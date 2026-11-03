//! The pty read on a thread of its own, ahead of the parsing.
//!
//! PTY reads can be short, but 4 KiB is not a Linux read-size ceiling: a
//! read into a full hand-off can return all 16 KiB. Reading on another
//! thread overlaps transport with parsing. The reading thread keeps
//! reading into one hand-off while more
//! is already waiting and there is room, so a flood moves in large pieces
//! and a single keystroke's echo is handed on at once.
//!
//! Only two producer hand-offs exist. Once a hand-off has been copied into
//! the parser's buffer it is recycled immediately, letting the producer fill
//! both while parsing proceeds. Thus at most two hand-offs plus the copied
//! one being parsed can be outstanding beyond the pty itself.

use std::io::{self, Read};
use std::time::Duration;
use std::os::fd::{AsRawFd, OwnedFd};
use std::sync::mpsc::{self, Receiver, Sender};
#[cfg(test)]
use std::sync::mpsc::TryRecvError;

/// The most one hand-off holds.
const CHUNK: usize = 16 * 1024;
/// Hand-offs in flight: how far reading may run ahead of parsing.
const AHEAD: usize = 2;
/// Minimum spare capacity for another opportunistic read. This is a
/// coalescing policy, not a bound on the result: the full remaining slice
/// is passed to `read`, which can return more than this on Linux.
const PTY_READ: usize = 4096;

/// Historical top-up budget: poll's whole milliseconds truncate this to
/// zero, so the current setting is a readiness recheck, not a 400 us wait.
/// A true 400 us ppoll wait regressed ASCII and added ~0.45 ms quiet DA1
/// RTT; see bench/results/2026-11-02-ppoll. Preserve the measured behavior.
const TOP_UP: Duration = Duration::from_micros(400);

/// What waiting on the pty said: more bytes are ready, it stayed quiet
/// to the deadline, or its end came.
enum Poll {
    Ready,
    Quiet,
    End,
}

/// Check for more pty bytes, waiting only for whole milliseconds in `limit`.
fn wait_for_more(fd: Option<&OwnedFd>, limit: Duration) -> Poll {
    let Some(fd) = fd else { return Poll::Quiet };
    let mut pfd = libc::pollfd { fd: fd.as_raw_fd(), events: libc::POLLIN, revents: 0 };
    let millis = limit.as_millis().min(i32::MAX as u128) as libc::c_int;
    // SAFETY: pfd is one pollfd the call may write; the timeout bounds it.
    let r = unsafe { libc::poll(&mut pfd as *mut libc::pollfd, 1, millis) };
    if r < 0 {
        if std::io::Error::last_os_error().kind() == io::ErrorKind::Interrupted {
            return Poll::Ready;
        }
        return Poll::End;
    }
    if r == 0 {
        return Poll::Quiet;
    }
    // A peer can close with unread bytes still queued. POLLIN and HUP
    // then arrive together: drain readable bytes before honoring the end.
    if pfd.revents & libc::POLLIN != 0 {
        return Poll::Ready;
    }
    if pfd.revents & (libc::POLLHUP | libc::POLLERR) != 0 {
        return Poll::End;
    }
    Poll::Ready
}

/// The parsing side: reads come out of here, in order, exactly as the
/// pty gave them, and the end of the pty is the end of these.
pub struct ReadAhead {
    /// Hand-offs, each with how much of it was read.
    full: Receiver<(Vec<u8>, usize)>,
    empty: Sender<Vec<u8>>,
    current: Vec<u8>,
    end: usize,
    at: usize,
}

