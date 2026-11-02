# Producer/reader domain pairing: a replicated transport-only control

This is **not** a terminal benchmark or a new Glass/Ghostty scoreboard. No
parser, renderer, DA1, scrollback, terminal window or compositor participates.
It tests whether the earlier producer-placement effect requires terminal work.

## Method and audit trail

`bench/linux/transport-control.py` AST-extracts the existing `tput.py` payload
builder statements, at 154x39, instead of rewriting the workloads. ASCII,
Unicode and scroll-region bytes retain their hashes. A producer uses fixed
64-KiB writes to `/dev/null`, a pipe, or an explicitly raw PTY. The latter two
feed `transport-sink.c`, a minimal pinned C reader that validates the exact byte
count. There is no line processing, output conversion or terminal emulation.
The sink reports completion before formatting its JSON result.

Each run randomizes all 9 transport/producer-mask treatments per block, with
three metrics inside each treatment, for 12 blocks: **324 trials per run**.
The three runs below therefore retain **972 measured trials**, plus separately
labelled smoke measurements. Producer masks are unrestricted, large-L3
(0-7,16-23), or small-L3 (8-15,24-31). The sink is pinned as stated below.
The experiment records and validates actual producer and sink masks.

- `randomized/`: seed 179365, sink large. Eight payload repetitions per trial.
- `replication/`: seed 179366, sink large. Same pipe/PTY byte counts; null trials
  raised from 8 to 128 repetitions to reduce sub-millisecond timing overhead.
- `small-sink/`: seed 179367, sink small. Same counts as replication.

Each directory contains complete `manifest.json`, every trial in
`trials.jsonl`, and a replayable `summary.json`. Manifest hashes cover payloads,
source, sink binary, treatment order and raw results. Frozen Python versions
1-4 preserve measured revisions, including the original parent read-descriptor
lifetime; final code closes that spare descriptor after the readiness handshake.
`final-smoke/` checks that cleanup change. The sink source/binary and compiler
log are retained here. Source replay can use the corresponding exact snapshot.

The small-sink run's free-text manifest note incorrectly says "Sink pinned
large"; the numeric sink_cpus field and all observed sink_allowed fields correctly
record and validate the **small** domain. Its warm-up used the large domain;
measured trials used the requested small domain. Both are corrected in the final
harness, without modifying the original manifest or raw results.

## Main finding

Throughput ratios are paired within each block, relative to the unrestricted
producer in that same run. Wins count ratios >1; sign p values are exploratory,
two-sided and **not corrected for multiple testing**.

| Sink | Producer | ASCII ratio; wins/12 | Unicode ratio; wins/12 | Region ratio; wins/12 |
|---|---|---:|---:|---:|
| large, run 1 | small | .3560; 2 | .4271; 1 | .3401; 3 |
| large, replication | small | .3697; 1 | .4405; 0 | .4328; 2 |
| small, reciprocal | small | .9950; 4 | .9963; 5 | 1.0105; 7 |
| small, reciprocal | large | .8470; 0 | .8465; 1 | .8231; 0 |

Large-reader replication small-producer p values are .00635, .000488 and
.03857. Small-reader large-producer p values are .000488, .00635 and .000488.
The loss can occur without terminal parsing/rendering, and reverses when only
the reader domain changes. Thus the earlier loss cannot be attributed solely to
Glass's parser or a universally slow small-cache producer. It depends on domain
pairing in this synthetic transport control. This is not proof of the precise
kernel/cache-coherence/scheduler mechanism, or a predicted production gain.

For scale, PTY median MB/s (auto/large/small producer):

| Sink/run | ASCII | Unicode | Region |
|---|---|---|---|
| large 1 | 596/592/212 | 548/646/217 | 607/634/209 |
| large 2 | 533/565/203 | 521/605/203 | 478/609/198 |
| small | 1103/928/1101 | 1102/928/1095 | 1103/896/1114 |

These **cross-run medians are not paired estimates of a sink-policy gain**.
Load changed between runs (recorded in replication/small-sink manifests).
Within each run treatments are randomized; physical cores, frequency and
unrelated host work were not isolated. The null control is much faster and
noisier: its apparent first smoke penalty disappeared in run 1, and its
replication small/auto ratios were .802/.842/.806. Pipe replication ratios were
.783/.681/.606, smaller losses than the raw-PTY .370/.441/.433.

`kernel.sched_schedstats=0` throughout. Runqueue counter fractions are therefore
not interpreted; the final summarizer emits null for them. The original v1
summary printed them, and remains preserved. CPU time and voluntary-switch
counts do not uniquely identify blocking vs wakeup/coherence costs.

## Replay and limits

```
python3 -I bench/linux/transport-control.py summarize \
  bench/results/2026-11-02-transport-control/replication
```

`validator-check.log` records rejection of changed raw hashes, wrong masks,
wrong byte counts, missing/duplicate trials and incomplete manifests. This is
measurement-harness validation, not production correctness proof.

A distinct, actionable next experiment is a **reader-only small-domain policy**
with the parser left on large L3, unchanged producer and normal terminal gate.
It is different from the previously rejected scheduler-managed/unpinned reader.
Neither the producer nor competitor affinity should be changed in the scoreboard.
No production optimization is promoted by this diagnostic alone.

## Follow-through: production counterexample

The next experiment above was actually run:
[small-reader terminal gate](../2026-11-02-small-reader/README.md).
It passed 3 existing reader tests, but the completed 18-round unchanged terminal
gate lost **31.5% ASCII and 33.8% region**, each 17/18 losses. It was rejected and
the original source/executable restored. Thus this report is a transport finding,
not a recipe for a default affinity change. Faster raw PTY behavior did not
transfer to the reader/parser pipeline.

`audit.log` records 972-trial replay and replay with the original temporary sink
absent, using the exact preserved sink. The final Python source is also retained
as `transport-control.final.py`; measured revisions remain unchanged. The first
missing-sink replay failed on an incorrect manifest-field assumption; the final
replay corrected that bug. No raw performance result was changed by the replay fix.
