# The recycled-row reset: ceiling probes (2026-11-02)

Iteration 11. Question: how much of the ascii/scroll parse gap is
`Grid::scroll_up`'s tail loop — the eager `Row::reset` of the recycled
bottom row(s) — rather than the sentinel/region bookkeeping the C0-inline
attribution named?

## The chain, per bottom-of-screen CRLF

`linefeed` → `note_scroll_up` (bookkeeping) → `term.linefeed` →
`grid.scroll_up(1)` → `raw.rotate_left(1)` (O(1) — three pointers, *not*
the copy) → `increase_scroll_limit` (allocates/recycles one row) →
**`Row::reset(template)` over `occ` ≈ cols−1 cells ≈ 3.7 KB of stores**,
into the row that just became the *coldest* line of a ~37 MiB ring — and
then the next output line overwrites those same cells while hot.

At 160 cols that is ~24 bytes of grid stores per input byte on the
ascii workload: a store amplification, not a parse cost.

## Probes (deliberately incorrect, opt-in via GLASS_SKIP_ROW_RESET)

All numbers: single binary, interleaved A/B pairs, A = default path,
B = probe. `cargo test -p glass-term --release`, engine bench, best-of-3
per pair; medians over pairs below. Raw pairs in `pairs-*.txt`.

### =1 — skip the reset entirely (pure ceiling)

| workload  | A: HEAD | B: skip | Δ (median) |
| --------- | ------- | ------- | ---------- |
| ascii     | 509.1   | 708.2   | **+39%**   |
| ascii_lf  | 374.0   | 660.5   | **+77%**   |
| scroll_region | 478.7 | 699.9  | **+46%**   |
| tui_frames| 270.7   | 265.7   | wash       |
| unicode   | 220.4   | 143.3   | **−35%**   |

tui_frames washing (it rarely bottom-scrolls) is the mechanism's own
control: the lever is specific to recycled-row scrolls.

### What makes unicode slower: two stale-state readers, both found

=1 leaves the recycled row's cells stale. Two readers of that state pay:

1. **Stale wide/spacer flags.** `write_at_cursor`'s "overwrite a
   fullwidth cell" branch mis-fires on every plain write (clone of
   `extra`, neighbor clears, cursor-cell re-read).
2. **Stale `CellExtra`.** Each overwrite drops a live `Arc` that a full
   reset would already have cleared — an atomic dec per cell.

Probes:

| unicode                    | MB/s (median) | vs HEAD |
| -------------------------- | ------------- | ------- |
| HEAD (full reset)          | 219.3         | —       |
| =1 skip entirely           | 143.3         | −35%    |
| =2 skip + clear wide flags | 194.8         | −11%    |
| =3 =2 + drop `CellExtra`   | **214.4**     | **−2%** |

Both hazards neutralized by measurement; what remains is a wash.

### =3 spread with hazards neutralized (still output-incorrect)

| workload      | A: HEAD | B: =3   | Δ (median) |
| ------------- | ------- | ------- | ---------- |
| ascii         | 503.7   | 579.4   | **+15%**   |
| ascii_lf      | 332.7   | 385.2   | +16%       |
| scroll_region | 475.5   | 530.3   | +11%       |
| unicode       | 215.5   | 214.4   | wash       |

=3 is *not* output-correct: stale chars/colors persist beyond the next
line's writes (short lines, clear-screen-less scrolls). It bounds what a
correct lazy/deferred reset can reach.

## Verdict

- The recycled-row `Row::reset` is the **largest single lever found in
  the campaign** (hand-off fix was +7.5%; run-whole +2.8%): a correct
  lazy-reset design is worth +11–16% on the three text workloads with
  unicode held harmless, and the naive-skip ceiling is +39–77%.
- This **supersedes** the C0-inline README's "handler work" framing for
  the plain-text workloads: within that handler work, this one reset
  dominates; the sentinel/region bookkeeping is the residue.
- Correct-design sketch for the next step: mark the recycled row
  uncleared; substitute the template on read (or materialize lazily at
  damage/read time) so `occ`/flags/`extra` stay coherent for every
  reader named above.
