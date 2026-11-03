# Iteration 15: mandatory campaign audit

**Reported research, not championship acceptance or a runtime promotion.**

Read the full reconciliation in
[`../../../reports/research-1eecf9876bb302e9da10ff629e71e6d8-15.txt`](../../../reports/research-1eecf9876bb302e9da10ff629e71e6d8-15.txt).

`audit.json` is the final expanded read-only replay: 17 historical manifests,
3,171 file references (10 explicitly historical), 20 supported throughput series
/ 1,170 sessions, 26 engine datasets / 300 pairs, two quiet-RTT datasets and
39 diagnostic sessions. Other historical schemas, missing-provenance and
incomplete series are enumerated separately, **not** counted as validated.
`audit-initial.json` is superseded narrower coverage, not another experiment.

The exact selected executable remains `d75cb26f…`; all 120 Rust sources match
`starting-state.json`. The combined candidate `6111147b…` remains unpromoted.
Its 30-round replication establishes four within-series Ghostty throughput
leads after six-workload Holm correction, but not ASCII or scroll-region
superiority. It needs 3.5725% more ASCII merely to reach the observed median;
the retained executable's latest Unicode median needs 5.0133% to reach parity.
Parity is not superiority; different binaries/series cannot be pooled.

## Replay without benchmark, build, or repair

From the workspace root:

```sh
# Historical manifests with explicit exact snapshots. No discovery/fallback.
python3 bench/replay-evidence-index.py \
  bench/results/2026-11-03-campaign-audit/historical-index.json

# This new package's frozen artifacts. Does not depend on temporary binaries.
python3 bench/replay-evidence-index.py \
  bench/results/2026-11-03-campaign-audit/frozen-index.json

# Focused checker regressions: six tests, disposable temporary directories.
python3 -m unittest discover -s bench -p 'test_replay*index.py' -v
```

`replay-audit.py` additionally requires the recorded temporary executables and
harness paths for diagnostic/RTT provenance checks. Run it from the root with
output redirected **outside frozen evidence** if a new replay is wanted.
It explicitly inventories historical series, recomputes paired ratios and
Holm families from raw sessions, checks trace/pass count distinctions, and
compares all audited bytes before/after. No producer/terminal is launched.

Snapshot mapping repairs historical replayability, not the original manifests.
Three older word-decode documentation versions are copied from commit
`1661f5abf829010fa8e307e63f24f1984ae3420a` and match their original hashes.
Other historical mappings use already-retained snapshots. Original evidence
and unrelated work are unchanged. Hashes establish byte consistency, not
measurement accuracy, authenticity, safety, independence, or a world title.
