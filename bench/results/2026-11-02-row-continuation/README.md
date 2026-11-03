# Reuse row failure continuation: rejected, no runtime promotion

Reported research, not a world-championship result. Start commit
`c36c990`; Ryzen 9 9950X3D / RTX 3090, Linux, shared host.

## Candidate

When `put_row` has decoded the successor but rejects the held glyph (mark,
wrap/width limit, non-default ASCII charset, or underlying wide cell), return
that decoded successor and a rejection flag. The caller avoids re-decoding and
skips the known-failing `put_plain` retry. No changed scalar, width, scrolling,
or held-character semantics. This is not direct-commit or batching.

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
| ascii | 1.019490 | 9/11 | 0.06542969 |
| cursor_motion | 0.987702 | 2/11 | 0.06542969 |
| scroll_region | 1.003853 | 9/11 | 0.06542969 |
| truecolor | 0.989839 | 4/11 | 0.54882812 |
| tui_frames | 0.998725 | 5/11 | 1.00000000 |
| unicode | 0.982443 | 2/11 | 0.06542969 |

Sign tests are exploratory, uncorrected across workloads and candidates.
These tests are diagnostics, not through-PTY performance or visible latency.
No slowdown is dropped and no source change is promoted by engine timing alone.


## Payload coverage before a separate ASCII-island test

`payload-coverage.py` reconstructs the **unchanged terminal** Unicode input at
154x39, preserving RNG consumption by the preceding ASCII generator. Replay:

```
python3 -I bench/results/2026-11-02-row-continuation/payload-coverage.py > /tmp/coverage.json
cmp /tmp/coverage.json bench/results/2026-11-02-row-continuation/ascii-coverage.json
```

Payload 16,777,256 bytes, SHA-256
`82e706b13af91d95d513b487459780f941b4a66b5e729c1fe7163bd840c1c193`.
5,483,313 printable ASCII bytes across 2,008,491 spans. Spans >=8 cover only
845,824 bytes (**5.04% of all bytes**); >=16 cover 47,562 (**0.284%**).
These are opportunity counts, not measured cycle fractions or speed ceilings.
The engine speed test has its own older input generator; do not confuse these
terminal-input counts with the engine diagnostic's payload.

## Replay

From workspace root:

```
python3 -I bench/replay-engine-pairs.py --pairs 11 \
  bench/results/2026-11-02-row-continuation/engine-pairs.json
```

Add `--verify-binaries` while the exact executables recorded under `/tmp` are
available. All three runtime candidates were removed. Earlier untracked
experiments and prior iteration reports remain unchanged.
