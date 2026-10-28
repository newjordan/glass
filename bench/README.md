# bench

The harness behind every number in the [README](../README.md) and
[docs/PERFORMANCE.md](../docs/PERFORMANCE.md), and the results it gave.
Only glass and kitty 0.49.2 have been measured so far. Adding another
terminal is one line (below); please send the numbers whatever they say.

## What each file does

| File | What it measures or does |
| --- | --- |
| `tput.py` | Runs inside the terminal under test. Writes six workloads through the pty and times each until the terminal answers a DA1 query (`CSI c`), so the clock stops only when every byte has been parsed, as vtebench does. Each workload is written three times and the fastest is kept, with the terminal's own CPU time over it. Writes one JSON file. |
| `run-tput.sh` | Opens `tput.py` in each terminal in turn, full-screen on a headless output, for each round. |
| `run-startup.sh` | Launches each terminal in turn and times (a) launch until the program inside is running (it writes the time) and (b) launch until the window is on screen (Hyprland's `openwindow` event, sent when the window's first buffer arrives). Prints every launch and the medians. |
| `run-misc.sh` | For each terminal: eight quick startups (a); an idle window's memory, threads, VRAM (`nvidia-smi`) and CPU over 10 s; and key latency, 40 keys sent through Hyprland until `keys.py` reads them. |
| `keys.py` | Runs inside the terminal: logs the time of every key it reads, until `q`. |
| `summarize.py` | Medians over the rounds of `run-tput.sh`'s results: MB/s per workload, TUI frames a second, CPU over all six. |
| `take-mindseye.sh` | Records the mind's eye film: glass films itself (`GLASS_RECORD`) while the `glass_mindseye` example runs in it, full-screen on a headless output. |
| `lib.sh` | Shared: the headless output, launching, and the terminals the harness knows (`term_cmd`). |
| `scoreboard-20261027b.json` | The published numbers, with every round and launch behind them. The film's board reads it. |
| `results/2026-10-27/` | The raw files behind the published numbers; see its README. |
| `results/local/` | Where your own runs go by default (ignored by git). |

TODO: a "time to visible prompt" measure (`run-visible.sh`: launch until the
program's first output is on screen, for every terminal) is being written
and is not in this directory yet. See docs/PERFORMANCE.md for what is known
about it so far.

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

## Record the film

```sh
cargo build --release -p glass-term --bin glass --example glass_mindseye
bench/take-mindseye.sh film.mp4 95            # the geometry
bench/take-mindseye.sh film.mp4 95 --surreal  # with the video cubes and figures (needs MINDSEYE_ASSETS)
```

The recorder uses NVENC (`hevc_nvenc`) by default; set
`GLASS_RECORD_CODEC=libx264` without it.
