#!/bin/bash
# Run the instrumented glass through tput with GLASS_LOCK_CENSUS=1 and
# capture the census line it prints at exit.
#   GLASS  the binary to measure (default target/release/glass)
set -u
B=$(dirname "$(readlink -f "$0")")
. "$B/../lib.sh"
OUT=${OUT:-$B/../results/local/stall-census}
mkdir -p "$OUT"
OUT=$(readlink -f "$OUT")
headless_up
trap headless_down EXIT
name=census
out=$OUT/tput-census.json
err=$OUT/census-stderr.txt
rm -f "$out" "$err"
GLASSBIN=${GLASS:-$B/../../target/release/glass}
launch "sh -c 'GLASS_LOCK_CENSUS=1 exec $GLASSBIN --class bench.$name -e python3 -I $B/../tput.py $out' >$err 2>&1" || exit 1
for i in $(seq 60); do [ -s "$out" ] && break; sleep 1; done
wait_gone || echo "window did not close" >&2
[ -s "$out" ] && python3 -c "import json,sys; d=json.load(open(sys.argv[1])); print({k:(v['mb_s'],v.get('term_cpu_s')) for k,v in d['results'].items()})" "$out"
grep -h "glass-census" "$err" || echo "no census line in stderr: $(head -5 "$err" 2>/dev/null)"
