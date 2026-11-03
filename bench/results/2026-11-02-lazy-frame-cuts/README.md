# Lazy synchronized-frame cut iteration — not promoted

Starting source: f17bc98b660a12d920efae89f3a5d80bcdf56407.
Measured 2026-11-02 on shared Ryzen 9 9950X3D / RTX 3090, Linux/Hyprland.
Status: reported local research, not a universal performance conclusion.

## Hypothesis and isolated change

frame_cuts built a Vec, and the session appended n even when no frame
start existed. Thus ordinary reads incurred a boundary-vector allocation.
The candidate yielded the same cuts lazily using successors, then chained
once(n), preserving first-byte exclusion and complete-escape recognition.
No read-size, parser, splitter or affinity change. This candidate did not
include consumer coalescing.

## Method and provenance

Fresh control `/tmp/glass-i9-control`; candidate `/tmp/glass-i9-lazy-cuts`.
Control includes the selected runtime source, but is a **fresh release build**,
not the exact historical selected executable `/tmp/glass-i9-selected`.
Do not merge those executable identities or cross-run medians.
Configured RUSTC is 1.99.0, ordinary release thin LTO / one codegen unit,
same lockfile versions and flags. Unchanged normal reader/parser affinity.
All runtime experiments were independent; no two candidates were combined.
No other Glass build or benchmark overlaps a throughput gate. Unrelated host
workloads were not stopped or isolated.

```
GLASS=/tmp/glass-i9-lazy-cuts GLASS_ALT=/tmp/glass-i9-control \
  python3 bench/compare-tput.py bench/results/2026-11-02-lazy-frame-cuts --rounds 18
python3 bench/compare-tput.py bench/results/2026-11-02-lazy-frame-cuts --rounds 18 --summarize-only
```

18 rounds / 54 terminal sessions, all six candidate/control/Ghostty orders
three times. Unchanged historical tput.py bytes, fastest of three per workload,
154x39 geometry, timing ends at the DA1 reply (NOT visible frame or key latency).
terminal-summary.json retains executable/harness hashes, launch orders, raw
hashes and complete:true. terminal/ retains all raw JSON and launch logs.
replay.log records completed exact-hash replay. Candidate source snapshots and
patches are explicit research artifacts; they are not the installed runtime.

## Correctness

Seven targeted reader/frame-gate tests passed before the gate.
The random frame-escape test also compared every cut with a direct scan.
The final restored-source verifier reran these seven with stronger explicit
empty, adjacent-frame and first-byte cases. No lazy-iterator runtime remains.

## Paired throughput

Median of **within-round** candidate/control ratios (not ratio of medians).
Sign p values are exploratory, two-sided, uncorrected for six metrics and
three experiments. Shared-host excursions remain included.

| workload | candidate/control | wins/18 | sign p | candidate/Ghostty | wins/18 |
|---|---:|---:|---:|---:|---:|
| ascii | 1.02092 | 10 | 0.814529 | 0.90152 | 6 |
| unicode | 0.99437 | 7 | 0.480682 | 0.94097 | 5 |
| truecolor | 0.98241 | 5 | 0.0962524 | 1.15141 | 15 |
| cursor_motion | 1.00549 | 12 | 0.237885 | 1.11594 | 13 |
| scroll_region | 1.00685 | 10 | 0.814529 | 0.98691 | 8 |
| tui_frames | 0.98641 | 6 | 0.237885 | 1.03736 | 13 |

## Decision and limitations

Not promoted. No dependable joint ASCII/Unicode/scroll-region gain while
protecting the other metrics. This is a conservative release decision;
inconclusive ratios are not proof of universal regression or of no possible
allocation savings. Code-generation changes and host/pipeline scheduling can
move unaffected paths. No favorable subset or outlier-filtered replacement
score is used.

## Next necessary evidence

Matched-input per-stage CPU/wall and scheduler/blocked-time traces on the
frozen control, without changing competitor placement, before retrying
session-loop or reader changes. Do not infer a championship from isolated
engine gains or a favorable run median.
