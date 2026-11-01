#!/bin/bash
# (c) Launch until the program's first output is visible on screen.
#
# What it measures. The program a terminal runs paints, as the very first
# thing it does, the whole screen magenta (\e[48;2;255;0;255m\e[2J) and keeps
# it there. (c) is the time from launch to the first frame the compositor
# puts out on the output with that magenta in it. Same runs also give
#  (a) launch until the program is running (it records $EPOCHREALTIME
#      before it paints; same idea as run-startup.sh's (a)),
#  (b) launch until Hyprland's `openwindow` event (run-startup.sh's (b)),
#  (w) launch until the window first shows at all (any change at the
#      sampled spot: for glass that is its early CPU frame, for kitty its
#      first frame, whatever colour it is).
# "Launch" is the wall-clock time taken right before the hyprctl dispatch,
# exactly as in run-startup.sh.
#
# How. A headless output (CAP, default VISCAP) is set to HZ (default 240).
# visible/viscap.c, a wlr-screencopy client, keeps one frame request open on
# a 64x64 region at the centre of that output at all times, so it receives
# every frame the compositor renders there (capture forces a render each
# refresh) together with the compositor's monotonic timestamp of that frame;
# it logs the mean colour of each one. The first frame after launch whose
# region is mostly magenta gives (c).
#
# Resolution. One output frame: 1000/HZ ms (4.17 ms at 240 Hz). A frame's
# timestamp is when the compositor finished it; a physical display would
# then scan it out at its next refresh, the same for every terminal. Some
# frames are not captured (the next request was late): each run reports the
# gap since the previous captured frame (c_frame_gap_ms); when that gap is
# over 1.5 periods the marker may have been on screen up to that much earlier.
# Calibration: visible/calclient.c, a plain Wayland client, switches its
# window to and from magenta at known moments and asks for wp_presentation
# feedback; the session reports commit -> first captured frame and how the
# frame timestamps sit against Hyprland's own presentation times. It runs
# before and after the terminal runs.
#
# Windows get one window rule, matched to class ^bench-vis\..*$ only: no
# open animation (a fade would delay the marker reaching full colour) and
# opacity 1. It and the headless monitor rule are undone at the end.
#
# Control. Capturing makes the compositor render the output every refresh,
# which could itself change how fast a terminal starts. So every launch with
# capture on ("cap") is followed by one with viscap stopped ("nocap"), which
# gives (a) and (b) only; compare the two to see what the capture costs.
#
# Env: TERMS (glass kitty), RUNS (12), HZ (240), RES (1920x1080), CAP (VISCAP), MODES
# ("cap nocap"; "cap" alone skips the control), OUT (results JSON, default
# bench/results/local/visible-<date>.json). The terminals take turns run by run,
# alternating which goes first. "kitty-noconf" is kitty --config NONE; any
# other terminal is opened with lib.sh's term_cmd.
# GLASS and KITTY name the binaries (glass and kitty from PATH). The session
# directory goes under $TMPDIR (/tmp) and is kept; it is small.
# Needs cc, wayland-scanner, wayland-protocols and libwayland-client to build
# the two helpers.
set -u
B=$(dirname "$(readlink -f "$0")")
CAP=${CAP:-VISCAP}; HZ=${HZ:-240}; RUNS=${RUNS:-12}; TERMS=${TERMS:-glass kitty}; MODES=${MODES:-cap nocap}
# For term_cmd; the script's own launch and cleanup below replace lib.sh's.
. "$B/lib.sh"
OUT=${OUT:-$B/results/local/visible-$(date +%Y%m%d).json}; mkdir -p "$(dirname "$OUT")"
W=$(mktemp -d "${TMPDIR:-/tmp}/glass-bench-visible-$(date +%Y%m%d-%H%M%S).XXXX")
SOCK=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/hypr/${HYPRLAND_INSTANCE_SIGNATURE:-}/.socket2.sock
[ -S "$SOCK" ] || { echo "no Hyprland event socket at $SOCK" >&2; exit 1; }

# Build the two helpers into the session directory.
for p in $B/visible/wlr-screencopy-unstable-v1.xml /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml \
         /usr/share/wayland-protocols/stable/presentation-time/presentation-time.xml; do
  n=$(basename $p .xml); wayland-scanner client-header $p $W/$n-client.h && wayland-scanner private-code $p $W/$n.c || exit 1
done
cc -O2 -I$W -o $W/viscap $B/visible/viscap.c $W/wlr-screencopy-unstable-v1.c -lwayland-client || exit 1
cc -O2 -I$W -o $W/calclient $B/visible/calclient.c $W/xdg-shell.c $W/presentation-time.c -lwayland-client || exit 1

