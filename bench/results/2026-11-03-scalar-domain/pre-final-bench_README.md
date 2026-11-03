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
input hashes, byte counts and every trial. The historical summarizer conservatively
reports runqueue accounting as unavailable when `sched_schedstats=0`; that sysctl
alone is not a capability test for `CONFIG_SCHED_INFO` run-delay counters. See the
new own-thread calibration below. No historical counter is silently reinterpreted.
Preserve both the sink and script used
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


### Row locality experiments (UTC 2026-11-03)

[Boxed rows](results/2026-11-03-boxed-rows/README.md) trade a +7.74%
scroll-region engine result for -5.20% Unicode: rejected. [Row cache-line
alignment](results/2026-11-03-row-alignment/README.md) replicates +2.93%
Unicode in the engine, but loses 1.53% in 16/18 real-PTY paired rounds:
also rejected. The 54-session terminal protocol is cyclic-balanced, not the
canonical full-permutation schedule. Three engine datasets and all terminal
raw files have replay receipts. Six paired quiet-RTT rounds are separate and
are explicitly not key-to-screen latency. The exact selected executable was
restored, with only a strengthened lazy-row/history rotation test retained.

```
python3 -I bench/replay-engine-pairs.py --pairs 11 \
  bench/results/2026-11-03-boxed-rows/engine-pairs.json \
  bench/results/2026-11-03-row-alignment/engine-pairs.json
python3 -I bench/replay-engine-pairs.py --pairs 17 \
  bench/results/2026-11-03-row-alignment/engine-replication.json
python3 -I bench/results/2026-11-03-row-alignment/summarize-terminal.py
```

The terminal replay verifies all 54 raw hashes and exact summary equality,
and verifies the recorded executable/harness hashes while they are present.
It deliberately does not relabel the observed cyclic orders as the standard
runner's permutation schedule. See the experiment's execution-error notes.


### Immutable-mark / width campaign (UTC 2026-11-03)

- [Region indexing](results/2026-11-03-region-index/README.md): rejected engine
  tradeoff; replicated +2.17% region but -2.68% ASCII. No PTY gate claimed.
- [Immutable widths](results/2026-11-03-immutable-width/README.md): replicated
  +12.19% truecolor through the PTY; not a six-workload win.
- [Static mark records](results/2026-11-03-static-marks/README.md): replicated
  +28.46% Unicode over fresh control, +22.24% over Ghostty; small truecolor
  tradeoff and unresolved ASCII/region. Not selected alone.
- [Combined source](results/2026-11-03-marks-width/README.md): 18 then 30 full-
  permutation rounds, with separate exact-source correctness and response guards.
  Replication establishes four Ghostty throughput leads, not six. No runtime
  promotion; exact starting sources and selected release executable restored.

The canonical terminal runner stores raw unadjusted sign p-values. A separate
Holm report defines six-workload families per candidate/series/comparator;
series and candidates are not pooled and this is not campaign-wide correction.
No timing samples were removed for visible unrelated shared-host CPU load.

`run-pty-rtt.sh` now records actual AB/BA launch order and binary/harness hashes,
then calls the standalone `summarize-pty-rtt.py`. The checker rejects incomplete
sessions, changed raw summaries, altered provenance and replay mismatch. Earlier
RTT datasets remain unchanged under their original schema. These are quiet DA1
response times, **not key-to-screen latency**. Ten synthetic checker tests are
retained separately from measured responses.

```
python3 -I bench/test_summarize_pty_rtt.py
python3 -I bench/summarize-pty-rtt.py \
  bench/results/2026-11-03-marks-width/quiet-rtt
python3 -I bench/results/2026-11-03-marks-width/verify-evidence.py
```

The explicit evidence manifest covers this iteration's four result directories,
raw files, source snapshots and receipts; its verifier does not discover fallback
sources. Individual timing replays additionally require their recorded temporary
executables and unchanged harness. Integrity replay is not a timing-accuracy proof.


### Read-only real-terminal report replay and raw-read result

`compare-tput.py --summarize-only` regenerates summaries; it is **not** a
read-only validator of stored comparison fields. Use the independent checker
when validating frozen `glass.terminal-pairs/v1` reports:

