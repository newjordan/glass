# unicode's 44%: not work, codegen — the variable stride in `put_row`

Iteration 24. A measurement loop. **No speedup landed**; what it produced is a
localisation, a mechanism, and six dead ends that need not be retried.

## The ceiling

`put_row`'s width block replaced by the constant `1` (compiled in, no runtime
branch) runs `unicode` **+44%** (224.5 -> 323.9, engine, scale 0.5). An earlier
runtime probe put this at +23%; that probe cost 3.5% itself as a
per-character branch and was taxing both of its own arms. +44% is the number.

## What it is not

Each ablated alone, compiled in, measured against an alternated control:

| ablation | unicode | effect |
|---|---|---|
| skip the spacer cell write | 219.3 | none |
| skip the second guard read | 223.8 | none |
| **skip the whole wide-char flag guard** | 224.8 | **none** (base 224.8) |
| **skip the main cell write entirely** | 226.9 | **none** |
| split the one- and two-cell arms by hand | 225 | none (base 226) |
| 4 KiB width table over U+0000..U+0FFF, built from the crate | 217 | none (control 217) |
| Latin-1 answered by branch instead of lookup | 211.6 | **-6%, and incorrect** |
| width looked up one iteration early, off the dependency chain | 212.1 | **-4%** |

Removing the cell write *completely* changes nothing, so the stores are free.
The crate's own lookup is already as fast as a flat array. The Latin-1 branch
disagreed with the crate inside U+0000..U+0100 and an exhaustive equivalence
test caught it before it could reach a screen.

## What it is

With `GLASS_PARSE_TIMERS=1`, base against the width-1 build:

| | base | width = 1 |
|---|---|---|
| apply calls | 6150 | 6150 |
| print_run calls | 237,531 | 237,531 |
| print_run bytes | 23,763,141 | 23,763,141 |
| **print_run ms** | **83.17** | **50.02** |
| vte ms | 24.88 | 24.57 |

Identical calls, identical bytes, identical parser time: the entire 40% is
inside the loop body. Nothing is being skipped — the same instructions are
being scheduled better.

`column += width` is a **data-dependent stride**. It makes the loop's
induction variable non-affine, which blocks unrolling and software pipelining
of the whole body, not just the advance. Splitting the arms by hand does not
help because `column`'s loop-carried update stays variable whichever arm runs;
hoisting the lookup does not help because the lookup was never the problem.

## The one direction the evidence supports

A **stride-1 inner loop over a maximal run of one-cell characters**, leaving it
to the general path when a wide character appears. The stride is then a
constant inside the inner loop and the induction variable is affine. This is
the shape `print_run` already has for pure ASCII
(`cells.iter_mut().zip(&run[..n])`), so the pattern is in the codebase; the
mixed-width path simply has no equivalent.

83% of this workload's characters are one cell wide (57% ASCII, 26% narrow
non-ASCII, 17% wide), in runs averaging about six, so the inner loop would
carry most of the characters and re-enter roughly every sixth. Whether six is
long enough to pay for the switch is the open question, and it is measurable
before it is built: the width-1 ablation is the upper bound at +44%.

## Correctness

700/700 tests (glass-term 364, alacritty 177, glass-window 128, vte 31), and
the 25,600-stream differential sweep clean in both run-whole arms, at base.

## The stride-1 loop, built and measured: a wash

Iteration 24b. The direction this document recommended was built: an outer loop
alternating a stride-1 inner loop over one-cell characters with a single
general step for a wide or zero-width one, so a lone CJK glyph does not strand
the rest of the run. `column` advances by exactly 1 inside the inner loop, so
its induction variable is affine.

Correct — 25,600 streams in both run-whole arms, 700/700 tests — and **a wash**:

| | base | stride-1 |
|---|---|---|
| unicode | 225.3 | 223.0 |
| ascii | 825.0 | 828.4 |
| truecolor | 272.4 | 276.6 |
| cursor_motion | 254.9 | 255.6 |
| scroll_region | 854.9 | 862.3 |
| tui_frames | 296.6 | 295.5 |

Medians of 3 alternated pairs. Reverted.

## What the seven failures together say

The affine-stride reading was wrong, or at least incomplete. The inner loop
still has to *decide* that a character is one cell wide, which keeps the width
lookup and its branch inside the loop. Compiling the width in as `1` deletes
far more than the advance: the lookup, the zero-width branch and `put_mark`
with it, the `_ => break`, the spacer block, the flags conditional and the
general advance arithmetic — several data-dependent branches collapsing at
once, on a workload whose characters are 83/17 narrow to wide and so
unpredictable.

That is consistent with every result here: no single ablation moves anything
because no single branch is the cost; the lookup's *implementation* does not
matter (the table was a wash) because it is the branch on its result, not the
load, that is paid; hoisting it one iteration does not help because the branch
still lands where it did; and splitting or nesting loops does not help because
both keep the decision.

**Capturing the 44% needs per-character work with no data-dependent branches at
all** — a table-driven, branchless cell write — not a restructuring of the
current decisions. That is a different algorithm, not an iteration of this one.

For the release gate this is the load-bearing conclusion: **unicode's +27% is
not reachable incrementally.** Seven targeted attempts, all measured, none
worth keeping.
