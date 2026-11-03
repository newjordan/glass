# Exclusive-column row-lane diagnostic (iteration 20)

**Rejected optimization; only the boundary regression is kept.** No new
Ghostty session, runtime policy, terminal executable or championship claim.

[Full report](../../../reports/research-1eecf9876bb302e9da10ff629e71e6d8-20.txt).
`protocol.json` was frozen before both builds and the candidate source edit.
Fresh same-profile control/candidate release tests, 11 alternating pairs,
scale 2, fastest of five internal repetitions. All six engine workloads.

| Workload | Paired candidate/control CPU-throughput | Wins / 11 | Holm p (six) |
|---|---:|---:|---:|
| ASCII | 0.989569 | 1 | .070313 |
| Unicode | 0.979261 | 3 | 1 |
| Truecolor | 1.000625 | 6 | 1 |
| Cursor motion | 0.994981 | 3 | 1 |
| Scroll region | 0.999534 | 5 | 1 |
| TUI frames | 0.999354 | 4 | 1 |

The change uses a one-past-end cursor inside `put_row`, normalizing once on
exit instead of clamping/setting wrap per glyph. Unicode failed the frozen
>=1.02 benefit criterion and the .98 point-regression guard. Production source
was restored; no conditional real-PTY gate or rescue series ran. These point
estimates are not effect/equivalence proofs. Alternation does not establish iid
signs. Same-host code layout, load and fastest-of-N effects remain limitations.

Retained `speed::unicode_row_edges_preserve_pending_wrap` compares fast/parser
cells, cursor, replies, history and alternate state across widths, read cuts,
wide/combining marks, REP, modes and invalid UTF-8. It passes on both measured
executables. Deliberately clearing pending wrap builds, then fails with a cell
difference at 39x154/chunk 155; mutant source/binary hash/failure are preserved.
Its EXIT trap restored production source. Only this appended test remains.

- 380 terminal tests pass, 11 ignored; 12,800 parser differential streams pass.
- 49 existing Python tests pass; nine actual-report mutations are rejected.
- All 5,826 tracked prior result/report files and 119 other Rust files match
  starting hashes. Exact selected terminal executable remains unchanged.
- 535 prior frozen file references replay with one explicit historical mapping
  of the legitimately evolved `speed.rs` to `control-speed.rs`. No old manifest
  or source was rewritten. The old unmapped replay's strict rejection remains
  explainable; use the new explicit index, never ignore its mismatch.

Read-only local checkpoint (needs exact retained `/tmp/glass-i20-*-test` files):

```sh
D=bench/results/2026-11-03-exclusive-column
python3 -B "$D/verify.py"
python3 -B "$D/analyze.py"
python3 -B "$D/check-corruption.py"
python3 -B bench/replay-evidence-index.py "$D/prior-frozen-index.json"
python3 -B bench/replay-evidence-index.py "$D/frozen-index.json"
```

`verify.py` re-executes correctness and mutant failure, recomputes decisions and
checks hashes without repair or timing recapture. It fails closed on changed
or missing measured binaries. `checkpoint-initial.json` predates the self-
excluding final evidence manifest; final replay validates that manifest too.

The first verifier command erroneously requested `--lib` for a binary-only
package; `candidate-parser.log` preserves that pre-compilation error. The
corrected existing cargo test entry point and final restored cargo entry point
both pass. A different executable rebuilt later is not the measured original.
