# The ascii throughput ladder and the parse thread's busy fraction

Measured 2026-11-02, HEAD 963393d, release, this box (RTX 3090 host,
9950X3D), one method per rung:

    real harness (tput.py, headless Hyprland)   483–487 MB/s
    in-crate pty + ReadAhead (feed_pty, AHEAD=1) 521 MB/s
    in-crate direct pump (no pty, no threads)    542 MB/s

Thread census during the flood (stall-census.sh, 200 Hz, 2.4 s of
flood caught; buckets of 0.2 s):

    pty-parse   92–100% RUNNING  (saturated)
    pty-read    16–35% running

So the pipeline is NOT the limiter: the parse thread is CPU-bound on
apply, the reader has headroom, and hand-off waits are sub-microsecond
(census: 22,488 of 24,116 waits under 1 µs). The 542→483 delta (~11%)
is the session loop's own per-piece cost on the parse thread (engine
lock round trip, frame_cuts Vec, pieces Vec, key_view store) plus the
pty itself — not waiting on anyone.

Where apply's 59 ms/round goes (GLASS_PARSE_TIMERS, ascii, ÷3 rounds):
    43%  vte advance at run gaps — 158.6k calls/round, ~160 ns each,
         gaps average 3 bytes (CRLF at line ends): per-CALL cost
    31%  print_run lane (0.24 ns/B of stores + wrap handling)
    26%  feed machinery (ESC scan, mirror, chunking, joins)

Conclusion: ghostty's remaining 2x on ascii is closed in the apply
path, not the pipeline. The top item is the per-call vte walk at
CRLF gaps — the C0-inline attempt on it is killed (see README.md),
but the attribution stands.
