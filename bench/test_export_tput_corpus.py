"""Exporter contract tests; full real corpus equality has an independent capture."""
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('export_tput', Path(__file__).with_name('export-tput-corpus.py'))
e = importlib.util.module_from_spec(spec)
spec.loader.exec_module(e)

class ExportTests(unittest.TestCase):
    def test_real_boundaries_exclude_terminal_setup_and_timing(self):
        tree, lines = e.generator(e.SOURCE.read_bytes())
        self.assertEqual(lines,(50,82))
        code = ast.unparse(tree)
        self.assertNotIn('tcgetattr',code)
        self.assertNotIn('os.write',code)
        self.assertNotIn('perf_counter',code)
        self.assertIn('random.Random(7)',code)

    def test_missing_or_ambiguous_boundaries_are_rejected(self):
        for source in [b'W={}',b'rng=1\nW={}\n',b'old=0\nrng=1\nW={}',b'rng=1\nrng=2\nW={}\nold=0',b'rng=1\nold=0']:
            with self.subTest(source=source), self.assertRaises(ValueError):
                e.generator(source)

    def test_small_generator_runs_only_selected_statements(self):
        src = b'raise Exception("terminal setup")\nrng=random.Random(7)\nW={"ascii":b"x"}\nold=0\nraise Exception("terminal timing")\n'
        tree,_ = e.generator(src)
        ns = dict(random=e.random)
        exec(compile(tree,'fixture','exec'),ns)
        self.assertEqual(ns['W'],{'ascii':b'x'})

    def test_geometry_rejected_before_reading_or_generating(self):
        for rows,cols in [(3,154),(39,8),(513,154),(39,513),(True,154),(39,154.0)]:
            with self.subTest(rows=rows,cols=cols), self.assertRaises(ValueError):
                e.payloads(rows,cols)

    def test_export_hashes_and_manifest_last(self):
        data = {n:n.encode() for n in e.NAMES}
        with tempfile.TemporaryDirectory() as tmp, patch.object(e,'payloads',return_value=(data,{'fixture':True})):
            out = Path(tmp)/'new'
            manifest = e.export(out,39,154)
            self.assertEqual(json.loads((out/'manifest.json').read_text()),manifest)
            for n,raw in data.items():
                self.assertEqual((out/(n+'.bin')).read_bytes(),raw)
                self.assertEqual(manifest['workloads'][n],{'bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest()})
            with self.assertRaises(FileExistsError):
                e.export(out,39,154)
            self.assertEqual((out/'ascii.bin').read_bytes(),b'ascii')

    def test_existing_directory_not_touched_or_generated(self):
        with tempfile.TemporaryDirectory() as tmp, patch.object(e,'payloads',side_effect=AssertionError('must not run')):
            with self.assertRaises(FileExistsError):
                e.export(Path(tmp),39,154)
            self.assertEqual(list(Path(tmp).iterdir()),[])

    def test_generator_failure_does_not_publish(self):
        with tempfile.TemporaryDirectory() as tmp, patch.object(e,'payloads',side_effect=ValueError('bad generator')):
            out = Path(tmp)/'new'
            with self.assertRaises(ValueError):
                e.export(out,39,154)
            self.assertFalse(out.exists())

if __name__=='__main__':
    unittest.main()
