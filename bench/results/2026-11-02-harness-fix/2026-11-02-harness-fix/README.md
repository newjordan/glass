# The bench harness's Hyprland drift, fixed (2026-11-02)

Iteration 21. Commit `108308c` on glass main. All probes under
`/tmp/probe*.sh` on this machine; the fix in `bench/lib.sh` and its five
callers (`run-tput.sh`, `run-misc.sh`, `run-startup.sh`, `run-visible.sh`,
`keys-screen.sh`).

## What iteration 20 blocked on, and what it actually was

The iter-20 README recorded two blockers for the canonical 154x39
scoreboard run: (1) windows "landing at a fraction of the output" —
50x39/49x39 — blamed on "the harness's Hyprland integration having
drifted"; (2) glass dying with `GPU device: Parent device is lost`.

This iteration decomposed blocker (1) into three independent mechanisms:

1. **`exec_cmd`'s workspace option is dead** in Hyprland 0.56.2's lua
   API. The harness launched with
   `hl.dsp.exec_cmd(cmd, { workspace = "5501 silent" })`; the legacy
   `"<id> silent"` string is silently dropped by `buildRuleFromTable`
   ("failed to build table for exec rules"), the bare-number form is
   accepted but advisory-only, and in both cases the process runs while
   the window opens on the *active* workspace. A 625x1013 window tiled
   among two others on HDMI-A-1 is exactly 50 columns — the geometry the
   iter-20 session measured at, wrongly believed to be the output's tile.
   (The harness's `headless_up` mode setup, `hl.monitor`, still works.)
2. **`hyprctl output remove` can wedge the headless backend.** Removing a
   virtual output and immediately creating another can leave the new one
   at 0x0 with no mode that sticks; removing all virtual outputs and
   waiting for the monitor list to settle restores it. A 2s settle wait
   after `output remove` in `headless_down` has kept the path healthy.
3. **`hyprctl keyword` is unusable under the lua config** ("keyword can't
   work with non-legacy parsers") — any future probe must go through
   `hyprctl eval`.

Plus the mapping-latency finding: under tonight's load (sglang holding
17.8 GiB of the 3090, load ~5, three angel cockpits), ghostty took
**50s and 300s** to map a window in two probes. The harness's 900s
result wait absorbed it; my shorter probe loops did not, which is why
early probes looked like "the window never opens".

## The fix

`launch` now takes `CLASS COMMAND...` and registers a class-matched
window rule before spawning:

```lua
hl.window_rule({ name = "glassbench",
                 match = { class = "^<class>$" },
                 workspace = "<ws> silent" })
```

Window rules are evaluated at map time, terminal-agnostic, and the
`workspace` effect with the `silent` suffix is the documented way to
place an opening window. Verified placement live: foot at **1896x1013**
(a full tile minus the 2x12px borders, wait — minus Hyprland's 12px
border x2) on the headless output's workspace, mon 5, in 2s.

`wait_gone` grew from 10s to 60s (120 x 0.5s) — ten seconds truncated
runs mid-teardown under tonight's mapping latency.

## The end-to-end proof, and this session's canonical scoreboard

With the fix, `bench/run-tput.sh` produced **154x39** results — the
published geometry, for the first time since the scoreboard's own
README rule ("compare only at the same grid") started being violated:

- foot, 2 rounds: ascii 377.7/392.0, unicode 117.2/116.4, truecolor
  351.2/355.3, cursor_motion 390.5/407.8, scroll_region 365.5/276.8,
  tui fps 6395/6118 — a sane CPU-renderer reference on this box tonight.
- **ghostty 1.4.0, 2 rounds:** ascii 1052.1/747.9, unicode 260.0/267.6,
  truecolor 226.9/231.3, cursor_motion 202.9/204.4, scroll_region
  1032.2/1049.9, tui fps 3686/3595.
- **glass (published `~/.local/bin/glass` binary), 2 rounds:** ascii
  423.5/504.7, unicode 209.4/218.7, truecolor 240.1/246.8,
  cursor_motion 209.3/209.7, scroll_region 430.0/443.6, tui fps
  3316/3305.

Medians: glass/ghostty = ascii 464/900 (**0.52x**), unicode 214/264
(**0.81x**), truecolor 243/229 (**1.06x**), cursor_motion 210/204
(**1.03x**), scroll_region 437/1041 (**0.42x**), tui fps 3311/3641
(**0.91x**). Two caveats on these numbers: the published glass binary
predates the rw-default-on work (it lacks the bare-C0 gap fast path and
the run-whole default, worth +13-26% terminal-level per iteration 20),
and both terminals ran under tonight's GPU/CPU contention. The numbers
are a *repaired-harness baseline*, not a claim.

`truecolor` (1.06x) and `cursor_motion` (1.03x) lead; `scroll_region`
(0.42x) and `ascii` (0.52x) trail — consistent with the engine-side
findings that scroll's fix (region rotate, +42% engine, unlanded) and
ascii's parse-thread work remain the levers.

## Method notes

- `hyprctl eval`'s lua `print` never reaches the client; `error("...")`
  does, and runtime errors surface. That asymmetry is the only way to
  read values back out of an eval.
- `pkill -f <token>` matches the sandbox's own cmdline (the script text
  itself) and killed my own worker twice before I switched to killing by
  PID from `hyprctl clients -j`.
- The `hl.*` API can be enumerated by `for k,v in pairs(hl.dsp)` etc.;
  `workspace.move` takes `({workspace=N}, {monitor=CAP})` — a workspace
  move, not a window move. Window placement belongs to window rules.

## Raw

- `tput-foot-{1,2}.json`, `tput-ghostty-{1,2}.json`, `tput-glass-{1,2}.json`
  in this directory.
- The earlier `tput-ghostty-1.json` (49x39, pre-fix) was replaced by the
  154x39 run above.
