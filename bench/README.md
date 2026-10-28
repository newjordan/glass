# bench

The harness behind every number in the [README](../README.md) and
[docs/PERFORMANCE.md](../docs/PERFORMANCE.md), and the results it gave.
On Linux, glass and kitty 0.49.2 have been measured; on macOS, glass and
Ghostty 1.4.0 (`macos/`). Adding another terminal is one line (below);
please send the numbers whatever they say.

## What each file does

| File | What it measures or does |
| --- | --- |
| `tput.py` | Runs inside the terminal under test. Writes six workloads through the pty and times each until the terminal answers a DA1 query (`CSI c`), so the clock stops only when every byte has been parsed, as vtebench does. Each workload is written three times and the fastest is kept, with the terminal's own CPU time over it. Writes one JSON file. |
| `run-tput.sh` | Opens `tput.py` in each terminal in turn, full-screen on a headless output, for each round. |
| `run-startup.sh` | Launches each terminal in turn and times (a) launch until the program inside is running (it writes the time) and (b) launch until the window is on screen (Hyprland's `openwindow` event, sent when the window's first buffer arrives). Prints every launch and the medians. |
| `run-misc.sh` | For each terminal: eight quick startups (a); an idle window's memory, threads, VRAM (`nvidia-smi`) and CPU over 10 s; and key latency, 40 keys sent through Hyprland until `keys.py` reads them. |
| `keys.py` | Runs inside the terminal: logs the time of every key it reads, until `q`. |
| `keys-latency.sh` | Key to pty for one glass build: a window on the headless output `CAP` (which must exist), `N` keys sent through Hyprland, `keys.py` logging each read; `LOAD=yes` floods the pty with `yes` for the window's whole life, since a lock held through a flood only shows then. Prints the median and p90. |
| `keys-ab.sh` | `keys-latency.sh` for two builds (`GLASS`, `GLASS_ALT`), taking turns for `ROUNDS`. |
| `keys-screen.sh` | Key to screen: the program paints the screen red on each key, and `visible/viscap.c` watches a patch of the headless output (240 Hz) for it. |
| `vis-grid.sh` | Prints the mean colour of a grid of patches of the headless output, to find where a colour lands when `keys-screen.sh` sees nothing. |
| `summarize.py` | Medians over the rounds of `run-tput.sh`'s results: MB/s per workload, TUI frames a second, CPU over all six. |
| `run-visible.sh` | Launch until the program's first output is on screen. The program paints the whole screen magenta first thing; `visible/viscap.c`, a wlr-screencopy client, watches a patch of the headless output (240 Hz) frame by frame for it. The same launches give (a) program running, (b) `openwindow`, and (w) the window first showing at all. `visible/calclient.c` calibrates the capture with a client whose frames' times are known, and every captured launch is paired with one uncaptured, to see what capturing costs. `visible/analyze.py` turns a session into JSON. Builds its helpers with `cc` and `wayland-scanner`. |
| `take-mindseye.sh` | Records the mind's eye film: glass films itself (`GLASS_RECORD`) while the `glass_mindseye` example runs in it, full-screen on a headless output. |
| `lib.sh` | Shared: the headless output, launching, and the terminals the harness knows (`term_cmd`). |
| `scoreboard-20261027b.json` | The published numbers, with every round and launch behind them. The film's board reads it. |
| `results/2026-10-27/` | The raw files behind the published numbers; see its README. |
| `macos/run-tput.sh` | macOS: `tput.py` in glass and Ghostty, taking turns, a round each; `macos/in-term.sh` runs it inside each, and `macos/ghostty.conf` gives Ghostty glass's grid and font size. |
| `macos/run-startup.sh` | macOS: launch to window on screen (the window list) and to program running (`macos/stamp.c` writes the clock), glass and Ghostty taking turns. It builds `macos/launch.swift` and `macos/stamp.c` with the Xcode tools. |
| `results/2026-10-28-macos/` | The Mac runs behind docs/PERFORMANCE.md's macOS section; see its README. |
| `results/local/` | Where your own runs go by default (ignored by git). |

`run-visible.sh` and `visible/` measure launch until the program's first
output is on screen. The published result is in
`results/2026-10-27/visible.json`; see below.

### The six workloads (`tput.py`)

