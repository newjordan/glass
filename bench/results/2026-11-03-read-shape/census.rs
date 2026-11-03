//! Env-gated wall-time census of the hot path's own blocking: which
//! futex the parse thread sleeps on, from inside the process, where the
//! kernel's /proc/<tid>/syscall needs privileges we do not have.
//!
//! `GLASS_LOCK_CENSUS=1` makes every blocking take of a named lock, and
//! the reader's wait for a hand-off, count into buckets of microseconds
//! (powers of two, 1..=1M) and a total, printed once at exit.

use std::sync::atomic::{AtomicBool, AtomicU64, Ordering};
use std::time::Instant;

pub static ON: AtomicBool = AtomicBool::new(false);

/// Turn the census on when `GLASS_LOCK_CENSUS` says so. Called once, at
/// startup, before the hot threads exist.
pub fn init() {
    let on = std::env::var_os("GLASS_LOCK_CENSUS")
        .is_some_and(|v| !v.is_empty() && v != "0");
    ON.store(on, Ordering::Relaxed);
}

const BUCKETS: usize = 21;

struct Counters {
    waits: AtomicU64,
    total_ns: AtomicU64,
    buckets: [AtomicU64; BUCKETS],
}

impl Counters {
    const fn new() -> Self {
        Self { waits: AtomicU64::new(0), total_ns: AtomicU64::new(0), buckets: [const { AtomicU64::new(0) }; BUCKETS] }
    }
    fn add(&self, ns: u64) {
        self.waits.fetch_add(1, Ordering::Relaxed);
        self.total_ns.fetch_add(ns, Ordering::Relaxed);
        let mut b = 0usize;
        let mut cut = 1_000u64; // 1 µs
        while ns > cut && b < BUCKETS - 1 {
            cut *= 2;
            b += 1;
        }
        self.buckets[b].fetch_add(1, Ordering::Relaxed);
    }
}

const NAMES: [&str; 4] = ["engine", "handoff", "let-waiters", "writer"];
static COUNTERS: [Counters; NAMES.len()] = [const { Counters::new() }; NAMES.len()];

#[inline]
pub fn on() -> bool {
    ON.load(Ordering::Relaxed)
}

/// Name a lock for the census: `census_lock!(NAME)` wraps a blocking
/// expression; the wait it took is counted under NAME when the census is
/// on. Compiled to the bare expression otherwise.
#[macro_export]
macro_rules! census_lock {
    ($name:ident, $take:expr) => {{
        let began = $crate::census::on().then(std::time::Instant::now);
        let guard = $take;
        if let Some(began) = began {
            $crate::census::record(stringify!($name), began);
        }
        guard
    }};
}

use std::sync::atomic::AtomicUsize;

pub static HANDOFFS: AtomicUsize = AtomicUsize::new(0);
pub static HANDOFF_BYTES: AtomicU64 = AtomicU64::new(0);
pub static HANDOFF_READS: AtomicU64 = AtomicU64::new(0);
pub static HANDOFF_EMPTY_BREAKS: AtomicUsize = AtomicUsize::new(0);
pub static HANDOFF_FULL: AtomicUsize = AtomicUsize::new(0);

/// One hand-off's shape: how full it was, how many reads filled it, and
/// whether it broke on an empty pty rather than a full buffer.
pub fn handoff_shape(filled: usize, sysreads: u32, ended: bool) {
    use std::sync::atomic::Ordering::Relaxed;
    HANDOFFS.fetch_add(1, Relaxed);
    HANDOFF_BYTES.fetch_add(filled as u64, Relaxed);
    HANDOFF_READS.fetch_add(sysreads as u64, Relaxed);
    if filled >= CHUNK_FULL {
        HANDOFF_FULL.fetch_add(1, Relaxed);
    } else if !ended {
        HANDOFF_EMPTY_BREAKS.fetch_add(1, Relaxed);
    }
}

/// A hand-off counts as full at this many bytes.
pub const CHUNK_FULL: usize = 16 * 1024 - 4096;

/// Record one wait, from `began` to now, under `name`.
pub fn record(name: &str, began: Instant) {
    let idx = NAMES.iter().position(|n| *n == name).unwrap_or(0);
    COUNTERS[idx].add(began.elapsed().as_nanos() as u64);
}

/// Print the census to stderr. Called once at exit.
pub fn dump() {
    if !on() {
        return;
    }
    let mut out = String::from("glass-census");
    for (i, name) in NAMES.iter().enumerate() {
        let c = &COUNTERS[i];
        let waits = c.waits.load(Ordering::Relaxed);
        if waits == 0 {
            continue;
        }
        let ms = c.total_ns.load(Ordering::Relaxed) as f64 / 1e6;
        out.push_str(&format!(
            " {name}={waits}waits/{ms:.0}ms buckets_us=[{}]",
            (0..BUCKETS)
                .map(|b| c.buckets[b].load(Ordering::Relaxed).to_string())
                .collect::<Vec<_>>()
                .join(",")
        ));
    }
    use std::sync::atomic::Ordering::Relaxed;
    let h = HANDOFFS.load(Relaxed);
    if h > 0 {
        let bytes = HANDOFF_BYTES.load(Relaxed);
        let reads = HANDOFF_READS.load(Relaxed);
        out.push_str(&format!(
            " handoffs={h} avg_bytes={} avg_reads={:.1} full={} empty_breaks={}",
            bytes / h as u64,
            reads as f64 / h as f64,
            HANDOFF_FULL.load(Relaxed),
            HANDOFF_EMPTY_BREAKS.load(Relaxed)
        ));
    }
    eprintln!("{out}");
}
