#!/bin/bash
# Alternating quiet DA1 response-time sessions. Not key-to-screen latency.
# GLASS and GLASS_ALT are frozen executables; OUT must be a new directory.
# ROUNDS (default 12) is a count, N (default 500) samples per session.
set -euo pipefail
B=$(dirname "$(readlink -f "$0")")
. "$B/lib.sh"
: "${GLASS:?GLASS names a frozen executable}"
: "${GLASS_ALT:?GLASS_ALT names a frozen executable}"
: "${OUT:?OUT must name a new results directory}"
ROUNDS=${ROUNDS:-12}
N=${N:-500}
[[ $ROUNDS =~ ^[1-9][0-9]*$ && $N =~ ^[1-9][0-9]*$ ]] || exit 2
mkdir "$OUT"
OUT=$(readlink -f "$OUT")
export GLASS GLASS_ALT OUT ROUNDS N
python3 -I "$B/summarize-pty-rtt.py" "$OUT" --start
headless_up
trap headless_down EXIT
for round in $(seq "$ROUNDS"); do
  order="glass glass-alt"
  if ((round % 2 == 0)); then order="glass-alt glass"; fi
  for term in $order; do
    out=$OUT/rtt-$term-$round.json
    launch "bench.$term" $(term_cmd "$term" "bench.$term" python3 -I "$B/pty-rtt.py" "$out" "$N")
    for i in $(seq 120); do [ -s "$out" ] && break; sleep 0.5; done
    [ -s "$out" ] || { echo "missing result: $out" >&2; exit 1; }
    wait_gone || { echo "window failed to close: $term $round" >&2; exit 1; }
    printf '%s %s\n' "$round" "$term" >> "$OUT/order.txt"
    sleep 1
  done
  echo "quiet RTT round $round/$ROUNDS: $order"
done
python3 -I "$B/summarize-pty-rtt.py" "$OUT"
