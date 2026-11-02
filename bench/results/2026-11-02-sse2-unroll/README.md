# Two-block SSE2 classification — engine gain disappears at terminal level

Base: `8c10f2d`. Forward text classification unrolls two independent 16-byte
SSE2 masks into one 32-bit control/high-bit mask. The backward scan, byte
semantics, width policy and all reader/scheduler behavior are unchanged. No
AVX2 requirement, runtime CPU dispatch or compiler target flag. Candidate and
control source snapshots and `candidate.patch` preserve the runtime experiment.

## Engine diagnostic

Normal release, configured rustc 1.99.0, thin LTO and one codegen unit; 11
alternating AB/BA pairs, scale 2, five internal rounds. Raw outputs, exact binary
hashes, byte counts, read sizes and ratios: `engine-pairs.json`.

| workload | candidate/control MB per CPU-second | wins / non-ties | sign p |
|---|---:|---:|---:|
| ASCII | 1.0118 | 10/11 | .01172 |
| Unicode | 1.0090 | 7/10 | .34375 |
| truecolor | .9954 | 2/10 | .10938 |
| cursor | .9915 | 4/11 | .54883 |
| region | 1.0099 | 9/11 | .06543 |
| TUI | 1.0010 | 6/11 | 1 |

Exact scanner oracle test passed (`scanner-test.log`). This small engine result
is diagnostic and was **not** promoted without the real PTY gate.

## Full real-terminal gate: rejected

Frozen normal release builds from candidate and control. Eighteen rounds, all
six permutations of candidate/control/Ghostty repeated three times, 54 terminal
sessions. Grid 154 x 39. Three DA1-ended samples per workload/session with the
unchanged historical harness policy. No concurrent builds or local benchmark
jobs during this gate; this is still a shared, non-isolated host.

```
GLASS=/tmp/glass-i7-unroll GLASS_ALT=/tmp/glass-i7-control CAP=GLASSI7GATE \
  python3 -I bench/compare-tput.py bench/results/2026-11-02-sse2-unroll/gate --rounds 18
python3 -I bench/compare-tput.py bench/results/2026-11-02-sse2-unroll/gate \
  --rounds 18 --summarize-only
```

The first launch mistakenly passed `--out` and exited at argument parsing;
`terminal-gate.log` is that error, **not measurements**. The corrected gate is
`terminal-gate-corrected.log`. `gate-replay.log` is a successful independent
recomputation of all summaries with binary/harness/raw-result hashes checked.

| workload | candidate/control terminal throughput | wins/18 | sign p |
|---|---:|---:|---:|
| ASCII | .99699 | 9 | 1 |
| Unicode | 1.00108 | 9 | 1 |
| truecolor | .98859 | 5 | .09625 |
| cursor | .99580 | 9 | 1 |
| region | 1.00124 | 10 | .81453 |
| TUI | .99020 | 6 | .23788 |

No dependable gain. Removing a loop iteration in the scan does not establish a
production improvement; the roughly 1% engine gain failed to transfer. Candidate
removed. No new RTT claim: rejected candidates need no latency gate.

### Selected control vs Ghostty, from the same sessions

`selected-vs-ghostty.json` recomputes the **control** arm vs Ghostty from raw
sessions, not the rejected scanner arm:

| workload | control/Ghostty median paired ratio | wins/18 |
|---|---:|---:|
| ASCII | .9465 | 7 |
| Unicode | 1.0108 | 9 |
| truecolor | 1.1972 | 15 |
| cursor | 1.1260 | 14 |
| region | .9672 | 8 |
| TUI | 1.0674 | 13 |

These reflect this run and its load, not a replacement for older measured
builds. Unicode parity with mixed signs is not a reliable win; ASCII and region
remain unresolved. No all-metric/world-title claim. Sign p values throughout
are exploratory, not multiple-comparison corrected.

## Durable correctness addition, not runtime tuning

Three new tests are kept on the unchanged selected scanner/decoder source:

1. Exact text masks for every byte value around 16/32/64/128-byte boundaries,
   including high bits before/after controls across the SIMD halves.
2. Legal slices of lengths 0..256 ending immediately before a PROT_NONE page;
   any vector read past the slice faults instead of hiding in Vec capacity.
3. Every 1,112,064 Unicode scalar and every truncation of each encoding, plus
   540,672 boundary-form checks of invalid leads/continuations, overlong forms,
   surrogate boundaries and the U+10FFFF limit, compared with std validation.

`boundary-tests.patch` and `engine.tests-only.rs` identify the final test-only
source. Final gates, **on that source**:

- `cargo test --release -p glass-term --locked classified_text -- --nocapture`:
  2 passed (`final-boundary-tests.log`).
- `cargo test --release -p glass-term --locked utf8_decoding -- --nocapture`:
  2 passed, including the pre-existing randomized oracle (`final-decoder-tests.log`).

`final-source-test-hashes.txt` identifies the final source and test executable.
No new broad workspace test count, Clippy result or RTT is claimed. Selected
release executable restored byte-for-byte from the pre-experiment copy:
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
