# Static single-mark records: large Unicode gain, small truecolor tradeoff

Starting runtime: `86e1a564a014eeaf984b327d1f2fd0e32662ff3f`. This isolated
prototype was **not selected by itself**. The combined candidate is measured
separately in `../2026-11-03-marks-width/`; its results are not pooled here.

## Representation and obligations

Common marks U+0300..U+036F attach an immutable record from a fixed 112-entry
`OnceLock` array. The new one-word `CellExtraRef` tags these static pointers in
the low address bit. Nonstatic handles own exactly one Arc strong reference;
cloning/dropping them increments/decrements that count. Every dereference
clears the tag using provenance-preserving pointer mapping. A compile-time
alignment check reserves that bit. `Option<CellExtraRef>` remains one word
and `Cell` stays within its pre-existing 24-byte cap.

Mutation clones static content into an owned Arc first. Owned mutation
reclaims its one strong reference, uses `Arc::make_mut` (including Weak
reference dissociation) and restores raw ownership through an unwind guard
before constructing the returned mutable reference. No mutable access is
exposed by `Deref`. Equality and serde compare/encode content, not pointer
identity. Deserialization always produces owned content. Other marks retain
the pre-existing bounded single-mark Arc cache. Nine-mark limits, attachment,
underline/hyperlink behavior and plain-cell `None` are unchanged.

This adds unsafe ownership code and changes **the public field type** from
`Option<Arc<CellExtra>>` to `Option<CellExtraRef>`. It is not Arc-API-compatible.
`From<Arc<CellExtra>>` transfers one strong reference, and `Deref`, Clone,
Default, Debug, equality and serde provide content access. Pool retention is
fixed, not input-sized. No Unicode normalization is introduced.

## Tests actually executed

- Ordinary cell tests: **9 passed**. Covers all 112 static entries, out-of-range
  boundaries, word-size layout, static-to-owned COW, owned strong counts,
  Weak dissociation, creator-thread exit, cross-thread clone/drop and mutation,
  nine-mark cap, richer styles/links and content serialization.
- The same **9 tests passed strict-provenance Miri**, including thread cases.
  This is evidence for that compiler/model, not a universal safety proof.
- Alacritty package: **140 unit tests and 45 reference fixtures passed**.
- Release parser parity: **1 passed**; **12,800 seeded streams** had no
  divergence. The deliberately incorrect active probe 100 fails immediately
  with a cell divergence. An initial probe 5 was mistakenly used: it is
  documented inert, passed normally, and is **not** a sensitivity check.
  All logs, including the mistake and a mistyped grep which stopped a launch
  before builds/measurement, are retained. No failed launch counts as a gate.
- Two bounded independent reasoning reviews of the stated ownership
  transitions found no concrete defect. A broader tool-using reviewer timed
  out without an answer; it is not counted as a completed review.

## Engine screen and independent real-terminal replication

11 alternating engine pairs: Unicode **1.1736** (11/11 wins), but ASCII .9713
(1/11) and region .9304 (2/11). This **was not** used as terminal evidence.
The real-terminal protocol uses all six unchanged `tput.py` workloads, 154x39,
DA1-completed fastest-of-three passes, and all six terminal-order permutations.
There were no overlapping Glass builds/benchmarks; unrelated shared-host CPU
work was present. Ratios below are median paired candidate/control rates:

| workload | gate, 18 rounds | wins | replication, 24 rounds | wins |
|---|---:|---:|---:|---:|
| ASCII | 1.0319 | 12/18 | 1.0034 | 12/24 |
| Unicode | **1.2879** | **18/18** | **1.2846** | **22/24** |
| truecolor | .9849 | 0/18 | .9874 | 7/24 |
| cursor | .9989 | 8/18 | .9998 | 12/24 |
| region | 1.0029 | 9/18 | .9838 | 10/24 |
| TUI | 1.0028 | 10/18 | .9949 | 8/24 |

Unicode against Ghostty: **1.2415, 18/18**, then **1.2224, 23/24**. All three
previous Ghostty leads survived both series. ASCII and region are still
unresolved; truecolor's small control-relative cost is not hidden. First-gate
truecolor p=.00000762939; replication p=.0931396. Unicode replication control
p=.000035882, Ghostty p=.00000298023, unadjusted two-sided sign tests.

## Quiet response guard and replay

12 alternating pairs x 500 measured samples = **12,000 DA1 responses**.
Candidate/control pooled median .0699115/.0750465 ms, p90 .361389/.364646,
p99 1.686962/1.611731. Median of run medians .0681505/.07766075 ms; median
paired run delta -.0084055 ms. Large session variability and correlated samples
prevent a claim of latency improvement. This is **not key-to-screen latency**.

`quiet-rtt/` uses the retained, strengthened `run-pty-rtt.sh` plus standalone
`summarize-pty-rtt.py`, recording binary/harness/raw hashes and actual AB/BA
order. It passed exact replay. `rtt.log` separately records a failed attempt
to run nonexistent `bench/run-latency.sh`: no data came from that command.

Both terminal summaries passed canonical summarize-only replay and the engine
report passed its independent replay with binary identities checked. These
verify shape/order/hash/arithmetic consistency, **not timing accuracy**.
Frozen executable IDs are in `release-sha256.txt`; exact source snapshots and
build receipts are retained. The final combined source has separate
formatting/compile-time trait bounds and receives its own tests and gates.
