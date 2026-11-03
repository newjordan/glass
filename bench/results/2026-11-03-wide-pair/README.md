# Safe wide-pair replacement: rejected fixed screen

Starting HEAD `0247d6d`. Status: reported local research, not championship acceptance.

## Intervention

Only the width-two store in `Watch::put_row` changes: obtain a safe mutable
`[Cell; 2]` view after the existing bounds/wide guards and assign the new wide
base and spacer as one array. Narrow stores, UTF8 decoding, width lookup, zero
marks, parser state, cursor/wrap/drained accounting and row metadata are unchanged.
The earlier no-op CellExtra COW fix is present identically in both arms.

The prospective protocol was written before builds and timing. It specified
stopping before timing if relocation-masked hot instructions were identical.
They differ: print_utf8 grows from **8524 bytes / 1967 instructions** to
**8678 bytes / 2034 instructions**. `apply` remains identical after masking.
These static facts are not dynamic cost or causal timing attribution.

## Exact arms and correctness

`build.py` uses non-fresh Cargo compiler receipts for glass/vte/terminal,
content-preserving source touches, opt_level=3, debug assertions disabled,
exact source hashes and copied executable hashes. Cell source is explicitly
included, so both arms bind the no-op COW fix. No selected terminal was replaced.

Both exact release executables passed:
- existing `speed::unicode_row_edges_preserve_pending_wrap` test;
- full suite: **395 passed, 14 ignored, no failures or filtered tests**;
- **12800 differential streams**, 64 seeds x 200 streams.

No new oracle test was added. These finite existing checks do not independently
prove all terminal/Unicode semantics or absence of shared-handler oracle defects.

## Fixed engine screen

Exactly 12 balanced alternating AB/BA blocks, 24 sequential sessions, scale 2,
five internal repetitions, 4095-byte reads, all six workloads. Internal passes
are not independent trials. No pilot, exclusion, rescue variant, extra timing,
pooled historical series, optional stopping or changed threshold.

Primary screen: Unicode paired CPU-rate median >=1.02, wins>losses, six-workload
Holm-adjusted two-sided sign p<.05; all six point medians >=.98. Point guards
are operational screens, not inferential noninferiority evidence.

| workload | paired CPU ratio candidate/control | wins/losses | Holm p |
|---|---:|---:|---:|
| ASCII | 0.902593 | 5/7 | 1 |
| Unicode | 0.978824 | 5/7 | 1 |
| truecolor | 0.952068 | 2/10 | .231445 |
| cursor motion | 0.960900 | 5/7 | 1 |
| scroll region | 0.959930 | 3/9 | .729980 |
| TUI frames | 0.935910 | 3/9 | .729980 |

**Reject and restore.** Unicode misses target and every point guard fails.
These observations do not establish a statistically proven universal slowdown.
The host is shared; unrelated CPU-heavy work was observed near the final pair.
No per-session contention trace or causal attribution is claimed. Launch-order
balancing does not establish independent signs or remove temporal drift. All
sessions remain retained and no retiming is used to rescue the candidate.

## Replay and restoration

Runtime engine source is restored exactly to the starting control, retaining
the separately committed no-op COW improvement. Selected terminal SHA256 remains
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.

```
python3 -B bench/results/2026-11-03-wide-pair/verify.py
python3 -B bench/replay-evidence-index.py bench/results/2026-11-03-wide-pair/final-frozen-index.json
```

The verifier reproduces analysis/codegen, checks arm source and executable
bindings, exact correctness logs, and historical replay, and rejects 13 decoded
metadata corruptions including wrong invocation path/hash, missing/extra
sessions, overlap, failed census, absent output, settings/protocol drift and
duplicate JSON keys. This sensitivity check does not bypass byte manifests.
Retained temporary exact binaries remain replay dependencies.

The actual Ghostty gap is unchanged. This engine screen is neither PTY timing,
displayed latency, startup/resource measurement nor championship acceptance.
