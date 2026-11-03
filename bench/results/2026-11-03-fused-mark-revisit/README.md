# Fused combining-mark reuse revisited — reject corrected runtime

## Decision

**No runtime promotion.** After the independent split-UTF-8 accounting fix,
revisit the shelved safe fused-mark prototype. The first short-input oracles
pass but do **not** exercise fusion: their runs are below `RUN_MIN = 24`.
A new long-run oracle exposes an invalid `extra_free` row hint. Correct that
hint, pass the long oracle and both terminal suites, then reject the corrected
arm on the prospectively fixed 12-pair engine screen. Restore all three
production sources and retain the selected release executable unchanged.
There is no fresh PTY, Ghostty, memory, latency, launch, GPU, or championship
measurement here.

## New verifiable findings

1. The archived prototype can now pass the independent 3,816-case literal
   split/REP oracle after the unrelated parser repair. Those short examples,
   and the first 23,424-case redraw matrix, do not reach the 24-byte fast-run
   threshold. A large count is not branch coverage. The initial redraw
   oracle also compared Watch-owned scroll accounting against direct Term
   input, which cannot update it. Both setup failures are retained.
2. Repeating each string four times supplies at least 32 bytes and reaches
   `put_row`. The uncorrected arm reproduces `extra_free invalid fast=true
   alt=false cols=9`: a fresh/lazy row can receive combining-mark extras
   through the raw slice while its no-extras proof remains true. The literal
   semantic comparison alone does not detect this hidden row invariant.
   See `long-run-check/first-candidate.log` and `long-run-check/long-test.rs`.
3. Corrected prototype tracks `extra_written` per row run and calls
   `Row::note_extra_write()` after releasing the raw-slice borrow and before
   uniform-span bookkeeping. This conservatively invalidates the physical
   no-extras proof, including lazy stale tails. `occ_to` already advances
   before fusion's `continue`; it was not the defect. Safe Arc ownership,
   Cell layout, parser policy and reader code are unchanged. A singleton
   extra survives only with the same mark and no underline/link attributes;
   subsequent append COW preserves siblings and Weak witnesses.
4. The corrected long oracle passes **86,784 cases / 520,704 state
   comparisons per arm**. It checks all cells/history/cursor/template/mode
   against independent direct upstream `Term::input`, both parser lanes and
   screens, first/bottom rows, edge columns, narrow/wide bases, six marks,
   four pens, every byte split, three redraws, REP and explicit row no-extras
   invariants. This is bounded coverage, not proof for every Unicode scalar.
5. Corrected fusion is not a worthwhile performance candidate on the declared
   engine screen: Unicode median paired CPU rate **0.976300**, **1/12 wins**,
   two-sided sign p **0.00634765625**, six-workload Holm p **0.0380859375**
   (adverse direction). It misses both the 1.02 target and .98 point guard.
   Do not claim that reducing Arc traffic must improve throughput.

## Prospective measurement and all results

`protocol.json` freezes the first plan before runtime edits. The pre-timing
revision in `measured/protocol.json` explains the threshold/invariant correction;
no performance target, pairing count, workload or selection rule changes.
Exactly 12 alternating-order pairs; all six workloads; scale 1; best of five
per invocation; default read 4095; two hash-bound optimized test ELFs. Higher
ratios are faster, candidate/control.

| Workload | Median CPU ratio | wins/losses | Holm sign p |
| --- | ---: | ---: | ---: |
| ASCII | 0.993733 | 6/6 | 1.000000 |
| Unicode | 0.976300 | 1/11 | 0.038086 |
| Truecolor | 1.006671 | 8/4 | 1.000000 |
| Cursor motion | 1.009387 | 10/2 | 0.192871 |
| Scroll region | 0.993383 | 3/9 | 0.583984 |
| TUI frames | 1.000641 | 6/5 (one tie) | 1.000000 |

Sign-test assumptions are not established by alternating order. Best-of-five
invocations are not five independent observations. These are engine CPU rates,
not terminal MB/s, noninferiority proofs, isolated causal estimates or Ghostty
scores. All 24 invocations and parsed/raw rows are in `measured/raw.json`;
`analysis.json` is independently recomputed from them.

## Correctness, provenance, failure retention

Both measured arms: **397 terminal tests passed, 14 ignored**; 3,816 literal
split/REP cases and the 86,784-case long oracle pass. Candidate library:
**139 unit tests, 45 reference fixtures, one doctest** pass. The row method
and fused cell helper are confined to archived research sources. No runtime
or new unsafe ownership implementation ships.

- Root `run.log`: both short-oracle arms and candidate library pass, then
  argument parsing rejects unsupported `--read`; **zero timing invocations**.
- `corrected/long-oracle.log`: first metadata edit accidentally added the
  tracking flag without the invalidation call. Retained failure, not a pass.
- `corrected2/long-oracle.log`: repaired call passes the long oracle.
  `corrected2/run.log`: no-clobber guard refuses an old binary destination
  before building or timing. No binary overwrite or favorable-sample retry.
- `measured/run.py`: fresh destinations, same corrected runtime, full source
  census, non-fresh Cargo package receipts, retained compressed ELF per arm,
  log/binary/source hashes and `finally` restoration. This is the only timing
  attempt; all 12 prescribed pairs complete, with no rescue/pooling/retry.
- `verify.py` checks exact test censuses, source/binary bindings, all raw
  sessions, fixed pair count/order, independent analysis, source restoration
  and selected-executable hash. It replays the preceding checkpoint too.
- `test-verify.py` checks duplicate JSON keys and rejects 27 deliberate
  metadata/census/raw-timing corruptions, including rehashed misleading logs.

## Reproduce retained evidence (read-only)

```sh
D=bench/results/2026-11-03-fused-mark-revisit
python3 -B "$D/verify.py"
python3 -B "$D/test-verify.py"
python3 -B "$D/analyze.py"
```

`measured/run.py` is an exclusive source/Cargo-owner experimental runner, not
an ordinary read-only verifier. It uses no-clobber outputs: do not rerun it
in place or erase earlier receipts. New experiments require a fresh directory
and distinct executable names. The evidence manifest binds explicit retained
artifacts, not future directory scans; receipt replay does not reexecute Rust
or establish the truth of all measurement assumptions.

## Next necessary action

Do not escalate this arm. A future safe mark optimization needs a mechanism
that does not add decode/lookahead/guard overhead to every glyph, with tests
that force the optimized branch and inspect row metadata. The all-metric
Ghostty objective remains open; fresh exact-build competitive gates and the
missing non-throughput metrics are still necessary before any champion claim.