```
python3 -I bench/test_replay_terminal_pairs.py
python3 -I bench/replay-terminal-pairs.py \
  bench/results/2026-11-03-raw-read/gate --verify-binaries
```

Omit `--verify-binaries` only for explicit artifact-only replay after temporary
executables are gone. Runner/harness and raw/result checks still apply. Nothing
is rewritten; unsupported schemas, summary changes, incomplete sets, geometry,
byte-count, numeric, rounded rate/time/FPS inconsistencies and provenance changes
are rejected. The checker does not authenticate clocks or actual window display.

`bench/results/2026-11-03-raw-read/README.md` preserves a disposable-copy
corruption demonstration (old summarizer repairs, new checker rejects), 11 new
synthetic tests and read-only replay of 630 supported terminal sessions. The
raw-read candidate itself was rejected after 54 balanced sessions; it did not
clear ASCII or scroll-region gates. Three new reader regression tests survive;
the raw-syscall runtime change does not. Earlier reports remain unchanged.

### Reader call-shape diagnosis (2026-11-03)

`bench/results/2026-11-03-read-shape/README.md` preserves 12 balanced rounds of
plain/count/timed captures using the unchanged selected executable and the
boundary-only producer wrapper. The opt-in own-process LD_PRELOAD observer
records libc `read`/`poll` calls only on `pty-read`, not application buffers or
general kernel syscalls. It is a diagnostic, not a performance optimization.

```
gcc -shared -fPIC -O2 -std=c11 -Wall -Wextra -Werror \
  -o /tmp/glass-read-shape.so bench/linux/read-shape.c -ldl -pthread
OUT=/tmp/glass-read-shape-fresh GLASS=/absolute/frozen/glass \
OBSERVER=/tmp/glass-read-shape.so ROUNDS=12 \
  bash bench/linux/run-read-shape.sh
python3 -B -I bench/linux/analyze-read-shape.py \
  bench/results/2026-11-03-read-shape/balanced \
  --check bench/results/2026-11-03-read-shape/balanced-analysis.json
```

Reads reached 16 KiB; 4 KiB is not a Linux read-size ceiling. Captured large
reads carried about 70% of ASCII/region bytes. Wall/CPU attribution excludes
boundary-straddling calls and is inclusive wrapper/glibc/kernel time, not pure
kernel cost. Instrumentation and shared-host timing effects are substantial;
non-significant paired comparisons are not evidence of equivalence. All 648
balanced pass profiles and raw hashes replay, and five disposable-copy
corruptions are rejected without rewriting evidence. Full replay requires the
recorded binary/harness hashes; explicit artifact integrity has a separate
frozen verifier. The spare-capacity follow-up has its own uninstrumented gate.


### Sparse own-reader scheduler accounting (Linux diagnostic)

The `sched-shape` observer targets only the exact requested Glass executable's
self-named `pty-read` thread. Every 128 completed reads it brackets its own
schedstat snapshot with wall and thread-CPU clocks. It records no payload bytes.
This separates measured runnable-wait accounting from residual off-CPU time;
it does not identify kernel functions or pure blocking. Calibrate on each
kernel: `sched_schedstats=0` alone is not a capability test for sched_info.

Build/run/replay commands and the full 36-session balanced results are in the
[scheduler diagnostic report](results/2026-11-03-scheduler-shape/README.md).
`linux/analyze-sched-shape.py` is read-only and fails closed on altered hashes,
ABI/length/drop/continuity errors, changed payloads, times, reader identities or
rates. Historical observer-source snapshots are explicit and hash checked; no
binary or raw-artifact snapshot substitution is allowed. The original observer
source/DSO and separately hardened safe-smoke capture remain distinct.
Run `python3 -B -m unittest discover -s bench -p 'test_*.py' -v` from repo root.
No fast-sample selection, performance neutrality, promotion or championship is
implied by this diagnostic.

### Bounded own-reader contention (Linux, diagnostic only)

