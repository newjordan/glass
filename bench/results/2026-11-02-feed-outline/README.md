# Isolate `feed` inlining — rejected trade-off

This is the follow-up ablation to `../2026-11-02-bulk-lines/`, not a claimed
championship. Runtime source changes by exactly one annotation:
`#[inline(never)]` on `engine::feed`. No parser state, widths, chunk counts,
transport affinity, scrollback, or workload changes. New tests do not affect
the shipped executable.

## Why this experiment

The rejected bulk-CRLF candidate gained engine ASCII/region CPU throughput,
but not real-terminal ASCII/region. Its V3 full-terminal truecolor gain was
11.0% (17/18 wins) and cursor gain 2.3% (16/18), on workloads that cannot
benefit from consecutive ASCII/CRLF batching. V3 also made `feed` out of line.
This ablation removes the batching entirely and tests that annotation alone.
Do not attribute the observed result to bulk scrolling.

## Provenance and measurement

Starting selected source: beca911. Configured RUSTC is 1.99.0; default PATH
rustc is 1.99.1 and is not the compiler Cargo uses. Ordinary release thin LTO,
one codegen unit, existing affinity. Shared Ryzen 9 9950X3D / RTX 3090 host,
Linux/Hyprland. Unrelated host workloads are neither stopped nor isolated.
Both executables freshly rebuilt with the same configured toolchain, lockfile,
and flags. Fresh control hash exactly matches `/tmp/glass-i7-control` from the
prior iteration. Build JSONL and logs retain the artifact/compiler receipts.

Frozen binary paths: `/tmp/glass-i8-outline-control`, `/tmp/glass-i8-outline`.
The harness records their SHA256s, its own script SHA256s and every raw JSON.
18 rounds / 54 sessions: the six candidate/control/Ghostty orders repeated
three times. Unchanged historical tput.py workloads, 154x39, DA1-ended timing.
No local build/other benchmark overlaps this terminal gate. Correctness builds
finished before the gate, and subsequent checks run only after it finishes.
Terminal measurement and summarize-only replay are invoked by the same
`set -euo pipefail` job; partial reports are never accepted as complete.

`codegen-symbols.log` records a standalone feed symbol in the candidate but not
the control. This supports a code-generation difference, not a particular
microarchitectural explanation or causal performance claim.

## Correctness before gate

`cargo test --release -p glass-term --locked records_ -- --nocapture`:
3 passed / 0 failed (two new speed tests and one existing intake test selected
by the substring filter). The new tests compare cells, cursor, history/counts,
replies, and alternate-screen state against the existing byte-at-a-time parser
through the real Splitter/pump path. Cases include chunk boundaries, CRLF,
wide/combining predecessors, REP, insert and charset fallbacks, sync sequences,
mode changes, saturated history and unwritten suffixes. See record-tests.log.

## Decision

Full gate and hash replay completed (18 rounds / 54 sessions, all six orders).
No universal ranking or all-metric win is claimed. Runtime annotation removed:
truecolor's gain did not justify the ASCII downside or establish wins on the
remaining weak metrics. The region result is **inconclusive**, not a demonstrated
regression; the ASCII direction is concerning but its uncorrected sign test is
also not conventionally significant. Rejection is a conservative promotion
choice, not proof of a universal regression.


## Completed paired results

Candidate/fresh-control throughput, median of 18 within-round ratios:

| Metric | Ratio | Wins/18 | Two-sided sign p |
|---|---:|---:|---:|
| ascii | 0.91049 | 5 | 0.143463 |
| unicode | 1.00745 | 12 | 0.237885 |
| truecolor | 1.08351 | 17 | 0.000144958 |
| cursor_motion | 1.01457 | 15 | 0.00753784 |
| scroll_region | 0.98010 | 8 | 0.814529 |
| tui_frames | 0.99435 | 6 | 0.237885 |

The truecolor gain reproduces the direction seen in the bulk candidate, after
removing **all** CRLF batching. Thus that gain does not require batching. A
particular instruction-cache/register-allocation/specialization cause is not
proved. Sign tests are exploratory, uncorrected for multiple comparisons and
shared-host order/load effects. The performance gate is a promotion test on this
host, not an official ranking or general theorem.

Fresh selected-control/Ghostty within-round ratios from this same run:

| Metric | Ratio | Wins/18 |
|---|---:|---:|
| ascii | 0.97904 | 8 |
| unicode | 1.00751 | 9 |
| truecolor | 1.17774 | 16 |
| cursor_motion | 1.12409 | 15 |
| scroll_region | 1.04458 | 10 |
| tui_frames | 1.07655 | 15 |

ASCII, Unicode, and region do not show dependable victories. Unicode's nominal
parity is not a win; region's 10/18 is not convincing. This is a fresh-control
arm, not the restored selected executable's exact bytes (same source, different
historical release-build artifact). Do not silently merge these binaries or
cross-run medians into one scoreboard.

## Final restoration and verification

`engine.rs` restored byte-for-byte to pre-experiment source. Both rejected
runtime candidates remain only as explicit research snapshots and patches.
Two new test-only cases remain in `speed.rs` (65 added source lines). The final
case includes a separate 10,100-record stream at 3x40, so it really recycles the
shipped 10,000-line history. An earlier 1,100-record test/comment incorrectly
claimed saturation; that was corrected before final verification. The original
passed record-tests.log predates this correction; final-record-tests.log is the
receipt for the actual saturation test and restored runtime source.

Final `cargo test --release -p glass-term --locked records_ -- --nocapture`:
3 passed, 0 failed, including the two new tests and one pre-existing intake test.
Final `git diff --check` on edited source passed. Only this relevant correctness
gate was run after restoration; no broad workspace/clippy/doc or final randomized
sweep is claimed for this iteration. The bulk V1/V3 experiments each separately
passed 12,800 differential streams (see their retained logs).

Exact selected release executable restored to target/release/glass and compared
byte-for-byte to /tmp/glass-i8-selected, SHA256:
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
Both runtime candidates were rejected, so no new latency claim or RTT benchmark
was needed for promotion. No benchmark command remains running.

## Next necessary evidence

A selective long-run/escape-heavy dispatcher must preserve the original ASCII
codegen while selecting the outlined path for escape-heavy input. It is an
unverified hypothesis, **not** code to install from these results. Gate it
against a fresh control, include alternating mode/chunk streams in correctness,
and require full-pipeline ASCII/region non-regression. Alternatively, profile
CPU and wall time by stage under matched inputs before choosing another reader
or scanner change; isolated engine wins have repeatedly failed to transfer.
