# Performance

Every number glass publishes, how it was measured, and what to keep in mind
when reading it. The harness and the raw results are in [`bench/`](../bench/);
[bench/README.md](../bench/README.md) says how to run it on your machine.

## The numbers

The original published comparison against **kitty 0.49.2**, on one machine:
Ryzen 9 9950X3D, RTX 3090, Omarchy (Arch Linux), Hyprland, a 154×39 window.
Medians. Later four-terminal and paired research results are separate below;
these historical numbers are not a claim about every subsequent build.

| Measure | glass | kitty 0.49.2 | |
| --- | --- | --- | --- |
| Program's first output on screen, from launch | **46.1 ms** | 185 ms | 4.0× |
| Window on screen, from launch | **27.4 ms** | 72.1 ms | 2.6× |
| Program running, from launch | **34.0 ms** | 174 ms | 5.1× |
| Plain ASCII through the pty | **490 MB/s** | 326 MB/s | 1.5× |
| Unicode | **215 MB/s** | 149 MB/s | 1.4× |
| Truecolor | **253 MB/s** | 91 MB/s | 2.8× |
| Cursor motion | **214 MB/s** | 81 MB/s | 2.6× |
| Scroll region | **444 MB/s** | 344 MB/s | 1.3× |
| Full-screen TUI frames | **3,457 fps** | 917 fps | 3.8× |
| CPU over all six workloads | **0.57 s** | 1.12 s | 2.0× less |
| VRAM, idle window | **45 MiB** | 50 MiB | 1.1× less |
| Key press to the program | **2.20 ms** | 2.25 ms | 1.0× |
| Key press to the program, while it floods output | **3.0 ms** | 38.6 ms | 13× |

![glass vs kitty, measure by measure](media/glass-advantage.png)

Every round and every launch behind these is in
[`bench/scoreboard-20261028.json`](../bench/scoreboard-20261028.json), and
the raw files are in [`bench/results/2026-10-28-linux/`](../bench/results/2026-10-28-linux/)
and [`bench/results/2026-10-28-keys/`](../bench/results/2026-10-28-keys/).
VRAM is from 2026-10-27 ([`bench/results/2026-10-27/`](../bench/results/2026-10-27/)).

## How each was measured

All of it ran on a headless Hyprland output made for the run (1920×1080):
each terminal was launched through `hyprctl` onto it, full-screen in its
tile, one terminal at a time, the terminals taking turns. Each terminal ran
with the machine's own configuration for it. glass and kitty both came up
at 154×39 cells.

### Throughput (`bench/run-tput.sh`, `bench/tput.py`)

- `tput.py` runs inside the terminal. It writes each workload through the
  pty and stops the clock when the terminal answers a DA1 query (`CSI c`),
  so every byte has been parsed, the way vtebench times it.
- Six workloads: plain ASCII (24 MiB), Unicode (16 MiB), truecolor (24
  MiB), cursor motion (16 MiB), a scroll region (16 MiB), and 300
  full-screen TUI frames on the alternate screen, every cell with its own
  background colour. [bench/README.md](../bench/README.md) describes each.
- Within a round, each workload is written three times and the fastest
  pass counts.
- Five rounds, glass and kitty taking turns. The table shows the median of
  the five rounds.
- **Full-screen TUI frames** is 300 frames over the fastest pass's time.

### CPU

The terminal's own CPU time (user and system, from `/proc/<pid>/stat`)
over each workload's counted pass, summed over the six workloads; the
median over the five rounds.

### Startup (`bench/run-startup.sh`)

- Sixteen launches of each terminal through Hyprland, taking turns.
- The clock starts just before the launch command goes to `hyprctl`, so
  Hyprland's own launch time is in both terminals' numbers.
- **Program running** is when the program inside the terminal writes its
  first timestamp.
- **Window on screen** is Hyprland's `openwindow` event, read from its
  event socket as it arrives. Hyprland sends it when the window's first
  buffer arrives.
- **First output on screen** comes from `bench/run-visible.sh`; see "When the
  prompt appears" below.

### VRAM (`bench/run-misc.sh`)

`nvidia-smi`'s figure for an idle window's process.

### Key latency (`bench/run-misc.sh`, `bench/keys.py`)

Forty key presses, each sent to the window through Hyprland
(`send_shortcut`), timed until `keys.py`, running inside the terminal,
reads the byte from the pty. The median of the forty. Hyprland's dispatch
is in both terminals' numbers. This stops at the program reading the key;
it does not include drawing the echo.

The same measure while the program floods its output (`yes` writing to
the terminal for the whole run) is `bench/keys-latency.sh` with
`LOAD=yes`. The table gives the median of three runs' medians, glass and
kitty taking turns, measured on 2026-10-28; the logs are in
[`bench/results/2026-10-28-keys/`](../bench/results/2026-10-28-keys/).
- **What it measures:** a flood is when a terminal is busiest, and a key typed into it then (Ctrl+C to stop it) waits for whatever the terminal is busy with.
- **How glass avoids the wait:** the window's input thread writes the key to the pty itself, from the program's modes as the parsing thread last published them. It never takes the engine's lock, and it never waits for a frame to finish drawing.

## Say this plainly

### What "window on screen" shows

glass shows its window before the GPU driver is ready. The NVIDIA driver
takes about 100 ms to open, so glass draws on the CPU first: the background
colour, the background image and its tint, then, once the program has
written something, its cells (backgrounds, glyphs from the same fonts,
underlines and the cursor), as the GPU will draw them. The GPU's first frame
then replaces it, with nothing visibly changing.

