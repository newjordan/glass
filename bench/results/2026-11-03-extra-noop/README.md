# No-op CellExtra updates: avoid unnecessary copy-on-write

## Mechanism and finite result

`Cell::push_zerowidth` used `Arc::make_mut` before discovering that a cell's
nine-mark inline buffer was full. `Cell::clear_wide` similarly copied a shared
extra even when its mark buffer was already empty. Contents did not change, but
shared strong ownership detached and a sole strong owner's `Weak` handles were
dissociated unnecessarily.

The source now checks fullness before COW and emptiness before clearing the
mark buffer. `clear_wide` still removes `WIDE_CHAR` and blanks the character.
Actual appends and nonempty clears still use `Arc::make_mut`. Public field
representation remains `Option<Arc<CellExtra>>`; there is no unsafe code or
new cache/retention policy.

Six finite cases combine empty-clear/full-append with unique ownership,
sole-strong plus Weak, and two strong owners plus Weak. Each repeats its no-op
32 times while preserving underline color and a hyperlink.

| Arm | cases | ownership detachments | cell tests |
|---|---:|---:|---|
| control | 6 | 4 | 7 passed, 1 failed |
| candidate | 6 | 0 | 8 passed, 0 failed |

A separate four-case test establishes that actual mutations still isolate the
sibling's marks and preserve attributes, including Weak dissociation where a
real mutation requires it. Both arms pass that test. Existing cache/isolation,
serde, layout-cap and line-length tests pass on candidate.

Candidate terminal integration: **395 passed, 14 ignored, 0 filtered**, exit 0.
This is a fresh Rust execution, unlike iteration45's stored-suite replay.

## Commands and receipts

```
cargo test --release -p glass-alacritty-terminal --locked term::cell::tests -- --test-threads=1 --nocapture
cargo test --release -p glass-term --locked -- --test-threads=1
python3 -B bench/results/2026-11-03-extra-noop/verify.py
```

`control.log`/`.exit`, `candidate.log`/`.exit` and
`terminal-integration.log`/`.exit` retain results. The control was intentionally
expected to exit101 on the pointer-identity oracle; this is not a failing
candidate. Initial control tests stop at the first identity assertion, then a
complete matrix uses the same source test in both final arms. The parallel
intermediate matrix log has interleaved records; final control/candidate matrix
logs are single-threaded and are the replay authority.

`original-*`, `control-cell.rs` and `production-*` retain exact snapshots.
The checkpoint requires the final candidate and control to differ only in two
runtime guards and the header comment; their diagnostic tests are identical.
Cargo stdout/stderr are direct local execution receipts, not independently
attested build/source provenance. No fresh two-arm timed executable campaign
was performed.

The prior 17-manifest package is replayed with one explicit historical source
mapping. It retains **1,980 references / 1,886 source versions**; old evidence
files and reports remain unchanged. The selected release binary stays at
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.

## Limits and next competitive action

No allocation counter or time measurement was used. The finite ownership
result and source guard establish avoided COW in those cases, not a measured
total-memory or throughput improvement. The usual benchmark has a single
combining mark per base and does not establish meaningful cap-hit incidence.
Different-key singleton-cache reuse was considered and not implemented because
that corpus repeats one combining accent. No speedup, Ghostty gap reduction,
complete Unicode compatibility or championship acceptance is claimed.

The next competitive experiment still needs an applicable Unicode hotpath
mechanism, exact-build correctness, a prospectively fixed performance screen,
and then current selected-build end-to-end metrics. The six-workload parity
gaps and missing displayed-latency/resource/startup evidence from iteration45
remain open. This small source fix is a separate verifiable ownership advance,
not a replacement for those requirements.
