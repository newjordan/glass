# The canonical scoreboard on HEAD, on a free GPU — glass, ghostty, kitty, foot

Iteration 22. `bench/run-tput.sh`, `TERMS="glass ghostty kitty foot"`,
`ROUNDS="1 2 3 4 5"`, all four at **154x39** on the headless output, 96 s
end to end. Medians of 5 interleaved rounds. Raw: `tput-<term>-<round>.json`.

What makes this one worth more than iteration 21's: it measured **HEAD**
(`GLASS=target/release/glass`, with run-whole on by default), not the published
`~/.local/bin/glass`, and the GPU was **free** — 1577 MiB of 24576 and 25%
busy, sglang gone, load 2.1. Iteration 21's run had neither and said so
("a repaired-harness baseline, not a claim").

## Medians

| workload | glass | ghostty | kitty | foot | vs ghostty | vs kitty |
|---|---|---|---|---|---|---|
| ascii | 681.7 | 958.6 | 312.2 | 428.5 | 0.71x | **2.18x** |
| unicode | 217.8 | 283.2 | 142.8 | 140.0 | 0.77x | **1.53x** |
| truecolor | 241.8 | 241.4 | 85.8 | 351.5 | **1.00x** | **2.82x** |
| cursor_motion | 240.0 | 212.0 | 76.1 | 418.3 | **1.13x** | **3.15x** |
| scroll_region | 685.7 | 1136.6 | 341.7 | 384.6 | 0.60x | **2.01x** |
| tui_frames (fps) | 3502.8 | 3783.3 | 922.1 | 6295.9 | 0.93x | **3.80x** |

MB/s is wall-clock; tui_frames is fps.

## Against the release gate

- **kitty: 6 of 6, by 1.53x to 3.80x.** That half of the gate is met here.
- **ghostty: one win (cursor_motion 1.13x), one tie (truecolor 1.00x), four
  behind.** The distance left is tui_frames **+8%**, unicode **+30%**, ascii
  **+41%**, scroll_region **+66%**.

Against iteration 21's baseline the two large deficits closed a long way —
ascii 0.52x -> 0.71x, scroll_region 0.42x -> 0.60x — from HEAD plus a free
GPU, not from one change.

scroll_region is the one that needs an idea that does not exist yet. The engine
does ~860 MB/s on it with run-whole, the terminal delivers 686, and iteration
16 measured the ceiling with the region swap chain removed *entirely* at 925.
Ghostty is at 1137. Closing the engine-to-terminal gap perfectly still lands
short of ghostty, so the gate cannot be reached on this workload by finishing
the work already identified.

## CPU, where glass is already ahead

Terminal CPU seconds, medians, lower better:

| workload | glass | ghostty | kitty | foot |
|---|---|---|---|---|
| ascii | **0.06** | 0.07 | 0.08 | 0.08 |
| unicode | **0.10** | 0.13 | 0.10 | 0.16 |
| truecolor | 0.14 | 0.22 | 0.28 | **0.10** |
| cursor_motion | 0.09 | 0.17 | 0.22 | **0.06** |
| scroll_region | **0.04** | 0.04 | 0.05 | 0.06 |
| tui_frames | 0.12 | 0.17 | 0.32 | **0.07** |
| **total** | **0.55** | 0.80 | 1.05 | 0.53 |

glass spends less CPU than ghostty on five of six and ties the sixth: **0.55 s
against 0.80 s over the set, 1.45x less**, and 1.9x less than kitty. Where
ghostty wins on wall clock it is not winning on work done.

## Steadiness

On the workloads ghostty leads, its spread across the five rounds is wide and
glass's is narrow: ascii 31% against 17%, scroll_region 27% against 9%. Its
ascii rounds ran 845.9 to 1138.9. Medians of fewer than five rounds will not
reproduce on this box, which is how iteration 21 landed on 0.52x.
