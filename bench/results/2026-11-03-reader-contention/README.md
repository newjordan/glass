# Bounded own-reader contention: sensitivity, not a promoted fix

**Result:** CPU competition increases recorded reader runnable waiting, but
does not reproduce a reliable plain-arm ASCII/scroll-region penalty in 12
outer rounds. Observer effects obstruct a scheduler-only explanation of the
remaining Ghostty gap. No runtime source, payload, or selected binary changed.

## Protocol and provenance

`protocol.json` was written before the pilot. Exact selected binary SHA-256:
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
No Ghostty sessions were run in this experiment.

- Pin only the own `pty-read` TID to logical CPU 0 in both treatments.
- An own helper, also pinned to CPU 0, either sleeps on pipe EOF or does
  bounded integer work until EOF. No global policy or priorities changed.
- Six arms: sleep/busy crossed with plain/clock/scheduler reader observers.
- Twelve rounds, six-arm Williams design followed by reversals. Each arm
  occurs twice in each launch position; this is deterministic, not randomized.
- Same 154x39 geometry, payloads, byte counts, DA1 boundary, fastest-of-three
  throughput convention, and common pass-boundary producer profiling. Plain
  has no reader observer, but is **not fully uninstrumented**.
- Original producer and surviving non-reader thread masks are recorded and
  checked at every pass boundary; reader start-time/TID and pin checked too.
- Original reader mask restored before exit. Helpers terminate by pipe EOF.
- Six pilot-v2 sessions and six hardened smoke sessions remain separate from
  all 72 confirmatory sessions; no exclusions or data-dependent stopping.
- First pilot retained under `pilot/`: first capture finished, but launcher
  checked the wrong result key and aborted. Manifest remains incomplete.

## End-to-end results

Median of 12 paired busy/sleep ratios (not ratio of aggregate medians).
Values below 1 mean busy is slower. Plain signs and exploratory two-sided
sign p-values with six-workload Holm correction are shown. Internal passes
are not independent trials. The primary workloads were ASCII and scroll.

| Workload | Plain ratio | Clock ratio | Sched ratio | Plain faster/slower | Plain Holm p |
|---|---:|---:|---:|---:|---:|
| ascii | 0.9108 | 0.8716 | 0.9016 | 3/9 | 0.291992 |
| unicode | 0.9780 | 0.9636 | 0.9680 | 1/11 | 0.031738 |
| truecolor | 0.9764 | 0.9727 | 0.9722 | 0/12 | 0.002930 |
| cursor_motion | 0.9876 | 0.9865 | 0.9818 | 1/11 | 0.031738 |
| scroll_region | 1.0132 | 1.0611 | 0.8578 | 7/5 | 0.774414 |
| tui_frames | 0.9917 | 0.9856 | 0.9763 | 2/10 | 0.115723 |

ASCII has a -8.9% plain median effect but only 9/12 slower pairs; this
sample does not establish no effect or equivalence. Scroll has no reliable
plain penalty; the scheduler-observed ratio is 0.8578, and clock is 1.0611.
Do not use the scheduler trace alone to prescribe a shipping policy.

The exploratory **post-capture** paired ratio-of-ratios for scroll, scheduler
busy/sleep divided by plain busy/sleep, is 0.9008, 11/12 below 1; two-sided
sign p=0.006348, Holm within six workloads p=0.038086. This is an observer-
interaction warning, not a predeclared primary result or mechanism proof.

Unicode is 0.9780 in plain (11/12 slower; Holm p=0.031738), 0.9636 in
clock, and 0.9680 in scheduler. Truecolor and cursor also have small,
consistent plain penalties. These controlled sensitivities are not Unicode
optimizations, and do not imply that removing competition would deliver
the missing margin in ordinary uninstrumented Ghostty comparisons.

## Accounting response and uncertainty

Per round use the median of three whole-window pass decompositions, then
report the median of paired busy-minus-sleep differences. Rounded percentage
points; these differences are not differences of the two reported medians.

