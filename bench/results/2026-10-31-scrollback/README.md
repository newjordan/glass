# The scroll_region gap is not the history copy (2026-10-31)

## The question

The hand-off fix (573de33) left scroll_region at 475 MB/s against
ghostty's ~1100, with full hand-offs and only ~9 ms of hand-off wait,
and named "compute inside the parse (the scroll/history copy path)",
tying it to the 8B-cell question the width-cache ceiling probe framed.
That was a hypothesis. This session tested it.

## Method

1. `GLASS_SCROLLBACK` (engine.rs): the history's size from the
   environment, so one binary can run the harness with a 10,000-line
   ring (37 MB of cells) or none at all. The shipped default is
   unchanged.
2. `bench/results/local/scrollback-sweep/` — the full harness
   (tput.py in the window) with GLASS_SCROLLBACK=0 vs default, three
   rounds each, this machine.
3. `crates/term/src/speed.rs` — the headless bench gained
   `GLASS_BENCH_STAGE` (split only / pump only / both) and
   `GLASS_BENCH_COUNTERS` (engine counters: which of the two apply
   paths took each byte). A standalone C probe measured the scroll
   operations themselves.

## Findings

- **The history costs nothing.** GLASS_SCROLLBACK=0 leaves every
  workload within noise of the default in the full harness
  (scroll_region median 461 vs 471 MB/s; ascii 529 vs 522) and in the
  headless bench (scroll_region 512 vs 507). The ascii spread between
  placements is the two dies; see the hazard below.
- **The scroll operations themselves are free at flood cadence.** A C
  probe of the ring at 154x39 with the history resident: rotate is
  0.03-0.12 us per line (8-40 M lines/s) against the ~1 M lines/s the
  flood needs. Even the naive memmove alternative is 918 us/scroll -
  glass does not do that; the ring rotates by one index store.
- **scroll_region is ascii.** With the engine counters on, the two
  workloads are the same stream to the engine: 97.7% and 97.6% of
  bytes go through the ASCII run lane (`print_run`), 0.3% through the
  byte-at-a-time parser. A DECSLRM around the screen changes nothing
  the print path feels. The two workloads' small throughput
  difference is size-of-stream and die placement, not mechanism.
- **The engine owns the cost.** Stage decomposition: the splitter is
  2.25% of the budget, pump 1.3%, the engine 96.5%. Inside the engine,
  the byte-at-a-time vte parser touches under 1% of bytes on every
  workload - including the escape-dense ones (truecolor 0.9%,
  cursor_motion 0.5%, tui_frames 0.5%), whose escapes all go through
  glass's own lane. The lanes are not the cost either: ascii at 570
  MB/s is already the lane's ceiling.

## What that means

The width-cache framing ("the 8B-cell architecture question") was
about memory: the theory was that a 24-byte Cell makes the history
copy or the cell writes memory-bound. Measured: the cell store alone
sustains 1337 MB/s (the storebench), the scroll itself is free, the
history is free, and the full print path caps at ~600. The ~0.9 ns
per byte the print path pays over its own store is not memory; it is
the per-cell work the loop does between stores (flags test, pen
stores, wide-underneath check, wrap bookkeeping) and the per-line
cursor/grid re-entry. Making the cell smaller buys none of that back
- the Mac 16B-cell A/B already showed it costs more than it returns.

The gap to ghostty on plain text is therefore an engineering gap in
the run loop, not an architectural one: something between 600 and
1100 MB/s is available in `print_run` and its per-line scaffolding
without touching the cell layout. The escape path is a second,
separate ceiling (235-287 MB/s on escape-dense workloads, with vte
itself at under 1% of bytes) - the cost there is glass's own escape
scan and lane setup per sequence, which the earlier ceiling probe
capped at +21%.

## A measurement hazard, recorded

`GLASS_AFFINITY=off` lets the bench thread land on either die of this
X3D part; identical commands swing 340-660 MB/s. Every number above
was taken with the hot thread placed (the bench's own default), and
the sb=0/sb=10000 pairs were interleaved on the same placement.

## Raw

- scrollback-sweep/ - full-harness runs, default ring (copied from
  bench/results/local/scrollback-sweep, which .gitignore keeps out)
- scrollback-sweep/sb0/ - full-harness runs, GLASS_SCROLLBACK=0
