# Cache-line row alignment: engine gain, real-PTY Unicode regression

Reported research, no runtime promotion and no championship claim. Start HEAD
`1661f5a`; shared Ryzen 9 9950X3D / RTX 3090, Linux/Hyprland. Directory date is
UTC 2026-11-03 (host local 2026-11-02). Neither competitor configuration nor
terminal affinity was changed. The exact previously selected executable is
restored; source retains only a test in storage.rs.

## Candidate and engine gate

`candidate.patch` adds only `#[repr(align(64))]` to Row<T>, keeping contiguous
inline row storage. `layout.txt` with the pinned Cargo compiler confirms the
control Row<Cell> is 64 bytes with alignment 8 (Cell is 24/8). Raising alignment
of that 64-byte row does not increase its size, but changes allocation and
potentially layout/allocator behavior. This is not a claim of an isolated
cache-miss mechanism. All tested binaries use the same locked release config.

The first 11 alternating pairs used scale 2/five rounds. A fresh 17-pair series
on the SAME frozen executables followed; neither series is selectively pooled.
Ratios are median paired CPU throughput, candidate/control; p is unadjusted
sign-test p, diagnostic only on this shared host and six selected workloads.

| workload | first CPU ratio (W/L) | replication CPU ratio (W/L) |
|---|---:|---:|
| ascii | 0.998697 (5/6) | 0.994519 (7/10) |
| unicode | 1.018932 (9/1, one tie) | 1.029323 (14/3) |
| truecolor | 1.011714 (9/2) | 1.014609 (14/3) |
| cursor_motion | 1.036740 (8/3) | 1.007713 (11/6) |
| scroll_region | 1.001333 (7/4) | 1.002342 (10/7) |
| tui_frames | 0.990883 (5/6) | 1.006396 (11/6) |

Replication sign p for Unicode/truecolor: 0.01272583 each. Unicode is +2.93%,
but this is NOT enough for promotion: the next stage contradicts transfer.
Unrelated high-CPU work was observed on the shared host; no privileged host
changes were made. Full raw stderr/stdout and binary hashes are retained.

## 54 real-terminal sessions: cyclic-balanced protocol

18 rounds, three terminals per round, all 154x39, six unchanged tput.py
workloads, three passes/fastest DA1-completion estimator as in the existing
harness. `glass` = freshly built inline-row control, `glass-alt` = aligned
candidate, `ghostty` = installed competitor. Selected historical binary is
NOT mislabeled as this fresh control. `release-sha256.txt` names all three
Glass executables. `terminal-summary.json` records the competitor hash too.

Orders repeat [control,candidate,ghostty], [candidate,ghostty,control],
[ghostty,control,candidate], six times. This balances launch position, but it
is NOT compare-tput.py's six-permutation schedule; pairwise predecessor order
is not counterbalanced. It cannot supersede the canonical full-permutation
scoreboard. `run-terminal-cyclic.sh` retains the command for this distinct run.

The original appended summarize command used unsupported CLI flags and exited
2 AFTER all 54 JSONs existed. That failure remains in `terminal-run.log`.
`summarize-terminal.py` uses the existing strict shape/rate summarizer and
labels this protocol separately. It hashes every raw file and checks exact
summary equality on replay. It did not change any payload or measurement.

| workload | aligned/control paired wall ratio | wins/losses | aligned/Ghostty ratio | wins/losses |
|---|---:|---:|---:|---:|
| ascii | 1.086237 | 11/7 | 1.019395 | 10/8 |
| unicode | 0.984723 | 2/16 | 0.935558 | 6/12 |
| truecolor | 1.006140 | 12/6 | 1.175294 | 18/0 |
| cursor_motion | 0.999586 | 8/9 (one tie) | 1.111834 | 18/0 |
| scroll_region | 0.986085 | 8/10 | 0.981659 | 8/10 |
| tui_frames | 1.005954 | 12/5 (one tie) | 1.058747 | 18/0 |

