# Persistent own-content resize witness — 2026-11-03, iteration 40

**Research result, not a shipping fix or championship claim.** Runtime sources,
original tests, and selected shipping executable are restored unchanged.

## New result

Persisting anchor state distinguishes two histories that the preceding stateless
mapper provably collapsed. The tail picture and a picture on the next empty hard
line both become `(1,0)` at 2x3 with identical text. The prototype retains
`Witness { line: 0, column: 0, delta: 3 }` for the former and explicit `Physical`
mode for the latter. At 4x10 they return to `(0,3)` and `(1,0)` respectively;
neither is removed. Two cycles, both parser lanes, and active/inactive primary
resizing pass. Separate negative-offset/right-witness and full-width-glyph cases
bring the independently checked roundtrip inventory to **64 observations**.

The original blank-slot matrix is unchanged, including its failing assertion.
Across capacities 0, 1, 2, 8, 32, and 10000:

| Retained arm | Full slot failures / 221,184 | Failures / 168,296 continuously in-bounds slots | Eligible deleted-witness failures / 1,632 |
|---|---:|---:|---:|
| Shipping control, prior retained evidence | 45,880 | 42,984 | 320 |
| Physical-only map, prior retained evidence | 32,224 | 29,496 | 0 |
| Stateless blank rescue, prior retained evidence | 10,584 | 7,856 | 0 |
| Persistent own-content witness, new bound run | **2,728** | **0** | **0** |

These are finite correctness observations, not independent random samples. The
continuous lens is the **unchanged lens in the prior checker**, not a new
post-hoc definition. Full matrix failure remains visible: all six slot test
processes exit 101. `baseline-summary.json` derives the prior totals by replay,
not by claiming another execution of the historical arms.

Other unchanged desired-invariant matrices in the new source-bound executable:

- Height-only: **56,160 observations, zero failures**.
- Mixed resize: **20,736 observations, zero failures**.
- Unicode markers: **124,416 observations, zero failures**.
- Deleted-witness matrix: 6,912 total, **1,632 eligible, zero failures**.
- Differential streams: **12,800**, 64 seeds, 200 streams/seed, no divergence.

## Mechanism and limits

The shadow grid transports only physical cell origins; the previous stateless
blank-rescue block is removed. Before the first resize, the engine supplies
printable non-whitespace, non-wide-spacer glyph positions. Intake chooses the
nearest such cell in the picture's old wrap chain, ties to the earlier cell,
and stores that cell's position and the picture's signed flat-cell offset.
Each resize maps the **saved** witness, not a new witness chosen from the
collapsed picture coordinate. Contentless lines retain explicit physical-only
mode and never silently reacquire. Deletion is per placement sequence rather
than shared picture key. Replacement invalidates the existing sequence's state.

This is deliberately **resize-only research**. It is not a full logical-cell
identity system, and it allocates and resizes a shadow grid. Intervening writes,
scrolls, reset, eviction and all placement lifecycle transitions are not fully
integrated. No performance claims or speed comparisons were made.

## Concrete promotion blockers

1. **Lifetime contract after leaving retained space.** All 2,728 full-slot
   failures are outside the continuously-in-bounds lens. An exact retained
   example is `lifetime-counterexample.txt`: at capacity zero a derived offset
   is out of bounds on step 0, so the prototype deletes its picture. The marker
   survives. Widening on step 1 brings the logical slot `(1,3)` back in bounds,
   but the picture cannot return. A dormant anchor would differ from permanent
   deletion. This is not a failure-free full-slot implementation.
2. **Stale state after terminal movement.** A real band scroll between resizes
   moves marker `M` from row 2 to row 1. The stale witness leaves the picture at
   `(2,3)` rather than `(1,3)` in **both parser lanes**. The characterization
   passes by requiring this known counterexample, not by asserting a fix.
   Shipping must not gain this prototype cache without movement and lifecycle
   integration.
3. The candidate suite reports **389 passed, three failed, 21 ignored**. All
   three failures are existing tests that assert reproduction of old resize
   defects; their assertions are not edited to manufacture a green suite.
   Normal-restored suite: **392 passed, 14 ignored**. This distinction is checked.

## Evidence integrity and reproduction

`build.py` extends the canonical content-preserving, nonfresh Cargo receipt
recipe to bind all 13 experimental source files, including stateful intake.
`build-candidate-bound/identity.json`, `cargo.jsonl`, and exact final source
snapshots bind the new final executable; it reruns the entire inventory.
Earlier v1–v4 runs are exploratory evidence, not substituted for that final run.
All runtime sources are restored byte-for-byte; 8,498 pre-existing tracked
files retain their Git blob identities. Selected executable SHA-256 remains
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.

Read-only verification, no candidate installation required:

```sh
python3 -B bench/results/2026-11-03-persistent-witness/verify.py
python3 -B bench/results/2026-11-03-persistent-witness/test-verify.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-persistent-witness/final-frozen-index.json
```

`run.py` preserves exact commands, environment, logs and actual exits. No empty
filter is accepted as a sweep. The seven checker tests reject **54 record
corruptions**, seven invalid coordinate shapes, and duplicate JSON keys.
First checker-test failures are retained: two mutations originally targeted
**ineligible** deletion records; correcting the tests to target eligible
records avoids a false rejection claim. Initial roundtrip test failures also
remain: their screen-row oracle incorrectly assumed width roundtrips could not
move text into history. Final right/wide oracles scan the unique text marker and
apply the known signed offset, independently of Reflow and the picture result;
the Python checker additionally fixes all 64 destinations explicitly.

Next necessary experiment: carry witness identity through actual movement and
lifecycle events and separately choose/test a dormant-versus-dead attachment
policy. Neither shipping promotion nor superiority over Ghostty is established
by this research checkpoint.
