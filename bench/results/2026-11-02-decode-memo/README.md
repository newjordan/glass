# Exact-prefix UTF-8 decode memo — rejected

Base: `8c10f2d`. Candidate is an 8 KiB, 1,024-slot direct-mapped table of
atomically published exact four-byte input tags and successful decoded scalar
and byte length. ASCII and short slice tails use the original scalar decoder;
cache misses use the same RFC-3629 validation. No width-policy changes. Source
snapshots and `candidate.patch` preserve the exact experiment.

Unlike a lead-shape table or a wider-load scalar decoder, this attempts to
reuse the result of a complete earlier validation for an identical prefix. It
does not assume well-formed terminal input. Collisions fall through to scalar
validation. This does not prove the cache hit rate was high: hit-rate sampling
was not instrumented, so the mechanism of the slowdown remains unestablished.

## Correctness

- `cargo test --release -p glass-term --locked plain_runs_match_the_parser -- --nocapture`:
  1 passed, 1 broader sweep ignored; log `differential.log`.
- `cargo test --release -p glass-term --locked utf8_decoding_matches_the_standard_library -- --nocapture`:
  1 passed, log `decoder-test.log`.

## Paired engine diagnostic

Both test executables use configured rustc 1.99.0, normal release thin LTO and
one codegen unit. Control rebuilt from the frozen source after the candidate;
9 alternating AB/BA pairs, scale 2, five internal rounds. Exact binary hashes,
workloads, read sizes and raw output are in `engine-pairs.json`.

| workload | candidate/control CPU throughput | wins/9 | sign p, two-sided |
|---|---:|---:|---:|
| ASCII | 1.0067 | 7 | .1797 |
| Unicode | **.8995** | **0** | **.003906** |
| truecolor | 1.0030 | 6 | .5078 |
| cursor motion | 1.0035 | 6 | .5078 |
| scroll region | 1.0021 | 6 | .5078 |
| TUI | 1.0086 | 5 (one tie) | .7266 |

Unicode loses 10.05% in all nine pairs. These are engine diagnostics, not a new
terminal ranking; the signs are exploratory, not multiple-test corrected. No
terminal gate or new RTT measurement is warranted for this rejected candidate.
The control engine source was restored, and the selected release executable
was not rebuilt or replaced. `selected-sha256.txt` identifies that executable.
