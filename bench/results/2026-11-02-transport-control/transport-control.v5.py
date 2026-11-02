#!/usr/bin/env python3
"""Linux causal control for producer placement, NOT a terminal benchmark.

Reuse tput.py's exact payload builder (AST-extracted definitions only), then
compare /dev/null, pipe, and raw-PTY transport to a minimal pinned C sink.
Fixed 64-KiB writes and 154x39 payloads; randomize all nine treatments per
block. Preserve every repetition, byte count, scheduler counter and hash.
"""
import argparse
import ast
import hashlib
import itertools
import json
import math
import os
from pathlib import Path
import random
import resource
import select
import statistics
import subprocess
import termios
import time
import tty

BENCH = Path(__file__).resolve().parents[1]
ARMS = ("auto", "large", "small")
TRANSPORTS = ("null", "pipe", "pty")
METRICS = ("ascii", "unicode", "scroll_region")


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def cpus(text):
    result = set()
    for part in text.split(","):
        edges = part.split("-")
        if len(edges) not in (1, 2) or not all(x.isdecimal() for x in edges):
            raise ValueError("invalid CPU list")
        lo, hi = int(edges[0]), int(edges[-1])
        if not 0 <= lo <= hi < 1024:
            raise ValueError("invalid CPU range")
        result.update(range(lo, hi + 1))
    if not result:
        raise ValueError("empty CPU list")
    return result


def payloads():
    # Do not execute terminal I/O or a locally rewritten workload generator.
    # These markers identify pre-existing AST statements, not substring code.
    path = BENCH / "tput.py"
    module = ast.parse(path.read_text(), filename=str(path))
    starts = [i for i, node in enumerate(module.body)
              if isinstance(node, ast.Assign) and any(isinstance(t, ast.Name) and t.id == "rng" for t in node.targets)]
    ends = [i for i, node in enumerate(module.body)
            if isinstance(node, ast.Assign) and any(isinstance(t, ast.Name) and t.id == "old" for t in node.targets)]
    if len(starts) != 1 or len(ends) != 1 or starts[0] >= ends[0]:
        raise ValueError("payload builder boundaries changed")
    selected = ast.Module(body=module.body[starts[0]:ends[0]], type_ignores=[])
    scope = {"random": random, "cols": 154, "rows": 39}
    exec(compile(selected, str(path), "exec"), scope)
    workloads = scope["W"]
    if set(workloads) != {"ascii", "unicode", "truecolor", "cursor_motion", "scroll_region", "tui_frames"}:
        raise ValueError("payload set changed")
    return {k: workloads[k] for k in METRICS}


def scheduler():
    fields = [int(x) for x in Path("/proc/self/schedstat").read_text().split()]
    if len(fields) != 3:
        raise ValueError("missing scheduler counters")
    return dict(zip(("runtime_ns", "runqueue_ns", "timeslices"), fields))


def usage():
    r = resource.getrusage(resource.RUSAGE_SELF)
    return {"user_us": round(r.ru_utime * 1e6), "system_us": round(r.ru_stime * 1e6),
            "voluntary": r.ru_nvcsw, "involuntary": r.ru_nivcsw, **scheduler()}


def line_with_timeout(stream, timeout=15):
    # Unbuffered subprocess stdout means select is not blind to a Python buffer.
    line, deadline = bytearray(), time.monotonic() + timeout
    while not line.endswith(b"\n"):
        remaining = deadline - time.monotonic()
        if remaining <= 0 or not select.select([stream], [], [], remaining)[0]:
            raise TimeoutError("sink handshake/report timeout")
        b = os.read(stream.fileno(), 1)
        if not b:
            raise RuntimeError("sink exited before report")
        line.extend(b)
        if len(line) > 4096:
            raise ValueError("oversize sink report")
    return bytes(line)


