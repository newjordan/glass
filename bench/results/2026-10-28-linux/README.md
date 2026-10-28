# Results, 2026-10-28 (Linux)

The raw files behind the Linux numbers in the README and
[docs/PERFORMANCE.md](../../../docs/PERFORMANCE.md). The summary, with every
round and launch, is [`../../scoreboard-20261028.json`](../../scoreboard-20261028.json).

**The machine:** a Ryzen 9 9950X3D and an RTX 3090, running Omarchy (Arch Linux) and Hyprland 0.56, with a 1920×1080 headless output. Both terminals ran at 154×39 cells, each with the machine's own configuration.

**The terminals:**
- **glass:**
  - throughput on `0220628`;
  - first output on screen and startup on `4660308`.
- **kitty 0.49.2,** as Arch Linux packages it.

| File | What it is |
| --- | --- |
| `tput-glass-1..5.json`, `tput-kitty-1..5.json` | Throughput rounds 1 to 5, the two taking turns (`bench/run-tput.sh`). |
| `visible.json` | First output on screen, program running and window on screen (`bench/run-visible.sh`). Each terminal is launched 12 times with the 240 Hz capture on and 12 times with it off. The file also holds every run, the calibration and the GPU load. |

The key-latency logs of the same day are in [`../2026-10-28-keys/`](../2026-10-28-keys/).

Against 2026-10-27, the parser applies colour changes and cursor moves
itself, writes wide text a row at a time, and uses mimalloc. The results:

| Workload | 10-27 | 10-28 |
| --- | --- | --- |
| Truecolor | 200 MB/s | 253 MB/s |
| Cursor motion | 143 MB/s | 214 MB/s |
| Unicode | 179 MB/s | 215 MB/s |
| Full-screen TUI | 2,673 fps | 3,457 fps |
| CPU over the six | 0.67 s | 0.57 s |

Plain ASCII and the scroll region held.
