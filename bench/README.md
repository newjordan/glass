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
| `pgo-train.py` | Seeded mixed terminal sessions for optional PGO research, separate from the scored `tput.py` payload. Writes a training receipt, not a score. See `results/2026-11-02-pgo/README.md`; no default release flags use its profile. |
| `pty-rtt.py` | Quiet DA1 round trips through the real PTY; stores all samples and validates replies. A reader latency guard, **not** a key-to-screen measurement. See `results/2026-11-02-ppoll/README.md`. |
| `run-startup.sh` | Launches each terminal in turn and times (a) launch until the program inside is running (it writes the time) and (b) launch until the window is on screen (Hyprland's `openwindow` event, sent when the window's first buffer arrives). Prints every launch and the medians. |
| `run-misc.sh` | For each terminal: eight quick startups (a); an idle window's memory, threads, VRAM (`nvidia-smi`) and CPU over 10 s; and key latency, 40 keys sent through Hyprland until `keys.py` reads them. |
| `keys.py` | Runs inside the terminal: logs the time of every key it reads, until `q`. |
| `keys-latency.sh` | Key to pty for one terminal (`TERMINAL`, glass by default, any `term_cmd` knows): a window on the headless output `CAP` (which must exist), `N` keys sent through Hyprland, `keys.py` logging each read; `LOAD=yes` floods the pty with `yes` for the window's whole life, since a lock held through a flood only shows then. Prints the median and p90. |
| `keys-ab.sh` | `keys-latency.sh` for two builds (`GLASS`, `GLASS_ALT`), taking turns for `ROUNDS`. |
| `keys-screen.sh` | Key to screen: the program paints the screen red on each key, and `visible/viscap.c` watches a patch of the headless output (240 Hz) for it. |
| `vis-grid.sh` | Prints the mean colour of a grid of patches of the headless output, to find where a colour lands when `keys-screen.sh` sees nothing. |
| `summarize.py` | Medians over the rounds of `run-tput.sh`'s results: MB/s per workload, TUI frames a second, CPU over all six. |
| `run-visible.sh` | Launch until the program's first output is on screen. The program paints the whole screen magenta first thing; `visible/viscap.c`, a wlr-screencopy client, watches a patch of the headless output (240 Hz) frame by frame for it. The same launches give (a) program running, (b) `openwindow`, and (w) the window first showing at all. `visible/calclient.c` calibrates the capture with a client whose frames' times are known, and every captured launch is paired with one uncaptured, to see what capturing costs. `visible/analyze.py` turns a session into JSON. Builds its helpers with `cc` and `wayland-scanner`. |
| `take-mindseye.sh` | Records the mind's eye film: glass films itself (`GLASS_RECORD`) while the `glass_mindseye` example runs in it, full-screen on a headless output. |
| `lib.sh` | Shared: the headless output, launching, and the terminals the harness knows (`term_cmd`). |
| `scoreboard-20261028.json` | The published Linux numbers, with every round and launch behind them. |
| `scoreboard-20261027b.json` | The first published numbers (2026-10-27). The film's board reads it. |
| `results/2026-10-28-linux/` | The raw files behind the published Linux numbers; see its README. |
| `results/2026-10-27/` | The raw files behind the first published numbers; see its README. |
| `macos/run-tput.sh` | macOS: `tput.py` in glass and Ghostty, taking turns, a round each; `macos/in-term.sh` runs it inside each, and `macos/ghostty.conf` gives Ghostty glass's grid and font size. |
| `macos/run-startup.sh` | macOS: launch to window on screen (the window list) and to program running (`macos/stamp.c` writes the clock), glass and Ghostty taking turns. It builds `macos/launch.swift` and `macos/stamp.c` with the Xcode tools. |
| `results/2026-10-28-macos/` | The Mac runs behind docs/PERFORMANCE.md's macOS section; see its README. |
| `results/2026-10-28-keys/` | Key to pty for glass and kitty, idle and under a flood (`keys-latency.sh`); see its README. |
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

### Balanced real-terminal gate

`compare-tput.py` drives the unchanged `run-tput.sh` through all six launch
permutations of candidate, control and Ghostty (repeat three times = 18 rounds):

```sh
GLASS=/absolute/candidate GLASS_ALT=/absolute/control \
  python3 bench/compare-tput.py bench/results/my-gate --rounds 18
```

