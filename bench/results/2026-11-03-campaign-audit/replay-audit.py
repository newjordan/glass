#!/usr/bin/env python3
"""Frozen iteration-15 read-only audit; run from the workspace root.

No measurement processes are launched. Original artifacts are never rewritten.
Discovery here inventories supported/unsupported *reports*, not fallback sources
for hash validation. The historical verifier reads only its explicit index.
"""
import hashlib
import importlib.util
import json
import math
from pathlib import Path
import statistics
import struct

OUT = Path("bench/results/2026-11-03-campaign-audit")
BENCH = Path("bench")


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def load(path):
    return json.loads(path.read_text())


def signs(ratios):
    wins, losses = sum(x > 1 for x in ratios), sum(x < 1 for x in ratios)
    n = wins + losses
    p = min(1., 2 * sum(math.comb(n, k) for k in range(min(wins, losses) + 1)) / 2**n)
    med = statistics.median(ratios)
    return dict(median_ratio=med, wins=wins, losses=losses, ties=len(ratios)-n,
                sign_p_two_sided=p, gain_to_median_parity=1/med-1, ratios=ratios)


def compare(directory, arm):
    report = load(directory / "terminal-summary.json")
    results = {}
    for work in terminal.WORKLOADS:
        ratios = []
        for r in range(1, report["rounds"] + 1):
            a = load(directory / "terminal" / f"tput-{arm}-{r}.json")
            b = load(directory / "terminal" / f"tput-ghostty-{r}.json")
            ratios.append(a["results"][work]["mb_s"] / b["results"][work]["mb_s"])
        results[work] = signs(ratios)
    prior = 0.
    for i, name in enumerate(sorted(results, key=lambda n: results[n]["sign_p_two_sided"])):
        prior = min(1., max(prior, (6-i)*results[name]["sign_p_two_sided"]))
        results[name]["holm_six_workload_p"] = prior
        results[name]["exploratory_positive_lead"] = prior <= .05 and results[name]["median_ratio"] > 1
    return dict(source=str(directory), source_sha256=sha(directory/"terminal-summary.json"),
                arm=arm, binary=report["binaries"][arm], ghostty=report["binaries"]["ghostty"],
                rounds=report["rounds"], workloads=results,
                note="Retrospective six-workload comparator family, not campaign-wide correction; median parity is not superiority.")


history = module("history", BENCH / "replay-evidence-index.py")
terminal = module("terminal", BENCH / "replay-terminal-pairs.py")
engine = module("engine", BENCH / "replay-engine-pairs.py")
diagnostic = module("diagnostic", BENCH / "linux/analyze-read-shape.py")
rtt = module("rtt", BENCH / "summarize-pty-rtt.py")
index = OUT / "historical-index.json"
# Input snapshots are explicit and pinned; include their bytes before and after.
protected = {index}
for entry in load(index)["manifests"]:
    p = Path(entry["path"])
    protected.add(p)
    manifest = load(p)
    for source in manifest.get("sha256", manifest):
        original = (Path(entry["source_root"]) / source).as_posix()
        protected.add(Path(entry["snapshots"].get(original, original)))
for p in Path("bench/results").glob("*/**/terminal-summary.json"):
    if "/baseline/" not in str(p):
        protected.add(p)
        protected.update((p.parent / "terminal").glob("tput-*.json"))
engine_paths = set(Path("bench/results").glob("*/**/engine-pairs*.json"))
# Replications use historical filenames different from the primary pair reports.
engine_paths.update(Path(p) for p in (
    "bench/results/2026-11-02-validated-scalar/unicode-replication.json",
    "bench/results/2026-11-02-word-decode/engine-replication.json",
    "bench/results/2026-11-03-region-index/engine-replication.json",
    "bench/results/2026-11-03-row-alignment/engine-replication.json",
))
engine_paths = sorted(p for p in engine_paths if "/baseline/" not in str(p))
protected.update(engine_paths)
# This fingerprint demonstrates no changes to the audited evidence; not authorship.
before = {str(p): sha(p) for p in sorted(protected)}
result = {"schema": "glass.campaign-audit/v1", "historical_integrity": history.validate(Path.cwd(), load(index))}
terminal_rows = []
for path in sorted(Path("bench/results").glob("*/**/terminal-summary.json")):
    if "/baseline/" in str(path):
        continue
    report = load(path)
    row = dict(path=str(path), sha256=sha(path), schema=report.get("schema"), rounds=report.get("rounds"))
    if report.get("schema") != "glass.terminal-pairs/v1":
        row.update(status="legacy_schema_not_validated")
    elif report.get("complete") is not True:
        row.update(status="incomplete_not_validated")
    else:
        try:
            row.update(status="replayed", receipt=terminal.validate(path.parent))
        except KeyError as error:
            # Missing provenance is explicitly not repaired or silently ignored.
            assert error.args == ("runner_sha256",), error
            row.update(status="unsupported_missing_provenance", diagnostic=str(error))
    terminal_rows.append(row)
