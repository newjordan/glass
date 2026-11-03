# Changelog

All notable changes to glass are recorded here. Versions follow
[Semantic Versioning](https://semver.org/).

## 0.1.0 - unreleased

### Research — safe scalar-domain UTF8 validation, rejected

- Test uniform continuation checks and decoded-scalar minima, retaining safe
  character construction. Both arms pass 383 tests and 12,800 differential
  streams. Twelve balanced pairs yield Unicode 1.005126x, 6/12 wins: fails
  the prospective 1.02 target. TUI loses 11/12 pairs; no runtime promotion.
- Hot routine grows from 1,967 to 1,972 instructions at the same entry address;
  source-level branch simplification does not shrink this compiled routine.
  Retain complete noisy pairs, exact codegen and additive protocol-template
  clarification. No Ghostty gate or championship claim; selected executable,
  120 Rust sources and 6,514 earlier tracked result/report files preserved.
- Read-only checkpoint:
  `python3 -B bench/results/2026-11-03-scalar-domain/verify-current.py`.

### Research — scanner outlining recovers truecolor, Unicode vetoes promotion

- Test one scanner inline attribute in a 12-block, four-arm factorial (48 exact
  engine sessions). Authority-outlined/control truecolor gains 4.94%, but Unicode
  loses 2.40% and fails the prospective .98 guard. Runtime rejected/restored;
  no new terminal/Ghostty timing or championship claim.
- Confirm register-carried decimal index and retain exact disassembly. The moved
  print_utf8 routine keeps 1,967 relocation-masked instructions; layout/caller
  effects remain unproven. Retain raw replay and 23 evidence-corruption checks.
- Both new arms and restored control pass 383 tests plus 12,800 differential
  streams each; 65 Python tests pass. Selected executable, 120 crate Rust sources
  and 6,318 prior tracked reports/results are unchanged. Read-only checkpoint:
  `python3 -B bench/results/2026-11-03-csi-outlining/verify.py`.

### Research — exact-binary instruction attribution (no runtime change)

- Freeze 24 plain/profiled engine sessions and one excluded sampler pilot.
  Repeated truecolor regression localizes to Engine::apply; disassembly exposes
  extra candidate CSI digit-loop index spill/reloads. Unicode samples instead
  concentrate in print_utf8 with leading-byte dispatch hotspots. These are
  diagnostic codegen leads, not established causal costs or competitive wins.
- Retain raw traces, exact ELF symbols/disassembly, observer ratios, an existing
  ELF-reader cross-check and a read-only checkpoint. Preserve selected build,
  all 120 tracked Rust files and 6,182 prior tracked result/report files.

The first release. glass is a terminal that draws in its own GPU window
(wgpu on Vulkan, winit, with `alacritty_terminal` as the terminal engine).
A program runs in a pseudo-terminal, and what it writes comes in through
**open intake**: glass takes in the dialects programs already speak and
**expands** them into the window as text, pictures, layers and 3D scenes.
No dialect is the reference one; each is an adapter onto one shared
description of what to show.

### Simple-CSI ground-handoff regression and measured follow-up

- Retain 2,160 parser-differential handoff/chunk scenarios. A compiled mutant
  that fails to revoke ground after parser input produces an actual cell mismatch.
- Reject a known-ground handoff follow-up to parser-authority removal: 11 fresh
  pairs retain ASCII/scroll CPU gains but truecolor ratio .927055 fails the
  frozen all-workload guard. Restore runtime; no selected executable change.
- 383 terminal tests and 12,800 streams per correct arm, 65 Python tests, and
  22 evidence-corruption rejections. Preserve 6,100 prior artifacts; provide a
  read-only exact-source checkpoint. No new Ghostty or championship claim.

### C1 row-boundary regression and width-handle research

- Add parser-differential coverage for all 32 C1 scalars, row-run thresholds,
  UTF-8 read splits, printable predecessors, REP and mode/reply state. A built
  C1-to-glyph decoder mutant fails on actual cells; production behavior stays.
- Reject row-scoped width-cache acquisition: frozen 11-pair Unicode CPU-rate
  ratio 1.009280, 9/11 wins, six-workload Holm p=.261719. Fresh-process
  instrumented diagnostics confirm an unnecessary C1-only cache initialization
  (1,114,112-byte payload inferred, not measured RSS/latency). Restore runtime;
  381 terminal tests, 12,800 differential streams and 49 Python tests pass.
  No new Ghostty score or championship claim.

### Unicode row-edge regression and exclusive-column research

- Add parser-differential coverage for pending wrap across narrow/wide/combining
  successors, read cuts, REP, modes, stale wide cells and malformed UTF-8.
  A built semantic mutant that drops pending wrap is caught by the new test.
- Reject an exclusive-column `put_row` rewrite after a prospectively frozen
  11-pair engine screen: Unicode candidate/control CPU-throughput 0.979261,
  3/11 wins. Restore runtime; retain raw results and read-only replay. No new
  Ghostty claim. 380 terminal tests, 12,800 differential streams and 49 Python
  tests pass; nine report corruptions reject without changing evidence.

### Reciprocal same-L3 hot placement (research only)

- Measure reader/parser sibling versus distinct-core pins on the unchanged
  selected executable: five-session pilot, preserved rejected 100-session
  strict run, and two fresh 100-session series under an explicit v2 protocol.
- Find a repeatable secondary ASCII distinct/auto placement lead under shared
  host load, but no uniformly replicated primary-family significance and no
  default-affinity or all-metric competitor win. Keep runtime unchanged.
- Add read-only identity/mask/topology/order replay, 13 non-mutating corruption
  rejections, explicit non-target-transition reporting, and four two-role
  cleanup fault cases; preserve all 120 Rust sources and 621 prior files.

### Controlled reader contention (diagnostic only)

- Capture a predeclared 12-round, six-arm own-reader contention experiment:
  72 confirmatory sessions plus separate six-session pilot and hardened smoke.
- Detect runnable-wait sensitivity and a scroll observer interaction; plain
  ASCII/scroll effects do not justify a shipping scheduler policy. Report
  Unicode's small controlled penalty and substantial snapshot uncertainty.
- Add read-only treatment replay, ten non-mutating corruption challenges, and
  SIGTERM/SIGHUP/SIGINT affinity/helper cleanup checks. Preserve the selected
  release bytes and all 120 Rust sources; no candidate promotion or title claim.

### Own-reader scheduler accounting (diagnostic only)

- Validate own-thread runnable-wait accounting on this kernel even with
  `sched_schedstats=0`: 36 balanced busy/sleep/own-child-contention trials.
- Capture 36 balanced plain/clock/scheduler terminal sessions plus separate
  pilot and hardened-observer smoke captures. Preserve whole-window coverage,
  observer effects and snapshot uncertainty; residual is not pure blocking.
- Add fail-closed read-only trace replay and nine checker regressions; 41 Python
  tests pass. No runtime source change, release rebuild or candidate promotion.

### Reader call-shape research (not promoted)

- Diagnose the unchanged Linux reader with 36 balanced plain/count/timed
  sessions. Reads reach 16 KiB: correct the false 4-KiB ceiling in comments;
  retain explicit observer-overhead, boundary and shared-host limitations.
- Reject a distinct tail spare-capacity policy after 54 uninstrumented paired
  terminal sessions. All six candidate/control median ratios are below one;
  original runtime statements and exact selected executable are restored.
- Retain a read-only call-trace decoder, five measured corruption rejections,
  exact source/raw snapshots and prior evidence baseline copies. This is
  diagnostic and integrity evidence, not an all-metric championship.

### Raw-read research and read-only measurement replay

- Reject Linux raw `SYS_read` after 54 balanced real-terminal sessions: neither
  ASCII nor scroll-region clears the paired improvement gate. Runtime and the
  exact selected executable remain unchanged.
- Guard descriptor-free reader interrupts/errors, multi-credit EOF and final
  PTY hangup handoffs. Seven reader tests pass in 100 repeated runs.
- Add an independent read-only throughput-report checker. Demonstrate, on a
  disposable copy, that the existing summarizer repairs altered comparisons
  rather than rejecting them; retain 11 corruption tests and replay 630 supported
  terminal sessions without rewriting historical evidence. Integrity is not
  timing accuracy or an all-metric championship. See the raw-read result README.

### Immutable extras and width research (not promoted)

- Prototype bounded immutable combining-mark records and generated Unicode
  widths; retain exact-source tests, strict-provenance Miri and two independent
  real-PTY gates for the combination. Its replication leads Ghostty on Unicode,
  truecolor, cursor motion and TUI throughput, but ASCII/region remain unresolved.
  No all-metric title or runtime/API promotion: starting sources and exact selected
  executable restored. See `bench/results/2026-11-03-marks-width/README.md`.
- Strengthen paired quiet-PTY response-time provenance and replay with a standalone
  fail-closed checker and ten synthetic tests. These are not key-to-screen results.

### Reader correctness and measured research

- Linux: drain readable final PTY bytes before honoring a simultaneous
  `POLLHUP`; a deterministic raw-PTY regression failed before the correction
  and passes afterward.
- Return fully copied reader hand-offs before parsing the independent copy,
  allowing the existing two buffers to refill sooner. A fresh-control paired
  comparison measured about +5.1% scroll-region throughput, not a lead on every
  workload. The bounded read-ahead allowance and quiet RTT are documented in
  `bench/results/2026-11-02-early-recycle/README.md`.
- Add balanced six-order terminal comparisons with provenance and workload
  checks. Preserve rejected Unicode and third-buffer experiments rather than
  inferring a terminal win from engine microbenchmarks alone.

### Session-overhead research and regression coverage

- Reject independent opportunistic read coalescing, lazy frame-cut iteration,
  and stack-backed splitter output after full six-order terminal gates;
  preserve the selected runtime and exact executable.
- Cover queued hand-off byte order/credit return across output sizes and
  empty/adjacent/random synchronized-frame cut boundaries. Seven final
  reader/frame-gate tests pass; no universal performance claim.

### Scanner and UTF-8 regression coverage

- Test exact SIMD text masks across 16/32/64/128-byte boundaries and legal
  slice ends immediately before an inaccessible page on Linux x86-64.
- Test every Unicode scalar, encoding truncations, and malformed boundary
  forms against standard-library validation. No runtime decoder change.
- Record four measured scanner/decoder experiments. The SSE2 engine gain did
  not transfer to the full paired terminal gate; retain the selected runtime
  and executable, not a speculative all-metric performance claim.

### Matched-input performance diagnosis

- Add opt-in Linux task/producer timing and own-process leaf-IP diagnostics,
  with profiling-overhead controls, exact payload/pass provenance and replay.
  Separate parser-bound Unicode/escape workloads from reader-heavy ASCII and
  scroll region; record timer coalescing and limitations rather than turning
  profiles into scoreboard claims.
- Reject a one-attribute row-writer outlining candidate after the existing
  parser-equivalence test and eleven engine pairs. Runtime and exact selected
  executable unchanged; no all-metric performance win claimed.

### UTF-8 research and decoder regression coverage

- Guard decoder tails with an inaccessible page, including truncations and
  malformed forms; exhaust all valid scalars at five padded offsets so
  fixed-word paths for short encodings cannot escape coverage.
- Add a fail-closed read-only replay checker for paired engine reports.
- Reject row-continuation reuse, ASCII-island batching and masked-word UTF-8
  decoding after balanced measurements/replication. No runtime promotion;
  exact selected executable restored. This is not an all-metric Ghostty win.

### Row locality research and regression coverage

- Compare global boxed row storage and cache-line row alignment in 39 engine
  pairs, then 54 real-terminal sessions and 12 quiet-RTT sessions for alignment.
  Reject both: boxing regresses Unicode/ASCII; alignment's engine Unicode gain
  reverses through the real PTY. No runtime promotion or all-metric win claim.
- Cover 1,260 region/origin/count combinations with history, ring seams, empty
  ranges, lazy-tail state, colors, uniform metadata and shared cell extras.
  Final restored-source checks: 137 library, 45 reference, 376 terminal and
  five validator tests pass (11 terminal tests intentionally ignored).

### Open intake

### Decoded Unicode handoff: fewer calls, larger hot routine, rejection

- Reject returning decoded put_row lookahead: 12 balanced engine pairs yield
  .918109 Unicode CPU ratio despite 4.1341% fewer instrumented decode attempts.
- Exact print_utf8 entry address stays fixed; static instructions grow from
  1,967 to 2,252. Caller instruction stream unchanged. Diagnostic, not causal
  cost attribution or a Ghostty win. No instrumented rates used as timing.
- Both arms pass 383 tests + 12,800 streams. Preserve 120 crate Rust files,
  6,421 prior reports/results and selected terminal; restore exact Cargo ELF.
- Retain raw sessions, census sources/failed first driver, disassembly, 23
  corruption checks and historical documentation adapter for frozen replay.



### Parser-ground boundary guard and fresh-build provenance

- Supplemental replay fixes an intermittent verifier-only diagnostic comparison:
  tolerate exactly one of three known first-stale-package messages, preserving
  all rejection flags, hashes and other diagnostics. Original artifacts remain
  unchanged; no runtime or performance gate changes.

- Retain 1,092 parser-differential read-boundary scenarios for partial UTF8,
  strings, CSI, sync and REP. A compiled partial-UTF8 mutant fails on cells.
- Reject shadow-parser removal despite 11-pair ASCII/scroll-region CPU gains
  (1.064495/1.068099); truecolor .922042 fails the prospective regression guard.
  Restore runtime, retain exact raw evidence; no new Ghostty score.
- Fix a measured build-provenance hazard: old source mtimes let Cargo reuse a
  mutant as control. New arm builder requires real recompilation, binds hashes
  and atomically publishes without clobbering; preserve the failed receipts.

### Static width storage research — runtime rejected
- Measured zero-initialized BSS widths against the selected heap-backed cache:
  Unicode CPU 1.001949x over 11 fresh pairs (6 wins, Holm p=1.0), failing the
  frozen warm gate. No runtime promotion or new Ghostty timing.
- Preserved a distinct 30-process first-lookup diagnostic: median thread CPU
  116,047 -> 1,994 ns, candidate lower in all 15 pairs. Not startup or retained
  RSS; max-RSS deltas were all zero, and static BSS grows. Full raw data retained.
- Added strict cold-capture replay and eight Python tests; 23 real-report
  corruptions reject without modifying evidence. Candidate/restored terminal
  tests and 12,800-stream sweeps pass. All 120 Rust files, 5,938 prior artifacts
  and selected terminal bytes unchanged. [Evidence](bench/results/2026-11-03-static-width-cache/README.md).


### Measured research and parser regression coverage

- Test CRLF records across chunking, modes, wide/combining predecessors, REP,
  sync output, suffix retention and actual 10,000-line history recycling.
- Reject bounded bulk-CRLF scrolling and a separate feed-outline ablation after
  complete 18-round terminal comparisons each. Preserve build/source/hash/raw
  receipts; neither runtime change ships. Exact selected executable restored.

- APC graphics (`ESC _ G …`): transmit and place over every transmission
  medium (direct, file, temporary file, shared memory), chunking, `o=z`
  compression, z-index above and below text, source rectangles, Unicode
  placeholders, relative placements, animation (`a=f`, `a=a`, `a=c`) and
  the full delete table.
- DCS sixel, with raster attributes and aspect.
- OSC 1337 inline images, `File=` and the multipart form: PNG, JPEG, GIF,
  TIFF, WebP, BMP, ICO, TGA and PNM.
- CSI u keyboard: the progressive key flags, alongside legacy key bytes.
- OSC 8 hyperlinks, opened with Ctrl+click (`http`, `https`, `file` and
  `mailto` only).
- tmux passthrough: wrapped sequences are unwrapped and taken in.
- Pictures follow the text: they move with scroll regions and the
  alternate screen, keep their place through reflow on resize, and text
  written over an in-cell picture hides only the cells it covers.

### glass's own dialect

`ESC _ glass; …` (reference: `docs/GLASS_DIALECT.md`):

- layers and groups, glows, ring and line strokes, particles;
- lit primitives and 3D scenes, with chrome and liquid materials;
- glTF 2.0 models with skinning and their animations;
- tweens that glass plays itself;
- video frames, charts, and a showcase panel above and below the text.

### The window

- The early window: on Wayland the window is on screen before the GPU is
  open. Its background (colour, image and tint) is drawn on the CPU into
  shared memory as soon as the window exists, the program starts as soon
  as the compositor has settled the window's size, its first output is
  drawn on the CPU too (same fonts, same colours), and the GPU's first
  frame takes over when the driver is ready.
- On processors whose dies carry last-level caches of different sizes
  (AMD's X3D parts), the pty read and parse threads stay on the largest
  one; `GLASS_AFFINITY=off` leaves them to the scheduler.
- `GLASS_RECORD=film.mp4` films the window as it is drawn, through ffmpeg
  and the GPU's encoder.
- Command-line flags follow the `xdg-terminal-exec` convention: `-e`,
  `--title`, `--class`, `--working-directory` and `--hold`.
- Settings live in `$XDG_CONFIG_HOME/glass/glass.conf`; glass's
  environment variables are named `GLASS_*`.

### Speed

Measured against kitty 0.49.2 on one machine (Ryzen 9 9950X3D, RTX 3090,
Hyprland), both in the same 154×39 window. Throughput workloads are timed
until the terminal answers DA1, as the median of five interleaved rounds;
startup is the median of 12 launches, caught at 240 Hz.

| | glass | kitty 0.49.2 |
| --- | --- | --- |
| First output on screen | 46.1 ms | 185 ms |
| Window on screen | 27.4 ms | 72.1 ms |
| Program running | 34.0 ms | 174 ms |
| Plain text | 490 MB/s | 326 MB/s |
| Truecolor | 253 MB/s | 91 MB/s |
| Full-screen TUI | 3,457 fps | 917 fps |
| Key press to the program, during a flood | 3.0 ms | 38.6 ms |

On macOS (M4 Pro), against Ghostty 1.4.0, glass is ahead on every measure
but wide text, which is about even; docs/PERFORMANCE.md has the table.

These are one machine's numbers, not a general claim.

### The terminal engine

- glass carries Alacritty's `alacritty_terminal` 0.26.0 as a fork in
  `crates/alacritty-terminal`, Apache-2.0 as upstream. Its README credits
  the authors and its CHANGES.md lists every change.
- It takes upstream's five fixes made since that release. Among them, a
  cell keeps at most nine combining marks, so a program can no longer
  exhaust memory by writing marks onto one cell.

### Platforms and packaging

- Linux on Wayland and X11 with Vulkan, for x86_64 and aarch64. The
  release binaries need glibc 2.31 or newer.
- macOS on Apple Silicon through Metal, from source: tested on an M4 Pro
  with macOS 26. There is no packaged macOS build yet.
- Release tarballs with the binary, a desktop entry, icons and the
  licences of every crate built in; a one-line installer
  (`install.sh`); AUR packages `glass-term` (from source) and
  `glass-term-bin` (from the release tarball).


## Research — 2026-11-03 (height-snapshot, iteration 37)
- Reject incomplete resize-coordinate repair despite 56,160 passing height-only
  picture/marker observations: 32 mixed-resize observations still fail.
- Reproduce a new shipping defect: unrelated tail truncation on a mixed-resize
  round trip deletes a picture whose text marker survives. Retain end-to-end and
  one-field matcher characterizations plus ignored desired-invariant matrices.
- Shipping runtime/executable unchanged; 392 tests and 12,800 differential streams
  pass; four Python tests reject 24 evidence corruptions. No speed or Ghostty win.

## Research — 2026-11-03 (origin-map, iteration 38)
- Separate physical-cell provenance from absolute-coordinate base and blank
  logical-slot anchors using real shadow-Grid resize replay. Base guard clears
  124,416 Unicode-marker observations (shipping fails 47,640); height/mixed
  nonblank matrices also pass. This is finite correctness evidence, not speed.
- Reject promotion: established blank-slot picture regression still fails.
  Retain exact build sources, raw failures, corrected probe, and setup mistakes.
- Shipping runtime/executable unchanged; 392 tests and 12,800 differential
  streams pass. Seven Python tests reject 27 evidence corruptions and 7 invalid
  configurations. No Ghostty comparison or latency/memory claim.

## Research — 2026-11-03 (blank-witness, iteration 39)
- Bound same-row trailing-blank witness rescue: slot failures 45,880 shipping,
  32,224 physical, 10,584 witness over 221,184 observations/arm. Even continuous
  in-bounds subset leaves 7,856 candidate failures; no runtime promotion.
- Prove two anchor histories collapse to identical next mapper inputs with
  different original logical-slot contracts. Reproduce new inactive-primary
  ghost picture after its own glyph/row is deleted (both parser lanes).
- Restore runtime and selected executable; 392 Rust tests, 12,800 streams pass.
  Five Python tests reject 36 record mutations, seven invalid coordinate shapes
  and duplicate keys. Retain setup/checker mistakes. No speed or Ghostty claim.

### Research: independent witness motion and event authority (2026-11-03, iteration 41)

No runtime promotion. Three controlled arms on the same final test source show
372 -> 24 -> 0 failures per 480 interleaved resize/scroll cases, at each of six
history-capacity settings. Transport picture and selected witness independently;
include witness-only rows in motion authority or the engine suppresses required
events. Real APC intake, both parser lanes, active/inactive primary resize, six
scroll operations, signed offsets. Prototype RIS cleanup also reproduced/fixed.
Full scope, failed builds/zero-test receipts, source snapshots and replay:
`bench/results/2026-11-03-scroll-witness/README.md`. Candidate still has the prior
three shipping-defect characterization failures and broad out-of-bounds slot
failures; no universal anchor, performance, memory or Ghostty win claim. Restored
shipping: 392 tests pass, 14 ignored; 12,800 differential streams pass per arm.

### 2026-11-03 — physical picture fragments retain independent identity

Fix successive region-scroll splits minting the same placement sequence, and a
vanished anonymous fragment deleting its surviving siblings. Allocate through
`Intake::bump`, remove physical fragments by sequence, and clone unsliced
coverage only when splitting. Real APC regressions fail 4/4 on control and pass
4/4 on the isolated production patch; 393 tests pass, 14 ignored. Broader resize
witness work remains research-only; selected release executable unchanged.
Evidence: `bench/results/2026-11-03-split-witness/README.md`.