impl ReadAhead {
    /// Start reading `reader` on a thread of its own. `fd` (the pty's own
    /// descriptor, duplicated) says whether more is waiting; without it
    /// every read is handed on by itself.
    pub fn spawn(mut reader: Box<dyn Read + Send>, fd: Option<OwnedFd>) -> io::Result<Self> {
        let (full_tx, full) = mpsc::channel::<(Vec<u8>, usize)>();
        let (empty, empty_rx) = mpsc::channel::<Vec<u8>>();
        // Each hand-off is filled once and keeps its length, so a reused
        // one is read into as it is, not cleared again.
        for _ in 0..AHEAD {
            let _ = empty.send(vec![0; CHUNK]);
        }
        std::thread::Builder::new().name("pty-read".into()).spawn(move || {
            crate::affinity::place_hot_thread();
            while let Ok(mut buf) = empty_rx.recv() {
                let mut filled = 0;
                let mut ended = false;
                let mut sysreads = 0u32;
                let census = crate::census::on();
                loop {
                    match reader.read(&mut buf[filled..]) {
                        Ok(0) => ended = true,
                        Ok(n) => filled += n,
                        Err(e) if e.kind() == io::ErrorKind::Interrupted => continue,
                        Err(_) => ended = true,
                    }
                    sysreads += 1;
                    if ended || CHUNK - filled < PTY_READ {
                        break;
                    }
                    if !waiting(fd.as_ref()) {
                        // The pty is empty this instant. The tty layer
                        // copies a flood in blocks a few microseconds
                        // apart. Recheck readiness before handing off;
                        // TOP_UP currently truncates to poll(0), not a
                        // sub-millisecond wait. A real wait was measured
                        // and rejected (see TOP_UP). Do not restore it
                        // based on the historical comments alone.
                        if filled > 0 {
                            match wait_for_more(fd.as_ref(), TOP_UP) {
                                Poll::Ready => continue,
                                Poll::Quiet => break,
                                Poll::End => {
                                    ended = true;
                                    break;
                                }
                            }
                        }
                        // Nothing read and nothing waiting: block in the
                        // read itself, the way a quiet pty always waits.
                        continue;
                    }
                }
                if census {
                    crate::census::handoff_shape(filled, sysreads, ended);
                }
                if filled > 0 && full_tx.send((buf, filled)).is_err() {
                    return;
                }
                if ended {
                    return;
                }
            }
        })?;
        Ok(Self { full, empty, current: Vec::new(), end: 0, at: 0 })
    }
}

/// Whether the pty holds bytes not read yet.
fn waiting(fd: Option<&OwnedFd>) -> bool {
    let Some(fd) = fd else {
        return false;
    };
    let mut n: libc::c_int = 0;
    // SAFETY: FIONREAD writes one int through the pointer, which points
    // at `n`; the descriptor is owned and open.
    let r = unsafe { libc::ioctl(fd.as_raw_fd(), libc::FIONREAD, &mut n as *mut libc::c_int) };
    r == 0 && n > 0
}

