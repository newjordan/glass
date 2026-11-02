# Drain final readable bytes before PTY hangup

## Independently reproduced correctness defect

`wait_for_more` inspected `POLLHUP|POLLERR` before accepting readable data.
Linux poll can report **POLLIN and POLLHUP simultaneously** when a peer closes
with unread bytes still queued. The producer first checks `FIONREAD`; a child
can write its final burst and close between that check and `poll`. Treating
HUP as unconditional EOF in that state can discard that final burst.

This is a source-level correctness issue distinct from the early-recycling
performance hypothesis. It does not depend on adding a buffer or a timeout.
A raw PTY written with `the final burst`, then closed on the slave side,
produces this poll state on the measured Linux host.

## Failing regression, then fix

`reproduce.sh` adds the Linux regression test to the existing reader test
module. The test creates a raw PTY, writes final bytes and closes the slave.
It requires `Ready` while the bytes remain readable, drains the exact bytes,
then requires `End`. There is no sleep or probability-based race trigger.

- Before fix: `before.log`, **exit 101**, assertion requiring Ready fails.
- Fix: accept `POLLIN` before treating `POLLHUP|POLLERR` as End.
- After fix: `after.log`, **exit 0**, all three reader tests pass.

The two existing reader checks cover byte ordering/EOF and exact producer
credit timing for empty, partial and exhausted reads. The new test proves the
HUP/readable state handling, not that a random scheduling stress happened to
hit the full producer race.

No intentional wait, new allocation, unsafe operation or larger hand-off is
added by this correction. EINTR and quiet behavior are unchanged. The subsequent
read drains the bytes and the next EOF/hangup ends the stream. The regression
is Linux-gated; this is not a cross-platform poll behavior claim.

## Final-source verification and performance scope

`verify.sh` rebuilds the combined two-buffer early-recycle + HUP correction,
runs the existing project gates with matched rustdoc, and compares it to the
frozen pre-HUP candidate. Exact source/binary hashes and all command exits are
retained here. The full terminal comparison must be read before final claims;
passing a correctness regression does not imply any throughput improvement.

The preceding [fresh-control early-recycle replication](../2026-11-02-early-recycle/README.md)
measured +5.1% scroll-region throughput (15/18 pairs) and about +1.0% cursor
motion, with three established Ghostty leads preserved. That executable is a
separate build; these numbers are not automatically attributed to the HUP
build. ASCII and Unicode remain open championship deficits, and quiet DA1 RTT
is not key-to-screen latency. Startup, memory, busy input latency and other
machines were not covered by this iteration's final gate.

## Completed final-source results

Final executable SHA-256:
`d75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c`.
`target/release/glass` is restored to these exact measured bytes.

All commands in `verification-exits.txt` exit 0. Actual final-source checks:
830 workspace tests passed (11 ignored; the existing `vulkan_headless` exclusion
is explicit), 136 terminal unit + 45 reference tests passed, matched-rustdoc
workspace documentation tests passed, workspace Clippy completed with warnings
and no errors. Reader regression before/after is separately recorded above.
25,600 differential streams across both parser modes were run on the preceding
reader-only candidate; the HUP correction does not change parser code. Do not
mislabel those as newly rerun streams on this final executable.

18 full balanced real-terminal rounds, geometry 154 x 39, all six launch orders
three times (`gate/terminal-summary.json`):

| workload | final / pre-HUP candidate | wins | final / Ghostty | wins |
|---|---:|---:|---:|---:|
| ASCII | .9675 | 8/18 | .8600 | 6/18 |
| Unicode | .9934 | 7/18 | .9505 | 4/18 |
| truecolor | .9945 | 6/18 | **1.1784** | **18/18** |
| cursor motion | .9928 | 7/18 | **1.1195** | **18/18** |
| scroll region | .9764 | 8/18 | .9361 | 3/18 |
| TUI frames | 1.0097 | 13/18 | **1.0723** | **18/18** |

No final/pre-HUP change is established by these exploratory sign tests (all
p >= .0963). This is not proof of exact equivalence or that the unfavorable
medians cannot matter. Shared-machine and build-layout effects remain possible;
all rounds are retained. Against Ghostty, three established leads survive;
ASCII, Unicode and scroll-region are **not championship wins**. The final
scroll ratio is .9361, not the pre-HUP build's .9997. Do not transfer the
better ratio between builds. The +5.1% early-recycling estimate is measured
against a fresh HEAD control in its own report, not inferred by multiplying
ratios from this run.

Final/pre-HUP quiet RTT, six paired sessions, 300 correlated samples/session:
median of run medians .03332775 / .033831 ms; pooled medians .0342545 / .032306
ms; pooled p99 .064031 / .060274 ms. Paired run median signs split 3/3. No
reliable improvement or regression is established at this resolution, and no
intentional wait is added. This is DA1 RTT, not key-to-screen latency.

Selection: keep bounded two-buffer early recycling (replicated smaller gain)
and the independently reproduced HUP byte-preservation fix. Reject direct
commit, width hoist and extra credit. The world-championship goal remains open.
