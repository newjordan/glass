# Width-cache initialization hoist: engine/terminal reversal

Source: `f920961c8b459385f73eb171c9c2c8a71b5d6347`; normal release build,
configured rustc 1.99.0. All real-terminal rounds 154 x 39 on the local
9950X3D / RTX 3090 / Linux / Hyprland system.

## Candidate

`candidate.patch` extracts `width_cache()` and `cached_width()`, obtains the
same atomic-cache slice at row entry, and calls the latter inside `put_row`.
`width_of` remains the wrapper for other callers. Cache values, relaxed
memory ordering, `unicode-width` fallback and malformed-input behavior are
unchanged. It removes a per-glyph `OnceLock::get_or_init` check from the source
loop without replacing the width algorithm.

Existing checks: parser comparison passed; exhaustive
`engine::tests::width_cache_agrees_with_the_crate_everywhere` passed for every
Unicode scalar on first and second lookup. See `parser-test.log`,
`width-test.log`. No broad correctness claim beyond those checks is made for
this rejected candidate.

## Engine diagnostics

11 alternating pairs; scale 2, five rounds inside each process; retained raw
output and executable hashes in `engine-pairs.json`.

| workload | candidate/control CPU-throughput ratio | wins | sign p |
|---|---:|---:|---:|
| ASCII | 1.0819 | 11/11 | .000977 |
| Unicode | **1.0298** | **11/11** | **.000977** |
| truecolor | 1.0135 | 9/11 | .0654 |
| cursor motion | 1.0078 | 8/11 | .2266 |
| scroll region | 1.0000 | 5 wins, 5 losses, 1 tie | 1 |
| TUI frames | .9984 | 5/11 | 1 |

## Completed terminal gate

18 rounds, all six launch permutations repeated three times. Candidate
`/tmp/glass-width-hoist-bin`, control `/tmp/glass-cache-selected`, Ghostty.
`gate/terminal-summary.json` includes binary and harness hashes, every raw JSON
hash, geometry, medians, paired ratios and exact two-sided sign tests.

| workload | candidate/control | wins | candidate/Ghostty | wins |
|---|---:|---:|---:|---:|
| ASCII | .9744 | 6/18 | .9034 | 7/18 |
| Unicode | **.9346** | **0/18** | .8984 | 1/18 |
| truecolor | 1.1233 | 18/18 | 1.3216 | 18/18 |
| cursor motion | 1.0204 | 18/18 | 1.1377 | 18/18 |
| scroll region | 1.0057 | 10/18 | .9268 | 6/18 |
| TUI frames | 1.0227 | 15/18 | 1.0781 | 17/18 |

The **6.54% Unicode loss in all 18 pairs** has p=.00000763. The large
truecolor gain and movements on untouched paths show that binary-wide changes
can accompany this source refactor. They do not license claiming width work
was reduced on every workload, or explain the Unicode sign inversion.
The sign tests are exploratory and uncorrected for multiple comparisons.
Ghostty had several severe low outliers; all rounds remain included, not
filtered. No generalization to another build, machine or terminal is claimed.

## Code-generation hypothesis explicitly NOT established

The release and engine-test executables both retain a `cached_width` symbol.
Initial suspicion that the release glyph loop calls an out-of-line helper
was not supported by callsite inspection. A symbol alone does not prove such
a call. The short correction is retained in `../2026-11-02-width-inline/`.
Do not turn that hypothesis into a finding or repeat it as the explanation.

## Decision

Rejected, runtime source restored. No real-terminal Unicode gain. This is a
new measured counterexample to promoting an engine-only 3% improvement.
