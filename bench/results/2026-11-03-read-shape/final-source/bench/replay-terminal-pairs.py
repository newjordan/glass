#!/usr/bin/env python3
"""Read-only, fail-closed replay of glass.terminal-pairs/v1 reports.

Independently recomputes summaries, launch orders, raw hashes and input shapes.
Checks the recorded runner/harness and, optionally, temporary executables.
Integrity/consistency only: not timing accuracy, presentation or a championship.
Run from any directory; no report is rewritten, even on a successful replay.
"""
import argparse
import hashlib
import itertools
import json
import math
from pathlib import Path
import statistics

WORKLOADS = ("ascii", "unicode", "truecolor", "cursor_motion", "scroll_region", "tui_frames")
SUPPORTED = {"glass", "glass-alt", "ghostty", "kitty", "foot", "alacritty"}
BENCH = Path(__file__).resolve().parent


def require(condition, message):
    if not condition:
        raise ValueError(message)


def unique_object(pairs):
    result = {}
    for key, value in pairs:
        require(key not in result, f"duplicate JSON key: {key}")
        result[key] = value
    return result


def load(path):
    return json.loads(Path(path).read_text(), object_pairs_hook=unique_object)


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def valid_digest(value):
    return isinstance(value, str) and len(value) == 64 and all(c in "0123456789abcdef" for c in value)


def positive_int(value):
    return type(value) is int and value > 0


def number(value, zero=False):
    return type(value) in (int, float) and math.isfinite(value) and (value >= 0 if zero else value > 0)


def sign_p(wins, losses):
    n = wins + losses
    return min(1., 2 * sum(math.comb(n, k) for k in range(min(wins, losses) + 1)) / 2 ** n)


