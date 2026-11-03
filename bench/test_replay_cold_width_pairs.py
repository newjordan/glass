#!/usr/bin/env python3
"""Synthetic replay-contract tests; fixture values are not measurements."""
import copy
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('cold_replay', Path(__file__).with_name('replay-cold-width-pairs.py'))
replay = importlib.util.module_from_spec(spec)
spec.loader.exec_module(replay)
PREFIX = 'COLD_WIDTH_V1 '


def fixture():
    def row(pid, begin):
        raw = dict(codepoint=30028, width=2, cpu_ns=10, wall_ns=12,
                   minor_faults=1, maxrss_delta_kib=0)
        return dict(pid=pid, begin_ns=begin, end_ns=begin + 1000, exit=0,
                    stdout='running 1 test\ntest ' + replay.TEST + ' ... ok\n'
                    'test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 99 filtered out; finished in 0.00s\n',
                    stderr=PREFIX + json.dumps(raw) + '\n')
    pairs = []
    for i in range(2):
        order = ['base', 'candidate'] if i == 0 else ['candidate', 'base']
        pair = dict(order=order)
        for j, arm in enumerate(order):
            pair[arm] = row(10 + i * 2 + j, 10000 + (i * 2 + j) * 2000)
        pairs.append(pair)
    return dict(schema='glass.cold-width-pairs/v1',
                test=replay.TEST, complete=True, unchanged_binaries=True,
                binaries={arm: dict(path='/nonexistent/synthetic', sha256='0' * 64) for arm in replay.ARMS},
                pairs=pairs)


class ColdReplayTests(unittest.TestCase):
    def test_valid_and_tie(self):
        result = replay.validate(fixture(), expected_pairs=2)
        self.assertEqual(result['processes'], 4)
        self.assertEqual(result['metrics']['cpu_ns']['ties'], 2)

    def test_reject_contract_damage(self):
        mutations = [
            lambda r: r.update(complete=False),
            lambda r: r.update(unchanged_binaries=False),
            lambda r: r.update(test='wrong'),
            lambda r: r.update(unknown=True),
            lambda r: r['pairs'].pop(),
            lambda r: r['pairs'][1].update(order=['base', 'candidate']),
            lambda r: r['pairs'][0]['base'].update(exit=1),
            lambda r: r['pairs'][0]['base'].update(pid=True),
            lambda r: r['pairs'][0]['candidate'].update(pid=10),
            lambda r: r['pairs'][0]['base'].update(begin_ns=11000),
            lambda r: r['pairs'][0]['candidate'].update(begin_ns=10001),
            lambda r: r['pairs'][0]['base'].update(stdout='running 0 tests\n'),
            lambda r: r['pairs'][0]['base'].update(stdout=r['pairs'][0]['base']['stdout'] * 2),
            lambda r: r['pairs'][0]['base'].update(stderr=r['pairs'][0]['base']['stderr'] * 2),
            lambda r: r['pairs'][0]['base'].update(stderr='COLD_WIDTH_V1 {"cpu_ns": 3, "cpu_ns": 4}\n'),
        ]
        for i, mutate in enumerate(mutations):
            with self.subTest(i=i):
                report = fixture()
                mutate(report)
                with self.assertRaises((ValueError, KeyError)):
                    replay.validate(report, expected_pairs=2)

    def test_raw_values_fail_closed(self):
        for key, value in [('cpu_ns', 0), ('cpu_ns', True), ('cpu_ns', 2000),
                           ('wall_ns', float('nan')), ('minor_faults', -1),
                           ('width', 1), ('codepoint', 0), ('extra', 1)]:
            with self.subTest(key=key, value=value):
                report = fixture()
                row = report['pairs'][0]['base']
                raw = json.loads(row['stderr'][len(PREFIX):])
                raw[key] = value
                row['stderr'] = PREFIX + json.dumps(raw) + '\n'
                with self.assertRaises(ValueError):
                    replay.validate(report)

    def test_explicit_pair_and_binary_checks(self):
        with self.assertRaises(ValueError):
            replay.validate(fixture(), expected_pairs=3)
        with self.assertRaises(FileNotFoundError):
            replay.validate(fixture(), verify_binaries=True)

    def test_duplicate_keys(self):
        with self.assertRaises(ValueError):
            json.loads('{"pairs": [], "pairs": []}', object_pairs_hook=replay.unique_object)

    def test_no_overwrite_output(self):
        with tempfile.TemporaryDirectory() as tmp:
            out = Path(tmp) / 'existing.json'
            out.write_text('untouched')
            result = subprocess.run([sys.executable, '-B', str(Path(__file__).with_name('cold-width-pairs.py')),
                                     sys.executable, sys.executable, '--out', str(out)],
                                    capture_output=True, text=True)
            self.assertNotEqual(result.returncode, 0)
            self.assertEqual(out.read_text(), 'untouched')

    def test_nonzero_child_is_preserved(self):
        with tempfile.TemporaryDirectory() as tmp:
            child = Path(tmp) / 'fail'
            child.write_text('#!/bin/sh\necho deliberate-test-failure >&2\nexit 7\n')
            child.chmod(0o700)
            out = Path(tmp) / 'receipt.json'
            result = subprocess.run([sys.executable, '-B', str(Path(__file__).with_name('cold-width-pairs.py')),
                                     str(child), str(child), '--pairs', '1', '--out', str(out)],
                                    capture_output=True, text=True)
            report = json.loads(out.read_text())
            self.assertNotEqual(result.returncode, 0)
            self.assertFalse(report['complete'])
            self.assertEqual(report['pairs'][0]['base']['exit'], 7)
            self.assertIn('deliberate-test-failure', report['pairs'][0]['base']['stderr'])
            with self.assertRaises(ValueError):
                replay.validate(report)

    def test_timeout_child_is_reaped_and_preserved(self):
        with tempfile.TemporaryDirectory() as tmp:
            child = Path(tmp) / 'wait'
            child.write_text('#!/usr/bin/env python3\nimport time\nprint("started", flush=True)\ntime.sleep(60)\n')
            child.chmod(0o700)
            out = Path(tmp) / 'receipt.json'
            result = subprocess.run([sys.executable, '-B', str(Path(__file__).with_name('cold-width-pairs.py')),
                                     str(child), str(child), '--pairs', '1', '--timeout', '0.2', '--out', str(out)],
                                    capture_output=True, text=True, timeout=5)
            report = json.loads(out.read_text())
            self.assertNotEqual(result.returncode, 0)
            row = report['pairs'][0]['base']
            self.assertFalse(report['complete'])
            self.assertTrue(row['timeout'])
            self.assertLess(row['exit'], 0)
            with self.assertRaises(ProcessLookupError):
                import os
                os.kill(row['pid'], 0)


if __name__ == '__main__':
    unittest.main()
