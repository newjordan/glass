#!/bin/bash
# Retained command for this experiment, cyclic balance (NOT full permutations).
# First recorded launch was issued interactively with this loop. Its final
# compare-tput.py invocation had unsupported --base/--candidate/--out flags;
# that error is retained in terminal-run.log. Use summarize-terminal.py below.
set -euo pipefail
E=bench/results/2026-11-03-row-alignment/terminal
mkdir "$E"  # Fresh output only; do not replace a recorded run.
for cycle in $(seq 1 6); do
  for entry in 'glass glass-alt ghostty' 'glass-alt ghostty glass' 'ghostty glass glass-alt'; do
    round=$(( (cycle-1)*3 + 1 ))
    case "$entry" in 'glass-alt ghostty glass') round=$((round+1));; 'ghostty glass glass-alt') round=$((round+2));; esac
    CAP=GLASSI12ALIGN BENCH_WS=7712 GLASS=/tmp/glass-i12-control-bin GLASS_ALT=/tmp/glass-i12-aligned-bin TERMS="$entry" ROUNDS="$round" OUT="$E" bash bench/run-tput.sh
  done
done
python3 -I bench/results/2026-11-03-row-alignment/summarize-terminal.py
