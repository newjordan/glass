#!/usr/bin/env python3
"""Fail-closed paired terminal throughput comparison, via run-tput.sh.

Example (18 rounds balance all six launch permutations of three arms)::
    GLASS=/path/candidate GLASS_ALT=/path/control \
      python3 bench/compare-tput.py results --rounds 18

Term names resolve through bench/lib.sh. Completed reports include raw JSON
hashes, binaries, launch order, geometry, paired ratios and exact two-sided
sign tests. Sign tests are exploratory, not corrected for multiple metrics.
Do not run competing benchmarks concurrently. The fastest of three samples
within a terminal is still tput.py's estimator, not three independent runs.
"""
import argparse
import hashlib
import itertools
import json
import math
import os
from pathlib import Path
import shutil
import statistics
import subprocess

WORKLOADS = ("ascii", "unicode", "truecolor", "cursor_motion", "scroll_region", "tui_frames")
ENV_BIN = {"glass": "GLASS", "glass-alt": "GLASS_ALT", "ghostty": "GHOSTTY",
           "kitty": "KITTY", "foot": "FOOT", "alacritty": "ALACRITTY"}


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def sign_p(wins, losses):
    n = wins + losses
    return min(1., 2 * sum(math.comb(n, k) for k in range(min(wins, losses) + 1)) / 2**n)


