#!/bin/bash
# Exact-binary pipeline diagnostic. Sequential balanced uninstrumented,
# boundary-only and boundary+sampled sessions. Not a default score.
set -euo pipefail
B=$(dirname "$(readlink -f "$0")")
. "$B/../lib.sh"
OUT=${OUT:?OUT names a fresh directory}
GLASS=${GLASS:?GLASS names a frozen executable}
ROUNDS=${ROUNDS:-12}
[[ $ROUNDS =~ ^[1-9][0-9]*$ ]] || exit 2
mkdir "$OUT"
OUT=$(readlink -f "$OUT")
GLASS=$(readlink -f "$GLASS")
export GLASS
python3 - "$OUT" "$B" "$GLASS" "$ROUNDS" <<'PY'
import hashlib,json,itertools,pathlib,sys
out,b,binary,rounds=sys.argv[1:];b=pathlib.Path(b)
paths=[pathlib.Path(binary), b/'pipeline-profile.py',b/'run-pipeline-profile.sh',b.parent/'tput.py',b.parent/'lib.sh']
d={'schema':'glass.pipeline-profile-run/v1','complete':False,'binary':binary,'rounds':int(rounds),
   'sha256':{str(p.resolve()):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
   'orders':[],'planned_orders':[list(x) for x in itertools.islice(itertools.cycle(itertools.permutations(['plain','edges','sampled'])),int(rounds))]}
(pathlib.Path(out)/'manifest.json').write_text(json.dumps(d,indent=2)+'\n')
PY
trap headless_down EXIT
headless_up
for r in $(seq "$ROUNDS"); do
  order=$(python3 - "$OUT/manifest.json" "$r" <<'PY'
import json,sys
print(' '.join(json.load(open(sys.argv[1]))['planned_orders'][int(sys.argv[2])-1]))
PY
)
  for arm in $order; do
    result="$OUT/tput-$arm-$r.json"
    class="bench.pipeline-$arm-$r"
    case "$arm" in
      plain) payload="python3 -I $B/../tput.py $result" ;;
      edges) payload="python3 -I $B/pipeline-profile.py run $result --sample-ms 0" ;;
      sampled) payload="python3 -I $B/pipeline-profile.py run $result --sample-ms 5" ;;
    esac
    # No GLASS_* diagnostic flags: the exact frozen executable is unchanged.
    launch "$class" "$GLASS --class $class -e $payload"
    found=0
    for tick in $(seq 3600); do
      if [ -s "$result" ]; then found=1; break; fi
      if [ "$tick" -gt 100 ] && [ -z "$(run_windows)" ]; then
        echo "session closed without result: $result" >&2
        exit 1
      fi
      sleep 0.1
    done
    [ "$found" = 1 ] || { echo "missing $result" >&2; exit 1; }
    wait_gone || { echo "session failed to close" >&2; exit 1; }
    python3 - "$result" "$arm" <<'PY'
import hashlib,json,pathlib,sys
p=pathlib.Path(sys.argv[1]);d=json.loads(p.read_text())
assert (d['cols'],d['rows']) == (154,39), d
assert len(d['results']) == 6
if sys.argv[2] != 'plain':
 s=json.loads(p.with_suffix('.profile.json').read_text())
 assert s['complete'] and len(s['passes']) == 18
 assert s['result_sha256'] == hashlib.sha256(p.read_bytes()).hexdigest()
print(p.name, {k:v['mb_s'] for k,v in d['results'].items()}, flush=True)
PY
  done
  python3 - "$OUT/manifest.json" "$r" <<'PY'
import json,pathlib,sys
p=pathlib.Path(sys.argv[1]);d=json.loads(p.read_text());d['orders'].append(d['planned_orders'][int(sys.argv[2])-1]);p.write_text(json.dumps(d,indent=2)+'\n')
PY
done
python3 - "$OUT/manifest.json" <<'PY'
import hashlib,json,pathlib,sys
p=pathlib.Path(sys.argv[1]);d=json.loads(p.read_text())
for source,sha in d['sha256'].items():
 assert hashlib.sha256(pathlib.Path(source).read_bytes()).hexdigest() == sha,source
assert d['orders'] == d['planned_orders']
d['complete']=True;p.write_text(json.dumps(d,indent=2)+'\n')
PY
