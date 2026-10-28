# Key latency in glass — method, baselines, breakdown, changes

Worktree `/work/frosty40/glass-keys-glm`, branch `latency/keys` (off `main`
b28a31b). Machine: the owner's (Ryzen 9 9950X3D, RTX 3090, Hyprland); all
measurements on a private headless output `KEYCAP` (1920×1080), never on the
user's monitors. glass is always the worktree's `target/release/glass`.

NOTE: the task asked for these files under
`/work/frosty40/glass-term-agents/reviews/`; that path is outside this
session's granted workspace root, so they live in `reviews/` in the worktree.
Copy them over if wanted.

## Method

Two measures, each with median and p90 over >=40 keys:

1. **Key to pty** — the time from Hyprland dispatching the key to the
   program inside reading its bytes. The same path `bench/run-misc.sh`
   measures: `hyprctl … send_shortcut` to the window's address; the program
   (`bench/keys.py`) logs `time.time_ns()` at each read; the sender logs
   `date +%s%N` just before each dispatch. Pairing is positional (one key,
   one read, 120 ms apart). This includes Hyprland's dispatch and Python's
   read loop — an upper bound on glass's own time; the breakdown below
   separates glass's share.
   Harness: `bench/keys-latency.sh` (new; same shape as `run-misc.sh`, one
   window at a time, `LOAD=yes` runs `yes | head -c 200M` behind the reader
   to flood the pty).

2. **Key to screen** — the time from the key being sent to the program's
   echo of it being visible on screen. The program inside prints a solid
   bright-red full screen (`ESC[48;2;255;0;0m ESC[2J`) with each key; a
   wlr-screencopy client (`bench/visible/viscap.c`, built by the script)
   captures a 64x64 patch of the headless output every compositor frame
   (240 Hz) and logs each frame's mean colour; the key's screen time is the
   first frame at or after the program's read whose patch is red. The pty
   number for the same key comes from the same run's read log.
   Harness: `bench/keys-screen.sh` (new). Resolution: one output frame,
   4.17 ms at 240 Hz.

Both were run on an idle terminal and under a flood (`yes`), because lock
contention only shows under load. kitty ran through the same harnesses for
an environment reference.

## Baselines (before any change, worktree build at b28a31b)

| measure | glass idle | kitty idle | glass `yes` | kitty `yes` |
|---|---|---|---|---|
| key->pty median | 2.08 ms (p90 2.92) | 2.08 ms | 90-256 ms (p90 499-602) | 34.0 ms (p90 84.7) |
| key->screen median | 6.87 ms (p90 9.53) | 5.94 ms (p90 7.38) | n/a (see note) | n/a |

Notes:
- The published number (bench/results/2026-10-27) for key->pty is glass 2.25
  / kitty 2.43 median; my reruns reproduce it (2.08 / 2.08) within run noise.
- key->pty under `yes` varies by run (255.69, then 90.02 in another; p90 up
  to 602 ms). The tail is the queue: keys arrive while the reader holds the
  engine lock for whole reads of a flood.
- key->screen under load cannot be read this way: with a flood running the
  patch is already red from the previous key. Load findings rest on the pty
  measure plus the idle screen path.

## Breakdown

`GLASS_KEY_TRACE=1` (new, off by default) prints, on stderr, one line per
step with the wall clock in ns, the thread and the step, in
`GLASS_STARTUP_TRACE`'s shape:

- `key-window` — the window thread received the key (`window.rs` `on_key`);
- `key-input` — the app thread picked it up from the channel (`Ui::input`);
- `key-encoded` — the five program-state reads and the byte encoding done;
- `key-written` — the bytes are through `Session::write` (its writer mutex);
- `*_lock_wait_us` — how long a wait for the engine or writer mutex took;
- `key-draw-start` / `key-draw-end` — the app thread's draw of the echo;
- `key-present` — the window thread presented the frame carrying it.

(Numbers follow with each change below.)

## Second session (2026-10-28): merging main, and the flood tail

`main` moved (776a229, 73a189b: the reader setup, the engine's
row-at-a-time writes). The branch was rebased onto it (fast-forward,
work re-applied); the fixed 50 µs pause from the first session was
dropped as the brief asked, and the merge brought in a bug fix the
first session's diff had shadowed: a `drop(lock(&engine))` on the reply
path that locked the engine a second time to drop a temporary, taking
the lock the flood's own thread was about to need.

