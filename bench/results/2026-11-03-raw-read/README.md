# Linux raw read: no promotion; independent terminal replay

Starting HEAD: `ccb8560`. This experiment is independent of the archived
immutable-mark/width prototypes: no such runtime/API changes are applied.

## Hypothesis, protocol and exact builds

Matched-input profiles found ASCII and scroll-region substantially less parser
CPU-bound than Unicode. A narrow, previously untested candidate replaces the
Linux `Read` trait -> portable-pty -> libc cancellation-enabled `read` route
with `libc::syscall(SYS_read)` on the already-owned duplicate master descriptor.
No descriptor flags, poll/gather policy, affinity, producer, parser, bytes or
credit count change. The boxed-reader fallback remains when no descriptor exists.
The candidate no longer translates EIO to zero in portable-pty, but the producer
ends on either error or zero, after sending any bytes already gathered.

`decision-rule.txt` predates measurement: all 18 balanced rounds, no subset
selection, no promotion without dependable ASCII/region evidence and protection
of the other workloads. Builds use configured rustc 1.99.0, thin LTO / one codegen
unit, same lockfile and ordinary flags. The exact selected executable is distinct
from the fresh control, even though its runtime source is the same.

| executable | SHA-256 |
|---|---|
| selected, restored | d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c |
| fresh control | c14daae87141541f747095ec77644e9189e009251716408e2630abd7a294a1ed |
| raw-read candidate | 8627654dcea1efdd1058f572ac043b966bb6efa5d87bd9a4c2edaa03f556878d |

Frozen `read_ahead.candidate.rs` and `candidate.patch` are the measured source.
`candidate-with-tests` snapshots record later tests/portability cleanup, not the
measured executable. The four pre-existing reader tests passed on the candidate.

## Complete real-PTY gate

```
GLASS=/tmp/glass-i14-raw-read-bin GLASS_ALT=/tmp/glass-i14-control-bin \
  python3 bench/compare-tput.py bench/results/2026-11-03-raw-read/gate --rounds 18
python3 -I bench/replay-terminal-pairs.py \
  bench/results/2026-11-03-raw-read/gate --verify-binaries
```

54 sessions, all six launch permutations repeated three times, 154x39, unchanged
normal producer and tput.py. Its historical estimator uses fastest of three
internal passes per workload; those passes are not independent experiments.
All host excursions remain included; unrelated host work was not isolated.
No Glass compilation or other Glass benchmark overlapped the gate.
Times end on DA1 processing, **not rendered frames or key-to-screen latency**.
Sign tests below are exploratory, two-sided, uncorrected; ties reduce their n.

| workload | candidate/control | wins/18 | sign p | candidate/Ghostty | wins/18 |
|---|---:|---:|---:|---:|---:|
| ASCII | 1.03686 | 11 | .480682 | 1.02798 | 10 |
| Unicode | .98571 | 5 (1 tie) | .143463 | .95041 | 5 |
| truecolor | .99152 | 5 | .096252 | 1.15455 | 17 |
| cursor motion | .99583 | 8 | .814529 | 1.11935 | 17 |
| scroll region | 1.01659 | 12 | .237885 | 1.04266 | 10 |
| TUI frames | .99467 | 8 (1 tie) | 1 | 1.04538 | 15 |

**Do not promote.** Neither targeted workload has dependable evidence, while
other point estimates are negative. This does not prove zero syscall overhead;
it does reject this candidate under the recorded conservative release protocol.
No replication or new latency claim is warranted for this rejected candidate.
`fresh-control-vs-ghostty.json` separately derives the unchanged fresh control's
paired scores; it is not the rejected candidate or the historical selected binary.
The campaign's all-metric goal remains unresolved.

## Retained regression coverage

Only three new tests survive in production source, not the raw syscall change:

- Descriptor-free fallback retries Interrupted; delivers all data before a later
  terminal error; handles zero-sized consumer reads and sticky EOF (five sizes).
