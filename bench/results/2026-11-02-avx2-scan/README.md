# Long-suffix AVX2 dispatch — not selected

Base `8c10f2d`. Runtime AVX2 dispatch only for suffixes of at least 64 bytes;
short/escape-heavy inputs and unsupported hosts use baseline SSE2. The backward
run search is unchanged. Forward scan consumes complete 32-byte blocks and
returns exact first-control and high-bit classification; no out-of-slice load.
Source snapshots and patch are retained.

## Correctness and first-command error

The first `next_run` test filter matched zero tests (`scanner-test.log`) and
is **not correctness evidence**. Exact corrected invocations of
`engine::tests::text_runs_end_where_a_byte_at_a_time_scan_ends` and
`speed::plain_runs_match_the_parser` each passed one test. See
`scanner-test-corrected.log` and `differential.log`. No broad sweep claimed.

## Nine paired engine diagnostics

Both release executables use configured rustc 1.99.0 and identical workspace
release flags. Alternating AB/BA, scale 2, five internal rounds; binary hashes,
raw outputs and all ratios are retained in `engine-pairs.json`.

| workload | candidate/control CPU throughput | wins / non-ties | sign p |
|---|---:|---:|---:|
| ASCII | 1.0396 | 7/8 | .07031 |
| Unicode | .9773 | 2/9 | .17969 |
| truecolor | 1.0057 | 5/8 | .72656 |
| cursor | 1.0055 | 6/9 | .50781 |
| region | 1.0447 | 7/9 | .17969 |
| TUI | 1.0195 | 6/9 | .50781 |

Mixed and inconclusive, with Unicode in the wrong direction. Not a terminal
ranking. No terminal run or RTT gate performed for this candidate. No AVX2
compiler default or machine-specific release flags were added. Runtime source
restored before the subsequent SSE2-only unroll experiment, which separates
wider dispatch from the possibility of loop unrolling.
