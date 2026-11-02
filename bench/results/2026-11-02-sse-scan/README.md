# SSE2 run scan: real progress, not an all-metric win

Base: `2a82a589d4eeadb4e0f1dfc1eae155ffcc038ce1`. Linux, Ryzen 9 9950X3D,
RTX 3090, 154×39, Ghostty 1.4.0. Build compiler was the explicitly configured
rustc **1.99.0** (b940084d7), not the 1.99.1 reported by the shell shim.

## What changed

`next_run` retains the existing 24-byte skip probe for escape-heavy input,
but x86-64 recovers the printable prefix and scans its suffix 16 bytes at a
time using baseline SSE2. Exact control masks identify C0/DEL; high-bit masks
classify ASCII during the same scan. `feed` consumes that classification
instead of rereading the entire run with `is_ascii()`.

Unlike subtraction-based word masks, SSE2's exact masks can identify the
**last** control in a backward block. Classification excludes bytes before
that control and after the forward boundary. The one unsafe block loads an
explicit `&[u8; 16]` with `loadu`; no overread, alignment requirement, AVX, or
runtime CPU-feature dependency. Non-x86 retains the original word scan and
`is_ascii()` classification. macOS/ARM was not measured or cross-compiled.

Terminal semantics, widths, cells, scroll history and rendering are unchanged.
An independent logic review found the masks sound, and called out the existing
short-EOF retry edge: `from` may become `len + 1`. Keep the non-subtracting
loop guard; a `len - from` rewrite would underflow. A regression assertion
covers it, multiple boundaries, and high bits outside the candidate span.

## Engine: reproduced at longer duration

`engine/sse-final-pairs.json`: 11 pairs, AB/BA, scale 2, five rounds per arm.
Ratios are median paired **MB/cpu-s**, candidate/base. Every arm uses identical
workload bytes/read sizes, with raw output, exit status and SHA-256 retained.

| Workload | ratio | wins/losses | exact two-sided sign p |
|---|---:|---:|---:|
| ascii | 1.1014 | 11/0 | .00098 |
| unicode | 1.0259 | 10/1 | .01172 |
| truecolor | .9916 | 1/10 | .01172 |
| cursor_motion | 1.0078 | 8/3 | .22656 |
| scroll_region | 1.1400 | 11/0 | .00098 |
| tui_frames | .9857 | 2/8, one tie | .10938 |

An earlier nine-pair scale-1 run independently found +10.4% ASCII and +13.1%
region, both 9/9. The small truecolor/TUI engine tradeoff was explicitly checked
in the terminal gate, not silently discarded.

## Terminal gate: 15 balanced rounds, three terminals

Unmodified `bench/tput.py`: every window runs all six workloads three times,
keeps the fastest, waits for DA1 completion, and closes before the next starts.
Order rotates by round: candidate/baseline/Ghostty, Ghostty/candidate/baseline,
baseline/Ghostty/candidate. All 45 records are in `terminal/`, all 154×39.
`terminal-summary.json` records individual ratios, medians, sign tests and hashes.
Candidate = glass, old HEAD = glass-alt. Ratios below are **paired**, not the
ratio of separately aggregated medians.

| Metric | new/old Glass | wins/15 | new/Ghostty | wins/15 |
|---|---:|---:|---:|---:|
| ascii | 1.0021 | 8 | .8988 | 5 |
| unicode | **1.0577** | **14** | .9713 | 3 |
| truecolor | 1.0007 | 8 | **1.1584** | **15** |
| cursor_motion | .9975 | 5 | **1.0981** | **15** |
| scroll_region | **1.0856** | **12** | .9255 | 2 |
| tui_frames | .9935 | 5 | **1.0505** | **15** |

Unicode new/old p=.00098; region p=.03516. Other new/old p≥.30176. Each
Ghostty lead in the three winning metrics is p=.000061. Ghostty still wins
Unicode 12/15 (p=.03516), region 13/15 (p=.00739). ASCII 10/15 is inconclusive
(p=.30176) and its spread remains broad: do not call it a win. Sign tests are
exploratory and not multiple-comparison corrected; rounds are not independent
hardware replications. This is one shared machine, not a universal ranking.

Candidate medians MB/s: ascii 942.3, Unicode 268.2, truecolor 275.1,
cursor 238.0, region 1053.1, TUI 274.9. The Unicode and region gains are real
progress relative to the paired control; the three established Ghostty wins
survived. **Three leads, two deficits, one noisy/unfavorable metric.** Startup,
key latency, idle VRAM/memory, power and visible rendering were not rerun; no
new claims about those surfaces. Public performance docs retain their older
published measurement set rather than mixing these experimental numbers in.

