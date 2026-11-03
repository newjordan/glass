# Safe padding-ID marks: Unicode +25.36%, all-metric screen rejected

**Outcome: research only; candidate and common API migration restored out of
shipping.** The exact original runtime sources and `target/release/glass` are
unchanged. The no-op COW fix already shipping at `0247d6d` remains intact. No
Ghostty/PTY benchmark was launched for this candidate and no championship or
all-metric lead is established.

Starting commit: `307b997` (full revision and hashes in `starting-state.json`).
Prospective protocol: `protocol.json`, frozen before the first build or timing.
Linux x86-64, configured rustc 1.99.0; a mismatched rustdoc diagnostic was resolved
by setting `RUSTDOC` to the rustdoc beside `RUSTC`, not by dropping doctests.

## New finding: a safe ownership route fits the existing cell stride

The earlier static-mark prototype required tagged raw pointers, manual Arc strong
counts and unsafe trait implementations. This prototype does not promote that
implementation. A private `u16` dictionary ID plus an ordinary private
`Option<Arc<CellExtra>>` fits a **24-byte Cell, alignment 8** on this host. A
112-entry process-wide `OnceLock` dictionary supplies read-only logical content
for one mark in U+0300..U+036F. Cloning an inline singleton copies an ID, not an
Arc; destruction has no Arc to decrement. No pointer tagging or unsafe code is
added. All other scalars continue through the existing bounded Arc cache.

State transitions:

- Empty -> dictionary singleton: nonzero ID, no Arc. Empty -> other singleton:
  zero ID, ordinary Arc. Private state prevents callers creating both at once.
- Second mark, nonempty clear-wide, real underline/link mutation: clone the
  immutable content into an Arc, clear the ID, then use normal Arc COW.
- Underline/link `None` no-ops leave inline state alone. `clear_extra`, lazy-tail
  cleanup and reset clear both fields; `clear_wide` retains an allocated empty
  extra where the old representation did.
- `zerowidth`, empty/line-length detection, style equality, logical equality,
  Debug and serde all read logical content, not the Arc field alone. Wire output
  contains the original five logical fields, not the internal ID. Deserializing
  an eligible singleton canonicalizes it; empty/richer extras remain ordinary.

This is **not public-field API compatible**. Both experimental arms migrate the
call sites to `plain`, `from_template`, `has_extra` and `clear_extra`, and make
extra storage private. Only the candidate adds the ID/storage logic. Thus the
measured comparison isolates representation after a *common API migration*;
it is not a measured candidate-vs-unmodified-shipping comparison. The common
migration is in `migration.patch`; the representation delta is `candidate.patch`.
Final build source snapshots are `control-crates_*.rs` and
`candidate-crates_*.rs`, identified by `build-*/identity.json`. Shorter
`candidate-cell*.rs` snapshots are development history, not the final arm.

Padding is compiler/target dependent, not a stable Rust ABI promise. The dictionary
symbol occupies **6,280 bytes** in the candidate ELF, including initialization
state. The original one-entry thread-local cache also remains for misses. A
24-byte cell is not proof of unchanged RSS, allocations, executable footprint,
startup, cache behavior or resources on other platforms. None of those competitive
gates has been supplied for this candidate.

## Fixed 12-pair screen — stopped, no rescue run

Six generated in-memory workloads, scale 2, 4095-byte reads, best of five passes
per invocation. Exactly 12 control/candidate pairs alternate AB/BA: 24 sessions,
144 workload observations; the five internal passes are not independent trials.
All sessions retained, no pilot, exclusions, pooling or adaptive extension.
No other Glass build or test overlapped these sessions. Shared-host noise and
serial dependence remain limitations.

| Workload | median candidate/control CPU rate | median wall rate | candidate wins/losses | six-workload Holm sign p |
| --- | ---: | ---: | ---: | ---: |
| ASCII | 0.972639 | 0.973303 | 2 / 10 | 0.077148 |
| Unicode | **1.253557** | **1.253027** | **12 / 0** | **0.002930** |
| Truecolor | 0.989754 | 0.989732 | 0 / 12 | 0.002930 |
| Cursor motion | 0.999240 | 0.999621 | 5 / 7 | 0.774414 |
| Scroll region | **0.976001** | **0.975536** | **0 / 12** | **0.002930** |
| TUI frames | 0.991120 | 0.991100 | 0 / 12 | 0.002930 |

