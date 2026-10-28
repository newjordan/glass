#!/bin/bash
# The rest, for each terminal in turn, on a headless output:
#  - startup: launch until the program inside is running (8 launches;
#    run-startup.sh is the fuller version, with the window's own time);
#  - an idle window: resident memory, threads, VRAM (nvidia-smi, NVIDIA
#    only) and CPU over 10 s;
#  - key latency: a key sent through Hyprland until the program reads it
#    (keys.py logs each read), 40 keys.
# The key logs go to $OUT/keys-<terminal>.log and $OUT/sent-<terminal>.log.
#
#   TERMS  the terminals (glass kitty)
#   OUT    where the logs go (bench/results/local)
#   CAP    the headless output's name (GLASSCAP)
#   GLASS, GLASS_ALT, KITTY   the binaries (see lib.sh)
set -u
B=$(dirname "$(readlink -f "$0")")
. "$B/lib.sh"
OUT=${OUT:-$B/results/local}
mkdir -p "$OUT"
OUT=$(readlink -f "$OUT")
TMP=$(mktemp -d "${TMPDIR:-/tmp}/glass-bench-misc.XXXXXX")
headless_up
trap 'headless_down; rm -rf "$TMP"' EXIT
# The pid and address of the window of class bench-<terminal>.
winfo() { run_windows | awk -v c="bench-$1" '$2==c {print $1, $3; exit}'; }
cpu() { awk '{print $14+$15}' "/proc/$1/stat"; }
for t in ${TERMS:-glass kitty}; do
  # Startup: launch until the program inside is running.
  ds=()
  for i in 1 2 3 4 5 6 7 8; do
    f=$TMP/start-$t
    rm -f "$f"
    t0=$(date +%s%N)
    launch "$(term_cmd "$t" "bench-$t" "sh -c 'date +%s%N > $f'")" || exit 1
    for j in $(seq 400); do [ -s "$f" ] && break; sleep 0.005; done
    [ -s "$f" ] && ds+=($(( ($(cat "$f") - t0) / 1000000 )))
    sleep 1.5
  done
  echo "$t startup_ms ${ds[*]}"
  # Idle window: memory, VRAM, CPU over 10 s.
  launch "$(term_cmd "$t" "bench-$t" "sleep 40")"
  sleep 5
  read -r pid addr < <(winfo "$t")
  rss=$(awk '/VmRSS/{print $2}' "/proc/$pid/status")
  pss=$(awk '/^Pss:/{print $2}' "/proc/$pid/smaps_rollup")
  thr=$(ls "/proc/$pid/task" | wc -l)
  vram=n/a
  command -v nvidia-smi >/dev/null && vram=$(nvidia-smi | awk -v p="$pid" '$5==p{print $(NF-1)}')
  c0=$(cpu "$pid"); sleep 10; c1=$(cpu "$pid")
  echo "$t idle pid=$pid rss_mb=$((rss / 1024)) pss_mb=$((pss / 1024)) threads=$thr vram=${vram:-none} idle_cpu_ticks_10s=$((c1 - c0))"
  kill "$pid"
  wait_gone
  sleep 1
  # Input latency: key sent through Hyprland until the program reads it.
  log=$OUT/keys-$t.log
  sent=$OUT/sent-$t.log
  rm -f "$log"
  launch "$(term_cmd "$t" "bench-$t" python3 -I "$B/keys.py" "$log")"
  sleep 3
  read -r pid addr < <(winfo "$t")
  : > "$sent"
  for i in $(seq 40); do
    date +%s%N >> "$sent"
    hyprctl eval "hl.dispatch(hl.dsp.send_shortcut({ mods = \"\", key = \"a\", window = \"address:$addr\" }))" >/dev/null
    sleep 0.12
  done
  hyprctl eval "hl.dispatch(hl.dsp.send_shortcut({ mods = \"\", key = \"q\", window = \"address:$addr\" }))" >/dev/null
  sleep 1
  wait_gone
  python3 - "$sent" "$log" "$t" <<'PY'
import sys, statistics as st
sent = [int(x) for x in open(sys.argv[1])]
got = [int(l.split()[0]) for l in open(sys.argv[2]) if "a" in l.split(" ", 1)[1]]
d = sorted((g - s) / 1e6 for s, g in zip(sent, got))
print(sys.argv[3], "key_to_pty_ms n=%d median=%.2f p90=%.2f min=%.2f" % (len(d), st.median(d), d[int(len(d) * .9)], d[0]))
PY
done
