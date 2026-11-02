# Handoff 2 — 2026-11-02 (later)

Continues `2026-11-02-handoff`. One performance commit plus this
handoff on `main`, on top of `1690d59`. **Still nothing pushed**
(44+ commits ahead of `origin/main` — see Next). Repo still private.

## State

- `cargo build --workspace --all-targets --locked` — clean
- `cargo test --workspace --lib --bins --locked` with CI's skips —
  **824 passed, 0 failed**; `cargo test -p
  glass-alacritty-terminal --locked --tests` — **178 passed** (45 ref)
- `cargo test --workspace --doc --locked` — clean
- `cargo clippy --workspace --all-targets --locked` — **0 errors**
- `plain_runs_match_the_parser_over_seeds` — 25,600 streams, both
  run-whole arms, no divergence; still fails under
  `GLASS_RUN_PROBE=1` as it should
- **Unverified locally:** same as before (MSRV toolchain, packaging)

## What landed

Details and raw gate JSONs in `2026-11-02-gate-stack`,
`2026-11-02-uniform-oracle`, and `2026-11-02-lane-singles`.

1. **The deferred hard problems, done.** Lazy sentinel fold in
   `note_scroll_up` (with the liveness replant the first version
   missed — the sweep found it at seed 10), the C0 gap fast path
   with both guards the handoff specified, a full-codespace width
   cache, template lane writes, the full-damage short-circuit, an
   8K scroll-count chunk. Plus a pre-existing seam-rotation bug
   (swap chain only correct for `positions == 1`) found and fixed
   with a test that fails on the old code.
2. **The uniform-style oracle.** `Row::extra_free` (dropless lane
   overwrites via `ptr::write`) and `Row::uniform_to` (physical
   prefix sharing `inner[0]`'s style, witnessed — no stored
   specimen). Covered flood slices store 4 B/cell instead of 24 B.
   Engine, paired: ascii +54–60%, scroll_region +55%.
3. **Lane singles.** One printable cell between SGR sequences goes
   through `put_plain`, not `print_run`'s whole setup:
   **tui_frames converted** (1.025x, 14/15) and truecolor widened.
   `put_row` rewritten on one row slice (marks break to the
   existing fallback; `put_mark` and the Engine/Watch `mark`
   plumbing deleted). `Selection::clear_of` lets region scrolls
   skip selection rotation when the sentinel sits clear.

## Gate, final, 15 rounds paired at 154x39

| metric | vs ghostty | rounds | vs handoff tree |
|---|---|---|---|
| truecolor | **1.153x** | 15/15 | +2.5% |
| cursor_motion | **1.094x** | 15/15 | −0.5% |
| tui_frames | **1.025x** | 14/15 | +2.6% |
| ascii | 0.952 paired | 6/15 | +37% |
| scroll_region | 0.929x | 4/15 | +38% |
| unicode | 0.877x | 0/15 | +11% |

**3 pass, 1 tied inside ghostty's own spread, 2 behind.** It was
2 pass, 1 tie, 3 behind. ascii's glass median is the higher of
the two (1032 vs 884), but the paired median is 0.952 and wins
only 6/15 — ghostty's ascii median swung 884–1130 across the
day's gates while glass held 1000–1050. Do not call ascii either
way without more rounds.

## Do not redo these

Everything in the first handoff still holds, plus, all paired
with sign tests (numbers in the round records):

- **Deferred region rotation** (logical shift in
  `compute_index`, normalized before any structural op): engine
  scroll_region +9–11%, gate scroll +0–3%, truecolor −1.4 to
  −3.3% at 0/15 both times. Every per-character row index pays
  for it. Built and gated twice.
- **Dropless `put_row`** in three forms (branch, precheck,
  const-generic dispatch): unicode −2 to −20%. The assignment's
  drop check is not its cost; `print_run`'s dropless win does
  not transfer.
- **Width games**: BMP-split cache −9%, BSS static cache −1 to
  −3%, next-glyph width carry −8.3%, branch-only widths tie the
  cache. The historic "width = 23–44%" bounds conflate wide
  handling and scroll frequency: skipping the spacer measures
  0%, and lying about widths changes how often lines wrap.
- **Row-size games**: packed meta word (64→56 B) −1 to −3%
  everywhere, boxed blank −2/−5%, born-lazy zeroed rows flat to
  −3%, upfront scrollback reserve gate-neutral. The rotate is
  cache-line-bound; a hand memmove ties `rotate_right`, and the
  old +27% no-rotate bound was cache residency of the rewritten
  row, not copy cost.
- **Recycle blank reuse** −3.7% scroll (the compares cost what
  the rebuild did), **print_run self-wrap** ~0%, **64K reader
  hand-offs** −9/−10% same-round (the 4K→16K engine chunk win is
  already the shipped 16K).

## Measurement rules (additions)

- **Probes lie by construction three ways**: `GLASS_RUN_PROBE`
  ≥100 skips the lane (readings were lane-skip ceilings),
  bounds that change widths change scroll frequency, and
  removing a scroll makes the same physical row hot forever.
  Ship-form paired A/B or it didn't happen.
- **An edit that silently doesn't match measures beautifully.**
  One dropless wiring no-opped against a differently shaped
  loop and produced a full, plausible A/B series. Grep the
  landed code for the thing you meant to change before benching.
- Engine ↔ terminal transfer discounts floods by roughly half
  once apply stops being the bottleneck (ascii: ~1800 MB/cpu-s
  engine, ~1040 MB/s through the pty).

## Next

1. **Push.** Still the first item from the last handoff, now
   with more commits CI has never seen.
2. **The cell/page redesign is the remaining structural lever.**
   Bounded pieces: region rotate ≈21% of scroll_region engine
   time (mostly cache residency of cycled rows), unicode ≈86%
   `put_row` with the template assignment bounded at ~5%. An
   8–16 B Copy cell with styles/extras in side storage attacks
   both; scoped in `2026-11-02-uniform-oracle` (34 `.extra`
   sites, cursor-template and serde consequences). It will not
   flip unicode alone (+5% bounded there) — pair it with the
   branchless table-driven per-character work the first handoff
   calls for, or accept unicode as the known deficit.
3. **More ascii gate rounds** before claiming that metric in
   either direction; its noise is ghostty-side.
