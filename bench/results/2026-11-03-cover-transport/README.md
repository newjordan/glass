# Partial-scroll coverage provenance — 2026-11-03

## Finding

Text-covered cells in real sixel / OSC 1337 pictures can reappear after a
partial-region scroll, while other surviving picture cells become hidden.
`apply_moved` inferred the removed original-row count from the difference in
screen lines. A top cut may have no displacement (or a negative displacement),
and a bottom cut can have positive displacement without removing any top rows.
Neither is an original-row offset. Splits below a band also need their own
original offset even when screen geometry does not move.

## Candidate

`motion::scroll_rect_with_rows` carries transient `ScrolledRect { rect, from }`
through the existing slicing algorithm. `from` is relative to the input of this
scroll, not the original image's lifetime. Every fragment starts with the same
unsliced `Put` snapshot and crops its coverage using that explicit provenance.
Merged contiguous slices retain the first offset. The geometry-only
`scroll_rect` interface still projects the same algorithm's rectangles for the
glass-dialect caller. Nothing is added to persistent placement state.
Coverage truncation uses cell-row counts, not the previous 0.01 height tolerance.
The floating-to-u16 conversion saturates consistently with `Covers`' row domain.

## Paired result

Identical appended test source in control and candidate; original pre-existing
tests are unchanged. 2,592 cases × setup plus three scroll observations =
10,368 records per arm. Both arms pass every setup. Control fails 968 first
scroll, 520 repeated-scroll and 520 reverse-scroll observations (2,008 total);
candidate fails zero. Real wire intake covers sixel / OSC 1337, both parser
lanes, both screens, upward/downward partial scrolls, multiple offsets/heights,
and three cover masks. No test placement geometry is manually rewritten.

The Rust oracle enumerates initially visible source-cell centres and transports
individual cells. It does not call `scroll_rect`, `cut_rows`, or coverage crop
logic. `check-cells.py` independently recomputes the expected cells from the
case inputs, enforces the complete Cartesian grid and validates each pass flag.
Five Python tests reject 18 record corruptions, six invalid coordinate shapes,
duplicate JSON keys, unknown arms, and jointly forged expected/actual data.

Candidate full release test suite: 395 passed, 14 ignored. Both arms: 12,800
seeded differential streams with no divergence. Selected `target/release/glass`
remains byte-identical to the starting binary. This changes runtime *sources*,
not that selected executable. Build identities require actual non-fresh release
compiler receipts and content-preserving touches of explicit inputs. `run.py`
records exact repeat commands, exits and hashes in `runs.json`.

## Scope and retained mistakes

This is a correctness fix, not a Ghostty comparison or world-champion result.
No throughput/latency/memory measurements were made. Integer-sized pictures
only are measured here; arbitrary fractional sizes, witness relocation on
resize, arbitrary text lifecycles and full-screen history policies remain out
of scope. Current results use real text covers before scrolling, with repeated
scrolls but no post-scroll writes.

The initial harness compile used nonexistent APIs; build-control retains that
failure. The next harness compared pixel coordinates to normalized coordinates;
build-control-v2 and control-invalid-units.log retain that invalid run. Neither
is counted as a production failure. build-control-v3 is the valid control.
A zero-selected-test exploratory probe also provided no evidence. Historical
replay initially used a wrong CLI option and then needed an additional explicit
source snapshot binding. The final frozen index binds exact retained bytes;
earlier iteration files are unchanged.

## Reproduction and integrity

- `python3 -B bench/results/2026-11-03-cover-transport/check-cells.py`
- `python3 -B bench/results/2026-11-03-cover-transport/test-check-cells.py`
- `python3 -B bench/results/2026-11-03-cover-transport/verify.py`

`starting-state.json` records the starting head, tracked Rust/TOML hashes and
selected executable hash. `original-*` retain explicit changed source inputs;
`production-*` retain final tested versions. `evidence-sha256.json` freezes
explicit evidence sources. `prior-frozen-index.json` replays the prior 1,752
references / 1,729 versions using old retained snapshots without changing prior
manifests. Byte replay establishes integrity only, not experimental validity.
