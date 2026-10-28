#!/bin/bash
# Key-to-pty latency for one glass binary, mirroring bench/run-misc.sh's
# key section: a window on the headless output, 40 keys sent through
# Hyprland's send_shortcut, keys.py logging each read.
#
#   GLASS  the glass binary (required)
#   N      keys to send (default 40)
#   CAP    headless output name (default KEYCAP; must already exist)
#   TAG    label in the output line (default the binary's basename)
#   LOAD   if set, `yes` floods the pty while keys are sent
set -u
B=$(dirname "$(readlink -f "$0")")
GLASS=${GLASS:?GLASS names the glass binary}
N=${N:-40}
CAP=${CAP:-KEYCAP}
TAG=${TAG:-$(basename "$GLASS")}
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
LOG=$TMPDIR/keys-$TAG-$$.log
SENT=$TMPDIR/sent-$TAG-$$.log
ERR=${ERRLOG:-}
ENVV=""
[ -n "$ERR" ] && ENVV="GLASS_KEY_TRACE=1"
if [ -n "${LOAD:-}" ]; then
  CMD="sh -c 'yes | head -c 200000000 & exec python3 -I $B/keys.py $LOG'"
else
  CMD="python3 -I $B/keys.py $LOG"
fi
OUTRD=""; ERRRD=""
[ -n "$ERR" ] && { OUTRD="> $TMPDIR/out-$TAG-$$.log"; ERRRD="2> $ERR"; }
hyprctl eval "hl.dispatch(hl.dsp.exec_cmd([[$ENVV $GLASS --class bench-keys -e $CMD $OUTRD $ERRRD]], { workspace = \"$WS silent\" }))" >/dev/null
sleep 3
read -r pid addr < <(run_windows | awk '$2=="bench-keys" {print $1, $3; exit}')
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


