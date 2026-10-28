#!/bin/sh
# in-term.sh SCRIPT ARGS...: runs a bench script inside the terminal under
# test. It waits a second first, since Ghostty sizes its window a moment
# after the program starts. BENCH_TERM_PID is set to the terminal's own pid
# (its nearest glass or ghostty ancestor), so the CPU time measured is the
# terminal's.
p=$$
while [ "$p" -gt 1 ]; do
  c=$(ps -o comm= -p "$p")
  case "$c" in *ghostty|*/glass|glass) break;; esac
  p=$(ps -o ppid= -p "$p" | tr -d " ")
done
sleep 1
BENCH_TERM_PID=$p exec /usr/bin/python3 -I "$@"
