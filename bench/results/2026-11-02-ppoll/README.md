# The 400 us top-up was actually poll(0)

## New, directly verified finding

`crates/term/src/read_ahead.rs` declares `TOP_UP = Duration::from_micros(400)`.
The shipped `wait_for_more` converts it using `limit.as_millis()` before
passing the integer to `poll`. That conversion yields **0**, not 400 us.
Therefore the historical description of a 400 us wait in
`../2026-10-31-handoff/README.md` is false for the source measured in this
iteration. It is an additional readiness probe, and can still alter hand-off
shapes, but its results cannot be attributed to a 400 us deadline.

This is source evidence, not a hypothesis about the cause of throughput
bimodality. The external Python producer is not explicitly placed by Glass's
per-thread `place_hot_thread` calls; whether its CPU placement explains the
bimodality remains unmeasured. Do not claim that it does.

## Candidate and method

`candidate.patch` replaces integer-millisecond `poll` with `ppoll` and an
initialized `timespec`, preserving the exact 400 us duration. Signal mask is
unchanged. EINTR, HUP/error and EOF branches are otherwise unchanged. This
candidate is separate from larger hand-offs, borrowed-buffer parsing, and the
already-rejected gather path. No buffer or ahead-limit change is involved.

The pre-existing test
`read_ahead::tests::reading_ahead_gives_every_byte_in_order_then_the_end`
passed (`reader-test.log`). That checks byte order/EOF, not real-time delay.

`hashes.txt` identifies candidate `/tmp/glass-ppoll-bin` and control
`/tmp/glass-cache-selected`. Both include the selected single-mark cache.
Fifteen full terminal rounds compare candidate, control and Ghostty at
154 x 39. The three launch-order rotations match the other iteration gates;
this balances ordinal slot but does not cover all six permutations.
No other Glass benchmark runs concurrently.

`bench/pty-rtt.py` is a separate quiet-latency guard: DA1 queries through the
real PTY, after 3 ms quiet, 20 warmups then 300 samples per run, three runs per
arm, storing all samples. It validates the exact reply and fails on missing,
oversized or changed replies. This is **not key-to-screen latency**. A true
400 us wait is expected to be visible here, so a throughput-only claim would
be incomplete. The guard runs only after throughput completes.

## Outcome

**Rejected and removed.** Full paired throughput results:

| workload | ppoll / control | wins/losses/ties | sign p | ppoll / Ghostty |
|---|---:|---:|---:|---:|
| ascii | **0.9494** | 3/12/0 | .03516 | 0.8600 |
| unicode | 1.0129 | 14/1/0 | .000977 | 0.9551 |
| truecolor | **0.9910** | 2/13/0 | .00739 | 1.1357 |
| cursor_motion | 1.0075 | 8/7/0 | 1 | 1.1094 |
| scroll_region | 1.1548 | 9/5/1 | .42395 | 0.9653 |
| tui_frames | 0.9956 | 7/8/0 | 1 | 1.0317 |

The tempting +15.5% scroll median is **not** a consistent paired win. It is
not evidence of a solved region gap. ASCII and truecolor regress.

Quiet RTT (`rtt-summary.json`, three runs and 900 samples per arm):

| arm | median ms | p90 ms | p99 ms | run medians ms |
|---|---:|---:|---:|---|
| control | .031384 | .045706 | .064011 | .028564, .033398, .032261 |
| ppoll | .482723 | .501603 | .519076 | .480303, .485413, .482417 |

The median rises **.451339 ms**. This is the expected cost of a real top-up
wait on a quiet program, not a key-to-screen measurement or a claim that
400 us is a strict wall-clock bound. Samples are correlated within sessions;
do not treat 900 samples as 900 independent paired terminal experiments.

`terminal-summary.json`, `terminal/`, `terminal.log`, `rtt-summary.json` and
`rtt/` retain the measurements. The source result above stands independently
of the candidate's performance. The historical documentation was inaccurate,
but blindly making it true is worse. Runtime behavior remains the measured
poll(0) readiness recheck; only its misleading comments are corrected.
No cross-platform build claim is made for this Linux-only experiment.
