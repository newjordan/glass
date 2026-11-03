# One opportunistic extra consumer hand-off — not promoted

Starting source: f17bc98b660a12d920efae89f3a5d80bcdf56407.
Measured 2026-11-02 on shared Ryzen 9 9950X3D / RTX 3090, Linux/Hyprland.
Status: reported local research, not a universal performance conclusion.

## Hypothesis and isolated change

The parser supplies a 64-KiB buffer, but ReadAhead returns at most one
16-KiB producer hand-off. The candidate appended at most one already-queued
hand-off with try_recv, preserving immediate credit recycling and retaining
any uncopied second tail. It did not wait, change producer chunk size, add
producer credits, alter affinity, or change parser logic. This isolates
amortization of per-read session work from prior producer-side experiments.

## Method and provenance

Fresh control `/tmp/glass-i9-control`; candidate `/tmp/glass-i9-coalesce`.
Control includes the selected runtime source, but is a **fresh release build**,
not the exact historical selected executable `/tmp/glass-i9-selected`.
Do not merge those executable identities or cross-run medians.
Configured RUSTC is 1.99.0, ordinary release thin LTO / one codegen unit,
same lockfile versions and flags. Unchanged normal reader/parser affinity.
All runtime experiments were independent; no two candidates were combined.
No other Glass build or benchmark overlaps a throughput gate. Unrelated host
workloads were not stopped or isolated.

```
GLASS=/tmp/glass-i9-coalesce GLASS_ALT=/tmp/glass-i9-control \
  python3 bench/compare-tput.py bench/results/2026-11-02-consumer-coalesce --rounds 18
python3 bench/compare-tput.py bench/results/2026-11-02-consumer-coalesce --rounds 18 --summarize-only
```

18 rounds / 54 terminal sessions, all six candidate/control/Ghostty orders
three times. Unchanged historical tput.py bytes, fastest of three per workload,
154x39 geometry, timing ends at the DA1 reply (NOT visible frame or key latency).
terminal-summary.json retains executable/harness hashes, launch orders, raw
hashes and complete:true. terminal/ retains all raw JSON and launch logs.
replay.log records completed exact-hash replay. Candidate source snapshots and
patches are explicit research artifacts; they are not the installed runtime.

## Correctness

Six reader tests passed before the gate. Three were candidate-specific
coalescing/credit/order cases, in addition to existing byte-order, partial
credit and final-readable-byte HUP regressions. Only the generic queued-byte
and exactly-once-credit test survives in the final source; candidate-only
coalescing expectations remain in read_ahead.candidate.rs.

## Paired throughput

Median of **within-round** candidate/control ratios (not ratio of medians).
Sign p values are exploratory, two-sided, uncorrected for six metrics and
three experiments. Shared-host excursions remain included.

| workload | candidate/control | wins/18 | sign p | candidate/Ghostty | wins/18 |
|---|---:|---:|---:|---:|---:|
| ascii | 0.94329 | 6 | 0.237885 | 0.90116 | 5 |
| unicode | 0.98514 | 5 | 0.0962524 | 0.96376 | 7 |
| truecolor | 1.00127 | 10 | 0.814529 | 1.16090 | 13 |
| cursor_motion | 0.99564 | 9 | 1 | 1.10417 | 10 |
| scroll_region | 1.00617 | 10 | 0.814529 | 0.82242 | 6 |
| tui_frames | 0.99981 | 9 | 1 | 0.92327 | 8 |

## Decision and limitations

Not promoted. No dependable joint ASCII/Unicode/scroll-region gain while
protecting the other metrics. This is a conservative release decision;
inconclusive ratios are not proof of universal regression or of no possible
allocation savings. Code-generation changes and host/pipeline scheduling can
move unaffected paths. No favorable subset or outlier-filtered replacement
score is used.

Separate quiet DA1 RTT guard: six alternating AB/BA sessions per arm, 300
samples/session, after throughput; 0.065275 ms candidate versus
0.065911 ms control (median of run medians).
Pooled p99: 1.249150/1.208864 ms. Paired run-median
deltas have three signs each. Large session variation: no dependable latency
benefit established. Samples within sessions are correlated, not 1800
independent experiments. Raw samples, hashes and replies retained in rtt/.

## Next necessary evidence

Matched-input per-stage CPU/wall and scheduler/blocked-time traces on the
frozen control, without changing competitor placement, before retrying
session-loop or reader changes. Do not infer a championship from isolated
engine gains or a favorable run median.