PIDS=""
mine() { hyprctl clients -j | python3 -c 'import json,sys; print(" ".join(str(c["pid"]) for c in json.load(sys.stdin) if c["class"].startswith("bench-vis.")))'; }
cleanup() {
  # Close our windows first, so nothing moves onto a real monitor.
  for k in $(seq 40); do p=$(mine); [ -z "$p" ] && break; kill $p 2>/dev/null; sleep 0.25; done
  p=$(mine); [ -n "$p" ] && kill -9 $p 2>/dev/null; sleep 0.5
  kill -CONT $PIDS 2>/dev/null; kill $PIDS 2>/dev/null
  hyprctl eval 'if _G.bench_vis_rule then _G.bench_vis_rule:set_enabled(false) end' >/dev/null
  hyprctl eval "hl.monitor({ output = \"$CAP\", mode = \"preferred\", position = \"auto\", scale = 1 })" >/dev/null
  [ -z "$(mine)" ] && hyprctl output remove $CAP >/dev/null
  hyprctl eval 'if _G.bench_vis_ws then _G.bench_vis_ws:set_enabled(false); _G.bench_vis_ws = nil end' >/dev/null
}
trap cleanup EXIT

# The output's own workspace, named before it is made: otherwise Hyprland
# may hand it the one a real monitor shows. A workspace and an output each
# take the first rule that names them, so the number is the run's own and
# the rule is switched off again at the end (cleanup).
VWS=${BENCH_WS:-$((1000 + $$ % 9000))}
hyprctl eval "_G.bench_vis_ws = hl.workspace_rule({ workspace = \"$VWS\", monitor = \"$CAP\", default = true })" >/dev/null
hyprctl output create headless $CAP >/dev/null; sleep 0.5
hyprctl eval "hl.monitor({ output = \"$CAP\", mode = \"$RES@$HZ\", position = \"auto\", scale = 1 })" >/dev/null; sleep 1
read WS MW MH MHZ < <(hyprctl monitors -j | CAP=$CAP python3 -c 'import json,os,sys
m=[m for m in json.load(sys.stdin) if m["name"]==os.environ["CAP"]]
print(*(m and [m[0]["activeWorkspace"]["id"], m[0]["width"], m[0]["height"], m[0]["refreshRate"]] or [""]))')
# No headless output found: stop rather than open windows on a real monitor.
[ -n "$WS" ] || { echo "no headless output $CAP" >&2; exit 1; }
# Should the rule not hold and the output be given a workspace with
# windows: stop rather than run among them.
if hyprctl clients -j | WS=$WS python3 -c 'import json,os,sys; sys.exit(0 if any(str(c["workspace"]["id"]) == os.environ["WS"] for c in json.load(sys.stdin)) else 1)'; then
  echo "headless output $CAP was given workspace $WS, which holds windows; stopping" >&2
  hyprctl output remove $CAP >/dev/null
  exit 1
fi
echo "output $CAP ${MW}x${MH}@$MHZ workspace $WS; session $W"
hyprctl eval '_G.bench_vis_rule = hl.window_rule({ name = "bench-vis", match = { class = "^bench-vis\\..*$" }, no_anim = true, tag = "-default-opacity", opacity = "1 1" })' >/dev/null

# The headless output's workspace, read again before every launch: another
# output appearing can take a workspace back (Hyprland returns workspaces to
# the output they were made on).
capws() { hyprctl monitors -j | CAP=$CAP python3 -c 'import json,os,sys; print(*[m["activeWorkspace"]["id"] for m in json.load(sys.stdin) if m["name"]==os.environ["CAP"]])'; }
target() { WS=$(capws); [ -n "$WS" ] || { echo "headless output $CAP is gone" >&2; exit 1; }; echo $WS > $W/expect; }
check() { [ -s $W/misplaced ] && { echo "a window left $CAP; stopping:" >&2; cat $W/misplaced >&2; exit 1; }; return 0; }
launch() { hyprctl eval "hl.dispatch(hl.dsp.exec_cmd([[$1]], { workspace = \"$WS silent\" }))" >/dev/null; }
# The program: note the time, paint the marker, hold it. foot, Alacritty
# and WezTerm start it at 80x24 and resize once the window is tiled, and
# the cells a resize adds are blank, so it paints again on SIGWINCH (the
# sleep runs in the background, since a trap waits for a foreground one).
prog() { echo "sh -c 't=\$EPOCHREALTIME; m() { printf \"\\033[?25l\\033[48;2;255;0;255m\\033[2J\"; }; trap m WINCH; m; echo \$t > $1; sleep 2 & while ! wait \$!; do kill -0 \$! 2>/dev/null || break; done'"; }
cmd() { case $1 in
  glass) echo "GLASS_STARTUP_TRACE=1 ${GLASS:-glass} --class bench-vis.glass -e $2 2>$3";;
  kitty) echo "${KITTY:-kitty} --class bench-vis.kitty $2 2>$3";;
  kitty-noconf) echo "${KITTY:-kitty} --config NONE --class bench-vis.kitty-noconf $2 2>$3";;
  # A second glass build, to compare two in one run.
  glass-alt) echo "GLASS_STARTUP_TRACE=1 ${GLASS_ALT:?GLASS_ALT names a second glass binary} --class bench-vis.glass-alt -e $2 2>$3";;
  *) echo "$(term_cmd $1 bench-vis.$1 "$2") 2>$3";;
esac; }

