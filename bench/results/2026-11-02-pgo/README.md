# Mixed-session PGO: measured, not enabled by default

## Scope and result

This is an opt-in compiler experiment on the **single-mark cache** source
starting at `ceaca65`, not a shipped release setting and not a Ghostty sweep.
The final measurements are in `terminal-summary.json`; every raw terminal
receipt is under `terminal/`. All three arms used 154 x 39 grids. Order was
rotated among PGO Glass (`glass`), normal cache Glass (`glass-alt`) and Ghostty.
There were 15 complete rounds, with no other Glass benchmark running.

| workload | PGO / normal cache | wins | PGO / Ghostty | wins |
|---|---:|---:|---:|---:|
| ascii | 1.0192 | 9/15 | 0.8010 | 1/15 |
| unicode | 1.0104 | 12/15 | 0.9697 | 6/15 |
| truecolor | 1.0323 | 15/15 | 1.1852 | 15/15 |
| cursor_motion | 1.0013 | 10/15 | 1.0965 | 15/15 |
| scroll_region | 1.0354 | 13/15 | 0.9332 | 2/15 |
| tui_frames | **0.9724** | **1/15** | 1.0127 | 9/15 |

Against normal cache, the two-sided sign p values are .0352 for Unicode,
.000061 for truecolor, .00739 for region and **.000977 for the TUI loss**.
The TUI/Ghostty comparison is inconclusive (p=.6072), unlike the established
normal-cache TUI lead. This is why the profile is rejected as the default.

Training uses `bench/pgo-train.py`, not `bench/tput.py`. Three independent seeds
(318731, 912953, 517829) each produced about 6.7 MB of mixed multilingual logs,
ANSI colors, tabs, scrolling subregions, alternate-screen cursor edits and
synchronized redraws. Training receipts record the geometry, seed, byte count
and payload SHA-256. The training wall times are **not benchmark scores**.
DA1 barriers ensure each phase was processed. This does not test every terminal
feature, and no holdout generalization beyond the measured harness is claimed.

The merged profile contains 78,864 functions and 733,889 blocks. `rustc` is
1.99.0 / LLVM 23.1.1; `llvm-profdata` is LLVM 23.1.3. No profile mismatch or
missing-function warning was emitted. Binary and profile hashes are in
`hashes.txt`; build logs are retained. The optional build reduced the binary
from 14,469,792 bytes to 13,261,528 bytes (about 12.65 MiB).
Binary size is not a throughput result.

## Reproduce

Use the **same source and compiler** for instrumentation and profile use.
The source is the cache-only candidate; inline marks, borrowed reader, rotation
arithmetic and validated decoder patches are NOT applied. A later cache lookup
syntax-only let-chain cleanup happened after this binary was frozen, so these
are results for the recorded binaries, not a claim of byte-identical rebuilds.

```sh
mkdir -p /tmp/glass-pgo-profile
RUSTFLAGS='-Cprofile-generate=/tmp/glass-pgo-profile' \
  CARGO_TARGET_DIR=/tmp/glass-pgo-target \
  cargo build --release -p glass-term --locked
cp /tmp/glass-pgo-target/release/glass /tmp/glass-pgo-generate
```

Launch the instrumented binary using `bench/lib.sh` on a private headless
output. For each seed, run `python3 -I bench/pgo-train.py RECEIPT SEED` INSIDE
that terminal, inheriting:

```sh
export LLVM_PROFILE_FILE=/tmp/glass-pgo-profile/session-%m-%p.profraw
```

Wait for each terminal to exit so its profile is flushed, then:

```sh
llvm-profdata merge -o /tmp/glass-pgo-profile/merged.profdata \
  /tmp/glass-pgo-profile/*.profraw
RUSTFLAGS='-Cprofile-use=/tmp/glass-pgo-profile/merged.profdata -Cllvm-args=-pgo-warn-missing-function' \
  CARGO_TARGET_DIR=/tmp/glass-pgo-target \
  cargo build --release -p glass-term --locked
cp /tmp/glass-pgo-target/release/glass /tmp/glass-pgo-use
```

Evaluate with the unchanged `bench/run-tput.sh`, rotating three arms each round:

```sh
CAP=GLASSPGOGATE GLASS=/tmp/glass-pgo-use \
  GLASS_ALT=/tmp/glass-mark-cache-bin \
  TERMS='glass glass-alt ghostty' ROUNDS=1 \
  OUT=bench/results/2026-11-02-pgo/terminal bench/run-tput.sh
```

Use all rounds and paired ratios, not a division of unrelated medians.
Exact two-sided sign tests are exploratory and uncorrected for multiple
comparisons. Profiles and binaries remain local `/tmp` artifacts; no generated
profile or machine-specific optimization flag is added to the normal build.

## Decision

Do not promote this profile to the default build: the final gate must be read
as a tradeoff, not a universal optimization. The normal cache build remains
the selected implementation. See the adjacent summary for the completed
per-workload comparisons and the cache report for the remaining Ghostty gaps.
