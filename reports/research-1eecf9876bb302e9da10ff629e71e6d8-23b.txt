# Stable replay supplement — parser-authority screen unchanged

Supersedes only the checkpoint command from commit 02756e5. Runtime, binary,
raw performance pairs, decisions and previous reports are **unchanged**.

The first and post-commit checkpoint both exited zero. An additional replay
exited one with `ValueError: corruption replay changed`. The real stale-build
receipt has three simultaneously fresh (stale-for-this-purpose) package rows.
`build-engine-arm.py` checks a Python set, so across processes it may report
VTE, Glass, or alacritty_terminal first. Sixteen fixed hash seeds reproduce
all three messages; all 17 challenges are rejected under every seed. The full
structured-report equality in the initial verifier was too strict about this
incidental diagnostic. **The original checkpoint command is intermittent and
must not be used as the reliable canonical checkpoint.** The failure receipt,
original verifier, original evidence hashes and reports are retained untouched.

The supplemental verifier keeps the original checkpoint's logic but explicitly
normalizes only `actual_stale_control_receipt` to one of those three allowed
messages. It requires exactly one such case and rejected=true; no unknown
reason is allowed. Every other case field, diagnostic, digest and preservation
flag must match exactly. Six normalization tests cover all three reasons,
non-mutation, unapproved reasons, false status, missing/duplicate incidents,
other diagnostics, flags and digests. No correctness or performance gate is
weakened. Original frozen documentation hashes replay against exact captured
snapshots; no prior artifact is edited. Separate supplemental hashes cover
this verifier and explanation.

Reliable read-only checkpoint:

```sh
python3 -B bench/results/2026-11-03-parser-authority-replay/verify.py
python3 -B bench/results/2026-11-03-parser-authority-replay/test-normalization.py -v
```

The original result remains: 11 paired engine runs, candidate/control CPU
throughput 1.064495 ASCII, 1.068099 scroll-region, **.922042 truecolor**.
The .98 all-workload guard fails, so runtime is rejected/restored. No new
Ghostty or terminal timing, and no world-champion or all-metric win claim.
382 tests per arm, 12,800 streams per arm, 1,092 boundary scenarios per correct
arm, 65 main Python tests plus six supplemental tests, 17 corruption challenges.
119 other crate Rust sources, 5,994 prior tracked artifacts and the selected
executable remain unchanged. Post-commit checkpoint and multi-seed replay
results are retained separately as explicit receipts, not claimed acceptance.
