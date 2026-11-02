# Uniform-style oracle + dropless lane (2026-11-02, later same day)

Continues `2026-11-02-gate-stack` on the same uncommitted tree. That
record's "dropless rejected / cell prototype not built" section is
superseded by what follows: the drop and most of the pen stores in
the flood lane are now skipped, without changing the cell layout.

## What landed

1. **`Row::extra_free`** — a maintained bit: no physical cell in the
   row holds `CellExtra`, so a full overwrite owes no drop. Set where
   proven (fresh/scanned rows), cleared by every `&mut T` escape
   (`IndexMut` all six forms, `last_mut`, `&mut Row` iteration — the
   last two were holes in the first landing, since closed) and by
   `write_cell` when the written cell carries an extra.
   `GridCell::has_extra` (default false) is the per-type hook.
2. **Dropless `print_run`** — when the bit holds, the lane writes
   with `ptr::write`. Engine, paired 7: ascii +12.4% 7/7,
   scroll_region +4.0% 7/7, nothing down. (An earlier wiring
   silently no-opped against a differently shaped loop and measured
   only the `put_row` half; the force-dropless probe that "proved"
   coverage was not the problem was measuring that half. And probes
   ≥100 skip the lane — one A/B series was invalid for that reason.
   Both traps are now written down where the probes live.)
3. **Uniform-style prefix oracle** — `Row::uniform_to`: physical
   cells `inner[..uniform_to]` all share `inner[0]`'s style
   (`GridCell::style_eq`: fg, bg, flags, extra — everything but the
   character). No specimen is stored; cell 0 witnesses. Maintained
   by truncation at every `&mut` escape, note-after-write in the
   lanes (`note_uniform_write`, witness-based: `inner[0]` or
   `inner[end]` survives any single write), inline in `write_cell`,
   re-derived in `reset`, preserved across `recycle` (physical
   property — the stale cells keep the style the next flood writes,
   which is the point). `print_run` reads it once per slice
   (≥8-byte slices only): covered slices store the character alone
   (4 B/cell instead of 24 B), uncovered short writes truncate only
   when they restyled claimed cells (`owes_truncate`). Engine,
   paired 7 vs the extra_free stack: **ascii +54–60% 7/7,
   scroll_region +55% 7/7**, cursor/tui recovered to ~1.00 after
   the per-slice thresholds, unicode −3% (put_row pays a truncate
   per call; see rejections).
4. **`uniform_to: u32`** — Row is 64 B, not 72 B; rows move whole
   in region rotation. Engine scroll_region +2.8% 7/7, small mixed
   negatives elsewhere at engine level, gate-neutral same-round.
   Kept for the scroll memmove.

## Gate (this directory, 15 rounds, 154x39)

glass = full stack above, glass-alt = handoff tree `1690d59`,
ghostty 1.4.0. Same-round pairs vs handoff: **ascii +38% 13/15,
scroll_region +34% 15/15, unicode +11% 15/15**, truecolor/cursor
−1%, tui_frames −4% 0/15. Vs ghostty this run: truecolor 1.094
15/15 and cursor_motion 1.107 15/15 beat it; ascii 0.909 (7/15 —
inside ghostty's run-to-run spread; earlier runs of this stack
read 0.996–1.000), tui_frames 0.978, scroll_region 0.887,
unicode 0.882 still behind. Two of six clear, two near ties.

## Decomposition now (probes 0/100/104, engine, scale 1)

ascii 1681 MB/cpu-s: lane 30%, gap 38%, scan 32%.
scroll_region 1532: lane 13%, gap 58%, scan 29% — gap measured
directly: region rotate (36-row memmove) 21% of total, recycle
~1%, rest is the linefeed chain. unicode 268: lane 86%.
Bounds: killing width lookup *and* wide handling = 431 (the wide
half is most of it; a branch-only width reads the same as the
cache). Scrollback growth phase costs ~14% on ascii vs
`GLASS_SCROLLBACK=0` paired — steady-state ring/cache cycling,
not allocation (see rejections).

## Rejected after measurement (this round)

- **put_row char-only in the prefix**: unicode −20%. Per glyph
  there, decode + width + guard dwarf the pen stores; in
  `print_run` the store is the whole loop. Bisected: span
  bookkeeping alone −20%, char-only branch another −6%.
- **put_row guard-skip only**: unicode −2.3% 0/7. The guard's load
  is the same cache line the write needs.
- **Born-lazy rows** (zeroed-alloc cells via a `lazy_vec` hook;
  layout pinned by test): flat to −3%. The fill was never the
  cost; malloc count is, and min-round benches exclude growth.
- **Storage::reserve at grid creation**: gate-neutral same-round,
  3× sweep time, 10k startup allocations. No measured gain.
- **Boxed `Row::blank`** (72→56 B rows): −2% scroll, −5% unicode.
  The guard path chases the pointer per glyph.
- **BMP-split width cache**: unicode −9% 0/7.
- **print_run self-wrap** (wrapline primitives inline instead of
  one `input` per wrapped line): sweep-clean, ~0% engine.
  `Term::input` for one ASCII char is already lean.

## Remaining

- scroll_region: the region rotate memmove is the largest single
  bounded item left (21%). Beating it needs offset-indexed region
  rows (tried once at −6% terminal as a global index change) or
  smaller rows via the 8B-cell redesign.
- unicode: put_row's per-glyph wide handling. Every local variant
  measured loses; the structural answer is the same 8B cell.
- ascii/tui_frames: inside ghostty's run-to-run spread; more
  gate rounds would be needed to call them either way.

## Code

- `crates/alacritty-terminal/src/grid/row.rs` — `extra_free`,
  `uniform_to` (u32), maintenance at every escape, `uniform_covers`
  / `uniform_prefix` / `note_uniform_write` / `truncate_uniform`.
- `crates/alacritty-terminal/src/grid/mod.rs` — `GridCell::has_extra`,
  `GridCell::style_eq`.
- `crates/alacritty-terminal/src/term/cell.rs` — `Cell::has_extra`,
  `Cell::style_eq`.
- `crates/alacritty-terminal/src/grid/storage.rs` — `GridCell`
  bounds on `with_capacity`/`initialize`/`grow_visible_lines`
  (seam fix itself is gate-stack's).
- `crates/term/src/engine.rs` — dropless + char-only slices in
  `print_run`, truncate/note contract in `put_row`/`put_plain`,
  `note_uniform_span` out of line.
- Held throughout: 824 workspace unit tests, 178 alacritty tests
  (45 ref), doc tests, clippy 0 errors, sweep 0 divergences both
  arms after every change that stayed; sweep verified to fail
  under `GLASS_RUN_PROBE=1`.