nvidia-smi --query-gpu=timestamp,utilization.gpu,memory.used --format=csv,noheader -lms 500 > $W/gpu.csv 2>/dev/null & PIDS+=" $!"
$W/viscap $CAP $((MW/2-32)) $((MH/2-32)) 64 64 $W/frames.vis & VISCAP=$!; PIDS+=" $VISCAP"
: > $W/events.log; : > $W/misplaced
# Hyprland's event socket, read as events come: openwindow (with its
# workspace), and anything that moves workspaces or outputs. A bench window
# that opens anywhere but the expected workspace, or whose workspace is moved
# off the headless output, is killed at once and noted in "misplaced".
python3 -I -c '
import json, os, socket, subprocess, sys, time
sock, evf, W, cap = sys.argv[1:5]
s = socket.socket(socket.AF_UNIX); s.connect(sock); out = open(evf, "a"); buf = b""
def expect():
    try: return open(W + "/expect").read().strip()
    except OSError: return ""
def kill_misplaced(why):
    try:
        mons = {m["id"]: m["name"] for m in json.loads(subprocess.run(["hyprctl", "monitors", "-j"], capture_output=True, text=True).stdout)}
        cl = json.loads(subprocess.run(["hyprctl", "clients", "-j"], capture_output=True, text=True).stdout)
    except Exception:
        mons, cl = {}, []
    for c in cl:
        if c.get("class", "").startswith("bench-vis.") and (mons.get(c.get("monitor")) != cap or str(c["workspace"]["name"]) != expect()):
            try: os.kill(c["pid"], 9)
            except OSError: pass
    with open(W + "/misplaced", "a") as f: f.write("%d %s\n" % (time.time_ns(), why))
while True:
    d = s.recv(65536)
    if not d: break
    t = time.time_ns(); buf += d
    *lines, buf = buf.split(b"\n")
    for l in lines:
        ev, _, data = l.decode(errors="replace").partition(">>")
        if ev == "openwindow":
            f = data.split(",", 3)
            if len(f) >= 3:
                out.write("%d openwindow %s %s\n" % (t, f[2], f[1])); out.flush()
                if f[2].startswith("bench-vis.") and f[1] != expect(): kill_misplaced("%s opened on workspace %s" % (f[2], f[1]))
        elif ev in ("moveworkspacev2", "monitoraddedv2", "monitorremovedv2", "createworkspacev2", "destroyworkspacev2"):
            out.write("%d %s %s\n" % (t, ev, data)); out.flush()
            if ev == "moveworkspacev2":
                f = data.split(",")
                if len(f) >= 3 and f[1] == expect() and f[2] != cap: kill_misplaced("workspace %s moved to %s" % (f[1], f[2]))
' "$SOCK" $W/events.log $W $CAP & PIDS+=" $!"
sleep 1

gone() { for k in $(seq 40); do [ -z "$(mine)" ] && return; sleep 0.25; done; kill $(mine) 2>/dev/null; sleep 0.5; }
calibrate() { target; launch bench-vis.cal "$W/calclient bench-vis.cal 30 > $W/cal-$1.txt 2>&1"; sleep 1; for k in $(seq 60); do [ -z "$(mine)" ] && break; sleep 0.25; done; gone; sleep 0.5; }

calibrate pre; check
: > $W/runs.txt
set -- $TERMS
for i in $(seq $RUNS); do
  # Alternate which terminal goes first.
  if [ $((i % 2)) = 1 ]; then order="$*"; else order=$(printf '%s\n' "$@" | tac | tr '\n' ' '); fi
  for t in $order; do
    for mode in $MODES; do
      # Capture off: viscap is stopped, so nothing forces the output to render.
      [ $mode = nocap ] && kill -STOP $VISCAP
      c=$(cmd $t "$(prog $W/start-$i-$t-$mode)" $W/trace-$i-$t-$mode)
      target
      t0=$(date +%s%N)
      launch "bench-vis.$t" $c
      echo "$i $t $mode $t0 $WS" >> $W/runs.txt
      sleep 2.5; gone; check
      [ $mode = nocap ] && kill -CONT $VISCAP
      sleep 1
    done
  done
done
calibrate post; check
sleep 0.3
kill $PIDS 2>/dev/null; PIDS=""
python3 -c 'import time; print(time.clock_gettime_ns(time.CLOCK_REALTIME) - time.clock_gettime_ns(time.CLOCK_MONOTONIC))' > $W/clock-end
cleanup; trap - EXIT
python3 -I $B/visible/analyze.py $W $MHZ > $OUT || exit 1
python3 -c '
import json, sys
d = json.load(open(sys.argv[1]))
print("frame period %.2f ms; capture: %s" % (d["frame_period_ms"], d["capture_cadence"]))
for k, c in d["calibration"].items(): print("calibration", k, "commit->frame", c["commit_to_frame_ms"], "frame-presented", c["frame_minus_presented_ms_no_missed_frame"])
print("gpu", d["gpu_during_runs"])
for t, s in d["summary"].items():
    for k in ("a_program", "b_openwindow", "w_window_visible", "c_output_visible"):
        if s[k]["n"]: print("%-19s %-17s median %6s  runs %s" % (t, k, s[k]["median_ms"], s[k]["runs_ms"]))
' $OUT
echo "results $OUT; session $W"