| Workload | Sleep runnable % | Busy runnable % | Paired runnable pp | Paired residual pp | Sleep/busy bracket uncertainty % |
|---|---:|---:|---:|---:|---:|
| ascii | 0.014 | 7.577 | 7.574 | 5.242 | 0.265/0.237 |
| unicode | 0.696 | 2.827 | 2.166 | -3.710 | 0.125/2.541 |
| truecolor | 0.560 | 2.407 | 1.789 | -3.268 | 0.138/4.727 |
| cursor_motion | 0.348 | 2.126 | 1.445 | -5.077 | 0.117/1.343 |
| scroll_region | 0.006 | 7.777 | 7.731 | 1.461 | 0.278/0.239 |
| tui_frames | 0.216 | 2.396 | 1.874 | -2.470 | 0.129/1.715 |

ASCII recorded runnable-wait fraction rises in 12/12 rounds; scroll and
Unicode rise in 11/12. These counters respond to the known treatment.
However, Unicode busy snapshot uncertainty is about 2.54% of sampled wall,
comparable to its runnable fraction; truecolor busy uncertainty is about
4.73%. Do not treat these decompositions as exact partitions. Residual
remains unclassified off-CPU/accounting time, not pure blocked I/O.

Busy helper CPU/wall over its lifetime is 0.8307–0.8519 (median 0.8438);
sleep is about 0.000011. The CPU0 restriction is artificial and other
eligible threads, SMT, caches, clocks, thermal state, shared-host load,
deterministic ordering, and treatment carryover remain possible confounds.
No inference about unrestricted baseline scheduling follows.

## Verification and cleanup

- `analyze-reader-contention.py` replays all hashes, sources, explicit
  historical source mappings, arm order, rates, pass times, masks, identities,
  trace windows, whole-window coverage and helper lifecycle read-only.
- 84 valid sessions replayed: pilot-v2 6 + balanced 72 + safe-smoke 6.
- Ten disposable real-capture corruptions rejected, including coordinated
  dependent-hash updates. All challenged files unchanged by replay.
- Nine existing scheduler checker tests passed. No Rust source edit/build
  occurred; past Rust counts are not claimed as fresh verification here.
- SIGTERM, SIGHUP, SIGINT smoke uses injected payload wait but real reader
  pin/helper: all restore mask, kill no unrelated process, reap helper and
  retain complete:false. It is not benchmark data.
- Original capture wrapper is explicitly frozen under `source-snapshots/`.
  Current wrapper additionally unwinds catchable termination and always
  closes child streams. SIGKILL cannot execute Python cleanup; the caller
  must terminate its owned terminal/process group in that case.
- 120 Rust sources, selected release bytes, and all 193 prior scheduler/audit
  artifacts match the starting snapshot. Unrelated untracked work preserved.

## Replay

From repository root (no terminal launches, builds or evidence repair):

```sh
python3 -B bench/linux/analyze-reader-contention.py \
  bench/results/2026-11-03-reader-contention/balanced
python3 -B bench/results/2026-11-03-reader-contention/check-corruption.py
python3 -B -m unittest discover -s bench -p test_analyze_sched_shape.py -v
```

Historical wrapper snapshots are explicit and hash matched; no fallback.
`safe-smoke/` uses current hardened wrapper. `balanced/` uses the frozen
capture wrapper, same selected binary, same safe scheduler observer.

## Decision and next door

Do not promote a reader affinity, parser, or buffer policy from this run.
The all-metric claim remains unsupported. Exact-build audit remains the
baseline: selected executable needs roughly 5.01% more Unicode for observed
median parity; combined unpromoted candidate still lacks ASCII/scroll
superiority. Different binaries and datasets must not be pooled.

The next useful measured door is a predeclared **observer-free** exact-build
placement experiment, with Unicode as a guard and recorded own producer/
reader masks outside timed passes. First preserve identical build controls
and independently gate all six throughput workloads plus startup, CPU,
memory and quiet key latency. This diagnostic is a confound bound, not a
reason to repeat a parser micro-optimization or declare a world title.
