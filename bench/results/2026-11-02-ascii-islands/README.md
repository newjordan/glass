# Byte-proven ASCII islands inside Unicode rows: rejected, no runtime promotion

Reported research, not a world-championship result. Start commit
`c36c990`; Ryzen 9 9950X3D / RTX 3090, Linux, shared host.

## Candidate

At a held ASCII glyph under the default charset, prove eight successor bytes
are printable ASCII. Write the held glyph and at most seven successor glyphs
with a fixed-stride loop, keeping the last consumed successor held. Bound by
the row edge and first underlying wide-cell flag; retain wrap, lazy-row,
uniform-span and REP bookkeeping. No per-glyph width inference for non-ASCII.
This differs from staged Unicode-glyph batching and width-one speculation.

Frozen source and exact patch: `engine.control.rs`, `engine.candidate.rs`,
`candidate.patch`. Build receipts include rustc output and Cargo artifact paths.
Normal `cargo test --release -p glass-term --locked --no-run
--message-format=json`, release thin LTO / one codegen unit. Control and
candidate frozen out of target before measurements. Existing differential
`speed::plain_runs_match_the_parser`: **1 passed, 0 failed** on this candidate.

## Initial balanced engine diagnostic

11 alternating AB/BA pairs, scale 2, five internal rounds; CPU-rate ratio is
the median of paired candidate/control ratios, not a ratio of medians. Each
invocation's internal best-of-five estimator is not five independent trials.
Raw stdout/stderr, binary hashes, workload bytes/read sizes: `engine-pairs.json`.
No concurrent benchmark jobs during any measurements.

| Workload | Median candidate/control CPU rate | Wins/pairs | Two-sided sign p |
|---|---:|---:|---:|
| ascii | 1.003964 | 6/11 | 1.00000000 |
| cursor_motion | 0.964269 | 2/11 | 0.06542969 |
| scroll_region | 1.011253 | 7/11 | 0.54882812 |
| truecolor | 0.995336 | 5/11 | 1.00000000 |
| tui_frames | 0.975019 | 2/11 | 0.06542969 |
| unicode | 0.889912 | 0/11 | 0.00097656 |

Sign tests are exploratory, uncorrected across workloads and candidates.
These tests are diagnostics, not through-PTY performance or visible latency.
No slowdown is dropped and no source change is promoted by engine timing alone.


The coverage preflight is retained in `../2026-11-02-row-continuation/`.
The distinct implementation passes existing parser equivalence but loses
**11.01% Unicode in all 11 pairs**. No terminal gate was warranted.

## Replay

From workspace root:

```
python3 -I bench/replay-engine-pairs.py --pairs 11 \
  bench/results/2026-11-02-ascii-islands/engine-pairs.json
```

Add `--verify-binaries` while the exact executables recorded under `/tmp` are
available. All three runtime candidates were removed. Earlier untracked
experiments and prior iteration reports remain unchanged.
