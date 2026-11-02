#!/usr/bin/env python3
"""Balanced paired engine measurements; raw output and provenance are retained.

This is a diagnostic, not a substitute for the through-pty terminal gate.
Build both test executables with identical cargo flags, copy them out of target,
then run: engine-pairs.py BASE CANDIDATE --out results.json --pairs 7
"""
import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import re
import statistics
import subprocess

LINE = re.compile(r"^\s*(\w+):\s+([\d.]+) MB/s\s+([\d.]+) MB/cpu-s\s+\((\d+) bytes, read (\d+)\)", re.M)


def sign_p(wins, losses):
    n = wins + losses
    return min(1.0, 2 * sum(math.comb(n, k) for k in range(min(wins, losses) + 1)) / 2**n)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("base", type=Path)
    p.add_argument("candidate", type=Path)
    p.add_argument("--out", required=True, type=Path)
    p.add_argument("--pairs", type=int, default=7)
    p.add_argument("--scale", type=float, default=1.0)
    p.add_argument("--rounds", type=int, default=3)
    p.add_argument("--only", default="ascii,unicode,truecolor,cursor_motion,scroll_region,tui_frames")
    args = p.parse_args()
    if args.pairs < 1 or args.rounds < 1 or not math.isfinite(args.scale) or args.scale <= 0:
        p.error("pairs, rounds and scale must be positive")
    paths = {"base": args.base.resolve(), "candidate": args.candidate.resolve()}
    env = {k: v for k, v in os.environ.items() if not k.startswith("GLASS_")}
    env.update(GLASS_BENCH_SCALE=str(args.scale), GLASS_BENCH_ROUNDS=str(args.rounds), GLASS_BENCH_ONLY=args.only)
    report = {
        "schema": "glass.engine-pairs/v1", "settings": {k: v for k, v in env.items() if k.startswith("GLASS_")},
        "binaries": {k: {"path": str(v), "sha256": hashlib.sha256(v.read_bytes()).hexdigest()} for k, v in paths.items()},
        "pairs": [],
    }
    args.out.parent.mkdir(parents=True, exist_ok=True)
    expected = set(args.only.split(","))
    for i in range(args.pairs):
        pair = {}
        order = ["base", "candidate"] if i % 2 == 0 else ["candidate", "base"]
        for arm in order:
            proc = subprocess.run([str(paths[arm]), "--ignored", "--exact", "--nocapture", "speed::speed"], env=env, capture_output=True, text=True, timeout=600)
            pair[arm] = {"exit": proc.returncode, "stdout": proc.stdout, "stderr": proc.stderr}
            rows = {m[0]: {"mb_s": float(m[1]), "mb_cpu_s": float(m[2]), "bytes": int(m[3]), "read": int(m[4])} for m in LINE.findall(proc.stderr)}
            pair[arm]["results"] = rows
            if proc.returncode != 0 or set(rows) != expected or any(r["mb_cpu_s"] <= 0 or r["mb_s"] <= 0 for r in rows.values()):
                report["failure"] = {"pair": i, "arm": arm, "result": pair[arm]}
                args.out.write_text(json.dumps(report, indent=2) + "\n")
                raise RuntimeError(f"invalid benchmark {arm} pair {i}: {proc.stderr}")
        for name in expected:
            a, b = (pair[arm]["results"][name] for arm in ("base", "candidate"))
            if (a["bytes"], a["read"]) != (b["bytes"], b["read"]):
                raise RuntimeError(f"incompatible workload {name}")
        report["pairs"].append({"order": order, **pair})
        args.out.write_text(json.dumps(report, indent=2) + "\n")
        print(f"pair {i + 1}/{args.pairs} recorded", flush=True)
    summary = {}
    for name in sorted(expected):
        ratios = [pair["candidate"]["results"][name]["mb_cpu_s"] / pair["base"]["results"][name]["mb_cpu_s"] for pair in report["pairs"]]
        wins, losses = sum(r > 1 for r in ratios), sum(r < 1 for r in ratios)
        summary[name] = {"median_cpu_ratio": statistics.median(ratios), "wins": wins, "losses": losses, "sign_p_two_sided": sign_p(wins, losses)}
    report["summary"] = summary
    args.out.write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    main()
