# Four-byte masked UTF-8 validation: rejected, no runtime promotion

Reported research, not a world-championship result. Start commit
`c36c990`; Ryzen 9 9950X3D / RTX 3090, Linux, shared host.

## Candidate

For slices with at least four bytes available, load a little-endian u32.
Validate continuation-byte high bits together and enforce the existing
E0/ED/F0/F4 bounds; reconstruct one scalar using masks/shifts. Retain the old
decoder for shorter tails, and preserve scalar widths, character sequence and
scroll frequency. No unchecked scalar creation, tables, memo, normalization,
or benchmark-specific dispatch.

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
| ascii | 1.022453 | 8/11 | 0.22656250 |
| cursor_motion | 1.026230 | 6/11 | 1.00000000 |
| scroll_region | 1.007366 | 6/11 | 1.00000000 |
| truecolor | 1.008671 | 7/11 | 0.54882812 |
| tui_frames | 1.010112 | 6/11 | 1.00000000 |
| unicode | 1.011570 | 7/11 | 0.54882812 |

Sign tests are exploratory, uncorrected across workloads and candidates.
These tests are diagnostics, not through-PTY performance or visible latency.
No slowdown is dropped and no source change is promoted by engine timing alone.


## Independent build/pair replication: initial gain does not reproduce

After adding identical decoder tests to both source arms, rebuild both with
the same flags; freeze `/tmp/glass-i11-control-retest` and
`/tmp/glass-i11-word-retest`. The extra tests change the test executable layout;
this is a sensitivity/replication check, **not** pooling one larger sample.
15 alternating pairs, scale 3, seven internal rounds, all six workloads:

| Workload | Median CPU rate ratio | Wins/15 | Two-sided sign p |
|---|---:|---:|---:|
| ascii | 1.005331 | 9/15 | 0.60723877 |
| cursor_motion | 1.008946 | 12/15 | 0.03515625 |
| scroll_region | 0.995797 | 6/15 | 0.60723877 |
| truecolor | 1.011071 | 13/15 | 0.00738525 |
| tui_frames | 0.996771 | 6/15 | 0.60723877 |
| unicode | 0.995212 | 5/15 | 0.30175781 |

Unicode +1.16% (7/11) becomes **-0.48% (5/15)**. No dependable Unicode gain;
no terminal promotion run, RTT run or new competitor score. Movements in
other workloads need not be benefits of the decoder; code layout and host
variance can move unchanged paths. All observations retained; no filtering.

Production forms were also built and hashed (`production-sha256.txt`):
candidate `abef0610e32f0a586c0120740d6177a93ffd6015767fa6943a6cf82ab234d346`,
fresh control `eb14bd5e80f5a4cca770a4272bdd416bd05f9a11f427fbfd6633cb8685e51ce0`.
**They were not benchmarked through the terminal** and are not promoted.
The exact historical selected release executable was restored afterward.

## Expanded safety coverage, kept on selected source

Four decoder tests passed on the candidate and restored source. New:

- all 1,112,064 valid Unicode scalars, each at offsets 0..4 with trailing junk;
  5,560,320 padded scalar comparisons. This forces word paths for short scalars.
- guarded mmap: valid 1/2/3/4-byte scalars, invalid forms and every truncation,
  with 0..32 ASCII-prefix lengths and every in-bounds starting offset. Each
  slice ends immediately before a PROT_NONE page, exposing decoder overreads.
  mmap is RAII-unmapped even when an assertion unwinds.

Unpadded short-scalar exhaustive tests alone do not exercise the new four-byte
path for those scalars; this is a concrete coverage gap, not a runtime bug.
The existing parser equivalence test also passed on each candidate and final
source. Final targeted Rust gate: **5 passed, 0 failed** (four decoder + one
parser differential), no workspace-wide test claim.

## Instruction evidence, not a bottleneck proof

`print-utf8.asm` and `print-utf8.symbol.txt` come from the exact selected binary.
`sample-inputs.sha256` identifies it and the previous iteration's unmodified
`cpu-summary.json`. That summary's highest Unicode offsets `+0x543` (47),
`+0x523` (34), `+0x96c` (31), `+0x54b` (13) include UTF-8 lead dispatch and
bounds checks; `+0x96c` is not assigned a mechanism here. These are correlated,
coalesced, coarse leaf samples. They motivated a test, not a causal cost split.
Decoder rewrites failing to win do not prove that decoding is free.

## Restoration and report checks

`restoration.json`: live engine minus only the two added tests equals frozen
control exactly; runtime source hashes and selected executable hashes retained.
Selected release SHA-256:
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
`target/release/glass` was byte-compared to `/tmp/glass-i11-selected`.

`bench/replay-engine-pairs.py` is a separate fail-closed raw/parsed/summary
consistency checker. Five validator unit tests pass; synthetic fixtures are
explicitly not measurements. Real report replay is retained in
`initial-replay.log` and `replication-replay.log`. It verifies arithmetic and
provenance, not measurement accuracy or terminal ranking.

## Replay

From workspace root:

```
python3 -I bench/replay-engine-pairs.py --pairs 11 \
  bench/results/2026-11-02-word-decode/engine-pairs.json
```

Add `--verify-binaries` while the exact executables recorded under `/tmp` are
available. All three runtime candidates were removed. Earlier untracked
experiments and prior iteration reports remain unchanged.
