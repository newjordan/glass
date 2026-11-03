# Reader call shape, not a syscall or championship scoreboard

**Reported research.** Starting commit `671ac9f`, selected release executable
SHA-256 `d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
Linux/Hyprland on the shared Ryzen 9950X3D / RTX 3090 workstation. No affinity,
producer placement, competitor settings or official leaderboard were changed.
This is a new own-process read/poll diagnostic, not another UTF-8 shortcut.

## Design and evidence

The selected executable was not rebuilt for this capture. `read-shape.c` is an
opt-in LD_PRELOAD observer, gated by exact `/proc/self/exe` and the self-named
`pty-read` thread. It records no buffers, pointers, descriptors or program text.
Count mode records read request/result, poll result/revents and one monotonic
exit time. Timed mode adds entry wall and two thread CPU clock observations.
Successful call results and errno are preserved. Events are appended to a fixed
single-writer array, committed by release/acquire count; overflow is explicit.
Destructor output uses exclusive creation and a write-all loop. It can omit the
very last reader call during process teardown, so the checker requires the
**actually dumped prefix** to enclose every measured pass. It is not an
exhaustive process-lifetime or kernel syscall trace. The selected dynamic symbol
table uses libc read/poll/pthread_setname_np; direct syscalls are not observed.
The known reader has no hook-reentrant signal handler or fork path. This observer
is not a general-purpose preload library or a future ABI compatibility promise.

`pilot/` contains one round (three sessions, 54 passes). `balanced/` contains
12 rounds, all six plain/count/timed orders twice, one terminal at a time,
154x39, all six unchanged payloads and all three repetitions. All arms use the
same boundary-only `pipeline-profile.py` wrapper, and default unpinned producer.
Plain has no preload. The observer is inherited but inactive in executed child
programs; even inactive interposition can perturb those processes. BSS demand
faults, per-call clocks, trace stores and scheduling are part of the treatment.

The balanced decoder accounts for **8,752,761,648 payload-plus-query bytes** in
432 instrumented passes, **1,439,461 captured read calls** and **514,143 captured
poll calls**. All 648 plain/count/timed pass profiles and all source/raw/binary
hashes replay. Each instrumented pass must total the original payload plus its
three-byte DA1 query; the trace header, drop count, order, request/result ranges,
pass geometry, payload hash and fastest-of-three stored summary are checked.
This checks consistency, not clock accuracy or absence of every possible missed
zero/error call. The initial selected binary and runtime source are snapshotted.

## New findings

The old reader documentation described 4 KiB as the most one Linux PTY read can
return. That is false on this kernel: both instrumented modes contain 16,384-byte
returns, using the unchanged reader's full remaining handoff slice. Count-mode
positive-read means and aggregate byte shares are:

| Workload | Mean bytes/read | Bytes in reads >4096 | Maximum |
|---|---:|---:|---:|
| ASCII | 6821.4 | 70.9% | 16384 |
| Unicode | 5734.1 | 55.0% | 16384 |
| Truecolor | 5776.2 | 56.1% | 16384 |
| Cursor motion | 5545.9 | 53.0% | 16384 |
| Scroll region | 6792.1 | 70.0% | 16384 |
| TUI frames | 5623.9 | 53.4% | 16384 |

These are pooled byte/call statistics, **not** independent statistical samples
or an estimate of uninstrumented read sizes. Size distributions change sharply
across sessions. ASCII's per-round pooled large-read byte share ranges from
20.4% to 89.2% in count mode. The observer-conditioned capture refutes a hard
ceiling; it does not establish one stable kernel transport distribution.

Timed-mode medians across the 36 passes per workload:

| Workload | Whole read+poll wall / pass wall | Read CPU (ms) | Poll CPU (ms) | Reader snapshot CPU (ms) |
|---|---:|---:|---:|---:|
| ASCII | 92.7% | 24.542 | 0.703 | 27.637 |
| Unicode | 26.4% | 13.946 | 0.852 | 16.725 |
| Truecolor | 27.2% | 20.719 | 1.221 | 24.852 |
| Cursor motion | 24.5% | 14.106 | 0.881 | 17.048 |
| Scroll region | 94.4% | 14.748 | 0.459 | 16.619 |
| TUI frames | 26.8% | 17.934 | 0.965 | 21.149 |

Only calls wholly contained in a pass contribute duration. Calls straddling
boundaries are counted separately; bytes belong by return time. The median
boundary-straddle count is two. Monotonic and thread clocks are **inclusive
userspace-wrapper/glibc/kernel** observations; not pure kernel time. Snapshot
windows have about 0.12 ms median uncertainty. CPU interval is nested inside
wall interval. Different-column medians must not be subtracted as if they were
one pass. Remaining reader time can include ioctl, handoff/credit operations,
clock/trace overhead and scheduling; it is not all credit pressure. Off-CPU wall
cannot be classified blocked versus runnable without scheduler evidence.

Quiet polls are about 15.5–15.7% of count-mode captured ASCII/region polls,
versus 5.5–6.0% for the other four workloads. FIONREAD and handoff calls are not
hooked, so this does not measure total reader syscalls or handoff rate.

## Overhead control and uncertainty

Fastest-of-three **session** rates are paired within round. Passes are not
independent comparison units. Twelve pairs, no exclusions:

| Workload | Count/plain median ratio (wins) | Timed/plain median ratio (wins) |
|---|---:|---:|
| ASCII | 1.06036 (7/12) | 0.91569 (4/12) |
| Unicode | 0.99725 (5/12) | 0.99323 (5/12) |
| Truecolor | 1.00386 (6/12) | 1.00842 (7/12, one rounded tie) |
| Cursor motion | 1.02241 (10/12) | 1.01079 (7/12) |
| Scroll region | 0.98146 (6/12) | 1.03103 (7/12) |
| TUI frames | 0.99615 (5/12) | 1.01427 (7/12) |

The exploratory count/cursor sign p=0.038574 is uncorrected; it does not survive
12-comparison Bonferroni. No equivalence test was run. Timed ASCII's point
estimate is -8.4%, even though its two-sided sign p=0.387695 does not reject the
null. Neither non-significance nor a point estimate near one proves negligible
observer cost. Plain ASCII itself ranges from 173.0 to 1095.7 MB/s. Later rounds
slow dramatically on the shared host. **All rounds remain**, including those
with incompatible-looking rates. The pilot was particularly perturbed (ASCII
1082.5 plain, 578.9 count, 331.8 timed MB/s). It is retained separately, not
pooled into the planned twelve-round comparison. These are diagnostic rates,
not a fresh uninstrumented Ghostty scoreboard or visible/key latency evidence.

## Checker adversarial replay and implementation receipts

Five disposable-copy corruptions are retained in `corruption-demonstration.json`:
changed raw summary; nonzero drops with updated trace hash; truncated trace with
updated hash; one missing pass byte with updated hash; and a shortened dumped
tail that no longer encloses the last pass. All five are rejected without any
file mutation. Updating a hash alone cannot bypass the structural/byte checks.
This is measured rejection of those alterations, not a proof against forgery.

Initial strict C build rejected an eight-byte magic initialized with a string
literal under GCC 16 `-Werror`; explicit eight characters fixed it. The failed
build log is retained. An initial analyzer file was invalid and immediately
rejected by Python before analysis; the valid source was written before the
first report. One host snapshot pipeline hit SIGPIPE under pipefail and was
rerun without truncating version output. A mistaken `--lib` test invocation
ran no tests (this is a binary crate); corrected `--bin glass` ran all seven
existing reader tests successfully. No failed command is counted as a pass.

`previous-evidence-replay.json` checks all 700 prior explicit artifacts before
this iteration's changes. `baseline/` and `previous-manifest-baseline.json`
retain exact pre-iteration bytes for those artifacts so later doc/comment edits
do not destroy historical hash closure. Earlier result directories and manifests
are not rewritten. Source snapshots, trace DSO and raw traces are explicit.

## Reproduce

```sh
gcc -shared -fPIC -O2 -std=c11 -Wall -Wextra -Werror \
  -o /tmp/glass-read-shape.so bench/linux/read-shape.c -ldl -pthread
