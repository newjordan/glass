#!/bin/bash
# Sequential diagnostic only: no results belong on the default scoreboard.
set -euo pipefail
B=$(dirname "$(readlink -f "$0")")
. "$B/../lib.sh"
OUT=${OUT:?fresh directory}
GLASS=$(readlink -f "${GLASS:?frozen executable}")
SAMPLER=$(readlink -f "${SAMPLER:?cpu-sample.so}")
mkdir "$OUT"
OUT=$(readlink -f "$OUT")
trap headless_down EXIT
headless_up
for target in pty-parse pty-read; do
  for r in 1 2 3; do
    result="$OUT/tput-$target-$r.json"
    trace="$OUT/$target-$r.pcs"
    class="bench.cpu-sample-$target-$r"
    launch "$class" "env LD_PRELOAD=$SAMPLER GLASS_SAMPLE_EXE=$GLASS GLASS_SAMPLE_THREAD=$target GLASS_SAMPLE_OUT=$trace GLASS_SAMPLE_US=100 $GLASS --class $class -e python3 -I $B/pipeline-profile.py run $result --sample-ms 0"
    found=0
    for tick in $(seq 1200); do
      if [ -s "$result" ]; then found=1; break; fi
      if [ "$tick" -gt 100 ] && [ -z "$(run_windows)" ]; then echo "closed without $result" >&2; exit 1; fi
      sleep 0.1
    done
    [ "$found" = 1 ] || exit 1
    wait_gone || exit 1
    python3 - "$result" "$trace" <<'PY'
import json,pathlib,sys
p,t=map(pathlib.Path,sys.argv[1:]);d=json.loads(p.read_text());s=json.loads(p.with_suffix('.profile.json').read_text())
assert s['complete'] and len(s['passes']) == 18 and (d['cols'],d['rows']) == (154,39)
header=t.read_text().splitlines()[0]
assert 'armed=1' in header and 'samples=0 ' not in header and 'dropped=0 ' in header
print(p.name,header,flush=True)
PY
  done
done
