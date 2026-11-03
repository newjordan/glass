# Blank-slot witness experiment — rejected, shipping restored

Iteration 39, 2026-11-03. This is finite local correctness research, not a
Ghostty comparison, timing/memory measurement, benchmark acceptance, or a win.

The guarded physical-origin mapper from iteration 38 loses trimmed blank slots.
One narrowly scoped intervention rescues absent trailing blank origins on an
unwrapped old physical row using its own last surviving nonempty cell as witness.
It never falls back to global line-length matching, rescues content origins, or
borrows a witness from another row. `protocol.json` predates execution.

Three exact optimized test arms: shipping control, prior guarded physical mapper,
and witness extension (one runtime source differs). Every matrix includes both
parser lanes, active/inactive primary, six history capacities, real picture intake,
Unicode/combining glyphs, zero/two-cell gaps and repeated resize observations.
The oracle is the actual unique glyph and its original blank-slot offset, not
`Reflow::map_anchor` output. Earlier artifacts remain unchanged.

| Arm | Failed / 221,184 slot observations | Failed / 168,296 continuously in-bounds observations | Ghost pictures / 1,632 own-row deletion controls |
|---|---:|---:|---:|
| Shipping | 45,880 | 42,984 | 320 |
| Guarded physical | 32,224 | 29,496 | 0 |
| Witness | 10,584 | 7,856 | 0 |

The first column counts all surviving-glyph checkpoints; some prior steps have
lost an out-of-bounds slot. The independent stricter lens never asks a discarded
slot to resurrect: both glyph and expected slot must stay in bounds at every
prior step. Blank/cropped glyph observations are separately counted, not silently
called passes. These are correlated finite observations, not independent trials.
There are 6,912 deletion configurations total; 1,632 have own glyph gone and an
unrelated glyph still present. All configurations and exits are retained.

## New counterexamples

1. **Identity collapse**: picture after `M` at (0,3), or on next hard row at
   (1,0), on 4x10. Put cursor at (0,0); resize to 2x3. Both now have identical
   text and picture (1,0). On resizing to 4x10, the entire next `Reflow` (including
   exact destinations) is byte-for-byte equal. Both yield picture (1,0), but the
   first history's original marker-relative slot is (0,3). Equal mapper inputs
   cannot implement both distinct original-slot contracts. This characterizes
   lost identity; it does not implement persistent anchor state or prove that
   every broader stateful design fails. All intermediate equality assertions
   actually execute in `blank_witness_indistinguishable_histories`.
2. **Shipping ghost**: fill four 10-column rows; overwrite row 3 with `M`, clear
   its tail, attach picture at (3,1); put `W` on row 0, cursor at (0,0). Resize
   to 2x14 with history 0. `M` is gone, `W` survives. Active primary removes the
   picture (base 0); alternate-active primary incorrectly retains picture (1,1),
   base 2. Both parser lanes reproduce it. This complements, not repeats, the
   earlier coordinate-base characterization: visible stale content is observed.

The narrow width-only probe passes 6,144 observations; established MARK blank-slot
test now passes. Witness also passes 124,416 nonblank Unicode, 56,160 height-only
and 20,736 mixed nonblank observations. None override the blank-slot failures.
Default-history suite: witness 389 passed, 3 failed (shipping-defect expectations
that the repair changes), 19 ignored; physical 388/4/19; control 392/0/17. Actual
restored shipping sources pass **392 tests, 14 ignored**, and 12,800 differential
streams. All three experiment arms pass 12,800 streams each. No promotion.

## Honest setup failures

Two legacy test names and an initial sweep name were mistyped: exit 0 / zero
executed tests are retained as setup mistakes, never used as evidence. Corrected
exact filters run the real full matrices and sweep. A first whole-suite execution
with GLASS_SCROLLBACK=0 fails 23 tests whose assumptions require history; corrected
suites use 10000. Both failures are retained, not explained away as flakiness.
Verifier first used the wrong identity field (`binary_sha256` vs actual `sha256`),
then lacked exact candidate storage snapshot selection; raw failures and verifier
generations remain. One Python test's asserted mutation count was 21 instead of
20; its failure/source are also retained. No runtime or timing evidence was edited.

## Replay

```
python3 -B bench/results/2026-11-03-blank-witness/verify.py
python3 -B bench/results/2026-11-03-blank-witness/test-verify.py
python3 -B bench/replay-evidence-index.py bench/results/2026-11-03-blank-witness/final-frozen-index.json
```

The checker recomputes coordinates and booleans from raw records, requires unique
complete configuration sets, binds exact build/source/binary receipts and original
tracked content, replays prior frozen checks, and checks actual nonzero execution.
Five Python tests reject 36 evidence-record mutations, seven coordinate type/
shape violations and duplicate JSON keys. Hashes are local content consistency,
not independent truth, build attestation, or a security boundary.

Next prerequisite: define persistent logical-anchor identity/offset and its
own-line deletion lifetime, or explicitly revise the blank-slot contract. Do not
stack more stateless length-based fallback heuristics onto the physical map.

Historical replay detail: appending research notes invalidated the previous
checker’s live document seals. That failure is retained. The current checker
maps ONLY its three explicitly sealed old document names to their retained
pre-iteration snapshots; no runtime/raw-evidence lookup is redirected, and
current document bytes remain independently sealed. Final independent replay
covers 1,197 file references / 1,187 source versions in eight manifests. These
are byte-integrity checks, not measurement truth or external acceptance.
