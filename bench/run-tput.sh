#!/bin/bash
# Throughput: tput.py in each terminal, one at a time, full-screen on a
# headless output. Each terminal's result goes to $OUT/tput-<terminal>-<round>.json.
#
#   TERMS   the terminals, in the order they take turns (glass kitty)
#   ROUNDS  round labels, one run of every terminal each (1)
#   OUT     where the results go (bench/results/local)
#   CAP     the headless output's name (GLASSCAP)
#   GLASS, GLASS_ALT, KITTY   the binaries (see lib.sh)
#
#   ROUNDS="1 2 3 4 5" bench/run-tput.sh     # what the published numbers used
set -u
B=$(dirname "$(readlink -f "$0")")
. "$B/lib.sh"
OUT=${OUT:-$B/results/local}
mkdir -p "$OUT"
OUT=$(readlink -f "$OUT")
headless_up
trap headless_down EXIT
for round in ${ROUNDS:-1}; do
  for t in ${TERMS:-glass kitty}; do
    out=$OUT/tput-$t-$round.json
    rm -f "$out"
    launch "$(term_cmd "$t" "bench.$t" python3 -I "$B/tput.py" "$out")" || exit 1
    for i in $(seq 900); do [ -s "$out" ] && break; sleep 1; done
    # The next terminal gets the whole output only once this one has gone.
    wait_gone || echo "$t round $round: the window did not close" >&2
    sleep 1
    if [ -s "$out" ]; then
      python3 -c "import json,sys; d=json.load(open(sys.argv[1])); print(sys.argv[2], sys.argv[3], d['cols'], 'x', d['rows'], {k: (v['mb_s'], v.get('fps'), v['term_cpu_s']) for k, v in d['results'].items()})" "$out" "$t" "$round"
    else
      echo "$t round $round: no result" >&2
    fi
  done
done
