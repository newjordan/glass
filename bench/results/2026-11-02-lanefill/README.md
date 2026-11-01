# The lane's left-edge fill: ascii_lf's remaining 41%, pinned (2026-11-02)

## Where this sits

Iteration 12 landed the lazy recycled-row mechanism; iteration 13 routed
the UTF-8 print paths through `overwrite_cell`. This session re-measured
the ceiling those landings left open, on HEAD (cffa9db), interleaved
A/B, single binary, medians over 4 pairs (headroom-pairs.txt):

| workload  | landed | ceiling (GLASS_SKIP_ROW_RESET=1) | headroom |
| --------- | ------ | --------------------------------- | -------- |
| ascii     | ~700   | ~706                              | ~0       |
| ascii_lf  | ~437   | ~616                              | ~41%     |
| scroll_region | ~510 | ~514                              | ~0       |

ascii and scroll_region are fully collected; ascii_lf alone retains
41% of the recycled-row headroom - the bare-\n shape logs, hexdump and
yes(1) write.

## Fixing the census first

The fill census's width histogram was dead: materialize_to logged its
site but never the width, so every direct caller landed in "other" with
no shape. Fix at the materialize_to site (row.rs): the width histogram
now counts stop - start for every fill. With it wired, the census names
the residual on ascii_lf (2 rounds, scale 0.25):

    fill-census: notes=652821 cells=10536115
    widths: w0=318416 w1=264595 ... w17+=(69810 ...)
    fill-sites: ... lane 90474|68228  other 228855|201441  (no-fill|filled)

~35k fills of ~147 cells each per round (5.1M blank-cell clones; ~150 MB
of stores per round). ascii, the control, has exactly ONE w17+ fill in
two rounds. Wiring the lane bucket (site 4, in lane_cells_slice)
confirms the lane owns it: 68,228 lane fills, of which the big ones are
exactly one per line.

## The mechanism

A bare \n at the bottom does not reset the column. So each line of
ascii_lf opens with a 1-2 cell run at the far right edge of the freshly
recycled row (occ = 0): the lane's materialize_to(column) pays ~cols-1
blank clones (~3.7 KB at 154 cols) to overwrite one cell - and the
ragged edge of the staircase never overwrites those blanks: the fill is
100% dead work, per line.

\r\n lines (ascii) never see it: the CR puts the continuation run at
col 0, where materialize_to(0) fills nothing.

## The ceiling probe

GLASS_SKIP_LANE_FILL=3 (new, deliberately incorrect, same family as the
other ceiling probes) skips the lane's left-edge materialization. Same
binary, interleaved, 4 pairs (lanefill-pairs.txt):

| workload | A: fill (HEAD) | B: skip | delta median |
| -------- | -------------- | ------- | ------------ |
| ascii_lf | 374.0          | 545.8   | +46%         |
| ascii    | 670.1          | 665.6   | wash (control) |

The probe's +46% accounts for the remaining headroom measured against
the skip-everything ceiling (+41%): within a few percent, all of it.

## The fix it points to

A hole in the lazy frontier: when a lane run starts at column > occ on a
recycled row, write [column, end) physically while [occ, column) remains
observably blank - instead of materializing it. virtual_cell already
resolves reads correctly for any column (blank when past occ, physical
otherwise); the change is local to lane_cells_slice and materialize_to.
The blank retires only when occ == len.

Design notes:

- The staircase's ragged edge stays blank forever (the visible line is
  line[0..153]), so the hole's cells are never written later either.
- overwrite_cell (UTF-8 paths) pays the same dead fill at the same shape
  and gets the same treatment for free.
- The raw-slice readers (into_iter, Index<Range...> READ arms - which do
  NOT materialize - and the scanners) still see stale bytes in the hole;
  the observable readers (virtual_cell, observable()) are already
  correct. The lane returns virtual_from = occ as today, and the
  caller's wide-guard treats the hole as blank - which it is.

## Raw pairs

- headroom-pairs.txt - landed vs GLASS_SKIP_ROW_RESET=1 on HEAD
- lanefill-pairs.txt - fill vs GLASS_SKIP_LANE_FILL=3
