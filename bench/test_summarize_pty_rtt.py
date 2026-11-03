#!/usr/bin/env python3
"""Synthetic consistency tests only; fixtures are not benchmark evidence."""
import copy
import importlib.util
import json
import os
from pathlib import Path
import statistics
import tempfile
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location("rtt", Path(__file__).with_name("summarize-pty-rtt.py"))
rtt = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(rtt)


class ReplayTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        root = Path(self.tmp.name)
        self.out = root / "synthetic"
        self.out.mkdir()
        self.binary = root / "not-a-real-terminal"
        self.binary.write_text("#!/bin/sh\nexit 0\n")
        self.binary.chmod(0o700)
        with patch.dict(os.environ, {"ROUNDS": "2", "N": "4", "GLASS": str(self.binary),
                                     "GLASS_ALT": str(self.binary)}):
            rtt.start(self.out)
        (self.out / "order.txt").write_text("1 glass\n1 glass-alt\n2 glass-alt\n2 glass\n")
        for term in rtt.TERMS:
            for run in (1, 2):
                values = [0.1, 0.2, 0.3, 0.4]
                raw = {"schema": "glass.pty-rtt/v1", "n": 4, "quiet_ms": 3,
                       "reply_hex": "1b5b3f36323b343b323263", "samples_ms": values,
                       "median_ms": statistics.median(values), "p90_ms": 0.4,
                       "p99_ms": 0.4, "min_ms": 0.1, "max_ms": 0.4}
                (self.out / f"rtt-{term}-{run}.json").write_text(json.dumps(raw))
        self.raw = self.out / "rtt-glass-1.json"

    def alter_raw(self, key, value):
        data = rtt.load(self.raw)
        data[key] = value
        self.raw.write_text(json.dumps(data))

    def test_exact_replay(self):
        first = rtt.summarize(self.out)
        self.assertEqual(first, rtt.summarize(self.out))
        self.assertEqual(first["glass"]["pooled_p99_ms"], 0.4)

    def test_raw_summary_mismatch(self):
        self.alter_raw("median_ms", 0.3)
        with self.assertRaisesRegex(ValueError, "summary disagrees"):
            rtt.summarize(self.out)

    def test_missing_or_additional_session(self):
        self.raw.unlink()
        with self.assertRaisesRegex(ValueError, "raw file set"):
            rtt.summarize(self.out)

    def test_reordered_launches(self):
        (self.out / "order.txt").write_text("1 glass-alt\n1 glass\n2 glass-alt\n2 glass\n")
        with self.assertRaisesRegex(ValueError, "reordered sessions"):
            rtt.summarize(self.out)

    def test_changed_executable(self):
        self.binary.write_text("changed\n")
        with self.assertRaisesRegex(ValueError, "executable changed"):
            rtt.summarize(self.out)

    def test_invalid_samples(self):
        for values in ([0.1, 0.2, float("nan"), 0.4], [0.1, True, 0.3, 0.4],
                       [0.1, -0.2, 0.3, 0.4], [0.1]):
            with self.subTest(values=values):
                self.alter_raw("samples_ms", values)
                with self.assertRaisesRegex(ValueError, "invalid samples"):
                    rtt.summarize(self.out)

    def test_changed_reply(self):
        self.alter_raw("reply_hex", "1b5b3f3163")
        with self.assertRaisesRegex(ValueError, "changed reply"):
            rtt.summarize(self.out)

    def test_duplicate_json_key(self):
        self.raw.write_text('{"schema": 1, "schema": 2}')
        with self.assertRaisesRegex(ValueError, "duplicate JSON key"):
            rtt.summarize(self.out)

    def test_changed_saved_summary(self):
        first = rtt.summarize(self.out)
        changed = copy.deepcopy(first)
        changed["glass"]["pooled_median_ms"] = 100.0
        (self.out / "summary.json").write_text(json.dumps(changed))
        with self.assertRaisesRegex(ValueError, "summary replay differs"):
            rtt.summarize(self.out)

    def test_coherent_raw_tampering_after_replay(self):
        rtt.summarize(self.out)
        data = rtt.load(self.raw)
        data["samples_ms"][-1] = 0.5
        data.update(p90_ms=0.5, p99_ms=0.5, max_ms=0.5)
        self.raw.write_text(json.dumps(data))
        with self.assertRaisesRegex(ValueError, "summary replay differs"):
            rtt.summarize(self.out)


if __name__ == "__main__":
    unittest.main()
