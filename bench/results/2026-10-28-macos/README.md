# glass and Ghostty on macOS, 2026-10-28

**The machine:** a Mac mini with an M4 Pro, macOS 26.6.2, and a 4K display that stayed awake for the runs (`caffeinate -d`). The Mac was in ordinary use, with other apps open.

**What was measured:**
- **glass** at `4660308` for throughput, and `f727bb8` for startup.
- **Ghostty 1.4.0,** the notarized release.
- Both had a 160×48 grid at font size 13. Ghostty's settings are in `../../macos/ghostty.conf`.

## Throughput

`bench/macos/run-tput.sh`, five rounds, the two taking turns. Each round runs every workload three times and keeps the fastest (`bench/tput.py`).

| Workload | glass | Ghostty | |
| --- | --- | --- | --- |
| Plain ASCII | **364 MB/s** | 281 MB/s | 1.30× |
| Unicode | 246 MB/s | 237.5 MB/s | about even |
| Truecolor | **254 MB/s** | 214 MB/s | 1.19× |
| Cursor motion | **209 MB/s** | 188 MB/s | 1.11× |
| Scroll region | **351 MB/s** | 285 MB/s | 1.23× |
| Full-screen TUI | **2,863 fps** | 2,436 fps | 1.18× |
| CPU, all six | **0.84 s** | 1.36 s | |

- **Unicode is a close call.** Ghostty's rounds ranged from 219 to 316 MB/s; glass's stayed between 243 and 247.
- **Accents.** The workload's "á" is an "a" followed by a combining accent. glass stores that accent on the letter's cell, as alacritty's grid does, at the cost of a small allocation.

## Startup

`bench/macos/run-startup.sh`, twelve launches of each, taking turns (`startup.txt`). The times run from the spawn to:
- **Program running:** the moment the program inside writes the clock.
- **Window on screen:** the moment the window list first shows a window the terminal owns.

| | glass | Ghostty |
| --- | --- | --- |
| Program running | **37 ms** | 141 ms |
| Window on screen | **162 ms** | 226 ms |

- **glass starts the program before its window exists.** macOS gives a window the size it asks for, so the grid is known as soon as the fonts are loaded.
- **Ghostty runs its command through `login` and `bash`,** as it does by default on macOS. glass starts the command directly.

## The pty

macOS's pty hands over at most 1 KiB a read, whatever the line speed. A reader that only reads gets about 260 to 300 MB/s through it. So plain text and the scroll region run near what the pty can carry, in both terminals.
