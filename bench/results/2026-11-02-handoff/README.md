# Handoff — 2026-11-02

Six commits landed on `main` tonight, `03b1eb8`..`483b43a`. **42 commits ahead
of `origin/main`, nothing pushed.** Repo is still private.

## State

- `cargo build --workspace --all-targets --locked` — clean
- `cargo test --workspace --lib --bins --locked` with CI's own skips — **821
  passed, 0 failed**
- `cargo clippy --workspace --all-targets --locked` — **0 errors** (it would
  have failed before tonight; see `2b9d4f9`)
- `plain_runs_match_the_parser_over_seeds` — 25,600 streams, both run-whole
  arms, no divergence
- **Unverified locally:** the MSRV job (needs a 1.95 toolchain, not installed)
  and the packaging job (needs `shellcheck`; only `desktop-file-validate` is
  here)

## What landed

1. **The crash.** `Preparing` detached the GPU thread; `process::exit` then ran
   NVIDIA's `atexit` teardown over a thread still inside `vkCreateInstance`.
   16 core dumps over two days, five command lines, several of them valid bench
   runs. Reproduced and verified gone.
2. **run-whole on by default**, +3 to +7% engine, 24 of 24 A/Bs positive.
3. **The lane's one-character floor**, which run-whole made stale:
   **truecolor 1.00x → 1.10x against ghostty, 9 of 9, disjoint ranges.** One
   gate metric converted.
4. **CI unbroken** — six clippy errors `#![cfg_attr(clippy, deny(warnings))]`
   makes fatal.
5. **Docs tell the truth** — the table carries all four terminals and says
   outright where ghostty is ahead.
6. **Two tools**: the seed sweep (strictly stronger than the fixed-seed gate —
   it finds cases the gate passes) and `shrink_sweep_divergence`, which cut one
   divergence from thousands of bytes to 39 in a single run.

## Gate, measured at 154x39 on a free GPU

| metric | glass | ghostty | | evidence |
|---|---|---|---|---|
| truecolor | 262.4 | 238.8 | **1.10x** | 9/9 disjoint |
| cursor_motion | 239.3 | 217.8 | **1.10x** | 9/9 disjoint |
| tui_frames | 3792 | 3807 | 1.00x | 4/9, overlapping — a tie |
| unicode | 222.9 | 282.6 | 0.79x | 0/9 |
| ascii | 703.3 | 1102.1 | 0.64x | 0/9; ghostty read 959, 1071, 1102 across three runs |
| scroll_region | 757.1 | 1155.9 | 0.65x | 0/9 |

**2 pass, 1 tie, 3 behind.** It was 1 pass, 1 tie, 4 behind.

## Do not redo these

**unicode, eight ablations, all negative.** The ceiling is real: `put_row` with
the width compiled in as `1` runs +44%. But identical calls, identical bytes,
`print_run` 83.17 ms against 50.02 ms — it is **codegen, not work**. Skipping
the spacer write, the second guard read, the *entire* wide-char flag guard, or
the whole cell write each changed nothing; a 4 KiB width table from the crate
is a wash; a Latin-1 branch was slower *and* wrong inside U+0000..U+0100; the
lookup hoisted one iteration was 4% worse; splitting the one- and two-cell arms
was a wash; and the stride-1 inner loop — the thing the first half of
`2026-11-02-unicode-stride` recommends — was also a wash. Capturing it needs
branchless, table-driven per-character work. That is a different algorithm.

**The C0 gap.** Built, correct, not landed. It needs two guards: synchronized
output, and groundness at `fed` (false at a chunk's start, where the parser may
be part way through a sequence the previous chunk began). The second is found
only by the sweep, not by the fixed-seed gate — almost certainly why this was
reverted the first time. Worth +5.0% scroll_region at terminal, p=0.035, and it
costs `cursor_motion`, which passes. Recipe and both guards in
`2026-11-02-c0-gap`.

**Gather vs read-ahead.** Gather is ~11% ahead through the bench's pty and a
wash at terminal level. The reader idles ahead of the sink; hand-off latency is
off the critical path (470 ms of a 450 MB flood, removable, removing it changes
nothing).

**`GLASS_RUN_PROBE` 3 to 99 are inert.** Only 1, 2, and >=100/104 do anything.

## Measurement rules, learned the hard way

- **Use the paired `glass-alt` arm and report the sign test, not the median.**
  Paired at 15 rounds resolves 3%; unpaired at 9 cannot resolve 5%. Code
  placement alone moves a median up to 2.7% without ever reaching significance,
  so treat p>0.05 as absent however good the median looks.
- **Instruments tax what they measure.** `GLASS_PARSE_TIMERS=1` depresses
  throughput 27% and inflated the vte attribution to 76 ns per gap; a
  per-character width probe cost 3.5% and turned a real 44% into a reported
  23%. Measure the instrument before believing it.
- **The engine is not a proxy for the terminal.** They can disagree in *sign*:
  the C0 change is +3.8% engine and -3.2% terminal on unicode, 0 of 15,
  p=0.000.
- Engine gains *do* transfer where real — scroll_region +4.7% engine, +5.0%
  terminal, about 1:1. The pipeline costs 17% once; it does not scale a win
  away.

## Next

1. **Push.** 42 commits CI has never seen, and it would now pass.
2. **The draw and view path is the only uninstrumented region left.** The parse
   path has `engine::timers`, the locks have `census`, the hand-off has
   counters. The unicode sign inversion is work, not waiting — the census shows
   2 to 9 ms of waits in a ~470 ms flood, identical across builds — so it is in
   there. A draw-phase timer in the shape of `census.rs`, env-gated, with its
   own cost measured first.
3. **The gate as stated is not reachable on scroll_region.** Iteration 16
   measured its engine ceiling, with the region swap chain removed *entirely*,
   at 925 against ghostty's ~1150. ascii needs about +35% engine on top of a
   perfect pipeline. Those two need architectural work with a measured plan, not
   another iteration — or the release gate needs to change.
