# Branchless wide-cell stores — isolated and rejected

Unfinished iteration-5 candidate, measured during iteration 6. This is **not**
eight-glyph staging: it removes the width==2 store branch by writing the final
cell as a spacer first, then overwriting the glyph cell. For width one the two
addresses coincide. The existing guards constrain widths to one or two and reject
end-of-row/underlying-wide hazards; width-zero marks still take the prior path.

The bounded-channel reader was restored to its original source **before** this
candidate test executable was built. Therefore these results isolate the engine
edit and do not combine two experimental runtime changes. `engine.candidate.rs`
is the measured source; `engine.control.rs` is the selected source (including an
earlier comment correction). `candidate.patch` preserves the experimental diff.

Smallest pre-existing relevant correctness entry point:

```
cargo test --release -p glass-term plain_runs_match_the_parser -- --nocapture
```

`differential.log`: one test passed, one broader seed sweep remained ignored.
No new differential-stream count or broad-suite verification is claimed.

```
python3 -I bench/engine-pairs.py /tmp/glass-i5-control-test \
  /tmp/glass-i6-branchless-test --out engine-pairs.json --pairs 11
```

`engine-pairs.json` records frozen executable hashes, exact output, byte/read
counts and orders. Eleven balanced CPU-throughput pairs (candidate/control):

| Workload | Median ratio | Wins/11 | Two-sided sign p |
|---|---:|---:|---:|
| ASCII | 0.9924 | 5 | 1 |
| Unicode | **0.9313** | **0** | **0.0009766** |
| Truecolor | 0.9938 | 4 | 0.54883 |
| Cursor | 0.9992 | 4 | 0.54883 |
| Region | 1.0125 | 8 | 0.22656 |
| TUI | 0.9990 | 5 | 1 |

A convincing **6.9% Unicode regression**, not a gain. Exploratory sign tests
uncorrected; engine timing is diagnostic rather than terminal ranking. No
terminal or quiet-RTT gate was run for this rejected engine candidate.

The original selected engine source and selected release executable are restored.
Only the earlier explanatory comment differs from HEAD; no runtime change is
promoted. Exact selected executable SHA-256:
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
