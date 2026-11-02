#!/bin/bash
# Sequential final verification; run from repository root after other measurements.
set -euo pipefail
D=bench/results/2026-11-02-early-recycle
mkdir "$D/final"
D=$D/final
exec > >(tee "$D/verification.log") 2>&1
run() {
  local log=$1
  shift
  printf '\nRUN %s:' "$log"
  printf ' %q' "$@"
  printf '\n'
  set +e
  "$@" > "$D/$log.log" 2>&1
  local rc=$?
  set -e
  printf '%s %s\n' "$log" "$rc" | tee -a "$D/exits.txt"
  tail -8 "$D/$log.log"
  return "$rc"
}
# Final verification selects the bounded two-buffer early-copy-credit variant.
python3 - <<'PY'
from pathlib import Path
import subprocess
p=Path('crates/term/src/read_ahead.rs')
s=p.read_text().replace('Only three producer hand-offs exist.', 'Only two producer hand-offs exist.').replace('all three while parsing proceeds. Thus at most three hand-offs plus the copied', 'both while parsing proceeds. Thus at most two hand-offs plus the copied').replace('const AHEAD: usize = 3;', 'const AHEAD: usize = 2;')
p.write_text(s)
assert subprocess.check_output(['git','diff','--','crates/term/src/engine.rs']) == b''
PY
cp crates/term/src/read_ahead.rs "$D/selected-read_ahead.rs"
git diff -- crates/term/src/read_ahead.rs > "$D/selected.patch"
sha256sum crates/term/src/{engine,read_ahead}.rs > "$D/selected-source-hashes.txt"
# Fresh HEAD control, built with the same toolchain and flags as the candidate.
# A failed control build must still restore the candidate source.
trap 'cp "$D/selected-read_ahead.rs" crates/term/src/read_ahead.rs' EXIT
git show HEAD:crates/term/src/read_ahead.rs > crates/term/src/read_ahead.rs
run control-build cargo build --release -p glass-term --locked
cp target/release/glass /tmp/glass-recycle-fresh-control
cp "$D/selected-read_ahead.rs" crates/term/src/read_ahead.rs
run candidate-build cargo build --release -p glass-term --locked
cp target/release/glass /tmp/glass-recycle-final
sha256sum /tmp/glass-recycle-{fresh-control,final} > "$D/binary-hashes.txt"
# Checks are sequential, never concurrent with timing runs.
run reader-tests cargo test --release -p glass-term --locked -- read_ahead::tests
cp target/release/deps/glass-1153e7f1f5d5d9af /tmp/glass-recycle-final-test
run parser-tests /tmp/glass-recycle-final-test --exact speed::plain_runs_match_the_parser
run sweep-whole env GLASS_SWEEP_SEEDS=64 GLASS_SWEEP_ROUNDS=200 /tmp/glass-recycle-final-test --ignored --exact --nocapture speed::plain_runs_match_the_parser_over_seeds
run sweep-legacy env GLASS_RUN_WHOLE=0 GLASS_SWEEP_SEEDS=64 GLASS_SWEEP_ROUNDS=200 /tmp/glass-recycle-final-test --ignored --exact --nocapture speed::plain_runs_match_the_parser_over_seeds
run workspace-tests cargo test --workspace --lib --bins --locked -- --skip atlas_gpu_tests:: --skip it_draws_on_a_real_gpu
run terminal-reference-tests cargo test -p glass-alacritty-terminal --locked
run doc-tests env RUSTDOC="$(dirname "$RUSTC")/rustdoc" cargo test --workspace --doc --locked
run clippy cargo clippy --workspace --all-targets --locked
run diff-check git diff --check
sha256sum --check "$D/selected-source-hashes.txt"
# Timing is the final phase, against the freshly rebuilt control.
run throughput env GLASS=/tmp/glass-recycle-final GLASS_ALT=/tmp/glass-recycle-fresh-control python3 bench/compare-tput.py "$D/gate" --rounds 18
run quiet-rtt env GLASS=/tmp/glass-recycle-final GLASS_ALT=/tmp/glass-recycle-fresh-control OUT="$D/rtt" ROUNDS=6 N=300 bash bench/run-pty-rtt.sh
cp /tmp/glass-recycle-final target/release/glass
sha256sum target/release/glass > "$D/restored-executable.txt"
sha256sum --check "$D/selected-source-hashes.txt"
printf '\nFinal verification commands completed; inspect exits and measured comparisons.\n'
