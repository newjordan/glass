# Immutable Unicode widths: replicated truecolor gain; not a sweep

Starting runtime source: `86e1a564a014eeaf984b327d1f2fd0e32662ff3f`.
This isolated candidate was **not independently selected**. It is later tested
with the immutable-mark prototype in `../2026-11-03-marks-width/`.

Instead of initializing a flat AtomicI8 width cache at runtime, `build.rs`
generates one byte per codepoint from the same `unicode-width` dependency used
at runtime. `width_of(char)` indexes read-only bytes. 255 represents `None` or
an invalid scalar; all Rust `char` values are in range. The generator asserts
that all defined widths fit its encoding. The exact manifest, generator,
engine and patch are retained. The binary has ~1.1 MiB additional read-only
data; this is **not** a new width policy or an allocation-free terminal.

The exhaustive pre-existing test compared every valid scalar twice with the
runtime dependency: **1 passed**, `exhaustive-width-test.log`. Parser parity:
**1 passed**, `parser-test.log`. `engine-pairs.json` is an 11-pair engine screen;
it is not the basis for any claimed end-to-end gain.

## Frozen executable, two independent real-terminal series

All six unchanged `tput.py` payloads, 154 x 39 geometry, headless Hyprland,
three DA1-completed passes per workload (fastest retained by the existing
harness). Orders cycle through all six permutations of candidate, fresh
control and Ghostty. No builds or other Glass measurements overlapped them.
The shared host did have unrelated CPU work. Values below are median paired
candidate/control rate ratios; p values are unadjusted two-sided sign tests.

| workload | first, 18 rounds | wins | replication, 30 rounds | wins |
|---|---:|---:|---:|---:|
| ASCII | 1.0710 | 9/18 | 0.9676 | 14/30 |
| Unicode | 1.0167 | 13/18 | 1.0211 | 20/30 |
| truecolor | 1.1205 | 18/18 | 1.1219 | 23/30 |
| cursor motion | 1.0227 | 18/18 | 1.0251 | 21/30 |
| scroll region | 1.0271 | 12/18 | 0.9431 | 13/30 |
| TUI frames | 1.0276 | 16/18 | 1.0318 | 19/30 |

Replication truecolor p=.00522288; cursor p=.0427739; Unicode p=.0987371.
The large truecolor gain reproduces. ASCII and region medians do **not**
reproduce; signs are mixed. Do not call the first series an all-metric win.

Against Ghostty, replication ratios were ASCII .9073 (13/30), Unicode .9669
(10/30), truecolor 1.3374 (27/30), cursor 1.1317 (24/30), region .9750 (13/30),
TUI 1.0727 (23/30). These do not establish world-champion status.

## Response-time guard and evidence

`rtt/` retains 12 alternating AB/BA session pairs, 500 samples each after
20 warmups: **12,000 measured DA1 responses**. The original retained runner
was `bench/run-pty-rtt.sh`; `bench/run-latency.sh` is not a checkout file.
Candidate/control pooled median .047600/.046688 ms; p90 .145503/.145303 ms;
p99 .542059/.648649 ms. Session medians vary substantially. No latency
improvement is established. Quiet DA1 RTT is **not key-to-screen latency**.
Earlier raw summaries are preserved rather than silently upgraded to the new
standalone RTT replay schema.

`gate/terminal-summary.json` and `replication-gate/terminal-summary.json` retain raw
hashes, launch order, exact binaries and harness identities. Both passed the
canonical summarize-only replay before any later harness changes. Replaying
with the same harness and temporary executables checks consistency, not timing
accuracy. `release-sha256.txt` identifies the exact executables. The previous
selected binary remained at `target/release/glass` during measurements.
