#!/bin/bash
# Startup, the same way for every terminal, on a headless output:
#  (a) launch until the program inside is running (it writes the time);
#  (b) launch until the window is mapped: Hyprland's `openwindow` event,
#      which it sends when the window's first frame (its first committed
#      buffer) arrives, read from the event socket as it comes.
# The terminals take turns run by run, so each sees the same machine.
#
#   TERMS  the terminals (glass kitty)
#   RUNS   launches of each (8; the published numbers used 16)
#   CAP    the headless output's name (GLASSCAP)
#   GLASS, GLASS_ALT, KITTY   the binaries (see lib.sh)
#
#   RUNS=16 bench/run-startup.sh
set -u
B=$(dirname "$(readlink -f "$0")")
. "$B/lib.sh"
SOCK=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/hypr/${HYPRLAND_INSTANCE_SIGNATURE:-}/.socket2.sock
[ -S "$SOCK" ] || { echo "no Hyprland event socket at $SOCK" >&2; exit 1; }
TMP=$(mktemp -d "${TMPDIR:-/tmp}/glass-bench-startup.XXXXXX")
headless_up
# Every openwindow event, stamped as it arrives: "ns class".
EV=$TMP/events.log
: > "$EV"
python3 -I -c '
import socket, sys, time
s = socket.socket(socket.AF_UNIX); s.connect(sys.argv[1]); out = open(sys.argv[2], "a"); buf = b""
while True:
    d = s.recv(65536)
    if not d: break
    t = time.time_ns(); buf += d
    *lines, buf = buf.split(b"\n")
    for l in lines:
        if l.startswith(b"openwindow>>"):
            f = l[12:].split(b",", 3)
            if len(f) >= 3: out.write("%d %s\n" % (t, f[2].decode(errors="replace"))); out.flush()
' "$SOCK" "$EV" &
LISTENER=$!
trap 'kill $LISTENER 2>/dev/null; headless_down; rm -rf "$TMP"' EXIT
sleep 0.3
declare -A RA RB
for i in $(seq "${RUNS:-8}"); do
  for t in ${TERMS:-glass kitty}; do
    f=$TMP/start-$t
    rm -f "$f"
    t0=$(date +%s%N)
    # The program records when it runs, then stays a moment so the window
    # is mapped whatever order the two happen in.
    launch "$(term_cmd "$t" "bench.$t" "sh -c 'date +%s%N > $f; sleep 1'")" || exit 1
    for j in $(seq 600); do [ -s "$f" ] && grep -q " bench.$t\$" "$EV" && break; sleep 0.005; done
    # A run that missed either is left out, and said so.
    if [ -s "$f" ]; then RA[$t]+="$(( ($(cat "$f") - t0) / 1000000 )) "; else echo "$t run $i: the program never ran" >&2; fi
    m=$(awk -v t0="$t0" -v c="bench.$t" '$2==c && $1>=t0 {print $1; exit}' "$EV")
    if [ -n "$m" ]; then RB[$t]+="$(( (m - t0) / 1000000 )) "; else echo "$t run $i: no openwindow event" >&2; fi
    : > "$EV"
    # The next run starts once this window has gone.
    wait_gone || echo "$t run $i: the window did not close" >&2
    sleep 1
  done
done
med() { python3 -c 'import statistics,sys; v=[int(x) for x in sys.argv[1:]]; print(statistics.median(v) if v else "none")' "$@"; }
for t in ${TERMS:-glass kitty}; do
  echo "$t a_child_ms ${RA[$t]:-}median=$(med ${RA[$t]:-})"
  echo "$t b_mapped_ms ${RB[$t]:-}median=$(med ${RB[$t]:-})"
done