def measure(sink, data, repeats, transport, allowed, sink_cpus):
    initial = os.sched_getaffinity(0)
    process = None
    owned = set()
    try:
        os.sched_setaffinity(0, allowed)
        if os.sched_getaffinity(0) != allowed:
            raise ValueError("producer affinity did not apply")
        sink_meta = None
        if transport == "null":
            write_fd = os.open("/dev/null", os.O_WRONLY)
            owned.add(write_fd)
        else:
            if transport == "pipe":
                read_fd, write_fd = os.pipe()
            else:
                read_fd, write_fd = os.openpty()
                tty.setraw(write_fd, termios.TCSANOW)
                tty.setraw(read_fd, termios.TCSANOW)
            owned.update((read_fd, write_fd))
            process = subprocess.Popen([str(sink), str(read_fd), str(len(data) * repeats),
                                        *map(str, sorted(sink_cpus))], pass_fds=(read_fd,),
                                       stdout=subprocess.PIPE, stderr=subprocess.PIPE, bufsize=0)
            if line_with_timeout(process.stdout) != b"READY\n":
                raise ValueError("bad sink handshake")
            actual = os.sched_getaffinity(process.pid)
            if actual != sink_cpus:
                raise ValueError("sink mask did not apply")
            sink_meta = {"pid": process.pid, "allowed": sorted(actual)}
            # Only the child owns the read end during the trial. If it exits,
            # pipe writes fail with EPIPE and PTY writes with EIO, rather than
            # hanging because this parent kept a reader alive.
            os.close(read_fd)
            owned.remove(read_fd)
        before = usage()
        start = time.perf_counter_ns()
        write_calls = 0
        for _ in range(repeats):
            view = memoryview(data)
            while view:
                n = os.write(write_fd, view[:65536])
                if n <= 0:
                    raise RuntimeError("write made no progress")
                view = view[n:]
                write_calls += 1
        written = time.perf_counter_ns()
        after = usage()
        done = written
        if process is not None:
            result = json.loads(line_with_timeout(process.stdout))
            code = process.wait(timeout=15)
            errors = process.stderr.read().decode(errors="replace")
            if code or errors or result["bytes"] != len(data) * repeats:
                raise RuntimeError(f"sink failed: {code}, {errors}, {result}")
            if not start < result["done_ns"] <= time.perf_counter_ns():
                raise ValueError("sink clock mismatch")
            done = max(written, result["done_ns"])
            sink_meta.update(result)
        return {"bytes": len(data) * repeats, "payload_repetitions": repeats, "write_calls": write_calls,
                "start_ns": start, "write_end_ns": written, "done_ns": done,
                "elapsed_ns": done - start, "producer": {k: after[k] - before[k] for k in before},
                "producer_allowed": sorted(allowed), "sink": sink_meta,
                "mb_s": len(data) * repeats / ((done - start) / 1e9) / 1e6}
    finally:
        if process is not None and process.poll() is None:
            process.kill()
            process.wait(timeout=5)
        if process is not None:
            process.stdout.close()
            process.stderr.close()
        for fd in owned:
            os.close(fd)
        os.sched_setaffinity(0, initial)


def pvalue(wins, losses):
    n = wins + losses
    return min(1.0, 2 * sum(math.comb(n, k) for k in range(min(wins, losses) + 1)) / 2**n) if n else 1.0


