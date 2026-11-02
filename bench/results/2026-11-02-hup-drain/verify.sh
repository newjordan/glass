#!/bin/bash
set -euo pipefail
D=bench/results/2026-11-02-hup-drain
exec > >(tee "$D/verification.log") 2>&1
export RUSTDOC="$(dirname "$RUSTC")/rustdoc"
run() {
  local log=$1; shift
  printf '\nRUN %s:' "$log"; printf ' %q' "$@"; printf '\n'
  set +e
  "$@" > "$D/$log.log" 2>&1
  local rc=$?
  set -e
  printf '%s %s\n' "$log" "$rc" | tee -a "$D/verification-exits.txt"
  tail -8 "$D/$log.log"
  return "$rc"
}
sha256sum crates/term/src/engine.rs crates/term/src/read_ahead.rs > "$D/source-hashes.txt"
cp crates/term/src/read_ahead.rs "$D/selected-read_ahead.rs"
run build cargo build --release -p glass-term --locked
cp target/release/glass /tmp/glass-hup-final
sha256sum /tmp/glass-hup-final /tmp/glass-recycle-final > "$D/binary-hashes.txt"
run workspace-tests cargo test --workspace --lib --bins --locked -- --skip vulkan_headless
run terminal-reference-tests cargo test -p glass-alacritty-terminal --locked
run doc-tests cargo test --workspace --doc --locked
run clippy cargo clippy --workspace --all-targets --locked
run diff-check git diff --check
run throughput env GLASS=/tmp/glass-hup-final GLASS_ALT=/tmp/glass-recycle-final python3 bench/compare-tput.py "$D/gate" --rounds 18
run quiet-rtt env GLASS=/tmp/glass-hup-final GLASS_ALT=/tmp/glass-recycle-final OUT="$D/rtt" ROUNDS=6 N=300 bash bench/run-pty-rtt.sh
sha256sum --check "$D/source-hashes.txt"
cp /tmp/glass-hup-final target/release/glass
sha256sum target/release/glass > "$D/restored-executable.txt"
printf '\nFinal-source commands completed; inspect scores, not only exits.\n'
