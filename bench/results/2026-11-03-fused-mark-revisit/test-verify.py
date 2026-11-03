#!/usr/bin/env python3
"""Pure receipt/corruption checks; no Rust compilation or repeated timing."""
import copy
import importlib.util
from pathlib import Path
import unittest

D = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('verify_fused', D / 'verify.py')
V = importlib.util.module_from_spec(spec)
spec.loader.exec_module(V)


class Evidence(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.identities = {a: V.load(V.M / ('build-' + a) / 'identity.json') for a in ['control', 'candidate']}
        cls.records = V.load(V.M / 'gates.json')
        cls.logs = {(r['arm'], r['label']): (V.M / f'{r["arm"]}-{r["label"]}.log').read_text() for r in cls.records}
        cls.censuses = {a: V.sha(V.M / (a + '-source-sha256.json')) for a in ['control', 'candidate']}
        cls.raw = V.load(V.M / 'raw.json')

    def test_complete(self):
        result = V.verify()
        self.assertEqual(result['pairs'], 12)
        self.assertTrue(result['production_restored'])

    def test_duplicate_json_keys(self):
        with self.assertRaises(ValueError):
            V.A.json.loads('{"pairs":12,"pairs":0}', object_pairs_hook=V.A.unique)

    def test_gate_metadata_corruptions(self):
        mutations = [lambda x: x.pop(), lambda x: x.append(copy.deepcopy(x[0])),
                     lambda x: x[0].update(exit=1), lambda x: x[0].update(binary_sha256='0'*64),
                     lambda x: x[0].update(source_census_sha256='0'*64),
                     lambda x: x[0].update(log_sha256='0'*64), lambda x: x[0].update(start_ns=x[0]['end_ns']),
                     lambda x: x[0].update(argv=['true']), lambda x: x[0].update(label='unknown')]
        for i, change in enumerate(mutations):
            with self.subTest(i=i):
                records = copy.deepcopy(self.records)
                change(records)
                with self.assertRaises((ValueError, KeyError)):
                    V.check_records(records, self.identities, self.logs, self.censuses)

    def test_rehashed_log_census_corruptions(self):
        replacements = [('control', 'literal', 'cases=3816', 'cases=0'),
                        ('candidate', 'redraw', 'cases=86784', 'cases=23424'),
                        ('candidate', 'redraw', 'observations=520704', 'observations=0'),
                        ('control', 'suite', '397 passed', '0 passed'),
                        ('candidate', 'suite', '14 ignored', '15 ignored'),
                        ('candidate', 'library', '139 passed', '138 passed'),
                        ('candidate', 'library', '45 passed', '44 passed'),
                        ('candidate', 'library', '1 passed', '0 passed')]
        for arm, label, old, new in replacements:
            with self.subTest(arm=arm, label=label, old=old):
                logs, records = dict(self.logs), copy.deepcopy(self.records)
                self.assertIn(old, logs[arm, label])
                logs[arm, label] = logs[arm, label].replace(old, new)
                for r in records:
                    if (r['arm'], r['label']) == (arm, label):
                        r['log_sha256'] = V.hashlib.sha256(logs[arm, label].encode()).hexdigest()
                with self.assertRaises(ValueError):
                    V.check_records(records, self.identities, logs, self.censuses)

    def test_raw_timing_corruptions(self):
        mutations = [lambda x: x['pairs'].pop(), lambda x: x['pairs'].append(copy.deepcopy(x['pairs'][0])),
                     lambda x: x['pairs'][0].update(order=['candidate', 'base']),
                     lambda x: x['pairs'][0]['base'].update(exit=1),
                     lambda x: x['binaries']['candidate'].update(sha256='0'*64),
                     lambda x: x['settings'].update(GLASS_BENCH_ROUNDS='99'),
                     lambda x: x['pairs'][0]['candidate']['results'].pop('unicode'),
                     lambda x: x['pairs'][0]['base']['results']['ascii'].update(mb_cpu_s=1),
                     lambda x: x['pairs'][0]['candidate'].update(stdout='test result: ok. 0 passed; 0 failed;'),
                     lambda x: x.update(failure={})]
        for i, change in enumerate(mutations):
            with self.subTest(i=i):
                raw = copy.deepcopy(self.raw)
                change(raw)
                with self.assertRaises((ValueError, KeyError)):
                    V.A.analyze(raw, self.identities)


if __name__ == '__main__':
    unittest.main(verbosity=2)
