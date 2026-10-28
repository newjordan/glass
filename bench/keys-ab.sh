#!/bin/bash
# Key-to-pty latency for two glass builds side by side, one after the
# other on the same headless output: keys-latency.sh's measure, run once
# per binary, so a change's effect and the run-to-run noise it sits in
# come out together. Same variables as keys-latency.sh (GLASS, N, CAP,
# TAG, LOAD), plus:
#
#   GLASS_ALT  the second glass binary (required)
#   ROUNDS     how many times the pair runs, alternating (default 1)
set -u
B=$(cd "$(dirname "$0")" && pwd)
[ -n "${GLASS:-}" ] && [ -n "${GLASS_ALT:-}" ] || { echo "GLASS and GLASS_ALT name the two binaries" >&2; exit 1; }
ROUNDS=${ROUNDS:-1}
for round in $(seq "$ROUNDS"); do
  TAG=${TAG_A:-$(basename "$GLASS")}-$round N=${N:-40} "$B/keys-latency.sh"
  TAG=${TAG_B:-$(basename "$GLASS_ALT")}-$round N=${N:-40} GLASS=$GLASS_ALT "$B/keys-latency.sh"
done