result["terminal_inventory"] = terminal_rows
result["terminal_replayed_sessions"] = sum(r["receipt"]["sessions"] for r in terminal_rows if r["status"] == "replayed")
engine_rows = []
for path in engine_paths:
    report = load(path)
    engine.validate(report)
    engine_rows.append(dict(path=str(path), sha256=sha(path), pairs=len(report["pairs"])))
result["engine_inventory"] = engine_rows
result["engine_pairs"] = sum(r["pairs"] for r in engine_rows)
root = Path("bench/results/2026-11-03-read-shape")
diagnostic_rows = []
for name in ("pilot", "balanced"):
    derived = diagnostic.analyze(root / name)
    assert json.loads(json.dumps(derived)) == load(root / f"{name}-analysis.json")
    diagnostic_rows.append(dict(series=name, sessions=derived["sessions"], passes=derived["passes"],
                                manifest_sha256=derived["manifest_sha256"]))
result["diagnostic_replays"] = diagnostic_rows
# Literal all-record census versus the pass-window counts in the derived report.
counts = {"read": 0, "poll": 0}
for path in sorted((root / "balanced").glob("*.trace")):
    data = path.read_bytes()
    for event in diagnostic.EVENT.iter_unpack(data[diagnostic.HEADER.size:]):
        counts["read" if event[5] == 1 else "poll"] += 1
observations = load(root / "balanced-analysis.json")["observations"]
inside = {"read": sum(r["read_calls"] for r in observations), "poll": sum(r["poll_calls"] for r in observations)}
result["trace_accounting"] = dict(all_captured_records=counts, pass_window_records=inside,
                                  outside_pass_windows={k: counts[k]-inside[k] for k in counts})
rtt_rows = []
for name in ("static-marks", "marks-width"):
    directory = Path(f"bench/results/2026-11-03-{name}/quiet-rtt")
    assert (directory / "summary.json").is_file()  # Prevent summarize's initial-publication path.
    original = (directory / "summary.json").read_bytes()
    summary = rtt.summarize(directory)
    assert (directory / "summary.json").read_bytes() == original
    rtt_rows.append(dict(source=str(directory), rounds=summary["provenance"]["rounds"],
                         samples_per_run=summary["provenance"]["samples_per_run"],
                         sha256=sha(directory / "summary.json")))
result["quiet_rtt_replays"] = rtt_rows
result["scoreboards"] = {
    "selected_latest_series": compare(root / "tail-policy/gate", "glass-alt"),
    "unpromoted_combined_initial": compare(Path("bench/results/2026-11-03-marks-width/gate"), "glass"),
    "unpromoted_combined_replication": compare(Path("bench/results/2026-11-03-marks-width/replication-gate"), "glass"),
}
state = load(OUT / "starting-state.json")
assert sha(Path("target/release/glass")) == state["selected_sha256"]
assert all(sha(Path(p)) == h for p, h in state["runtime_sources"].items())
result["restoration"] = dict(selected_sha256=state["selected_sha256"], runtime_sources_checked=len(state["runtime_sources"]),
                              runtime_source_changes=[], note="No release build or runtime edit in this audit.")
after = {str(p): sha(p) for p in sorted(protected)}
assert before == after
fingerprint = hashlib.sha256(json.dumps(before, sort_keys=True).encode()).hexdigest()
result["read_only_check"] = dict(files=len(before), before_sha256=fingerprint, after_sha256=fingerprint,
                                 note="Explicit audited artifact bytes unchanged; not a filesystem-wide mutation audit.")
print(json.dumps(result, indent=2, sort_keys=True))
