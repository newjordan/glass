# Mandatory campaign evidence review — iteration 45

**Reported, not championship acceptance.** No new runtime build, timing capture,
submission or deployment. Existing runtime sources and selected executable stay
unchanged. The mandatory review reconciles all claims from iterations 31–44.

## Verified results

- New audit exited **0** and reproduced stored-data analyses and negative results.
- Existing evidence-index tests: **6 passed**.
- Latest historical scope: 14 manifests / **1,819 references / 1,790 versions**.
- Separate iteration31 scope: 2 manifests / **136 references / 71 versions**.
- Their union: 16 manifests / **1,955 references / 1,861 versions**.
- All **9,017** pre-existing protected tracked paths are unchanged.
- Final index additionally freezes this review's explicit files.

### Findings not established by the preceding checkpoint

1. Iteration44's actual checker contains **14 record mutations and seven invalid
   coordinate shapes**, not its README's 18 and six. Five unittest methods pass.
   The new audit derives this inventory from the actual Python AST; historical
   evidence files are preserved, with the correction stated here and in the report.
2. Iteration44's verifier omits the `argv[0]` ↔ receipt executable-path binding.
   An **in-memory decoded-metadata** path-only mutation is accepted by that verifier
   but rejected by the new binding check. The real saved records pass the stricter
   check and the retained executables match their hashes. This is not a manifest
   bypass, wrong-execution allegation or runtime exploit.
3. The latest frozen index does not cover iteration31's separate evidence package.
   Both scopes and their union now replay explicitly. Reference counts are NOT
   test or independent-experiment counts.

## Actual competitive gap

Last selected-build series: 30 alternating rounds, 60 sessions. Own throughput
needed just to reach observed paired parity:

| workload | selected / Ghostty | own gain to observed parity |
|---|---:|---:|
| ASCII | 0.947116395 | +5.583644% |
| Unicode | 0.929112259 | +7.629621% |
| Truecolor | 1.181802248 | 0 |
| Cursor motion | 1.098724997 | 0 |
| Scroll region | 0.989284971 | +1.083108% |
| TUI frames | 1.062165424 | 0 |

Only truecolor, cursor motion and TUI have within-series Holm-corrected positive
leads. Reciprocals are point deltas, not confidence bounds or superiority margins.
No campaign-wide adaptive correction or independent serial signs are established.
Later source correctness fixes are not competitively measured in that executable.
Startup, resources, displayed key/frame latency, compatibility/platform scope and
an agreed acceptance command remain unresolved.

## Replay

From the repository root:

```sh
python3 -B bench/results/2026-11-03-campaign-audit-45/verify.py
```

Requires the retained exact test executables, selected binary and Ghostty binary.
This recomputes stored observations and validates frozen bytes, not a new Rust
suite or benchmark. `audit-first.stderr` retains the initial failed AST lookup;
failed-process copies and `setup-error-summary.json` retain previous setup/control
failures. No failed run is counted as candidate validation.

Full review: `reports/research-1eecf9876bb302e9da10ff629e71e6d8-45.txt`.
Next: a predeclared Unicode/ASCII candidate on exact PTY-exported workloads, then
same-build end-to-end and missing-metric gates if it survives. No world-title claim.
