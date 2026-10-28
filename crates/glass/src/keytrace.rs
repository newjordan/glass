//! `GLASS_KEY_TRACE=1`: where the time from a key being sent to its echo
//! being on screen goes. Each mark prints, on stderr, the wall clock in
//! nanoseconds, the thread and the step, in the shape the startup trace
//! uses, so a run's marks line up with the launcher's own clock and with
//! `GLASS_STARTUP_TRACE`'s. Unset, a mark is one relaxed load.
//!
//! The steps a key takes: the window thread receives it
//! (`key-window`), hands it to the app's input thread (`key-input`),
//! which reads the program's state, encodes the bytes and writes them to
//! the pty (`key-write`); the program echoes; the reader thread parses
//! the echo (`key-parse`) and wakes the app's thread, which draws it
//! (`key-draw`), and the window thread presents the frame that carries
//! it (`key-present`).

use std::io::Write;
use std::sync::OnceLock;
use std::time::SystemTime;

static ON: OnceLock<bool> = OnceLock::new();

fn on() -> bool {
    *ON.get_or_init(|| {
        std::env::var_os("GLASS_KEY_TRACE")
            .is_some_and(|v| !v.is_empty() && v != "0")
    })
}

/// Whether the marks are printed. `GLASS_KEY_TRACE=quiet` runs the same
/// code paths with the printing off, to tell what the tracing itself
/// costs from what the steps take.
fn printing() -> bool {
    on() && std::env::var_os("GLASS_KEY_TRACE").is_some_and(|v| v != "quiet")
}

/// Whether any step is tracing, for the paths that build strings only
/// when they are wanted.
pub fn tracing() -> bool {
    on()
}

/// Note that a key reached `what`.
pub fn mark(what: &str) {
    if !printing() {
        return;
    }
    let wall = SystemTime::now()
        .duration_since(SystemTime::UNIX_EPOCH)
        .map_or(0, |d| d.as_nanos());
    let thread = std::thread::current();
    let _ = writeln!(
        std::io::stderr().lock(),
        "glass-key {wall} [{}] {what}",
        thread.name().unwrap_or("-"),
    );
}

/// One step in a key's path that may be slow even when the marks around
/// it are quick: how long was spent waiting for a lock. The wait is
/// printed when it is dropped, whatever came of the step it timed.
pub struct Wait {
    started: Option<std::time::Instant>,
    what: &'static str,
}

impl Wait {
    /// Time a lock from here; a drop prints the wait.
    pub fn for_lock(what: &'static str) -> Self {
        Self { started: on().then(std::time::Instant::now), what }
    }
}

impl Drop for Wait {
    fn drop(&mut self) {
        if let Some(started) = self.started.filter(|_| printing()) {
            let micros = started.elapsed().as_micros();
            let wall = SystemTime::now()
                .duration_since(SystemTime::UNIX_EPOCH)
                .map_or(0, |d| d.as_nanos());
            let _ = writeln!(
                std::io::stderr().lock(),
                "glass-key {wall} [-] {}_lock_wait_us {micros}",
                self.what
            );
        }
    }
}
