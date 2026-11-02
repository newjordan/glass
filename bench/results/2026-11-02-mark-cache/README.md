# Single-mark sharing: a measured Unicode gain, not a Ghostty sweep

Starting source: `ceaca65fa6e5dfc0b3be23cef7c77606d43761d3` (SSE2 scanner).
Machine: Ryzen 9 9950X3D / RTX 3090; Linux / Hyprland headless output;
all terminal pairs at **154 x 39**. Cargo's configured `RUSTC` is
rustc 1.99.0 (b940084d7); the earlier doctest failure was a rustdoc-version
mismatch and the preceding iteration already retained a passing matched run.
No new workspace-wide test count is claimed by this iteration.

## Kept: bounded sharing of single-mark cell extras

`Cell::push_zerowidth` used to allocate one `Arc<CellExtra>` for every
previously plain cell receiving its first combining mark. It now clones an
immutable mark-only extra from a one-entry thread-local cache, keyed by the
exact character. Cache misses replace that one entry; application input
cannot grow the cache. Existing extras bypass it. Adding another mark,
changing underline color/hyperlink, and clearing wide state all retain
`Arc::make_mut`. TLS teardown falls back to an owned allocation. No unsafe
code, cell-layout change, Unicode normalization, new width rule, parser or
reader changes. The nine-mark limit and serde values are unchanged.

The benchmark includes decomposed `a + U+0301`, so it exercises this path.
Other scripts with alternating accents or many marks per cell can gain less
or pay copy-on-write overhead. The result is not universal Unicode speedup.

### Engine: 11 balanced pairs

`engine-pairs.json` retains stdout/stderr, executable hashes and environment.
Same release flags, scale 2, five rounds per invocation. CPU-throughput ratio
(candidate / preceding source), median of pairwise ratios:

| workload | ratio | wins | two-sided sign p |
|---|---:|---:|---:|
| unicode | **1.0488** | **11/11** | **0.000977** |
| ascii | 1.0365 | 10/11 | 0.0117 |
| truecolor | 0.9890 | 0/11 | 0.000977 |
| cursor_motion | 0.9900 | 2/11 | 0.0654 |
| scroll_region | 1.0036 | 9/11 | 0.0654 |
| tui_frames | 0.9948 | 3/11 | 0.2266 |

Only Unicode uses the changed allocation path. Movements in other workloads
are therefore build/code-placement effects, not proof of cache benefits.
In particular, the small engine truecolor regression did not transfer to the
terminal gate. CPU best-of-five is diagnostic, not the release decision.

### Terminal gate: 15 balanced three-arm rounds

Candidate = `/tmp/glass-mark-cache-bin`, baseline =
`/tmp/glass-mark-base-bin`, third arm = Ghostty. The launch order rotates
`glass glass-alt ghostty`, `ghostty glass glass-alt`, `glass-alt ghostty glass`.
`terminal-summary.json` includes all pairwise ratios, sign tests and raw JSON
SHA-256 hashes. Ratios below use wall-clock MB/s (TUI fps has the same ratio).

| workload | cache / baseline | wins | cache / Ghostty | wins |
|---|---:|---:|---:|---:|
| ascii | 1.0224 | 8/15 | 0.8838 | 2/15 |
| unicode | **1.0234** | **15/15** | 0.9327 | 2/15 |
| truecolor | 1.0036 | 8/15 | **1.1550** | **14/15** |
| cursor_motion | 0.9871 | 3 wins, 11 losses, 1 tie | **1.1016** | **15/15** |
| scroll_region | 1.0066 | 8/15 | 0.9395 | 6/15 |
| tui_frames | 0.9897 | 6/15 | **1.0515** | **15/15** |

Unicode versus baseline: p=0.000061. The small cursor-motion movement is
p=0.0574 (ties excluded); do not label it a proved regression or improvement.
All three established Ghostty wins survived. **ASCII, Unicode and
scroll-region do not pass. This is not world-champion evidence.** Startup,
latency, memory and other machines were not remeasured here.

### Correctness actually executed

- `cargo test --release -p glass-alacritty-terminal --locked --lib term::cell::tests`:
  **6 passed** (`cell-tests.log`). Includes cache sharing/eviction, independent
  second-mark/style/link mutation, nine-mark cap, preserved existing attributes,
  and shared-versus-owned serde equality/roundtrip; retained cell-size and
  line-length tests also passed.
- Cache-only executable: `--exact speed::plain_runs_match_the_parser`: **1
  passed**, `parser-test.log`.
- A later inline-mark candidate using the same cache passed **12,800 streams
  over 128 seeds**, but that larger sweep belongs to the rejected candidate
  and is not mislabeled as a new cache-only sweep.
- Independent static review of the cache and inline candidate found no
  concrete correctness defect. That review was not an independent test run.
- Final selected source, after a syntax-only let-chain cleanup: **6 cell tests
  passed** again (`final-cell-tests.log`), and `cargo clippy -p
  glass-alacritty-terminal --lib --tests --locked` exited 0
  (`final-package-clippy.log`). No new workspace-wide test count is claimed.

### Exact final-source confirmation

The lint-cleanup rebuild was **not byte-identical**, so it was not assumed to
inherit the first binary's performance. `final-build-hashes.txt` identifies
`/tmp/glass-cache-selected`; `selected-terminal/` and
`selected-terminal-summary.json` retain a second complete 15-round gate of
that exact binary, versus the original baseline and Ghostty, with no other
Glass benchmark running. Same geometry and rotating order:

| workload | final / baseline | wins | final / Ghostty | wins |
|---|---:|---:|---:|---:|
| ascii | 1.0797 | 9/15 | 0.8799 | 4/15 |
| unicode | **1.0342** | **15/15** | 0.9602 | 4/15 |
| truecolor | 0.9957 | 7/15 | **1.1637** | **15/15** |
| cursor_motion | 1.0030 | 9 wins, 5 losses, 1 tie | **1.1099** | **15/15** |
| scroll_region | 0.9642 | 4/15 | 0.9018 | 1/15 |
| tui_frames | 0.9989 | 7/15 | **1.0557** | **15/15** |

Unicode p=.000061 versus baseline; all three established Ghostty wins also
have p=.000061. ASCII's apparently attractive baseline median is inconclusive
(p=.6072), as is region's movement versus baseline (p=.1185). Do not sell
these noisy workload shifts as cache effects. The exact selected source
therefore confirms the gain and still does **not** pass the remaining three.

## New measured dead ends (patches and raw evidence retained)

1. **Borrow the read-ahead hand-off (`BufRead`) instead of copying it**
   (`../2026-11-02-borrowed-reader/`). Same 16 KiB chunk, two buffers, pacing
   and frame gates. Existing byte-order/EOF test passed. Fifteen terminal
   pairs: ASCII 0.9810, Unicode 0.9921, region 0.9821; cursor 1.0126, 15/15.
   Early rounds overlapped the rotation engine diagnostic, so this is an
   exploratory result, not clean release evidence. No target-gap gain, not
   kept. Source restored, patch retained.
2. **Replace region rotation's signed remainder with bounded add/subtract**
   (`../2026-11-02-rotation-index/`). Fourteen existing storage tests passed.
   Engine region 1.0123 (9/11, p=.0654), Unicode 0.9315 (0/11), TUI 0.9905
   (1/11). Arithmetic is equivalent for visible lines, but codegen is not
   profitable. Also overlapped the reader diagnostic. Removed.
3. **Attach combining marks inside the existing row-slice loop**
   (`../2026-11-02-inline-marks/`). Only attach when the base was written by
   this invocation; commit `extra_free`/uniform metadata after the slice.
   Parser test and 12,800-stream sweep passed, independent static review
   found no defect. Clean engine Unicode 0.9947 (4/11); clean terminal
   Unicode 1.0083 (11/15, p=.1185), TUI 0.9880. No credible target benefit;
   removed despite three Ghostty wins surviving. This is distinct from old
   per-mark row-lookup plumbing, and still does not pay.
4. **Validate each UTF-8 run once, then decode with `str::Chars`**
   (`../2026-11-02-validated-decode/`). Invalid/partial runs keep `utf8_at`;
   parser differential passed. Nine engine pairs: Unicode **0.6053, 0/9**.
   A valid-string boundary check and repeated iterator setup are much more
   expensive here than the fused checked scalar decoder. Removed, no
   terminal gate warranted. Initial command-line typo (`--exact` before
   Cargo's `--`) failed before compilation and was corrected; no result is
   inferred from that failure.
5. **Hand memmove rotation** was stopped before coding: this compiler's
   `core/src/slice/rotate.rs` already selects `ptr_rotate_memmove` for the
   one-row/64-byte case. This also confirms the earlier hand-memmove dead
   end. Do not add unsafe code to duplicate it.

A separate held-out-workload PGO experiment lives in `../2026-11-02-pgo/`.
Its build effects must not be reported as a portable algorithmic change.
Fifteen clean rounds measured cache+PGO versus normal cache: Unicode +1.04%
(12/15), truecolor +3.23% (15/15), region +3.54% (13/15), but TUI **-2.76%**
(1/15). It still loses ASCII, Unicode and region to Ghostty, and no longer
proves a TUI lead. The profile is **not enabled by default**.

## Reproduce

Build and copy Cargo's reported release test executable on each source;
`python3 bench/engine-pairs.py BASE_TEST CANDIDATE_TEST --pairs 11 --scale 2
--rounds 5 --out pairs.json`. The runner fails on missing workload, zero
throughput or nonzero exit. For terminal data use the three rotating launch
orders above with `bench/run-tput.sh`, `ROUNDS=1..15`, explicit immutable
`GLASS` and `GLASS_ALT` binaries. Do not run two benchmarks concurrently.

The next structural work remains the cell/page representation and
branch-decision cost described in `../2026-11-02-handoff-2/`; the cheap
allocation reduction above does not make those gaps disappear.

## A new reader finding, then a latency-guarded rejection

The final source audit found that the historical 400 us reader top-up was
actually `poll(0)`: `Duration::as_millis()` truncates 400 us to zero. The
separate [`ppoll` report](../2026-11-02-ppoll/README.md) verifies that source
fact and measures a real 400 us wait rather than assuming it is better.
It lost 5.1% ASCII (3/15 wins), and its quiet real-PTY DA1 RTT rose from
.0314 ms to .4827 ms across three runs per arm. It is removed; comments are
corrected without changing runtime behavior. This is new evidence against
restoring the wait on the strength of the old handoff narrative.

The selected release executable is restored to `target/release/glass` with
SHA-256 `30d08e820c63aea21c496d3f18a67aa3c7dc6b766b42a74683340c66fd0e7de1`.
The only runtime source change is the bounded cache. Reader comments changed
after its exact-build gate, but no reader runtime change remains.
