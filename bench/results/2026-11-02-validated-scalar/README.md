# Eliminate duplicate Unicode-scalar validation — not promoted

Base runtime: `8c10f2d`. The fused UTF-8 decoder already restricts C2..DF,
E0/ED second bytes, F0/F4 second bytes and all 80..BF continuations. Those
conditions prove the decoded value is a scalar, making `char::from_u32`'s final
range/surrogate check logically redundant. Candidate replaces only that final
call with `from_u32_unchecked`, with a local safety argument. No malformed
input is newly accepted. The original checked implementation is retained in
selection because measurements do not justify introducing this unsafe operation.

Both arms carry identical three new tests from the SSE2 study. Normal release
flags and configured rustc 1.99.0. Snapshots preserve exact measured source;
`candidate.patch` contains the isolated runtime change before test additions.

## Correctness

`decoder-tests.log`: two decoder tests passed, including every valid scalar,
every truncated encoding, boundary-form mutations, and the old random/mutated
standard-library oracle. `boundary-tests.log`: two scanner tests passed;
`differential.log`: parser differential test passed. These are candidate tests;
final selected tests appear in the adjacent SSE2 report.

## Measured effect

Eleven alternating AB/BA engine pairs, scale 2, five internal rounds:

| workload | candidate/control CPU throughput | wins / non-ties | sign p |
|---|---:|---:|---:|
| ASCII | .9925 | 5/11 | 1 |
| Unicode | 1.0130 | 9/11 | .06543 |
| truecolor | 1.0003 | 6/11 | 1 |
| cursor | .9996 | 5/11 | 1 |
| region | 1.0122 | 9/11 | .06543 |
| TUI | .9951 | 5/11 | 1 |

Nineteen focused Unicode replication pairs, scale 5, seven internal rounds:
**1.01153**, 13 wins / 5 losses / 1 tie, two-sided sign p **.09625**.
`engine-pairs.json` and `unicode-replication.json` retain frozen executable
hashes, exact outputs and read/workload compatibility checks.

The direction is mildly encouraging, but remains small and mixed under this
measurement. Post-selection repetition is not a confirmatory p-value; no
multiple-test correction or cache/branch attribution is claimed. No terminal
or RTT gate: this was not promoted on engine evidence alone. Restore the
original checked scalar construction; keep the exhaustive tests instead.
