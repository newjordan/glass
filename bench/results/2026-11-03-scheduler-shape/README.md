# Own-reader scheduler accounting: new diagnostic, no promotion

**Reported local research, not championship acceptance.** Exact selected Glass
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`;
no runtime rebuild or edit. No Ghostty comparison. All 120 Rust sources and the
selected executable are preserved.

## New result

`kernel.sched_schedstats=0` is **not by itself a capability test** for the
`/proc/<tid>/schedstat` run-delay counter on this Linux 7.2.8-9 kernel.
`kernel-evidence.txt` records CONFIG_SCHED_INFO=1, the matching header's
`sched_info_on()` and `proc_pid_schedstat` disassembly. More importantly,
`calibration.jsonl` experimentally distinguishes sleep from CPU contention:
12 balanced repetitions each, one pinned own process, and only its own competing
child pinned to that same logical CPU. No global sysctl changes, elevated
privilege, unrelated-task tracing or PMU facilities.

| Calibration | Wall ms | Thread CPU ms | Runqueue ms | Residual ms |
|---|---:|---:|---:|---:|
| Busy work (ambient contention present) | 80.013 | 38.334 | 42.040 | 0.138 |
| Sleep | 80.466 | 0.020 | 0.786 | 79.661 |
| Busy + own competing child | 80.548 | 24.815 | 56.029 | 0.084 |

These are component-wise medians, not a single additive trial. The busy arm is
**not an uncontended baseline**. Calibration must be repeated on another kernel;
this does not retroactively reinterpret the preserved historical reports that
conservatively nulled runqueue estimates.

## Capture and limits

A separate 3-session pilot was followed by **36 balanced sessions**: 12 rounds
cycling all six orders of profile-only plain, clock-only observer, and scheduler
observer. Own exact executable / self-named `pty-read` thread only. No runtime
code, affinity, producer or input treatment. Every 128 completed reads the probe
records wall/thread-CPU clock brackets and its own schedstat snapshot. Windows
include userspace, channel-credit waits, poll/ioctl and read work, not just a
syscall. The runtime is not rebuilt. The wrapper is the existing matched-payload
pipeline wrapper, with zero periodic sampling.

Decomposition uses bracket midpoint deltas for wall/CPU, cumulative run-delay
deltas for runnable waiting, and residual = wall - CPU - runqueue. We do not use
the proc runtime field for CPU estimation. The conservative snapshot uncertainty
is twice the sum of endpoint wall brackets; all signed residuals remain visible.
Only complete windows fully inside a producer pass count. Excluded boundaries
and unfinished teardown tails are not extrapolated. Full prefix continuity,
reader TID/start-time identity and no dropped windows are checked independently.

Balanced **scheduler-arm** pass medians (36 passes per workload):

| Workload | CPU % | Runqueue % | Residual % | Wall coverage % | Snapshot uncertainty % |
|---|---:|---:|---:|---:|---:|
| ASCII | 24.27 | 34.91 | 40.25 | 96.61 | 0.65 |
| Unicode | 11.82 | 14.97 | 73.74 | 95.91 | 0.43 |
| Truecolor | 16.78 | 21.68 | 62.48 | 97.27 | 0.44 |
| Cursor motion | 15.35 | 13.32 | 71.16 | 96.40 | 0.43 |
| Scroll region | 46.67 | 32.64 | 21.19 | 95.92 | 0.79 |
| TUI frames | 16.04 | 20.17 | 63.90 | 93.58 | 0.49 |

Component-wise medians need not sum to 100%. ASCII runqueue fractions range
0.92–46.63%; scroll-region 0.18–59.25%. Whole-window coverage minima are
92.36% and 84.97%, respectively. Median runqueue share **of off-CPU time** is
44.00% ASCII and 59.70% scroll-region in this instrumented capture. Thus treating
all off-CPU time as blocked/I/O time would be materially wrong here.

Residual is **not pure blocking**: it includes sleep/channel waits, interrupts,
accounting error and unclassified off-CPU time. No kernel copy/locking or
line-discipline attribution is established. Run-delay is a kernel accounting
observation, not a full scheduler-event trace or universal cause of the
Ghostty performance gap.

Observer effects are explicit. Median per-round throughput ratios:

| Workload | Clock/plain | Scheduler/plain | Scheduler/clock |
|---|---:|---:|---:|
| ASCII | 0.86127 | 1.00652 | 1.09037 |
| Unicode | 0.99663 | 0.99812 | 0.98152 |
| Truecolor | 1.03076 | 1.01128 | 0.95664 |
| Cursor motion | 0.96189 | 0.98400 | 1.01442 |
| Scroll region | 0.88728 | 1.02143 | 1.01881 |
| TUI frames | 0.92848 | 0.92408 | 0.95852 |

No comparison has even uncorrected two-sided sign p<.05; **not evidence of
neutrality/equivalence**. Both the clock and proc observer can alter pacing.
The plain arm still has the common producer/profile wrapper, so these are not
uninstrumented scoreboard measurements. No independence of passes is assumed.

## Reproduction and preservation

From the workspace root:

```sh
cc -O2 -Wall -Wextra -Werror bench/linux/sched-calibrate.c -o /tmp/sched-calibrate
/tmp/sched-calibrate > /tmp/calibration.jsonl
cc -shared -fPIC -O2 -Wall -Wextra -Werror -pthread \
  bench/linux/sched-shape.c -ldl -o /tmp/sched-shape.so
OUT=bench/results/new-scheduler-capture GLASS="$PWD/target/release/glass" \
  OBSERVER=/tmp/sched-shape.so ROUNDS=12 bash bench/linux/run-sched-shape.sh
python3 -B bench/linux/analyze-sched-shape.py \
  bench/results/2026-11-03-scheduler-shape/balanced \
  --calibration bench/results/2026-11-03-scheduler-shape
python3 -B -m unittest discover -s bench -p 'test_*.py' -v
```

The original observer source is retained in `source-snapshots/sched-shape.c`.
Current reusable observer makes target TID atomic and fails explicitly if
teardown precedes the first complete window. Original pilot/balanced captures
use the unchanged original `.so` and explicit `source-snapshots.json` mappings;
no fallback to current source on a mismatch. `*-final-replay.json` reproduces
all original numerical analyses exactly. The separate `safe-smoke/` capture
uses `sched-shape-safe.so`, not mixed into the 36-session result.

Read-only checker regressions cover continuity, counter/time regression,
truncation/drop/mode/ABI failures, recycled identities, duplicate JSON,
whole-window inclusion and retaining negative residuals. Seven disposable
real-capture corruptions are rejected without rewriting any of their files.
The entire pre-existing campaign audit is replayed into
`prior-audit-replay.json`, not overwritten in its original directory.

**Next causal experiment:** predeclare a bounded own-CPU-contention treatment
and its no-contender control, preserve all observer arms, and require matched
uninstrumented confirmation for any runtime policy. Do not retry a buffer or
poll tweak based solely on these counters. The all-metric Ghostty gap and exact
build acceptance remain unresolved.
