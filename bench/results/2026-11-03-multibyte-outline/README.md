# Shared multibyte UTF-8 helper: smaller caller, rejected slowdown

Iteration 29; reported local research, not competitive acceptance. Source base
`7b008e68a7e3a51ec58cb270f23b592f9ab11dd4`. Candidate not promoted; production sources restored.
All earlier tracked result/report files and shared docs remain untouched.

## New question and exact intervention

Does outlining *only multibyte validation*, keeping the ASCII return inline,
reduce the duplicated decoder footprint enough to benefit real row-writing?
Prior decoded-lookahead and scalar-domain rewrites did not test this call/size
tradeoff. The exact `candidate.patch` inserts one call after the existing ASCII
return and extracts the original multibyte body, unchanged, to one
`#[inline(never)] utf8_multibyte_at(bytes, at, lead)`. The lead comes from the
original checked read. No unchecked scalar construction, width changes, row
changes, parser authority changes or new dependencies. Empty/truncated/invalid
inputs keep the same checked read/reject behavior. Snapshots bind all four
explicit build inputs for both arms.

`protocol.json` and runner/analyzer sources were frozen before timing. One
candidate, 12 AB/BA balanced pairs, all six workloads, no pilots, retries,
exclusions, optional stopping or variants. Primary operational screen: Unicode
median candidate/control CPU-rate >=1.02, wins > losses, six-workload Holm
adjusted two-sided sign p <.05; every median CPU-rate >=.98 point guard.
These point guards do not prove noninferiority; a significant sign test would
not prove the effect exceeds 2%. Any successful engine screen would still need
separate prospective real-terminal and Ghostty validation.

## Correctness and build provenance

Both fresh exact release-test builds pass **383 terminal tests, 0 failed,
11 ignored** and **12,800 differential streams / 64 seeds** each. Existing
terminal tests include exhaustive scalar/padded scalar decoding, malformed and
truncated boundaries, guarded-page-tail cases and parser-state tests. These
checks support the extraction, not proof for every terminal stream. No new
Rust test or runtime source is retained by this iteration.

`build-control/` and `build-candidate/` preserve Cargo JSONL, non-fresh required
package receipts, exact compiler artifact paths, source and copied-executable
hashes. Control byte-matches the previous exact control ELF. `build.py` restores
all four source inputs in `finally`, and verifies the selected executable hash.
`bench/test_build_engine_arm.py`: **8 tests passed** (receipt/publication logic,
not benchmark validity). `corruption.json`: **23 synthetic corruptions of the
real raw report rejected**, not semantic or performance proof.

## Measured engine screen: reject

24 sequential best-of-five sessions, scale 2, read 4095. The invocation is the
measurement unit, not its five internal best-of rounds. Rates are already
rounded by the existing benchmark; paired ratio medians and two-sided exact
sign tests are reconstructed from retained stdout/stderr. No concurrent
benchmark/build jobs were launched by this iteration during timing; a shared
host is not an isolated laboratory. Balanced order does not establish
independent fair signs. All raw results, including regressions, are retained.

| Workload | CPU-rate ratio | Wall-rate ratio | Wins | Sign p | Holm p |
|---|---:|---:|---:|---:|---:|
| ascii | 1.010891 | 1.010753 | 7/12 | 0.77441406 | 1.00000000 |
| cursor_motion | 0.989927 | 0.989531 | 5/12 | 0.77441406 | 1.00000000 |
| scroll_region | 1.004887 | 1.004509 | 8/12 | 0.38769531 | 1.00000000 |
| truecolor | 0.994656 | 0.994194 | 5/12 | 0.77441406 | 1.00000000 |
| tui_frames | 0.989451 | 0.988943 | 5/12 | 0.77441406 | 1.00000000 |
| unicode | 0.915050 | 0.915397 | 2/12 | 0.03857422 | 0.23144531 |

