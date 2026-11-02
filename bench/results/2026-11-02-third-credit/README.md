# Third producer credit: not worth another buffer

Source: `f920961c8b459385f73eb171c9c2c8a71b5d6347` plus two-buffer early
recycling. `candidate.patch` additionally raises `AHEAD` from 2 to 3 while
preserving 16 KiB hand-offs, copy-based parsing, poll(0), CPU-affinity policy
and engine source. One more 16 KiB allocation permits at most three future
hand-offs plus the independent parser copy. This is an explicitly larger
backpressure bound, not a free implementation detail.

Existing PTY byte-order/EOF and deterministic partial-read/credit tests both
passed (`reader-tests.log`). This is not a whole-workspace verification claim
for the rejected three-buffer candidate.

## Completed comparison

18 real-terminal rounds, all six launch orders repeated three times at
154 x 39 on Ryzen 9 9950X3D / RTX 3090 / Linux / Hyprland. Candidate =
`/tmp/glass-third-credit-bin`; control = `/tmp/glass-early-recycle-bin` (two
buffers, early recycle). `gate/terminal-summary.json` has exact binaries,
harness hashes, raw JSON hashes, paired ratios, signs and geometry. No
outlier rounds are removed. The shell and compositor had no `GLASS_*`
experiment flags when inspected (`experiment-env.json`); the runner was
subsequently corrected to clear inherited flags explicitly for future runs.

| workload | three / two buffers | wins | sign p | three / Ghostty | wins |
|---|---:|---:|---:|---:|---:|
| ASCII | 1.0422 | 10/18 | .8145 | .8314 | 5/18 |
| Unicode | 1.0048 | 11/18 | .4807 | 1.0044 | 10/18 |
| truecolor | 1.0047 | 11/18 | .4807 | 1.2049 | 18/18 |
| cursor motion | 1.0094 | 12/18 | .2379 | 1.1183 | 18/18 |
| scroll region | 1.0185 | 10/18 | .8145 | .9930 | 8/18 |
| TUI frames | 1.0071 | 12/18 | .2379 | 1.0612 | 18/18 |

**No comparison against two-buffer early recycling passes p=.05**, even
before multiple-comparison correction. The 4.2% ASCII median is particularly
misleading: only 10/18 signs agree. The three established Ghostty leads remain,
but Unicode's ratio just above one is not a win; 10/18 is consistent with noise.
These exploratory sign tests are uncorrected for multiple comparisons.

## Decision

Do not retain the additional 16 KiB or larger outstanding-byte bound without
a measured benefit. Revert AHEAD to two. The selected final verification
rebuilds the two-buffer candidate and a fresh HEAD control with identical
flags, tests that exact source and reruns the terminal and quiet-RTT gates.
No quiet-RTT, memory or cross-platform claim is made for three buffers.