- Transfers larger than all producer credits drain exactly once to EOF across
  four consumer sizes and partial chunk tails.
- Real raw PTY with readable data and HUP already present before spawning the
  reader drains the final partial handoff and reaches sticky EOF (three sizes).

Restored-source reader tests: **7 passed**. Repeated directly from the test binary:
**100 repetitions / 700 test executions, no failures**. These repeated runs are
stress coverage, not 700 independent statistical experiments.
Full existing terminal suite: **379 passed, 0 failed, 11 ignored**.
The ignored tests include benchmark/explicit opt-in cases; no GPU/platform claim.
Final formatted source again passed the full terminal suite (379/0/11).
Matched-toolchain library/reference/doctest results are **136/45/1 passed**.
The first library command passed compiled tests but failed doctests because
stable rustdoc 1.99.1 did not match configured rustc 1.99.0. That diagnostic is
retained. The explicit RUSTDOC=$(dirname "$RUSTC")/rustdoc rerun passed; this is
not a suppressed test failure. The selected executable is byte-compared after
restoration, and removal of the added tests exactly reconstructs starting source.

## Newly demonstrated measurement-integrity defect and fix

`compare-tput.py --summarize-only` checks raw hashes but **rewrites** altered stored
comparison summaries instead of rejecting them. The runner records its own digest
but that mode does not check it. This is a verifier gap, not evidence that prior
measurements were actually corrupted.

`summary-mutation-demonstration.json` gives a concrete disposable-copy experiment:
change ASCII wins to 18 and median ratio to 9.99. The old summarizer exits zero
and repairs the copy. The new checker rejects it nonzero and leaves it unchanged.
The original measurement report is byte-identical throughout. No timings rerun.

`bench/replay-terminal-pairs.py` is independent and read-only. It rejects duplicate
keys, incomplete/unknown schema, unsupported statistical claims, changed runner,
harness, binary (when requested), raw sets/hashes, order, geometry, workload and
byte shapes, numeric invalidity, all derived ratios/counts/p-values/medians, and
rate/time/FPS inconsistencies. Rounding intervals respect tput.py's milliseconds
and 0.1-rate precision instead of reconstructing nonexistent exact timestamps.
This validates consistency/integrity only, not trustworthy clocks or timing accuracy.

**11 synthetic corruption tests passed**; synthetic fixtures are not benchmarks.
The existing engine replay tests (5) and quiet-RTT checker tests (10) also pass.
Ten supported frozen datasets replayed: **630 terminal sessions**. The original
mixed-schema replay stopped at `glass.cyclic-terminal-comparison/v1`; that older
row-alignment dataset is explicitly listed as unsupported, not silently accepted.
`historical-schema-inventory.json` names all supported/skipped paths; original
failure diagnostics are preserved. Historical reports/raw files are not rewritten.

## Integrity and next step

`evidence-sha256.json` explicitly lists this experiment's sources, raw data,
reports and receipts. `verify-evidence.py` verifies them without path discovery;
its final receipt is excluded to avoid self-reference. Earlier reports remain
unchanged. Temporary executable-dependent replay is supported while those binaries
exist; the artifact manifest does not require temporary binaries.

Do not retry raw SYS_read as an undiscovered all-metric fix. A next transport lead
needs evidence of syscall counts/read sizes or blocked-time/credit-pressure on the
unaltered full pipeline, with its sampling overhead measured. Do not deduce that
all time in a sampled read leaf is glibc cancellation overhead, or that a parser
speedup transfers automatically to the PTY. Championship remains unverified.


Historical-manifest lifecycle note: the previous marks-width strict verifier
now fails on intentionally changed live CHANGELOG.md. Audit finds exactly three
live-doc changes and 633 unchanged artifacts. Prior doc snapshots match all three
old expected hashes; see `previous-evidence-source-audit.json`. Neither the old
manifest nor its verifier/report/raw datasets were edited. Do not claim the
unmodified old whole-tree verifier passes after intentional documentation edits.
