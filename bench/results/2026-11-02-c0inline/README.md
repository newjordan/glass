# C0-inline: killed by the differential, evidence kept

## The candidate
Gaps between run lanes average 3 bytes and cost 43% of apply time (per
the timers, later corrected below: handler work, not state-machine walks) (HEAD, GLASS_PARSE_TIMERS, ascii:
475,776 advance calls / 3 rounds = 158.6k per round at ~160 ns ≈ 25 ms
of 59 ms apply). In tput's workloads the gap is CRLF at line ends. In
vte's ground state CR/LF/VT/FF are pure `execute` actions that never
change parser state, so the lane can call `Watch::carriage_return` /
`Watch::linefeed` directly (the same methods vte's dispatch calls) and
skip the walk. Gate: GLASS_C0_INLINE=1.

## The kill
`plain_runs_match_the_parser` (lane path vs plain parser, 400 random
rounds) diverges deterministically at round 274, cells differ. Shrunk
(the new `shrink_c0_inline_divergence` test, kept in speed.rs) to:

    \x1b[?2026h m \x1b[?47l \n Q=c]1337;CurrentDir=/tmp

The handler trace (GLASS_C0_TRACE) was read from interleaved stderr of
the fast and slow runs, so its apparent ordering ("linefeed before m")
is NOT evidence — the same trap the repo has documented twice before.
What is proven: the cell divergence is deterministic (5/5 runs, same
round, same minimal case), it appears only with GLASS_C0_INLINE=1, and
the 46-byte case above reproduces it. The mechanism — how the gap
inline interacts with `quiet_run`'s piece joins, the sync-update hold
(the case opens ?2026h and never closes it) and the lane's `fed`
accounting — is NOT pinned down. The engine change is reverted (git
checkout); the shrinker and the trace test stay as the reproduction.
Any retry must first de-interleave the trace (run fast and slow in
separate processes, or tag each line with the run).

## What stands
- The 43%/25 ms attribution stands (timers, not the candidate).
- The minimal case is deterministic and 46 bytes.
- Any future gap-inline must preserve ordering across quiet-piece
  joins; the shrinker is now part of the suite for exactly this.

## Update: mechanism pinned, candidate retired with the attribution corrected

The divergence was the **synchronized-update buffer**: with `?2026h`
open, vte's advance buffers bytes unapplied (the run below the gap is
skipped for the same reason — see the `sync_timeout` check in `feed`),
so an immediate C0 applies *ahead* of bytes still held in the sync
buffer. One guard fixes it exactly:

    processor.sync_timeout().sync_timeout().is_none()

With the guard, `plain_runs_match_the_parser` passes all 400 rounds
(gate on), the 46-byte case and every single-part variant matches, and
the full suite is green. Component necessity: ALL five parts of the
case are jointly required — remove any one (2026h, m, 47l, LF, the
25-byte run) and it matches.

**The measured verdict, though, retires the candidate**: with the guard
in and firing (c0 bypassed 309,848 of 359,830 gap bytes on ascii =
86%), vte time barely moves (25.9 → 25.3 ms) and apply total is flat;
throughput is a wash within noise across interleaved pairs. Replacing
the parser's walk with identical handler calls changes nothing — the
cost was never the state-machine dispatch.

**Attribution corrected**: the "43% vte-advance share" is not
per-call parser overhead. It is the handler work under the gap —
`Watch::linefeed`'s sentinel bookkeeping, `note_scroll_up`'s region
logic, `term.linefeed()`, `warm_next_row`'s prefetch — the same
per-line work the two-phase row rewrite targets. The remaining call
count (158,592/round on ascii) is the chunk-tail advances, which no
gap-inline can touch.

Next lever, precisely: `Watch::linefeed` per CRLF — batch the sentinel
fold and region checks across a run's linefeeds, or the 8B-cell
architecture for scroll_region's copy cost.