The scheduler follow-up crosses an own sleep/busy helper with plain/clock/
scheduler observers in a predeclared 12-round six-arm balanced order. It pins
only the own `pty-read` TID and helper, preserves recorded producer/non-reader
masks, and restores the original reader mask before exit. No global scheduling
setting or priority is changed. Artificial restriction is not shipping policy.

See [protocol, results and limitations](results/2026-11-03-reader-contention/README.md).
The runner requires fresh `OUT`, exact `GLASS`, `OBSERVER`, `HELPER`, and
`PROTOCOL` paths, and uses the ordinary headless-output helper. Build only the
own helper with `cc -O2 -Wall -Wextra -Werror -std=c11
bench/linux/reader-contender.c -o /chosen/path/reader-contender`; no terminal
rebuild is necessary. Do not run concurrent headless benchmark campaigns.

Read-only replay (does not launch terminals or repair evidence):

```sh
python3 -B bench/linux/analyze-reader-contention.py \
  bench/results/2026-11-03-reader-contention/balanced
python3 -B bench/results/2026-11-03-reader-contention/check-corruption.py
```

Replay verifies complete arm order/source/raw hashes, unchanged payloads and
rates, identities/masks on all passes, trace/window integrity, and helper/reader
cleanup. The exact capture wrapper snapshot is explicit and hash matched.
Catchable termination restores affinity and reaps helpers; SIGKILL cannot run
Python cleanup, so the owning caller must terminate its terminal/process group.
This is diagnostic sensitivity evidence, not an observer-free throughput gate,
competitor ranking, runtime promotion, or world-championship acceptance.


### Reciprocal same-L3 reader/parser placement

`linux/hot-placement.py` changes only the two own-parent hot-role masks around
unchanged `tput.py`. `linux/run-hot-placement.sh` serializes five role-balanced
arms (shipping auto, two sibling pairs, two reciprocal distinct-core pairs)
and records exact source/binary/protocol/raw hashes. No sampler, per-pass hook,
producer pin or runtime build. CPU topology and named thread identities are
verified; masks restored independently on failure. This is an artificial
placement experiment with boundary observations, not an ordinary terminal score.

[Iteration 18](results/2026-11-03-hot-placement/README.md) retains the five-session
pilot, a strictly rejected initial 100 sessions, two new 100-session v2 series,
all protocol revisions, raw sidecars, observed non-target GPU-init changes,
source snapshots, four real two-role cleanup fault cases, and 13 non-mutating
corruption rejections plus a reportable-transition positive control. Initial
strict rejection remains reproducible, not repaired or reclassified. No series
pooling or default affinity promotion. Secondary ASCII placement lead merits
controlled validation; primary significance is not uniformly replicated.

Read-only (no launch/build/repair; full commands in the package README):

```sh
python3 -B bench/linux/analyze-hot-placement.py \
  bench/results/2026-11-03-hot-placement/confirmatory \
  --expect bench/results/2026-11-03-hot-placement/confirmatory-replay.json
python3 -B bench/linux/analyze-hot-placement.py \
  bench/results/2026-11-03-hot-placement/replication \
  --expect bench/results/2026-11-03-hot-placement/replication-replay.json
python3 -B bench/results/2026-11-03-hot-placement/replay-initial-rejection.py
python3 -B bench/results/2026-11-03-hot-placement/check-corruption.py
```

Role/start_ticks, affinity/producer masks, topology, geometry, payload sizes,
rounded rates, exact hashes, restoration and actual monotonic capture order are
checked. Non-target transitions are explicit v2 observations, not silently
excluded or treated as failures. Snapshots do not prove continuous residency,
pass-level GPU-init overlap or unchanged masks between boundaries. Sign tests
condition on independent fair round signs, not guaranteed by deterministic
orders; separate six-workload secondary families do not rescue failed primary
analyses. Run-to-run stability, controlled load and full competitor/startup/
key-to-screen gates remain necessary. Do not rerun capture/fault harnesses into
frozen output directories. No new Ghostty sessions or world-title claim.


### Exclusive-column row lane and pending-wrap oracle (2026-11-03)

