#!/bin/bash
# Own terminal only. Artificial same-L3 topology diagnostic, not a scoreboard.
set -euo pipefail
B=$(dirname "$(readlink -f "$0")")
. "$B/../lib.sh"
OUT=${OUT:?fresh output directory}
GLASS=$(readlink -f "${GLASS:?exact selected executable}")
PROTOCOL=$(readlink -f "${PROTOCOL:?frozen protocol}")
ROUNDS=${ROUNDS:-20}
[[ $ROUNDS =~ ^[1-9][0-9]*$ ]] || exit 2
mkdir "$OUT"
OUT=$(readlink -f "$OUT")
python3 -B - "$OUT" "$B" "$GLASS" "$PROTOCOL" "$ROUNDS" <<'PY'
import hashlib,json,pathlib,sys
out,b,binary,protocol,rounds=sys.argv[1:];out=pathlib.Path(out);b=pathlib.Path(b)
base=['auto','s0','d10','s1','d01']
orders=[base[i:]+base[:i] for i in range(5)]
orders += [list(reversed(row)) for row in orders]
paths=[pathlib.Path(binary),pathlib.Path(protocol),b/'hot-placement.py',b/'run-hot-placement.sh',b.parent/'lib.sh',b.parent/'tput.py']
d=dict(schema='glass.hot-placement-run/v1',complete=False,binary=binary,protocol=protocol,rounds=int(rounds),
       arms=['auto','s0','s1','d01','d10'],orders=[],planned_orders=[orders[i%10] for i in range(int(rounds))],
       sha256={str(p.resolve()):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})
assert json.loads(pathlib.Path(protocol).read_text())['binary_sha256']==d['sha256'][binary]
(out/'manifest.json').write_text(json.dumps(d,indent=2)+'\n')
PY
trap headless_down EXIT
headless_up
for r in $(seq "$ROUNDS"); do
  order=$(python3 -B - "$OUT/manifest.json" "$r" <<'PY'
import json,sys
print(' '.join(json.load(open(sys.argv[1]))['planned_orders'][int(sys.argv[2])-1]))
PY
)
  for arm in $order; do
    result="$OUT/tput-$arm-$r.json"
    class="bench.hot-placement-$arm-$r"
    payload="env -u LD_PRELOAD -u GLASS_AFFINITY -u GLASS_LOCK_CENSUS -u GLASS_SCHED_EXE -u GLASS_SCHED_OUT -u GLASS_SCHED_MODE -u GLASS_READ_SHAPE_EXE -u GLASS_READ_SHAPE_OUT -u GLASS_READ_SHAPE_MODE -u GLASS_SAMPLE_OUT -u GLASS_PGO_BURST -u BENCH_TERM_PID -u KITTY_PID $GLASS --class $class -e python3 -B -I $B/hot-placement.py $result --binary $GLASS --protocol $PROTOCOL --arm $arm"
    echo "round $r/$ROUNDS $arm"
    launch "$class" "$payload"
    found=0
    for tick in $(seq 3600); do
      if [ -s "$result" ]; then found=1; break; fi
      if [ "$tick" -gt 100 ] && [ -z "$(run_windows)" ]; then echo "closed without $result" >&2; exit 1; fi
      sleep .1
    done
    [ "$found" = 1 ] || { echo "missing $result" >&2; exit 1; }
    wait_gone || { echo 'session failed to close' >&2; exit 1; }
    python3 -B - "$result" <<'PY'
import json,pathlib,sys
p=pathlib.Path(sys.argv[1]);d=json.loads(p.read_text());s=json.loads(p.with_suffix('.placement.json').read_text())
assert (d['cols'],d['rows'],len(d['results']))==(154,39,6)
assert s['complete'] is True and not s['cleanup_errors']
assert all(s['roles_restored'][k]['allowed']==s['original'][k] for k in s['original'])
PY
  done
  python3 -B - "$OUT/manifest.json" "$r" <<'PY'
import json,pathlib,sys
p=pathlib.Path(sys.argv[1]);d=json.loads(p.read_text());d['orders'].append(d['planned_orders'][int(sys.argv[2])-1]);p.write_text(json.dumps(d,indent=2)+'\n')
PY
done
python3 -B - "$OUT/manifest.json" <<'PY'
import hashlib,json,pathlib,sys
p=pathlib.Path(sys.argv[1]);d=json.loads(p.read_text())
for path,digest in d['sha256'].items():
    assert hashlib.sha256(pathlib.Path(path).read_bytes()).hexdigest()==digest,path
d['complete']=True
d['raw_sha256']={f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in sorted(p.parent.iterdir()) if f.is_file() and f.name!='manifest.json'}
p.write_text(json.dumps(d,indent=2)+'\n')
PY
