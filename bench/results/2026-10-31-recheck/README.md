# The ghostty gap, re-checked on two machines (2026-10-31)

Two questions from the operator: did we lose ground, and are the benchmarks
trustworthy? One afternoon of re-measuring answered both.

## 1. No commit regressed glass. Nothing to revert.

Clean interleaved A/B on the same quiet Mac mini (M4 Pro), same hour, order
rotating so position cancels, 6 rounds (bench/macos/ab-3way.sh, new):

| workload        | glass@4660308 | glass@HEAD 193b2c0 | HEAD/pub |
| --------------- | ------------- | ------------------ | -------- |
| ascii           | 351.9 MB/s    | 352.6              | 1.00     |
| cursor_motion   | 203.9         | 205.8              | 1.01     |
| scroll_region   | 323.1         | 321.5              | 0.99     |
| truecolor       | 241.3         | 244.1              | 1.01     |
| tui_frames      | 245.3         | 248.9              | 1.01     |
| unicode         | 236.8         | 237.1              | 1.00     |
| cpu (six)       | 0.88 s        | 0.87 s             |          |

Raw runs: macos-ab/tput-{a,b,ghostty}-<round>.json (a = published commit,
b = HEAD). The working tree is clean at HEAD; the reverted 16B-cell
side-table refactor is gone (its own A/B verdict stands: every workload
slower); the stashed width-cache is not in the tree. Every commit since the
published scoreboard is within noise of it - the muse contributor changes
included. The honest caveat: HEAD also does not beat the published commit,
so whatever upside those changes were meant to bring is not visible on
macOS throughput either.

## 2. What actually moved: ghostty's binaries changed under us

- Linux (this box): pacman's log has ghostty 1.3.1 installed 2026-10-28
  21:30 and upgraded to 1.4.0 on 2026-10-31 10:19 - the morning of this
  re-check. The Oct-28 field numbers (results/local/field-*, glass 2-3x)
  measured 1.3.1. Today, same harness, same headless output and grid:
  ghostty 1.4.0 posts 968-1132 MB/s ascii and 996-1119 MB/s scroll against
  glass's 489-508 and 447-464 - a 2x gap - while glass is byte-for-byte
  where it was. Raw: tput-{glass,ghostty}-[123].json here.
- macOS (Mac mini): ghostty 1.4.0's binary is unchanged since 2026-10-27
  (mtime, --version), yet it measures +21-34% throughput and -16-26% CPU
  per workload today vs the Oct-28 session, with glass flat. No OS update
  (26.6.2 since Aug 21), no thermal assertion, no low-power state. The
  Oct-28 session ran on a Mac in ordinary use; today's ran quiet, after a
  reboot between the sessions (up 2 days at 15:18 = rebooted Oct 29).
  Machine load state - not any glass commit - is what moved macOS ghostty
  by up to a third.

## 3. Where glass stands today, honestly

Against ghostty 1.4.0 on the Mac: ascii a tie (352.6 vs 349.6), cursor
motion within noise (205.8 vs 209.5), glass behind on scroll_region (0.90x),
truecolor (0.89x), tui_frames (0.88x) and unicode (0.75x). On Linux, behind
on ascii/scroll by ~2x. The startup, CPU-under-load and key-latency wins
against kitty (README scoreboard) were measured then and stand.

## Method notes

- ab-3way.sh warms the machine with one throwaway run before the first
  measured round, so the first position no longer runs cold.
- run-tput.sh stops rather than open windows on a workspace that holds
  any; today that guard tripped on a stale Hyprland rule for workspace 67
  (the cockpit's aquamarine overlay). A fresh output name (CAP=GLASSB)
  clears it.
