# Same-L3 reciprocal hot-thread placement (iteration 18)

**Reported research; no runtime promotion, no world-title claim.**
Full result: [`../../../reports/research-1eecf9876bb302e9da10ff629e71e6d8-18.txt`](../../../reports/research-1eecf9876bb302e9da10ff629e71e6d8-18.txt).

Exact selected binary `d75cb26f…` and all 120 Rust sources unchanged. Reader
and parser were assigned to two SMT sibling pairs or reciprocal distinct-core
pairs within the same 96-MiB L3. Shipping masks are the `auto` baseline.
Unchanged `tput.py`, producer unpinned, no samplers/pass hooks. Boundary
snapshots and artificial pins mean this is **not** an ordinary terminal score.

## Findings

- Five-session pilot and two fresh 100-session v2 series replay successfully.
  The **additional initial 100 sessions are rejected**, preserved, and not pooled.
- First v2 primary distinct/sibling family: **no corrected rejection**.
  Replication: Unicode/truecolor/TUI reject within that primary family only.
  No uniformly replicated primary-family superiority is established.
- Secondary distinct/auto ASCII ratios **1.32602** and **1.30988**, 17/3 round
  wins/losses in each, six-workload-family Holm p=.015461 in each. This is a
  promising shared-host placement lead, not a default pinning policy.
- Initial strict replay rejected autonomous `gpu-open` non-target affinity/name
  changes in five sessions. V2 was frozen **before new collection**, explicitly
  observes/reports these changes (15 and 18 sessions), and retains all hot-role,
  producer, provenance and cleanup guards. No sessions dropped. Frozen v1 still
  rejects the initial run. See `initial-rejection.json` and `protocol-v2.json`.
- Sign-test p-values assume independent fair round signs under the null;
  deterministic balanced orders do not prove that assumption. No pooling,
  either-series-significant rule, or cross-family guarantee. Nonsignificance
  is not equivalence/noninferiority.
- Busy compiler processes were observed after first v2 capture during replication
  (`post-confirmatory-host-witness.json`); no per-pass attribution or proof of a
  pure SMT mechanism. No external process was changed. No new Ghostty session.

## Replay without launch/build/repair

From repository root; output goes to stdout, not frozen evidence:

```sh
python3 -B bench/linux/analyze-hot-placement.py \
  bench/results/2026-11-03-hot-placement/pilot \
  --expect bench/results/2026-11-03-hot-placement/pilot-replay.json
python3 -B bench/linux/analyze-hot-placement.py \
  bench/results/2026-11-03-hot-placement/confirmatory \
  --expect bench/results/2026-11-03-hot-placement/confirmatory-replay.json
python3 -B bench/linux/analyze-hot-placement.py \
  bench/results/2026-11-03-hot-placement/replication \
  --expect bench/results/2026-11-03-hot-placement/replication-replay.json
python3 -B bench/results/2026-11-03-hot-placement/replay-initial-rejection.py
python3 -B bench/results/2026-11-03-hot-placement/check-corruption.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-hot-placement/frozen-index.json
python3 -B -m unittest discover -s bench -p 'test_replay_*.py' -q
```

Placement replay checks the recorded current source/executable/protocol hashes;
those exact paths/versions must remain available. Frozen artifact replay does
not require the temporary executable. Hashes prove consistency, not benchmark
accuracy/authenticity/safety. Source snapshots preserve current emitting/checking
machinery. Snapshot v1 needs its original logical import location; use the
provided rejection replay rather than running that relocated snapshot directly.

`signal-cleanup.py` launched once inside own terminal exercises real two-role
pins with injected waits/failure: SIGTERM/HUP/INT and second-pin failure all
restore both masks and remain incomplete. `signal-smoke/` contains fault
sidecars, **not throughput sessions**. Do not rerun it into frozen evidence.
`check-corruption.py` operates on temporary copies: 13 corruptions reject,
one non-target-transition positive control is accepted **and reported**, and
all input hashes are unchanged. `checker-tests.log`: 22 existing tests passed.

`starting-state.json` binds 120 Rust sources and 621 previous files. Prior
read-only checks: 17 manifests/3171 references and 437 contention artifacts.
`final-verification.json`, `evidence-sha256.json` and `frozen-index.json` close
this package. Earlier packages, unrelated untracked files and selected runtime
are preserved. Proposed follow-up: controlled load/core-placement with
prospective worthwhile-benefit and regression margins; only then fresh complete
competitor, startup, real key-to-screen and correctness gates.


Historical document closure: today's documentation updates change three live
paths covered by the previous package. `previous-docs/` retains the exact
`0f20904` bytes, verified against that package's unchanged manifest;
`prior-contention-index.json` maps only those paths. Read-only final replay:

```sh
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-hot-placement/prior-contention-index.json
```

`prior-contention-final-replay.json` verifies 437 references (3 historical
document versions); `prior-historical-final-replay.json` verifies 17 manifests/
3171 references (10 historical). Earlier replay receipts captured before
today's doc updates remain unchanged. No old artifact/manifest was rewritten.
