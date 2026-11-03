# Independent resize-witness transport and event authority (iteration 41)

Research only. Shipping runtime sources and selected release executable restored
byte-for-byte; no performance, memory, Ghostty superiority or campaign acceptance
claim. Starting commit: `d1263b9`.

## New measured result

Each of six history-capacity settings (0, 1, 2, 8, 32, 10000) executes the same
480 configurations: fast/slow parser x primary-active/inactive resize x five
marker rows x signed offsets 0/3/8/-8 x SU/SD/IL/DL/RI/LF. Real APC picture intake,
8-row grid, 10 -> 7 -> operation -> 10 columns. The alternate screen is entered
only around each resize, not around the primary scroll. These cases do not fill
history; six capacity settings are configuration coverage, not a history-lifetime
stress demonstration.

| Arm | failures / 480 per capacity | aggregate / 2,880 |
| --- | ---: | ---: |
| Previous persistent resize-only witness | 372 | 2,232 |
| Independent transport, picture-only motion authority | 24 | 144 |
| Independent transport + witness-aware authority | 0 | 0 |

The saved witness can be in a different row from the picture after reflow.
Transporting its absolute point independently and updating the signed offset by
`(picture_row_delta - witness_row_delta) * current_columns` removes most failures.
The residual 24 are exactly the negative-offset configurations whose picture is
above the affected band while the witness is inside it: row 1 with SU/SD/RI/LF,
and row 3 with IL/DL, in both lanes and resize modes. The engine suppresses these
scroll events when the store's exclusive motion endpoint covers only pictures.
Including each surviving primary placement's witness row in `motion_end` removes
the residual. This is a missing-authority signal, not a reflow arithmetic error.

A separate RIS reproduction shows zero placements but one saved witness entry in
the prior prototype (first lane aborts). Both corrected arms clear it and pass in
both lanes. This is retained prototype metadata, not evidence of a shipping leak.
Cleanup also follows `retain_showings`; not all mutation/deletion routes have
been audited, and split pictures do not yet propagate identity to new fragments.

## Independent oracles and provenance

`new-tests.rs` calculates physical marker and picture movement separately from
pre-scroll coordinates using literal band bounds. Expected final picture
coordinates use the actually scanned unique marker plus that independently
computed signed separation, not mapper output or observed picture movement.
The final tests additionally assert pre-resize picture geometry whenever its
witness survives. All three arms use the exact same final test source.

`verify.py` independently reconstructs all 480 expected records per log, validates
complete/unique configurations, integer coordinate shapes, marker survival,
physical picture movement, exact 24-case residual set, per-record flags, summaries
and nonzero test execution. It compares the oracle inputs/outputs across arms.
It binds test logs to binary identities, compiler receipts and explicit source
snapshots; all three packages must have non-fresh compiler artifacts.
`candidate.patch` describes the final research arm against shipping, not just
this iteration's two-file incremental change.

Six Python tests reject 24 record corruptions, seven malformed coordinate shapes,
duplicate JSON keys and an unknown arm. The first adversarial run exposed a
missing marker-survival check and an incorrect mutation literal; the failed test
source/log and corrected source/log are retained. Executable hashes are checked
when the original retained `/tmp` executables still exist; long-term replay uses
sealed source/compiler/run/log bytes and does not reconstruct or attest binaries.

## Regression evidence and limits

Final candidate, exact pre-existing matrix entries across six settings:

- 56,160 height-only, 20,736 mixed-resize and 124,416 Unicode observations: zero
  failures, checked by prior independent parsers.
- 1,632 eligible deleted-witness checks: zero failures.
- Broad blank-slot matrix still fails 560/400/424/448/448/448 cases per setting,
  unchanged from the prior arm; 168,296 continuously-in-bounds observations still
  have zero failures. These failures are retained, not removed from acceptance.
- Persistent identity/right-offset/wide roundtrip diagnostic passes (64 cases).
- Actual differential entry point: 12,800 streams pass in candidate and restored
  shipping (`64` seeds x `200` rounds).
- Candidate full suite: 389 pass, three shipping-defect characterization tests
  fail, 23 ignored. Exact failures match the prior candidate's three failures:
  inactive-primary height shrink, picture height growth, mixed resize roundtrip.
  This is not a clean candidate full-suite pass.
- Restored shipping full suite: 392 pass, 14 ignored. Selected `target/release/glass`
  and prior tracked evidence remain unchanged; only narrative notes are appended.

First build failed on a nonexistent `Fate::Pieces` variant and exposed an insertion
that missed the real `apply_moved` branch. Corrected build uses `Fate::Split`; both
failed compiler receipts and corrected sources are retained. Earlier commands
used nonexistent test filters (`aware-bound-*`, `aware-sweep.log`): zero-test logs
are retained and explicitly excluded from the final counts. `run-matrices.py`
records child exits and does not itself fail when a child fails; only exact
checker inventory and nonzero executed-test checks establish the reported result.
The prior process log for iteration 40 was empty; its retained source/checker and
new controlled runs, not that log, establish the stale-witness failure.

Not validated: arbitrary text writes/erasure, re-placement/deletion of dormant
witness state across all routes, multi-row fragment identity, alternate-picture
witnesses, all full-screen/history eviction behavior, unbounded offset precision,
performance, memory bounds or a head-to-head Ghostty metric. No promotion.

## Read-only reproduction

```sh
python3 -B bench/results/2026-11-03-scroll-witness/test-verify.py
python3 -B bench/results/2026-11-03-scroll-witness/verify.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-scroll-witness/final-frozen-index.json
```

The canonical checkpoint is deterministic; post-commit replay must match it.
The explicit frozen index extends the prior index without changing prior sources;
any historical document adaptation is pinned to the exact saved original bytes.
It verifies byte integrity, not accuracy, safety, authorship or championship status.
