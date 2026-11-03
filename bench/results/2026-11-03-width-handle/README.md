# Row-scoped width-cache handle: rejected

This iteration tests one distinct mechanism: acquiring the existing flat Unicode
width-cache handle once per `put_row`, instead of through `width_of` for each
non-ASCII scalar. The cache entries remain relaxed atomics, with the same
fill-on-miss Unicode policy. Decoder, cells, cursor arithmetic, combining-mark
ownership, PTY reader and scheduling are unchanged in the timing candidate.

## Frozen screen and result

`protocol.json` was saved before either candidate code or measurements. Fresh
release test controls/candidates used the same locked Cargo command and flags.
`engine-identities.json` binds their copied executable bytes. Eleven balanced
AB/BA pairs, scale 2, five internal rounds, all six workloads; no simultaneous
own build during measurements. These are **engine CPU-rate diagnostics**, not
terminal/competitor timings or independent samples from each internal round.
The fastest internal CPU pass is selected by the existing benchmark.

| Workload | Candidate/control median CPU rate | Wins/11 | Six-workload Holm p |
|---|---:|---:|---:|
| ASCII | 1.018585 | 11 | .005859 |
| Unicode | 1.009280 | 9 | .261719 |
| Truecolor | 1.009943 | 9 | .261719 |
| Cursor motion | 1.008080 | 10 | .058594 |
| Scroll region | 1.002945 | 8 | .261719 |
| TUI frames | 1.003923 | 9 | .261719 |

Unicode fails both the >=1.02 target and corrected p<.05 requirement. All six
point ratios exceed .98, which does not establish equivalence/noninferiority.
No terminal follow-on, extra pairs, variant, replication or rescue pooling.
The runtime change is rejected and restored exactly. In particular, ASCII's
observed improvement is **not** attributed to the modified Unicode row path:
ASCII dispatches through `print_run`; layout and shared-host effects remain.
Balanced launch order does not establish independent round signs.

## New mechanism finding: eager cache allocation

Review identified a resource behavior the warm throughput benchmark cannot
assess. A C1-only valid UTF-8 run enters the row path once RUN_MIN is reached,
then returns without querying any width. Moving `width_cache()` before that
check can initialize its allocation unnecessarily.

`cold-protocol.json` is a separate, **post-screen** mechanistic diagnostic. It
cannot reverse the failed performance decision. Both instrumented source
snapshots relocate the same OnceLock to an observable module static. The
identical isolated test starts with an empty cache in a new process, feeds
one whole stream and observes the cache before differential comparison.

| Fresh-process stream | Instrumented control | Instrumented candidate |
|---|---|---|
| 16 U+0085 C1 scalars | not initialized | initialized |
| 32 ASCII `a` | not initialized | not initialized |
| 16 U+754C wide scalars | initialized | initialized |

All six exact tests pass, including parser cell/state parity. The cache has
1,114,112 one-byte atomic entries, so its payload is **1,114,112 bytes**
(1.0625 MiB), deduced from representation. This is not an allocator, RSS,
startup-latency or energy measurement, and says nothing about allocation
frequency outside this isolated cold case. Instrumented binary/source hashes
and six logs are retained; `analyze-cold.py` replays the observations. Neither
the instrumentation nor the extra test is shipped in production.

## Retained source change and verification

Only `speed::c1_row_runs_preserve_parser_state` remains in Rust source. It
covers all 32 C1 scalars, C1-only and mixed printable predecessors, REP/replies,
alternate screen, wrap modes, styles, three screen sizes, and seven read cuts
(including UTF-8 splits and RUN_MIN 23/24/25 boundaries): 2,688 differential
scenarios. It guards parser-visible state, **not allocation behavior**.
A built negative control maps valid C1 scalars to `?` in the decoder: the test
fails on actual cells at 3x2, U+0080, chunk 24. This proves a particular C1
semantic defect is caught, not that all mutations or cache resource changes
would be caught.

- Exact candidate: exhaustive Unicode-width agreement, parser parity and
  existing pending-wrap regression pass.
- Restored release build: 381 terminal tests pass; 11 intentionally ignored.
- Existing parser sweep: 12,800 streams over 64 seeds, no divergence.
- Existing Python entry point: 49 tests pass.
- Nine report corruptions reject without changing the evidence report.
- 119 Rust files are byte-identical; the 120th changes only test code.
- All 5,869 previously tracked result/report files and selected terminal
  executable are preserved. Starting hashes and historical mappings retained.

The initial engine launch used unsupported named binary arguments; it measured
nothing, is retained in `engine-launch-argument-error.log`, and was followed by
one correctly formed 11-pair run. The initial cold diagnostic used the wrong
`feed` argument type; both failed logs are preserved. Only `*-corrected` builds
produced cold observations. Neither failure was silently replaced.

## Read-only replay

```sh
python3 -B bench/results/2026-11-03-width-handle/verify.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-width-handle/frozen-index.json
```

The checkpoint requires the retained hashed test executables under `/tmp`;
missing/changed binaries fail closed instead of rebuilding. Frozen byte replay
is independent of temporary executables. `starting-state.json` preserves the
entire prior result/report file set. `prior-frozen-index.json` explicitly maps
evolved test/document sources to retained snapshots without altering old
manifests. Checkpoint/hash receipts do not imply timing truth or championship.

**No new Ghostty score.** The prior selected-build comparison remains the
relevant frozen scoreboard (Unicode ratio .929112; three of six corrected
positive throughput leads). This iteration does not close the ASCII, Unicode
or scroll-region gaps, or the broader startup/memory/input/presentation gates.
See [iteration 21 report](../../../reports/research-1eecf9876bb302e9da10ff629e71e6d8-21.txt).
