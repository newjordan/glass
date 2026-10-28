//! The pty read on a thread of its own, gathered for the parsing: how
//! glass reads where the pty hands over little at a time.
//!
//! macOS's pty hands over at most 1 KiB a read, whatever the line speed,
//! at about 2 µs of system time each: a third of the time a colour-heavy
//! flood takes when the parsing thread reads for itself. Here a thread
//! reads, and what it has read waits in one buffer until the parsing
//! takes all of it at once, by swapping buffers. Neither side waits on
//! the other while there is work: the reading thread wakes the parsing
//! only when the parsing has gone to sleep, and the parsing, finding
//! nothing, looks again for a moment before it sleeps, since in a flood
//! the next read is a few microseconds away and waking a sleeping thread
//! costs more than that.
//!
//! A read that empties the pty wakes the program to write more, and a
//! read made before the program has written it sleeps until it has: two
//! thread wakes for every KiB, which cost more than the reading itself.
//! So after a full read the reading thread waits [`REFILL`], long enough
//! for the program to have written the next KiB, and its next read finds
//! it there. Plain text through the window went from 252 to 372 MB/s on
//! an M4 Pro, with 1.2 to 1.8 µs all close to the best.
//!
//! The buffer holds at most [`AHEAD`] bytes before the reading stops, so
//! the program runs at most that far ahead of the screen.

use std::io::{self, Read};
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::{Arc, Condvar, Mutex, MutexGuard};
use std::time::{Duration, Instant};

/// How far reading may run ahead of parsing.
const AHEAD: usize = 64 * 1024;
/// How long the parsing looks for more before it sleeps.
const LOOK: Duration = Duration::from_micros(50);
/// The most macOS's pty hands over in one read: a read this big means
/// the program is writing faster than it is read.
const FULL: usize = 1024;
/// How long the program takes to write the next KiB once a read has made
/// room for it.
const REFILL: Duration = Duration::from_nanos(1500);

struct Shared {
    state: Mutex<State>,
    /// The parsing sleeps here until there are bytes, or the end.
    bytes: Condvar,
    /// The reading sleeps here until there is room.
    room: Condvar,
    /// Whether bytes wait, read without the lock while the parsing looks.
    ready: AtomicBool,
}

#[derive(Default)]
struct State {
    buf: Vec<u8>,
    /// The pty ended: no bytes will come after the ones in `buf`.
    ended: bool,
    /// The parsing side is gone; the reading stops at its next read.
    closed: bool,
    parsing_asleep: bool,
    reading_asleep: bool,
}

fn lock(shared: &Shared) -> MutexGuard<'_, State> {
    shared.state.lock().unwrap_or_else(|e| e.into_inner())
}

/// The parsing side: reads come out of here, in order, exactly as the
/// pty gave them, and the end of the pty is the end of these.
pub struct Gathered {
    shared: Arc<Shared>,
    /// The bytes taken last, and how far into them the reads have come.
    current: Vec<u8>,
    at: usize,
}

impl Gathered {
    /// Start reading `reader` on a thread of its own.
    pub fn spawn(mut reader: Box<dyn Read + Send>) -> io::Result<Self> {
        let shared = Arc::new(Shared {
            state: Mutex::new(State { buf: Vec::with_capacity(AHEAD * 2), ..State::default() }),
            bytes: Condvar::new(),
            room: Condvar::new(),
            ready: AtomicBool::new(false),
        });
        let reading = Arc::clone(&shared);
        std::thread::Builder::new().name("pty-read".into()).spawn(move || {
            let shared = reading;
            crate::affinity::place_hot_thread();
            let mut chunk = vec![0u8; 16 * 1024];
            loop {
                let n = match reader.read(&mut chunk) {
                    Ok(n) => n,
                    Err(e) if e.kind() == io::ErrorKind::Interrupted => continue,
                    Err(_) => 0,
                };
                let mut state = lock(&shared);
                while n > 0 && state.buf.len() >= AHEAD && !state.closed {
                    state.reading_asleep = true;
                    state = shared.room.wait(state).unwrap_or_else(|e| e.into_inner());
                    state.reading_asleep = false;
                }
                if state.closed {
                    return;
                }
                if n == 0 {
                    state.ended = true;
                } else {
                    state.buf.extend_from_slice(&chunk[..n]);
                    shared.ready.store(true, Ordering::Release);
                }
                if state.parsing_asleep {
                    shared.bytes.notify_one();
                }
                if n == 0 {
                    return;
                }
                drop(state);
                if n >= FULL {
                    let wait = Instant::now();
                    while wait.elapsed() < REFILL {
                        std::hint::spin_loop();
                    }
                }
            }
        })?;
        Ok(Self { shared, current: Vec::with_capacity(AHEAD * 2), at: 0 })
    }

