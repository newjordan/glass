# The run lane's real budget, and two candidates it killed (2026-11-01)

## Method

`GLASS_RUN_PROBE` (engine.rs, off by default) bounds the run lane's
suspects one at a time, all deliberately incorrect but the one measured
as a fix; `GLASS_PARSE_TIMERS=1` brackets apply/print_run/vte from the
inside (the clocks are gated on the flag, so the production path pays
nothing). Both arm in the bench test itself — main never runs there, a
trap that made this session's first ladder read as all-null.

## The budget (ascii, 154x39, scale 1.0, per round ~68 ms CPU)

- run cell stores 27% (537,630 print_run calls, avg 138 B — a 343-char
  line is 2.45 segments at 154 columns)
- byte-at-a-time vte advance at run gaps 43%: 950,364 calls, avg 1 byte
  each (held char + `\r\n`); the cost is the call, not the bytes
- the rest (ESC scan, mirror catch-up/stretch, loop) 30%

Numbers: apply 205.8 ms for 3 rounds; print_run 55.0 ms; vte 89.3 ms.

## Killed by measurement

- **Conditional pen stores** (store only where the cell differs): a
  REGRESSION, -15% ascii (403-428 vs 477-516 interleaved, one binary,
  probe 2 vs default). The compares cost more than the fire-and-forget
  stores they would save. Earlier "2.5x" numbers for it were the probe
  value colliding with the lane-skip gate (>=5); that collision, and
  the inert-probe first ladder, are both recorded in the loop log.
- **C0 direct-execute at gaps** (apply `\r\n` by Handler calls, no
  state machine — exact in ground state, REP untouched): a wash on
  ascii and on ascii_lf (bare-`\n` lines, added workload), +-2%,
  because the gap is one advance call either way and the split's
  rposition costs what the machine costs. Reverted.

## What the budget says

The gap to ghostty on plain text is now attributed to (a) ~43% in
per-call vte advance where the average call carries one byte, and (b)
per-segment re-entry of print_run at wrap boundaries (~2.45 segments
per line at 154 columns). Both are call-count problems, not byte
problems; the lane itself stores at 0.63 ns/B.

## Raw

- `ladder.txt` — the corrected probe ladder, interleaved
- `timers.txt` — the parse-timer decomposition, ascii + ascii_lf

## Probe 6: routing the gap through the lane — also a loss

The gap's printables sent through `print_run` (deliberately breaking
REP) measured 456-526 MB/s against the shipped 513-562: the lane's
entry scaffolding (~102 ns amortized over 137 cells) cannot beat a
1-3-byte advance call on a 1-3-byte slice. The lane wins by
amortization; a gap has nothing to amortize. Removed after measurement;
the 43% vte-advance share is a per-call cost the segment-per-wrap
design pays structurally, and the honest fixes are call-count reducers
(longer effective segments or a cheaper per-call entry), not byte-rate
work.

## Baselines after the dust settled (same machine, quiet)

- ascii 547-564 MB/s, scroll_region 497-500 MB/s (scale 1.0)
