#!/usr/bin/env python3
"""Independently validate/replay a retained engine-pairs/v1 report, without reruns.

Checks raw output against parsed rows, paired workload identity, launch order,
and every summary field. Optionally require the exact recorded executables.
This validates report consistency, NOT timing accuracy or terminal performance.
"""
import argparse
import hashlib
import json
import math
from pathlib import Path
import re
import statistics

ROW = re.compile(r"^\s*(\w+):\s+([\d.]+) MB/s\s+([\d.]+) MB/cpu-s\s+\((\d+) bytes, read (\d+)\)", re.M)
ARMS = ("base", "candidate")
WORKLOADS = {"ascii", "unicode", "truecolor", "cursor_motion", "scroll_region", "tui_frames"}


def require(condition, message):
    if not condition:
        raise ValueError(message)


def unique_object(pairs):
    result = {}
    for key, value in pairs:
        require(key not in result, f"duplicate JSON key: {key}")
        result[key] = value
    return result


def validate(report, verify_binaries=False, expected_pairs=None):
    require(report.get("schema") == "glass.engine-pairs/v1", "unknown schema")
    require("failure" not in report, "failed measurement")
    settings = report["settings"]
    names = settings["GLASS_BENCH_ONLY"].split(",")
    expected = set(names)
    require(bool(expected) and len(names) == len(expected) and expected <= WORKLOADS, "invalid workload selection")
    scale, rounds = float(settings["GLASS_BENCH_SCALE"]), int(settings["GLASS_BENCH_ROUNDS"])
    require(math.isfinite(scale) and scale > 0 and rounds > 0, "invalid settings")
    binaries = report["binaries"]
    require(set(binaries) == set(ARMS), "invalid binary arms")
    for arm in ARMS:
        entry = binaries[arm]
        require(isinstance(entry["path"], str) and bool(entry["path"]), "missing binary path")
        require(re.fullmatch(r"[a-f0-9]{64}", entry["sha256"]) is not None, "invalid binary hash")
        if verify_binaries:
            require(hashlib.sha256(Path(entry["path"]).read_bytes()).hexdigest() == entry["sha256"], f"changed binary: {arm}")
    pairs = report["pairs"]
    require(isinstance(pairs, list) and bool(pairs), "no pairs")
    require(expected_pairs is None or len(pairs) == expected_pairs, "unexpected pair count")
    workload_shapes = {}
    for i, pair in enumerate(pairs):
        require(pair["order"] == list(ARMS if i % 2 == 0 else reversed(ARMS)), f"wrong order: pair {i}")
        for arm in ARMS:
            entry = pair[arm]
            require(type(entry["exit"]) is int and entry["exit"] == 0, f"nonzero exit: {i}/{arm}")
            require(isinstance(entry["stdout"], str), f"invalid stdout: {i}/{arm}")
            matches = ROW.findall(entry["stderr"])
            require(len(matches) == len(expected) and {m[0] for m in matches} == expected, f"missing/duplicate rows: {i}/{arm}")
            parsed = {m[0]: {"mb_s": float(m[1]), "mb_cpu_s": float(m[2]), "bytes": int(m[3]), "read": int(m[4])} for m in matches}
            require(parsed == entry["results"], f"raw/parsed mismatch: {i}/{arm}")
            for name, row in parsed.items():
                require(all(math.isfinite(row[k]) and row[k] > 0 for k in ("mb_s", "mb_cpu_s")), f"invalid rates: {i}/{arm}/{name}")
                require(row["bytes"] > 0 and row["read"] > 0, f"invalid shape: {i}/{arm}/{name}")
                shape = row["bytes"], row["read"]
                require(workload_shapes.setdefault(name, shape) == shape, f"changed shape: {i}/{arm}/{name}")
    summary = {}
    for name in sorted(expected):
        ratios = [pair["candidate"]["results"][name]["mb_cpu_s"] / pair["base"]["results"][name]["mb_cpu_s"] for pair in pairs]
        wins, losses = sum(r > 1 for r in ratios), sum(r < 1 for r in ratios)
        n = wins + losses
        p = min(1.0, 2 * sum(math.comb(n, k) for k in range(min(wins, losses) + 1)) / 2 ** n)
        summary[name] = {"median_cpu_ratio": statistics.median(ratios), "wins": wins, "losses": losses, "sign_p_two_sided": p}
    require(report.get("summary") == summary, "summary mismatch or incomplete report")
    return summary


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("reports", nargs="+", type=Path)
    parser.add_argument("--verify-binaries", action="store_true")
    parser.add_argument("--pairs", type=int, help="require exact completed pair count")
    args = parser.parse_args()
    if args.pairs is not None and args.pairs <= 0:
        parser.error("--pairs must be positive")
    for path in args.reports:
        raw = path.read_bytes()
        report = json.loads(raw, object_pairs_hook=unique_object)
        summary = validate(report, args.verify_binaries, args.pairs)
        print(json.dumps({"path": str(path), "sha256": hashlib.sha256(raw).hexdigest(), "pairs": len(report["pairs"]), "summary": summary}, sort_keys=True))


if __name__ == "__main__":
    main()
