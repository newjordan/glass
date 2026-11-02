# Earlier producer credit: measured scroll-region gain

Starting source: `f920961c8b459385f73eb171c9c2c8a71b5d6347`.
Linux / Ryzen 9 9950X3D / RTX 3090 / Hyprland, all rounds 154 x 39;
configured rustc 1.99.0, normal workspace release flags, no PGO.

## New source finding

The production parser reads into its own 64 KiB buffer. `ReadAhead::read`
copies one at-most-16-KiB hand-off into it but historically returned the
exhausted source Vec to the producer only on the **next** read. During parsing
of the independent copy, one of just two producer buffers is unavailable even
though no parser reference to it exists.

`candidate.patch` returns the fully copied buffer immediately, resetting
`current`, `at` and `end`; partial reads retain it. Empty reads return before
mutation. A closed producer drops the returned Vec. No new unsafe code,
allocation, sleep, poll timeout, chunk size, parser pacing or affinity change.

This is not the rejected borrowed-reader experiment: borrowing retains the
source through parsing. This change keeps the copy, releases producer credit
earlier, and lets the producer refill while that copy is parsed.

**Bound changes:** two producer buffers still exist, but up to two future
hand-offs may coexist with one copied hand-off being parsed. Outstanding
read-ahead beyond the PTY can thus grow by at most **16 KiB** (nominal 32 to
48 KiB including the parser copy). Existing allocated parser storage is
unchanged. This is not a backpressure-neutral change.

## Correctness

- Existing raw-PTY byte-order/EOF test: passed.
- Deterministic added regression: empty and partial reads return no credit;
  final copied byte returns it before another read; EOF never returns it twice.
- `reader-tests.log`: 2 passed, 0 failed.

The release binary was captured before the test-only regression was added;
production runtime statements are identical. Its SHA-256 is
`cb5436229256fbaebd6c910c45c6a91ead5b5e63346de9708d92048e529711be`.

## Balanced real-terminal comparison

18 rounds, all six permutations of candidate/control/Ghostty three times.
`gate/terminal-summary.json` retains binaries, launch order, geometry, paired
ratios, exact two-sided sign tests and hashes of every raw JSON. Candidate is
`/tmp/glass-early-recycle-bin`, control is `/tmp/glass-cache-selected`.

| workload | candidate/control | wins | candidate/Ghostty | wins |
|---|---:|---:|---:|---:|
| ASCII | .9873 | 8/18 | .8432 | 4/18 |
| Unicode | .9989 | 9/18 | .9491 | 6/18 |
| truecolor | 1.0076 | 13/18 | 1.1985 | 18/18 |
| cursor motion | 1.0006 | 9/18 | 1.1085 | 18/18 |
| scroll region | **1.1247** | **16/18** | .9858 | 7/18 |
| TUI frames | 1.0124 | 10/18 | 1.0581 | 18/18 |

Scroll region: **+12.47%, 16/18 pairs, p=.001312** versus control. This
survives a simple six-workload Bonferroni threshold .00833. The small
truecolor delta (p=.0490) does not; do not claim it as an independent gain.
ASCII/Unicode/cursor/TUI control deltas do not establish an improvement or
regression. The three established Ghostty leads survive, each 18/18.
Scroll region **does not beat Ghostty** (7/18, p=.4807), nor does this solve
ASCII or Unicode. No world-champion conclusion is licensed.

## Quiet real-PTY latency guard

`bash bench/run-pty-rtt.sh`, six AB/BA paired runs, 300 measured DA1 samples
per run after 20 warmups, 3 ms quiet interval before each query. No concurrent
throughput benchmark. `rtt/summary.json` and raw JSON retain all samples,
paired run-median deltas and hashes.

| arm | median of run medians ms | pooled median ms | p90 ms | p99 ms |
|---|---:|---:|---:|---:|
| early recycle | .036000 | .035552 | .049313 | .063078 |
| control | .031600 | .032612 | .044463 | .061746 |

