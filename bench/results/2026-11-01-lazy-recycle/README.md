# The recycled-row reset, landed — verified +43% ascii, and an honest −34% unicode

Iteration 12 follow-through: the lazy recycled-row mechanism is landed,
correct, and measured, converting iteration 11's ceiling probes into code.

## The mechanism (commits 923c91e, 7176015, e20ec66)

A scrolled-in row becomes observably blank through a lazy frontier instead of
~3.7 KB of eager stores into the coldest row of the ~37 MiB ring.

- Row::recycle(template): occ = 0 + a blank (T::default() with reset(template)
  — NOT the template itself; the first version leaked the pen's flags into
  empty cells and the ctrl_l pump test caught it).
- Readers virtualize: Index<Column>, line_length, is_clear, PartialEq, serde,
  and the new Row::observable() see blanks, never stale bytes.
- Writers pay minimally: write_cell is one full-overwrite store with a
  branchless fast path; lane_cells_slice materializes only the gap left of a
  print-run write, so a left-to-right flood stores no blank it overwrites.

## Correctness surfaces closed

1. glass's clear_screen mirror walked rows with line.into_iter() — raw stale
   bytes — disagreeing with Term's virtualized walk by one row (the ctrl_l
   off-by-one). Fixed via Row::observable().
2. Reflow on resize splits/joins physical cells (front_split_off); a lazy row
   would donate stale bytes. All rows materialize at resize entry
   (-(history)..screen_lines — the first attempt used 0..len and panicked).
3. Storage::swap's 4-qword unsafe copy assumed Row = 4 words; blank makes 6,
   so it copied rows partially. Now slice::swap.
4. Serde serializes observable cells; all 45 golden ref-tests round-trip
   byte-identical (the goldens use lowercase inner/occ — one rename).
5. Wide-char handling reads under-flags through the lazy frontier and clears
   neighbors by exact address (flags_remove, occ_bump), never the tail.

Suite: 364/364 glass-term, 131/131 + 45/45 alacritty-terminal.

## Measured (interleaved A/B, one machine, 5 pairs, medians)

| workload | head | lazy | delta |
|---|---|---|---|
| ascii | 499.0 | 712.4 | +42.8% |
| ascii_lf | 339.1 | 420.3 | +23.9% |
| scroll_region | 474.6 | 513.1 | +8.1% |
| unicode | 206.8 | 136.3 | -34.1% |
| tui_frames | 264.7 | 260.7 | -1.5% |
| truecolor | 249.4 | 242.5 | -2.8% |
| cursor_motion | 226.4 | 218.3 | -3.6% |

Raw: ab-lazy4.txt (plus ab-lazy2/3 and the first cut's ab-interleaved.txt,
which showed the write path must not materialize: ascii +2% before, +43% after).

## The unicode regression, bisected but not fully attributed

- ab-cleanhead (head-exact eager reset + new write path): 168 vs head 207
  -> the write-path rewrite costs ~19% on unicode.
- ab-nolazy (eager full fill + new write path): 150.
- full lazy: 136.

The rewrite builds a 24-byte Cell off-grid and reads observable under-flags
per character; unicode pays twice per glyph (glyph + spacer). input is
deliberately #[inline(never)], so those bodies are real frames. Three recovery
attempts (branchless fast path, inline(always) on row/grid accessors,
inline(always) on write_at_cursor) did not recover it (130-140, lazy5/6/7).

Open lead: the ~19% component is the per-char Cell construction + under-flags
read replacing HEAD's bare cursor_cell() reference — not blank bookkeeping.
Next probe: a fill counter on materialize_to to rule blank fills in/out, then
a HEAD-shaped variant keeping cursor_cell() for width==1 and deferring the
write_cell path to width==2.

## For the campaign

ascii +43% is the largest verified single-lever gain of the campaign (previous
best: +7.5% hand-off fix, +2.8% run-whole). It converts iteration 11's ceiling
probes (+39/+77/+46 hazards-off) into a correct, landed mechanism at
+43/+24/+8 on the flood workloads.
