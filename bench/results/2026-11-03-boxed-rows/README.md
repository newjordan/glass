# Boxed physical rows: a region gain with repeatable Unicode/ASCII losses

Reported research, not a runtime promotion. Local date 2026-11-02, UTC
2026-11-03. Start HEAD `1661f5a`. Shared Ryzen 9 9950X3D / RTX 3090 Linux host.
No Ghostty measurement in this experiment. See the separate row-alignment gate
for the subsequent distinct candidate, terminal comparison, and final checks.

## Candidate and provenance

`storage.candidate.rs` / `candidate-with-test.patch` change physical storage
from `Vec<Row<T>>` to `Vec<Box<Row<T>>>`. Allocation/reallocation box each row;
indexing dereferences it; region rotation moves pointers. Reflow's existing
owned-row interfaces are preserved by boxing/unboxing `replace_inner` and
`take_all`. No unsafe code. Test fixtures use a boxed construction helper.
The trial trades 64-byte row moves for 8-byte pointer moves but adds a dependent
load at lookup and one allocation per physical row. It does NOT isolate those
costs from allocator placement, cache effects, and compiler code layout.

`start.json` freezes all 120 Rust sources and the selected release hash before
editing. `storage.start.rs` is original; `storage.control.rs` adds only the
first version of the rotation model test. Both test executables were built
with the same locked release configuration, without custom RUSTFLAGS/PGO.
`control-build-final.*` and `candidate-build.*` retain build receipts;
`engine-pairs.json` retains executable hashes and every arm's output.

## Engine measurements

11 alternating A/B pairs, scale 2, five internal rounds, six unchanged speed
workloads; CPU ratios are candidate/control median paired MB/cpu-s ratios.

| workload | CPU ratio | wall ratio | CPU wins/losses | unadjusted sign p |
|---|---:|---:|---:|---:|
| ascii | 0.987488 | 0.986991 | 0/11 | 0.0009765625 |
| unicode | 0.947979 | 0.947862 | 0/11 | 0.0009765625 |
| truecolor | 1.004242 | 1.003932 | 8/3 | 0.2265625 |
| cursor_motion | 1.005399 | 1.005407 | 8/2 (one tie) | 0.109375 |
| scroll_region | 1.077415 | 1.077499 | 11/0 | 0.0009765625 |
| tui_frames | 1.011707 | 1.011393 | 8/3 | 0.2265625 |

Wall ratios above are rounded summaries; exact raw arithmetic is in JSON.
The engine run is not through a real terminal PTY and is not a scoreboard.
The region benefit is useful evidence that this structural tradeoff has
headroom, not proof that copying 56 fewer bytes explains all of it. Reject:
Unicode -5.20% and ASCII -1.25% are unacceptable for the all-metric objective.
No terminal benchmark was spent on this already-regressing candidate.

## Correctness and execution issues retained

The control storage filter passed 16 tests. Boxed rows passed 137 library
tests with serde and `speed::plain_runs_match_the_parser` (1 test). The boxed
run used the INITIAL rotation model test; the strengthened final test is not
retroactively claimed for this reverted candidate. Final restored-source
coverage is in the row-alignment directory.

Command mistakes are retained rather than passed off as success: first used
`-p alacritty_terminal` instead of the package name, then `--lib` for the
binary-only glass-term package; neither produced a measured control. One
existing map-based test fixture needed a boxed conversion, caught by compile.
`candidate-fmt-check.log` also reports existing unrelated formatting changes;
no broad formatting rewrite was applied. Only the subsequent successful
builds were measured.

Runtime boxing is removed. The exact selected release executable remains
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.

Replay (while the retained /tmp binaries still exist):

```
python3 -I bench/replay-engine-pairs.py --verify-binaries --pairs 11 \
  bench/results/2026-11-03-boxed-rows/engine-pairs.json
```

Without `--verify-binaries`, replay still validates retained raw results,
shape, alternating order, parsed rows, and summary arithmetic after those
non-durable executables are gone; it cannot then rehash the executables.
