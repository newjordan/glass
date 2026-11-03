# Authoritative parser-ground screen — runtime rejected

## Question and frozen protocol

Can Glass remove its separate `Mirror` state machine and use VTE's actual
Ground + partial-UTF8 + pending-sync state to decide whether a run or simple
CSI lane may bypass the parser? `protocol.json` fixed one implementation,
11 AB/BA engine pairs, scale 2, best of five rounds. Required >=1.02 ASCII or
scroll-region CPU-throughput with six-workload Holm p<.05, plus >=.98 on every
workload. No variant, selective rerun or rescue pooling was permitted.

## New measured finding

| workload | candidate/control median CPU throughput | wins/11 | Holm p |
|---|---:|---:|---:|
| ASCII | 1.064495 | 11 | .005859 |
| Unicode | 1.011687 | 8 | .226563 |
| truecolor | **0.922042** | **0** | .005859 |
| cursor motion | 1.039707 | 11 | .005859 |
| scroll region | 1.068099 | 11 | .005859 |
| TUI frames | 1.031504 | 10 | .023438 |

The candidate clears both target workloads but **fails the truecolor guard**.
Runtime is rejected and restored, no PTY/competitor run followed. These are
best-of-five in-process CPU-throughput diagnostics, not terminal speed, startup,
latency, energy, equivalence or a Ghostty score. Alternating serial orders do
not establish independent signs or causal confidence bounds. The candidate
also changes where gaps reach VTE: the numbers cannot isolate shadow-parser
cost alone. Next lead (unmeasured): authoritative state with a different
simple-CSI handoff, independently frozen; no claim it will recover truecolor.

## Correctness retained

`speed::parser_ground_chunk_boundaries` tests 1,092 deterministic combinations
of read cuts, partial/malformed UTF8, CSI/OSC/DCS/APC, synchronized output,
REP and narrow/wide grids. Both correct builds pass. A compiled mutant omits
`partial_utf8_len == 0` and fails with **Some("cells")**, prefix C3, 3x2 grid,
25-byte chunks. Ground is insufficient if VTE still owns a partial scalar.
Both exact measured arms pass **382 tests**, 11 ignored, and **12,800 streams**
over 64 seeds. The restored build retains this regression only; no runtime
implementation change is selected.

## Build-provenance defect found and fixed

The first attempted control restore used `shutil.copy2`, restoring old mtimes.
Cargo reused the most recent mutant and reported VTE, alacritty_terminal and
Glass `fresh=true`. Its executable SHA256 **equals the mutant's**, while the
fresh corrected control differs. The focused test stopped the pipeline before
any timing sample existed. The apparent baseline defect was **not confirmed**.
Initial failure, stale identities and logs remain; corrected builds rewrite
exact source bytes with current mtimes before compiling. Corrected control
and candidate receipts show the affected packages non-fresh, and both pass.

`bench/build-engine-arm.py` now touches explicit input timestamps without
changing content, requires non-fresh VTE, alacritty_terminal and Glass receipts,
requires release test and successful build completion, binds input/output
hashes, and publishes a fully staged executable atomically without clobbering.
Use only with exclusive source/target ownership. It is a local build guard, not
source attestation, a sandbox or comprehensive race protection. Its output
is byte-identical to measured control. It refuses an existing output before
creating receipts. Eight helper tests cover stale/missing/ambiguous receipts,
non-release or incomplete builds, failed-copy cleanup and no-clobber publication.
65 total Python tests pass. 17 challenges of actual report/build copies are
rejected without changing canonical evidence, including the real stale receipt.

## Preservation and replay

All **119 other crate Rust sources**, the selected `target/release/glass` hash
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`,
and **5,994 prior tracked result/report files** are preserved. The 96 additional
tracked .rs artifacts outside crates are preserved too (216 tracked .rs total,
only `crates/term/src/speed.rs` changed). Previous frozen evidence replays via
explicit mappings to retained docs/source snapshots; no prior file is repaired.
Selected terminal executable was neither rebuilt nor replaced.

```sh
python3 -B bench/results/2026-11-03-parser-authority/verify.py
python3 -B bench/replay-evidence-index.py bench/results/2026-11-03-parser-authority/frozen-index.json
```

The read-only checkpoint does not build, repair, discover evidence or rerun
performance. It validates frozen sources, exact binary identities, all eleven
raw paired reports, the decision, positive and negative checks and historical
hashes. This is concrete research progress, **not every-metric superiority**.
