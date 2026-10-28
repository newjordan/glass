#!/bin/sh
# run-tput.sh: tput.py in glass and Ghostty on macOS, taking turns, one run
# of each a round. Each result goes to $OUT/tput-<terminal>-<round>.json.
#
#   GLASS    the glass binary (target/release/glass)
#   GHOSTTY  Ghostty's binary (/Applications/Ghostty.app/Contents/MacOS/ghostty)
#   ROUNDS   round labels (1 2 3 4 5)
#   OUT      where the results go (bench/results/local)
#
# Both open at 160x48 with font size 13 (Ghostty through ghostty.conf, glass
# through its defaults). The display is kept awake while it runs.
#   bench/macos/run-tput.sh && python3 bench/summarize.py bench/results/local
set -u
B=$(cd "$(dirname "$0")/.." && pwd)
GLASS=${GLASS:-$B/../target/release/glass}
GHOSTTY=${GHOSTTY:-/Applications/Ghostty.app/Contents/MacOS/ghostty}
OUT=${OUT:-$B/results/local}
mkdir -p "$OUT"
caffeinate -dimu -t 3600 >/dev/null 2>&1 &
awake=$!
for r in ${ROUNDS:-1 2 3 4 5}; do
  for t in glass ghostty; do
    out=$OUT/tput-$t-$r.json
    rm -f "$out"
    case $t in
      glass) "$GLASS" --class glassbench -e "$B/macos/in-term.sh" "$B/tput.py" "$out" >/dev/null 2>&1 ;;
      ghostty) "$GHOSTTY" --config-default-files=false --config-file="$B/macos/ghostty.conf" \
        -e "$B/macos/in-term.sh" "$B/tput.py" "$out" >/dev/null 2>&1 ;;
    esac
    # The next terminal starts only once this one has gone.
    while pgrep -x ghostty >/dev/null || pgrep -f "glass --class glassbench" >/dev/null; do sleep 0.5; done
    sleep 2
    [ -s "$out" ] && echo "$t round $r done" || echo "$t round $r: no result" >&2
  done
done
kill $awake
