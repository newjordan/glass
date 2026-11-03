#!/usr/bin/env python3
"""Negative tests of the finite source-row evidence parser, not rendering tests."""
import copy
import importlib.util
import json
from pathlib import Path
import re
import unittest

D = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('seam_verify', D / 'verify.py')
v = importlib.util.module_from_spec(spec)
spec.loader.exec_module(v)
TEXT = (D / 'candidate.log').read_text()
MATCH = re.search(r'source-seams-json (\{[^\n]+\})', TEXT)
BASE = json.loads(MATCH.group(1))


def replaced(record):
    return TEXT[:MATCH.start(1)] + json.dumps(record) + TEXT[MATCH.end(1):]


class Evidence(unittest.TestCase):
    def reject(self, record):
        with self.assertRaises(ValueError):
            v.matrix(replaced(record), 'candidate')

    def test_complete(self):
        result = v.verify()
        self.assertEqual(result['candidate'], {'cases': 1536, 'failures': 0})
        self.assertEqual(result['control'], {'cases': 1536, 'failures': 384})

    def test_record_corruptions(self):
        edits = []
        for key, value in [('pass', False), ('fast', 0), ('alternate', 1), ('cropped', 'false'), ('down', None),
                           ('height', 2.0), ('expected', []), ('got', []), ('start', True)]:
            row = copy.deepcopy(BASE)
            row[key] = value
            edits.append(row)
        row = copy.deepcopy(BASE)
        row['extra'] = 1
        edits.append(row)
        row = copy.deepcopy(BASE)
        del row['got']
        edits.append(row)
        for key in ['expected', 'got']:
            for idx in [0, 3, 4, 6]:
                row = copy.deepcopy(BASE)
                row[key][0][idx] += 0.125
                edits.append(row)
        # Colluding reported/observed values must still fail the independent oracle.
        row = copy.deepcopy(BASE)
        row['got'][0][4] += 0.25
        row['expected'] = copy.deepcopy(row['got'])
        edits.append(row)
        self.assertEqual(len(edits), 20)
        for row in edits:
            with self.subTest(row=row):
                self.reject(row)

    def test_invalid_configurations(self):
        for key, value in [('start', -1), ('start', 1), ('height', 0), ('height', 3),
                           ('top', 3), ('bottom', 8), ('n', 0)]:
            row = copy.deepcopy(BASE)
            row[key] = value
            with self.subTest(key=key, value=value):
                self.reject(row)

    def test_malformed_coordinates(self):
        for value in [None, [None], [[1, 2]], [[0, 1, 2, 0, 0, 1, float('nan')]],
                      [[0, 1, 2, 0, 0, 1, float('inf')]], [[0, 1, True, 0, 0, 1, 1]],
                      [[0, 1, 2, 0, 0, 1, 0]]]:
            row = copy.deepcopy(BASE)
            row['got'] = value
            with self.subTest(value=value):
                self.reject(row)

    def test_duplicate_missing_summary_and_test_receipts(self):
        second = re.findall(r'source-seams-json (\{[^\n]+\})', TEXT)[1]
        variants = [TEXT.replace(second, MATCH.group(1), 1),
                    TEXT.replace('source-seams-summary cases=1536 failures=0', 'source-seams-summary cases=1536 failures=1'),
                    TEXT.replace('test result: ok. 1 passed; 0 failed;', 'test result: ok. 0 passed; 0 failed;'),
                    TEXT.replace('source-seams-json ' + MATCH.group(1), '', 1)]
        for text in variants:
            with self.subTest(text=text[-150:]):
                with self.assertRaises(ValueError):
                    v.matrix(text, 'candidate')

    def test_duplicate_json_keys_and_unknown_arm(self):
        with self.assertRaises(ValueError):
            v.load('{"a":1,"a":2}')
        with self.assertRaises(ValueError):
            v.matrix(TEXT, 'unmeasured')


if __name__ == '__main__':
    unittest.main(verbosity=2)
