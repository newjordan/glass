# Fused single-mark overwrite prototype — shelved before timing

Prospective 12-pair protocol in `protocol.json`; no performance sessions ran.
The prototype changed cell/engine sources in place without changing `Cell`
layout. `first-edge.log` passed the existing Unicode row-edge test. The direct
upstream Term oracle in `direct-term.log` failed on split input. Repeating the
oracle on unchanged engine runtime (`direct-term-control.log`) failed at the
same byte cut: `a\u{308}b\u{301}z`, split after `a` and the mark's lead byte,
lost `b`. Thus this failure was not attributable to the fusion candidate.

The original/candidate source snapshots are retained. Both speculative runtime
changes were removed. The new direction isolates and repairs the inherited
partial-UTF8 scratch-buffer consumption bug; see
`../2026-11-03-partial-utf8-accounting/README.md`. No estimate of fusion speed,
causality, correctness or Ghostty superiority is made. Candidate remains shelved.
