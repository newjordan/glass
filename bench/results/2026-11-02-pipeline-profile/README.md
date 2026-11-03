# Matched-input pipeline profiles, not a scoreboard

**Reported research. No runtime promotion or championship claim.** Host Ryzen 9
9950X3D / RTX 3090, Linux/Hyprland, shared machine. Start commit
`68f18dd66fd1bfc917e50689aa4dc3443cd28e0e`. Exact historical selected executable:
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
No terminal affinity or competitor configuration was changed. No throughput
result here measures visible-frame or keyboard latency.

## 1. 36-session overhead control

`diagnostic-v2/manifest.json` records twelve rounds, all six plain/edges/sampled
orders twice, one terminal at a time. All sessions use the same executable,
154x39 geometry, six unchanged `bench/tput.py` payloads and fastest-of-three
DA1 estimator. Plain executes that file directly. The instrumented wrapper
executes a retained derived producer with snapshots outside the timed pass and
wall/process-CPU timers around its two `write_all` calls (payload, DA1).
It preserves every pass and payload hash. `bench/tput.py` is not edited.

Edges takes task snapshots only at boundaries. Sampled additionally observes
four named tasks every requested 5 ms. Samples record state, last CPU, allowed
mask, `/proc` CPU runtime, context switches and kernel wait channel. These are
non-atomic observations, NOT scheduler-event traces. sched_schedstats is off;
zero schedstat run-delay is not evidence of zero run-queue delay.

All **36 sessions / 432 instrumented passes** validate. Median paired rate
ratio vs plain (wins/12):

| Workload | Boundary-only | Sampled |
|---|---:|---:|
| ASCII | 1.0945 (7) | 1.0883 (8) |
| Unicode | 0.9915 (5) | 1.0085 (10) |
| Truecolor | 1.0078 (8) | 0.9985 (5) |
| Cursor motion | 0.9998 (6) | 0.9949 (3) |
| Scroll region | 0.9562 (4) | 0.9683 (4) |
| TUI frames | 1.0067 (9) | 1.0055 (8) |

No equivalence is established; the instrumentation can perturb pacing and the
host varies. These comparisons are controls, not an optimization or new score.
Observer snapshot cost median .407 ms (max .967); observed sample spacing
median 5.513 ms (max 55.158). Retain all outliers. Unit of replication is the
session/round, not the correlated 432 passes.

## 2. Different bottleneck regimes

Boundary-only median task CPU-runtime / DA1-wall ratio, and median parser
voluntary switches per pass:

| Workload | Parser CPU/wall | Reader CPU/wall | Parser voluntary switches |
|---|---:|---:|---:|
| ASCII | .5313 | .8655 | 1216 |
| Unicode | .9859 | .2381 | 12 |
| Truecolor | .9879 | .2723 | 13 |
| Cursor motion | .9890 | .2451 | 10 |
| Scroll region | .5230 | .8894 | 835.5 |
| TUI frames | .9895 | .2840 | 11 |

These ratios are per-thread and concurrent, so they do not sum to one. Boundary
read skew exists; off-CPU residual cannot separate blocked from runnable time.
The producer's payload `write_all` spans a median 99.7-99.9% of pass wall time
across all six workloads. That is pipeline backpressure, NOT evidence that
Python execution accounts for 99% of CPU or a unique causal bottleneck.

Crucially, the slowest boundary-only Unicode pass was **133.915 ms wall /
131.076 ms parser CPU**, with two involuntary switches. Fastest Unicode wall
was 59.783 ms, and median 63.036 ms. Thus this reproduced slow excursion has
increased on-CPU parser cost, not a simple long off-CPU stall. CPU frequency,
cache behavior, SMT interference and other causes are NOT distinguished.
The >10x ASCII excursions from earlier iterations did not recur in this batch;
these profiles do not retroactively diagnose them.

## 3. Leaf CPU sampling of the exact executable

`cpu/` contains three parser and three reader sessions under `cpu-sample.v1.c`
(preloaded diagnostic DSO, not linked into Glass). It arms a CPU-time timer on
the named current thread, recording x86-64 RIP and monotonic timestamp into
fixed lock-free storage. No payload memory or environment is sampled.
Symbolization joins only pass windows and translates file offsets through ELF
LOAD segments, requiring a containing symbol. Local symbols come from the
exact unstripped executable; unknown libc PCs remain unknown.

