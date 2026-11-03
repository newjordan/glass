# Per-pass clock retention / observer check (2026-11-03, iteration 34)

## Retained implementation

`crates/term/src/speed.rs` is compiled only under `cfg(test)` in main.rs.
`GLASS_BENCH_SAMPLES=/new/path.jsonl` opts the existing `speed::speed` diagnostic
into retaining **every** in-memory pass's paired integer wall/thread-CPU
nanoseconds, payload length, read size and pass index. No JSON/file I/O occurs
inside a pass. The numeric vector is preallocated; records are serialized and
flushed after each workload. Output is `create_new`: existing files are refused.
Printed on-mode minima derive from the retained durations (CPU and wall minima
still independently selected). With recording off, legacy clock acquisition and
summary semantics remain. This is not a speed candidate or a terminal benchmark.

The new parser, `bench/analyze-engine-passes.py`, requires a caller-authenticated
manifest and exact workload/pass order; refuses duplicate JSON keys, booleans as
integers, missing/extra/reordered passes, unknown fields/schema, nonpositive or
out-of-range durations, and mismatched lengths/read/rounds. It reports integer
samples, min/median/max and minima pass IDs, never a speed acceptance verdict.
Nanosecond representation does not establish nanosecond accuracy; CPU/wall clock
endpoints are adjacent, not identical. It does not authenticate a manifest for
the caller or validate terminal contents. Sampling is refused for PTY/stage modes.

## Fixed experiment and actual results

Exactly 12 sequential balanced on/off pairs, one final release test executable,
five passes per six exact Python terminal payloads, 39x154, 4095-byte reads.
The recorder off/on executable is the same SHA256
`afaa4ae10d8781fcc6f0df2a84f4ff1be1e4993fac76527ee1d742023e8bfa59`.
No pilot, result retry, exclusion, pooling, threshold or count adjustment.

24 sessions, 360 retained pass pairs, 72 on-mode workload sessions. CPU and wall
minima chose different passes in only **1/72** cases (ASCII). That possible
cross-pass mismatch is **not** the dominant issue in this capture. Median-pass
selection sensitivity is substantial:

| Workload | median on/off CPU rate | median on/off wall rate | median CPU duration / minimum duration, across 12 sessions | CPU best-pass counts, indices 0..4 |
|---|---:|---:|---:|---|
| ASCII | .934537 | .934380 | 1.1679 | 0,3,2,2,5 |
| Unicode | 1.104757 | 1.104917 | 1.0714 | 0,4,3,3,2 |
| Truecolor | 1.008227 | 1.008853 | 1.0522 | 1,0,3,4,4 |
| Cursor motion | .999434 | .999031 | 1.0409 | 4,2,1,2,3 |
| Scroll region | 1.013951 | 1.014116 | 1.0699 | 4,0,0,3,5 |
| TUI frames | 1.004088 | 1.003766 | 1.0429 | 3,0,1,6,2 |

ASCII per-session CPU median/min range 1.0224–1.7777; the other workload ranges
are retained in analysis.json. These are selection sensitivity measurements,
not independent pass samples or comparative terminal wins. One executable
with recording toggled cannot isolate compile-time observer effects relative
to the old executable. Shared-host/setup/cache effects remain confounded.
The observed on/off rates are too dispersed to establish a negligible observer
cost, causal penalty/benefit, or a valid correction factor. No significance or
noninferiority claim. No inference that earlier candidates would pass under a
new estimator. Future comparisons must predeclare their estimator and use the
same recorder mode on both arms, with fresh evidence.

## Specific checks

- Final optimized non-fresh build pinned by Cargo JSON and four source hashes.
- One pre-existing parser-equivalence test passed on that exact final ELF.
- Integer-pair serialization unit test passed on the intermediate ELF; after
  the summary-duration alignment edit, final raw 360 records/printed summary
  agreement is checked by analysis. No full terminal suite was run this iteration.
- Five Python parser/contract test methods pass (including malformed-record
  subtests). Twenty-six raw receipt corruptions rejected.
- Six real entry-point guard failures rejected: existing output, zero rounds,
  zero read, PTY, partial feed, and no workload match. Existing sentinel untouched.
- Seven archives preserve the six byte-identical payloads and final executable:
  128,989,204 raw bytes in 3,712,548 compressed bytes, losslessly verified.
- Frozen/preservation replay is a source-integrity gate, not speed acceptance.

## Failures retained

First runner invocation failed preflight before any session: the prior payloads
were archived `.bin.xz`, while preflight expected `.bin`. All preflight sources,
protocol/logs retained; materialized exact hash-checked bytes locally, changed
only corpus location with an explicit amendment, then ran the fixed schedule.
No measured session was rerun. A failed apply_patch preflight changed nothing;
a context-specific edit succeeded. A read-only advisory seat timed out, and its
candidate was not adopted. No claimed independent audit.

## Reproduction / archives

Read-only replay, no GPU, terminal or timing needed:

```
python3 -B bench/results/2026-11-03-pass-samples/verify.py
python3 -B bench/replay-evidence-index.py bench/results/2026-11-03-pass-samples/final-frozen-index.json
```

`original-speed.rs` preserves the immediately previous diagnostic so prior
historical manifests still resolve; earlier evidence files themselves unchanged.
For a NEW experiment (not replay of this one), decompress each corpus `.bin.xz`
into `.bin`, build a new release test ELF, and use a new output path:

```
GLASS_BENCH_CORPUS=bench/results/2026-11-03-pass-samples/corpus \
GLASS_BENCH_SCALE=1 GLASS_BENCH_ROUNDS=5 GLASS_BENCH_READ=4095 \
GLASS_BENCH_SAMPLES=/a/new/samples.jsonl \
/path/to/new/release-test-elf --exact --ignored --nocapture speed::speed
python3 -B bench/analyze-engine-passes.py /a/new/samples.jsonl \
  --manifest bench/results/2026-11-03-pass-samples/corpus/manifest.json --rounds 5
```

Do not rerun run.py in this frozen directory; its no-clobber contract is
intentional. The selected runtime executable remains
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
No runtime promotion, no Ghostty comparison, no all-metric championship evidence,
and no acceptance command bound. The next performance claim still requires a
runtime candidate and fresh selected-build end-to-end evidence for the actual
remaining gaps and the agreed all-metric scope.
