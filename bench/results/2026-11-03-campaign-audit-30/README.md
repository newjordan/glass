# Mandatory iteration-30 evidence reconciliation

No runtime promotion, timing capture, build, submission or championship.

Read `../../../reports/research-1eecf9876bb302e9da10ff629e71e6d8-30.txt`
for the complete target/negative-result/provenance audit.

- `audit.py`: read-only replay using existing analyzers plus explicit independent
  scoreboard, parity arithmetic, temporal and rounded-pass sensitivity logic.
- `claims.json`: 15 reconciled historical claim groups (iterations 15–29).
- `target-contract.json`: unresolved acceptance requirements; not agreed criteria.
- `input-sha256.json`: explicit final inputs, no historical fallback.
- `audit-with-sensitivity.json`: FINAL expected audit output.
- `audit-initial.stderr`: retained first adapter failure, corrected in NEW code.
- `audit-second.json`, `audit.json`, `audit-expanded.json`: intermediate outputs;
  none replaces the final result or original historical evidence.
- `starting-state.json`: preservation baseline; does not adopt untracked work.
- `prior-*`: saved successful preceding read-only checkpoint/replay outputs.
- `verify.py`: final audit consistency + explicit frozen-file replay.

Run from the repository root (requires retained exact temporary executables):

```sh
python3 -B bench/results/2026-11-03-campaign-audit-30/verify.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-campaign-audit-30/frozen-index.json
```

No fallback rebuild. A missing historical executable is a dependency failure,
not permission to bind a fresh build to its old scores. Full Rust test counts
are historical receipts, not fresh test runs in this review. A green local
checkpoint is not a global campaign acceptance check.
