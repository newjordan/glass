#!/usr/bin/env python3
"""Validator mutation tests; synthetic numbers are NOT benchmark measurements."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest

spec = importlib.util.spec_from_file_location("replay", Path(__file__).with_name("replay-engine-pairs.py"))
replay = importlib.util.module_from_spec(spec)
spec.loader.exec_module(replay)


def fixture():
    def entry(rate):
        return {"exit": 0, "stdout": "one synthetic row", "stderr": f" unicode: {rate}.0 MB/s {rate}.0 MB/cpu-s (100 bytes, read 17)\n",
                "results": {"unicode": {"mb_s": float(rate), "mb_cpu_s": float(rate), "bytes": 100, "read": 17}}}
    return {"schema": "glass.engine-pairs/v1",
            "settings": {"GLASS_BENCH_ONLY": "unicode", "GLASS_BENCH_SCALE": "1", "GLASS_BENCH_ROUNDS": "3"},
            "binaries": {arm: {"path": "/nonexistent/synthetic", "sha256": "0" * 64} for arm in ("base", "candidate")},
            "pairs": [{"order": ["base", "candidate"], "base": entry(100), "candidate": entry(110)}],
            "summary": {"unicode": {"median_cpu_ratio": 1.1, "wins": 1, "losses": 0, "sign_p_two_sided": 1.0}}}


class ReplayTests(unittest.TestCase):
    def test_valid_and_tie(self):
        report = fixture()
        self.assertEqual(replay.validate(report, expected_pairs=1), report["summary"])
        report["pairs"][0]["candidate"] = copy.deepcopy(report["pairs"][0]["base"])
        report["summary"]["unicode"].update(median_cpu_ratio=1.0, wins=0)
        replay.validate(report)

    def test_reject_bad_reports(self):
        def mutate_pair(report, key, value):
            report["pairs"][0]["base"][key] = value
        mutations = [
            lambda r: r.update(schema="unknown"),
            lambda r: r.update(failure={}),
            lambda r: r.update(pairs=[]),
            lambda r: r.pop("summary"),
            lambda r: r["summary"]["unicode"].update(wins=2),
            lambda r: r["pairs"][0].update(order=["candidate", "base"]),
            lambda r: mutate_pair(r, "exit", 1),
            lambda r: mutate_pair(r, "stderr", ""),
            lambda r: mutate_pair(r, "stderr", r["pairs"][0]["base"]["stderr"] * 2),
            lambda r: r["pairs"][0]["base"]["results"]["unicode"].update(mb_cpu_s=1),
            lambda r: r["binaries"]["base"].update(sha256="missing"),
            lambda r: r["settings"].update(GLASS_BENCH_SCALE="nan"),
            lambda r: r["settings"].update(GLASS_BENCH_ONLY="unicode,unicode"),
        ]
        for i, mutation in enumerate(mutations):
            with self.subTest(mutation=i):
                report = fixture()
                mutation(report)
                with self.assertRaises((ValueError, KeyError)):
                    replay.validate(report)

    def test_reject_changed_workload_shape(self):
        report = fixture()
        entry = report["pairs"][0]["candidate"]
        entry["stderr"] = entry["stderr"].replace("100 bytes", "101 bytes")
        entry["results"]["unicode"]["bytes"] = 101
        with self.assertRaisesRegex(ValueError, "changed shape"):
            replay.validate(report)

    def test_requested_pairs_and_binary_checks_fail_closed(self):
        with self.assertRaisesRegex(ValueError, "pair count"):
            replay.validate(fixture(), expected_pairs=2)
        with self.assertRaises(FileNotFoundError):
            replay.validate(fixture(), verify_binaries=True)

    def test_duplicate_json_key(self):
        with self.assertRaisesRegex(ValueError, "duplicate JSON key"):
            json.loads('{"pairs": [], "pairs": []}', object_pairs_hook=replay.unique_object)


if __name__ == "__main__":
    unittest.main()
