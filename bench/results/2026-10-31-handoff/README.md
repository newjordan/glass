# The hand-off stall: found, measured, fixed (2026-10-31)

## The question the recheck left open

The Oct-31 recheck showed glass's Linux ascii at ~500 MB/s against
ghostty 1.4.0's ~1100 with the *same* terminal CPU (0.06 s) and inferred
"the lever is pipelining". That was a guess about where the wall time
went. This session measured it.

## Method

1. `bench/linux/stall-census.sh` — samples /proc/<pid>/task/*/stat and
   wchan at ~200 Hz while the six tput workloads run. The parse thread
   (pty-parse) sleeps 47% of its wall in `__futex_wait`; the engine lock
   was the suspect by name.
2. wchan cannot tell two futexes apart, and /proc/<tid>/syscall needs
   CAP_SYS_PTRACE this sandbox lacks. So `GLASS_LOCK_CENSUS=1`
   (crates/term/src/census.rs, in-process, env-gated, zero-cost off)
   counts every blocking take of the hot path's locks and the reader's
   hand-off wait, with each hand-off's shape: bytes, pty reads, and
   whether it broke on an empty pty.
3. `bench/linux/lock-census.sh` runs tput under the census.

## Findings

- engine mutex: 74,762 takes, **14 ms** total wait
- reader hand-off (mpsc): 74,762 waits, **1,220 ms** — 87x the engine lock
- writer, lock-handoff politeness: negligible
- 94% of hand-offs broke on FIONREAD saying the pty was empty, averaging
  1.1 reads and 4.9 KB each
- A standalone C probe (`/tmp/pty-pace.c`, same box) shows the raw pty
  delivers a flood in **11.9 KB average reads**: the tty layer copies in
  blocks microseconds apart, and FIONREAD between blocks reads empty.
  The reader took that literally, handed its part-full buffer on and
  parked; the parse thread paid a futex round trip per block.

**The engine lock was innocent.** The stall is the reader's hand-off
granularity mistaking the tty's block cadence for end-of-data.

## Fix (573de33)

A part-full hand-off now waits up to 400 µs on poll(2) for the next
block before going on. Hand-offs: 74,762 -> 24,334; average 4.9 KB ->
14,987 bytes (91% full); empty-breaks 94% -> 2.6%.

Interleaved A/B (glass vs glass-alt, 4 rounds, order rotating, this
machine): ascii median 504.1 -> 542.0 MB/s (+7.5%); the other five
workloads flat within noise. Key latency: median 2.04 ms over 40 keys,
unchanged from the published baseline. Suite: 364 passed, 0 failed.

## Raw

- stall-census/samples-glass.txt — the 200 Hz wchan census
- stall-census/tput-glass.json — its run's throughput
- stall-census/census-stderr.txt — in-process lock census, post-fix
- ab-topup/ — the interleaved A/B, both builds' every round
