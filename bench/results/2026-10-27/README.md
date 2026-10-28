# Results, 2026-10-27

The raw files behind the numbers in the README and
[docs/PERFORMANCE.md](../../../docs/PERFORMANCE.md). The summary, with every
round and every launch, is [`../../scoreboard-20261027b.json`](../../scoreboard-20261027b.json).

**Machine.** Ryzen 9 9950X3D, RTX 3090, Omarchy (Arch Linux), Hyprland 0.56,
a 1920×1080 headless output. Both terminals ran at 154×39 cells, with the
machine's own configuration for each.

**Terminals.**

- **glass.** Startup was measured on the build this repository's commit
  `42ec6b3` records (`28222a960` in the development tree it was exported
  from). The throughput rounds ran on the development build `04b5ccbef`,
  the one before the early frame; the early frame did not change the pty
  read path.
- **kitty 0.49.2**, as Arch Linux packages it.

**Files.**

| File | What it is |
| --- | --- |
| `tput-glass-pacing-v1..v5.json` | glass, throughput rounds 1 to 5. `glass-pacing` was the harness's name that day for the second glass binary (`GLASS_ALT`, now `glass-alt` in `lib.sh`), which was the build under test. |
| `tput-kitty-v1..v5.json` | kitty, throughput rounds 1 to 5, taking turns with glass. |
| `keys-glass.log`, `keys-kitty.log` | key latency: when `keys.py` read each key (ns, wall clock) |
| `sent-glass.log`, `sent-kitty.log` | key latency: when each key was sent through Hyprland |
| `visible.json` | first output on screen (`run-visible.sh`): 12 launches of each terminal at 240 Hz, every run, the capture's frame timing, the calibration and the GPU load. glass is the build that draws its first output on the CPU (after the 0.1.0 renames). |

```sh
python3 -I bench/summarize.py bench/results/2026-10-27   # the throughput, CPU and TUI medians
```

The startup runs (16 launches of each terminal) are in the scoreboard as
`startup_ms` (program running) and `first_frame_ms` (window on screen). The
VRAM figure is `nvidia-smi`'s for an idle window, read by `run-misc.sh`; its
output was not kept.
