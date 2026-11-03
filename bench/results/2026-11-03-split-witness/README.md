# Split fragments: witness inheritance and an isolated production fix

2026-11-03, loop iteration 42. This is a finite correctness result, not competitive acceptance.

## New results

1. A real APC multi-row picture, width 10 -> 7, SD inside a partial band, then width 7 -> 10 reproduces missing witness inheritance in the previous research arm. The existing first fragment returns to `(line=1,column=8)`; the born fragment remains `(5,1)` instead of `(3,9)`.
2. Research repair clones the transported anchor, adds each fragment's physical row displacement in the old width, assigns a fresh internal identity, and starts every fragment from the unsliced placement. **1,680 observations**, active/inactive primary and both parser lanes, pass. Four repeated-split/local-death cases also pass.
3. Two independently isolated **shipping bugs**, without any resize prototype: successive splits of the same placement generate identical internal identities (`[3,1048579,1048579]`); physical removal of one anonymous fragment removes every sibling because it uses the shared showing key. Real picture intake and two successive region scrolls reproduce both in both parser lanes.
4. A minimal production patch allocates fragments with `Intake::bump()` and removes vanished physical fragments by `seq`, not dialect/image/placement key. Existing parent cleanup still receives showing keys. It clones the original placement only on `Fate::Split`, preserving coverage/crop provenance without adding a clone to ordinary movement.
5. Shipping control: **4/4 fail**. Production: **4/4 pass**, exact source partitions preserved, next placement ID exceeds all fragment IDs, local death preserves siblings, image-wide APC deletion still removes all fragments. Final production regression suite: **393 passed, 0 failed, 14 ignored**.

## Independent expectations

Tests use Engine, Splitter/session pump and APC graphics bytes. They do not invoke a mapping helper to calculate expected positions. For the resize matrix the marker lies outside the scroll band and never moves. At width 7, a born fragment is displaced by `7*(above+down)` cells; its original flat position is `10+picture_column`. Divide by 10 for the return location. Source partitions are `[0,0,1,above/height]` and `[0,above/height,1,(height-above)/height]`.

Matrix domain: 2 parser lanes x 2 primary active states x 5 marker columns x 2 picture columns x sum(height-1 for height in [3,4,5,6]) x 3 SD amounts = 1,680. No history fill; history capacity is explicitly 10,000. Rows are 24. Width transition is 10 -> 7 -> 10. Pictures are one cell wide, 3..6 cells high. Repeated split cases are an 8-row picture at width 7, with two SD bands and optional SU deletion of only its first fragment. The shipping-only regression uses that physical geometry directly without resizing or any witness metadata.

## Exact scope and source status

**Promoted source:** only `crates/term/src/intake/mod.rs` physical split handling and a regression in `position_tests.rs`. See `production.patch`. Other runtime bytes match `starting-state.json`.

**Not promoted:** persistent resize witnesses, event authority changes, origin snapshots and the 1,680-case prototype. Their exact source bytes are `candidate-final-*.rs`; `candidate-sources.json` seals their hashes. Runtime snapshot originals and final production sources are retained separately. The selected `target/release/glass` executable is unchanged; this iteration compiled release test executables, not a new user-facing release.

No timing, memory, arbitrary-write lifetime, eviction, arbitrary widths, fractional coordinates, relative-parent split semantics or competitive Ghostty metrics are established. Existing resize defects remain open. There is no bound acceptance command and no campaign-complete claim.

## Evidence and replay

- `build-*/identity.json`, `cargo.jsonl`, `cargo.log`: all attempted builds, including compiler failures. Three successful arms are checked for non-fresh `glass`, `vte`, and `alacritty_terminal` compilation and exact snapshot hashes.
- `runs.json` and `*-measured.log`: executed commands/environment, actual exits (control 101; repaired production/prototype 0), binary hashes and log hashes.
- `production-regressions.log`: final production full suite including four JSON observations.
- `stale-roundtrip*.log`: earlier failing experiments. First build used a nonexistent test API; the first runnable geometry setup left the cursor below the intended band, corrected by explicit home. Both are excluded from the asserted results. First local-cleanup build had a tuple-vs-seq type error; retained and excluded.
- `verify.py`: strict byte inventory, source/compiler/run bindings, independent geometry, complete configurations, source partitioning and suite counts. Binary hashes checked if original `/tmp` binaries exist; durable replay checks recorded source/compiler/log bytes, not binary attestation.
- `test-verify.py`: five tests; rejects 16 record mutations, nine malformed coordinate sets, missing/extra records, wrong summary, duplicate JSON keys and 11 matrix corruptions. A fourth unused variant is not counted as a rejection.
- Prior 11-manifest archive: **1,577 references / 1,564 source versions** match through explicit snapshots, with no prior tracked file edits. Current frozen index appends this iteration and preserves prior mappings.

Run:

```sh
python3 -B bench/results/2026-11-03-split-witness/verify.py
python3 -B bench/results/2026-11-03-split-witness/test-verify.py
python3 -B bench/replay-evidence-index.py bench/results/2026-11-03-split-witness/final-frozen-index.json
```

The manifest is an integrity inventory. It is not independent verification, a timing measurement, or championship acceptance.