It clears `GLASS_*` flags inherited by the runner and requires a fresh output folder.
Hyprland executes terminal commands using its server environment, so also check
that the compositor itself has no experimental `GLASS_*` flags. The runner
retains launch orders, logs, binary and harness hashes and every raw JSON hash,
and rejects missing/invalid rates, mismatched workloads/bytes/sample counts or
mixed geometry. A run stays `complete: false` until all launches and provenance
checks pass. `--summarize-only` checks the recorded orders and exact binaries
before rebuilding the summary. Ratios are paired within rounds; sign tests are
exploratory, uncorrected for multiple comparisons. Shared-machine outliers remain
in the record. This is throughput evidence, not a universal championship test.

For quiet DA1 RTT (not key-to-screen latency), use:

```sh
GLASS=/absolute/candidate GLASS_ALT=/absolute/control \
  OUT=bench/results/my-rtt ROUNDS=6 N=300 bash bench/run-pty-rtt.sh
```

This alternates AB/BA, retains every sample and binary hash, restores the terminal
through `pty-rtt.py`, and reports both run medians and pooled tails. Sessions,
not the correlated samples within them, are the independent replication unit.
Do not run throughput, RTT and CPU-heavy builds/tests concurrently.

### Paired engine diagnostics

`engine-pairs.py` compares two **test executables**, not terminal binaries.
Build each source revision with the same flags, using
`cargo test --release -p glass-term --locked --no-run`, and copy the executable
reported by Cargo before building the other revision. Then run:

```sh
python3 bench/engine-pairs.py /path/to/base-test /path/to/candidate-test \
  --pairs 11 --scale 2 --rounds 5 --out /path/to/engine-pairs.json
```

The runner alternates AB/BA order, clears inherited `GLASS_*` probes, retains
binary hashes and complete output, and rejects failed runs, missing workloads,
nonpositive rates, or mismatched byte/read counts. It reports median paired
CPU-throughput ratios and exact two-sided sign tests (exploratory, not corrected
for multiple comparisons). Engine results do **not** replace the real-window,
through-pty gate: rotate terminal order, check geometry, retain every round,
and compare paired ratios rather than dividing unrelated medians.
The [SSE2 scan report](results/2026-11-02-sse-scan/README.md) is an example
with complete engine pairs, a balanced terminal gate, and rejected candidates.
The [single-mark sharing report](results/2026-11-02-mark-cache/README.md)
adds a bounded allocation-reuse gain (+3.42% Unicode, 15/15 final-build pairs;
an earlier binary was +2.34%, also 15/15)
and records four more rejected implementation candidates. Three Ghostty
throughput leads remain; ASCII, Unicode and scroll-region still do not pass.

## Add another terminal

`term_cmd` in `lib.sh` knows glass, kitty, foot, Alacritty, Ghostty and
WezTerm. To add another, add a line to it. It gets a name, a window class
and a command, and must print the command line that opens the terminal with
that class (its Wayland app id) running the command as its child, closing
when the command exits. For example, for foot:

```sh
    foot) echo "foot --app-id $class $*" ;;
```

Then `TERMS="glass foot" ROUNDS="1 2 3 4 5" bench/run-tput.sh`, and the same
`TERMS` for the other scripts.

The classes have a dot in them (`bench.foot`), since Ghostty takes its class
as a GTK application id and ignores one without a dot.

Check the grid first: every `tput-*.json` records it, and terminals are
compared only at the same one. With the same font and padding, foot,
Alacritty, Ghostty and WezTerm come out a column or a row larger than glass
and kitty (154×39 on a 1920×1080 output), so their lines in `term_cmd` widen
the padding by a few pixels to match. `linux/wezterm.lua` gives WezTerm,
which has no configuration on the measured machine, the font, size and
padding the others have, and no tab bar.

