#!/bin/bash
# Key-to-screen latency: the time from a key being sent until the echo
# of that key is on the screen (a frame the screencopy client captured
# shows it). Same shape as keys-latency.sh (one terminal at a time, N
# keys through Hyprland, median/p90), but the window runs a program that
# echoes a big block and viscap watches a patch of the headless output.
#
#   TERMS    glass (default) or kitty, one at a time
#   N        keys per run (default 40)
#   TAG      prefix of the result files
#   GLASS    the glass binary (default: this worktree's target/release)
#   CAP      headless output name (default KEYCAP)
#   HZ       the headless output's rate (default 240)
#   LOAD     when set, the program also floods the pty (yes) while the
#            keys are sent
#   W        session directory (default $TMPDIR/keys-screen.$$)
set -u
B=$(cd "$(dirname "$0")" && pwd)
. "$B/lib.sh"
CAP=${CAP:-KEYCAP}
N=${N:-40}
TAG=${TAG:-run}
HZ=${HZ:-240}
W=${W:-${TMPDIR:-/tmp}/keys-screen.$$}
mkdir -p "$W"
VIS=$W/viscap
GLASS=${GLASS:-$B/../target/release/glass}

build() {
  [ -x "$VIS" ] && return 0
  for p in $B/visible/wlr-screencopy-unstable-v1.xml; do
    n=$(basename $p .xml)
    wayland-scanner client-header $p $W/$n-client.h && wayland-scanner private-code $p $W/$n.c || return 1
  done
  cc -O2 -I$W -o $VIS $B/visible/viscap.c $W/$n.c -lwayland-client || return 1
}

headless_up
hyprctl eval "hl.monitor({ output = \"$CAP\", mode = \"1920x1080@$HZ\", position = \"auto\", scale = 1 })" >/dev/null
sleep 1
trap 'kill $VISCAP 2>/dev/null; headless_down; rm -rf "$TMP"' EXIT
TMP=$(mktemp -d "${TMPDIR:-/tmp}/glass-bench-screen.XXXXXX")
build || { echo "cannot build viscap" >&2; exit 1; }

read MW MH < <(hyprctl monitors -j | CAP=$CAP python3 -c '
import json, os, sys
m = [m for m in json.load(sys.stdin) if m["name"] == os.environ["CAP"]]
print(*(m and [m[0]["width"], m[0]["height"]] or [""]))')

# One bright block per key. The program reads one key, prints its block,
# and stays put; the number in the block tells the frames apart.
RUN=$W/run
: > "$RUN.py"
cat > "$RUN.py" <<'PY'
import os, sys, time
n = int(sys.argv[1]); log = open(sys.argv[2], "w")
fd = sys.stdin.fileno()
import termios, tty
old = termios.tcgetattr(fd)
tty.setraw(fd)
def block(i):
    # A solid bright-red block with the count in it, so a frame showing
    # key i is told from one still showing key i-1.
    return "\x1b[48;2;255;0;0m\x1b[2J\x1b[H\x1b[7m key %d \x1b[0m" % i
try:
    for i in range(n):
        b = os.read(fd, 64)
        t = time.time_ns()
        sys.stdout.write(block(i)); sys.stdout.flush()
        log.write("%d %d\n" % (t, i)); log.flush()
        if b"q" in b: break
finally:
    termios.tcsetattr(fd, termios.TCSADRAIN, old)
PY

winfo() { run_windows | awk -v c="bench-keys" '$2==c {print $1, $3; exit}'; }

for t in ${TERMS:-glass}; do
  LOG=$W/keys-$t.log
  rm -f "$LOG" "$W/frames-$t.vis"
  case $t in
    glass) CMD="python3 -I $RUN.py $N $LOG";;
    kitty) CMD="python3 -I $RUN.py $N $LOG";;
  esac
  if [ -n "${LOAD:-}" ]; then
    CMD="sh -c 'yes | head -c 200000000 > /dev/stdout & exec $CMD'"
  fi
  launch "$([ $t = glass ] && echo "${GLASS} --class bench-keys -e $CMD" || echo "kitty --class bench-keys $CMD")"
  sleep 3
  read -r pid addr < <(winfo)
  [ -n "$addr" ] || { echo "no window"; exit 1; }
  # viscap watches a patch of the output where the key's block shows.
  $VIS "$CAP" $((MW/2-32)) $((MH/2-32)) 64 64 "$W/frames-$t.vis" &
  VISCAP=$!
  sleep 1
  : > "$W/sent-$t"
  for i in $(seq $N); do
    date +%s%N >> "$W/sent-$t"
    hyprctl eval "hl.dispatch(hl.dsp.send_shortcut({ mods = \"\", key = \"a\", window = \"address:$addr\" }))" >/dev/null
    sleep 0.12
  done
  hyprctl eval "hl.dispatch(hl.dsp.send_shortcut({ mods = \"\", key = \"q\", window = \"address:$addr\" }))" >/dev/null
  sleep 1
  kill $VISCAP 2>/dev/null; VISCAP=
  kill "$pid" 2>/dev/null
  wait_gone
  sleep 0.5
done

# Turn the sent times, the program's read times and the frames into
# key-to-pty and key-to-screen numbers.
python3 - "$W" "$TAG" <<'PY'
import glob, os, statistics as st, sys
W, TAG = sys.argv[1], sys.argv[2]
per_term = {}
for path in glob.glob(os.path.join(W, "sent-*.log")) + glob.glob(os.path.join(W, "sent-*")):
    t = os.path.basename(path).split("-", 1)[1].split(".")[0]
    lines = [l for l in open(path).read().splitlines() if l.strip()]
    if not lines:
        continue
    sent = [int(x) for x in lines]
    keylog = os.path.join(W, "keys-%s.log" % t)
    pty = []
    if os.path.exists(keylog):
        got = [(int(l.split()[0]), int(l.split()[1])) for l in open(keylog) if l.strip()]
        pty = sorted((g - s) / 1e6 for s, (g, i) in zip(sent, got))
    vis = os.path.join(W, "frames-%s.vis" % t)
    screen = []
    if os.path.exists(vis):
        raw = open(vis).read().splitlines()
        off = int(raw[0].split()[3])
        # seq ready_mono recv_mono r g b nmag npix
        frames = [tuple(map(int, l.split())) for l in raw if l and not l.startswith("#")]
        # A key's block fills the patch with red until the next key's
        # block replaces it, so key i is on screen from the first red
        # frame at or after its read.
        red = [f[1] + off for f in frames if f[3] > 140 and f[4] < 100 and f[5] < 100]
        got = [(int(l.split()[0]), int(l.split()[1])) for l in open(keylog)] if os.path.exists(keylog) else []
        screen = sorted((min(r for r in red if r >= g) - s) / 1e6 for s, (g, i) in zip(sent, got)) if got and red else []
    def stats(v):
        return "n=%d median=%.2f p90=%.2f min=%.2f" % (len(v), st.median(v), v[int(len(v) * .9)], v[0]) if v else "n=0"
    print("%s key_to_pty_ms %s" % (t, stats(pty)))
    print("%s key_to_screen_ms %s" % (t, stats(screen)))
PY
