#!/bin/bash
# Resume after the captured rustdoc version mismatch. Preserve previous receipts.
set -euo pipefail
D=bench/results/2026-11-02-early-recycle/final
exec > >(tee "$D/resume-verification.log") 2>&1
export RUSTDOC="$(dirname "$RUSTC")/rustdoc"
run() {
  local log=$1; shift
  printf '\nRUN %s:' "$log"; printf ' %q' "$@"; printf '\n'
  set +e
  "$@" > "$D/$log.log" 2>&1
  local rc=$?
  set -e
  printf '%s %s\n' "$log" "$rc" | tee -a "$D/exits.txt"
  tail -8 "$D/$log.log"
  return "$rc"
}
sha256sum --check "$D/selected-source-hashes.txt"
run terminal-reference-matched cargo test -p glass-alacritty-terminal --locked
run doc-tests cargo test --workspace --doc --locked
run clippy cargo clippy --workspace --all-targets --locked
run diff-check git diff --check
run throughput env GLASS=/tmp/glass-recycle-final GLASS_ALT=/tmp/glass-recycle-fresh-control python3 bench/compare-tput.py "$D/gate" --rounds 18
run quiet-rtt env GLASS=/tmp/glass-recycle-final GLASS_ALT=/tmp/glass-recycle-fresh-control OUT="$D/rtt" ROUNDS=6 N=300 bash bench/run-pty-rtt.sh
cp /tmp/glass-recycle-final target/release/glass
sha256sum target/release/glass > "$D/restored-executable.txt"
sha256sum --check "$D/selected-source-hashes.txt"
printf '\nFinal commands completed; inspect measurements, not only exits.\n'
