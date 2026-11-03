# Safe decoded-scalar-domain validation: no promotion

**Rejected runtime candidate; local research, not championship acceptance.**

## New intervention

The control decoder selects E0/ED/F0/F4-specific second-byte limits before
assembling the scalar. The candidate checks every continuation with the same
`b & 0xc0 == 0x80` predicate, assembles the scalar, then rejects values below
the per-length minimum. Safe `char::from_u32` still rejects surrogates and values
above U+10FFFF. This is not the earlier table, word-load, unchecked-construction,
call-reuse or parser-authority candidate. No extra lookahead or unsafe access.

Exactly one candidate. Frozen patch and four source snapshots precede serial
builds and timing. Both arms pass **383 terminal tests** (11 ignored), including
the pre-existing exhaustive valid-scalar/truncation/boundary decoder tests, and
**12,800 differential streams**. Control byte-matches iteration 27's exact ELF.
The build driver restores all four source files in `finally`; the final rebuilt
Cargo artifact byte-matches control. The selected release terminal is untouched.

## Prospective screen and complete result

Exactly **12 alternating AB/BA pairs**, **24 sessions**, six workloads, scale 2,
five internal repetitions, read size 4095. Each printed rate is best-of-five;
internal repetitions are not five independent trials. No pilot, exclusion,
rescue candidate, extra pair, pooling or PTY escalation. Ratios are
candidate/control engine CPU throughput.

| Workload | Median CPU ratio | Wins/12 | Six-workload Holm p |
|---|---:|---:|---:|
| ASCII | 1.004250 | 7 | 1 |
| Unicode | **1.005126** | **6** | **1** |
| Truecolor | .983740 | 2 | .192871 |
| Cursor motion | .981429 | 2 | .192871 |
| Scroll region | 1.000384 | 7 | 1 |
| TUI frames | .985766 | 1 | .038086 |

Unicode fails the >=1.02 primary target and positive-sign/corrected-significance
conditions. All six >=.98 median point guards clear; that is **not** evidence of
noninferiority. Reject the candidate. The TUI loss has 11/12 negative signs;
its Holm p is conditional on independent fair signs, which sequential balance
on this shared host does not establish.

Early pairs have large excursions. Unicode ratios range **.720639–1.463950**;
ASCII ratios range **.665660–1.213496**. All remain in the decision. No causal
host-noise diagnosis, trimmed reanalysis or replacement sessions are claimed.
The Unicode median is neither a demonstrated gain nor proof of zero effect.

## Exact timing ELF result

`print_utf8` starts at **0x2623a0 in both arms**, but its machine code does not
shrink: **8,524 -> 8,595 bytes**, **1,967 -> 1,972 instructions**, **420 -> 423
stack-referencing instructions**. This is a concrete counterexample to assuming
that removing source-level second-byte cases reduces compiled hot-code size.

`Engine::apply` remains at **0x258340**, 9,774 bytes / 2,048 instructions, with
the same relocation-masked instruction hash. `print_utf8`'s masked hash changes.
Static stack references include address computations and are not measured
spills/cycles. Same routine entry and unchanged normalized caller do not hold
all callee displacements, data layout, branches or host conditions fixed. No
unique causal attribution for the workload ratios follows from this census.

## Protocol provenance defect

`protocol.json` was frozen before the run, but its copied `hypothesis` sentence
still describes iteration 27. `intervention`, the exact source/patch, `mechanism`,
build driver, and numerical `engine` gates describe this experiment. An explicit
**additive** `protocol-clarification.json` records the stale sentence at
11:16:24 UTC, before timing-result inspection and while the run was still in
progress. Neither the protocol nor its hash-bound sessions were rewritten.
The copied build prose names i26; the actual build assertion uses i27 control,
which transitively byte-matches i26. This template error is disclosed rather
than silently repaired; no arm/order/threshold/sample changed.

## Replay and preservation

```sh
python3 -B bench/results/2026-11-03-scalar-domain/verify.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-scalar-domain/frozen-index.json
```

The checkpoint validates identities emitted by the existing Cargo artifact
selector, source hashes, exact patch application in a disposable directory,
test censuses, full raw decisions, disassembly, and **23 evidence-corruption
challenges**. The prior checkpoint is replayed through a location/index-only
adapter with explicit historical documentation snapshots, not rewritten code.

All **120 crate Rust sources**, **6,514 prior tracked result/report files** and
the selected terminal executable remain unchanged. Temporary exact timing ELFs
are required for binary/disassembly replay; no reconstructed fallback. Hash
replay checks bytes, not independent measurement accuracy or authenticity.

No new terminal/Ghostty, latency, startup, memory, frame or competitive gate was
run. No runtime candidate is selected and no world championship is established.