The Unicode target (>=1.02, wins > losses, Holm p < .05) clears. **ASCII and
scroll-region fail the predeclared >=.98 point guards**, so the engine screen
fails and promotion stops. Even truecolor and TUI, which clear that operational
guard, lose every pair. Point guards are not noninferiority confidence bounds;
sign tests assume independent fair signs, not established by balanced order.
There is no campaign-wide adaptive correction.

Static census of these exact ELFs: `print_utf8` grows from 8,524 bytes / 1,967
instructions to 8,706 / 2,018; stack-referencing instructions rise 420 -> 439.
`Engine::apply` is 9,774 / 2,048 -> 9,766 / 2,049. Routine entry addresses differ.
This is consistent with a trade-off worth researching, not attribution of the
regressions to any specific branch, initialization, register spill or layout.
No follow-up timing was launched after seeing the failed guards.

## Correctness and provenance

| Gate | Control | Candidate |
| --- | ---: | ---: |
| Library tests | 139 passed | 140 passed |
| Reference fixtures | 45 passed | 45 passed |
| Doctests with matching toolchain | 1 passed | 1 passed |
| Existing full terminal suite | 395 passed, 14 ignored | 395 passed, 14 ignored |
| Existing parser differential sweep | 12,800 streams | 12,800 streams |
| Cell bytes / alignment | 24 / 8 | 24 / 8 |

The common logical test covers all 112 dictionary marks, four misses, mark/style
promotion, per-cell isolation, empty/line-length behavior, reset/accessor
semantics, serde/Debug equality with an explicitly owned extra, and cross-thread
mutation. Existing no-op strong/Weak ownership tests remain. Candidate's additional
storage test, also run under debug assertions, checks ID mapping for **every
valid Unicode scalar**, no Arc for inline marks, clone/no-op behavior, second-mark
promotion and cleanup. These finite tests and shared-oracle sweeps do not prove
all terminal semantics, arbitrary serde formats, platforms or unsafe-free
performance causality.

The first candidate-cell run failed an old direct-Arc unwrap; it remains in
`candidate-cell-first.log`. Logical test adaptation did not itself count as a
pass. Source review found remaining direct empty/line-length reads and an eager
narrowing expression; those were corrected *before timing*. The first full
library command failed only in mismatched-version doctests, and the final build
wrapper initially refused to overwrite an earlier executable. Those diagnostics
and pre-final builds remain retained and are not final gate receipts. Two
read-only inspection scripts also used an incorrect manifest-shape assumption;
the final index replay uses the existing canonical replay machinery.

`verify.py` checks exact binary paths and bytes, non-fresh Cargo receipts, source
snapshots/patches, correctness invocations/censuses, recomputes every raw pair and
Holm decision, replays static disassembly, and rejects **13 metadata/key
corruptions**. The earlier frozen index matches **2,061 references / 1,966 source
versions**. It does not launch Rust tests, builds, a terminal or a benchmark.

```sh
python3 -B bench/results/2026-11-03-inline-mark-id/verify.py
```

Requires the retained exact executables named in `binaries.json`. Saved integrity
receipts are not reproducible measurements without those binaries and sources.

## Literal target delta remains open

The mandatory iteration45 campaign audit is preserved unchanged at
`../2026-11-03-campaign-audit-45/` and the original iteration45 report. Its exact
historical shipping-vs-Ghostty 30-pair throughput result still requires own-rate
improvements of **5.58% ASCII, 7.63% Unicode and 1.08% scroll-region just to reach
observed median parity**, not establish positive lead. It has corrected positive
leads for truecolor, cursor motion and TUI in that historical scope only. No
multiplication of this generated-engine ratio into that old terminal result is
valid. Later correctness fixes and this prototype were not measured in that
competitive executable. Startup, resources, displayed key/frame latency,
compatibility/platform scope and a bound acceptance command remain missing.

A next attempt must separately address the safe-ID ASCII/scroll veto without
changing the evidence or pretending the common API migration was free. Only a
new predeclared candidate that survives its own engine screen should proceed to
same-build PTY, Ghostty and missing-metric gates. This report closes the present
experiment, not the world-champion objective.
