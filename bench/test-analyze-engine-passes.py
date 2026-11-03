#!/usr/bin/env python3
"""Boundary validation for retained engine-pass records (not timing accuracy)."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest

spec = importlib.util.spec_from_file_location('passes', Path(__file__).with_name('analyze-engine-passes.py'))
a = importlib.util.module_from_spec(spec)
spec.loader.exec_module(a)


class PassTests(unittest.TestCase):
    def setUp(self):
        self.rows = [dict(schema='glass.engine-pass/v1', workload='ascii',
                          **{'pass': p, 'rounds': 3, 'bytes': 100, 'read': 4095,
                             'wall_ns': [300, 200, 400][p], 'cpu_ns': [100, 180, 190][p]})
                     for p in range(3)]

    def parse(self, rows):
        return a.parse('\n'.join(json.dumps(r) for r in rows), {'ascii': 100})

    def test_different_minima_and_median(self):
        item = a.describe(self.parse(self.rows))['ascii']
        self.assertTrue(item['minima_on_different_passes'])
        self.assertEqual(item['best_wall_pass'], 1)
        self.assertEqual(item['best_cpu_pass'], 0)
        self.assertEqual(item['wall']['median_ns'], 300)
        self.assertEqual(item['cpu']['median_ns'], 180)
        self.assertEqual(item['cpu']['median_mb_s'], 100 * 1000 / 180)

    def test_boundaries_reject(self):
        mutations = [lambda r: r.pop(), lambda r: r.append(copy.deepcopy(r[0])),
                     lambda r: r.reverse()]
        for key, value in [('schema', 'other'), ('workload', 'unicode'), ('pass', True),
                           ('pass', 1), ('rounds', 0), ('rounds', 4), ('bytes', 101),
                           ('read', 4096), ('cpu_ns', 0), ('wall_ns', -1),
                           ('cpu_ns', 1.0), ('cpu_ns', True), ('wall_ns', 2**64),
                           ('wall_ns', '100'), ('cpu_ns', None), ('extra', 1)]:
            mutations.append(lambda r, k=key, v=value: r[0].__setitem__(k, v))
        mutations += [lambda r: r[0].pop('cpu_ns')]
        for n, mutation in enumerate(mutations):
            with self.subTest(case=n):
                rows = copy.deepcopy(self.rows)
                mutation(rows)
                with self.assertRaises(ValueError):
                    self.parse(rows)

    def test_duplicate_keys(self):
        text = '\n'.join(json.dumps(r) for r in self.rows)
        with self.assertRaisesRegex(ValueError, 'duplicate JSON key'):
            a.parse(text.replace('"cpu_ns": 100', '"cpu_ns": 100, "cpu_ns": 101'), {'ascii': 100})

    def test_blank_empty_and_wrong_expected_shape(self):
        text = '\n'.join(json.dumps(r) for r in self.rows)
        for invalid in ('', text + '\n\n', 'not json'):
            with self.assertRaises(ValueError):
                a.parse(invalid, {'ascii': 100})
        for shapes, rounds, read in [({}, 3, 4095), ({'ascii': True}, 3, 4095),
                                    ({'ascii': 100}, 0, 4095), ({'ascii': 100}, 3, 0)]:
            with self.assertRaises(ValueError):
                a.parse(text, shapes, rounds, read)

    def test_multiworkload_order(self):
        rows = copy.deepcopy(self.rows)
        rows += [dict(r, workload='unicode', bytes=200) for r in self.rows]
        text = '\n'.join(json.dumps(r) for r in rows)
        parsed = a.parse(text, {'ascii': 100, 'unicode': 200})
        self.assertEqual(list(parsed), ['ascii', 'unicode'])
        with self.assertRaises(ValueError):
            a.parse(text, {'unicode': 200, 'ascii': 100})


if __name__ == '__main__':
    unittest.main()
