#!/bin/bash
# Key-to-pty latency for one terminal, mirroring bench/run-misc.sh's
# key section: a window on the headless output, 40 keys sent through
# Hyprland's send_shortcut, keys.py logging each read.
#
#   TERMINAL  the terminal, as lib.sh's term_cmd names it (default glass)
#   GLASS  the glass binary (required for glass)
#   N      keys to send (default 40)
#   CAP    headless output name (default KEYCAP; must already exist)
#   TAG    label in the output line (default the binary's basename for
#          glass, else the terminal's name)
#   LOAD   if set, `yes` floods the pty while keys are sent
set -u
B=$(dirname "$(readlink -f "$0")")
TERMINAL=${TERMINAL:-glass}
[ "$TERMINAL" = glass ] && GLASS=${GLASS:?GLASS names the glass binary}
N=${N:-40}
CAP=${CAP:-KEYCAP}
# For term_cmd; the script's own workspace and run_windows below replace lib.sh's.
. "$B/lib.sh"
TAG=${TAG:-$([ "$TERMINAL" = glass ] && basename "$GLASS" || echo "$TERMINAL")}
WS=$(hyprctl monitors -j | CAP=$CAP python3 -c '
import json, os, sys
ids = [m["activeWorkspace"]["id"] for m in json.load(sys.stdin) if m["name"] == os.environ["CAP"]]
print(ids[0] if ids else "")')
[ -n "$WS" ] || { echo "no headless output $CAP" >&2; exit 1; }
run_windows() {
  hyprctl clients -j | WS=$WS python3 -c '
import json, os, sys
for c in json.load(sys.stdin):
    if str(c["workspace"]["id"]) == os.environ["WS"]:
        print(c["pid"], c["class"], c["address"])'
}
LOG=${TMPDIR:-/tmp}/keys-$TAG-$$.log
SENT=${TMPDIR:-/tmp}/sent-$TAG-$$.log
ERR=${ERRLOG:-}
ENVV="${SLOW_KEYS:+GLASS_SLOW_KEYS=$SLOW_KEYS}"
# TRACE lets a run trace without writing: `quiet` runs the same code
# paths, `1` prints the marks to ERRLOG's file.
TRACE=${TRACE:-}
[ -n "$ERR" ] && TRACE=${TRACE:-1}
[ -n "$TRACE" ] && ENVV="$ENVV GLASS_KEY_TRACE=$TRACE"
if [ -n "${LOAD:-}" ]; then
  # The flood must outlast the keys and reach the pty: `yes` writes to
  # the terminal itself (`/dev/tty`), so the run's output redirection
  # (an ERRLOG run redirects glass's stderr to a file) does not swallow
  # it and turn a load run into an idle one.
  CMD="sh -c 'yes > /dev/tty & exec python3 -I $B/keys.py $LOG'"
  # FLOOD_MB caps the flood's pace instead (that many MB a second, a
  # paced writer in python), for telling lock waits from kernel queueing.
  if [ -n "${FLOOD_MB:-}" ]; then
    CMD="sh -c 'python3 -c \"import time,sys
chunk=b\\\"y\\n\\\"*$FLOOD_MB*1024*1024
while True:
    t=time.monotonic()
    sys.stdout.buffer.write(chunk)
    sys.stdout.buffer.flush()
    d=time.monotonic()-t
    if d<1: time.sleep(1-d)\" > /dev/tty & exec python3 -I $B/keys.py $LOG'"
  fi
else
  CMD="python3 -I $B/keys.py $LOG"
fi
OUTRD=""; ERRRD=""
[ -n "$ERR" ] && { OUTRD="> ${TMPDIR:-/tmp}/out-$TAG-$$.log"; ERRRD="2> $ERR"; }
hyprctl eval "hl.dispatch(hl.dsp.exec_cmd([[$ENVV $(term_cmd "$TERMINAL" bench.keys "$CMD") $OUTRD $ERRRD]], { workspace = \"$WS silent\" }))" >/dev/null
sleep 3
read -r pid addr < <(run_windows | awk '$2=="bench.keys" {print $1, $3; exit}')
[ -n "$addr" ] || { echo "no window" >&2; exit 1; }
: > "$SENT"
for i in $(seq "$N"); do
  date +%s%N >> "$SENT"
  hyprctl eval "hl.dispatch(hl.dsp.send_shortcut({ mods = \"\", key = \"a\", window = \"address:$addr\" }))" >/dev/null
  sleep 0.12
done
hyprctl eval "hl.dispatch(hl.dsp.send_shortcut({ mods = \"\", key = \"q\", window = \"address:$addr\" }))" >/dev/null
sleep 1
kill "$pid" 2>/dev/null
for i in $(seq 20); do [ -z "$(run_windows)" ] && break; sleep 0.25; done
python3 - "$SENT" "$LOG" "$TAG" <<'PY'
import sys, statistics as st
sent = [int(x) for x in open(sys.argv[1])]
got = [int(l.split()[0]) for l in open(sys.argv[2]) if "a" in l.split(" ", 1)[1]]
d = sorted((g - s) / 1e6 for s, g in zip(sent, got))
if not d:
    print(sys.argv[3], "key_to_pty_ms NO DATA"); sys.exit(1)
print(sys.argv[3], "key_to_pty_ms n=%d median=%.2f p90=%.2f min=%.2f max=%.2f" % (len(d), st.median(d), d[int(len(d)*.9)], d[0], d[-1]))
PY


