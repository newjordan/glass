# Split UTF-8 valid-prefix accounting — data-loss fix

## New result

A terminal input chunk can end in the middle of a UTF-8 scalar. The next call
copies up to four total bytes into `partial_utf8`. `from_utf8` can then report a
valid prefix consisting of **the completed scalar plus ASCII**, followed by an
incomplete/invalid next scalar. The parser emitted only the first character but
returned `valid_up_to() - old_bytes`, silently consuming the un-emitted ASCII.

Example: `a\u{308}b\u{301}z`, split after `a` plus the first byte of U+0308,
loses `b`. The remaining U+0301 attaches to `a` instead. This is observable text
corruption, not just incorrect accounting or a different shared-allocation ID.
It also produces an incorrect consumed-byte result with early termination.

The fix changes that return to `c.len_utf8() - old_bytes`, matching the existing
successful-buffer branch. It resets the partial length exactly as before;
ASCII and subsequent bytes remain available to the normal parser loop. Invalid
first-scalar and still-incomplete branches are unchanged. No unsafe code added,
no Cell layout/ownership changes, no reader/parser authority shortcut.

## Paired results (final source-bound arms)

| Independent check | Control | Candidate |
|---|---:|---:|
| Literal parser dispatch, 2,478 cases | **48 failures** | **0 failures** |
| Stop after first scalar, 21 cases | **2 failures** | **0 failures** |
| Literal ASCII-before-ESC/invalid/partial tails | fails | passes |
| Direct `Term::input`, 3,816 engine cases | **72 failures** | **0 failures** |
| Existing terminal suite | 395 pass, 14 ignored, new oracle skipped | **396 pass, 14 ignored** |
| Shared-parser differential sweep | 12,800 no divergence | 12,800 no divergence |

Candidate library gates: **138 unit tests, 45 reference fixtures, 1 doctest**.
Parser: **34 tests**, plus **37 tests and 1 doctest without default features**.
Read-only evidence-checker tests: **4 pass**, rejecting **14 metadata** and
**10 rehashed census** corruptions, plus duplicate JSON keys.

The literal parser matrix varies four scalar widths/base characters, six tails,
every ordered pair of byte cuts, and both advance APIs. The stopped-parser test
checks exact emitted text, exact consumed count, and literal remaining dispatch.
The engine matrix varies fast/parser modes, primary/alternate screens, widths
4/8/19, left/penultimate/right-edge cursor positions, eight base/mark strings,
two pen states, every byte cut, and literal last-scalar REP. It seeds wide cells
and old combining extras beneath the writes. Its expected path feeds Unicode
characters **directly to upstream `Term::input`**, bypassing the shared UTF-8
parser; it compares complete grid/history/cursor/template states.

**Why earlier tests missed this:** fast and slow engines both share this parser.
Their agreement (including 12,800 streams per arm here) is not proof against
shared input loss. The direct character oracle and literal parser events are
necessary, materially distinct evidence.

## Discovery and retained failures

The proposed fused-mark reuse optimization is **shelved**, restored completely,
and never timed. See `../2026-11-03-fused-mark-reuse/README.md`. Its direct oracle
failed on both prototype and unchanged runtime and led to this parser defect.
The existing Unicode row-edge test alone passed the prototype.

The first final attempt is retained under `attempt1/`. It passed normal gates
but failed to compile the new stopped-parser **test** without default features:
`String` and `ToString` were not in the no-std prelude. Explicit `std::string::String`
and the already-imported format macro repaired the test; runtime fix unchanged.
`no-default-repair.log` and the complete repeated final arms record recovery.
An initial evidence-checker negative case exposed acceptance of a negative first
timestamp; `python-tests-first.log` is retained, the check was tightened, and
all 24 corruptions now fail closed. Earlier ad hoc logs and the mistaken Cargo
package-name failure are retained, not represented as passing final receipts.

## Source/build/replay

`run.py` swaps parser source arms in place, exclusively owns the build, uses the
pre-existing `bench/build-engine-arm.py` to touch explicit inputs and require
non-fresh vte/library/terminal compiler receipts, and runs exact tests from the
resulting binaries. Test-only engine source is identical across arms. Parser
arms differ only in the one runtime return and its explanatory comment. Final
source hashes, Cargo command/receipts, logs/exits and settings are recorded in
`final-build-*/`, `final-gates.json`, and `final-*.log`. Both exact test ELFs are
retained compressed. A `finally` restores candidate parser source on failure.

Reproduction (from repository root, configured Cargo/Rust environment):

```sh
# Replay evidence read-only; does not rebuild or rerun Rust tests.
python3 -B bench/results/2026-11-03-partial-utf8-accounting/verify.py
python3 -B bench/results/2026-11-03-partial-utf8-accounting/test-verify.py

# Fresh current-source checks, separate from saved replay.
RUSTDOC="$(dirname "$RUSTC")/rustdoc" cargo test --release --locked -p vte partial_utf8_ -- --nocapture
RUSTDOC="$(dirname "$RUSTC")/rustdoc" cargo test --release --locked -p glass-term partial_utf8_chunks_match_direct_term_input -- --nocapture
RUSTDOC="$(dirname "$RUSTC")/rustdoc" cargo test --release --locked -p glass-term
```

The paired runner requires a new evidence destination/executable names for a
new experiment; do not overwrite this retained evidence. Historical replay
preserves the prior **2,164 references / 2,069 source versions** through explicit
source snapshots. Current manifest and frozen-index receipts bind this result;
post-commit receipts are saved separately to avoid self-hash cycles.

## Scope and next gate

This is a verified local source correctness fix, **not** a performance win,
new same-build PTY result, Ghostty comparison, resource measurement, official
championship acceptance, or proof of arbitrary invalid-input behavior. The
selected `target/release/glass` executable remains byte-identical; only source
and release **test** executables changed. A fresh production build and full
same-build comparative/resource/latency gates remain necessary before any
world-title claim. No acceptance command is bound to this loop.
