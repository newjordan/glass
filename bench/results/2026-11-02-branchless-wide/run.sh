#!/bin/bash
set -euo pipefail
D=bench/results/2026-11-02-branchless-wide
while kill -0 3198029 2>/dev/null; do sleep 5; done
cargo test --release -p glass-term plain_runs_match_the_parser -- --nocapture > "$D/differential.log" 2>&1
cp target/release/deps/glass-1153e7f1f5d5d9af /tmp/glass-i5-branchless-test
python3 -I bench/engine-pairs.py /tmp/glass-i5-control-test /tmp/glass-i5-branchless-test --out "$D/engine-pairs.json" --pairs 11 > "$D/engine-pairs.log" 2>&1
cat "$D/engine-pairs.log"