Five of six run-median deltas are positive, one negative; the median paired
delta is .0045335 ms (about 4.5 microseconds), sign p=.21875. This does not
establish latency equivalence or a proved regression. It excludes neither
small scheduling costs nor tails under a flood. It is far smaller than the
rejected real-400-us wait's ~.451 ms penalty, but is **not key-to-screen
latency**. Samples within each session are correlated; 1,800 samples per arm
are not 1,800 independent paired experiments.

## Decision boundary

This is a measured candidate, not a claim that pipeline credit alone explains
all throughput movement. A subsequent third-credit comparison tests whether
more buffers help; see `../2026-11-02-third-credit/`. Final source selection
and complete correctness receipts belong to the final integration report.

## Fresh-control replication and verification

`final/` rebuilds HEAD control and the two-buffer candidate consecutively using
Rust 1.99.0 / LLVM 23.1.1 and identical normal release flags. The reader cleanup
removes unused imports; no engine experiment is present. Source snapshots,
source hashes, build logs, binary hashes and every command exit are retained.
The control differs from the previously frozen release executable; this is a
separate replication, not a reason to pool unrelated measurements.

The full 18-round, all-six-order replication (`final/gate/terminal-summary.json`):

| workload | candidate / fresh control | wins | candidate / Ghostty | wins |
|---|---:|---:|---:|---:|
| ASCII | .9951 | 9/18 | .8712 | 3/18 |
| Unicode | 1.0086 | 12/18 | .9646 | 7/18 |
| truecolor | 1.0118 | 11/18 | 1.1664 | 18/18 |
| cursor motion | **1.0097** | **14 wins, 3 losses, 1 tie** | **1.1237** | **18/18** |
| scroll region | **1.0509** | **15/18** | .9997 | 9/18 |
| TUI frames | 1.0112 | 12/18 | **1.0574** | **18/18** |

Scroll p=.00754 and cursor p=.00418 are exploratory uncorrected tests; both
also fall below .05/6 in this replication. The other small changes are not
proved. The scroll effect is **5.1%, not the first run's 12.5%**. Keep both
records, do not market the larger estimate as universal. Scroll has reached
parity with Ghostty in this run, not a demonstrated lead. ASCII remains behind;
Unicode does not establish leadership. The three established leads survive.

Fresh quiet RTT (`final/rtt/summary.json`, six paired sessions): median of run
medians candidate .0294805 ms / control .031497 ms; pooled medians .0305675 /
.0307325 ms; pooled p99 .057748 / .067838 ms. Four of six paired run medians
favor candidate. Neither this nor the first RTT run establishes a reliable
few-microsecond difference. There is no intentional wait and no reproduced
half-millisecond cost, but do not call this a key-to-screen latency improvement.

Verification before the subsequent HUP correctness fix:

- 828 workspace tests passed, 11 ignored; existing `vulkan_headless` excluded.
- 136 terminal-library unit tests + 45 reference tests passed.
- 12,800 differential streams in default whole-run mode and another 12,800 in
  legacy mode, no divergence; fixed parser comparison passed.
- Reader tests passed, including deterministic partial-read/credit semantics.
- Workspace Clippy exited 0 with warnings (not a warning-free claim).
- Workspace documentation tests passed with matched Rust 1.99.0 rustdoc.
- The first package test command's unit/reference parts passed but its implicit
  doctest failed because stable rustdoc loaded artifacts from RUSTC 1.99.0.
  `terminal-reference-tests.log` retains the failure; the matched-rustdoc rerun
  and explicit documentation checks passed. Do not erase the first failure.

`verify-final.sh` and `resume-final.sh` capture the actual commands and the
mismatch recovery. They use existing project entry points, not fabricated
verification. The final runtime source later also receives the separately
reproduced [HUP drain correction](../2026-11-02-hup-drain/README.md). Its final
build and measurements must be read separately from the hashes above.
