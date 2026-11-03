# Region indexing: small scroll gain rejected for ASCII cost

Starting source: `86e1a564a014eeaf984b327d1f2fd0e32662ff3f`.
This is a **rejected** isolated engine experiment, not a terminal result.

`Storage::rotate_region_up` can map a visible line through the existing
`compute_index` one-subtraction mapping rather than signed remainder. Whole
row rotation, lazy `occ`/`blank` state and disjoint-suffix fallback stay intact.
`candidate.patch`, `storage.control.rs` and `storage.candidate.rs` retain the
exact proposal. An initial test compilation failed because the suffix fallback
still used a removed closure; that diagnostic is retained. It was fixed before
all reported measurements. It is not a runtime defect or a successful run.

Two independent, alternating control/candidate engine series used all six
workloads, scale 2 and five internal rounds. Ratios are median paired
candidate/control MB per CPU-second (not PTY throughput):

| workload | 11 pairs | wins/losses | replication, 17 pairs | wins/losses |
|---|---:|---:|---:|---:|
| ASCII | 0.9839 | 2/9 | 0.9732 | 3/14 |
| Unicode | 1.0135 | 8/3 | 1.0097 | 10/7 |
| truecolor | 1.0086 | 9/2 | 1.0034 | 9/8 |
| cursor motion | 1.0097 | 9/2 | 1.0117 | 16/1 |
| scroll region | 1.0298 | 7/4 | 1.0217 | 14/3 |
| TUI frames | 1.0056 | 8/3 | 1.0062 | 12/4, 1 tie |

Replication unadjusted sign p: ASCII and region .0127258, cursor .000274658.
The ASCII cost does not meet an all-workload improvement objective, and the
region gain is modest. No terminal gate was spent on this tradeoff. Do not
repeat it as a novel region-index discovery; a different region-local-offset
scheme was already tried in the prior campaign, too.

`candidate-library-tests.log` retains the package unit suite, and
`candidate-differential.log` retains the parser-equivalence check. Both paired
reports pass `bench/replay-engine-pairs.py --verify-binaries` with their
recorded pair counts while the named temporary executables remain available.
Replay checks raw output, arithmetic, identity and order, **not timing accuracy**.
The runtime source was restored before subsequent width/mark experiments.
`start.json` records the pre-experiment source and selected binary identities.
