# Direct scalar commit: correct, but rejected at terminal

Starting source: `f920961c8b459385f73eb171c9c2c8a71b5d6347`.
Linux / Ryzen 9 9950X3D / RTX 3090 / Hyprland; all terminal rounds 154 x 39.
Compiler: configured `RUSTC` 1.99.0, normal workspace release flags (thin LTO,
one codegen unit). No PGO or machine-specific codegen flags.

## Hypothesis and actual edit

In default run-whole mode the legacy Unicode loop decodes a successor before
writing its held scalar. `candidate.patch` adds a direct-commit arm and a const
parameter on `put_row`: commit the checked scalar immediately, publish the last
committed character for REP, and route marks/wraps through existing `input`.
The non-whole-run arm remains unchanged. Invalid UTF-8 and C1 stop unconsumed.
This is distinct from the previous validate-then-`str::Chars` experiment.

## Correctness

- Existing `speed::plain_runs_match_the_parser`: 1 passed, 0 failed.
- Existing ignored sweep, `GLASS_SWEEP_SEEDS=64 GLASS_SWEEP_ROUNDS=200`:
  12,800 differential streams, no divergence.

Logs: `parser-test.log`, `sweep.log`. Correctness does not imply a speedup.

## Engine diagnostics (11 alternating pairs)

`engine-pairs.json` retains raw stdout/stderr, settings and executable hashes.
Ratios are candidate/control reader-thread CPU throughput.

| workload | paired median ratio | wins | two-sided sign p |
|---|---:|---:|---:|
| ASCII | 1.0676 | 11/11 | .000977 |
| Unicode | .9898 | 4/11 | .5488 |
| truecolor | 1.0100 | 9/11 | .0654 |
| cursor motion | 1.0113 | 8/11 | .2266 |
| scroll region | .9950 | 3/11 | .2266 |
| TUI frames | 1.0091 | 10/11 | .0117 |

ASCII does not execute the changed Unicode loop. Its engine gain cannot be
claimed as removal of held-character work; binary layout is a confounder.

## Real-terminal gate (18 three-arm rounds)

Run with `bench/compare-tput.py`, balancing **all six** launch permutations
three times each. Candidate `/tmp/glass-direct-bin`, control
`/tmp/glass-cache-selected`, third arm Ghostty. Captured hashes are in
`binary-hashes.txt` and `gate/terminal-summary.json`. Each round still uses
`tput.py`'s fastest-of-three estimator, not three independent observations.

| workload | candidate/control | wins | candidate/Ghostty | wins |
|---|---:|---:|---:|---:|
| ASCII | 1.0485 | 12/18 | .8917 | 6/18 |
| Unicode | **.9657** | **0/18** | .9045 | 0/18 |
| truecolor | .9960 | 6/18 | 1.1435 | 18/18 |
| cursor motion | .9945 | 6/18 | 1.1057 | 18/18 |
| scroll region | .9744 | 8/18 | .8848 | 3/18 |
| TUI frames | .9946 | 7/18 | 1.0404 | 17/18 |

Unicode loses **3.43% in all 18 pairs**, p=.00000763. The tempting ASCII
median has p=.2379, not evidence of a win. Other small control deltas do not
clear p=.05. Tests are exploratory and uncorrected for multiple comparisons.
All raw rounds, geometry, launch order, paired ratios and hashes are retained
under `gate/`; `terminal-gate.log` is the completed comparison receipt.

## Decision

Rejected and removed from runtime source. The direct-commit loop's correctness
was verified, but there is no production Unicode gain. The through-PTY gate
kills an idea the engine-only numbers could have made superficially attractive.
No startup, key-to-screen, memory, non-Linux or other-machine claim is made.
