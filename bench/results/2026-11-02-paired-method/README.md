# Calibrating the paired A/B: what code placement alone is worth

Iteration 26. No optimisation. This measures the instrument every other
iteration depends on, and it changes which of iteration 25's numbers may be
believed.

## Why

A paired `glass`/`glass-alt` run cancels drift **over time**, but a fixed
difference between two binaries — code placement, alignment, inlining — is
constant across every round. It would show as a clean 0/15 at p=0.000 and be
indistinguishable from a mechanism. This repo already records "-3.5% as
code-layout noise between two identical-behavior builds", so the question is
whether the sign test can tell the two apart at all.

## The control

`engine.rs` with an `#[inline(never)]` function held live by a `#[used]`
static, placed above the lane's helpers so the hot code after it moves. Never
called; semantics identical; the binaries differ.

15 paired rounds, base against base+perturbation, two-sided sign test on the
per-round ratios:

| workload | delta | pairs won | p |
|---|---|---|---|
| ascii | **-2.7%** | 4/15 | 0.118 |
| scroll_region | +1.8% | 8/15 | 1.000 |
| unicode | +0.4% | 9/15 | 0.607 |
| truecolor | -0.2% | 6/15 | 0.607 |
| tui_frames | -0.2% | 5/15 | 0.302 |
| cursor_motion | +0.1% | 8/15 | 1.000 |

**Layout alone never reaches significance** — nothing below p=0.118 — while its
median delta reaches 2.7%. So the median is not safe on its own at this scale,
and the sign test is: placement moves the number without moving the signs
consistently.

## What that licenses, and what it withdraws

Against iteration 25's paired C0 run:

| workload | layout only | C0 change | verdict |
|---|---|---|---|
| unicode | +0.4%, p=0.607 | **-3.2%, 0/15, p=0.000** | **real** |
| scroll_region | +1.8%, p=1.000 | **+5.0%, 12/15, p=0.035** | **real** |
| cursor_motion | +0.1%, p=1.000 | **-1.0%, 3/15, p=0.035** | real, small |
| ascii | -2.7%, p=0.118 | +3.3%, 10/15, p=0.302 | **withdrawn** |
| truecolor | -0.2%, p=0.607 | +0.4%, p=0.118 | no effect |
| tui_frames | -0.2%, p=0.302 | -0.3%, p=1.000 | no effect |

**`ascii`'s +3.3% is withdrawn.** It is the noisiest metric here — placement
alone moved it -2.7% — and p=0.302 does not clear it. The claim that the C0
change's engine gain on ascii transferred is unsupported; only
`scroll_region`'s does (+4.7% engine, +5.0% terminal, about 1:1).

**Rule for future A/Bs:** report the sign test, not the median, and treat any
result above p=0.05 as absent no matter how good the median looks. A median of
2-3% is inside what placement buys.

## The unicode inversion is not contention

`unicode` is +3.8% in the engine and -3.2% at terminal, p=0.000 — the only
measured case where a change's sign flips between the two. A unicode flood
through a real window under `GLASS_LOCK_CENSUS=1`, both binaries:

```
base  engine=4862waits/2ms  handoff=4862waits/9ms  handoffs=4862 avg_bytes=15646
c0    engine=4862waits/2ms  handoff=4862waits/2ms  handoffs=4862 avg_bytes=15646
```

2 to 9 ms of waiting in a ~470 ms flood, identical between builds. The
inversion is **work, not waiting** — a 50x margin, so this holds even though
the flood itself was too short to resolve 3.2% (the `head -c` asked for 200 MB
of a 76 MB file, and two reps spread 3.4%).

Every instrumented region is accounted for: the parse path has `engine::timers`,
the locks have `census`, the hand-off has its own counters. The draw and view
path has **no instrument at all**, and it is the only place left for the work
to be.

## Next

A draw-phase timer, the way `census.rs` instruments locks: time per frame in
the view snapshot, the layer walk and the present, env-gated and off by
default, with its cost measured before it is trusted — this session has three
instances of an instrument taxing what it measured.