Unicode **0.915050x**, **2/12 wins**, fails both the 1.02 target and .98
point guard. Unadjusted slowdown sign p=.03857422, but six-workload Holm
p=.23144531 does **not** clear .05. Report the measured veto without claiming
familywise-significant regression. No terminal promotion or new Ghostty run is
justified by this failed prospective screen.

## Exact machine-code result

`codegen.json`, exact `nm` and `objdump` captures come from the timed ELFs:

| Routine | Control | Candidate |
|---|---:|---:|
| print_utf8 entry | 0x2623a0 | 0x2623a0 |
| print_utf8 bytes | 8524 | 7987 |
| print_utf8 instructions | 1967 | 1820 |
| print_utf8 stack-referencing instructions | 420 | 419 |
| new multibyte helper bytes/instructions | absent | 427/120 |

Caller shrinks **537 bytes (6.30%) / 147 instructions (7.47%)**, yet Unicode
CPU throughput falls **8.50%** in this screen. With the helper included, the
two named symbols shrink just **110 bytes / 27 instructions**; no whole-ELF
size claim follows. There are two static helper call sites in print_utf8;
no dynamic call count was measured. Engine::apply remains 9,774 bytes / 2,048
instructions at the same entry 0x258340, with identical
relocation-masked instruction digest. Entry movement and a larger caller are
therefore not necessary for this observed slowdown.

This rejects a monotonic caller-size -> throughput assumption for this candidate,
not the value of instruction-cache locality generally. Added call/return cost,
register allocation, changed local control flow and surrounding code/data layout
remain *unseparated hypotheses*. No dynamic causal attribution, cache event,
cycle decomposition or reclaimed performance is claimed. The helper argument
lead==bytes[at] remains true by construction. The advisory review found no lost
decoding invariant; a separate read-only spawned review timed out and is not a
pass or an independent audit.

## Additive input-index correction, not timing repair

`prospective-inputs.json` was created while the serial build was starting and
accidentally included the then-empty **output** `build-control.json` in its
19-file list. Its original empty hash is retained. `input-audit.json` records
that sole output-only exception and all **18 actual inputs unchanged**. The
checkpoint checks the exact exception name/empty hash, completed build-output
hash, compiler receipt and every actual input hash. No protocol/source/script,
raw timing, analysis, threshold or prior evidence was rewritten. The audit is
post-timing and is not represented as prospective evidence itself.

Shared CHANGELOG.md, bench/README.md and docs/PERFORMANCE.md are intentionally
unchanged so historical evidence can replay at its original paths. This result
is documented here and in its standalone report. Earlier files are not repaired
or remapped by this experiment.

## Replay and preservation

From workspace root (exact timing ELFs retained under /tmp):

```sh
python3 -B bench/results/2026-11-03-multibyte-outline/verify.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-multibyte-outline/frozen-index.json
```

The read-only checkpoint binds exact intervention, original input index and
explicit output audit, fresh build provenance, correctness censuses, raw/analysis
reconstruction, corruption rejection, exact disassembly and previous checkpoint.
It then replays explicit frozen hash sources. Receipts retain actual exit/output;
no bare process exit or selected-text snippet is championship acceptance.

Selected production SHA-256 remains `d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
**120 tracked Rust sources** and
**6,601 prior tracked result/report files** remain byte-identical.
No candidate, Ghostty comparison or championship claim is promoted.

## Next necessary evidence

The shared-helper footprint hypothesis is spent in this exact form. Do not
retune this rejected helper without a new prospective, independently useful
question. Ownership/call-site dynamic work remains unmeasured, but the current
experiment gives no causal estimate for calls. Before another decoder rewrite,
revisit the remaining *real-terminal* competitive gaps under an explicit
cross-terminal protocol with correctness, throughput and tail-latency gates.
A same-binary transport/call-path diagnostic could prioritize that work without
changing UTF-8 semantics; it is not yet a measured finding.
