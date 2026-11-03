#!/usr/bin/env python3
import copy
import importlib.util
import json
import unittest
from pathlib import Path
D = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('cells', D / 'check-cells.py')
v = importlib.util.module_from_spec(spec)
spec.loader.exec_module(v)

class Evidence(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.rows = v.parse((D / 'candidate.log').read_text())

    def test_complete(self):
        self.assertEqual(v.validate_records(self.rows, 'candidate')['observations'], 10368)
        self.assertEqual(v.validate_records(v.parse((D / 'control.log').read_text()), 'control')['failures_by_step'], [0, 968, 520, 520])

    def reject(self, mutate):
        rows = copy.deepcopy(self.rows)
        mutate(rows)
        with self.assertRaises((ValueError, TypeError, IndexError)):
            v.validate_records(rows, 'candidate')

    def test_record_corruptions(self):
        changes = [lambda r: r.pop(), lambda r: r.append(copy.deepcopy(r[0])),
                   lambda r: r[0].update(extra=1), lambda r: r[0].pop('got'),
                   lambda r: r[0].update(fast=0), lambda r: r[0].update(start=False),
                   lambda r: r[0].update(step=4), lambda r: r[0].update(mask=3),
                   lambda r: r[0].update(pass_=True), lambda r: r[0].update({'pass': False}),
                   lambda r: r[0].update(height=8), lambda r: r[0].update(bottom=8),
                   lambda r: r[0]['got'][0].__setitem__(0, 99),
                   lambda r: r[0]['expected'][0].__setitem__(0, 99)]
        for mutate in changes:
            with self.subTest(mutate=mutate): self.reject(mutate)

    def test_coordinate_shapes(self):
        for bad in [None, {}, [[0, 1]], [[0, 1, 2, 3, 4]], [[False, 0, 0, 0]], [[0, 0, float('nan'), 0]], [[0, 'x', 0, 0]]]:
            self.reject(lambda r: r[0].update(got=bad))

    def test_engine_expectation_not_authority(self):
        def mutate(rows):
            rows[0]['expected'][0][0] = 99
            rows[0]['got'] = copy.deepcopy(rows[0]['expected'])
        self.reject(mutate)

    def test_duplicate_json_and_unknown_arm(self):
        with self.assertRaises(ValueError): v.parse('cover-transport-json {"fast":true,"fast":false}')
        with self.assertRaises(ValueError): v.validate_records(self.rows, 'unrecognized')

if __name__ == '__main__':
    unittest.main(verbosity=2)
