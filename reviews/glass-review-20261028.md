# glass, reviewed — 2026-10-28

Rank: **good, and getting better in the right order.** The evidence
below comes from reading the whole tree (19k lines across `term` and
`glass`) and from the key-latency work on `latency/keys` — I measured
rather than skimmed the parts I touch.

## What is strong

1. **The architecture earns its keep.** One reader thread, one pump
   path (splitter → engine → intake together under one lock), one
   `Session` boundary the window never reaches around. Every
   concurrency decision I had to understand, I could understand from
   one file. That is rare and worth protecting in review.
2. **The numbers are real.** `speed.rs` runs the reader's actual path
   with no window; the benches (startup, throughput, visible, keys) all
   go through Hyprland onto a private headless output, so a result is
   reproducible by anyone with the same compositor. `docs/PERFORMANCE.md`
   publishes the harness's own outputs, not hand-picked numbers.
3. **Failure is handled, not hoped away.** Poisoned locks are recovered
   (`unwrap_or_else(|e| e.into_inner())` everywhere, consistently), the
   pty read loop treats `Err` as end-of-stream, and `FrameGate` bounds
   every wait (50 ms) so a wedged program cannot wedge the window.
4. **The scrollback and reflow story is tested at the level that
   breaks** — scroll display offsets against `scrolled_off_top`,
   alternate-screen switching, resize reflow — not just happy paths.
   357 tests, and they run in under a second.

## What I would fix next, ranked

1. **Draw work under a flood is the last latency tail** (see
   `reviews/key-latency.md`). The engine lock is no longer the
   bottleneck — the app thread's draw is: full-screen damage from `yes`
   costs 4.6-19 ms a frame at an 8 ms pace, and keys queue behind it.
   Damage tracking that skips rows that merely scrolled would cut most
   of it; the intake already knows which rows a read touched.
2. **`Session` is 2.1k lines and becoming a facade with state.** The
   reader thread's body, the reply path, and the KeyView handover all
   live in `spawn`. A `Reader` struct (thread + buf + handoff flag +
   KeyView publication) would let the concurrency story be tested
   without a pty — today only the flood benches exercise it, and this
   sandbox could not even run the three pty tests (no `/dev/ptmx`;
   they fail on plain `main` here too, which is worth knowing in CI).
3. **The pack/unpack KeyView word has no cross-thread test.** The unit
   test proves the round trip; nothing proves a torn or reordered read
   is impossible. It is (one aligned u64, release/acquire), but a
   comment saying why it cannot tear, or a `static_assert`-style check
   on size, would keep it true as fields are added.
4. **Clippy's `chunks_exact_to_as_chunks` backlog** (8 warnings in
   `glass-term` alone) is a five-minute `--fix`, and every one is on a
   pixel or index loop that the speed harness would prove unchanged.
5. **`OUTPUT_PACE`/`OUTPUT_GATHER` are tuned constants with a story**
   (8 ms / 1 ms) but no knob. The flood work above will want to retune
   them; an env override in the `glass_stage::env` style would save a
   rebuild per experiment.

## Advice for the owner

- Keep the one-message-in-flight rule and `FrameGate` as they are; both
  were right when I traced them, and the temptation under a flood is to
  add queues, which is exactly how the tail comes back.
- The `GLASS_KEY_TRACE` and `GLASS_SLOW_KEYS` pair (full trace vs
  threshold-only logging) is the pattern to copy for the next
  investigation: the full trace changed the measurement by a factor of
  ten under load, and the threshold log is what placed the real tail.
- `hyprctl eval` with `exec_cmd` onto a named headless workspace is the
  only harness shape I have found that measures a real compositor path
  without touching a user's monitors; it is worth factoring the four
  key/key-screen/throughput/startup scripts' shared plumbing (they
  already share `lib.sh`) into one runner before a fifth appears.

## Verdict

The key-latency branch takes glass from worst-in-class under load
(134-437 ms medians behind `yes`, against kitty's 34) to 14-32 ms with
zero throughput cost and parity with kitty idle — and the remaining
tail is now a renderer question with a measurement pointing at it,
not a mystery. Merge it when the owner is ready; the two review items
above are the next branch, not this one.
