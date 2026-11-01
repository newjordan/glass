# The unicode −19.5%, decomposed and 80% recovered (2026-11-01, iteration 16)

## What this closed

Iteration 15's audit left one number unexplained: engine bench unicode
was +17% while the terminal measured −19.5% — same grid changes, opposite
signs. This session built the missing binary and decomposed it.

## The mislabeled A/B, found and corrected

The audit ablation's "head" (0220628, published) vs "alt" (HEAD)
comparison spans 43 commits; only ~10 are the lazy campaign. The engine
A/B script inherited from iteration 13 had the same flaw — its "A"
worktree was at 40d7c2a (HEAD), labeled "pre". Both were re-run against
a true pre-campaign build of 963393d.

## Terminal A/B, clean machine, interleaved (tput, headless, 3 rounds)

| binary | unicode | ascii | scroll_region |
| --- | --- | --- | --- |
| 963393d (pre-lazy) | 208.1 | 428.2 | 394.4 |
| HEAD at iter-15 end | 162.0 | 546.4 | 474.6 |
| HEAD + this session | 198.7 | 570.7 | 376.0 |

- unicode −21.5% → −4.5% vs pre-lazy; the lazy campaign owns the whole
  regression (the 33 earlier commits — including the muse-contributor
  changes the operator asked about — are innocent).
- ascii's win is real and grew (+33%).
- Bisect points 7176015 / e20ec66 each carried the full −34% engine
  cost at landing; cffa9db's overwrite_cell had already reclaimed ~half.

## The residual mechanism

Per-glyph lazy bookkeeping on the UTF-8 print path:

1. overwrite_cell called materialize_to(col) per glyph — an Option
   check, two min/cmp and a branch, on the col == occ case that every
   left-to-right run hits (the store itself makes the cell physical).
2. The wide-char guard read virtual_cell twice per glyph even when the
   run writes over the lazy blank, which cannot carry wide flags.

## The two cuts (both landed)

1. overwrite_cell fast path: col == occ && blank.is_some() → store
   directly, bump occ, return; no materialize call.
2. put_row guard hoisted per run: a run starting at/past the lazy
   frontier writes over the blank, so guard_from = 0 and the per-glyph
   test never fires; non-lazy rows keep guarding every column.

Engine A/B (unicode, 5 pairs, medians): prelazy 220.6 vs HEAD 205.9 →
−14% at session start became −5% after both cuts.

## Negatives (measured, honored)

- Grid re-index hypothesis DEAD: the row-borrow rewrite alone was a wash
  engine-side (first measured against pre-fix HEAD by the mislabeled
  script, then re-run correctly).
- Render path exonerated: cells()/paint read the same rows for ascii,
  which improved through the same readers.
- A first cut of the guard hoist (unwrap_or(0)) dropped the guard on
  non-lazy rows entirely — the escapes/plain differential caught it
  before commit (364/364 after the fix).

## Raw

- Terminal pairs: tput-glass*.json in this directory (results-fix2)
- Engine pairs: harness logs 11920–11923 (ab-engine3/4/5)
- Bisect binaries: prelazy, lazy717, wc66 (glass-iter16/)
