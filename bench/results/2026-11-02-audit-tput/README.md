# The 15-iteration audit: claims vs artifacts, then the terminal scoreboard re-run (2026-11-02)

The iteration-15 checkpoint demands reconciling the active claims against
primary artifacts before new costly work. The audit found one unmeasured
reconciliation — the entire lazy-recycle campaign (080fd04) postdates the
last in-terminal ghostty comparison (local-compare, Oct 31 15:29; commits
landed 21:25–23:09) — so this session rebuilt HEAD and re-ran the same
harness, interleaved, 4 rounds each (tput-{glass,ghostty}-[1-4].json).

## 1. Claims vs artifacts

| Active claim | Primary artifact | Verdict |
| --- | --- | --- |
| +43% ascii engine (lazy recycle, iter 12) | 2026-11-02-headroom + ab logs | engine-true; **in-terminal +27%** |
| +17% unicode (overwrite_cell, iter 13) | 11903-ab-overwrite.log | engine-true; **net in-terminal -21%** vs pre-campaign glass |
| ascii/scroll headroom "~0" post-landing | lanefill/headroom pairs | engine-bench only; terminal still needs +41%/+107% |
| "No commit regressed glass" (recheck) | 2026-10-31-recheck | held for its range; **superseded**: the campaign itself regressed in-terminal unicode |
| ghostty 1.4.0 ~1100 ascii / "2x gap" | local-compare jsons | ghostty session-var +/-10%; the "2x" framing was **stale** — now 0.71x |
| hand-off fix +7.5% ascii | 2026-10-31-handoff A/B | stands (inside the re-measured HEAD) |
| iter-14 lane-fill design (unimplemented) | 2026-11-02-lanefill | still open; ascii_lf shape absent from tput (\r\n lines) |
| Negative results (16B cells slower, sync-buffer flat, IndexMut skip incorrect) | their READMEs | honored, not re-litigated |

## 2. The re-measured scoreboard (medians of 4 interleaved rounds, 154x39, headless)

| workload | glass (pre-campaign) | glass HEAD | ghostty 1.4.0 | old ratio | now | Δglass |
| --- | --- | --- | --- | --- | --- | --- |
| ascii | 506 | 640.5 | 904. | 0.47 | **0.71** | +27% |
| unicode | 210 | 166.1 | 246.9 | 0.74 | **0.67** | -21% |
| truecolor | 257 | 231.7 | 211.6 | 1.09 | **1.10** | won |
| cursor_motion | 216 | 203.7 | 198.0 | 1.02 | **1.03** | won |
| scroll_region | 451 | 467.4 | 966.5 | 0.41 | **0.48** | +4% |
| tui_frames | 245 | 229.4 | 235.1 | 0.94 | **0.98** | -6% |

CPU over the same rounds: glass 1.3-1.8 cores vs ghostty 2.0-2.7; per
CPU-second glass leads on 4 of 6 (unicode 124 vs 116, truecolor 174 vs 103,
cursor 160 vs 96, tui 167 vs 116; trails ascii 360 vs 336, scroll 280 vs 373).

## 3. Contradictions the audit resolves

- **The engine bench over-collects.** ascii: engine said 500->712; terminal
  506->640. The pty/render pipeline absorbs a third of the engine win.
- **The unicode regression is now measured in-terminal.** The lazy recycle
  cost unicode -34% engine-side and overwrite_cell bought back +17%;
  in-terminal it shows as -21% vs the pre-campaign binary (210->166) while
  ghostty held. The trade bought ascii +27% / scroll +4% at unicode -21% /
  tui -6%.
- **"2x behind ghostty" was stale on both ends**: the campaign moved glass
  up and ghostty's own session-var moved it down (1104->967 scroll,
  283->247 unicode across sessions; the recheck already caught ghostty's
  binary moving).

## 4. The literal target deltas (this box, this harness, to beat ghostty)

ascii 640.5 -> 904.8 (**+41%**), unicode 166.1 -> 246.9 (**+49%**),
scroll_region 467.4 -> 966.5 (**+107%**), tui_frames 229.4 -> 235.1 (+2.5%).
truecolor and cursor_motion are already ahead.

Priority by mechanism, not just size: scroll_region's +107% with ghostty
*more* CPU-efficient per byte (373 vs 280 MB/cpu-s) means ghostty's scroll
path is genuinely cheaper per cell, not merely wider-parallel — that is the
8B-cell architecture question, not a pipeline stall. unicode's +49% is
self-inflicted (the lazy mechanism's residual per-cell cost) and therefore
the cheapest to claw back. ascii's +41% needs the parse thread itself to
more than double its rate; the lane-fill fix (iter 14, designed) does not
apply to tput's \r\n shapes.

## Raw

- tput-glass-[1-4].json, tput-ghostty-[1-4].json — interleaved, same session,
  glass = target/release/glass @ 080fd04, CAP=GLASSB.

## 5. The ablation: same-session, binary-vs-binary (2026-11-02-audit-ablation/)

The -21% unicode regression claim rested on a cross-session comparison.
This control interleaves the published pre-campaign binary (glass.0220628,
"A") against HEAD (glass-alt, "B") in one session, 3 rounds each:

| workload | A: 0220628 | B: HEAD 080fd04 | delta |
| --- | --- | --- | --- |
| ascii | 447.0 | 560.8 | **+25%** |
| unicode | 211.9 | 170.1 | **-19.5%** |
| truecolor | 253.1 | 233.2 | -7.9% |
| cursor_motion | 212.2 | 205.6 | -3.1% |
| scroll_region | 459.4 | 471.1 | +2.5% |
| tui_frames (fps) | 3409.8 | 3347.0 | -1.8% |

The audit's two headline numbers — ascii +27%, unicode -21% — reproduce
under the strongest control as +25% / -19.5%. The campaign's terminal-level
trade is real, not session noise: it bought ascii and scroll and paid
unicode, truecolor and cursor_motion. Whether that trade is net good is an
operator call; the evidence for it is now interleaved on both sides.

Suite at HEAD: 364 passed, 0 failed (glass-term, release).
