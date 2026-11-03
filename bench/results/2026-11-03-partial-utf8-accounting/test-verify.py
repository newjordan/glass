#!/usr/bin/env python3
"""Recorded-evidence checker unit tests, including negative metadata checks."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest

D = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('evidence', D / 'verify.py')
v = importlib.util.module_from_spec(spec)
spec.loader.exec_module(v)


class Evidence(unittest.TestCase):
    def setUp(self):
        self.records = v.load(D / 'final-gates.json')
        self.identities = {a: v.load(D / ('final-build-' + a) / 'identity.json') for a in ['control', 'candidate']}
        self.logs = {(r['arm'], r['label']): (D / f'final-{r["arm"]}-{r["label"]}.log').read_text() for r in self.records}

    def test_complete(self):
        self.assertTrue(v.check_records(self.records, self.identities, self.logs))

    def test_duplicate_key_rejected(self):
        with self.assertRaises(ValueError):
            json.loads('{"exit":0,"exit":101}', object_pairs_hook=v.unique)

    def test_metadata_corruptions_rejected(self):
        changes = [
            lambda r: r.pop(),
            lambda r: r.append(copy.deepcopy(r[0])),
            lambda r: r.reverse(),
            lambda r: r[0].update(exit=0),
            lambda r: r[0].update(expected_exit=0),
            lambda r: r[0].update(arm='candidate'),
            lambda r: r[0].update(argv=['true']),
            lambda r: r[3].update(settings={}),
            lambda r: r[3].update(settings=dict(GLASS_SWEEP_SEEDS='1', GLASS_SWEEP_ROUNDS='1', GLASS_SWEEP_FROM='1')),
            lambda r: r[0].update(binary_sha256='0' * 64),
            lambda r: r[0]['source_sha256'].update({'crates/vte/src/lib.rs': '0' * 64}),
            lambda r: r[0].update(start_ns=-1),
            lambda r: r[0].update(end_ns=r[0]['start_ns']),
            lambda r: r[0].update(log_sha256='0' * 64),
        ]
        for change in changes:
            rows = copy.deepcopy(self.records)
            change(rows)
            with self.assertRaises((ValueError, KeyError)):
                v.check_records(rows, self.identities, self.logs)
        print(f'rejected metadata corruptions={len(changes)}')

    def test_rehashed_census_corruptions_rejected(self):
        import hashlib
        changes = [
            (0, 'cases=2478 failures=48', 'cases=2478 failures=0'),
            (0, 'cases=21 failures=2', 'cases=21 failures=0'),
            (1, 'cases=3816 failures=72', 'cases=3816 failures=0'),
            (4, 'cases=2478 failures=0', 'cases=2478 failures=1'),
            (5, 'cases=3816 failures=0', 'cases=3816 failures=1'),
            (6, '396 passed', '395 passed'),
            (7, 'swept 12800', 'swept 200'),
            (8, '138 passed', '139 passed'),
            (9, '34 passed', '33 passed'),
            (10, '37 passed', '36 passed'),
        ]
        for i, old, new in changes:
            rows = copy.deepcopy(self.records)
            logs = dict(self.logs)
            key = (rows[i]['arm'], rows[i]['label'])
            self.assertIn(old, logs[key])
            logs[key] = logs[key].replace(old, new)
            rows[i]['log_sha256'] = hashlib.sha256(logs[key].encode()).hexdigest()
            with self.assertRaises(ValueError):
                v.check_records(rows, self.identities, logs)
        print(f'rejected rehashed census corruptions={len(changes)}')


if __name__ == '__main__':
    unittest.main(verbosity=2)
