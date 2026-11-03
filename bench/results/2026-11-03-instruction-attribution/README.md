# Exact-binary instruction attribution (iteration 25)

**Diagnostic only; no runtime promotion or championship result.** Reuses the
byte-exact iteration-24 control and rejected candidate. No Rust edit or rebuild.

- `protocol.json`: frozen before pilot/capture; one excluded pilot, exactly
  24 main sessions, three four-arm rotations per workload, scale 12/rounds 5.
- `starting-state.json`: binaries, selected executable, 120 Rust sources,
  6,182 earlier tracked result/report hashes.
- `run.py`: one-shot capture; creates new output directories, retains receipts
  and incomplete manifests on failure. Do not rerun into these frozen paths.
- `pilot/`, `main/`: raw logs, timer traces, per-run receipts and manifests.
- `analyze.py`: exact raw replay, ELF containing-symbol attribution, paired
  observer comparisons, conditional instruction hotspots. No score gate.
- `control/candidate.{elf,nm}` and `*-apply.asm`, `*-print_utf8.asm`: exact
  ELF dumps and disassembly, not reconstructed source-line claims.
- `crosscheck.py`: existing ELF reader vs saved/new tables; sampled `apply`
  and `print_utf8` addresses vs actual instruction starts.
- `evidence-sha256.json`, `frozen-index.json`: explicit own evidence closure.
- `verify.py`: read-only local integrity/replay checkpoint; no timing rerun.

Full findings and caveats:
`reports/research-1eecf9876bb302e9da10ff629e71e6d8-25.txt`.

The candidate truecolor CPU-rate ratio was below one in all three plain pairs
(median 0.915189). Exact machine code shows extra index spill/reload traffic in
its inlined CSI digit loop; sample hotspots include this region. This is a
causal hypothesis, not proof of stall cost. Unicode is mostly `print_utf8`
(73.80–75.61% of samples); its hottest IP is in the inlined UTF-8 leading-byte
dispatch, not the standalone width table. This does not rule out width work
inlined elsewhere or prove a future decoder optimization will win.

Requested 100us CPU timers delivered at roughly 1ms median spacing. Samples
cover setup, all rounds and teardown; they do not isolate the fastest reported
speed-test pass. Shared host, three pairs, timer aliasing and observer noise
preclude exact causal percentages or equivalence claims. No Ghostty launch.

Replay from workspace root (requires exact retained `/tmp/glass-i24-*-test`
executables and the selected `target/release/glass`, deliberately no fallback):

```sh
python3 -B bench/results/2026-11-03-instruction-attribution/verify.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-instruction-attribution/frozen-index.json
```

The prior checkpoint is itself rerun by `verify.py`; old evidence is not
rewritten. Exact binaries missing/changed means verification fails. Attribution
scripts are local research tools, not new production test-suite gates.
