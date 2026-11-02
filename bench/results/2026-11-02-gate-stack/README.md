# The gate after seven stacked fixes, and the five that measured nothing

_Written 2026-11-02 (the tree's clock reads November; the runs are
tonight's). Status: measured (the 15-round scoreboard and the
engine A/B medians) / bounded (the segment split)._

## Question

The handoff left glass at 1.10/1.10/1.00 against ghostty on
truecolor/cursor_motion/tui_frames and 0.64–0.79 on
ascii/scroll_region/unicode, with the remaining work described as
architectural. What does a fresh decomposition of the losing
workloads actually charge, and what closes when each charge is paid?

## Answer

Seven fixes landed, each measured paired (engine: same-session
alternated binaries, ratio of MB/cpu-s medians; terminal:
`glass`/`glass-alt` same-round pairs). Stacked against the handoff
tree at the terminal they are worth **ascii +12.1% (9/15), unicode
+11.3% (14/15, p=0.001), scroll_region +17.2% (15/15), truecolor
+1.3% (14/15), cursor_motion +2.5% (14/15), tui_frames +0.6%
(9/15)** (median ratios of same-round pairs). Against ghostty at
154x39 over the same 15 rounds (JSONs beside this file):

| workload | glass | ghostty | ratio |
| --- | ---: | ---: | ---: |
| truecolor | 264.6 | 224.2 | **1.162, 15/15** |
| cursor_motion | 242.5 | 207.8 | **1.169, 15/15** |
| tui_frames (fps) | 3754 | 3616 | **1.038, 13/15** |
| unicode | 248.3 | 278.9 | 0.877 (won 2 rounds) |
| ascii | 679.2 | 993.0 | 0.744 (won 2 rounds) |
| scroll_region | 882.8 | 1107.6 | 0.809 (won 1 round) |

Three metrics beat ghostty (tui_frames was a tie in the handoff);
three are closer than the handoff's 0.79/0.64/0.65 and still behind:
unicode needs a further +14%, ascii +34%, scroll_region +24%
against this run's ghostty medians. (Ratios move a few points
run to run with ghostty's own median, ascii most: an earlier
15-round run of the same stack without fix 7 read unicode 0.913,
ascii 0.714, scroll_region 0.785 on higher glass medians for the
first two. Same-round pairs against the handoff tree are the
stable figure.)

### The seven fixes

1. **The sentinel fold is lazy in `note_scroll_up`** (engine
   ascii +~7% paired at the time). Measuring the scroll band folded
   the sentinel — a selection range read against the grid — on every
   scrolled line, for a band no event carried while the store said
   nothing could move. The fold was also secretly the sentinel's
   replant: an erase that touches the top row drops `Term`'s
   selection, and scrolls before the next pacing fold were lost
   lines. The sweep caught exactly that (seed 10 round 8, field
   `history`, fast lane one line behind slow from the first fold).
   Kept: the fold still runs in the no-move path when the sentinel
   is missing or the hand-carried lines reach the pacing bound —
   one compare on a flood. Regression test:
   `lines_scrolled_after_the_sentinel_is_erased_still_count`
   (fails 0-vs-2 without the liveness fold; it needs
   `set_motion(None)`, which is how the pump leaves a quiet store).
2. **The C0 gap** (the handoff's recipe, both guards): a gap of bare
   controls with the parser in ground at its start and no sync
   collecting is carried out on the handler directly. Sweep-clean
   both run-whole arms.
3. **A flat width cache over the whole codespace** (`width_of`,
   unicode +8.2% engine, 5/5). The table tried before covered
   U+0000..U+0FFF; the flood's characters live above it (CJK,
   emoji, symbols), where the crate's lookup is several dependent
   loads. One load per character after the first ask; an exhaustive
   equivalence test holds it to the crate (it caught that width 3
   exists — U+17D8 — before the sweep did).
4. **`warm_next_row` deleted** (ascii +5.4% engine 4/4, unicode
   −0.7% 0/4). Fifty-eight write-prefetches of the row the next
   scroll reuses, a line ahead: the lane's own streaming stores
   prefetch themselves, and the warmed row is partly evicted again
   by the line written in between.
