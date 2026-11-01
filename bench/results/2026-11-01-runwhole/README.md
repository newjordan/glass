# The run applies whole: measured (2026-11-01)

## What changed

- `GLASS_RUN_WHOLE=1` (engine.rs) applies a run lane's whole run, holding
  no character back for the parser, and syncs glass's REP character into
  vte's private `preceding_char` after every lane write.
- vte 0.15.0 vendored at crates/vte with one addition:
  `Processor::set_preceding_char`, so a REP the *parser* completes after
  lane-written text (a sequence split across reads, e.g. `\x1b` then
  `\x1b[b`) repeats what the stream printed, not a stale char.
- `Watch.preceding` was per-chunk (`None` each feed); it is now carried on
  the Engine as `preceding_char` across chunks — the parser's
  `preceding_char` outlives a read, and the lane's copy must too.

## Three divergences the shrinker found (all fixed)

1. 24 pure-ASCII bytes: the run-whole branch computed `took` without ever
   calling `print_run` (the candidate's own first draft; no lane writes).
2. "漢字漢字漢字漢字\x1b\x1b[b": REP split across reads, completed by vte
   with its stale `preceding_char` → vendored-vte setter.
3. "\x1b[fXK\x1b[m\x1b\x1b[b": REP after the *escape lane's* between-text
   path, which never synced vte's copy → sync there too.

Delta-minimal repros live in the shrink tests (`shrink_run_whole_divergence`,
`shrink_escapes_divergence`); all 364 term tests green both modes.

## Measured, interleaved A/B, one binary (ab.log)

ascii 524.3 → 538.9 MB/s median (+2.8%); ascii_lf +1.0%; scroll_region wash.

## What this says about the 43%

The iteration-8 budget attributed 43% of ascii to byte-at-a-time vte
advance at run gaps, avg one byte per call. Un-holding removes one byte
from each call but keeps every call: the collected win is ~3%, so the
share is *per-call* cost, as the budget said — the call count is the
remaining lever, not the bytes each carries. Gap-call elimination (batching
the C0 between runs, or lane-taking the gap) remains the open mechanism;
probe 6 already showed routing the gap's printables through the lane is a
loss, so the call-count reducer must not re-enter print_run per gap.
