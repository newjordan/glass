#!/bin/sh
# ab-3way.sh: published glass vs HEAD glass vs Ghostty on macOS, one run of
# each per round with the order rotating so position bias cancels.
#   GLASS_A / GLASS_B   the two glass binaries
#   GHOSTTY             Ghostty's binary
#   ROUNDS              round labels (default "1 2 3 4 5 6")
#   OUT                 where the results go (bench/results/ab-3way)
# Each result lands in $OUT/tput-<a|b|ghostty>-<round>.json. Before the
# first measured round one throwaway run warms the machine.
set -u
B=$(cd "$(dirname "$0")/.." && pwd)
GLASS_A=${GLASS_A:?GLASS_A}
GLASS_B=${GLASS_B:?GLASS_B}
GHOSTTY=${GHOSTTY:-/Applications/Ghostty.app/Contents/MacOS/ghostty}
OUT=${OUT:-$B/results/ab-3way}
mkdir -p "$OUT"
caffeinate -dimu -t 7200 >/dev/null 2>&1 &
awake=$!

run_one() { # $1=arm label, $2=round
  out=$OUT/tput-$1-$2.json
  rm -f "$out"
  case $1 in
    a) "$GLASS_A" --class glassbench -e "$B/macos/in-term.sh" "$B/tput.py" "$out" >/dev/null 2>&1 ;;
    b) "$GLASS_B" --class glassbench -e "$B/macos/in-term.sh" "$B/tput.py" "$out" >/dev/null 2>&1 ;;
    ghostty) "$GHOSTTY" --config-default-files=false --config-file="$B/macos/ghostty.conf" \
        -e "$B/macos/in-term.sh" "$B/tput.py" "$out" >/dev/null 2>&1 ;;
  esac
  while pgrep -x ghostty >/dev/null || pgrep -f "glass --class glassbench" >/dev/null; do sleep 0.5; done
  sleep 2
  [ -s "$out" ] && echo "$1 round $2 done" || echo "$1 round $2: no result" >&2
}

warm_out=$OUT/tput-a-warm.json
rm -f "$warm_out"
"$GLASS_A" --class glassbench -e "$B/macos/in-term.sh" "$B/tput.py" "$warm_out" >/dev/null 2>&1
while pgrep -f "glass --class glassbench" >/dev/null; do sleep 0.5; done
rm -f "$warm_out"
sleep 2

i=0
for r in ${ROUNDS:-1 2 3 4 5 6}; do
  i=$(( i + 1 ))
  case $(( i % 3 )) in
    1) run_one a $r; run_one b $r; run_one ghostty $r ;;
    2) run_one b $r; run_one ghostty $r; run_one a $r ;;
    0) run_one ghostty $r; run_one a $r; run_one b $r ;;
  esac
done
kill $awake 2>/dev/null
echo DONE
