#!/usr/bin/env python3
"""Matched-payload Linux /proc diagnostic, NOT the default throughput gate.

run OUT.json [--sample-ms 5] executes the unchanged tput.py payload generator
and estimator, with instrumentation outside each timed pass and around the two
producer write_all calls. No affinity or terminal policy is changed. All 18
passes, not just the fastest, retain high-resolution task CPU and switch deltas.
A separate observer optionally samples actual last-CPU and kernel wait channels.
/proc schedstat run-delay may be disabled: off-CPU is NOT claimed to be blocked
rather than runnable. Sampling and snapshots have overhead; use --sample-ms 0
as the boundary-only control. Neither arm is an official terminal score.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

PAYLOAD = Path(__file__).resolve().parents[1] / "tput.py"
START = "            c0, t0 = cpu(tpid), time.perf_counter()"
END = "            t1, c1 = time.perf_counter(), cpu(tpid)"


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def task_snapshot(pid, tid):
    root = Path(f"/proc/{pid}/task/{tid}")
    before = time.monotonic_ns()
    try:
        stat = (root / "stat").read_text().rsplit(")", 1)[1].split()
        sched = {key.strip(): value.strip() for line in (root / "sched").read_text().splitlines()
                 if ":" in line for key, value in [line.split(":", 1)]}
        status = dict(line.split(":", 1) for line in (root / "status").read_text().splitlines() if ":" in line)
        schedstat = [int(x) for x in (root / "schedstat").read_text().split()]
        # Ptrace policy can return '0' even for a sleeping task. Preserve it;
        # do not turn an unavailable channel into an idle/active assertion.
        wchan = (root / "wchan").read_text().strip()
        return {"pid": pid, "tid": tid, "name": status["Name"].strip(),
                "start_ticks": int(stat[19]), "state": stat[0], "last_cpu": int(stat[36]),
                "allowed": status["Cpus_allowed_list"].strip(),
                "runtime_ns": round(float(sched["se.sum_exec_runtime"].strip()) * 1e6),
                "migrations": int(sched["se.nr_migrations"].strip()),
                "voluntary": int(status["voluntary_ctxt_switches"].strip()),
                "involuntary": int(status["nonvoluntary_ctxt_switches"].strip()),
                "schedstat": schedstat, "wchan": wchan,
                "before_ns": before, "after_ns": time.monotonic_ns()}
    except (FileNotFoundError, ProcessLookupError):
        return None  # Normal thread exit; never synthesize zero CPU.


def terminal_snapshot(pid):
    return [s for p in sorted(Path(f"/proc/{pid}/task").glob("*"))
            if (s := task_snapshot(pid, int(p.name))) is not None]


def deltas(begin, end):
    old = {(s["pid"], s["tid"], s["start_ticks"]): s for s in begin}
    result = []
    for s in end:
        b = old.get((s["pid"], s["tid"], s["start_ticks"]))
        if b is None:
            continue  # Do not compare a recycled tid with the old task.
        elapsed = ((s["before_ns"] + s["after_ns"]) - (b["before_ns"] + b["after_ns"])) / 2
        row = {k: s[k] for k in ("pid", "tid", "name", "allowed")}
        row.update({k: s[k] - b[k] for k in ("runtime_ns", "migrations", "voluntary", "involuntary")})
        row.update(elapsed_ns=elapsed, snapshot_uncertainty_ns=(s["after_ns"] - s["before_ns"] + b["after_ns"] - b["before_ns"]),
                   off_cpu_residual_ns=elapsed - row["runtime_ns"],
                   # Last-CPU is a sample, not residency or a migration trace.
                   last_cpu_before=b["last_cpu"], last_cpu_after=s["last_cpu"])
        result.append(row)
    return result


def instrument(source):
    for anchor in (START, END, "def write_all(b):"):
        if source.count(anchor) != 1:
            raise ValueError(f"payload instrumentation anchor missing or ambiguous: {anchor}")
    source = source.replace("def write_all(b):", "def _payload_write_all(b):")
    source = source.replace(START, "            c0 = cpu(tpid)\n            _profile.begin(name, data, _, tpid)\n            t0 = time.perf_counter()")
    source = source.replace(END, "            t1 = time.perf_counter()\n            _profile.end(name, _, tpid, t1 - t0)\n            c1 = cpu(tpid)")
    # Preserve the original generator and write loop verbatim; only add a
    # two-clock wrapper per write_all, NOT per byte or per write syscall.
    prefix = """def write_all(b):
    if not _profile.active:
        return _payload_write_all(b)
    _wall, _cpu = time.monotonic_ns(), time.process_time_ns()
    try:
        return _payload_write_all(b)
    finally:
        _profile.writes.append({'bytes': len(b), 'wall_ns': time.monotonic_ns() - _wall,
                                'cpu_ns': time.process_time_ns() - _cpu})