5. **`SCROLL_COUNT_CHUNK` 1024 → 8192** (+2..5.5% on every engine
   workload, 34/35 pairs; 65536 no better). Per 1024 bytes a feed
   paid a fresh wrapper, an engine sentinel read (`to_range`) and
   the count's bookkeeping. The sentinel stays safe: inside a chunk
   the wrapper paces it (`drained` folds, scroll-down folds, and
   fix 1's hand-carried bound), so unread travel is bounded
   whatever the chunk is.

6. **Whole cells from a template in both lanes** (ascii +5.5%,
   scroll_region +10%, unicode +6.6% engine, all 5/5 or better).
   `print_run` and `put_row` assign a cloned template cell and then
   the character, instead of five field stores writing the same
   values; the assignment's wide stores pipeline where the narrow
   ones did not. The wide guard became a loads-only precheck so the
   write loop keeps that shape. A warning on measuring this one:
   probe numbers 201-204 in an early draft read 2.4x — any
   `GLASS_RUN_PROBE >= 100` skips the lane apply in `feed`
   entirely, so those numbers were the lane-skip ceiling wearing
   the loop's clothes. The paired shipped-form A/B above is the
   real figure.

7. **`damage_line` skipped while full damage is owed** (cursor
   +2.2% engine 4/4, ascii +1.5%). Glass never reads `Term::damage`,
   and even for a reader the per-line bounds are unobservable while
   `full` stands: `damage()` returns `Full` without reading them
   and `reset()` undamages every line first. Behaviour-preserving;
   the alacritty suite (which does read damage) passes unchanged.

Plus a correctness fix found on the way: **`Storage::rotate_region`'s
seam fallback was only a rotation for `positions == 1`** (the swap
chain [a b c d e] → [c d e b a] for 2, where rotation wants
[c d e a b]). Any `CSI S` of several lines while the ring's seam lay
inside the region hit it. It is a three-reversal rotation now, with
a model test (`region_rotation_reads_as_rotation`) that drives a
2-line rotation across the seam. The alacritty ref suite
(`scroll_in_region_up_preserves_history`, `vttest_insert`) is the
witness that found it — via the rejected change below.

### Measured and rejected (do not redo)

- **Two-pass branch-reduced `put_row`** (predecode span, prechecked
  guard, slice writes): −7% unicode after two rounds of fixing its
  own traps (a mark must *end* the span with its prefix kept, not
  bail it: −41% before that fix; the guard must truncate to the
  prefix before a wide-underneath cell, not refuse). The fused
  loop's out-of-order overlap was already worth more than
  de-interleaving. The width=1 ceiling (+44%) still stands
  unexplained by any restructuring: what it removes is the width
  *decision* per character, not any one branch around it.
- **Word-wide lane cell writes** (`#[repr(C)]` Cell, offset asserts,
  two `u64` stores instead of five field stores): ascii a wash,
  unicode −7% (the pinned layout re-rolls every other loop's
  codegen). LLVM does not merge the field stores, and doing it by
  hand is not faster.
- **O(1) region scroll via a pending offset in `Storage`** (the
  `zero` trick for one region, materialized on demand): rotate's
  ablation ceiling read +13%, but that bound keeps the writes on
  the same hot rows; the offset collected +2.3% engine and
  −6% ± noise at the terminal. Reverted whole; only the seam fix
  above survives from it. Boxing `Row::blank` (56→40 B) was priced
  and skipped: a per-line allocation buys back a ~3 ns memmove
  saving.
- **Dropless lane writes**: writing cells without dropping the old
  `extra` bounds at +5-14%, but learning that no cell holds an extra
  costs the same per-cell load the drop itself does (a loads-only
  precheck measured -15% ascii). The drop can only go away with a
  representation that knows extras are absent without reading cells.
- **`utf8_at` as one slice match**: -4.6% unicode; the per-byte
  `get` form stays.
- **Inline wide-clear in `put_row`**: not built — guard breaks
  measure <=0.1 per line (recycled rows are blank-observable), so
  the break-to-`input` path is already rare.
- **Selection rotate ablation**: a wash. **Scrollback size** (100
  vs 10,000) changes nothing — the cold-row story is not history
  distance. Splitter alone runs at ~100 GB/s (`GLASS_BENCH_STAGE=1`).

### Where the remaining time is (bounded, current build)

Ceiling probes on the final tree split each workload's engine time
into lane writes (`GLASS_RUN_PROBE=100` removes them), the
gap/scroll chain (104 removes the parser too), and the rest:

| workload | MB/cpu-s | lane | gap+scroll | scan/rest |
| --- | ---: | ---: | ---: | ---: |
| ascii | 928 | 52% | 27% | 20% |
| scroll_region | 931 | 45% | 35% | 20% |
| unicode | 242 | 80% | 13% | 8% |

The lane writes 24 bytes a cell, and every scrolled line still
pays the whole linefeed chain (selection rotate measured a wash,
recycle, damage, cursor) of which the memmove was the only part
that separated out (+13% bound, ~+2% collectable). Note the split
above predates fix 6; the lane's share is smaller now, which only
raises the relative weight of the rest. Beating ghostty's ascii
and scroll_region from here looks like the cell representation
itself — fewer bytes written per cell — the fork-wide change
iter15 named `8B-cell`, plus whatever ghostty does not pay per
scrolled line. That is the hard remaining work; nothing measured
tonight contradicts it, and nothing smaller is left standing.

### The cell-representation prototype, priced but not built

Scoped after the gate run, as the named next work:

- `Cell` is 24 bytes: `extra: Option<Arc<CellExtra>>` alone is 8.
  A `u32` handle into an intern store (0 = none, copy-on-write
  where `Arc::make_mut` is today, serialized as the
  `Option<CellExtra>` it names so `grid.json` round-trips) makes
  the cell 20 bytes — a manual `Clone`/`Drop` pair keeps the
  sharing semantics, and its drop check (`extra != 0`) is the same
  shape as the `Arc` drop it replaces. Touch scope is contained:
  39 `.extra` sites in 4 files (`cell.rs`, `term/mod.rs`,
  `grid/mod.rs`, glass's `engine.rs`).
- What it can buy is bounded, and the bounds were measured rather
  than the prototype: lane writes are 48% (scroll) to 86%
  (unicode) of engine time, so -17% of lane store bytes is worth
  at most ~+8% ascii/scroll and less in the lane's non-store
  remainder. Even stacking the dropless bound (+5-14%, not
  collectable as shown above) does not reach ascii's +34% or
  scroll_region's +24%. unicode (+14% to flip) is the only metric
  this change could plausibly finish alone.
- Conclusion: build it only as part of the fuller `8B-cell`
  redesign (style out of the cell too), not as a standalone
  24->20 shrink. The prototype was stopped at the survey stage
  for that reason; the survey above is its measured plan.

## Artifacts

- `tput-glass-{1..15}.json`, `tput-glass-alt-{1..15}.json`,
  `tput-ghostty-{1..15}.json` beside this file (glass = final stack,
  glass-alt = the handoff tree `1690d59`, both `main`-built release
  binaries; ghostty 1.4.0+omarchy.1), 154x39, load 2–3.
- Method: pairs are medians of per-round ratios with sign counts;
  single measurements made no decision. The machine carried another
  project's build for much of the session (load 10–18); engine
  decisions used MB/cpu-s, terminal decisions the same-round pair.

## Code

- `crates/term/src/engine.rs` — lazy fold + liveness
  (`note_scroll_up`), `plain_c0` and `ground_at_fed` in `feed`,
  `width_of`, warm removal, `SCROLL_COUNT_CHUNK`, tests
  `lines_scrolled_after_the_sentinel_is_erased_still_count` and
  `width_cache_agrees_with_the_crate_everywhere`.
- `crates/alacritty-terminal/src/grid/storage.rs` — seam rotation
  and `region_rotation_reads_as_rotation`.
- Held throughout: 824 workspace unit tests (+3 new), doc tests,
  workspace clippy (deny-by-default clean), the alacritty ref suite
  (45), and the sweep at 25,600 streams, 0 divergences, run-whole
  on and off, after every change that stayed.

## Superseded in part

The dropless-lane rejection and the unbuilt cell prototype above
were overtaken later the same day: a maintained `extra_free` row
bit collects the drop, and a uniform-style prefix oracle collects
most of the pen stores (ascii +54–60%, scroll_region +55% engine).
See `2026-11-02-uniform-oracle`.