### Changes (each its own commit on `latency/keys`)

1. **`KeyView` as one word** (was: an RwLock the reader rewrote after
   every pumped read — under a flood tens of thousands of writes a
   second, and a write-preferring RwLock let a key's read wait behind
   them; the copy had moved the wait one lock along). The view now
   packs into a single u64 published by a release store and read by an
   acquire load. `scroll_to_bottom` takes the engine only when the view
   is actually lifted (`at_bottom` false).
2. **The handoff**: a waiter sets an atomic flag before locking and
   clears it once it holds the lock; between pieces the parsing thread
   checks the flag and only then stays off the lock (a bounded spin)
   for whoever asked. Nobody waiting: one load, no cost.
3. **The waiter spins briefly on `try_lock` before sleeping**: the
   parsing thread's hold is tens of microseconds and a futex round trip
   can cost more than the hold.

### Measured (after, worktree `4444ddc`; before, `main` 73a189b)

Key to pty, `bench/keys-latency.sh`, 40 keys a run, headless `KEYCAP`
at 1920×1080. The flood is `yes > /dev/tty` for the window's whole
life (the first session's `yes | head -c 200M` died half a second in;
those numbers mixed load and idle).

| run | glass idle | glass `yes` | kitty `yes` (first session) |
|---|---|---|---|
| before (main) | 2.10-2.96 ms median | 134-437 ms median, p90 345-691 | 34 ms |
| after | 2.06-2.24 ms median | **14-32 ms median, p90 39-126** | — |

Six load runs, alternating binaries; before/after differ by an order of
magnitude on every pair. Idle is unchanged (the floor is Hyprland's
dispatch plus the program's read, not glass).

Key to screen, `bench/keys-screen.sh`, idle:

| | median | p90 |
|---|---|---|
| before | 4.85-4.96 ms | 6.51-6.75 |
| after | 4.62-5.35 ms | 6.13-6.88 |
| kitty, same harness | 5.53 ms | 6.40 |

glass and kitty are at parity idle; the first session's 6.87/5.94 gap
does not reproduce on this harness (the redraw path already drew a
key's echo the moment it arrives — `interactive` in the app's loop —
and Mailbox presents it the same frame).

Throughput, `GLASS_BENCH_SCALE=1 speed::speed`, three runs each,
alternated (ascii is bimodal on this machine — 320 or 590 MB/s whatever
the build — so medians of alternated runs are the honest comparison):

| workload | before (main) | after |
|---|---|---|
| ascii | 334 | 340 MB/s |
| unicode | 243 | 245 |
| truecolor | 282 | 285 |
| cursor_motion | 207 | 209 |
| scroll_region | 513 | 504 |
| tui_frames | 286 | 289 |

No cost: every workload within run noise of `main`.

### What is left, and why

The load tail (p90 up to ~126 ms) is not the engine lock — the
slow-key diagnosis (`GLASS_SLOW_KEYS`) never fired once on it. Placed
step by step: sent → key-window is 2.8-3.0 ms; window → the app
thread's `key-input` is the whole tail; encoded → written is 7 µs.
The app thread is drawing the flood: full-screen damage every
OUTPUT_PACE (8 ms) and each draw measured 4.6-19 ms under `yes`, so a
key sits in its channel until the draw in flight ends. Slowing the
parse thread (the full trace prints a line a pumped read) settles the
flood into smaller damage per frame and the same runs then measure
3.1-3.3 ms median — the equilibrium, not the lock, is what is left.
Fixing it means drawing less per frame under a flood (damage tracking
that skips rows that scrolled), which is renderer work, out of this
branch's scope.

### What I tried that did not help

- The fixed 50 µs sleep a millisecond (first session): gone, and it
  never fired under `yes` anyway — one read is one piece, and the
  slice boundary never came.
- `std::thread::yield_now` after 64 spins in the handoff, and a 500 µs
  waiter spin: no measurable change; the futex round trip is not the
  tail.
- The RwLock KeyView (see above): moved the wait, did not remove it.