So 27.4 ms is when the window, with its real background, is on screen.
That is what Hyprland reports, and it is the same event for kitty. kitty's
own window is up at 72.1 ms, and its shell runs at 174 ms.

The early frame is drawn on Wayland only. On X11, or if any step of it
fails, glass shows the window with the GPU's first frame, and the program
starts after that frame.

### When the prompt appears

This is the startup number to judge a terminal by: launch until what the
program writes first is on screen.

- **Method.** `bench/run-visible.sh` measures it:
  - The program paints the whole screen magenta as its first act.
  - `bench/visible/viscap.c`, a wlr-screencopy client, keeps one frame request always open on a spot in the middle of a 240 Hz headless output. It gets every frame Hyprland renders there, with Hyprland's own timestamp.
  - The time is the first frame after the launch where the spot is magenta.
  - It is accurate to one frame, 4.2 ms. A calibration client that flips its window at known moments is caught within a frame plus about half a millisecond.
  - The open animation is turned off for the test windows only, so a fade-in doesn't delay either terminal.
- **Result.** Medians of 12 launches each, the two terminals taking turns:
  - **glass: 46.1 ms;**
  - kitty: 185 ms.

  Every run, the calibration and the GPU load are in [`bench/results/2026-10-28-linux/visible.json`](../bench/results/2026-10-28-linux/visible.json). The first published run, on 2026-10-27, gave 61.5 against 206 ms ([`bench/results/2026-10-27/visible.json`](../bench/results/2026-10-27/visible.json)).
- **How glass gets there.** The shell starts at about 35 ms, as soon as the compositor has settled the window's size, while the GPU is still opening. Its first output is drawn on the CPU in the window's early frame. Before that early text, glass's first output came with the GPU's first frame, at 172.7 ms.
- **kitty's config.** kitty read the author's config here. In an earlier session with `--config NONE`, kitty's first output came 18 ms sooner than with that config. Either way glass is three to four times quicker.

`GLASS_STARTUP_TRACE=1` prints each step of glass's startup on stderr, with
milliseconds since `main`.

### Plain ASCII and the CPU's cache

On CPUs whose dies have last-level caches of different sizes (AMD's X3D
parts), glass keeps its pty read and parse threads on the die with the
largest one. Without that, plain ASCII swung between about 250 and 430
MB/s on this CPU, depending on where the scheduler put the thread.
`GLASS_AFFINITY=off` turns the placement off. On a CPU with one L3, or
several of one size, nothing is placed and nothing changes.

### Which terminals have been measured

glass, ghostty 1.4.0, kitty 0.49.2 and foot have been through the throughput
harness at 154×39; alacritty and wezterm have not. The startup, key-latency
and VRAM measures have been run for glass and kitty only, so the comparison
against ghostty is throughput and CPU alone.