| Workload | Bytes | What it is |
| --- | --- | --- |
| `ascii` | 24 MiB | lines of random printable ASCII, a screen wide |
| `unicode` | 16 MiB | lines mixing CJK, emoji, accented letters, Greek, Cyrillic, arrows and box drawing with ASCII |
| `truecolor` | 24 MiB | every character with its own 24-bit foreground colour (`SGR 38;2`) |
| `cursor_motion` | 16 MiB | 50 jumps a chunk to random cells (`CUP`), each writing six coloured characters |
| `scroll_region` | 16 MiB | ASCII lines scrolling inside a margin (`DECSTBM`) from the second row to the third-last |
| `tui_frames` | 300 frames | full-screen frames on the alternate screen, every cell with its own 256-colour background |

The random generator is seeded (`random.Random(7)`), so every terminal gets
the same bytes for the same grid.

## Requirements

- **Hyprland.** Every launch goes through `hyprctl` onto a headless output
  made for the run, so each terminal gets the same full-screen tile and the
  same machine, and nothing opens on your monitors. The scripts use
  `hyprctl eval` with Hyprland's Lua dispatchers; they were run on Hyprland
  0.56.2. On another compositor, rewrite `headless_up`, `launch` and
  `run_windows` in `lib.sh`.
- `bash`, `python3`, `awk`, coreutils.
- `nvidia-smi` for the VRAM figure (NVIDIA only; it reads `n/a` elsewhere).
- The terminals. `GLASS`, `GLASS_ALT` and `KITTY` name the binaries
  (`glass` and `kitty` from `PATH` by default).
- A path to the repository without spaces: commands are handed to Hyprland
  as one line.

### How the headless output is handled

`lib.sh` makes the output (`CAP`, `GLASSCAP` by default), finds its
workspace, and opens every window there with `silent`, so focus never moves.
If the output cannot be found, the script stops before opening anything.
At the end it waits for every window on that workspace to close, closes any
that are left, and only then removes the output: a window still on an
output when it goes moves to a real monitor. Use a `CAP` name of your own if
another run may be using `GLASSCAP`.

## Reproduce the published numbers

On a quiet machine (no builds, no games, nothing else on the GPU):

```sh
cargo build --release -p glass-term
export GLASS=$PWD/target/release/glass

ROUNDS="1 2 3 4 5" bench/run-tput.sh         # throughput, CPU, TUI: 5 rounds, terminals taking turns
python3 -I bench/summarize.py                # the medians
RUNS=16 bench/run-startup.sh                 # window on screen and program running, 16 launches each
bench/run-misc.sh                            # idle VRAM and memory, key latency
```

`TERMS` picks the terminals and their order (`glass kitty` by default). Each
`tput-*.json` records the grid it ran at; compare terminals only at the same
grid. The published runs were all at 154×39.

What you get will differ from the published numbers: they come from one
machine (Ryzen 9 9950X3D, RTX 3090). Plain ASCII in particular depends on
the CPU's cache; see [docs/PERFORMANCE.md](../docs/PERFORMANCE.md).

## Add another terminal

Add a line to `term_cmd` in `lib.sh`. It gets a name, a window class and a
command, and must print the command line that opens the terminal with that
class (its Wayland app id) running the command as its child, closing when
the command exits. For example, for foot:

```sh
    foot) echo "foot --app-id $class $*" ;;
```

Then `TERMS="glass foot" ROUNDS="1 2 3 4 5" bench/run-tput.sh`, and the same
`TERMS` for the other scripts.

`tput.py` reads the terminal's CPU time from its parent process. A terminal
that starts commands through a helper process gets the helper's CPU time
instead; give `tput.py` the terminal's pid the way it reads kitty's
(`KITTY_PID`), or set `BENCH_TERM_PID`.

## Time to a visible prompt

```sh
RUNS=16 TERMS="glass kitty" bench/run-visible.sh
```

This is the measure for when the prompt really appears; "window on screen"
counts the window as soon as its first buffer arrives, before anything is
written into it. The published medians are glass 61.5 ms and kitty 206 ms
(`results/2026-10-27/visible.json`; see
[docs/PERFORMANCE.md](../docs/PERFORMANCE.md#when-the-prompt-appears)).
It needs `cc`, `wayland-scanner`, `wayland-protocols` and
`libwayland-client` to build its two helpers, and it adds one window rule
(for `bench-vis-*` windows: no open animation, full opacity) for the
length of the run. No result from it is published yet.

## Record the film

```sh
cargo build --release -p glass-term --bin glass --example glass_mindseye
bench/take-mindseye.sh film.mp4 95            # the geometry
bench/take-mindseye.sh film.mp4 95 --surreal  # with the video cubes and figures (needs MINDSEYE_ASSETS)
```

The recorder uses NVENC (`hevc_nvenc`) by default; set
`GLASS_RECORD_CODEC=libx264` without it.
