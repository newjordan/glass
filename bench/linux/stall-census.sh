#!/bin/bash
# Stall census: where does glass's parse thread actually spend wall time
# under a flood? Samples /proc/<pid>/task/*/stat (CPU) and wchan of every
# glass thread at ~200 Hz while tput.py's workloads run inside it.
#
#   OUT   results dir (bench/results/local/stall-census)
#   TERM  glass | glass-alt (binary to measure)
set -u
B=$(dirname "$(readlink -f "$0")")
. "$B/../lib.sh"
OUT=${OUT:-$B/../results/local/stall-census}
mkdir -p "$OUT"
OUT=$(readlink -f "$OUT")
WHICH=${WHICH:-glass}

headless_up
trap headless_down EXIT

name=stall
out=$OUT/tput-$WHICH.json
rm -f "$out"
launch "$(term_cmd "$WHICH" "bench.$name" python3 -I "$B/../tput.py" "$out")" || exit 1

# Find the glass process once its window is up: the pid that owns class
# bench.stall. The pid in Hyprland's client list is the terminal itself.
pid=
for i in $(seq 100); do
  pid=$(run_windows | awk -v c="bench.$name" '$2==c{print $1}')
  [ -n "$pid" ] && break
  sleep 0.1
done
[ -n "$pid" ] || { echo "no window for $WHICH" >&2; exit 1; }
echo "glass pid $pid"

# Sample threads until the workload writes its result: CPU ticks and
# wchan per task, one line per sample per thread.
samples=$OUT/samples-$WHICH.txt
: > "$samples"
python3 - "$pid" "$out" "$samples" <<'EOF'
import os, sys, time
pid, out, samples = sys.argv[1], sys.argv[2], sys.argv[3]
f = open(samples, "w", buffering=1)
while not os.path.exists(out) or os.path.getsize(out) == 0:
    try:
        tasks = os.listdir(f"/proc/{pid}/task")
    except FileNotFoundError:
        break
    stamp = time.time()
    for t in tasks:
        try:
            stat = open(f"/proc/{pid}/task/{t}/stat").read()
            comm = stat.rsplit(")", 1)[0].split("(", 1)[1]
            fields = stat.rsplit(")", 1)[1].split()
            utime, stime = int(fields[11]), int(fields[12])
            wchan = open(f"/proc/{pid}/task/{t}/wchan").read().strip()
            state = fields[0]
        except (FileNotFoundError, ProcessLookupError, IndexError):
            continue
        f.write(f"{stamp:.3f} {t} {comm} {state} {utime} {stime} {wchan}\n")
    time.sleep(0.005)
f.close()
EOF

python3 -c "import json,sys; d=json.load(open(sys.argv[1])); print(sys.argv[1].split('/')[-1], {k:(v['mb_s'],v.get('term_cpu_s')) for k,v in d['results'].items()})" "$out"
echo "samples: $(wc -l < "$samples")"
