# Performance

Every number glass publishes, how it was measured, and what to keep in mind
when reading it. The harness and the raw results are in [`bench/`](../bench/);
[bench/README.md](../bench/README.md) says how to run it on your machine.

## The numbers

Measured against **kitty 0.49.2**, the only other terminal measured so far,
on one machine: Ryzen 9 9950X3D, RTX 3090, Omarchy (Arch Linux), Hyprland,
a 154×39 window. Medians.

| Measure | glass | kitty 0.49.2 | |
| --- | --- | --- | --- |
| Program's first output on screen, from launch | **61.5 ms** | 206 ms | 3.4× |
| Window on screen, from launch | **31 ms** | 73 ms | 2.4× |
| Program running, from launch | **39.5 ms** | 193 ms | 4.9× |
| Plain ASCII through the pty | **497 MB/s** | 314 MB/s | 1.6× |
| Unicode | **179 MB/s** | 145 MB/s | 1.2× |
| Truecolor | **200 MB/s** | 82 MB/s | 2.4× |
| Cursor motion | **143 MB/s** | 78 MB/s | 1.8× |
| Scroll region | **451 MB/s** | 342 MB/s | 1.3× |
| Full-screen TUI frames | **2,673 fps** | 902 fps | 3.0× |
| CPU over all six workloads | **0.67 s** | 1.09 s | 1.6× less |
| VRAM, idle window | **45 MiB** | 50 MiB | 1.1× less |
| Key press to the program | **2.25 ms** | 2.43 ms | 1.1× |
| Key press to the program, while it floods output | **3.0 ms** | 38.6 ms | 13× |

![glass vs kitty, measure by measure](media/glass-advantage.png)

Every round and every launch behind these is in
[`bench/scoreboard-20261027b.json`](../bench/scoreboard-20261027b.json), and
the raw files are in [`bench/results/2026-10-27/`](../bench/results/2026-10-27/).

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

So 31 ms is when the window, with its real background, is on screen. That
is what Hyprland reports, and it is the same event for kitty. kitty's own
window is up at 73 ms, and its shell runs at 193 ms.

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
  - **glass: 61.5 ms;**
  - kitty: 206 ms.

  Every run, the calibration and the GPU load are in [`bench/results/2026-10-27/visible.json`](../bench/results/2026-10-27/visible.json).
- **How glass gets there.** The shell starts at about 40 ms, as soon as the compositor has settled the window's size, while the GPU is still opening. Its first output is drawn on the CPU in the window's early frame. Before that early text, glass's first output came with the GPU's first frame, at 172.7 ms.
- **kitty's config.** kitty read the author's config here. In an earlier session with `--config NONE`, kitty's first output came 18 ms sooner than with that config. Either way glass is about three times quicker.

`GLASS_STARTUP_TRACE=1` prints each step of glass's startup on stderr, with
milliseconds since `main`.

### Plain ASCII and the CPU's cache

On CPUs whose dies have last-level caches of different sizes (AMD's X3D
parts), glass keeps its pty read and parse threads on the die with the
largest one. Without that, plain ASCII swung between about 250 and 430
MB/s on this CPU, depending on where the scheduler put the thread.
`GLASS_AFFINITY=off` turns the placement off. On a CPU with one L3, or
several of one size, nothing is placed and nothing changes.

### Only kitty has been measured

alacritty, ghostty, foot and wezterm have not been run through the harness
yet. glass is ahead of kitty on every measure above; that is all these
numbers say. Adding a terminal to the harness is one line
([bench/README.md](../bench/README.md#add-another-terminal)).

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
| Plain ASCII | **363 MB/s** | 273 MB/s | 1.33× |
| Unicode | 240 MB/s | 235 MB/s | about even |
| Truecolor | **253 MB/s** | 218 MB/s | 1.16× |
| Cursor motion | **209 MB/s** | 187 MB/s | 1.12× |
| Scroll region | **351 MB/s** | 277 MB/s | 1.27× |
| Full-screen TUI | **2,891 fps** | 2,428 fps | 1.19× |
| CPU, six workloads | **0.84 s** | 1.37 s | |

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
close: Ghostty's rounds ranged from 213 to 304 MB/s, and glass's from 239 to
241.

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