Unicode loses 16/18, p=0.00131226 unadjusted; it is -1.53% here despite
+2.93% engine replication. Reject the candidate, do not cherry-pick ASCII.
The +8.62% paired ASCII median is noisy (p=0.48068), not the +0.98% ratio of
unpaired medians; those are different estimators. No runtime gain is shipped.

Medians (MB/s, except TUI fps):

| workload | control | aligned | Ghostty |
|---|---:|---:|---:|
| ascii | 978.4 | 988.0 | 989.8 |
| unicode | 279.15 | 274.5 | 292.35 |
| truecolor | 277.9 | 279.4 | 236.45 |
| cursor_motion | 238.9 | 239.6 | 214.75 |
| scroll_region | 1110.65 | 1084.35 | 1121.55 |
| TUI fps | 3945.65 | 3965.35 | 3745.0 |

Rounded session CPU seconds favor Glass versus Ghostty, but those counters
are coarse (0.01s steps); do not infer precise small candidate CPU deltas.
These sessions measure DA1-completion throughput, not visible-frame or
keyboard-to-screen latency. Against Ghostty this candidate has three clear
throughput wins, not six. The historical selected runtime remains untouched.

## Quiet real-PTY RTT (separate, not key-to-screen latency)

Existing run-pty-rtt.sh, six alternating paired rounds, 300 samples per arm per
round after warmup, 3ms quiet spacing. Here the role labels DIFFER: rtt/glass
is aligned candidate, rtt/glass-alt is control, as binary-hashes.txt records.
Median-of-run-medians: aligned 0.0334855ms, control 0.031767ms. Four of six
candidate session medians are slower; pooled p99 aligned 0.073789ms, control
0.050445ms. Sessions are correlated; this is neither a precise key latency
estimate nor a latency benefit. All 12 raw sessions/3,600 timed samples remain.

## Final correctness and restoration

- Restored-source library (serde): 137 passed; reference: 45 passed.
- Restored-source glass-term suite: 376 passed, 11 ignored, 0 failed.
- Existing replay-validator mutation tests: 5 passed.
- Each candidate passed parser differential; aligned also passed the
  strengthened lazy/history rotation model before its release build.
- New final regression covers 1,260 region/origin/count combinations with
  history outside the region, empty/singleton ranges, ring seams, per-row
  backgrounds, uniform-prefix metadata, partially overwritten lazy tails,
  and physical shared extras. It compares observable cells and metadata.
  Boxed rows were checked with the earlier version, not this later test.
- `restoration.json` checks all 120 original Rust source paths: only test
  code in storage.rs changed; its runtime prefix exactly equals original.
  Row alignment is removed; all other source bytes match the start hashes.
- target/release/glass byte-equals the saved selected executable, SHA-256
  d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c.

All three engine reports replay; terminal replay hashes all 54 raw sessions.
Build, test, failed-command, provenance, restoration and raw evidence stay
here and in the boxed-rows directory. Bare rustc's layout probe initially hit
E0514 (1.99.1 vs pinned Cargo 1.99.0); retry with rustup run 1.99.0 succeeded.
No cleaning or rewriting of earlier artifacts was needed.

## Replay

```
python3 -I bench/replay-engine-pairs.py --pairs 11 \
  bench/results/2026-11-03-boxed-rows/engine-pairs.json \
  bench/results/2026-11-03-row-alignment/engine-pairs.json
python3 -I bench/replay-engine-pairs.py --pairs 17 \
  bench/results/2026-11-03-row-alignment/engine-replication.json
python3 -I bench/results/2026-11-03-row-alignment/summarize-terminal.py
```

Engine --verify-binaries additionally needs the recorded /tmp binaries.
Terminal replay requires its recorded binaries installed/present to verify
current hashes; retained sources/build receipts are not byte-identical
rebuild guarantees. Final test receipts are explicitly scoped above.

## Next necessary work

Do not repeat scalar decoder tweaks, global boxing, or alignment alone as
already-proven wins. A better region indirection design must avoid Unicode's
lookup penalty while preserving reflow, owned extras, cursor templates and
serde. Another serious direction is a compact cell/page representation with
style/extra side storage, but its compatibility and cost remain unverified.
Neither idea is asserted as a solution, and the all-metric goal remains open.
