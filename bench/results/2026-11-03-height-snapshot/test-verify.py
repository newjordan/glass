#!/usr/bin/env python3
"""Finite negative evidence checks, not proof of adversarial integrity."""
import importlib.util
from pathlib import Path
import unittest

D = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('height_verify', D / 'verify.py')
v = importlib.util.module_from_spec(spec)
spec.loader.exec_module(v)


class Evidence(unittest.TestCase):
    def test_original_complete(self):
        self.assertEqual(v.check()['final_tests'], 392)

    def test_height_corruptions(self):
        text = (D / 'candidate-v5-height-1.log').read_text()
        first = next(line for line in text.splitlines() if line.startswith('height-case'))
        mutations = [
            ('absent', text.replace(first + '\n', '', 1)),
            ('duplicate', text + first + '\n'),
            ('wrong-capacity', text.replace('capacity=1', 'capacity=2', 1)),
            ('false-match', text.replace('ok=true', 'ok=false', 1)),
            ('invent-expectation', text.replace('expected=Some(0)', 'expected=Some(1)', 1)),
            ('invent-text-row', text.replace('actual=Some(0)', 'actual=Some(1)', 1)),
            ('invent-picture-row', text.replace('pictures=[0]', 'pictures=[1]', 1)),
            ('invalid-picture-type', text.replace('pictures=[0]', 'pictures=[True]', 1)),
            ('unknown-case', text.replace('rows=4', 'rows=3', 1)),
            ('wrong-step', text.replace('step=0', 'step=4', 1)),
            ('false-summary', text.replace('failures=0 capacity=1', 'failures=1 capacity=1', 1)),
            ('duplicate-summary', text + 'height-summary cases=9360 failures=0 capacity=1\n'),
            ('zero-test', text.replace('test result: ok. 1 passed;', 'test result: ok. 0 passed;', 1)),
            ('garbled-record', text.replace('height-case rows=', 'height-case badrows=', 1)),
        ]
        for label, mutant in mutations:
            with self.subTest(label=label), self.assertRaises(ValueError):
                v.height_observations(mutant, 1, 0)
        print(f'height mutations rejected: {len(mutations)}')

    def test_mixed_corruptions(self):
        text = (D / 'candidate-v5-mixed-10000.log').read_text()
        first = next(line for line in text.splitlines() if line.startswith('mixed-case'))
        mutations = [
            ('absent', text.replace(first + '\n', '', 1)),
            ('duplicate', text + first + '\n'),
            ('unknown-width', text.replace('width=5', 'width=7', 1)),
            ('unknown-density', text.replace('dense=false', 'dense=invalid', 1)),
            ('false-match', text.replace('ok=true', 'ok=false', 1)),
            ('invent-text', text.replace('text=[(0, 0)]', 'text=[(1, 0)]', 1)),
            ('invent-picture', text.replace('pictures=[(0, 0)]', 'pictures=[(1, 0)]', 1)),
            ('wrong-type', text.replace('text=[(0, 0)]', 'text=[(True, 0)]', 1)),
            ('false-summary', text.replace('failures=32', 'failures=31', 1)),
            ('wrong-test-result', text.replace('FAILED. 0 passed; 1 failed;', 'ok. 1 passed; 0 failed;', 1)),
        ]
        for label, mutant in mutations:
            with self.subTest(label=label), self.assertRaises(ValueError):
                v.mixed_observations(mutant, 32)
        print(f'mixed mutations rejected: {len(mutations)}')

    def test_expectation_not_copied_from_engine(self):
        self.assertEqual(v.expected_height((4, 2, 3, 2, 24, 'true', 'false', 0), 32), 0)
        self.assertEqual(v.expected_height((4, 6, 0, 0, 12, 'false', 'true', 0), 32), 2)
        self.assertIsNone(v.expected_height((4, 1, 3, 0, 12, 'false', 'true', 0), 0))
        self.assertEqual(len(v.height_keys()), 9360)
        self.assertEqual(len(v.mixed_keys()), 3456)


if __name__ == '__main__':
    unittest.main(verbosity=2)
