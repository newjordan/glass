#!/usr/bin/env python3
"""Validate/replay alternating quiet DA1 sessions; never key-to-screen latency."""
import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import statistics

TERMS = ("glass", "glass-alt")
BENCH = Path(__file__).resolve().parent


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def unique_object(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f"duplicate JSON key: {key}")
        result[key] = value
    return result


def load(path):
    return json.loads(Path(path).read_text(), object_pairs_hook=unique_object)


def start(out):
    rounds, n = int(os.environ["ROUNDS"]), int(os.environ["N"])
    if rounds <= 0 or n <= 0:
        raise ValueError("positive rounds and samples required")
    paths = {term: Path(os.environ[env]).resolve()
             for term, env in zip(TERMS, ("GLASS", "GLASS_ALT"))}
    for path in paths.values():
        if not path.is_file() or not os.access(path, os.X_OK):
            raise ValueError(f"not an executable: {path}")
    report = {"schema": "glass.paired-pty-rtt/v1", "rounds": rounds,
              "samples_per_run": n, "protocol": "alternating AB/BA quiet DA1",
              "binaries": {t: {"path": str(p), "sha256": digest(p)} for t, p in paths.items()},
              "harness_sha256": {str(BENCH / p): digest(BENCH / p) for p in
                                 ("lib.sh", "pty-rtt.py", "run-pty-rtt.sh", "summarize-pty-rtt.py")}}
    with (out / "start.json").open("x") as stream:
        stream.write(json.dumps(report, indent=2) + "\n")


def summarize(out):
    report = load(out / "start.json")
    if report["schema"] != "glass.paired-pty-rtt/v1":
        raise ValueError("unknown provenance schema")
    rounds, n = report["rounds"], report["samples_per_run"]
    if type(rounds) is not int or rounds <= 0 or type(n) is not int or n <= 0:
        raise ValueError("invalid session shape")
    if set(report["binaries"]) != set(TERMS):
        raise ValueError("incorrect executable set")
    for artifact in report["binaries"].values():
        if digest(artifact["path"]) != artifact["sha256"]:
            raise ValueError(f"executable changed: {artifact['path']}")
    expected_harness = {str(BENCH / p) for p in
                        ("lib.sh", "pty-rtt.py", "run-pty-rtt.sh", "summarize-pty-rtt.py")}
    if set(report["harness_sha256"]) != expected_harness:
        raise ValueError("incorrect harness set")
    for path, sha in report["harness_sha256"].items():
        if digest(path) != sha:
            raise ValueError(f"harness changed: {path}")
    expected_order = [f"{r} {t}" for r in range(1, rounds + 1)
                      for t in (TERMS if r % 2 else TERMS[::-1])]
    if (out / "order.txt").read_text().splitlines() != expected_order:
        raise ValueError("missing, duplicate or reordered sessions")
    expected_files = {f"rtt-{t}-{r}.json" for t in TERMS for r in range(1, rounds + 1)}
    if {p.name for p in out.glob("rtt-*.json")} != expected_files:
        raise ValueError("unexpected raw file set")
    medians, pooled, hashes = {}, {}, {}
    reply = None
    for term in TERMS:
        medians[term], pooled[term] = [], []
        for r in range(1, rounds + 1):
            path = out / f"rtt-{term}-{r}.json"
            raw = load(path)
            samples = raw["samples_ms"]
            if (raw["schema"] != "glass.pty-rtt/v1" or type(raw["n"]) is not int
                    or raw["n"] != n or raw["quiet_ms"] != 3 or len(samples) != n
                    or any(type(v) not in (int, float) or not math.isfinite(v) or v <= 0 for v in samples)):
                raise ValueError(f"invalid samples: {path}")
            encoded = bytes.fromhex(raw["reply_hex"])
            if not encoded.startswith(b"\x1b[?") or not encoded.endswith(b"c") or len(encoded) > 256:
                raise ValueError(f"invalid reply: {path}")
            if reply is not None and reply != encoded:
                raise ValueError(f"changed reply: {path}")
            reply = encoded
            ordered = sorted(samples)
            expected = {"median_ms": statistics.median(samples), "p90_ms": ordered[int(n * .9)],
                        "p99_ms": ordered[int(n * .99)], "min_ms": min(samples), "max_ms": max(samples)}
            if any(raw[key] != value for key, value in expected.items()):
                raise ValueError(f"raw summary disagrees: {path}")
            medians[term].append(expected["median_ms"])
            pooled[term].extend(samples)
            hashes[path.name] = digest(path)
    summary = {"provenance": report, "raw_sha256": hashes,
               "order_sha256": digest(out / "order.txt"),
               "note": "Samples correlated within sessions. Not key-to-screen latency."}
    for term in TERMS:
        values = sorted(pooled[term])
        summary[term] = {"run_medians_ms": medians[term],
                         "median_of_run_medians_ms": statistics.median(medians[term]),
                         "pooled_median_ms": statistics.median(values),
                         "pooled_p90_ms": values[int(len(values) * .9)],
                         "pooled_p99_ms": values[int(len(values) * .99)]}
    summary["paired_run_median_deltas_ms"] = [a - b for a, b in zip(medians[TERMS[0]], medians[TERMS[1]])]
    path = out / "summary.json"
    if path.exists():
        if load(path) != summary:
            raise ValueError("summary replay differs")
    else:
        with path.open("x") as stream:
            stream.write(json.dumps(summary, indent=2) + "\n")
    return summary


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path)
    parser.add_argument("--start", action="store_true")
    args = parser.parse_args()
    if args.start:
        start(args.directory)
    else:
        print(json.dumps(summarize(args.directory), indent=2))


if __name__ == "__main__":
    main()
