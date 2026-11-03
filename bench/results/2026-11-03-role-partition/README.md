# Whole-core role masks and exact-build competitor refresh

**Research checkpoint, not a runtime promotion or championship.**

New question: can disjoint **whole physical-core masks** inside the large L3
retain singleton-pin ASCII gains while preserving scheduler flexibility?
`protocol.json` freezes 30 blocks, five arms, benefit/noninferiority margins,
randomized position-balanced orders and pre-block load admission. It is distinct
from iteration 18's fixed singleton pins and observer/contention experiments.

The 150-session confirmatory series fails the primary gate. Its split/auto
ASCII median is 1.053058, but its simultaneous one-sided lower bound is .924927,
not above 1.05. Unicode and scroll-region guards also fail. This rejects
promotion, **not** the data, zero-effect null, or a future different policy.
Split/shared-half ASCII is .998076: no demonstrated role-separation benefit.
Do not rescue the primary with a favorable secondary contrast or more rounds.

- `pilot/`: five plumbing sessions, excluded from inference.
- `confirmatory/`: 30 blocks × five arms, all sessions retained.
- `*-replay.json`: independent stored-output replay, no report rewriting.
- `protocol.json`: full design, estimands, bounds and limitations.
- `competitor-protocol.json`, `shipping-vs-ghostty/`, `competitor-summary.json`:
  separately frozen comparison of the **unchanged shipping executable**; no
  role wrapper, no candidate, no pooling with historical series. Its 60 sessions
  establish three corrected throughput leads, but Unicode remains slower in
  27/30 rounds (median .929112, six-workload Holm p=.000025291); ASCII and
  scroll superiority remain unestablished.
- `source-snapshots/`: exact harness copies; captured source hashes remain
  binding. Snapshots are retained bytes, not silent fallback paths.
- `check-corruption.py`: 15 rejections plus one deliberately reported non-target
  transition positive control in disposable copies; original files unchanged.
- `signal-cleanup.py`: real own-parent mask changes restored for TERM/HUP/INT
  and injected second-pin failure; these four cases are NOT timing sessions.
- `recompute-primary.py`: separate raw median/ninth-order calculation.
- `verify.py`: full read-only local checkpoint. Runtime bytes, all 120 Rust
  sources and the prior 660 files must remain unchanged.

## Repeat checks without capture/build/repair

From the workspace root, while exact binaries and harnesses are retained:

```sh
python3 -B bench/results/2026-11-03-role-partition/verify.py
python3 -B bench/linux/analyze-role-partition.py \
  bench/results/2026-11-03-role-partition/confirmatory \
  --expect bench/results/2026-11-03-role-partition/confirmatory-replay.json
python3 -B bench/results/2026-11-03-role-partition/summarize-competitor.py
python3 -B -m unittest discover -s bench -p 'test_*.py' -v
```

Byte-integrity-only replay (no temporary executable dependency):

```sh
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-role-partition/frozen-index.json
```

Do not redirect output into frozen artifacts. Run fresh benchmark captures only
into new directories and never concurrently with another benchmark. The cleanup
smoke script intentionally requires its fresh output directory, and will refuse
reuse. The complete report, table, limitations, setup failures and next blocker
are in `reports/research-1eecf9876bb302e9da10ff629e71e6d8-19.txt`.
