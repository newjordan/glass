#!/bin/bash
# Find where a colour lands on the headless output: capture patches in a
# grid and print each patch's mean colour. For debugging keys-screen.sh.
set -u
B=$(cd "$(dirname "$0")" && pwd)
CAP=${CAP:-KEYCAP}
W=${W:-${TMPDIR:-/tmp}/visgrid.$$}
mkdir -p "$W"
VIS=$W/viscap
[ -x "$VIS" ] || {
  wayland-scanner client-header $B/visible/wlr-screencopy-unstable-v1.xml $W/wlr-screencopy-unstable-v1-client.h &&
  wayland-scanner private-code $B/visible/wlr-screencopy-unstable-v1.xml $W/wlr-screencopy-unstable-v1.c &&
  cc -O2 -I$W -o $VIS $B/visible/viscap.c $W/wlr-screencopy-unstable-v1.c -lwayland-client || exit 1
}
for y in 135 405 675 945; do
  for x in 240 720 1200 1680; do
    $VIS "$CAP" $x $y 64 64 "$W/f-$x-$y.vis" 2>/dev/null &
    p=$!
    sleep 0.3
    kill $p 2>/dev/null
    wait $p 2>/dev/null
    c=$(grep -v "^#" "$W/f-$x-$y.vis" | tail -1 | awk '{print $4, $5, $6}')
    echo "$x,$y: $c"
  done
done
rm -rf "$W"
