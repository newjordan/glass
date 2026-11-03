# Static marks plus immutable widths: four leads, no all-metric promotion

**Outcome: unpromoted research; original runtime and exact selected executable
restored.** The requested lead on every metric is not established. This is not
proof that the candidate is universally worse. Its measured Unicode/truecolor
progress is retained, along with unresolved ASCII and scroll-region results.

Starting checkpoint: `86e1a564a014eeaf984b327d1f2fd0e32662ff3f`.
Machine: Linux, Ryzen 9 9950X3D, RTX 3090, shared host. Cargo builds use the
configured rustc 1.99.0; shell rustc is 1.99.1; Miri reports 0.1.0 (2026-09-20).
The workload and geometry remain the existing six `tput.py` workloads at
**154 x 39**, DA1 completion, fastest of three passes. This is not visible-frame
latency. One full set of six terminal launch permutations is repeated, not a
cyclic-only order. No other Glass benchmark/build overlapped a terminal gate;
unrelated CPU work on the shared host was visibly substantial during parts of
the combined experiment. No slow sessions were deleted.

## What changed

This combines the two isolated experiments in
[`../2026-11-03-static-marks/`](../2026-11-03-static-marks/) and
[`../2026-11-03-immutable-width/`](../2026-11-03-immutable-width/):

- A fixed 112-entry immutable pool for U+0300..U+036F avoids per-cell Arc
  reference-count operations. `CellExtraRef` owns either a provenance-preserving
  tagged static pointer or exactly one raw Arc strong reference. Mutation
  converts static content into owned content, then uses guarded Arc COW.
  Strict ownership obligations, public field type change and tested Weak/
  cross-thread behavior are detailed in the isolated mark report.
- A build-time generated 0x110000-byte table replaces the runtime AtomicI8
  width cache, with the dependency's exact per-scalar answers. It adds about
  1.1 MiB of read-only executable data. This is not proof of a width-specific
  mechanism for the truecolor change; code/data layout also changes.
- The final combined source was formatted and its unsafe Send/Sync impls carry
  explicit `CellExtra: Send + Sync` bounds. These final bytes received their
  own tests/build/gates; isolated binary results were not inherited.

`candidate.patch`, `cell.candidate.rs`, `engine.candidate.rs`,
`Cargo.candidate.toml`, and `build.candidate.rs` retain the complete proposal.
The build script is a new file stored separately from the tracked-file patch.
`cell.pre-format.rs` is the earlier source, not the final measured source.
Formatter failures/warnings are retained; the installed stable formatter did
not honor nightly-only formatting options. No lint-clean claim is made.

## Exact-build through-PTY results

Every table value is the median of paired throughput ratios; larger is better.
Wins count paired rounds, not the fastest-three internal passes. Series are
**not pooled** with each other or with isolated experiments.

| workload | first 18: combined/control | wins | replication 30: combined/control | wins |
|---|---:|---:|---:|---:|
| ASCII | .8520 | 6/18 | 1.0112 | 17/30 |
| Unicode | 1.1591 | 11/18 | **1.2229** | **26/30** |
| truecolor | **1.1424** | **15/18** | **1.1298** | **26/30** |
| cursor motion | 1.0352 | 11/18 | **1.0147** | **25/30** |
| scroll region | 1.0394 | 11/18 | .9969 | 13/30 |
| TUI frames | 1.0488 | 12/18 | **1.0391** | **27/30** |

| workload | first 18: combined/Ghostty | wins | replication 30: combined/Ghostty | wins |
|---|---:|---:|---:|---:|
| ASCII | 1.1291 | 10/18 | .9655 | 10/30 |
| Unicode | 1.1121 | 13/18 | **1.1609** | **24/30** |
| truecolor | **1.4076** | **15/18** | **1.3266** | **29/30** |
| cursor motion | 1.1515 | 14/18 | **1.1269** | **26/30** |
| scroll region | 1.1564 | 10/18 | 1.0013 | 15/30 |
| TUI frames | 1.1094 | 14/18 | **1.0827** | **26/30** |

First-series Unicode was unresolved; its large positive median is not evidence
of equivalence or superiority. The adverse ASCII median is preserved. The
replication supports four workload gains, **not six**. ASCII and region do not
establish a lead on Ghostty or nonregression against control. No acceptable loss
margin had been declared, so nonsignificance cannot stand in for noninferiority.
The protected all-metric selection rule remains unmet.