The [iteration-20 bundle](results/2026-11-03-exclusive-column/README.md) freezes
11 fresh control/candidate engine pairs and rejects an internal cursor
representation rewrite. Unicode paired CPU-throughput is 0.979261, 3/11 wins:
not the prospective >=1.02 target; no full terminal candidate gate was run.
Only the new parser-differential boundary regression remains. A built mutation
that loses pending wrap fails that test semantically; source is restored.

```sh
D=bench/results/2026-11-03-exclusive-column
python3 -B "$D/verify.py"
python3 -B "$D/analyze.py"
python3 -B "$D/check-corruption.py"
python3 -B bench/replay-evidence-index.py "$D/prior-frozen-index.json"
python3 -B bench/replay-evidence-index.py "$D/frozen-index.json"
cargo test --release -p glass-term --locked speed::unicode_row_edges_preserve_pending_wrap -- --exact --nocapture
```

Replay requires the exact retained test executables and checks their hashes;
correctness re-execution is not a timing rerun. Nine corruptions reject. The
new prior index binds the old `speed.rs` hash to an exact pre-edit snapshot;
it does not edit or weaken old manifests. No new competitive/runtime gain.


### Row-scoped width-cache handle (iteration 21, rejected)

A [frozen 11-pair screen](results/2026-11-03-width-handle/README.md) moved the
existing atomic width-cache handle lookup outside the per-glyph row loop.
Unicode CPU-rate ratio **1.009280**, **9/11 wins**, six-workload Holm **p=.261719**
failed the predeclared >=1.02 / p<.05 screen. All six point ratios exceeded .98;
that is not equivalence evidence. No terminal follow-on, rescue series or new
Ghostty score. Runtime restored exactly; only a C1 differential test remains.

A separately declared post-screen cold diagnostic confirms an eager allocation
hazard: in six fresh instrumented test processes, C1-only input initializes the
candidate cache but not the control; ASCII initializes neither and wide Unicode
initializes both. The 1,114,112-byte cache payload is deduced from representation,
not an RSS or latency measurement. Instrumentation was restored, not shipped.

Retained C1 coverage spans all 32 scalars and 2,688 mode/size/read-cut scenarios;
a built C1-to-`?` decoder mutant fails on actual cells. Restored source passes
381 terminal tests, 12,800 existing differential sweep streams and 49 Python
tests; nine report corruption cases reject. All 5,869 prior result/report files,
119 unchanged Rust files and selected executable are preserved. The 120th Rust
file changes only test code. Historical evidence uses explicit retained source
mappings; no old manifest was rewritten.

```sh
python3 -B bench/results/2026-11-03-width-handle/verify.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-width-handle/frozen-index.json
```

Read-only checkpoint needs hashed retained `/tmp` test executables; byte replay
does not. Missing evidence fails closed. This is evidence closure, not acceptance
of the every-metric objective. [Full iteration report](../reports/research-1eecf9876bb302e9da10ff629e71e6d8-21.txt).

### Static zero-initialized width cache: cold gain, warm rejection (iteration 22)

The [frozen cache-representation experiment](results/2026-11-03-static-width-cache/README.md)
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


### Authoritative parser-ground research and fresh arm builds

`results/2026-11-03-parser-authority/` retains a frozen 11-pair screen with
ASCII/scroll-region CPU gains (1.064495/1.068099) but a truecolor regression
(.922042). Failed guard: **no runtime promotion or new Ghostty run**. Both
correct arms pass 382 tests, 12,800 streams and 1,092 boundary scenarios;
a real partial-UTF8 mutant fails on cells. Read-only checkpoint:

```sh
python3 -B bench/results/2026-11-03-parser-authority/verify.py
```

**Do not restore arm sources with old mtimes and trust Cargo's executable row.**
A reproduced `copy2` restore yielded the prior mutant executable as control;
corrected builds happened before all timing. The retained build helper touches
explicit Rust inputs without changing bytes, requires non-fresh VTE, terminal
library and Glass release-test receipts, hashes sources and binary, and stages
then atomically publishes without clobbering. Caller must exclusively own source
edits and Cargo target. Not a sandbox or cryptographic source attestation.

```sh
python3 -B bench/build-engine-arm.py --out /tmp/glass-new-arm-test \
  --receipt-dir bench/results/NEW-RUN/build-new-arm
```