def summarize(root):
    manifest = json.loads((root / "manifest.json").read_text())
    if not manifest["complete"]:
        raise ValueError("incomplete control run")
    for path, sha in manifest["files_sha256"].items():
        if digest(path) != sha:
            snapshots = [root.parent / f"transport-control.v{v}.py" for v in (1, 2, 3, 4)]
            if Path(path).name != "transport-control.py" or not any(p.exists() and digest(p) == sha for p in snapshots):
                raise ValueError(f"changed input: {path}")
    raw_path = root / "trials.jsonl"
    if digest(raw_path) != manifest["raw_sha256"]:
        raise ValueError("changed raw trials")
    trials = [json.loads(line) for line in raw_path.read_text().splitlines()]
    expected = list(itertools.product(TRANSPORTS, ARMS))
    if len(trials) != manifest["blocks"] * len(expected) * len(METRICS):
        raise ValueError("incomplete trial count")
    table = {}
    for trial in trials:
        key = trial["block"], trial["transport"], trial["arm"], trial["metric"]
        if key in table or trial["block"] not in range(manifest["blocks"]):
            raise ValueError("duplicate/unknown trial")
        if trial["bytes"] != manifest["payloads"][trial["metric"]]["bytes"] * manifest.get("repetitions_by_transport", {t: manifest["payload_repetitions"] for t in TRANSPORTS})[trial["transport"]]:
            raise ValueError("wrong byte count")
        if trial["producer_allowed"] != manifest["settings"][trial["arm"]]:
            raise ValueError("wrong producer mask")
        if trial["transport"] != "null" and (trial["sink"]["allowed"] != manifest["sink_cpus"] or trial["sink"]["bytes"] != trial["bytes"]):
            raise ValueError("wrong sink mask/count")
        if not trial["elapsed_ns"] > 0 or not trial["mb_s"] > 0:
            raise ValueError("invalid duration")
        table[key] = trial
    comparisons, medians = {}, {}
    for transport, metric in itertools.product(TRANSPORTS, METRICS):
        name = f"{transport}/{metric}"
        medians[name] = {}
        for arm in ARMS:
            values = [table[b, transport, arm, metric] for b in range(manifest["blocks"])]
            medians[name][arm] = {"mb_s": statistics.median(v["mb_s"] for v in values),
                "producer_cpu_fraction": statistics.median((v["producer"]["user_us"] + v["producer"]["system_us"]) * 1000 / v["elapsed_ns"] for v in values),
                "producer_runqueue_fraction": None if manifest["schedstats"] != "1" else statistics.median(v["producer"]["runqueue_ns"] / v["elapsed_ns"] for v in values),
                "producer_voluntary": statistics.median(v["producer"]["voluntary"] for v in values),
                "sink_cpu_fraction": None if transport == "null" else statistics.median((v["sink"]["user_us"] + v["sink"]["system_us"]) * 1000 / v["elapsed_ns"] for v in values)}
        comparisons[name] = {}
        for arm in ARMS[1:]:
            ratios = [table[b, transport, arm, metric]["mb_s"] / table[b, transport, "auto", metric]["mb_s"] for b in range(manifest["blocks"])]
            wins, losses = sum(r > 1 for r in ratios), sum(r < 1 for r in ratios)
            comparisons[name][arm] = {"ratios": ratios, "median_ratio": statistics.median(ratios),
                                     "wins": wins, "losses": losses, "sign_p_two_sided": pvalue(wins, losses)}
    report = {"schema": "glass.transport-control-summary/v1", "complete": True,
              "manifest_sha256": digest(root / "manifest.json"), "raw_sha256": digest(raw_path),
              "medians": medians, "comparisons_to_auto": comparisons,
              "note": "No parser, renderer, DA1, scrollback or terminal. Diagnostic only; uncorrected exploratory tests."}
    (root / "summary.json").write_text(json.dumps(report, indent=2) + "\n")
    for name, arms in comparisons.items():
        print(name, {a: (round(m["median_ratio"], 4), m["wins"], m["sign_p_two_sided"]) for a, m in arms.items()}, flush=True)
    return report


