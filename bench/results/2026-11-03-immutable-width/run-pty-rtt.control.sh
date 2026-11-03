#!/bin/bash
# Paired quiet DA1 RTT, not key-to-screen or frame latency. Both binaries
# must be captured first; do not run alongside throughput benchmarks.
# GLASS=candidate GLASS_ALT=control OUT=new-dir ROUNDS=6 N=300 bash bench/run-pty-rtt.sh
set -euo pipefail
B=$(dirname "$(readlink -f "$0")")
. "$B/lib.sh"
OUT=${OUT:?OUT names a new results directory}
mkdir "$OUT"
OUT=$(readlink -f "$OUT")
ROUNDS=${ROUNDS:-6}
N=${N:-300}
[[ $ROUNDS =~ ^[1-9][0-9]*$ && $N =~ ^[1-9][0-9]*$ ]] || exit 2
sha256sum "${GLASS:?GLASS names candidate}" "${GLASS_ALT:?GLASS_ALT names control}" > "$OUT/binary-hashes.txt"
headless_up
trap headless_down EXIT
for round in $(seq "$ROUNDS"); do
  if (( round % 2 )); then terms='glass glass-alt'; else terms='glass-alt glass'; fi
  for t in $terms; do
    out=$OUT/rtt-$t-$round.json
    launch "rtt.$t" $(term_cmd "$t" "rtt.$t" python3 -I "$B/pty-rtt.py" "$out" "$N")
    for _ in $(seq 120); do [ -s "$out" ] && break; sleep 1; done
    wait_gone
    [ -s "$out" ] || { echo "missing $out" >&2; exit 1; }
  done
done
sha256sum --check "$OUT/binary-hashes.txt"
python3 -I - "$OUT" "$ROUNDS" "$N" <<'PY'
import hashlib, json, pathlib, statistics, sys
out, rounds, n = pathlib.Path(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3])
summary, hashes, replies = {}, {}, set()
for arm in ('glass', 'glass-alt'):
    runs = []
    for r in range(1, rounds + 1):
        p = out / f'rtt-{arm}-{r}.json'
        raw = p.read_bytes()
        d = json.loads(raw)
        assert d['schema'] == 'glass.pty-rtt/v1'
        assert d['n'] == n and len(d['samples_ms']) == n
        assert all(0 < x < 2000 for x in d['samples_ms'])
        replies.add(d['reply_hex'])
        runs.append(d)
        hashes[p.name] = hashlib.sha256(raw).hexdigest()
    samples = sorted(x for d in runs for x in d['samples_ms'])
    summary[arm] = {'run_medians_ms': [d['median_ms'] for d in runs],
        'median_of_run_medians_ms': statistics.median(d['median_ms'] for d in runs),
        'pooled_median_ms': statistics.median(samples),
        'pooled_p90_ms': samples[int(len(samples)*.9)],
        'pooled_p99_ms': samples[int(len(samples)*.99)]}
assert len(replies) == 1
summary['paired_run_median_deltas_ms'] = [a-b for a,b in zip(summary['glass']['run_medians_ms'], summary['glass-alt']['run_medians_ms'])]
summary['raw_sha256'] = hashes
summary['rounds'] = rounds
summary['samples_per_run'] = n
summary['note'] = 'Samples correlated within sessions; not key-to-screen latency.'
(out / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
print(json.dumps(summary, indent=2))
PY