    /// Take everything read so far into `current`, waiting for it if
    /// there is nothing. False at the end of the pty.
    fn take(&mut self) -> bool {
        let start = Instant::now();
        while !self.shared.ready.load(Ordering::Acquire) && start.elapsed() < LOOK {
            std::hint::spin_loop();
        }
        let mut state = lock(&self.shared);
        loop {
            if !state.buf.is_empty() {
                self.current.clear();
                std::mem::swap(&mut state.buf, &mut self.current);
                self.at = 0;
                self.shared.ready.store(false, Ordering::Release);
                if state.reading_asleep {
                    self.shared.room.notify_one();
                }
                return true;
            }
            if state.ended {
                return false;
            }
            state.parsing_asleep = true;
            state = self.shared.bytes.wait(state).unwrap_or_else(|e| e.into_inner());
            state.parsing_asleep = false;
        }
    }
}

impl Read for Gathered {
    fn read(&mut self, out: &mut [u8]) -> io::Result<usize> {
        if out.is_empty() {
            return Ok(0);
        }
        if self.at >= self.current.len() && !self.take() {
            return Ok(0);
        }
        let n = out.len().min(self.current.len() - self.at);
        out[..n].copy_from_slice(&self.current[self.at..self.at + n]);
        self.at += n;
        Ok(n)
    }
}

impl Drop for Gathered {
    fn drop(&mut self) {
        let mut state = lock(&self.shared);
        state.closed = true;
        if state.reading_asleep {
            self.shared.room.notify_one();
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::io::Write;
    use std::os::fd::FromRawFd;

    /// A pty pair in raw mode, as the program's side and glass's.
    fn pty() -> (std::fs::File, std::fs::File) {
        let (mut master, mut slave) = (0, 0);
        // SAFETY: openpty fills the two descriptors; the termios is a
        // plain struct cfmakeraw fills before it is applied.
        unsafe {
            assert_eq!(libc::openpty(&mut master, &mut slave, std::ptr::null_mut(), std::ptr::null_mut(), std::ptr::null_mut()), 0);
            let mut tio: libc::termios = std::mem::zeroed();
            libc::tcgetattr(slave, &mut tio);
            libc::cfmakeraw(&mut tio);
            libc::tcsetattr(slave, libc::TCSANOW, &tio);
            (std::fs::File::from_raw_fd(master), std::fs::File::from_raw_fd(slave))
        }
    }

    /// Every byte the program writes comes out once, in order, however it
    /// is written and however slowly it is taken, and the program's side
    /// closing ends the reads.
    #[test]
    fn gathering_gives_every_byte_in_order_then_the_end() {
        let (master, mut slave) = pty();
        let mut gathered = Gathered::spawn(Box::new(master)).unwrap();
        let data: Vec<u8> = (0..600_000u32).map(|i| (i.wrapping_mul(2_654_435_761) >> 13) as u8).collect();
        let sent = data.clone();
        let writer = std::thread::spawn(move || {
            let mut at = 0;
            let mut size = 1;
            while at < sent.len() {
                let end = (at + size).min(sent.len());
                slave.write_all(&sent[at..end]).unwrap();
                at = end;
                size = size * 7 % 9001 + 1;
                // Now and then the program pauses, so the parsing sleeps.
                if size % 13 == 0 {
                    std::thread::sleep(Duration::from_micros(200));
                }
            }
            // Keep the program's side open until everything is read.
            slave
        });
        let mut got = Vec::new();
        let mut buf = vec![0u8; 3000];
        while got.len() < data.len() {
            let n = gathered.read(&mut buf).unwrap();
            assert!(n > 0, "the reads ended early at {}", got.len());
            got.extend_from_slice(&buf[..n]);
            // Now and then the parsing is slow, so the reading runs ahead.
            if got.len() % 7 == 0 {
                std::thread::sleep(Duration::from_micros(300));
            }
        }
        assert!(got == data, "the bytes came out changed");
        drop(writer.join().unwrap());
        assert_eq!(gathered.read(&mut buf).unwrap(), 0, "a closed pty ends the reads");
    }

    /// The reading stops once it is [`AHEAD`] bytes ahead, so a program
    /// can't fill memory faster than the screen takes it.
    #[test]
    fn the_reading_runs_no_further_ahead_than_its_bound() {
        let (master, mut slave) = pty();
        let gathered = Gathered::spawn(Box::new(master)).unwrap();
        let writer = std::thread::spawn(move || {
            let block = vec![b'x'; 4096];
            // Write until the pty itself is full and blocks; the test ends
            // by dropping the reader side, which ends this with an error.
            for _ in 0..1024 {
                if slave.write_all(&block).is_err() {
                    break;
                }
            }
        });
        let start = Instant::now();
        let mut held = 0;
        while start.elapsed() < Duration::from_millis(500) {
            held = lock(&gathered.shared).buf.len();
            std::thread::sleep(Duration::from_millis(20));
        }
        assert!(held >= AHEAD / 2, "the reading stopped early, at {held} bytes");
        assert!(held < AHEAD + 16 * 1024, "the reading ran {held} bytes ahead");
        drop(gathered);
        drop(writer);
    }
}
