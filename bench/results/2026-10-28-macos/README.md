# glass and Ghostty on macOS, 2026-10-28

**The machine:** a Mac mini with an M4 Pro, macOS 26.6.2, and a 4K display that stayed awake for the runs (`caffeinate -d`). The Mac was in ordinary use, with other apps open.

**What was measured:**
- **glass** at `aacf529` for throughput, and `f727bb8` for startup. The commits in between changed only startup.
- **Ghostty 1.4.0,** the notarized release.
- Both had a 160×48 grid at font size 13. Ghostty's settings are in `../../macos/ghostty.conf`.

## Throughput

`bench/macos/run-tput.sh`, five rounds, the two taking turns. Each round runs every workload three times and keeps the fastest (`bench/tput.py`).

| Workload | glass | Ghostty | |
| --- | --- | --- | --- |
| Plain ASCII | **363 MB/s** | 273 MB/s | 1.33× |
| Unicode | 240 MB/s | 235 MB/s | about even |
| Truecolor | **253 MB/s** | 218 MB/s | 1.16× |
| Cursor motion | **209 MB/s** | 187 MB/s | 1.12× |
| Scroll region | **351 MB/s** | 277 MB/s | 1.27× |
| Full-screen TUI | **2,891 fps** | 2,428 fps | 1.19× |
| CPU, all six | **0.84 s** | 1.37 s | |

- **Unicode is a close call.** Ghostty's rounds ranged from 213 to 304 MB/s; glass's stayed between 239 and 241.
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
