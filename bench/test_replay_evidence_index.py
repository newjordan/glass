#!/usr/bin/env python3
"""Regression tests for explicit historical mapping, not competitive evidence."""
import copy
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

SPEC = importlib.util.spec_from_file_location("evidence_index", Path(__file__).with_name("replay-evidence-index.py"))
replay = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(replay)


class HistoricalReplayTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.put("original.txt", b"newer live documentation")
        self.put("snapshot.txt", b"original bytes")
        self.manifest = {"schema": "glass.immutable-research-evidence/v1",
                         "sha256": {"original.txt": replay.digest(b"original bytes")}}
        self.put("manifest.json", json.dumps(self.manifest).encode())
        self.index = {"schema": replay.SCHEMA, "manifests": [{"path": "manifest.json",
                      "sha256": replay.digest((self.root / "manifest.json").read_bytes()),
                      "source_root": ".", "snapshots": {"original.txt": "snapshot.txt"}}]}

    def put(self, name, data):
        p = self.root / name
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_bytes(data)

    def run_index(self):
        before = {str(p): p.read_bytes() for p in self.root.rglob("*") if p.is_file()}
        try:
            return replay.validate(self.root, self.index)
        finally:
            self.assertEqual(before, {str(p): p.read_bytes() for p in self.root.rglob("*") if p.is_file()})

    def test_explicit_snapshot_and_unchanged_live(self):
        r = self.run_index()
        self.assertEqual((r["file_references"], r["historical_references"]), (1, 1))
        self.put("original.txt", b"original bytes")
        self.index["manifests"][0]["snapshots"] = {}
        self.assertEqual(self.run_index()["historical_references"], 0)

    def test_no_fallback_to_live_or_other_snapshot(self):
        self.put("original.txt", b"original bytes")
        (self.root / "snapshot.txt").unlink()
        with self.assertRaisesRegex(ValueError, "missing source"):
            self.run_index()
        self.put("snapshot.txt", b"wrong version")
        with self.assertRaisesRegex(ValueError, "changed source"):
            self.run_index()

    def test_mutations_of_manifest_and_index(self):
        baseline = copy.deepcopy(self.index)
        for mutate in [lambda e: e.update(sha256="0" * 64),
                       lambda e: e["snapshots"].update({"unused.txt": "snapshot.txt"}),
                       lambda e: e["snapshots"].update({"original.txt": "../escape"}),
                       lambda e: e.update(path="./manifest.json"),
                       lambda e: e.update(source_root="/tmp")]:
            with self.subTest(mutation=mutate):
                self.index = copy.deepcopy(baseline)
                mutate(self.index["manifests"][0])
                with self.assertRaises(ValueError):
                    self.run_index()
        self.index = baseline
        self.index["manifests"] *= 2
        with self.assertRaisesRegex(ValueError, "duplicate manifest"):
            self.run_index()

    def test_duplicate_json_and_unknown_schema(self):
        with self.assertRaisesRegex(ValueError, "duplicate JSON key"):
            replay.load(b'{"a":1,"a":2}')
        self.manifest["schema"] = "unknown"
        self.put("manifest.json", json.dumps(self.manifest).encode())
        self.index["manifests"][0]["sha256"] = replay.digest((self.root / "manifest.json").read_bytes())
        with self.assertRaisesRegex(ValueError, "unknown evidence"):
            self.run_index()

    def test_relative_manifest_source_root(self):
        self.put("series/data.txt", b"data")
        raw = json.dumps({"data.txt": replay.digest(b"data")}).encode()
        self.put("series/manifest.json", raw)
        self.index["manifests"] = [{"path": "series/manifest.json", "sha256": replay.digest(raw),
                                    "source_root": "series", "snapshots": {}}]
        self.assertEqual(self.run_index()["file_references"], 1)

    def test_symlink_file_and_parent_are_rejected(self):
        self.put("elsewhere/data", b"original bytes")
        (self.root / "link").symlink_to(self.root / "elsewhere", target_is_directory=True)
        self.index["manifests"][0]["snapshots"]["original.txt"] = "link/data"
        with self.assertRaisesRegex(ValueError, "symlink"):
            self.run_index()
        (self.root / "snapshot.txt").unlink()
        (self.root / "snapshot.txt").symlink_to(self.root / "elsewhere/data")
        self.index["manifests"][0]["snapshots"]["original.txt"] = "snapshot.txt"
        with self.assertRaisesRegex(ValueError, "symlink"):
            self.run_index()


if __name__ == "__main__":
    unittest.main()
