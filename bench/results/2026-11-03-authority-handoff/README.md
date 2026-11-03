# Ground handoff after simple CSI: measured follow-up, rejected

Iteration 24, 2026-11-03. Local research, not terminal throughput, runtime
promotion, equivalence, a new Ghostty comparison, or championship acceptance.

## Previous failure addressed first

The prior supplemental checkpoint (`parser-authority-replay/verify.py`) exited
zero at this iteration's start: 382 terminal tests/arm, 12,800 differential
streams/arm, 65 Python tests, 17 corruption challenges and 65 + 91 + 14 historical
file references. The original intermittent verifier and its evidence remain
unchanged. Its narrow set-order diagnostic correction is not generalized here.
The new checkpoint accepts exact deterministic rejection reports; each stale
build mutation changes only one package.

## New prospective question

The rejected parser-authority arm rechecked parser/sync ground around simple-CSI
handoffs. Could carrying an already-established local ground fact avoid that
work and its truecolor regression? This is one follow-up implementation, not a
variant search or a favorable subset of the earlier result. `protocol.json` was
written before building/measuring the candidate. Its exact fresh control and
candidate were rebuilt with `bench/build-engine-arm.py`, all three affected
package receipts non-fresh, explicit source hashes, and separate non-clobbered
executables. No overlapping own builds/measurements. A static reviewer found no
counterexample to the intended invariant, but that advice is not experimental
validation.

In `lane`, `after_lane` establishes known ground at `fed` only after a successful
lane with no intervening parsed bytes. Direct ASCII printing preserves it. Any
nonempty residual `Processor::advance` clears it, requiring the authoritative
partial-UTF8/sync-aware query before a new simple operation. Empty advances and
redundant queries are skipped only in that proven case. The REP-without-preceding
early return can leave `fed` before the sequence; the fact still means ground at
that older frontier, NOT that `fed` equals the end of the accepted sequence. An
ESC in that prefix prevents it qualifying for direct ASCII printing. Failed
lanes cannot export the fact. Preserve `set_preceding_char` for subsequent split
REP. Candidate patch and full original/control/candidate source snapshots stay
in the result directory; production runtime is restored byte-for-byte.

## Frozen six-workload engine screen

11 fresh pairs, alternating AB/BA, scale 2, best of five rounds inside each
process, identical six workloads; no pooling with iteration 23. Require at least
one ASCII/scroll-region CPU-rate median >=1.02 with positive signs and six-way
Holm p<.05, and every workload median >=.98. Screen failure stops PTY escalation.

Workload       candidate/control CPU-rate median   wins/11   Holm p
ascii                       1.068749                  11       .005859375
unicode                     0.996013                   5      1
truecolor                   0.927055                   0       .005859375
cursor_motion               1.048124                  11       .005859375
scroll_region               1.068974                  11       .005859375
tui_frames                  1.059147                  11       .005859375

Decision: reject; truecolor fails the .98 guard, losing all eleven pairs. Both
primary targets clear their benefit screen, but that does NOT override a guard.
No runtime or selected terminal binary promotion and no new PTY/Ghostty trial.

New bounded finding: this exact known-ground handoff implementation does not
rescue the truecolor tradeoff against shipping control. It does not establish
which remaining instruction/layout effect causes that regression. There was no
paired comparison of the two rejected variants, so do not infer improvement or
lack of improvement between them by subtracting ratios. Unicode's point estimate
is neither an equivalence result nor evidence of closing the competitor gap.
Serial deterministic AB/BA signs on a shared machine are an operational screen,
not independent causal inference or simultaneous performance confidence bounds.
CPU-rate is not end-to-end terminal speed. No host process was killed or tuned.

## Retained semantic guard and real mutation challenge

`speed::simple_lane_ground_handoff_boundaries` has 2,160 scenarios: 15 prefixes
x 6 bodies x 3 grid shapes x 8 chunk sizes; cuts also include the exact prefix
boundary. Covers consecutive SGR/CUP/REP, absent preceding glyph, split/malformed
UTF8, C0, incomplete OSC/DCS/APC, synchronized-update entry/exit and narrow wraps.
Each compares the fast engine with the fallback parser including cells, cursor,
replies and other state through the existing differential helper.

The compiled mutant removes only `ground = false` after a nonempty advance.
It exits 101 with `Some("cells")`, not a build error or a source-text assertion.
First counterexample is a 3x2 grid with SGR 44, an incomplete UTF8 lead byte C3,
SGR 32, Y and REP 3 in chunk size 23. A preceding successful lane cannot license
bypassing a newly buffered partial scalar. Full stdout/stderr and hashes retained.

Correct control, candidate, restored: 383 terminal tests each (11 ignored),
12,800 differential streams each over 64 seeds, 2,160 handoff cases each. The
restored executable's hash equals the control. 65 existing Python tests pass.
22 report/build corruptions reject on disposable in-memory copies with unchanged
canonical evidence: nine report fields/shapes/identity/order cases, a duplicate
JSON key, and stale package receipts in each of four exact build arms.

## Preservation and replay

Selected `target/release/glass` stays SHA256
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
All 6,100 tracked pre-iteration result/report files are unchanged. Of 120 live
crate Rust sources only the additional test in `crates/term/src/speed.rs` differs;
all 119 other runtime Rust files are byte-identical. Earlier snapshots/results
are never edited. Explicit historical indices retain earlier versions of evolved
source/docs names; no fallback discovery or source repair is used. The ancestor
65 and previous 105 frozen file references replay. A new manifest freezes this
iteration's real evidence and checkpoint source. It validates byte integrity,
not external authorship or accuracy of elapsed time.

Read-only checkpoint, no rebuilding or performance rerun:

    python3 -B bench/results/2026-11-03-authority-handoff/verify.py

Byte-integrity-only replay (does not need temporary diagnostic executables):

    python3 -B bench/replay-evidence-index.py \
      bench/results/2026-11-03-authority-handoff/frozen-index.json

The full checkpoint deliberately requires the four exact /tmp diagnostic
executables. Missing binaries are a blocker, not permission to substitute or
rebuild. Never redirect new output onto frozen receipts. Current live logs,
explicit source copies, compiler JSON, report corruption results and independent
engine replay are alongside this report.

## Campaign blocker / next necessary evidence

No verifiable external championship acceptance is bound. The last exact-build
shipping-vs-Ghostty refresh (iteration 19) still has three corrected throughput
leads but Unicode is slower in 27/30 rounds (median shipping/Ghostty .929112);
ASCII/scroll superiority is unestablished. This iteration adds no competitor
observations. The parser-authority route now has two separately rejected exact
implementations; stop treating redundant ground queries as an evidenced cure.
Before changing it again, obtain workload-specific instruction/code-layout
attribution for truecolor under exact identities, or choose a distinct Unicode
hot-path hypothesis. Any future promotion needs fresh all-workload guards and a
prospective end-to-end exact-build comparison. Do not declare the loop complete.