Unicode parser samples: **435/547 (79.5%)** in `Watch::print_utf8`; per run
144/181, 145/181, 146/185. ASCII print_run was 36/142 (25.4%) and scroll region
23/85 (27.1%). These are leaf PCs, not inclusive stacks or precise cycle costs.
The requested timer period was 100 us but observed parser spacing was ~1 ms;
signal coalescing/phase aliasing is material, samples are correlated.
Reader PCs mostly landed at libc file/virtual offset `0xa08f2`, the shared
`__syscall_cancel_arch_end` return stub (objdump evidence), not an exported
symbol that independently distinguishes read from poll.

### Follow-up call-label control

`cpu-v2/`: three serial reader sessions, new DSO with thread-local read/poll
labels, same executable/payloads. Delivered samples within passes:

| Workload | In read | In poll | Outside | Total |
|---|---:|---:|---:|---:|
| ASCII | 251 | 17 | 13 | 281 |
| Unicode | 88 | 12 | 10 | 110 |
| Truecolor | 168 | 6 | 13 | 187 |
| Cursor motion | 101 | 4 | 8 | 113 |
| Scroll region | 146 | 3 | 4 | 153 |
| TUI frames | 146 | 12 | 10 | 168 |

This evidence does not support assuming poll is the dominant sampled reader
path. It does NOT estimate call counts, syscall latency or kernel CPU share.
CPU timer delivery after kernel return can concentrate samples at a return
stub; calls are not independently sampled. Storage drops were zero, but timer
overruns were **4160/3750/3622** for **362/349/301** delivered samples; observed
median spacing ~2 ms. Label wrappers perturb calls. No claim of 100-us actual
resolution, kernel stacks, or a direct-read optimization follows.

## 4. Independent experiment, rejected

The profile motivated a one-attribute row-writer call-boundary candidate:
`put_row` inline(always) -> inline(never). It passed the pre-existing release
parser-equivalence test, then lost Unicode in 8/11 alternating engine pairs
(median ratio .99123). No terminal gate or promotion. Full source/build/raw
receipts: [row-outline](../2026-11-02-row-outline/README.md).
Runtime source restored byte-for-byte; exact selected executable unchanged.

## 5. Replay / reproduce

Run only one diagnostic/benchmark at a time; paths must have no spaces:

```sh
OUT=$PWD/bench/results/new-pipeline GLASS=/absolute/frozen/glass ROUNDS=12 \
  bash bench/linux/run-pipeline-profile.sh
python3 -I bench/linux/analyze-pipeline.py bench/results/new-pipeline \
  --out bench/results/new-pipeline-summary.json

gcc -shared -fPIC -O2 -std=c11 -Wall -Wextra -Werror \
  -o /absolute/cpu-sample.so bench/linux/cpu-sample.c -ldl -pthread -lrt
OUT=$PWD/bench/results/new-cpu GLASS=/absolute/frozen/glass \
  SAMPLER=/absolute/cpu-sample.so bash bench/linux/run-cpu-sample.sh
python3 -I bench/linux/symbolize-cpu-sample.py bench/results/new-cpu \
  --out bench/results/new-cpu-summary.json
```

The new runner uses v2. `THREADS=pty-read` selects three reader sessions.
Snapshot binaries/DSOs for long-term ELF replay: summary hashes reject identity
confusion but symbolization still needs the exact ELF at its recorded path.
For these saved results (read-only exact-summary replay):

```sh
E=bench/results/2026-11-02-pipeline-profile
python3 -I bench/linux/analyze-pipeline.py "$E/diagnostic-v2" --out "$E/pipeline-summary.json"
python3 -I "$E/symbolize-cpu-sample.v1.py" "$E/cpu" --out "$E/cpu-summary.json"
python3 -I bench/linux/symbolize-cpu-sample.py "$E/cpu-v2" --out "$E/cpu-v2-summary.json"
```

All three replays passed. The first `diagnostic/` launch failed on unstripped
/proc sched keys; it remains incomplete and excluded, with `run.log`. Fixed
runner failed early on session closure instead of silently counting it.
A failed v2 editing script and initial analyzer tuple/schema errors were fixed
before reporting v2. None is hidden as a successful measurement.

Explicit artifacts: original `diagnostic/`, full `diagnostic-v2/`, `cpu/`,
`cpu-v2/`, all three summaries, run/analyze/symbolize/replay logs, version-one
source snapshots and DSOs, `restoration.json`, disassembly excerpts and
`evidence-sha256.json`. Current diagnostic sources live in `bench/linux/`.
No PMU profile, full scheduler trace, official submission, or all-metric victory.
