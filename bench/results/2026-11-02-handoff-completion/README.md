# Interrupted bounded-handoff gate — completed, not promoted

This closes the unfinished iteration-5 experiment; it does not promote an
optimization or establish a new selected-binary ranking.

## Treatment and provenance

`../2026-11-02-bounded-handoff/candidate.patch` changes both unbounded mpsc
channels to `sync_channel(AHEAD)`. Buffer ownership already bounds outstanding
messages; the hypothesis was that preallocated rings avoid unbounded-channel
block allocation. Reader credit recycling, read cadence, and readable-before-HUP
logic are otherwise unchanged. The three existing reader tests passed on that
candidate (`reader-tests.log` in the original directory).

The old gate was terminated after fourteen complete rounds. It remains untouched
and explicitly incomplete. `resume.py` checked the exact three executable hashes,
runner hash, three harness hashes, all 42 inherited raw results and the original
six-order schedule before copying those results into `gate/`. It ran only rounds
15–18, finishing the six permutations three times. `gate/continuation.json`
identifies the inherited source report and hashes. The interruption is a session
boundary, so this is **not an uninterrupted independent replication**.

Frozen executables:

- candidate: `3fde596986b2ef431583f949ae33ed432a6325cbc0333b3cb84916027c2d2507`
- fresh same-flags control: `eb14bd5e80f5a4cca770a4272bdd416bd05f9a11f427fbfd6633cb8685e51ce0`
- Ghostty: `ef28bf3a0f6ead69014da86ab0c9a2ef30fcf3bf297a6a27c4c18dfc80a56a62`

The Unicode edit was not in either terminal executable. It was isolated later.

## Eighteen paired terminal results

Candidate/control wall-throughput median ratios, wins, exploratory two-sided
sign-test p (uncorrected, correlated workload results):

| Workload | Ratio | Wins/18 | p |
|---|---:|---:|---:|
| ASCII | 0.9374 | 7 | 0.48068 |
| Unicode | 0.9943 | 8 | 0.81453 |
| Truecolor | 0.9939 | 8 | 0.81453 |
| Cursor motion | 1.0048 | 11 | 0.48068 |
| Scroll region | 0.9858 | 7 | 0.48068 |
| TUI frames | 0.9701 | 5 | 0.09625 |

No reliable gain; the negative ASCII/TUI medians are not individually established
regressions. No quiet RTT measurement is necessary for a rejected candidate.
Ghostty comparisons in this gate concern the rejected candidate, **not the
selected source**. Do not relabel them as a selected-source scoreboard.

`replay.log` records exact JSON-normalized replay of all computed summary fields
and all 54 raw hashes. The first ad-hoc replay assertion compared Python tuples
to JSON lists and failed on `geometry`; serialization normalization fixed the
comparison. No raw-data inconsistency was found or suppressed.

Both the bounded reader source and executable have been removed from selection.
The selected reader is byte-identical to the frozen control, SHA-256
`9569efadfca5d4568b3bde77cf08d527caccb225035ad140001c763c9a57d68b`.
The original selected executable is restored at `target/release/glass`, SHA-256
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