glass leads the set on truecolor and cursor motion and spends the least CPU of
the GPU terminals. ghostty is ahead on plain ASCII, scroll region and unicode,
and level on full-screen TUI frames. Adding a terminal to the harness is one
line ([bench/README.md](../bench/README.md#add-another-terminal)).

Numbers and raw results:
[bench/results/2026-11-02-head-idle-scoreboard/](../bench/results/2026-11-02-head-idle-scoreboard/).

### Rounds, and what a difference has to clear

ghostty's throughput varies widely on this machine — its ASCII ran 846 to
1,139 MB/s across five rounds — so medians of fewer than five rounds do not
reproduce. For comparing two glass builds, `bench/run-tput.sh` takes a
`glass-alt` arm that interleaves both binaries in one run; a sign test over
the paired rounds resolves a 3% change at fifteen rounds, where an unpaired
median at nine cannot resolve 5%. Code placement alone is worth up to 2.7% of
a median without moving the signs
([bench/results/2026-11-02-paired-method/](../bench/results/2026-11-02-paired-method/)).

### One machine

These numbers come from one machine. Other GPUs and CPUs will differ, and
nothing here has been measured on AMD or Intel graphics, on a laptop, or on
a CPU with a single L3.

### Which build

"Window on screen" and "program running" were measured on the build at
this repository's commit `42ec6b3`. "First output on screen" was measured on
the build that added the early frame's text, the commit after the 0.1.0
renames. The throughput rounds ran on the development build just before
`42ec6b3`, which added the early frame; no later change touched the pty
read path.
[bench/results/2026-10-27/](../bench/results/2026-10-27/) has the details.

## macOS

glass against Ghostty 1.4.0, on an M4 Pro Mac mini (macOS 26.6, Metal).
Both had a 160×48 grid. The harness is `bench/macos/`, and the runs and
their method are in `bench/results/2026-10-28-macos/`. Five rounds for
throughput and twelve launches for startup, the two taking turns.

| Measure | glass | Ghostty | |
| --- | --- | --- | --- |
| Program running, from launch | **37 ms** | 141 ms | 3.8× |
| Window on screen, from launch | **162 ms** | 226 ms | 1.4× |
| Plain ASCII | **364 MB/s** | 281 MB/s | 1.30× |
| Unicode | 246 MB/s | 237.5 MB/s | about even |
| Truecolor | **254 MB/s** | 214 MB/s | 1.19× |
| Cursor motion | **209 MB/s** | 188 MB/s | 1.11× |
| Scroll region | **351 MB/s** | 285 MB/s | 1.23× |
| Full-screen TUI | **2,863 fps** | 2,436 fps | 1.18× |
| CPU, six workloads | **0.84 s** | 1.36 s | |

What it took on the Mac:

- **The pty is read on a thread of its own, gathered.**
  - macOS's pty hands over at most 1 KiB a read, at about 2 µs each.
  - A thread reads into one buffer, and the parsing takes the whole buffer at once.
  - After a full read the thread waits 1.5 µs for the program to refill the pty. Its next read then finds bytes instead of sleeping and being woken, which costs more than the read.
  - Plain text through a window went from 321 to 371 MB/s.
- **Colour changes and cursor moves skip the parser** in their plain forms. A parity test holds the result to vte's own on random escape-dense streams.
- **Wide text is written a row at a time,** and a combining accent goes onto its letter's cell without leaving that path.
- **The row the next scroll reuses is prefetched** on Apple Silicon, as it already was on x86.
- **mimalloc is glass's allocator.** The system allocator was slow at the many small allocations accents make.
- **The reading and parsing threads are user-interactive,** which keeps macOS from moving them to the efficiency cores.
- **The program starts before the window.** macOS takes about 70 ms to let an app make its window. A window there gets the size it asks for, so glass starts the program on that grid as soon as its fonts are loaded.

Plain text and the scroll region run near what the pty itself can carry: a
reader that only reads gets about 260 to 300 MB/s through it. Unicode is
close: Ghostty's rounds ranged from 219 to 316 MB/s, and glass's from 243 to
247.

## Later paired optimization research (2026-11-02)

The release-style experiments after the four-terminal scoreboard are retained
with exact executable hashes, raw through-PTY runs and differential checks:

- [SSE2 run scanning](../bench/results/2026-11-02-sse-scan/README.md) and
  [single-mark sharing](../bench/results/2026-11-02-mark-cache/README.md).
- [Early reader-credit recycling](../bench/results/2026-11-02-early-recycle/README.md),
  including a fresh-control final rebuild, verification logs and quiet DA1 RTT.
- [Final-readable-byte HUP correction](../bench/results/2026-11-02-hup-drain/README.md),
  reproduced by a failing raw-PTY test before the fix; this is a correctness
  result, not a throughput claim.
- Rejected [immediate scalar commit](../bench/results/2026-11-02-direct-commit/README.md),
  [width-cache hoisting](../bench/results/2026-11-02-width-hoist/README.md), and
  [a third reader buffer](../bench/results/2026-11-02-third-credit/README.md).

The engine test executable is a screening instrument, not the acceptance gate:
two Unicode candidates passed parser equivalence yet lost to control through
a real terminal, including one that won all eleven engine pairs. Correctness
and microbenchmarks alone do not establish a speed improvement. The newer
[balanced gate](../bench/README.md#balanced-real-terminal-gate) retains all six
three-terminal launch orders, paired signs, binary/harness hashes and raw data.
Significance tests are exploratory; six workloads also create multiple-testing
risk. Small medians with inconsistent signs are not wins.

These experiments do **not** establish leadership on every metric. Startup,
key-to-screen latency, CPU/memory use, feature compatibility and other machines
need their own controlled comparisons. Quiet DA1 RTT measures a different path
from key-to-screen latency, and this Linux reader change is not a macOS result.

### Producer-placement sensitivity is not an optimization

A separate Linux diagnostic at
[`2026-11-02-producer-placement`](../bench/results/2026-11-02-producer-placement/README.md)
kept the terminal binary, payload and terminal-thread CPU masks fixed and
restricted only the process writing the PTY. On this 9950X3D, twelve balanced
rounds found Glass small-cache-domain/unpinned paired ratios of **0.5735 ASCII**,
**0.9287 Unicode**, and **0.6754 scroll region**. Ghostty's corresponding
experiment did not find reliable differences. Restricting the producer to the
large-cache domain did not establish an improvement over unpinned for either.

This is a reproducibility/sensitivity result, not a new default-terminal score.
It does not separate producer execution capacity, clock speed, scheduling, PTY
cost or cross-domain communication; allowed masks do not record actual CPU
residency. Nor does a non-significant Ghostty result prove equivalence or a
terminal-by-treatment interaction. The default gate remains unpinned. The new
`bench/linux/run-producer-placement.sh` records treatment orders, topology,
binary/harness hashes, producer and terminal-thread masks, complete raw results,
and validated summaries so a restricted-child diagnostic cannot silently pass
for default behavior. The next causal controls are a fast sink, fixed minimal
PTY reader, and scheduler/blocked-time traces, not a more favorable leaderboard.

## Session-overhead ablations: no promotion

Three independent 18-round six-order comparisons tested consumer-side
nonblocking coalescing, lazy frame cuts, and stack-backed splitter output.
None established dependable ASCII/Unicode/scroll-region wins while guarding
other metrics. The tempting inline-piece ASCII +9.5% median won only 10/18
pairs, while TUI lost 17/18. Severe variation also affected unchanged controls;
this is not a causal diagnosis. See the [reports and raw provenance](../bench/README.md#session-overhead-ablations-2026-11-02).
Runtime source and exact selected executable were restored; seven final
reader/frame-gate tests pass. The matched-input stage evidence below narrows the next investigation; full
full scheduler-event/PMU traces remain unavailable (the later own-thread scheduler
accounting diagnostic is not an event trace). No favorable subset replaces the gate.

## Matched-input profiles: separate bottlenecks, no promotion

The [36-session frozen-binary diagnostic](../bench/results/2026-11-02-pipeline-profile/README.md)
retains all 432 instrumented passes and measures profiler overhead against plain
sessions. Unicode, truecolor, cursor and TUI parsing spend ~98.6-99.0% of pass
wall time on parser CPU; ASCII and region ~53.1% and 52.3%, with much more reader
CPU and handoff activity. The reproduced slow Unicode pass was 133.9 ms wall /
131.1 ms parser CPU, not simply an off-CPU scheduling stall.

Leaf-IP sampling put 435/547 Unicode parser samples in `print_utf8`, consistently
across three sessions. Reader call-label controls put most delivered ASCII and
region samples inside `read`, not readiness polling. Timer delivery was coarse
and heavily coalesced; this is not a kernel profile or exact syscall cost split.
A one-attribute row-writer outlining experiment passed parser equivalence but
failed to improve Unicode in eleven engine pairs and was rejected. Exact runtime
source and selected executable remain unchanged. These are diagnostic findings,
not new scores, causal frequency/cache attribution, or an all-metric victory.

## The film

"Mind's eye" is 95 seconds at 1080p and 60 fps. Every frame is a program
(`crates/term/examples/glass_mindseye`) writing escape codes into the pty,
and glass drawing them.

- Up to 9,662 layers a frame.
- 4.4 GB of escape codes in 86 seconds (51 MB/s).
- glass answered each frame in 5.8 ms on average. The program sends each
  frame inside a synchronized update and then waits for glass to answer a
  DA1 before building the next; the numbers in the film's corner are those
  measurements, taken as it runs.
- Recorded by glass itself, through the GPU's encoder (`GLASS_RECORD`).
- 5,699 of 5,700 frames drawn; the recorder repeated one. A frame the
  window is too slow for is repeated, not caught up, so the film keeps the
  wall clock's time and shows a stall as one.

`bench/take-mindseye.sh` records a take of it.

## Reproduce

```sh
cargo build --release -p glass-term
export GLASS=$PWD/target/release/glass
ROUNDS="1 2 3 4 5" bench/run-tput.sh && python3 -I bench/summarize.py
RUNS=16 bench/run-startup.sh
RUNS=12 TERMS="glass kitty" bench/run-visible.sh
bench/run-misc.sh
```

The harness launches through Hyprland; [bench/README.md](../bench/README.md)
has the requirements, what each script measures, and how to add a terminal.

## Transport-only control: producer/reader pairing matters

A new diagnostic removes the terminal entirely: the existing benchmark's payload
bytes are written to null, pipe and raw-PTY sinks, with only a minimal C reader.
Three randomized 12-block runs retain **972 measured trials**. With the reader
on large L3, small-domain producer PTY throughput fell to .356/.427/.340 of
unrestricted placement (ASCII/Unicode/region), replicated at .370/.441/.433.
Moving only the reader to small L3 reversed the relationship: the small-domain
producer was .995/.996/1.011, while a large-domain producer was .847/.847/.823.

This establishes that the placement effect can occur without Glass's parser or
renderer and depends on reader/producer domain pairing in this control. It does
**not** identify the kernel mechanism or predict a terminal speedup: Glass also
hands those bytes from reader to parser. Cross-run sink medians are not paired
policy estimates, host load changed, and exploratory sign tests are uncorrected.
No benchmark producer/competitor affinity or official throughput workload changed.
See [method, all raw receipts and caveats](../bench/results/2026-11-02-transport-control/README.md).

The previously interrupted bounded-channel experiment was completed (14 inherited
rounds plus 4 explicitly resumed rounds) and rejected; no robust gain and a .9701
TUI median ratio. The pending branchless-wide store experiment passed the existing
differential test but lost **6.9% Unicode in 11/11 pairs**, so it too was removed.
These negative results are not a new selected-source victory over Ghostty.

The follow-through **reader-only small-L3 policy was tested and rejected** in a
fresh-control, 18-round, unchanged terminal gate: ASCII .6852 and region .6623,
each losing 17/18 pairs. The original source and measured executable are restored.
This is the production counterexample to inferring a win from transport alone.
The same gate's selected-control/Ghostty Unicode ratio was **.9522 (6/18 wins)**;
there is still no all-metric championship. See
[the complete gate and control-only comparison](../bench/results/2026-11-02-small-reader/README.md).


### Checked scanner/decoder research: four candidates, no runtime promotion

The [two-block SSE2 report](../bench/results/2026-11-02-sse2-unroll/README.md)
records an engine +1.2% ASCII result that disappeared in the complete 18-round,
six-order real-terminal gate: candidate/control ASCII .9970, Unicode 1.0011,
region 1.0012; no dependable production benefit. Full raw results and binary,
harness and result hashes replay. The candidate was removed.

The fresh **selected-control/Ghostty** arm of that same run gives paired median
ratios ASCII .9465 (7/18 wins), Unicode 1.0108 (9/18), truecolor 1.1972 (15/18),
cursor 1.1260 (14/18), region .9672 (8/18), TUI 1.0674 (13/18). This shared-host
run does not show every-metric superiority; Unicode's apparent parity is not a
reliable win, and small/variable results do not establish a world title.

Other bounded experiments:
[exact-prefix UTF-8 memo](../bench/results/2026-11-02-decode-memo/README.md)
lost 10.0% Unicode engine throughput (0/9 wins);
[AVX2 long-suffix scan](../bench/results/2026-11-02-avx2-scan/README.md)
was mixed (+4% ASCII/region, -2.3% Unicode diagnostics), not selected;
[duplicate scalar-check removal](../bench/results/2026-11-02-validated-scalar/README.md)
gained only ~1.2% in a focused replication with mixed signs, not enough evidence
to introduce a new unsafe scalar construction. No terminal wins are claimed
for engine-only experiments.

The durable change is three regression tests: exact SIMD/control/high-bit
boundaries, legal slice ends immediately before an inaccessible page, and all
1,112,064 Unicode scalars with truncations and boundary-form rejection checks.
On the final selected source, two scanner tests and two decoder tests pass.
Runtime scanner/decoder code and the selected release executable are unchanged.


### CRLF bulk scrolling and feed code generation: rejected trade-offs

The [bounded CRLF experiment](../bench/results/2026-11-02-bulk-lines/README.md)
replaced several bottom-of-region ASCII/CRLF rotations with one, retaining
suffixes and parser equivalence. Nine engine pairs gained **18.3% ASCII and
18.8% region (9/9 each)**, but lost **11.8% truecolor (0/9 wins)**. Two follow-ups
changed guarding/inlining; the selected candidate's full 18-round, six-order
terminal gate did **not** transfer the ASCII/region gain: ratios **.9855** and
**.9777** against its frozen control. Runtime batching was removed.

That candidate also forced `feed` out of line. Its **11.0% truecolor (17/18)**
gain therefore could not be attributed to batching. A [one-line fresh-control
ablation](../bench/results/2026-11-02-feed-outline/README.md) removed all batching:
truecolor still gained **8.35% (17/18)** and cursor **1.46% (15/18)**, while ASCII
was **.9105 (5/18)**, Unicode **1.0075 (12/18)**, region **.9801 (8/18)** and TUI
**.9944 (6/18)**. It too was rejected: not a useful all-metric promotion. Region
is inconclusive, not a proved regression; ASCII's sign p=.1435 is not a
conventional significant loss. These are conservative promotion decisions.

Both full gates retain **108 terminal sessions total**, source/build receipts,
all six balanced orders, binary/harness/raw JSON hashes and successful hash
replays. Shared-host sign tests are exploratory and uncorrected. The one-line
ablation confirms that the truecolor direction does not require batching;
it does not prove an instruction-cache/register-allocation mechanism.

The fresh selected-control/Ghostty arm of the ablation measured ASCII **.9790
(8/18)**, Unicode **1.0075 (9/18)**, truecolor **1.1777 (16/18)**, cursor **1.1241
(15/18)**, region **1.0446 (10/18)**, TUI **1.0765 (15/18)**. ASCII, Unicode and
region still lack dependable victories. This fresh rebuilt same-source control
is not the exact historical selected executable; no cross-run medians or
binary identities are silently merged. **No world championship is established.**

Runtime source and exact selected release executable were restored. Retained
changes are two parser-equivalence regressions for CRLF chunking, terminal
modes, suffixes, wide/combining predecessors, REP, synchronized output, and a
real **10,100-record / 10,000-line-history** recycling case. The final relevant
release test gate passed **3 tests** (two new, one existing filter match).
The bulk V1 and V3 experiments separately passed **12,800 differential streams
each**; those receipts are candidate-specific, not a final workspace sweep.


### UTF-8 follow-up: no reproducible runtime gain

[Three distinct candidates](../bench/results/2026-11-02-word-decode/README.md)
passed parser equivalence; none was promoted. Continuation reuse lost 1.76%
Unicode in 11 engine pairs; byte-proven ASCII islands lost 11.01% in all 11.
Combined continuation-byte masks and a bounded four-byte load initially gained
1.16%, then replicated at -0.48% (5/15 wins). These are engine diagnostics,
not terminal or Ghostty scores, and neither test series is selectively pooled.

A useful safety gap was closed: exhaustive short UTF-8 scalars without padding
cannot exercise a four-byte decoder path. Added all valid scalars at five
padded offsets plus valid/malformed/truncated tails immediately before an
inaccessible page. Four decoder tests and the parser differential pass on
selected source. Runtime source (apart from tests) and the exact historical
selected release executable remain unchanged. Raw reports independently
replay via `bench/replay-engine-pairs.py`.


### Row locality: structural gains that failed the all-metric gate

[Boxing physical rows](../bench/results/2026-11-03-boxed-rows/README.md)
improved scroll-region engine CPU throughput 7.74% in 11 alternating pairs,
but lost 5.20% Unicode and 1.25% ASCII in all 11 pairs. Moving pointers instead
of row metadata is not a free region optimization: reject the global design.

[64-byte row alignment](../bench/results/2026-11-03-row-alignment/README.md)
kept inline storage and gained 2.93% Unicode in an independent 17-pair engine
replication. In 18 cyclic-balanced real-terminal rounds (54 sessions), however,
Unicode lost 1.53%, 16/18 pairs. The engine gain did not transfer. These rounds
balance launch position but are not the full-permutation canonical protocol.
Quiet DA1 RTT also supplied no latency benefit; it is not key-to-screen latency.
Neither candidate ships, and neither result is an all-metric Ghostty win.

The retained storage regression compares 1,260 region/origin/count combinations,
including history, ring seams, empty ranges, per-row backgrounds, uniform
metadata, shared extras and partially overwritten lazy tails. Restored-source
checks passed 137 library, 45 reference and 376 terminal tests (11 ignored),
plus five replay-validator tests. All three new engine reports and all 54
terminal sessions replay. Runtime source and the exact selected executable
remain unchanged; see the report's restoration hashes and scoped test receipts.


### Immutable extras and widths: four measured leads, no all-metric promotion

A [bounded immutable-mark pool](../bench/results/2026-11-03-static-marks/README.md)
removed Arc reference-count traffic for 112 common combining marks without
increasing the 24-byte cell cap. Its isolated 24-round PTY replication gained
28.46% Unicode versus a fresh control, and 22.24% versus Ghostty. A separate
[build-time width table](../bench/results/2026-11-03-immutable-width/README.md)
replicated a 12.19% truecolor gain. Neither is independently selected.

The [combined exact-build candidate](../bench/results/2026-11-03-marks-width/README.md)
received separate correctness checks and two independent PTY series, not pooled
with the isolated results. Its 30-round replication gained 22.29% Unicode and
12.98% truecolor versus control. Versus Ghostty, medians were Unicode +16.09%,
truecolor +32.66%, cursor +12.69% and TUI +8.27%; those four clear six-workload
Holm correction within that series/comparator. **ASCII and scroll-region do
not establish a lead.** The first combined series was substantially noisier,
including unresolved Unicode and an adverse ASCII median; it is preserved.
Shared-host load and code/data layout prevent a narrow causal claim.

No noninferiority tolerance was predeclared, and nonsignificance is not
nonregression. The recorded all-metric requirement remains unmet, so the
candidate is **unpromoted**: all 120 original Rust paths and the exact selected
release executable are restored. The public extra-field type change and unsafe
ownership code remain archived research, not a silently shipped API change.
Final-candidate checks passed 140 library, 45 reference, 9 strict-provenance
Miri cell tests, exhaustive scalar widths, parser parity and 12,800 differential
streams. Quiet RTT (12,000 replies) and eight startup launches per binary are
descriptive guards, not key-to-screen latency or proof of superiority. The
retained RTT runner now has standalone fail-closed replay and ten checker tests.


### Raw Linux read and independent terminal replay (2026-11-03)

A narrow replacement of the Linux reader's cancellation-enabled libc `read`
route with raw `SYS_read` did not demonstrate dependable ASCII or scroll-region
improvement. The full 18-round, six-order, three-arm series contains 54 real-PTY
sessions at 154x39. Candidate/fresh-control median paired ratios were 1.03686
for ASCII (11/18 wins, uncorrected sign p=.480682) and 1.01659 for region (12/18,
p=.237885); the four other workload point estimates were below one. Reject the
candidate, not the observed data. This does not establish zero syscall-wrapper
cost or a championship; selected runtime and exact executable are restored.

A concrete disposable-copy corruption experiment found that the old
`compare-tput.py --summarize-only` rewrites altered comparison summaries instead
of rejecting them. The independent `replay-terminal-pairs.py` is read-only and
checks stored derived results, runner/harness hashes, raw sets/shapes/hashes and
optional executable hashes. Its rounding-aware rate/time checks do not invent
unrecorded exact timestamps. Eleven synthetic corruption tests pass. Ten frozen
supported datasets, 630 terminal sessions, replay without modifying their reports.
One older `glass.cyclic-terminal-comparison/v1` dataset is explicitly unsupported,
not quietly accepted. This is integrity/consistency evidence, not timing accuracy.

The full protocol, raw data, rejection, corruption demonstration and limitations
are in `bench/results/2026-11-03-raw-read/README.md`. Do not reclassify sampled time
in `read` as proof of glibc-wrapper overhead or promote a noisy positive median.

### Reader call shapes and tail policy (2026-11-03)

An opt-in own-process interposer measured the unchanged `pty-read` thread in
12 balanced plain/count/timed rounds. All 648 pass profiles and trace hashes
replay; calls at pass boundaries are accounted separately. Captured reads reach
16 KiB, and reads above 4 KiB carry about 70% of ASCII/region bytes. The 4-KiB
spare-capacity constant is a coalescing policy, not a Linux read-size bound.

In timed captures, median wholly contained read/poll wall fractions were 92.7%
ASCII and 94.4% region versus 24.5–27.2% on Unicode/styled workloads. These are
inclusive wrapper/glibc/kernel spans, not pure kernel cost or blocked-versus-
runnable evidence. The observer changes pacing: timed/plain ASCII median ratio
is .91569, and plain ASCII itself ranges 173.0–1095.7 MB/s on this shared host.
Non-significant comparisons are not equivalence. Do not use this diagnostic as
a scoreboard or infer a reader-buffer optimization from it.

A distinct uninstrumented 18-round, three-arm gate tested only changing the
minimum spare-capacity threshold 4096->1, preserving two 16-KiB buffers,
readiness cadence and zero waiting. Candidate/control median ratios were
.98687 ASCII, .96540 Unicode, .94501 truecolor, .97534 cursor, .92324 region,
and .97583 TUI. No control improvement was established; reject. The independent
checker replays all 54 sessions and exact binary hashes. Seven existing reader
tests pass, starting runtime statements/constants are restored, and the exact
selected executable is byte-compared. Corrected comments and diagnostic tools
remain. Five disposable-copy corruptions are rejected read-only. See
`bench/results/2026-11-03-read-shape/README.md` for raw evidence and limits.


### Own-reader runnable-wait accounting (2026-11-03)

A new own-thread calibration demonstrates that `sched_schedstats=0` alone did
not disable `/proc/<tid>/schedstat` run-delay accounting on this kernel.
Thirty-six balanced busy/sleep/own-child-contention trials distinguish sleep
residual from runnable waiting. The historical conservative-null reports are
preserved, not silently reinterpreted. This is not a full scheduler-event trace.

A separate 36-session plain/clock/scheduler capture of the unchanged selected
executable measures whole-reader windows. In the scheduler arm, median runnable
wait fractions are 34.91% ASCII and 32.64% scroll-region, with median time
coverage 96.61%/95.92% and conservative snapshot uncertainty 0.65%/0.79%.
Component-wise medians are not additive. Runqueue share of off-CPU time has
median 44.00%/59.70%; treating all reader off-CPU time as blocking is not supported
in this capture. Residual includes unclassified off-CPU/accounting time and
cannot attribute PTY kernel copy/locking or channel waits uniquely.

Observer/control throughput ratios are noisy: scheduler/plain ASCII 1.00652,
scroll-region 1.02143, TUI 0.92408; no uncorrected sign p<.05, not equivalence or
neutrality. These are instrumented diagnostics, not a competitor gate or runtime
promotion. Full evidence, explicit source snapshots, read-only replay, separate
3-session pilot and 3-session hardened-observer smoke, and limits are in
[`scheduler-shape/README.md`](../bench/results/2026-11-03-scheduler-shape/README.md).
No new all-metric Ghostty victory is established. A predeclared bounded own-CPU
contention control is the next causal measurement, not another buffer tweak.

### Own-reader contention: observer sensitivity, not a policy win

The predeclared causal follow-up is complete: 12 balanced six-arm rounds,
**72 confirmatory sessions**, plus distinct six-session pilot and six-session
hardened-wrapper smoke. Only the own reader is pinned to CPU 0; sleep/busy
helpers share CPU 0. No Rust source, selected executable, priority, global
setting, payload, geometry, or DA1 completion policy changed.

Plain-arm busy/sleep median paired ratios: ASCII **0.9108** (3 faster/9 slower;
Holm p=.291992), scroll **1.0132** (7/5; p=.774414), Unicode **0.9780** (1/11;
p=.031738). These are artificial-restriction sensitivities, not unrestricted
performance changes. No significant ASCII/scroll penalty is not equivalence.

Scheduler-arm recorded runnable fraction increases in 12/12 ASCII and 11/12
scroll/Unicode rounds. Scroll throughput ratios disagree: plain 1.0132,
clock 1.0611, scheduler 0.8578. An explicitly **post-capture exploratory** paired
scheduler/plain ratio-of-ratios is 0.9008 (11/12 below 1; Holm p=.038086).
Treat this as an observer-interaction warning, not mechanism proof. Unicode
busy snapshot uncertainty reaches 2.54% of sampled wall; residual is not pure
blocking. These observations cannot justify a shipping scheduling change.

The [full report](../bench/results/2026-11-03-reader-contention/README.md) retains
all rounds, orders, masks, identities, traces, failed pilot, source snapshots,
read-only replays, ten non-mutating evidence-corruption challenges, and three
catchable-signal cleanup cases. The exact selected release remains unchanged.
The all-metric Ghostty goal is still open; no runtime candidate is promoted.


### Same-L3 reciprocal hot-thread placement — research, not promotion

The [iteration-18 package](../bench/results/2026-11-03-hot-placement/README.md)
compares two same-L3 SMT-sibling pairs with reciprocal distinct-core pairs and
shipping `auto` masks on the **unchanged selected executable**. It uses unchanged
six-workload `tput.py` with no samplers or pass hooks; boundary checks/artificial
pins mean this is not an ordinary terminal score. A five-session pilot and two
fresh 100-session series replay. An additional initial 100-session run is
**rejected and retained**: a strict non-target-mask invariant encountered GPU
thread changes. V2 observes/reports those changes, was frozen before new
collection, retains all hot-thread/producer/restore checks, and drops no sessions.

First v2 primary distinct/sibling family: no six-workload Holm rejection.
Replication: Unicode, truecolor and TUI reject within its primary family, not
uniformly replicated primary significance. Secondary distinct/auto ASCII
median paired ratios are **1.32602** and **1.30988**, 17/3 round wins/losses in
each, within-secondary-family Holm p=.015461 in each. Those are shared-host
placement leads, not pure SMT attribution, a shipping-policy validation, or new
Ghostty wins. Deterministic balancing does not establish independent round
signs for binomial inference; no pooled or either-series-significant guarantee.
A post-capture witness records busy compiler load, not pass-level causation.

Exact selected binary and all 120 Rust sources remain unchanged. No runtime
promotion: next is controlled host-load/core placement with prospective
worthwhile-benefit and regression bounds, then fresh complete competitor,
startup, real key-to-screen and correctness gates. The all-metric goal remains
open. Full numbers, exclusions, assumptions and read-only commands are in the
[report](../reports/research-1eecf9876bb302e9da10ff629e71e6d8-18.txt).


### Exclusive-column Unicode lane screen (2026-11-03)

A separate prospective 11-pair engine diagnostic changed only `put_row`'s
internal cursor representation to one-past-the-last-written cell. Unicode
candidate/control CPU-throughput was **0.979261** (3/11 wins, six-workload Holm
p=1), failing the >=1.02 target and .98 point-regression guard. The runtime
change is rejected/restored; no terminal candidate/competitor run followed.
This is not a statistically proven slowdown, equivalence result or new
Ghostty score. Alternating launch orders do not establish independent signs.

The retained change is a pending-wrap parser-differential regression. A built
mutant that drops pending wrap fails on actual cells at 154x39/chunk 155; both
correct executables pass. Restored verification: 380 terminal tests (11 ignored),
12,800 differential streams, 49 Python tests, nine evidence-corruption rejections
and 535 historical file references. Production source and selected executable
are unchanged; only test source evolves, with one explicit historical snapshot
for old evidence. All 5,826 tracked prior result/report files remain unchanged.
See the [full report](../reports/research-1eecf9876bb302e9da10ff629e71e6d8-20.txt)
and [replay commands](../bench/results/2026-11-03-exclusive-column/README.md).
The every-metric/world-title objective remains open.


### Row-scoped width-cache handle: failed screen and cold-resource finding

Iteration 21 tested one new mechanism, retaining the existing cache values and
atomic fill policy but acquiring its handle once per Unicode row lane. The
fresh-control 11-pair diagnostic gave Unicode **1.009280× CPU throughput**,
9/11 wins, six-workload Holm p=.261719: below the prospectively frozen >=1.02
and p<.05 requirements. The runtime change is rejected/restored, without extra
pairs, variant, terminal follow-on, replication or score substitution. All six
point ratios exceed .98 but do not prove noninferiority/equivalence. ASCII's
1.018585 point ratio cannot be attributed to the Unicode path it bypasses.

A separate post-screen instrumented fresh-process diagnostic establishes a
mechanism missed by the warm minimum-of-five timing: C1-only UTF-8 input can
initialize the candidate's entire cache without a width query. Control C1 and
both ASCII cases stay uninitialized; both wide-Unicode cases initialize. The
cache payload is 1,114,112 one-byte atomic entries (1.0625 MiB), derived from the
representation, **not measured RSS, startup latency, energy or allocator cost**.
Six exact isolated tests pass; the diagnostic does not reverse the failed gate.
Neither instrumentation nor diagnostic test is in production source.

Only a 2,688-scenario C1 parser-differential regression remains. It fails on
actual cells for a built C1-to-glyph decoder mutant. Restored correctness:
381 terminal tests, 12,800 seeded streams, 49 Python tests and nine corruption
rejections. Production runtime, selected executable and 5,869 prior result/report
files are unchanged; test/document evolution has explicit historical snapshots.
[Report](../reports/research-1eecf9876bb302e9da10ff629e71e6d8-21.txt) and
[replay](../bench/results/2026-11-03-width-handle/README.md).

No new Ghostty measurement. The preceding exact selected-build series still
shows only three of six corrected positive throughput leads; startup, memory,
input/presentation, sustained GPU and multi-platform objectives remain open.
Do not infer world-title or campaign completion from this local checkpoint.

### Static width storage: cold first-use gain is not a warm-throughput win

The [frozen cache-representation experiment](../bench/results/2026-11-03-static-width-cache/README.md)
replaces the heap-backed OnceLock widths with const-zero BSS AtomicU8 storage,
without changing Unicode width policy or the row loop. Eleven fresh AB/BA pairs:
Unicode CPU ratio **1.001949**, **6/11** wins, six-workload Holm **p=1.0**.
The >=1.02/corrected-sign gate failed: **no runtime change or terminal follow-on**.

A separately counted cold diagnostic in the same prospective protocol ran 30
fresh processes (15 pairs), one first U+754C lookup each. Median thread CPU:
control **116,047 ns**, candidate **1,994 ns**; candidate lower in all 15 pairs.
This times only the lookup including timer overhead, **not terminal startup**.
Minor-fault deltas were 4 vs 3 median, but control ranged 4–276; max-RSS high-water
deltas were zero in every process, **not evidence of lower retained RSS**. Test
executable BSS grew by 1,115,456 bytes net; that is section size, not resident use.
All samples remain; cold improvement does not override the failed warm gate.

The new read-only cold replay rejects incomplete/overlapping launches, zero-test
receipts, duplicate markers/keys, changed binaries and invalid metrics. The exact
candidate passes 382 terminal tests; restored runtime passes 381; both match
12,800 differential streams. 57 Python tests and 23 real-report corruption cases
pass. All 120 Rust sources, 5,938 prior tracked artifacts and selected terminal
executable are unchanged. No new Ghostty timing or every-metric superiority.

```sh
python3 -B bench/results/2026-11-03-static-width-cache/verify.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-static-width-cache/frozen-index.json
```


### Authoritative parser ground: real targets gained, truecolor guard failed

A distinct 11-pair engine screen removes the shadow `Mirror` and gates runs
and simple CSI on VTE's actual ground, partial-UTF8 and pending-sync state.
Candidate/control median CPU-throughput: ASCII **1.064495** (11/11 wins),
scroll-region **1.068099** (11/11), but truecolor **0.922042** (0/11). Both
targets clear six-workload Holm p=.005859; the .98 truecolor guard fails.
Runtime is rejected/restored; no new PTY/Ghostty timing follows. This is
best-of-five in-process work, not terminal speed; AB/BA signs need not be
independent, and changed parser handoff means cost is not isolated.

Retain 1,092 read-boundary scenarios; a built mutant omitting partial-UTF8
state fails with actual cell mismatch. Both correct arms pass 382 terminal
tests and 12,800 differential streams. A stale-build incident was caught
before timing: `copy2` restored old source mtimes and Cargo returned the mutant
as control (equal SHA256). Fresh corrected builds pass; initial receipts remain.
`bench/build-engine-arm.py` now requires non-fresh affected-package receipts
and atomically publishes without clobbering. 65 Python tests and 17 report/build
corruption challenges pass. Selected executable, 119 other crate Rust sources
and 5,994 prior tracked artifacts are preserved. No every-metric win claimed.

```sh
python3 -B bench/results/2026-11-03-parser-authority/verify.py
```


**Parser-authority replay correction:** the initial checkpoint command compares
one set-order-dependent stale-build diagnostic byte-for-byte and is intermittent.
Use the supplemental command below instead. It permits only one of three known
first-stale-package reasons for that one actual incident; all other evidence
and rejection fields remain exact. Original verifier/results/reports are frozen
unchanged. Six supplemental normalization tests cover the narrow correction.
No runtime selection or performance conclusion changes.

```sh
python3 -B bench/results/2026-11-03-parser-authority-replay/verify.py
```