def validate(out, verify_binaries=False):
    out = Path(out).resolve()
    report = load(out / "terminal-summary.json")
    require(report["schema"] == "glass.terminal-pairs/v1", "unknown schema")
    require(report["complete"] is True, "incomplete measurement")
    require("failure" not in report, "failed measurement")
    require(report["multiple_testing_corrected"] is False, "unsupported statistical claim")
    rounds, terms = report["rounds"], report["terms"]
    require(positive_int(rounds), "invalid rounds")
    require(isinstance(terms, list) and len(terms) >= 2 and all(isinstance(t, str) for t in terms)
            and len(set(terms)) == len(terms) and set(terms) <= SUPPORTED, "invalid terminal arms")
    orders = list(itertools.permutations(terms))
    require(report["orders"] == [list(orders[i % len(orders)]) for i in range(rounds)], "invalid launch order")
    require(valid_digest(report["runner_sha256"]), "invalid runner digest")
    require(digest(BENCH / "compare-tput.py") == report["runner_sha256"], "runner changed")
    harness = report["harness_sha256"]
    require(set(harness) == {str(BENCH / name) for name in ("run-tput.sh", "lib.sh", "tput.py")}, "invalid harness set")
    for path, expected in harness.items():
        require(valid_digest(expected) and digest(path) == expected, f"harness changed: {path}")
    require(set(report["binaries"]) == set(terms), "invalid binary arms")
    for term, binary in report["binaries"].items():
        require(isinstance(binary["path"], str) and Path(binary["path"]).is_absolute(), f"invalid binary path: {term}")
        require(valid_digest(binary["sha256"]), f"invalid binary digest: {term}")
        if verify_binaries:
            require(digest(binary["path"]) == binary["sha256"], f"binary changed: {term}")

    expected_paths = {f"terminal/tput-{term}-{r}.json" for term in terms for r in range(1, rounds + 1)}
    require(set(report["raw_sha256"]) == expected_paths, "invalid raw manifest")
    require({str(p.relative_to(out)) for p in (out / "terminal").glob("tput-*.json")} == expected_paths,
            "unexpected raw file set")
    grids, counts, data, hashes = set(), {}, {}, {}
    for term in terms:
        data[term] = []
        for r in range(1, rounds + 1):
            relative = f"terminal/tput-{term}-{r}.json"
            path = out / relative
            require(not path.is_symlink() and path.resolve().is_relative_to(out), f"invalid raw source: {relative}")
            expected = report["raw_sha256"][relative]
            require(valid_digest(expected) and digest(path) == expected, f"raw hash changed: {relative}")
            hashes[relative] = expected
            raw = load(path)
            require(set(raw) == {"cols", "rows", "results"}, f"invalid raw fields: {relative}")
            require(positive_int(raw["cols"]) and positive_int(raw["rows"]), f"invalid geometry: {relative}")
            grids.add((raw["cols"], raw["rows"]))
            require(set(raw["results"]) == set(WORKLOADS), f"invalid workloads: {relative}")
            for name, row in raw["results"].items():
                fields = {"bytes", "secs", "mb_s", "term_cpu_s"} | ({"fps"} if name == "tui_frames" else set())
                require(set(row) == fields, f"invalid result fields: {relative}/{name}")
                count, secs, rate = row["bytes"], row["secs"], row["mb_s"]
                require(positive_int(count), f"invalid byte count: {relative}/{name}")
                require(counts.setdefault(name, count) == count, f"changed byte count: {relative}/{name}")
                require(isinstance(secs, list) and len(secs) == 3 and all(number(x) for x in secs),
                        f"invalid samples: {relative}/{name}")
                require(number(rate) and number(row["term_cpu_s"], zero=True), f"invalid rate/CPU: {relative}/{name}")
                # tput.py stores milliseconds and 0.1 MB/s, not exact times.
                # Require intersecting rounding intervals, never equality of a
                # rate recomputed from an already-rounded fastest sample.
                lower = count / ((rate + .05) * 1e6)
                upper = count / (max(rate - .05, 1e-300) * 1e6)
                require(lower <= min(secs) + .0005 + 1e-12 and upper >= min(secs) - .0005 - 1e-12,
                        f"rate/time mismatch: {relative}/{name}")
                if name == "tui_frames":
                    fps = row["fps"]
                    require(number(fps), f"invalid fps: {relative}")
                    # The hashed tput.py uses 300 frames; both independently
                    # rounded rates must admit the very same unrounded time.
                    require(max(lower, 300 / (fps + .05), min(secs) - .0005)
                            <= min(upper, 300 / max(fps - .05, 1e-300), min(secs) + .0005) + 1e-12,
                            f"frame-rate mismatch: {relative}")
            data[term].append(raw)
    require(len(grids) == 1 and report["geometry"] == [list(g) for g in sorted(grids)], "changed geometry")
    comparisons = {}
    for other in terms[1:]:
        comparisons[other] = {}
        for name in WORKLOADS:
            ratios = [a["results"][name]["mb_s"] / b["results"][name]["mb_s"]
                      for a, b in zip(data[terms[0]], data[other])]
            wins, losses = sum(x > 1 for x in ratios), sum(x < 1 for x in ratios)
            comparisons[other][name] = {"median_ratio": statistics.median(ratios), "wins": wins, "losses": losses,
                                        "ties": rounds - wins - losses, "sign_p_two_sided": sign_p(wins, losses),
                                        "ratios": ratios}
    medians = {term: {name: statistics.median(d["results"][name]["mb_s"] for d in ds) for name in WORKLOADS}
               for term, ds in data.items()}
    # Canonical JSON comparison rejects booleans substituted for numeric fields
    # (Python's ordinary equality would otherwise treat True as 1).
    canonical = lambda value: json.dumps(value, sort_keys=True, allow_nan=False)
    require(canonical(report["comparisons"]) == canonical(comparisons), "comparison summary mismatch")
    require(canonical(report["medians_mb_s"]) == canonical(medians), "median summary mismatch")
    return {"directory": str(out), "report_sha256": digest(out / "terminal-summary.json"),
            "sessions": len(hashes), "rounds": rounds, "geometry": report["geometry"],
            "binaries_checked": verify_binaries, "note": "Read-only integrity replay, not timing accuracy."}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directories", nargs="+", type=Path)
    parser.add_argument("--verify-binaries", action="store_true")
    args = parser.parse_args()
    for directory in args.directories:
        print(json.dumps(validate(directory, args.verify_binaries), sort_keys=True))


if __name__ == "__main__":
    main()
