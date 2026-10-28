#!/bin/sh
# run-startup.sh: launch to window on screen, and launch to program running,
# for glass and Ghostty on macOS, taking turns, N launches each (12).
# `launch` (launch.swift) starts the terminal and watches the window list
# for a window it owns; `stamp` (stamp.c) is the program inside, and writes
# the clock the moment it runs. GLASS, GHOSTTY: as in run-tput.sh.
#
# Ghostty runs its command through login and bash, as it does by default
# on macOS. glass starts it directly.
set -u
B=$(cd "$(dirname "$0")/.." && pwd)
GLASS=${GLASS:-$B/../target/release/glass}
GHOSTTY=${GHOSTTY:-/Applications/Ghostty.app/Contents/MacOS/ghostty}
BIN=${TMPDIR:-/tmp}/glass-bench-macos
mkdir -p "$BIN"
[ -x "$BIN/stamp" ] || cc -O2 -o "$BIN/stamp" "$B/macos/stamp.c" || exit 1
[ -x "$BIN/launch" ] || xcrun swiftc -O -o "$BIN/launch" "$B/macos/launch.swift" || exit 1
stamp=$BIN/stamp.out
caffeinate -dimu -t 3600 >/dev/null 2>&1 &
awake=$!
for r in $(seq "${N:-12}"); do
  printf "glass   "
  "$BIN/launch" "$stamp" "$GLASS" --class glassbench -e "$BIN/stamp" "$stamp" 2>/dev/null
  sleep 1
  printf "ghostty "
  "$BIN/launch" "$stamp" "$GHOSTTY" --config-default-files=false --config-file="$B/macos/ghostty.conf" \
    -e "$BIN/stamp" "$stamp" 2>/dev/null
  sleep 1
done
kill $awake
