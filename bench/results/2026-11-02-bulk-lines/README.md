# Bounded CRLF bulk scrolling — rejected after full gate

Runtime candidate rejected, not an accepted optimization or a championship.
Starting source: beca911. Shared Ryzen 9 9950X3D / RTX 3090 host, Linux/Hyprland.
Cargo uses the configured `RUSTC` (1.99.0), not the default rustc on PATH (1.99.1).
Release thin LTO, one codegen unit, existing affinity and unchanged workloads.

## Hypothesis

At the bottom of a scroll region, several complete ASCII CRLF records can
replace repeated scroll-by-one rotations with a single bounded bulk scroll.
Records never exceed the grid width, the batch is at most eight records and
strictly smaller than the region height. The original bottom row receives the
first write after rotation, retaining its unwritten suffix. Later records write
on blank recycled rows. No text, stores or scrolls are omitted. Refuse insert
mode, nonzero column, pending wrap, nondefault charset, hyperlink/extra cell
state, picture motion and in-cell picture coverage. Existing print_run performs
the actual cell writes. No data is deferred beyond the current input piece.

## Versions and measured engine diagnostics

Nine alternating control/candidate pairs per version, three internal rounds,
scale 1.0, 4095-byte reads. Ratios are candidate/control MB per CPU-second.
Frozen executables and raw stdout/stderr are hashed by engine-pairs.py.
Exploratory sign tests are uncorrected and not confirmatory after selection.

- v1: ASCII 1.1826, region 1.1878, both 9/9 wins; truecolor .8822 (0/9).
- v2: guard CRLF before helper call, keep helper out-of-line. ASCII 1.2327,
  region 1.2035, both 9/9; truecolor .8678, cursor .9687, TUI .9682.
- v3: also make feed out-of-line (`#[inline(never)]`). ASCII 1.0594 (5/9),
  region 1.6500 (7/9), truecolor .9661 (4/9), cursor .9575 (2/9),
  Unicode .9699 (4/9), TUI .9695 (2/9). Noisy round under unrelated host work.
  No claim that this isolates the causal effect of batching or inlining.

v1/v2/v3 source snapshots and patches are retained; engine.candidate.rs is the
v3 runtime plus direct-path tests. speed.candidate.rs records the test source
at build time. Later test-only coverage is recorded separately.

## Correctness evidence so far

The bulk_ascii_records_match_parser test passes seven terminal setup variants,
four grids and five chunk sizes with REP, CJK, partial/exact/overlong lines.
Both v1 and v3 ran the randomized differential test: 12,800 streams each, no
divergence. These sweeps are not themselves evidence of batch coverage.
The ordinary pump sets the no-picture state, authorizing the eligible path.
An additional direct test explicitly asserts full batch consumption and checks
cells, cursor and history against the parser on five setup variants, and refusal
on picture motion, insert mode and nonzero columns. It passes. The first direct
assertion wrongly compared internal Storage equality (requires normalized ring
indices); the next included an Engine counter not copied back by the direct
Watch harness. The corrected logical comparisons pass. Full-stream tests compare
counters through the real pump instead.

## Real-terminal gate

Frozen v3 / selected executable / Ghostty; 18 rounds, every six-order permutation
repeated three times; unchanged DA1-ended tput.py on the existing headless output
harness. No local builds, tests or competing local benchmarks overlap the gate.
Other users' host activity is not controlled. Initial invocation used unsupported
flags and exited during argument parsing, with no measured terminal sessions.
Corrected invocation and raw provenance are in terminal-gate-corrected.log and
terminal/terminal-summary.json. Wait for its complete flag and hash replay before
using it as evidence. Interim numbers are intentionally not published here.

Selection and final verification will be appended after the gate finishes.


## Completed real-terminal gate and decision

The corrected gate completed all 18 rounds / 54 terminal sessions at 154x39.
Six candidate/control/Ghostty orders were repeated three times. Binary, harness,
and raw-result hashes replayed successfully with `--summarize-only`.
Candidate/control paired throughput medians, wins/18 and exploratory two-sided
sign p-values (no multiplicity correction):

| Metric | Ratio | Wins | p |
|---|---:|---:|---:|
| ascii | 0.98546 | 9 | 1 |
| unicode | 1.00257 | 9 | 1 |
| truecolor | 1.10987 | 17 | 0.000144958 |
| cursor_motion | 1.02304 | 16 | 0.00131226 |
| scroll_region | 0.97766 | 7 | 0.480682 |
| tui_frames | 1.00384 | 10 | 0.629059 |

ASCII and region gains did **not** transfer; runtime batching removed. The
truecolor/cursor result cannot be attributed to batching: V3 also forced `feed`
out of line, and these workloads do not use consecutive eligible CRLF records.
A same-toolchain fresh-control ablation tests that annotation alone in
`../2026-11-02-feed-outline/`. No causal claim about instruction cache, register
allocation, compiler specialization, or transport behavior is proved here.

The direct-path test ultimately passed for primary, alternate, styled, no-wrap,
and restricted-region cases. It asserts that bytes are consumed and checks
logical cells/cursor/history, plus refusal for pictures, insert mode and a
nonzero column. Initial attempts to compare ring Storage directly panicked on
its required zero-offset invariant. Comparing engine scroll counters directly
also failed because the low-level Watch harness did not copy them back. The
pump-based differential tests cover those engine counters separately. These
were harness corrections, not an observed candidate data-loss defect.

An earlier commentary incorrectly said the stream tests never enabled batching;
tracing `session::pump` showed it always supplies the correct picture-motion
state, so the original stream tests were valid. The direct test removed the
remaining ambiguity by asserting positive consumption.

The two reusable CRLF tests are retained in `speed.rs`, extended to saturated
history, row suffixes, wide/combining predecessors, REP and synchronized output.
The initial 1,100-record variant passed before the outline terminal gate but
did not saturate the shipped 10,000-line history. It was corrected to include a
separate 10,100-record case, which passed on the restored runtime source; see
feed-outline/final-record-tests.log. The
candidate-only direct test was removed together with the rejected runtime helper;
its exact source is preserved in `engine.candidate.rs`.

The initial terminal invocation used unsupported --candidate/--baseline/--out
arguments and measured nothing. The corrected command and hash replay both
exited 0; see terminal-gate-corrected.log and terminal-replay.log. The selected
control for this bulk gate was the prior exact frozen executable, not a new
rebuild; the outline ablation instead uses a freshly rebuilt paired control.

No published leaderboard, all-metric victory, latency gain, or championship is
claimed. Shared-host unrelated work was not isolated. Benchmark workload timing
is ended by DA1; do not infer keyboard latency from these throughput figures.
