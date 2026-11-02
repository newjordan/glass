# scroll_region: the swap chain is the deficit — and a fix that collects 70% of it

Iteration 16. Worktree: `/home/frosty40/glass-iter16/probe` (HEAD 7af7e5d + this change).
Patch: `rotate-region.patch` in this directory. Binaries: `glass-iter16/bin_target-head` (A), `glass-iter16/bin_rotate_clean` (B, engine bench), `glass-iter16/glass-{head,rotate}-bin` (tput).

## The question

The scoreboard's largest deficit was scroll_region: glass 467 vs ghostty 966 MB/s wall-clock (0.48x). Iteration 15 attributed it to "the 8B-cell architecture question" — an inference from CPU-second ratios, never measured. This iteration decomposed it.

## Method notes (two measurement traps, both caught)

1. Env-gated probes must cache their lookup. The first hand-rolled probe read std::env::var_os on every call: it measured its own locked-environ scan, showing "+40% skip-scroll-event". Caching the read in a OnceLock moved BASE 288->508 MB/s and shrank the apparent effect to +3%. The repo's own probes (AtomicU8 at startup) are sound; iteration 14's lane-fill +46% is unaffected.
2. A terminal-level A/B harness that silently drops stderr or argv flags returns 0 — every "0 MB/s" during bring-up was that, not a build difference.

## Decomposition (engine bench, interleaved, medians of 3)

| probe (deliberately incorrect) | scroll_region MB/s | verdict |
|---|---|---|
| HEAD | 288->508 (after fixing probe tax) | baseline |
| skip note_scroll_up entirely | +3% | scroll bookkeeping ~free |
| skip store event push | wash | store path free |
| skip sentinel folds (outer) | wash | never on this path |
| skip the region swap chain | 925 (+77%) | the deficit's home |

Engine vs terminal: engine 508 vs terminal 467 — the pipeline absorbs only ~8% of this workload. The deficit is engine-side.

## The fix

Grid::scroll_up's region branch replaced 35 Row::swap calls (one per position x region height) with one Storage::rotate_region — a single slice::rotate_right over the region's contiguous physical run, O(1) index arithmetic, each row moved exactly once. Rows move whole, so lazy-recycle occ/blank state stays with its text exactly as swaps left it. The ring's seam case (region straddling zero, possible only after full-screen scrolls moved the origin) falls back to the swap chain — rare, and always correct. A python ring-simulation proved the rotate_right equivalence before the Rust was written; the first Rust cut had the fallback's iteration order inverted (caught by ref test scroll_in_region_up_preserves_history, whose diff printer also had a latent history-indexing bug, fixed alongside).

## Result (engine bench, interleaved pairs, ROUNDS=5)

| workload | HEAD | rotate | delta |
|---|---|---|---|
| scroll_region | 516.1 | 737.1 | +42% |
| ascii | 684 (median of 5 pairs) | 688 | wash |
| ascii_lf | 449 | 422 | -5% (borderline; -3.5% exists as code-layout noise between two identical-behavior builds) |
| unicode | 203 | 207 | wash |
| truecolor | 235 | 233 | wash |
| cursor_motion | 214 | 213 | wash |
| tui_frames | 255 | 252 | wash |

Ceiling (swap chain removed entirely): 925. The fix collects ~70% of the headroom.

## Correctness

- alacritty lib: 131/131, ref: 45/45 (doctests: known E0514 stale-rlib environment issue, identical on clean HEAD)
- glass-term: 364/364, intake subset 258/258

## Status

Patch is in the worktree, not yet committed to glass main. Terminal-level tput A/B (glass vs glass-alt on Hyprland) launched; tput-*.json in this directory when it lands.