OUT=/tmp/glass-read-shape-fresh GLASS=/absolute/frozen/glass \
OBSERVER=/tmp/glass-read-shape.so ROUNDS=12 \
  bash bench/linux/run-read-shape.sh
python3 -B -I bench/linux/analyze-read-shape.py \
  bench/results/2026-11-03-read-shape/balanced \
  --check bench/results/2026-11-03-read-shape/balanced-analysis.json
```

Full timing replay requires the recorded exact binary and unchanged capture
harness paths/hashes. Artifact-only integrity replay is available through
the frozen explicit evidence verifier. Neither replay re-runs measurements.
The controlled spare-capacity-policy follow-up is documented separately in
`tail-policy/`; no runtime optimization follows automatically from this capture.

## Tail spare-capacity policy: rejected

The false 4-KiB ceiling suggested one distinct follow-up: change only `PTY_READ`
4096->1, filling a remaining tail when readiness permits. Keep two 16-KiB
handoffs, existing FIONREAD/poll(0) cadence and no added waiting. This differs
from larger buffers, extra credits, single-poll and raw-syscall experiments.
The risk is more short reads/probes for little extra payload.

Seven existing reader tests passed. The exact candidate is
`1d626efc697c57a8bbe87ffb31e40ea077cb9159937e5fddc1f049827122fbd5`;
control is the selected executable. All 18 rounds/54 sessions completed: all six
candidate/control/Ghostty orders three times, unchanged uninstrumented producer
and 154x39 geometry, all six workloads, no outlier removal.

| Workload | Candidate/control | Wins/18 | Candidate/Ghostty | Wins/18 |
|---|---:|---:|---:|---:|
| ascii | 0.98687 | 9 | 0.87633 | 7 |
| unicode | 0.96540 | 8 | 0.81703 | 5 |
| truecolor | 0.94501 | 4 | 1.25653 | 17 |
| cursor_motion | 0.97534 | 7 | 1.10669 | 11 |
| scroll_region | 0.92324 | 6 | 1.05231 | 11 |
| tui_frames | 0.97583 | 6 | 1.04378 | 12 |

Every median against control is below one. Truecolor loss uncorrected sign
p=.03088 becomes Holm p=.18530; do not claim a corrected significant loss.
No control improvement was established. Only truecolor versus Ghostty survives
the six-workload comparator-family correction (Holm p=.00086975), not a
whole-campaign correction. A favorable competitor cell does not justify a
candidate below control. Reject the runtime change. No quiet-RTT gate or
all-metric victory is claimed.

Independent read-only replay verified 54 sessions and exact candidate/control/
competitor hashes. The derived `tail-policy/holm.py` is not the independent
checker. `restoration.json` confirms starting runtime statements/constants
(only corrected comments remain) and exact selected-executable byte comparison.
Both diagnostic captures replayed after restoration. Next useful evidence is
a scheduler-aware transport/line-discipline trace that distinguishes blocked
versus runnable time and kernel copy/locking versus transport availability,
with explicit observer-overhead control; not another unsupported buffer tweak.