def run(args):
    root = args.out.resolve()
    root.mkdir(exist_ok=False)
    sink = args.sink.resolve()
    initial = os.sched_getaffinity(0)
    large, small = cpus(args.large), cpus(args.small)
    sink_cpus = cpus(args.sink_cpus) if args.sink_cpus else large
    if not sink_cpus <= initial or not large <= initial or not small <= initial or large & small:
        raise ValueError("masks must be disjoint allowed CPU subsets")
    data = payloads()
    settings = {"auto": initial, "large": large, "small": small}
    files = [Path(__file__).resolve(), BENCH / "tput.py", Path(__file__).with_name("transport-sink.c"), sink]
    orders = []
    rng = random.Random(args.seed)
    for _ in range(args.blocks):
        order = list(itertools.product(TRANSPORTS, ARMS))
        rng.shuffle(order)
        orders.append(order)
    manifest = {"schema": "glass.transport-control/v1", "complete": False,
                "blocks": args.blocks, "seed": args.seed, "orders": orders,
                "payload_repetitions": args.repeats, "repetitions_by_transport": {t: max(128, args.repeats) if t == "null" else args.repeats for t in TRANSPORTS}, "chunk_bytes": 65536, "geometry": [154, 39],
                "settings": {k: sorted(v) for k, v in settings.items()}, "sink_cpus": sorted(sink_cpus),
                "payloads": {k: {"bytes": len(v), "sha256": hashlib.sha256(v).hexdigest()} for k, v in data.items()},
                "files_sha256": {str(p): digest(p) for p in files},
                "machine": os.uname()._asdict() if hasattr(os.uname(), "_asdict") else list(os.uname()),
                "topology": subprocess.run(["lscpu", "-e=CPU,CORE,SOCKET,NODE,CACHE"], check=True, capture_output=True, text=True).stdout,
                "schedstats": Path("/proc/sys/kernel/sched_schedstats").read_text().strip(),
                "loadavg_before": Path("/proc/loadavg").read_text().strip(),
                "cpu_pressure_before": Path("/proc/pressure/cpu").read_text(),
                "note": "Raw PTY output processing disabled. Sink pinned to recorded sink_cpus; producer only randomized. New process per trial."}
    manifest_path = root / "manifest.json"
    manifest_path.write_text(json.dumps(manifest, indent=2) + "\n")
    # Untimed unreported warmup avoids compiling/building while timed work runs.
    for transport in TRANSPORTS:
        measure(sink, data["ascii"][:65536], 1, transport, initial, sink_cpus)
    with (root / "trials.jsonl").open("x", buffering=1) as raw:
        for block, order in enumerate(orders):
            for transport, arm in order:
                metrics = list(METRICS)
                rng.shuffle(metrics)
                for metric in metrics:
                    trial = measure(sink, data[metric], manifest["repetitions_by_transport"][transport], transport, settings[arm], sink_cpus)
                    trial.update(block=block, transport=transport, arm=arm, metric=metric)
                    raw.write(json.dumps(trial) + "\n")
            print(f"block {block + 1}/{args.blocks}", flush=True)
    manifest.update(complete=True, raw_sha256=digest(root / "trials.jsonl"),
                    loadavg_after=Path("/proc/loadavg").read_text().strip(),
                    cpu_pressure_after=Path("/proc/pressure/cpu").read_text())
    manifest_path.write_text(json.dumps(manifest, indent=2) + "\n")
    summarize(root)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    r = sub.add_parser("run")
    r.add_argument("out", type=Path)
    r.add_argument("--sink", type=Path, required=True)
    r.add_argument("--large", required=True)
    r.add_argument("--small", required=True)
    r.add_argument("--sink-cpus", help="reader CPU mask; defaults to --large")
    r.add_argument("--blocks", type=int, default=12)
    r.add_argument("--repeats", type=int, default=8)
    r.add_argument("--seed", type=int, default=179365)
    s = sub.add_parser("summarize")
    s.add_argument("root", type=Path)
    args = parser.parse_args()
    if args.command == "run":
        if not 1 <= args.blocks <= 48 or not 1 <= args.repeats <= 64:
            parser.error("blocks 1..48 and repeats 1..64 required")
        run(args)
    else:
        summarize(args.root)


if __name__ == "__main__":
    main()