foot, Alacritty and WezTerm start the program at 80×24 and resize once the
window is tiled, so `tput.py` waits for a size that holds for a second
before it builds the workloads, and `run-visible.sh`'s program paints its
marker again on `SIGWINCH`.

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
written into it. The published medians are glass 46.1 ms and kitty 185 ms
(`results/2026-10-28-linux/visible.json`; see
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

### Producer placement diagnostic (Linux)

Do not pin a producer and publish the result as default terminal performance.
On multi-domain CPUs, the child writing the PTY can materially change end-to-end
throughput even when the terminal binary, parser policy and payload are fixed.
The separate diagnostic below restricts **only the child**, uses unchanged
`tput.py`, and records both child and terminal-thread allowed CPU masks. It
cycles all six treatment orders; run terminals sequentially, not concurrently.
Choose masks from the actual machine topology, not these example CPU numbers:

```sh
OUT=bench/results/new-placement-glass TERM_NAME=glass GLASS=/path/to/frozen/glass \
  ROUNDS=12 LARGE_CPUS=0-7,16-23 SMALL_CPUS=8-15,24-31 \
  bash bench/linux/run-producer-placement.sh
OUT=bench/results/new-placement-ghostty TERM_NAME=ghostty \
  ROUNDS=12 LARGE_CPUS=0-7,16-23 SMALL_CPUS=8-15,24-31 \
  bash bench/linux/run-producer-placement.sh
```

Each new output directory contains the binary/harness hashes, topology, treatment
order, raw throughput, affinity sidecars and validated paired summary. Replay
with `python3 -I bench/linux/producer-placement.py summarize OUT 12`; the runner
also verifies its input hashes after completing the run. An allowed CPU mask is
**not** a sample of the CPU actually used. This experiment cannot separate cache
locality, inter-domain communication, clock speed and scheduler effects, nor
explain every historical outlier. Its sign tests are exploratory and uncorrected.
The default gate is still `compare-tput.py`, without this wrapper. See
[the diagnostic report](results/2026-11-02-producer-placement/README.md) for actual
observations and the rejected parser/reader alternatives from the same iteration.

### Parser-free transport controls (Linux)

`linux/transport-control.py` is a **diagnostic**, not a terminal ranking. It
extracts the existing `tput.py` payload builder and compares fixed-size writes
to null/pipe/raw-PTY sinks under randomized producer CPU placement. A minimal
C sink validates byte totals; explicit reader placement permits reciprocal
controls. Use the machine's actual topology, not these example masks:

```sh
cc -O3 -Wall -Wextra -Werror -o /tmp/glass-transport-sink linux/transport-sink.c
python3 -I linux/transport-control.py run results/new-transport \
  --sink /tmp/glass-transport-sink --large 0-7,16-23 --small 8-15,24-31 \
  --blocks 12 --repeats 8 --seed 179365
# Add --sink-cpus 8-15,24-31 for the reciprocal reader-domain control.
python3 -I linux/transport-control.py summarize results/new-transport
```

Run from `bench/`, without concurrent benchmarks/builds. Each run requires a
fresh output directory and retains treatment order, actual masks, workload and
input hashes, byte counts and every trial. Disabled scheduler runqueue accounting
is reported as unavailable, not zero wait. Preserve both the sink and script used
for durable replay. The default terminal gate remains unchanged; do not pin the
producer or comparator to manufacture an apparent win. See the
[972-trial transport-control report](results/2026-11-02-transport-control/README.md).

The interrupted bounded-channel gate was completed without overwriting its first
14 rounds; [the completion report](results/2026-11-02-handoff-completion/README.md)
explains the session break and rejects promotion. The isolated branchless-wide
edit [lost Unicode in all 11 engine pairs](results/2026-11-02-branchless-wide/README.md)
and was removed as well.

The raw-transport lead was followed into a reader-only small-L3 candidate.
[Its complete default terminal gate](results/2026-11-02-small-reader/README.md)
rejected the policy: .6852 ASCII and .6623 region, each 17/18 losses. The reader
and parser retain the original placement, and the selected executable is restored.
Do not turn this diagnostic into an affinity workaround or a championship claim.


### Scanner/decoder campaign closure

[`results/2026-11-02-sse2-unroll/`](results/2026-11-02-sse2-unroll/README.md)
contains the full 18-round, six-order candidate/control/Ghostty gate and its
hash-checked replay. The small engine gain did not transfer; no runtime change
was kept. Adjacent `decode-memo`, `avx2-scan` and `validated-scalar` reports retain
three other measured candidates, limitations, and exact source/binary provenance.
Three new correctness tests remain: SIMD boundary/high-bit masks, a Linux
PROT_NONE guard-page slice end, and exhaustive valid-scalar/truncation/boundary
UTF-8 checks. Read the reports before retrying those experiments.


### CRLF/coalesced-scroll and code-generation ablation (2026-11-02)

[Bulk CRLF report](results/2026-11-02-bulk-lines/README.md) and
[one-line feed-outline ablation](results/2026-11-02-feed-outline/README.md):
engine ASCII/region gains did not transfer to the full terminal. A persistent
truecolor gain survived removing all batching, but outlining risked ASCII and
was rejected too. Both 18-round, six-order gates and hash replays completed:
108 terminal sessions total. The reports distinguish frozen historical-control
and fresh rebuilt-control binaries; do not mix their identities. Runtime source
and selected executable restored, two test-only CRLF/history regressions retained.
No benchmark workload or competitor placement changed and no title is claimed.


### Session-overhead ablations (2026-11-02)

Independent gates tested [one opportunistic consumer hand-off](results/2026-11-02-consumer-coalesce/README.md),
[lazy frame-boundary cuts](results/2026-11-02-lazy-frame-cuts/README.md), and
[stack-backed splitter pieces](results/2026-11-02-inline-pieces/README.md).
All three completed 18 rounds / six launch orders and hash replay: 162 terminal
sessions total. None established a dependable joint weak-metric win without
tradeoffs, and no runtime change remains. Queue byte/credit and synchronized
frame-boundary regression tests remain; final relevant gate was 7/7 passing.
Raw control throughput also showed severe session variation, so do not promote
an allocation hypothesis from favorable medians. Separate coalescing DA1 RTT
was inconclusive. Exact selected executable restored, not the fresh-control
artifact. Reports retain source snapshots, patches, binary identities and raw
hashes; no all-metric or world-champion claim is supported.


### Matched-input pipeline diagnosis (2026-11-02)

Before more speculative hot-loop tuning, the exact selected executable was
profiled in 12 balanced plain/boundary-only/sampled rounds (36 sessions), with
all 432 instrumented passes retained. Unicode parser CPU/wall was .9859;
ASCII .5313 and scroll region .5230, with much more reader CPU/handoff work.
A slow Unicode pass spent 131.1 ms on parser CPU over 133.9 ms wall: a plain
scheduler-wait explanation does not fit that reproduced excursion.

Six leaf-IP profile sessions localized 435/547 Unicode parser samples to
`print_utf8`. Three reader call-label sessions found most delivered ASCII and
region samples inside `read`, not `poll`. The CPU timer was coarse (~1-2 ms
observed despite 100 us requested), heavily coalesced, and these are not
kernel stacks or precise CPU percentages. Profiling changes pacing; neither
profiled arm belongs on the scoreboard. A distinct row-writer outlining
candidate passed existing parser equivalence but failed its Unicode engine
gate and was removed. No runtime or executable replacement.

[Complete method, limitations, raw receipts and reproduction](results/2026-11-02-pipeline-profile/README.md).
New opt-in tools: `linux/run-pipeline-profile.sh`, `pipeline-profile.py`,
`analyze-pipeline.py`, `cpu-sample.c`, `run-cpu-sample.sh`, and
`symbolize-cpu-sample.py`. All summaries have exact-hash replay. No PMU or
full scheduler-event trace was available; no all-metric Ghostty win is claimed.


### UTF-8 continuation, ASCII islands and word decoding (2026-11-02)

Three new, ship-semantics candidates passed existing parser equivalence but
were rejected. Eleven balanced engine pairs: reusing failed row continuations
lost 1.76% Unicode (2 wins); byte-proven eight-byte ASCII islands lost 11.01%
(0 wins); four-byte masked validation initially gained 1.16% (7 wins), then
replicated at **-0.48% (5/15)** after identical test additions and rebuilds.
Neither engine gains nor instruction samples are terminal rankings.
No runtime promotion, competitor/RTT gate or championship claim.

Kept: decoder guard-page tails and exhaustive padded offsets (short encodings
otherwise miss a four-byte decoder fast path). Final selected-source targeted
Rust gate: four decoder tests + parser differential, **5 passed, 0 failed**.
The historical selected release executable is byte-identically restored.

- [Continuation and exact terminal-payload ASCII coverage](results/2026-11-02-row-continuation/README.md)
- [Byte-proven ASCII islands](results/2026-11-02-ascii-islands/README.md)
- [Masked-word decode, replication, instruction evidence and restoration](results/2026-11-02-word-decode/README.md)

Read-only independent arithmetic/provenance replay (no benchmark rerun):

```
python3 -I bench/replay-engine-pairs.py --pairs 11 \
  bench/results/2026-11-02-row-continuation/engine-pairs.json \
  bench/results/2026-11-02-ascii-islands/engine-pairs.json \
  bench/results/2026-11-02-word-decode/engine-pairs.json
python3 -I bench/replay-engine-pairs.py --pairs 15 \
  bench/results/2026-11-02-word-decode/engine-replication.json
python3 -I bench/test_replay_engine_pairs.py -v
```

Use `--verify-binaries` while the frozen `/tmp` executables are still present.
Rejects missing/duplicate rows or JSON keys, nonzero exits, changed byte/read
shape, order errors, and summary/raw-output disagreement. This validates
internal consistency, not timing accuracy. Five validator mutation tests pass;
those synthetic fixtures are explicitly not research measurements.
