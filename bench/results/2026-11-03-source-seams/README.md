# Source-seam identity during partial-region scrolling — iteration 43

## New finding and production change

`motion::scroll_rect` merged two retained picture slices whenever their output
rectangles touched. A partial-region scroll can close a gap left by discarded
**source** rows: screen adjacency is not source-image adjacency. The merge then
summed source heights as if the discarded interval still existed, displaying a
deleted source row and losing a surviving one. This is distinct from fragment
identifier aliasing fixed in iteration 42 and from the research-only resize
witness problems.

The production change in `crates/term/src/intake/motion.rs` tracks the end of the
last emitted original-coordinate slice and requires that it equal the next
slice's start before merging. It advances on push/merge, not on a discarded
slice. Empty and all-discarded cases retain the old behavior. The existing
screen-adjacency requirement remains necessary. No fuzzy source-coordinate
comparison, blanket fragmentation, engine event change, or new retained runtime
state is introduced.

## Concrete independent witness

A picture starting at row 0 with height 4, scrolled up one row in half-open band
`[2,7)`, should show original rows 0, 1, 3 at screen rows 0, 1, 2. Control instead
shows original rows 0, 1, 2. The final physical row is right but its source pixels
are wrong. The control test really exits 101; it is not an expected-pass test
and no assertion or expected value is weakened for the candidate.

## Reproduction and bounded scope

The new production regression is
`intake::position_tests::source_seams_real_apc_row_oracle`. It creates real APC
RGB pictures through Engine/Intake, then issues real CSI SU/SD in a partial
scroll region. It compares frame rectangles, expanded into per-cell source
strips, against independent transport of the original rows, not against
`scroll_rect`, `cut_rows`, or `merge`.

The Cartesian matrix has 1,536 cases:

- both parser lanes and primary/alternate screens;
- a full 1x1 image and an explicit subrectangle of a 2x4 image;
- original start rows 0/2/4/6, heights 2/4/6/8;
- half-open bands `[2,7)` and `[4,9)`;
- scroll amounts 1/2/3, upward and downward.

| Measurement | Control | Candidate |
| --- | ---: | ---: |
| Source-row matrix failures | 384 / 1,536 | 0 / 1,536 |
| Upward failures | 144 | 0 |
| Downward failures | 240 | 0 |
| Differential streams | 12,800 pass | 12,800 pass |

Failures are evenly split across parser lanes, screens and full/cropped image
arms (192 per value of each flag). The full candidate suite passes **394 tests,
14 ignored**, including the earlier identity/local-fragment-deletion regression.
The selected `target/release/glass` executable is unchanged; this is a tested
production-source fix, not a rebuilt or timed release application.

## Evidence, commands and exact identities

`starting-state.json` pins starting HEAD `28b8e4e`, runtime-source snapshots and
the selected executable. `build-control/` and `build-candidate/` retain optimized
Cargo test receipts with non-fresh glass/vte/alacritty_terminal artifacts and
input hashes. `run.py` reruns five explicit commands and captures actual exits,
environment, exact binary hashes and log hashes in `runs.json`.

The control and candidate contain identical new test source; their sole runtime
source difference is the seven-line merge guard in `patch.diff`. Unrelated
runtime sources are checked against their originals. The snapshots bind each
build, including the test source, independently of later Cargo artifacts.

Replay without compiling or rerunning the engine:

```sh
python3 -B bench/results/2026-11-03-source-seams/verify.py
python3 -B bench/results/2026-11-03-source-seams/test-verify.py
python3 -B bench/replay-evidence-index.py bench/results/2026-11-03-source-seams/final-frozen-index.json
```

The six Python evidence tests pass, including rejection of 20 record
corruptions, seven invalid configurations, seven malformed coordinate forms,
duplicate/missing records, false summaries/zero-test receipts, duplicate JSON
keys and an unknown arm. One corruption changes both expected and observed
source rows together; the separately computed oracle still rejects it.
These tests validate the evidence checker, not an additional rendering sample.

`evidence-sha256.json` freezes the exact sources, builds, five run receipts and
logs used by the first checkpoint. `prior-frozen-index.json` keeps earlier
reports bound to exact historical snapshots without modifying those reports;
its 12-manifest replay matches 1,688 file references / 1,669 source versions.
The final index adds this iteration's explicit inventories. Saved checkpoint
outputs and final replay counts are the authority for the later freeze.

## Limits and next necessary work

Finite integer-height APC source-row evidence does not establish fractional or
partially clipped geometry, in-cell coverage-mask transport (sixel/OSC 1337),
all scroll operations, all sequences of repeated scrolling, or general resize
correctness. `apply_moved` still derives a coverage top cut from physical line
difference, not source provenance; whether moved/cropped in-cell masks stay
attached to their original source cells needs a separate independent oracle.
That lead is **unverified**, not another defect claim.

The previously documented research-only resize-witness lifetime/authority
failures remain unresolved. No throughput, startup, memory, GPU, latency,
Ghostty comparison, championship result, or campaign acceptance was measured.
A local model review agreed with the narrow loop invariant; it is advisory,
not an independent execution or promotion gate. No Labyrinth map is initialized
in this workspace, so the explicit finite experiment and receipts are used.
