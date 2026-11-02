# The bare-C0 gap, implemented safely — and worth nothing at terminal level

Iteration 25. The C0 gap fast path that iteration 20 banked on and that was
reverted for a correctness divergence was rebuilt, made safe, measured, and
**not landed**. What it cost to find out is written down here so it need not be
found out twice.

## What it is

`ascii` is 153 printable characters and `"\r\n"` per line, so every gap between
runs is two C0 bytes, and each one enters the parser's state machine through
`processor.advance`. With run-whole on, that is **396,480 parser entries for
2-byte gaps** over a 5-round run.

The fast path carries out the gap directly — `linefeed`, `carriage_return`,
`put_tab`, `backspace` on the handler — when every byte of the gap is one of
those four controls.

## Two guards, both necessary, found by measurement

Unguarded it **diverges in cells**, caught by the sweep *and* by the existing
fixed-seed `plain_runs_match_the_parser`.

1. **Synchronized output.** While a sync is open the parser is collecting, and
   these controls must be deferred with everything else rather than applied
   now. `processor.sync_timeout().sync_timeout().is_none()`. This is the one
   the existing 400-stream gate catches, and almost certainly the original
   kill.
2. **Groundness at `fed`.** Adding guard 1 made the fixed-seed gate pass —
   364/364 — while the 25,600-stream sweep **still diverged**. The sweep is
   strictly stronger than the gate. `shrink_sweep_divergence` cut the case from
   thousands of bytes to **39**:

   ```
   <invalid UTF-8> ESC ] 1 3 3 7 ; F i l e = BEL \r NSv}Sy~` <invalid UTF-8> ;111;111;111;1m
   ```

   An OSC terminated by BEL. The assumption that the parser is in ground
   wherever a gap begins is false at a chunk's start, where it may be part way
   through a sequence the previous chunk began. A `ground_at_fed` flag — false
   at chunk start, true after a parser advance to a ground point, a printable
   run taken from ground, or a sequence the lane took — closes it.

With both guards: **25,600 streams in both run-whole arms, no divergence,
700/700 tests.** It is correct.

## What it is worth

Engine (medians of 3 alternated pairs, scale 0.5):

| workload | base | c0+guards | |
|---|---|---|---|
| ascii | 842.8 | 883.9 | **+4.9%** |
| scroll_region | 859.0 | 899.6 | **+4.7%** |
| unicode | 223.8 | 232.9 | **+3.8%** |
| ascii_lf | 499.6 | 502.8 | +0.6% |
| truecolor | 280.8 | 276.3 | -1.6% |
| cursor_motion | 258.2 | 252.6 | -2.2% |
| tui_frames | 298.3 | 289.8 | -2.9% |

Terminal, 9 interleaved rounds at 154x39 on a free GPU:

| workload | base | c0+guards | delta |
|---|---|---|---|
| ascii | 703.3 | 691.4 | -1.7% |
| scroll_region | 757.1 | 755.5 | -0.2% |
| unicode | 222.9 | 222.1 | -0.4% |
| truecolor | 262.4 | 264.2 | +0.7% |
| cursor_motion | 239.3 | 237.8 | -0.6% |
| tui_frames (fps) | 3792.0 | 3845.0 | +1.4% |

**Nothing.** Every number inside ±1.7%. A 4.9% engine gain on `ascii` produced
no terminal change at all.

## Why it was not landed

It adds a correctness-sensitive fast path, with two guards whose necessity is
not obvious from reading it, to the hottest loop in the engine, in exchange for
nothing a user or the scoreboard can see. The recipe and both guards are
recorded above; land it the day engine throughput is the binding constraint.

## CORRECTION: the terminal run above was underpowered, and its conclusion wrong

The 9-round terminal table above cannot support what the next section
originally claimed. Terminal `ascii` has **sd 7.5% and sem 2.5% at n=9**, so a
4% effect is not resolvable: the -1.7% reading is consistent with anything from
-5% to +2%. Worse, cross-run comparison is hopeless here — ghostty's own ascii
median moved 1102.1 to 948.8 between the two runs, 14%, with no change to
ghostty.

`term_cmd` has a `glass-alt` arm for exactly this: two binaries interleaved in
one run, which cancels drift and pairs every round. 15 paired rounds, base
against c0+guard, with a two-sided sign test on the per-round ratios:

| workload | base | c0+guard | delta | pairs won | sign p |
|---|---|---|---|---|---|
| scroll_region | 730.2 | 769.7 | **+5.0%** | 12/15 | **0.035** |
| ascii | 660.1 | 684.7 | +3.3% | 10/15 | 0.302 |
| truecolor | 262.4 | 264.0 | +0.4% | 11/15 | 0.118 |
| tui_frames (fps) | 3808.0 | 3820.9 | -0.3% | 7/15 | 1.000 |
| cursor_motion | 237.7 | 236.4 | **-1.0%** | 3/15 | **0.035** |
| unicode | 223.7 | 216.4 | **-3.2%** | **0/15** | **0.000** |

**Engine gains do transfer.** scroll_region is +4.7% in the engine and +5.0% at
terminal, about 1:1. The claim that engine work does not reach the terminal was
wrong and is withdrawn.

**And transfer is not uniform — it can invert.** `unicode` is +3.8% in the
engine and -3.2% at terminal, 0 of 15 pairs, p=0.000. An engine number is not a
per-workload proxy for a terminal number, and any engine win worth landing has
to be confirmed in a paired terminal run.

The decision not to land stands, on better evidence: it costs a metric that
passes (cursor_motion) and one that trails (unicode) to buy +5% on one at 0.66x
and +3% on one at 0.73x, neither of which flips.

## Method worth keeping

Paired `glass`/`glass-alt` rounds with a sign test resolve a 3% effect at
n=15. Unpaired medians at n=9 cannot resolve 5%. Every A/B from here should use
the paired form — it is the same wall-clock cost and several times the power.
Two conclusions in this session were drawn from unpaired runs and both were
wrong: `tui_frames` called a pass at 5 rounds (a tie at 9), and this one.

## What the transfer ratio means for the gate

Terminal `ascii` 703 against engine 842 is a 17% pipeline loss, not the 2x that
an earlier comparison against the stale, contended 464 suggested. So the sink
is ordinary overhead, not a multiplier — and closing it **entirely** would put
ascii at 842 against ghostty's ~950, still 0.89x. scroll_region likewise: a
perfect sink gives ~900 against ghostty's ~1150, 0.78x.

Both therefore need large *engine* gains on top of a perfect pipeline: ascii
about +35%, scroll_region about +28%. Iteration 16 measured scroll_region's
engine ceiling with the region swap chain removed entirely at 925, which is
below what is needed. That is the honest shape of the remaining gate.

## The finding that outlives it

Iteration 24's structural result stands on its own: the reader's hand-off wait
is ~470 ms of a 450 MB flood, `Gathered` removes it outright, and the flood
takes exactly as long — so hand-off latency is off the critical path. That says
the reader idles because it is ahead of the sink, which is still true.

What does **not** follow, and what the paired run above disproves, is that
engine gains cannot reach the terminal. They can, about 1:1 where they are
real. The pipeline costs 17%, once, and does not scale away a win.

## Kept

`shrink_sweep_divergence` (`#[ignore]`, `GLASS_SHRINK_SEED`/`_ROUND`): greedy
minimisation of anything the sweep finds, modelled on
`shrink_c0_inline_divergence`. It turned an unreadable stream into 39 bytes in
one run, and it is the tool the next divergence wants.
