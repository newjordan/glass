# Key latency, idle and under a flood, 2026-10-28

The machine and the harness:
- Ryzen 9 9950X3D, RTX 3090, Hyprland.
- A 1920×1080 headless output.
- `bench/keys-latency.sh`, run once for each terminal and condition.

Each run sends 40 keys through Hyprland's `send_shortcut` to the window. `keys.py`, the program inside, logs the time it reads each one. The `sent-*` files are the send times and the `keys-*` files the read times; the n-th key sent pairs with the n-th read.
- **Idle:** nothing else is running.
- **The flood (`y1` to `y3`):** `yes` writes to the terminal for as long as the window lives.
- **The builds:**
  - glass is `main` after the key-latency merge, plus the commit that types keys from the input thread;
  - kitty is 0.49.2 with `--config NONE`.

| Key to pty | glass | kitty |
| --- | --- | --- |
| Idle, median | 2.20 ms | 2.25 ms |
| Under `yes`, median of each run | **3.11, 3.01, 3.02 ms** | 41.75, 38.58, 37.48 ms |
| Under `yes`, p90 of each run | **3.71, 3.62, 3.72 ms** | 73.85, 69.23, 67.81 ms |

The idle floor, about 2 ms, is Hyprland's dispatch plus the program's read; glass's own part is tens of microseconds (`GLASS_KEY_TRACE=1`).

Before the work of 2026-10-28, glass under the same flood took 134 to 437 ms. There were two causes:
- **The engine lock.** A key's state reads waited on it, and the parsing thread holds it read after read.
- **The draw.** A key waited for the app thread, which spends a flood drawing.

Now the key's state comes from a word the parsing thread publishes after each read, and the window's input thread types the key itself. Input the app thread will write to the program, such as a paste or a reported click, keeps its place ahead of later keys.