Both output path and receipt directory must be new. Do not reuse historical
names or overwrite earlier evidence. 65 Python tests, including failed-copy
cleanup/no-clobber checks, and 17 actual-report corruption challenges pass.


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


### Known-ground simple-CSI handoff follow-up (2026-11-03, iteration 24)

The separately frozen follow-up keeps the authoritative parser route but carries
known ground across successful simple-CSI/ASCII handoffs, clearing the local fact
on every nonempty parser advance. Its 11 fresh engine pairs still fail the guard:
ASCII CPU ratio 1.068749, scroll-region 1.068974, truecolor .927055 (0/11 wins).
Reject and restore runtime; no PTY escalation, new Ghostty observations or runtime
promotion. Do not compare two rejected variants by subtracting their separate
ratios or claim this establishes the instruction-level cause.

Retain 2,160 boundary scenarios; a built stale-ground mutant fails on actual
cells after a split UTF8 lead byte. Control/candidate/restored each pass 383 tests
and 12,800 streams; 65 Python tests and 22 corruption challenges pass. Selected
terminal executable, 119 runtime Rust files and all 6,100 prior tracked artifacts
are unchanged. Original earlier checkpointers are frozen; their source identity
predates the new regression. Use this exact-state read-only checkpoint now:

```sh
python3 -B bench/results/2026-11-03-authority-handoff/verify.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-authority-handoff/frozen-index.json
```

Full sources, frozen protocol, six-workload table, build identities, limits and
remaining competitive gaps: `bench/results/2026-11-03-authority-handoff/README.md`
and `reports/research-1eecf9876bb302e9da10ff629e71e6d8-24.txt`.

### Exact-binary instruction attribution (2026-11-03, iteration 25)

Diagnostic only, no runtime change or promotion. One excluded pilot and 24
frozen plain/profiled sessions reused the prior ground-handoff binaries.
Candidate/control truecolor CPU-rate ratios were 0.893/0.938/0.915. Exact
machine code exposes extra candidate CSI digit-loop index spill/reloads;
Engine::apply holds 42.73%/47.48% of control/candidate truecolor samples. This
is a testable codegen lead, not established causal cost. Unicode instead holds
73.80%/75.61% of samples in print_utf8 with hotspots in leading-byte dispatch,
not standalone width-table lookup. Requested 100us samples arrived around 1ms
and cover setup/all rounds. Three pairs and conditional shares establish no
significance, observer equivalence, future optimization or competitive win.
Selected executable, all 120 tracked Rust sources and 6,182 prior tracked
result/report files are unchanged. Raw evidence, instruction disassembly,
existing-ELF-reader cross-check and read-only `verify.py` are under
`bench/results/2026-11-03-instruction-attribution/`; full report:
`reports/research-1eecf9876bb302e9da10ff629e71e6d8-25.txt`.


### Scanner outlining factorial (2026-11-03, iteration 26)

One `simple` scanner inline attribute, 12 balanced four-arm blocks / 48 retained
in-process engine sessions. Authority-outlined/original-control median CPU-rate
ratios: ASCII **1.074813**, Unicode **0.975962**, truecolor **1.049426**, cursor
**1.060409**, scroll-region **1.059254**, TUI **1.078943**. Both target workloads
clear six-workload Holm p=.002930, but Unicode fails the prospective .98 point
guard. **Candidate rejected; production unchanged.** No PTY/Ghostty comparison.

Exact disassembly confirms the outlined decimal index remains in r9 with no
stack references in its selected 18-instruction loop. Outlining recovers 12.67%
truecolor within the authority parser but costs 3.11% on the original parser;
this supports code-generation sensitivity, not unique spill causality. Unicode's
generated stream has no CSI; setup commands precede timing. The moved print_utf8
routine retains 1,967 relocation-masked instructions / 8,524 bytes in all arms.
Caller/code-placement effects are open leads, not established explanations.

