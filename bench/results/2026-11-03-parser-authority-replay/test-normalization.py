#!/usr/bin/env python3
"""Exercise only the narrow first-stale diagnostic normalization."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('stable_authority_verify', HERE / 'verify.py')
verify = importlib.util.module_from_spec(spec)
spec.loader.exec_module(verify)
ORIGINAL = json.loads((verify.D / 'corruption-replay-final.json').read_text())


def incident(report):
    return next(c for c in report['cases'] if c['case'] == 'actual_stale_control_receipt')


class NarrowNormalization(unittest.TestCase):
    def test_all_three_known_reasons_equal_and_input_unchanged(self):
        before = copy.deepcopy(ORIGINAL)
        expected = verify.normalize_corruption(ORIGINAL)
        for name in ('vte', 'glass', 'alacritty_terminal'):
            r = copy.deepcopy(ORIGINAL)
            incident(r)['reason'] = 'missing/ambiguous/stale package receipt: ' + name
            self.assertEqual(verify.normalize_corruption(r), expected)
        self.assertEqual(ORIGINAL, before)

    def test_unapproved_reason_rejected(self):
        r = copy.deepcopy(ORIGINAL)
        incident(r)['reason'] = 'unexpected source or build failure'
        with self.assertRaises(ValueError):
            verify.normalize_corruption(r)

    def test_false_status_rejected(self):
        r = copy.deepcopy(ORIGINAL)
        incident(r)['rejected'] = False
        with self.assertRaises(ValueError):
            verify.normalize_corruption(r)

    def test_missing_or_duplicate_incident_rejected(self):
        for duplicate in (False, True):
            r = copy.deepcopy(ORIGINAL)
            c = incident(r)
            if duplicate:
                r['cases'].append(copy.deepcopy(c))
            else:
                r['cases'].remove(c)
            with self.assertRaises(ValueError):
                verify.normalize_corruption(r)

    def test_other_diagnostics_not_normalized(self):
        r = copy.deepcopy(ORIGINAL)
        r['cases'][0]['reason'] += ' changed'
        self.assertNotEqual(verify.normalize_corruption(r), verify.normalize_corruption(ORIGINAL))

    def test_digests_and_flags_not_normalized(self):
        r = copy.deepcopy(ORIGINAL)
        r['canonical_reports_unchanged'] = False
        self.assertNotEqual(verify.normalize_corruption(r), verify.normalize_corruption(ORIGINAL))
        r = copy.deepcopy(ORIGINAL)
        key = next(iter(r['sha256']))
        r['sha256'][key] = '0' * 64
        self.assertNotEqual(verify.normalize_corruption(r), verify.normalize_corruption(ORIGINAL))


if __name__ == '__main__':
    unittest.main()
