# Row-writer call-boundary ablation — rejected

A leaf CPU profile of the exact selected executable placed 435/547 Unicode
parser samples in `Watch::print_utf8`. The existing table decoder, decode memo,
glyph batching, width and stride candidates are not repeated here. This distinct
experiment only changes `put_row` from `#[inline(always)]` to `#[inline(never)]`.
No UTF-8 validation, widths, stores, cursor state or parser behavior changes.

**Decision: reject.** The existing `speed::plain_runs_match_the_parser` passed
one release test. Eleven alternating AB/BA engine pairs (scale 2, five internal
rounds, sequential with no terminal benchmarks/builds overlapping) gave:

| Workload | Median candidate/control CPU throughput | Wins / 11 |
|---|---:|---:|
| ASCII | 1.00995 | 9 |
| Unicode | **0.99123** | **3** |
| Truecolor | 0.99702 | 4 |
| Cursor motion | 0.99578 | 4 |
| Scroll region | 1.00239 | 6 |
| TUI frames | 0.99048 | 4 |

Unicode did not benefit, so there was no terminal promotion gate. The small
ASCII engine gain is neither a dependable terminal gain nor a reason to ship
this change. Exploratory sign tests are in `engine-pairs.json`; they are not
corrected across six metrics, and these data do not prove a universal loss.

Sources and receipts:
- `engine.control.rs`, `engine.candidate.rs`, `candidate.patch` (one attribute).
- `control-build.jsonl`, `control-build.log`, `candidate-build.jsonl`,
  `candidate-build.log` (same compiler/profile/locked dependencies).
- `differential.log` (existing pre-change project test, one pass, zero failures).
- `engine-pairs.json`, `engine-pairs.log` (all eleven pairs and binary hashes).
- `restoration.json` (exact source and selected executable identity).
- `evidence-sha256.json` (explicit artifact hashes).

Runtime source restored byte-for-byte to commit
`68f18dd66fd1bfc917e50689aa4dc3443cd28e0e`.
The exact selected release executable remains SHA256
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`;
no rebuilt binary was substituted. No championship or all-metric win claim.