"""
    return prefix + source


class Profile:
    def __init__(self):
        self.active = False
        self.passes = []

    def begin(self, name, data, index, pid):
        self.writes = []
        self.current = {"workload": name, "pass": index, "bytes": len(data),
                        "payload_sha256": hashlib.sha256(data).hexdigest()}
        self.current["terminal_before"] = terminal_snapshot(pid)
        self.current["producer_before"] = task_snapshot(os.getpid(), os.getpid())
        self.current["begin_ns"] = time.monotonic_ns()
        self.active = True

    def end(self, name, index, pid, wall):
        self.active = False
        c = self.current
        if (name, index) != (c["workload"], c["pass"]):
            raise ValueError("mismatched diagnostic pass")
        c["end_ns"] = time.monotonic_ns()
        c["producer_after"] = task_snapshot(os.getpid(), os.getpid())
        c["terminal_after"] = terminal_snapshot(pid)
        c.update(wall_s=wall, writes=self.writes)
        c["terminal_deltas"] = deltas(c["terminal_before"], c["terminal_after"])
        c["producer_deltas"] = deltas([c["producer_before"]], [c["producer_after"]])
        self.passes.append(c)


def observe(terminal, producer, interval_ms, path):
    # Discover only the hot threads once per sample; no unrelated process data,
    # environment, command lines, stack pointers or system-wide tracing.
    with Path(path).open("x") as output:
        while Path(f"/proc/{producer}").exists():
            before = time.monotonic_ns()
            tids = [terminal]
            for p in Path(f"/proc/{terminal}/task").glob("*"):
                try:
                    if (p / "comm").read_text().strip() in ("pty-read", "pty-parse"):
                        tids.append(int(p.name))
                except (FileNotFoundError, ProcessLookupError):
                    pass
            tasks = [task_snapshot(terminal, tid) for tid in sorted(set(tids))]
            tasks.append(task_snapshot(producer, producer))
            output.write(json.dumps({"before_ns": before, "tasks": [s for s in tasks if s],
                                     "after_ns": time.monotonic_ns()}, separators=(",", ":")) + "\n")
            output.flush()
            time.sleep(interval_ms / 1000)


def run(out, sample_ms):
    out = out.resolve()
    sidecar = out.with_suffix(".profile.json")
    samples = out.with_suffix(".samples.jsonl")
    derived = out.with_suffix(".producer.py")
    if any(p.exists() for p in (out, sidecar, samples, derived)):
        raise ValueError("refusing to replace existing diagnostic artifacts")
    source = instrument(PAYLOAD.read_text())
    derived.write_text(source)
    profile = Profile()
    pid = int(os.environ.get("BENCH_TERM_PID") or os.environ.get("KITTY_PID") or os.getppid())
    metadata = {"schema": "glass.pipeline-profile/v1", "complete": False,
                "sample_ms": sample_ms, "terminal_pid": pid, "producer_pid": os.getpid(),
                "payload_sha256": digest(PAYLOAD), "wrapper_sha256": digest(__file__),
                "derived_sha256": digest(derived), "producer_allowed": sorted(os.sched_getaffinity(0)),
                "sched_schedstats": Path("/proc/sys/kernel/sched_schedstats").read_text().strip(),
                "note": "Diagnostic overhead; off-CPU is not a blocked/runnable decomposition. Last-CPU samples are not residency."}
    sidecar.write_text(json.dumps(metadata, indent=2) + "\n")
    observer = None
    saved = sys.argv
    try:
        if sample_ms:
            observer = subprocess.Popen([sys.executable, "-I", str(Path(__file__).resolve()), "observe",
                                         str(pid), str(os.getpid()), str(sample_ms), str(samples)])
        sys.argv = [str(PAYLOAD), str(out)]
        namespace = {"__name__": "__main__", "__file__": str(PAYLOAD), "_profile": profile}
        exec(compile(source, str(derived), "exec"), namespace)
        if len(profile.passes) != 18:
            raise ValueError(f"expected 18 passes, got {len(profile.passes)}")
        metadata.update(complete=True, passes=profile.passes, result_sha256=digest(out))
    finally:
        sys.argv = saved
        if observer:
            observer.terminate()
            code = observer.wait(timeout=10)
            if code not in (-15, 0):
                metadata["complete"] = False
                metadata["observer_error"] = code
                sidecar.write_text(json.dumps(metadata, indent=2) + "\n")
                raise RuntimeError(f"observer exited {code}")
            metadata["samples_sha256"] = digest(samples)
        sidecar.write_text(json.dumps(metadata, indent=2) + "\n")


def main():
    p = argparse.ArgumentParser(description=__doc__)
    commands = p.add_subparsers(dest="command", required=True)
    r = commands.add_parser("run")
    r.add_argument("out", type=Path)
    r.add_argument("--sample-ms", type=float, default=5)
    o = commands.add_parser("observe")
    o.add_argument("terminal", type=int)
    o.add_argument("producer", type=int)
    o.add_argument("interval_ms", type=float)
    o.add_argument("path", type=Path)
    args = p.parse_args()
    if args.command == "run":
        if not 0 <= args.sample_ms <= 1000:
            p.error("sample-ms must be 0..1000")
        run(args.out, args.sample_ms)
    else:
        observe(args.terminal, args.producer, args.interval_ms, args.path)


if __name__ == "__main__":
    main()