def summarize(out, terms, rounds):
    grids, raw, data, byte_counts = set(), {}, {}, {}
    for term in terms:
        data[term] = []
        for r in range(1, rounds + 1):
            path = out / "terminal" / f"tput-{term}-{r}.json"
            d = json.loads(path.read_text())
            grid = d["cols"], d["rows"]
            if any(type(n) is not int or n <= 0 for n in grid):
                raise ValueError(f"invalid geometry: {path}")
            grids.add(grid)
            if set(d["results"]) != set(WORKLOADS):
                raise ValueError(f"incomplete workloads: {path}")
            for name, result in d["results"].items():
                count = result["bytes"]
                if type(count) is not int or count <= 0:
                    raise ValueError(f"invalid {name} byte count: {path}")
                if byte_counts.setdefault(name, count) != count:
                    raise ValueError(f"incompatible {name} byte counts: {path}")
                secs = result["secs"]
                if len(secs) != 3 or any(type(v) not in (int, float) or not math.isfinite(v) or v <= 0 for v in secs):
                    raise ValueError(f"invalid {name} samples: {path}")
                for key in ("mb_s", "term_cpu_s"):
                    value = result[key]
                    if type(value) not in (int, float) or not math.isfinite(value) or value < 0 or (key == "mb_s" and value == 0):
                        raise ValueError(f"invalid {name} {key}: {path}")
                if name == "tui_frames" and (not math.isfinite(result["fps"]) or result["fps"] <= 0):
                    raise ValueError(f"invalid fps: {path}")
            raw[str(path.relative_to(out))] = digest(path)
            data[term].append(d)
    if len(grids) != 1:
        raise ValueError(f"incompatible geometries: {sorted(grids)}")
    comparisons = {}
    for other in terms[1:]:
        comparisons[other] = {}
        for name in WORKLOADS:
            ratios = [a["results"][name]["mb_s"] / b["results"][name]["mb_s"]
                      for a, b in zip(data[terms[0]], data[other])]
            w, l = sum(x > 1 for x in ratios), sum(x < 1 for x in ratios)
            comparisons[other][name] = {"median_ratio": statistics.median(ratios),
                "wins": w, "losses": l, "ties": rounds - w - l,
                "sign_p_two_sided": sign_p(w, l), "ratios": ratios}
    return {"geometry": sorted(grids), "comparisons": comparisons, "raw_sha256": raw,
            "medians_mb_s": {t: {n: statistics.median(d["results"][n]["mb_s"] for d in ds)
                                    for n in WORKLOADS} for t, ds in data.items()}}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("out", type=Path)
    p.add_argument("--terms", default="glass,glass-alt,ghostty")
    p.add_argument("--rounds", type=int, default=18)
    p.add_argument("--summarize-only", action="store_true")
    args = p.parse_args()
    terms = args.terms.split(",")
    if len(terms) < 2 or len(set(terms)) != len(terms) or any(t not in ENV_BIN for t in terms):
        p.error("specify two or more distinct supported terminal names")
    if args.rounds <= 0:
        p.error("rounds must be positive")
    out = args.out.resolve()
    report_path = out / "terminal-summary.json"
    if args.summarize_only:
        report = json.loads(report_path.read_text())
        if report["terms"] != terms or report["rounds"] != args.rounds:
            p.error("terms/rounds must match the recorded run")
        permutations = list(itertools.permutations(terms))
        expected_orders = [list(permutations[i % len(permutations)]) for i in range(args.rounds)]
        if report["orders"] != expected_orders:
            p.error("cannot summarize an incomplete or differently ordered run")
        for binary in report["binaries"].values():
            if digest(binary["path"]) != binary["sha256"]:
                p.error(f"recorded binary changed: {binary['path']}")
        for path, sha in report.get("harness_sha256", {}).items():
            if digest(path) != sha:
                p.error(f"recorded harness changed: {path}")
    else:
        # Never replace old measurements. An interrupted run retains its
        # incomplete report and raw evidence; use a fresh directory to rerun.
        out.mkdir(parents=True, exist_ok=False)
        binaries = {}
        for t in terms:
            binary = os.environ.get(ENV_BIN[t], t)
            path = shutil.which(binary)
            if path is None:
                raise FileNotFoundError(binary)
            binaries[t] = {"path": str(Path(path).resolve()), "sha256": digest(path)}
        harness = Path(__file__).resolve().parent
        harness_sha256 = {str(harness / name): digest(harness / name)
                          for name in ("run-tput.sh", "lib.sh", "tput.py")}
        bench_env = {k: v for k, v in os.environ.items() if not k.startswith("GLASS_") and k != "GLASS"}
        bench_env.update({ENV_BIN[t]: binary["path"] for t, binary in binaries.items()})
        report = {"schema": "glass.terminal-pairs/v1", "harness_sha256": harness_sha256, "rounds": args.rounds,
                  "terms": terms, "binaries": binaries, "orders": [],
                  "runner_sha256": digest(__file__),
                  "experiment_env": {k: v for k, v in bench_env.items() if k.startswith("GLASS")},
                  "complete": False, "multiple_testing_corrected": False}
        report_path.write_text(json.dumps(report, indent=2) + "\n")
        permutations = list(itertools.permutations(terms))
        runner = Path(__file__).resolve().with_name("run-tput.sh")
        with (out / "terminal.log").open("w") as log:
            for r in range(1, args.rounds + 1):
                order = permutations[(r - 1) % len(permutations)]
                env = dict(bench_env, TERMS=" ".join(order), ROUNDS=str(r), OUT=str(out / "terminal"))
                subprocess.run(["bash", str(runner)], env=env, stdout=log, stderr=subprocess.STDOUT,
                               timeout=3600, check=True)
                # run-tput.sh can print 'no result' and exit 0; a full shape
                # check per round prevents that from becoming a success here.
                summarize(out, terms, r)
                report["orders"].append(list(order))
                report_path.write_text(json.dumps(report, indent=2) + "\n")
                print(f"round {r}/{args.rounds}: {' '.join(order)}", flush=True)
        for binary in binaries.values():
            if digest(binary["path"]) != binary["sha256"]:
                raise ValueError(f"binary changed during comparison: {binary['path']}")
        for path, sha in harness_sha256.items():
            if digest(path) != sha:
                raise ValueError(f"harness changed during comparison: {path}")
    summary = summarize(out, terms, args.rounds)
    if args.summarize_only and report.get("raw_sha256") != summary["raw_sha256"]:
        p.error("recorded raw measurements changed")
    report.update(summary)
    report["complete"] = True
    report_path.write_text(json.dumps(report, indent=2) + "\n")
    for term, metrics in report["comparisons"].items():
        print(f"{terms[0]} / {term}:")
        for name, m in metrics.items():
            print(f"  {name:14} {m['median_ratio']:.4f} {m['wins']}/{args.rounds} wins p={m['sign_p_two_sided']:.6g}")


if __name__ == "__main__":
    main()
