# Lane singles + selection clear-of (2026-11-02, continuation)

On top of `2026-11-02-uniform-oracle`. Three small changes stayed;
the region-offset rotation was built, measured twice at the gate,
and rejected both times.

## What landed

1. **Single-char lane take** (`feed`'s `lane`): one printable cell
   between two sequences — the `tui_frames`/`truecolor` shape —
   now goes through `put_plain` instead of paying `print_run`'s
   whole setup for one store, under exactly `print_utf8`'s
   caller-side conditions. Engine paired 7: tui_frames +7.0% 7/7,
   truecolor +5.1% 7/7 (against the uniform stack).
2. **Slice `put_row`**: the row's gap is materialized once
   (`lane_cells(column, 0)`), then glyphs write into one raw slice
   (`Row::lane_slice_from`) with `occ` bumped once at the end,
   replacing per-glyph `overwrite_cell` + `virtual_cell`. Marks
   break to the existing `input` fallback (the inline `put_mark`
   and the Engine/Watch `mark` plumbing are deleted). Engine
   paired 7: unicode +0.9% 6/7, nothing down.
3. **`Selection::clear_of`** + `#[inline] rotate`: scroll paths skip
   take/rotate/put when both anchors sit outside the scroll region
   — the scroll sentinel's steady state in any subregion flood.
   Skipping rotate entirely bounded at +5% scroll_region; the
   shipped check took +5.0% 7/7 of it at engine level.

## Gate (this directory, 15 rounds, 154x39)

glass = this stack, glass-alt = handoff tree `1690d59`, ghostty
1.4.0. Vs ghostty: **truecolor 1.153 15/15, cursor_motion 1.094
15/15, tui_frames 1.025 14/15 beat it**; ascii 0.952 median paired
ratio (glass's median is the higher of the two; ghostty's ascii
median swung 884–1130 across the day's runs while glass held
1000–1050), scroll_region 0.929, unicode 0.877 still behind.
Same-round vs handoff: ascii +37%, scroll_region +38%, unicode
+11%, truecolor +2.5%, tui_frames +2.6%, cursor_motion −0.5%.

## Rejected after measurement (this round)

- **Deferred region rotation** (offset in `compute_index`,
  normalized before any structural op, scroll_down included):
  engine scroll_region +9–11% 7/7, but gate same-round only
  +0–3% for scroll while truecolor took −1.4 to −3.3% at 0/15
  both times — every per-character row index pays the shift
  branch, and the winners' margins were the price. Built and
  gated twice (alone, then on this stack); reverted twice. The
  rotate memmove (21% of scroll_region engine time) stands.
- **Width carry in `put_row`** (look up the next glyph's width a
  glyph early): unicode −8.3% 0/7. The lookup is not a latency
  chain worth hiding; the earlier "width = 23–38%" bounds were
  mostly the wide-handling and scroll-frequency changes that come
  with lying about widths (a branch-only width reads like the
  cache; skipping the spacer write reads 0%).

## Where the remaining time is (engine decomposition)

unicode: ~86% `put_row` per-glyph work (decode, width, slice
store; template assignment bounded ~5%, spacer ~0%).
scroll_region: rotate memmove 21%, then the linefeed chain.
ascii at the gate is no longer apply-bound (engine ~1800 MB/cpu-s
vs ~1040 MB/s wall through the pty), so engine wins there dilute
by roughly half.

## Code

- `crates/term/src/engine.rs` — single-char lane take in `lane`,
  slice `put_row`, `put_mark`/`mark` plumbing deleted.
- `crates/alacritty-terminal/src/grid/row.rs` — `lane_slice_from`,
  `occ_bump` now pub.
- `crates/alacritty-terminal/src/selection.rs` — `clear_of`.
- `crates/alacritty-terminal/src/term/mod.rs` — scroll paths use it.
- Held: sweep 0 divergences both arms (fails under probe 1), 824
  unit + 178 alacritty + doc tests, clippy 0 errors.

## Addendum: three more measured rejections (same day, later)

- **Dropless `put_row`, third form** (const-generic dispatch on
  `extra_free`, no per-glyph branch): unicode −6.4% 0/7. Dropless
  in `put_row` has now lost in every form tried; the assignment's
  drop check is not its cost.
- **Width carry** (next glyph's width looked up a glyph early):
  unicode −8.3% 0/7.
- **Packed row meta** (`occ`/`uniform_to`/`extra_free` in one u64,
  Row 64→56 B): −1 to −3% on everything including scroll_region.
  The rotate memmove is cache-line-bound, not byte-count-bound,
  and every `occ` access pays mask/shift.

The tree stands exactly as gated above (`tput-*.json` here);
sweep both arms, 824 unit + 178 alacritty + doc tests, and clippy
were re-run clean on it after these reverts.
- **Recycle blank reuse** (skip rebuilding the blank when the row
  already holds the canonical one): scroll_region −3.7% 0/7,
  ascii −2.3% 0/7 — the field compares cost what the rebuild did.
- **Hand memmove for rotate-by-1**: +0.4% noise. `slice::rotate_right`
  already memmoves; the +27% no-rotate scratch bound was mostly
  cache residency (the same physical row rewritten every line),
  not copy instructions.
- **64K reader hand-offs** (`CHUNK` 16K->64K): same-round gate,
  14 rounds: ascii 0.910 2/14, scroll_region 0.897 1/14 vs the
  final stack. The engine-bench chunk sweep (+3-4% from 4K to 16K)
  does not extend to 64K at the terminal. Reverted.
