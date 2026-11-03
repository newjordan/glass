# Stack-backed splitter output pieces — not promoted

Starting source: f17bc98b660a12d920efae89f3a5d80bcdf56407.
Measured 2026-11-02 on shared Ryzen 9 9950X3D / RTX 3090, Linux/Hyprland.
Status: reported local research, not a universal performance conclusion.

## Hypothesis and isolated change

Every ordinary read creates a Vec<Piece> that typically holds one
borrowed text piece. The candidate generalized the splitter's four production
output signatures over an append-only PieceSink and supplied a four-element
SmallVec in the production session. More than four pieces spill to the heap;
recursive tmux unwrapping keeps its existing Vec and owned-text conversion.
The existing byte-step reference remained Vec-based. A direct smallvec
dependency was added at its already-pinned transitive version; Cargo.lock
changed only the glass-term direct dependency list. This candidate included
neither consumer coalescing nor lazy cuts.

## Method and provenance

Fresh control `/tmp/glass-i9-control`; candidate `/tmp/glass-i9-inline-pieces`.
Control includes the selected runtime source, but is a **fresh release build**,
not the exact historical selected executable `/tmp/glass-i9-selected`.
Do not merge those executable identities or cross-run medians.
Configured RUSTC is 1.99.0, ordinary release thin LTO / one codegen unit,
same lockfile versions and flags. Unchanged normal reader/parser affinity.
All runtime experiments were independent; no two candidates were combined.
No other Glass build or benchmark overlaps a throughput gate. Unrelated host
workloads were not stopped or isolated.

```
GLASS=/tmp/glass-i9-inline-pieces GLASS_ALT=/tmp/glass-i9-control \
  python3 bench/compare-tput.py bench/results/2026-11-02-inline-pieces --rounds 18
python3 bench/compare-tput.py bench/results/2026-11-02-inline-pieces --rounds 18 --summarize-only
```

18 rounds / 54 terminal sessions, all six candidate/control/Ghostty orders
three times. Unchanged historical tput.py bytes, fastest of three per workload,
154x39 geometry, timing ends at the DA1 reply (NOT visible frame or key latency).
terminal-summary.json retains executable/harness hashes, launch orders, raw
hashes and complete:true. terminal/ retains all raw JSON and launch logs.
replay.log records completed exact-hash replay. Candidate source snapshots and
patches are explicit research artifacts; they are not the installed runtime.

## Correctness

The pre-existing speed::splitter_bulk_matches_byte_steps test passed:
600 randomized streams with randomized read cuts and bounded-body fallback.
Its bulk output used SmallVec while the byte-step reference used Vec. This
checks pieces/state equivalence for the sampled streams, not whole-terminal
latency, all media behavior, or every allocation failure. The storage/API,
dependency, lockfile and temporary test edits were all restored afterward.

## Paired throughput

Median of **within-round** candidate/control ratios (not ratio of medians).
Sign p values are exploratory, two-sided, uncorrected for six metrics and
three experiments. Shared-host excursions remain included.

| workload | candidate/control | wins/18 | sign p | candidate/Ghostty | wins/18 |
|---|---:|---:|---:|---:|---:|
| ascii | 1.09482 | 10 | 0.814529 | 0.96808 | 8 |
| unicode | 0.98476 | 4 | 0.0308838 | 0.96200 | 7 |
| truecolor | 0.96775 | 5 | 0.0962524 | 1.13428 | 17 |
| cursor_motion | 0.97620 | 4 | 0.0308838 | 1.07651 | 16 |
| scroll_region | 0.99655 | 8 | 0.814529 | 0.98393 | 7 |
| tui_frames | 0.96957 | 1 | 0.000274658 | 1.02121 | 13 |

## Decision and limitations

Not promoted. No dependable joint ASCII/Unicode/scroll-region gain while
protecting the other metrics. This is a conservative release decision;
inconclusive ratios are not proof of universal regression or of no possible
allocation savings. Code-generation changes and host/pipeline scheduling can
move unaffected paths. No favorable subset or outlier-filtered replacement
score is used.

This run's exploratory ASCII +9.5% median won only 10/18 pairs, while TUI
lost 17/18 pairs (~3.0% median loss). Early escape-heavy positive ratios did
not survive the full gate. The raw control itself ranged 65.8–1132.6 MB/s
ASCII; candidate 62.9–1116.2. At least one control ASCII sample was 65.8 MB/s
with 0.45 s recorded terminal CPU, versus 1099.2 MB/s / 0.04 s in another
session. This is observable instability, not proof of any particular cause.

A lightweight one-second /proc observer was added partway through this gate
(after the first severe excursions), making it an explicit additional
measurement condition. placement-observations.jsonl has 176 snapshots.
All 25 sampled reader/parser observations per Glass arm kept allowed masks
0-7,16-23. Ghostty kept its original 0-31 mask. These sparse snapshots do
not continuously trace migrations, producer placement, blocked time or
coherence costs. The observer's overhead is not measured; no causal speed
claim is made from this run. It collected no environment or command lines.

Final-restored-tests.log: 7 passed, 0 failed after all runtime restoration.
restored-source.json compares source against starting commit;
selected-restored.sha256 plus cmp restore the exact historical executable.

## Next necessary evidence

Matched-input per-stage CPU/wall and scheduler/blocked-time traces on the
frozen control, without changing competitor placement, before retrying
session-loop or reader changes. Do not infer a championship from isolated
engine gains or a favorable run median.
