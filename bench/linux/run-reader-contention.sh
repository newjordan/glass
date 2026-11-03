#!/bin/bash
# Six-arm own-reader competition diagnostic. Never an official/default score.
set -euo pipefail
B=$(dirname "$(readlink -f "$0")")
. "$B/../lib.sh"
OUT=${OUT:?fresh output directory}
GLASS=$(readlink -f "${GLASS:?selected binary}")
OBSERVER=$(readlink -f "${OBSERVER:?scheduler observer}")
HELPER=$(readlink -f "${HELPER:?own helper}")
PROTOCOL=$(readlink -f "${PROTOCOL:?predeclared protocol}")
ROUNDS=${ROUNDS:-12}
CPU=${CPU:-0}
[[ $ROUNDS =~ ^[1-9][0-9]*$ && $CPU =~ ^[0-9]+$ ]] || exit 2
mkdir "$OUT"
OUT=$(readlink -f "$OUT")
python3 -B - "$OUT" "$B" "$GLASS" "$OBSERVER" "$HELPER" "$PROTOCOL" "$ROUNDS" "$CPU" <<'PY'
import hashlib,json,pathlib,sys
out,b,binary,observer,helper,protocol,rounds,cpu=sys.argv[1:];b=pathlib.Path(b);out=pathlib.Path(out)
arms=[f'{mode}-{obs}' for mode in ('sleep','busy') for obs in ('plain','clock','sched')]
base=[0,1,5,2,4,3]
rows=[[arms[(i+j)%6] for j in base] for i in range(6)]
rows+= [list(reversed(row)) for row in rows]
paths=[pathlib.Path(binary),pathlib.Path(observer),pathlib.Path(helper),pathlib.Path(protocol),
       b/'sched-shape.c',b/'sched-snapshot.h',b/'reader-contender.c',b/'reader-contention.py',
       b/'run-reader-contention.sh',b/'pipeline-profile.py',b.parent/'lib.sh',b.parent/'tput.py']
d=dict(schema='glass.reader-contention-run/v1',complete=False,binary=binary,observer=observer,
       helper=helper,protocol=protocol,rounds=int(rounds),cpu=int(cpu),arms=arms,orders=[],
       planned_orders=[rows[i%12] for i in range(int(rounds))],
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
    mode=${arm%-*}; obs=${arm#*-}
    result="$OUT/tput-$arm-$r.json"
    trace="$OUT/$arm-$r.trace"
    class="bench.reader-contention-$arm-$r"
    payload="$GLASS --class $class -e python3 -B -I $B/reader-contention.py $result --helper $HELPER --binary $GLASS --mode $mode --cpu $CPU"
    if [ "$obs" != plain ]; then
      payload="env LD_PRELOAD=$OBSERVER GLASS_SCHED_EXE=$GLASS GLASS_SCHED_OUT=$trace GLASS_SCHED_MODE=$obs $payload"
    fi
    payload="env -u LD_PRELOAD -u GLASS_SCHED_EXE -u GLASS_SCHED_OUT -u GLASS_SCHED_MODE -u GLASS_READ_SHAPE_EXE -u GLASS_READ_SHAPE_OUT -u GLASS_READ_SHAPE_MODE -u GLASS_LOCK_CENSUS -u GLASS_AFFINITY -u GLASS_SAMPLE_OUT -u GLASS_PGO_BURST $payload"
    echo "round $r/$ROUNDS $arm"
    launch "$class" "$payload"
    found=0
    for tick in $(seq 3600); do
      if [ -s "$result" ]; then found=1; break; fi
      if [ "$tick" -gt 100 ] && [ -z "$(run_windows)" ]; then echo "closed without $result" >&2; exit 1; fi
      sleep 0.1
    done
    [ "$found" = 1 ] || { echo "missing $result" >&2; exit 1; }
    wait_gone || { echo "session failed to close" >&2; exit 1; }
    python3 -B - "$result" <<'PY'
import json,pathlib,sys
p=pathlib.Path(sys.argv[1]);d=json.loads(p.read_text());s=json.loads(p.with_suffix('.profile.json').read_text());c=json.loads(p.with_suffix('.contention.json').read_text())
assert (d['cols'],d['rows'],len(d['results']))==(154,39,6)
assert s['complete'] and c['complete'] and len(s['passes'])==18
assert c['reader_allowed_during']==c['helper_allowed']==[c['cpu']]
assert c['reader_allowed_restored']==c['reader_allowed_before']
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
    assert hashlib.sha256(pathlib.Path(path).read_bytes()).hexdigest()==digest, path
d['complete']=True
d['raw_sha256']={f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in sorted(p.parent.iterdir()) if f.is_file() and f.name!='manifest.json'}
p.write_text(json.dumps(d,indent=2)+'\n')
PY
