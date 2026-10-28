#!/bin/bash
# take-mindseye.sh <out.mp4> <seconds> [demo args]: one recorded take of the
# mind's eye film, full-screen on a headless output, filmed by glass itself
# (GLASS_RECORD) through ffmpeg and the GPU's encoder.
#
#   TARGET          the cargo target dir holding glass and the example
#                   (the repo's target/release)
#   GLASS_RECORD_CODEC   the ffmpeg encoder (hevc_nvenc; libx264 without NVENC)
#   MINDSEYE_BENCH  the scoreboard the film draws (bench/scoreboard-20261027b.json)
#   MINDSEYE_ASSETS the glTF figures for --surreal (not in the repo)
#   TAKE_LOGS       where glass's and the demo's stderr go (a temp dir)
#
# Build first:
#   cargo build --release -p glass-term --bin glass --example glass_mindseye
#   bench/take-mindseye.sh film.mp4 95 --surreal
set -u
B=$(dirname "$(readlink -f "$0")")
REPO=$(dirname "$B")
T=${TARGET:-$REPO/target/release}
LOGS=${TAKE_LOGS:-$(mktemp -d "${TMPDIR:-/tmp}/glass-mindseye-take.XXXXXX")}
mkdir -p "$LOGS"
[ $# -ge 2 ] || { echo "usage: $0 <out.mp4> <seconds> [demo args]" >&2; exit 2; }
OUT=$(readlink -f "$1")
SECS=$2
shift 2
[ -x "$T/glass" ] && [ -x "$T/examples/glass_mindseye" ] || { echo "build glass and the glass_mindseye example into $T first" >&2; exit 1; }
BENCH=${MINDSEYE_BENCH:-$B/scoreboard-20261027b.json}
CAP=${CAP:-MINDCAP}
. "$B/lib.sh"
headless_up
trap headless_down EXIT
rm -f "$OUT" "$LOGS/glass.log" "$LOGS/demo.log"
launch "sh -c 'MINDSEYE_BENCH=$BENCH GLASS_OPACITY=1 GLASS_WALLPAPER=none GLASS_PADDING=0 GLASS_RECORD=$OUT GLASS_RECORD_SECONDS=$SECS GLASS_RECORD_DELAY_MS=900 exec $T/glass --class mindseye --hold -e sh -c \"sleep 1.2; exec $T/examples/glass_mindseye $* 2>$LOGS/demo.log\" 2>$LOGS/glass.log'"
for i in $(seq 50); do
  ADDR=$(run_windows | awk '$2=="mindseye" {print $3; exit}')
  [ -n "$ADDR" ] && break
  sleep 0.1
done
hyprctl eval "hl.dispatch(hl.dsp.window.fullscreen({ window = \"address:$ADDR\" }))" >/dev/null 2>&1
sleep 0.5
for i in $(seq $((SECS + 60))); do grep -q 'GLASS: recorded' "$LOGS/glass.log" 2>/dev/null && break; sleep 1; done
sleep 1
# The demo, then the window it ran in (it holds after the demo exits).
pkill -x -f "$T/examples/glass_mindseye.*" 2>/dev/null
run_windows | awk '$2=="mindseye" {print $1}' | xargs -r kill 2>/dev/null
grep GLASS "$LOGS/glass.log"
cat "$LOGS/demo.log"
echo "logs: $LOGS"
