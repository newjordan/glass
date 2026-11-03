#!/usr/bin/env python3
"""Synthetic corruption tests for the read-only checker; not timing evidence."""
import copy
import importlib.util
import itertools
import json
from pathlib import Path
import tempfile
import unittest

SPEC = importlib.util.spec_from_file_location("terminal_replay", Path(__file__).with_name("replay-terminal-pairs.py"))
replay = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(replay)


class ReplayTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.out = Path(self.tmp.name)
        (self.out / "terminal").mkdir()
        self.binary = self.out / "synthetic-executable"
        self.binary.write_bytes(b"not a measured terminal")
        terms, rounds = ["glass", "glass-alt", "ghostty"], 6
        self.report = {"schema": "glass.terminal-pairs/v1", "rounds": rounds,
                       "terms": terms, "orders": [list(x) for x in itertools.permutations(terms)],
                       "complete": True, "multiple_testing_corrected": False,
                       "runner_sha256": replay.digest(replay.BENCH / "compare-tput.py"),
                       "harness_sha256": {str(replay.BENCH / name): replay.digest(replay.BENCH / name)
                                          for name in ("run-tput.sh", "lib.sh", "tput.py")},
                       "binaries": {term: {"path": str(self.binary), "sha256": replay.digest(self.binary)} for term in terms},
                       "raw_sha256": {}, "geometry": [[80, 24]], "medians_mb_s": {}, "comparisons": {}}
        for term in terms:
            for r in range(1, rounds + 1):
                results = {name: {"bytes": 1_000_000, "secs": [.01, .011, .012], "mb_s": 100., "term_cpu_s": 0.}
                           for name in replay.WORKLOADS}
                results["tui_frames"]["fps"] = 30_000.
                self.write_raw(term, r, {"cols": 80, "rows": 24, "results": results})
            self.report["medians_mb_s"][term] = {name: 100. for name in replay.WORKLOADS}
        for other in terms[1:]:
            self.report["comparisons"][other] = {name: {"median_ratio": 1., "wins": 0, "losses": 0,
                                                       "ties": rounds, "sign_p_two_sided": 1., "ratios": [1.] * rounds}
                                                for name in replay.WORKLOADS}
        self.save()

    def save(self):
        (self.out / "terminal-summary.json").write_text(json.dumps(self.report))

    def write_raw(self, term, r, raw):
        relative = f"terminal/tput-{term}-{r}.json"
        path = self.out / relative
        path.write_text(json.dumps(raw))
        self.report["raw_sha256"][relative] = replay.digest(path)

    def mutate_raw(self, mutate):
        path = self.out / "terminal/tput-glass-1.json"
        raw = json.loads(path.read_text())
        mutate(raw)
        self.write_raw("glass", 1, raw)
        self.save()

    def reject(self, pattern=None, binaries=False):
        before = {p.name: p.read_bytes() for p in self.out.rglob("*.json")}
        with self.assertRaises((ValueError, KeyError, FileNotFoundError)) as caught:
            replay.validate(self.out, binaries)
        if pattern:
            self.assertIn(pattern, str(caught.exception))
        self.assertEqual(before, {p.name: p.read_bytes() for p in self.out.rglob("*.json")})

    def test_valid_ties_are_read_only(self):
        before = {p.name: p.read_bytes() for p in self.out.rglob("*.json")}
        self.assertEqual(replay.validate(self.out, True)["sessions"], 18)
        self.assertEqual(before, {p.name: p.read_bytes() for p in self.out.rglob("*.json")})

    def test_reject_incomplete_order_schema(self):
        baseline = copy.deepcopy(self.report)
        mutations = [lambda r: r.update(complete=False), lambda r: r.update(complete=1),
                     lambda r: r.update(failure={}), lambda r: r.update(schema="unknown"),
                     lambda r: r.update(rounds=True), lambda r: r.update(terms=["glass", "glass"]),
                     lambda r: r["orders"][0].reverse(), lambda r: r.update(multiple_testing_corrected=True)]
        for mutate in mutations:
            with self.subTest(mutation=mutate):
                self.report = copy.deepcopy(baseline)
                mutate(self.report)
                self.save()
                self.reject()

    def test_reject_summary_repair_and_boolean_counts(self):
        baseline = copy.deepcopy(self.report)
        for key, value in [("wins", 6), ("ties", True), ("ratios", [2.] * 6),
                           ("median_ratio", 1.01), ("sign_p_two_sided", 0.)]:
            with self.subTest(field=key):
                self.report = copy.deepcopy(baseline)
                self.report["comparisons"]["ghostty"]["ascii"][key] = value
                self.save()
                self.reject("comparison summary")
        self.report = copy.deepcopy(baseline)
        self.report["medians_mb_s"]["glass"]["ascii"] = 101.
        self.save()
        self.reject("median summary")

    def test_reject_runner_harness_and_binary_provenance(self):
        baseline = copy.deepcopy(self.report)
        mutations = [lambda r: r.update(runner_sha256="0" * 64),
                     lambda r: r["harness_sha256"].pop(next(iter(r["harness_sha256"]))),
                     lambda r: r["harness_sha256"].update({str(replay.BENCH / "tput.py"): "0" * 64}),
                     lambda r: r["binaries"].pop("glass-alt"),
                     lambda r: r["binaries"]["glass"].update(sha256="not-a-hash"),
                     lambda r: r["binaries"]["glass"].update(path="relative-executable")]
        for mutate in mutations:
            with self.subTest(mutation=mutate):
                self.report = copy.deepcopy(baseline)
                mutate(self.report)
                self.save()
                self.reject()
        self.report = baseline
        self.save()
        self.binary.write_bytes(b"changed")
        self.reject("binary changed", binaries=True)
        replay.validate(self.out)  # Explicit artifact-only mode ignores binary existence, not provenance shape.

    def test_reject_changed_hash_and_unexpected_raw_set(self):
        path = self.out / "terminal/tput-glass-1.json"
        original = path.read_bytes()
        path.write_bytes(original + b"\n")
        self.reject("raw hash changed")
        path.write_bytes(original)
        extra = self.out / "terminal/tput-glass-99.json"
        extra.write_bytes(original)
        self.reject("raw file set")
        extra.unlink()
        path.unlink()
        self.reject("raw file set")

    def test_reject_rehashed_geometry_workloads_counts(self):
        self.mutate_raw(lambda r: r.update(cols=81))
        self.reject("geometry")
        self.mutate_raw(lambda r: r.update(cols=80, rows=True))
        self.reject("geometry")
        self.mutate_raw(lambda r: (r.update(rows=24), r["results"].pop("unicode")))
        self.reject("workloads")

    def test_reject_rehashed_byte_count(self):
        self.mutate_raw(lambda r: r["results"]["ascii"].update(bytes=999_999))
        # Traversal order sets this altered count first, then fails on the next session.
        self.reject("byte count")

    def test_reject_invalid_numeric_samples(self):
        original = json.loads((self.out / "terminal/tput-glass-1.json").read_text())
        mutations = [dict(secs=[.01]), dict(secs=[0., .01, .01]), dict(secs=[True, .01, .01]),
                     dict(secs=[float("nan"), .01, .01]), dict(mb_s=float("inf")),
                     dict(mb_s=-1.), dict(term_cpu_s=-.01), dict(bytes=True)]
        for fields in mutations:
            with self.subTest(fields=fields):
                self.write_raw("glass", 1, copy.deepcopy(original))
                self.mutate_raw(lambda r: r["results"]["ascii"].update(fields))
                self.reject()

    def test_reject_rehashed_rate_and_fps_inconsistency(self):
        self.mutate_raw(lambda r: r["results"]["ascii"].update(secs=[.02] * 3))
        self.reject("rate/time mismatch")
        self.mutate_raw(lambda r: (r["results"]["ascii"].update(secs=[.01, .011, .012]),
                                   r["results"]["tui_frames"].update(fps=100.)))
        self.reject("frame-rate mismatch")

    def test_rounded_time_not_exact_time(self):
        # 0.010049 s rounds to .010 s but is not equal to a time computed
        # from the rounded MB/s. This valid historical format must survive.
        self.mutate_raw(lambda r: r["results"]["ascii"].update(secs=[.01, .011, .012], mb_s=99.5))
        ratios = [.995] + [1.] * 5
        self.report["medians_mb_s"]["glass"]["ascii"] = 100.
        for other in ["glass-alt", "ghostty"]:
            self.report["comparisons"][other]["ascii"].update(ratios=ratios, losses=1, ties=5)
        self.save()
        replay.validate(self.out)

    def test_duplicate_keys_rejected(self):
        path = self.out / "terminal-summary.json"
        path.write_text('{"schema":"first","schema":"second"}')
        self.reject("duplicate JSON key")
        self.save()
        path = self.out / "terminal/tput-glass-1.json"
        path.write_text('{"rows":24,"rows":24}')
        self.report["raw_sha256"][str(path.relative_to(self.out))] = replay.digest(path)
        self.save()
        self.reject("duplicate JSON key")


if __name__ == "__main__":
    unittest.main()
