# Reader-only small-L3 placement: terminal integration test

The parser-free reciprocal controls in
[transport-control](../2026-11-02-transport-control/README.md) establish that
producer/reader domain pairing can matter even without terminal work. This
candidate tests a distinct policy from the rejected scheduler-managed reader:
place the copying-only Linux reader on the smallest unequal L3 domain, while
leaving the history-owning parser on largest L3. The producer, benchmark,
competitor, buffering, parser, and drain-before-HUP logic do not change.

`candidate.patch` changes affinity/read_ahead only. `GLASS_AFFINITY=off`, allowed
CPU intersections, homogeneous/unknown machine no-op and macOS QoS remain intact.
Both executables are built fresh with the same compiler/profile; compiler,
source, binary hashes and build logs are retained. Their hashes:

- control: eb14bd5e80f5a4cca770a4272bdd416bd05f9a11f427fbfd6633cb8685e51ce0
- candidate: b373ee8221f8780494d553ff23fcc5ebfccae59e6062bca3c72b26789b5f13d2

The pre-existing `cargo test --release -p glass-term read_ahead::tests --
--nocapture` passed **3/3**, including copied-credit timing and final-byte drain
on simultaneous hangup. This is a focused reader check, not a broad-suite or
cross-platform verification. The existing engine comment correction was common
to both builds. No builds or other benchmarks ran concurrently with the gate.

```
GLASS=/tmp/glass-i6-reader-small GLASS_ALT=/tmp/glass-i6-reader-control \
  python3 -I bench/compare-tput.py \
  bench/results/2026-11-02-small-reader/gate --rounds 18
```

The unchanged six-order balanced gate, including Ghostty, uses the normal
unrestricted producer at 154x39. Internal workload repeats are not independent
statistical samples. Sign tests are exploratory and uncorrected.

The first session was very slow and the second recovered; neither was used as a
standalone promotion/rejection criterion. All final results, including outliers,
will be retained in the complete gate. Raw-PTY gains alone do not establish that
moving a reader away from its parser is beneficial.

Final decision and restoration are recorded below after the complete gate.

## Final result: rejected

`gate/terminal-summary.json` is complete. `replay.log` verifies all 54 raw
sessions, compatible geometry and byte counts, recomputed summaries, and frozen
binary/harness/runner hashes. The first-round outlier remains included.

| Metric | Candidate/control | Wins/18 | Two-sided sign p |
|---|---:|---:|---:|
| ASCII | **.6852** | **1** | **.000145** |
| Unicode | .9647 | 5 | .09625 |
| Truecolor | .9974 | 8 | .81453 |
| Cursor | .9794 | 5 | .09625 |
| Region | **.6623** | **1** | **.000145** |
| TUI | .9818 | 7 | .48068 |

**Do not promote.** The raw-PTY reader-placement effect did not transfer to
this reader/parser topology. The terminal result does not identify the exact
handoff, cache, scheduling or other kernel cause. A bounded live-mask observation
attempt did not capture an active two-thread session; no runtime affinity
observation is claimed. The source expresses the policy; unlike the synthetic
transport controls, this gate did not validate observed masks.

No new quiet RTT, broader-suite or cross-platform claim was needed for a rejected
candidate. `restoration.log` records byte-for-byte source restoration and the
exact selected executable hash d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c.
The runtime source is unchanged from selected; only the earlier engine comment
correction remains. No production optimization was promoted by this experiment.

`selected-vs-ghostty.json` derives **only the fresh control arm**, not the rejected
candidate, from the same complete gate. Median paired control/Ghostty ratios:
ASCII 1.0867 (12/18), Unicode **.9522 (6/18)**, truecolor 1.2103 (16/18),
cursor 1.1319 (16/18), region 1.0296 (10/18), TUI 1.0585 (14/18).
These exploratory, uncorrected results are not an all-metric championship, and
small advantages with mixed wins should not be reported as established leads.
