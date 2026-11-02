# Inlining hypothesis inspected, not established

The width-hoist release binary and test binary both retain a `cached_width`
symbol. That does not imply `Watch::print_utf8` calls it per glyph. Inspection
did not identify such a call, so the proposed causal explanation for the
engine/terminal inversion is withdrawn. `codegen.txt` records this limitation.

No forced-inline runtime candidate was built or promoted. Do not present this
directory as a benchmark result. The actual measured and rejected hoist
experiment is documented in `../2026-11-02-width-hoist/README.md`.