impl Read for ReadAhead {
    fn read(&mut self, out: &mut [u8]) -> io::Result<usize> {
        if out.is_empty() {
            return Ok(0);
        }
        while self.at >= self.end {
            let spent = std::mem::take(&mut self.current);
            if !spent.is_empty() {
                let _ = self.empty.send(spent);
            }
            let began = crate::census::on().then(std::time::Instant::now);
            match self.full.recv() {
                Ok((buf, end)) => {
                    if let Some(began) = began {
                        crate::census::record("handoff", began);
                    }
                    self.end = end.min(buf.len());
                    self.current = buf;
                    self.at = 0;
                }
                Err(_) => return Ok(0),
            }
        }
        let n = out.len().min(self.end - self.at);
        out[..n].copy_from_slice(&self.current[self.at..self.at + n]);
        self.at += n;
        if self.at == self.end {
            // The caller owns an independent copy. Return producer credit now,
            // not after the caller has parsed it and asks for the next read.
            let spent = std::mem::take(&mut self.current);
            self.at = 0;
            self.end = 0;
            let _ = self.empty.send(spent);
        }
        Ok(n)
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

    #[test]
    fn copied_handoff_returns_credit_after_its_last_byte_only() {
        let (full_tx, full) = mpsc::channel();
        let (empty, empty_rx) = mpsc::channel();
        let mut ahead = ReadAhead { full, empty, current: vec![1, 2, 3, 4], at: 0, end: 4 };
        let mut out = [0; 2];
        assert_eq!(ahead.read(&mut []).unwrap(), 0);
        assert!(matches!(empty_rx.try_recv(), Err(TryRecvError::Empty)));
        assert_eq!(ahead.read(&mut out).unwrap(), 2);
        assert_eq!(out, [1, 2]);
        assert!(matches!(empty_rx.try_recv(), Err(TryRecvError::Empty)));
        assert_eq!(ahead.read(&mut out).unwrap(), 2);
        assert_eq!(out, [3, 4]);
        assert_eq!(empty_rx.try_recv().unwrap(), [1, 2, 3, 4]);
        assert!(ahead.current.is_empty());
        assert_eq!((ahead.at, ahead.end), (0, 0));
        // EOF cannot return that buffer a second time. No reader thread or
        // sleep is needed to check producer credit independently of parsing.
        drop(full_tx);
        assert_eq!(ahead.read(&mut out).unwrap(), 0);
        assert!(matches!(empty_rx.try_recv(), Err(TryRecvError::Empty)));
    }

    #[cfg(target_os = "linux")]
    #[test]
    fn queued_handoffs_preserve_all_bytes_and_return_each_credit_once() {
        for capacity in [1, 2, 3, 5, 7, 8, 64] {
            let (full_tx, full) = mpsc::channel();
            let (empty, empty_rx) = mpsc::channel();
            for (bytes, end) in [(b"abcd".as_slice(), 3), (b"EF".as_slice(), 99), (b"ghijk".as_slice(), 5)] {
                full_tx.send((bytes.to_vec(), end)).unwrap();
            }
            drop(full_tx);
            let mut ahead = ReadAhead { full, empty, current: Vec::new(), at: 0, end: 0 };
            let mut out = vec![0; capacity];
            let mut got = Vec::new();
            loop {
                // Empty reads neither consume queued bytes nor return credit.
                assert_eq!(ahead.read(&mut []).unwrap(), 0);
                let n = ahead.read(&mut out).unwrap();
                if n == 0 { break; }
                got.extend_from_slice(&out[..n]);
            }
            assert_eq!(got, b"abcEFghijk", "capacity {capacity}");
            for expected in [b"abcd".as_slice(), b"EF".as_slice(), b"ghijk".as_slice()] {
                assert_eq!(empty_rx.try_recv().unwrap(), expected);
            }
            assert!(matches!(empty_rx.try_recv(), Err(TryRecvError::Empty)));
            assert_eq!(ahead.read(&mut out).unwrap(), 0);
            assert!(matches!(empty_rx.try_recv(), Err(TryRecvError::Empty)));
        }
    }

    #[cfg(target_os = "linux")]
    #[test]
    fn readable_bytes_are_drained_before_a_hangup_ends_the_reader() {
        let (mut master, mut slave) = pty();
        let fd: OwnedFd = master.try_clone().unwrap().into();
        slave.write_all(b"the final burst").unwrap();
        drop(slave);
        // Linux reports POLLIN | POLLHUP together: HUP does not mean
        // the already-buffered bytes are gone. This is the state a writer
        // can create between waiting(FIONREAD) and wait_for_more(poll).
        assert!(matches!(wait_for_more(Some(&fd), Duration::ZERO), Poll::Ready));
        let mut bytes = [0; 15];
        master.read_exact(&mut bytes).unwrap();
        assert_eq!(&bytes, b"the final burst");
        assert!(matches!(wait_for_more(Some(&fd), Duration::ZERO), Poll::End));
    }

    /// No PTY descriptor means the boxed reader is authoritative. Interrupts
    /// must be retried, later errors must not lose already delivered bytes,
    /// and every producer handoff must tolerate consumer reads of any size.
    #[test]
    fn descriptorless_reader_retries_interrupts_and_drains_before_error() {
        use std::collections::VecDeque;
        use std::sync::{
            Arc,
            atomic::{AtomicUsize, Ordering},
        };

        struct Script {
            steps: VecDeque<io::Result<Vec<u8>>>,
            calls: Arc<AtomicUsize>,
        }
        impl Read for Script {
            fn read(&mut self, out: &mut [u8]) -> io::Result<usize> {
                self.calls.fetch_add(1, Ordering::SeqCst);
                let bytes = self.steps.pop_front().expect("read after terminal error")?;
                assert!(out.len() >= bytes.len());
                out[..bytes.len()].copy_from_slice(&bytes);
                Ok(bytes.len())
            }
        }
        for capacity in [1, 2, 4, 8, 64] {
            let calls = Arc::new(AtomicUsize::new(0));
            let steps = VecDeque::from([
                Err(io::ErrorKind::Interrupted.into()),
                Ok(b"abc".to_vec()),
                Err(io::ErrorKind::Interrupted.into()),
                Ok(b"DEFGHI".to_vec()),
                Err(io::ErrorKind::Other.into()),
            ]);
            let mut ahead = ReadAhead::spawn(
                Box::new(Script {
                    steps,
                    calls: calls.clone(),
                }),
                None,
            )
            .unwrap();
            let mut got = Vec::new();
            let mut out = vec![0; capacity];
            loop {
                assert_eq!(ahead.read(&mut []).unwrap(), 0);
                let n = ahead.read(&mut out).unwrap();
                if n == 0 {
                    break;
                }
                got.extend_from_slice(&out[..n]);
            }
            assert_eq!(got, b"abcDEFGHI", "capacity {capacity}");
            assert_eq!(calls.load(Ordering::SeqCst), 5);
            assert_eq!(ahead.read(&mut out).unwrap(), 0);
            assert_eq!(ahead.read(&mut []).unwrap(), 0);
        }
    }

    #[test]
    fn descriptorless_reader_drains_multiple_credits_before_eof() {
        let data: Vec<u8> = (0..CHUNK * (AHEAD + 3) + 73)
            .map(|i| (i.wrapping_mul(131) >> 3) as u8)
            .collect();
        for capacity in [7, CHUNK - 1, CHUNK, CHUNK + 1] {
            let mut ahead =
                ReadAhead::spawn(Box::new(io::Cursor::new(data.clone())), None).unwrap();
            let mut out = vec![0; capacity];
            let mut got = Vec::new();
            loop {
                let n = ahead.read(&mut out).unwrap();
                if n == 0 {
                    break;
                }
                got.extend_from_slice(&out[..n]);
            }
            assert_eq!(got, data, "capacity {capacity}");
            assert_eq!(ahead.read(&mut out).unwrap(), 0);
        }
    }

    #[cfg(target_os = "linux")]
    #[test]
    fn reading_ahead_drains_final_partial_handoff_on_hangup() {
        for capacity in [1, 7, 64] {
            let (master, mut slave) = pty();
            let fd: OwnedFd = master.try_clone().unwrap().into();
            slave.write_all(b"last partial handoff").unwrap();
            drop(slave);
            // Both flags are present before the reading thread even starts.
            assert!(matches!(
                wait_for_more(Some(&fd), Duration::ZERO),
                Poll::Ready
            ));
            let mut ahead = ReadAhead::spawn(Box::new(master), Some(fd)).unwrap();
            let mut out = vec![0; capacity];
            let mut got = Vec::new();
            loop {
                let n = ahead.read(&mut out).unwrap();
                if n == 0 {
                    break;
                }
                got.extend_from_slice(&out[..n]);
            }
            assert_eq!(got, b"last partial handoff", "capacity {capacity}");
            assert_eq!(ahead.read(&mut out).unwrap(), 0);
        }
    }

    /// Every byte the program writes comes out once, in order, however it
    /// is written, and the program's side closing ends the reads.
    #[test]
    fn reading_ahead_gives_every_byte_in_order_then_the_end() {
        let (master, mut slave) = pty();
        let fd = master.try_clone().ok().map(OwnedFd::from);
        let mut ahead = ReadAhead::spawn(Box::new(master), fd).unwrap();
        let data: Vec<u8> = (0..300_000u32).map(|i| (i.wrapping_mul(2_654_435_761) >> 13) as u8).collect();
        let sent = data.clone();
        let writer = std::thread::spawn(move || {
            let mut at = 0;
            let mut size = 1;
            while at < sent.len() {
                let end = (at + size).min(sent.len());
                slave.write_all(&sent[at..end]).unwrap();
                at = end;
                size = size * 7 % 9001 + 1;
            }
            // Keep the program's side open until everything is read.
            slave
        });
        let mut got = Vec::new();
        let mut buf = vec![0u8; 64 * 1024];
        while got.len() < data.len() {
            let n = ahead.read(&mut buf).unwrap();
            assert!(n > 0, "the reads ended early at {}", got.len());
            got.extend_from_slice(&buf[..n]);
        }
        assert!(got == data, "the bytes came out changed");
        drop(writer.join().unwrap());
        assert_eq!(ahead.read(&mut buf).unwrap(), 0, "a closed pty ends the reads");
    }
}
