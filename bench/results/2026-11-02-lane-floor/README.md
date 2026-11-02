# The lane's one-character floor — truecolor from a tie to 1.10x

Iteration 23. One change in `engine.rs`'s `lane()`, plus the run-whole default
from iteration 22.

## The gap

`lane()` writes the text before a sequence straight into the grid, but only
`if after_lane && text.len() > 1`. The floor of 1 was right without run-whole:
`n` is then `text.len() - 1`, so a single character would print nothing.

Three workloads put **exactly one character between colour changes** —
`truecolor` (`SGR` + char), `tui_frames` (`SGR 48;5;N` + char, every cell of a
full screen), and anything else that colours per cell. For those, the floor
held every printed character out of the lane and sent it through the
byte-at-a-time parser, which runs ~30x slower per byte (~29 MB/s against
~886). The counters show it: `tui_frames` lane 0.0%, vte 0.5% of bytes — that
0.5% being precisely one char per cell.

With run-whole on, `n` is `text.len()`, so the floor can be 0 and the take is
sound. `set_preceding_char` already keeps REP correct, which is what the
original floor was protecting.

## Attribution (engine, alternating builds, 2 pairs each)

Both knobs moved together at first, so the builds were alternated to separate
them:

| workload | chars per sequence | run-whole alone | the floor |
|---|---|---|---|
| truecolor | 1 | nothing | **+9.2%** |
| tui_frames | 1 | nothing | **+11.3%** |
| cursor_motion | 6 | +13.3% | nothing |

`cursor_motion` already cleared the floor at 6 characters, so run-whole's
`n = len` against `len - 1` is the whole of its gain. The two one-character
workloads were gated entirely, and run-whole alone did nothing for them.
The split matches the workload shapes exactly.

## Terminal level: 9 interleaved rounds, 154x39, free GPU

| workload | glass | ghostty | ratio | glass wins |
|---|---|---|---|---|
| truecolor | 262.4 | 238.8 | **1.10x** | **9/9** |
| cursor_motion | 239.3 | 217.8 | **1.10x** | **9/9** |
| tui_frames (fps) | 3792.0 | 3806.7 | 1.00x | 4/9 |
| ascii | 703.3 | 1102.1 | 0.64x | 0/9 |
| unicode | 222.9 | 282.6 | 0.79x | 0/9 |
| scroll_region | 757.1 | 1155.9 | 0.65x | 0/9 |

**truecolor converted from 1.00x to 1.10x, 9/9, ranges disjoint** (glass
256.4-265.4 against ghostty 201.8-243.1). Banked.

**tui_frames is a dead heat, not a pass.** A 5-round run read 1.01x and that
was noise: at 9 rounds it is 1.00x on 4/9 with the ranges overlapping (glass
3621.6-3904.5, ghostty 3726.4-3830.6). It moved from 0.93x to parity, which is
real, but parity is not the gate. Five rounds is not enough on this box — the
controls in the 5-round run drifted up to 12% (ghostty ascii +11.8%, foot
truecolor +10.6%), wider than the effect being claimed.

ghostty's ascii read 958.6, 1071.4 and 1102.1 across three runs tonight, so
the ascii deficit is somewhere in 0.64-0.71x and the harness cannot currently
resolve it better than that.

## Correctness

`plain_runs_match_the_parser_over_seeds`: 25,600 random streams, both arms, no
divergence. Full suites 700/700 (glass-term 364, alacritty 177, glass-window
128, vte 31).

## Gate

2 pass (truecolor, cursor_motion), 1 tie (tui_frames), 3 behind (ascii +57%,
unicode +27%, scroll_region +53%). Was 1 pass, 1 tie, 4 behind.