The canonical runner stores unadjusted two-sided sign p-values.
`holm-workload-families.json` additionally corrects six workloads within each
candidate/series/comparator family (not campaign-wide correction). In combined
replication, Holm p versus control: Unicode/truecolor .00029738 each, cursor
.00031115, TUI .00005058; ASCII/region 1. Versus Ghostty: Unicode .00429272,
truecolor .00000035, cursor/TUI .00029738 each, ASCII .19747429, region 1.
First-series truecolor Holm p=.04522705 versus each comparator; the other
combined first-series claims do not clear this six-workload correction.
`decision-rule.txt` was recorded before viewing replication results; exactly
one planned 30-round replication was run, not a significance search.

## Correctness actually executed on this final candidate

- Package library with serde **140 passed**; reference fixtures **45 passed**.
- Cell ownership/layout/style/serde tests under Miri strict provenance:
  **9 passed**, including all 112 entries, COW, strong/Weak counts and threads.
- Exhaustive width test: every **1,112,064 valid scalar**, twice, matches
  the pinned width dependency. **1 test passed**.
- Existing parser parity: **1 passed**.
- Existing seeded differential sweep: **12,800 streams / 64 seeds**, no
  divergence. The isolated static-mark binary's probe-100 negative control
  diverges immediately; inert probe-5 and mistyped-log-check mistakes are
  retained and not called successful negative controls.

No workspace-wide final-candidate test or clippy claim is made. Tests validate
particular behaviors and Miri executions, not a universal memory-safety proof.
`review-notes.txt` distinguishes advisory consultations from executed checks
and records the read-only reviewer that timed out without findings.

## Serial guards

`quiet-rtt/`: 12 AB/BA pairs, 500 measured responses per session after 20
warmups = **12,000 measured DA1 responses**. Candidate/control pooled median
.029375/.0295555 ms, p90 .044164/.045296 ms, p99 .081003/.088917 ms. Median
of run medians .02713325/.0285615 ms; median paired run-median delta
-.00004975 ms. These tiny descriptive differences do not prove latency
superiority. Quiet DA1 is **not key-to-screen latency**.

`startup.log`: eight launches each, candidate always before control within a
pair (not AB/BA). Child-execution median **25.5/27.0 ms**; mapped-window median
**20.5/21.0 ms**. Every result contains eight samples, no missing child or map
event. The existing integer-ms harness/order and small sample count limit the
claim to a descriptive guard, not a statistically established startup win.
Key-to-screen latency, idle memory/VRAM, CPU energy and other machines were
not measured for this candidate. No all-metric title is implied by throughput.

## Restoration, replay and next action

`restoration.json` compares all **120 original Rust source paths**, with none
changed, checks an empty `git diff -- crates`, removal of the new build script,
and equality of saved/selected executable SHA-256:
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
The unpromoted combined executable is separately frozen with SHA-256:
`6111147b21a4bc6d112cfb359bd8e3535b4c7bdd03e0803b550534e8e45c3369`.
Fresh control is `c14daae87141541f747095ec77644e9189e009251716408e2630abd7a294a1ed`.
Post-guard hashes confirm no executable changed during measurements.

Both terminal datasets passed the canonical summarize-only replay (all raw
hashes, shape, order, executable and harness IDs). Quiet RTT passed the new
standalone replay. The RTT checker has **10 passing synthetic negative/positive
tests**; fixtures are not measurements. The explicit evidence manifest and
`verify-evidence.py` preserve source/log/raw integrity after temporary binaries
are removed. Replay is a consistency check, not a timing-accuracy guarantee.
Scoped source/docs/checker whitespace is clean. The full staged raw-artifact
check flags original test-log EOF blanks and patch-context whitespace; those
hashed bytes are preserved, with diagnostics retained separately.

Do not repeat the rejected region-index tradeoff or assume engine wins transfer.
The high-value retained lead is now concrete: static immutable marks can remove
a large measured Unicode deficit while preserving cell size, and immutable
widths can coexist with that gain in the combined replication. The next necessary
work is still **ASCII/region transport behavior and controlled all-metric
validation**, not another declaration of victory. No further throughput runs
were added after the fixed endpoint in this iteration.