Both outlined arms and restored control pass 383 terminal tests and 12,800
existing differential streams each; 65 Python tests pass. Independent raw replay
and 23 corruption rejections retain the failed gate, not an optimization win.
All 120 crate Rust sources, 6,318 prior tracked reports/results and selected
executable are unchanged. Full report:
`reports/research-1eecf9876bb302e9da10ff629e71e6d8-26.txt`; evidence and replay:

```sh
python3 -B bench/results/2026-11-03-csi-outlining/verify.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-csi-outlining/frozen-index.json
```

### Decoded-lookahead handoff diagnostic (2026-11-03, iteration 27)

Reject a distinct Unicode candidate returning put_row's already-decoded
lookahead rather than decoding it again in print_utf8. Exactly 12 AB/BA engine
pairs give Unicode CPU ratio **.918109** (1/12 wins); no runtime promotion or
PTY/Ghostty escalation. A separate test-only census confirms **4.1341% fewer
UTF8 attempts** (2.0050% fewer non-ASCII attempts), with all instrumented rates
excluded. Fewer source-level calls do not imply faster execution.

Both exact print_utf8 ELFs start at **0x2623a0**, but candidate instructions grow
from 1,967 to 2,252 and bytes from 8,524 to 9,699. Caller apply retains its
relocation-masked instruction stream. Fixed entry address rules out entry
movement as necessary for this candidate's loss, not all layout/codegen effects
or a unique causal explanation. Both arms pass 383 terminal tests and 12,800
differential streams. All 120 Rust sources, 6,421 prior tracked reports/results
and selected executable are unchanged; restored Cargo artifact byte-matches
control. Retain failed census invocation before corrected run; no engine
sessions lost or retried. Full report and read-only replay:

```sh
python3 -B bench/results/2026-11-03-decoded-handoff/verify.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-decoded-handoff/frozen-index.json
```

See `bench/results/2026-11-03-decoded-handoff/README.md` and
`reports/research-1eecf9876bb302e9da10ff629e71e6d8-27.txt`.


### Safe decoded-scalar-domain validation: screen failed (2026-11-03)

The decoder now has a distinct measured counterexample: replace special
E0/ED/F0/F4 second-byte bounds with uniform continuation-shape checks, a decoded
minimum per length, and safe `char::from_u32`. This changes neither accepted
UTF8 nor row/parser authority. The sole candidate passes 383 terminal tests and
12,800 differential streams per arm but fails the prospective 12-pair screen:
Unicode **1.005126x**, **6/12 wins**, Holm p=1, below the 1.02 target. TUI
**.985766x (1/12)**; truecolor **.983740x (2/12)**; cursor **.981429x (2/12)**;
ASCII **1.004250x (7/12)**; region **1.000384x (7/12)**. All median .98 point
guards clear, not a noninferiority demonstration. No runtime/PTY escalation.

Both exact `print_utf8` entries remain at 0x2623a0; code grows **8,524->8,595
bytes**, **1,967->1,972 instructions**, while caller `apply` retains its masked
instruction stream. Removing source-level lead-specific cases does not reduce
compiled footprint here. Static census is not dynamic cost or unique cause.
Early paired ratios have large excursions (Unicode .721–1.464); every pair is
retained, with no trimming, replacement sessions or fabricated host diagnosis.
The frozen protocol has a stale copied hypothesis sentence; an explicit
in-flight additive clarification precedes timing-result inspection. Exact patch,
intervention field and numeric gates were correct and unchanged throughout.

The original source and rebuilt Cargo artifact are restored byte-for-byte;
selected release executable, 120 Rust sources and 6,514 prior tracked result/
report files are unchanged. Full local report, limitations and read-only replay:

```sh
python3 -B bench/results/2026-11-03-scalar-domain/verify-current.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-scalar-domain/current-frozen-index.json
```

See `bench/results/2026-11-03-scalar-domain/README.md` and
`reports/research-1eecf9876bb302e9da10ff629e71e6d8-28.txt`. This is a rejected
local engine experiment, not a Ghostty comparison or a championship result.

The original history adapter's broad replacement also modified a quoted template,
so the first local checkpoint failed. Retain the original frozen scripts/failure;
the current checker uses a statement-anchored location/index-only adapter and
explicit pre-correction document snapshots. Timing evidence is unchanged.
