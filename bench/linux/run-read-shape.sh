#!/bin/bash
# Own-process read/poll diagnostic: no runtime rebuild, not a terminal scoreboard.
set -euo pipefail
B=$(dirname "$(readlink -f "$0")")
. "$B/../lib.sh"
OUT=${OUT:?fresh directory}
GLASS=$(readlink -f "${GLASS:?exact frozen executable}")
OBSERVER=$(readlink -f "${OBSERVER:?read-shape.so}")
ROUNDS=${ROUNDS:-12}
[[ $ROUNDS =~ ^[1-9][0-9]*$ ]] || exit 2
mkdir "$OUT"
OUT=$(readlink -f "$OUT")
python3 - "$OUT" "$B" "$GLASS" "$OBSERVER" "$ROUNDS" <<'PY'
import hashlib,itertools,json,pathlib,sys
out,b,binary,observer,rounds=sys.argv[1:];b=pathlib.Path(b)
paths=[pathlib.Path(binary),pathlib.Path(observer),b/'read-shape.c',b/'run-read-shape.sh',b/'pipeline-profile.py',b.parent/'lib.sh',b.parent/'tput.py']
d={'schema':'glass.read-shape-run/v1','complete':False,'binary':binary,'observer':observer,'rounds':int(rounds),
   'sha256':{str(p.resolve()):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
   'orders':[],'planned_orders':[list(x) for x in itertools.islice(itertools.cycle(itertools.permutations(['plain','count','timed'])),int(rounds))]}
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
    trace="$OUT/$arm-$r.trace"
    class="bench.read-shape-$arm-$r"
    payload="$GLASS --class $class -e python3 -I $B/pipeline-profile.py run $result --sample-ms 0"
    if [ "$arm" != plain ]; then
      payload="env LD_PRELOAD=$OBSERVER GLASS_READ_SHAPE_EXE=$GLASS GLASS_READ_SHAPE_OUT=$trace GLASS_READ_SHAPE_MODE=$arm $payload"
    fi
    # Strip diagnostic knobs inherited by Hyprland; only the explicit observer
    # treatment varies. No affinity, credit, parser or producer treatment.
    payload="env -u LD_PRELOAD -u GLASS_LOCK_CENSUS -u GLASS_AFFINITY -u GLASS_SAMPLE_OUT -u GLASS_PGO_BURST $payload"
    launch "$class" "$payload"
    found=0
    for tick in $(seq 3600); do
      if [ -s "$result" ]; then found=1; break; fi
      if [ "$tick" -gt 100 ] && [ -z "$(run_windows)" ]; then echo "closed without $result" >&2; exit 1; fi
      sleep 0.1
    done
    [ "$found" = 1 ] || { echo "missing $result" >&2; exit 1; }
    wait_gone || { echo "session failed to close" >&2; exit 1; }
    python3 - "$result" "$arm" "$trace" <<'PY'
import hashlib,json,pathlib,struct,sys
p=pathlib.Path(sys.argv[1]);d=json.loads(p.read_text());s=json.loads(p.with_suffix('.profile.json').read_text())
assert (d['cols'],d['rows'])==(154,39) and len(d['results'])==6
assert s['complete'] and len(s['passes'])==18 and s['result_sha256']==hashlib.sha256(p.read_bytes()).hexdigest()
if sys.argv[2]!='plain':
 data=pathlib.Path(sys.argv[3]).read_bytes();magic,version,size,count,dropped,mode,tid,cap,reserved=struct.unpack_from('<8s8I',data)
 assert magic==b'RDSHAPE1' and version==1 and size==56 and dropped==0 and reserved==0 and count>0 and tid>0
 assert mode==(sys.argv[2]=='timed') and len(data)==40+size*count and count<=cap
print(p.name,{k:v['mb_s'] for k,v in d['results'].items()},flush=True)
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
 assert hashlib.sha256(pathlib.Path(source).read_bytes()).hexdigest()==sha,source
assert d['orders']==d['planned_orders']
d['complete']=True
raw=[p for p in p.parent.iterdir() if p.suffix in ('.json','.jsonl','.py','.trace') and p.name!='manifest.json']
d['raw_sha256']={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(raw)}
p.write_text(json.dumps(d,indent=2)+'\n')
PY