## Measured and rejected in this iteration

All terminal code experiments except SSE2 were reverted. Patches in `rejected/`;
paired records in `engine/`. These are measurements, not causal proof: layout,
compiler and shared-machine effects can contribute to small deltas.

- Branchless mixed-width writer: writes spacer first, aliases it with the
  lead for width 1; parity passed, Unicode **−21.2%, 0/7**. Do not repeat.
- Forward-only word scan carrying ASCII classification: stable scale-1 repeat
  ASCII +2.6%, region +4.9%, Unicode +3.8%, but cursor −2.9%, truecolor −1.8%,
  TUI −2.7%. Early apparent +23% ASCII coincided with a several-fold machine
  speed change; not the defensible estimate. SSE2 supersedes this route.
- Backward word scan + classification: region +5.4%, TUI −3.0%, truecolor
  −1.4%. The subtraction mask cannot safely locate a final boundary.
- Skip-probe + forward word hybrid: region +3.4%, but truecolor/TUI −2.2/−2.4%.
  A five-round terminal run became grossly disrupted (several-fold changes in
  both terminals); it was not used as the acceptance gate.
- Lossless `CellColor(u32)` representation (ANSI serde format retained):
  parity passed; Unicode +2.0%, truecolor **−4.0%, 0/9**. Reverted. The
  memory-footprint motivation is not an established throughput benefit.
- Compact repr(u8) NamedColor plus explicit palette index mapping: parity
  passed; Unicode +0.6%, most other work −1–2%. Reverted, no ABI/API change left.
- Word-wide safe UTF-8 decoder with scalar short tail: stdlib differential
  passed; Unicode −6.1% median, noisy. Reverted.

The boxed-row-header suggestion was stopped before implementation: it
substantially overlaps the already rejected boxed blank; do not retry it.
Combining-mark inline handling was inspected, not implemented: attachment,
lazy materialization and uniform-prefix/extra ownership need a complete
correctness design, not an ad-hoc fast path.

## Verification (actual outcomes)

- `cargo test --release -p glass-term --locked`: **366 passed**, 11 ignored.
- `GLASS_SWEEP_SEEDS=128 GLASS_SWEEP_ROUNDS=100 cargo test --release -p
  glass-term --locked plain_runs_match_the_parser_over_seeds -- --ignored
  --nocapture`: **12,800 streams, no divergence**.
- Expanded pre-existing boundary/model test: passed, including short EOF.
- `cargo test --workspace --lib --bins --locked`: **825 passed**, 11 ignored,
  including GPU tests on the available GPU; no skipped GPU classes added.
- `cargo test -p glass-alacritty-terminal --locked --tests`: **133 unit + 45
  reference tests passed**.
- `cargo clippy --workspace --all-targets --locked`: exit 0; pre-existing
  warnings remain (not claimed warning-free). No new clippy diagnostics in
  the changed scanner.
- Initial doctest command failed E0514 because Cargo used rustdoc 1.99.1
  with RUSTC=1.99.0. `RUSTDOC="$(dirname "$RUSTC")/rustdoc" cargo test
  --workspace --doc --locked`: **passed**, one doctest. Both logs retained.
- `git diff --check`: passed.
- Paired runner smoke measurement passed; `/bin/false` arm rejected with
  exit 1 and an explicit saved failure receipt (`runner-reject.json`).

## Reproduce and next necessary action

`bench/engine-pairs.py` is the fail-fast runner used here. Build test executables
from base and candidate with the same release flags; copy Cargo's reported
executable before rebuilding the other. Example:

```
python3 bench/engine-pairs.py BASE_TEST CANDIDATE_TEST --pairs 11 --scale 2 \
  --rounds 5 --out pairs.json
```

The runner clears inherited GLASS probes; it is a diagnostic, not a terminal
or official leaderboard verifier. Binary hashes in the reports identify the
measured artifacts; local paths may no longer exist after cleanup.

**Next**: repeat a balanced full-terminal gate on a quiet machine before any
championship assertion. Region needs ~8% more, Unicode ~3%, from this gate;
ASCII is dominated by PTY/reader pacing and Ghostty spread after its engine
improved 10%. Further scanner gains cannot by themselves settle the PTY-bound
ASCII ranking. Do not trade away the three established wins or change widths,
scroll frequency, workload bytes, history size, or timer semantics to win.
