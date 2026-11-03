#!/usr/bin/env python3
"""Negative checks for the semantic replay; no performance/attestation claim."""
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import unittest
import sys

D=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('scroll_verify',D/'verify.py')
v=importlib.util.module_from_spec(spec);spec.loader.exec_module(v)


def fixture():
    rows=[v.load(D/(arm+'-finaldiag-results.json')) for arm in ['control','candidate']]
    logs=[[v.text(r['log']) for r in group] for group in rows]
    return logs+rows


def rehash(data):
    for arm in range(2):
        for i in range(3):
            data[arm+2][i]['sha256']=hashlib.sha256(data[arm][i].encode()).hexdigest()


class ReplayTests(unittest.TestCase):
    rejections = 0

    def test_real_observations(self):
        self.assertEqual(v.semantic_report(*fixture())['candidate_resize_mismatches'],76)

    def test_resize_cartesian_negative_controls(self):
        base=fixture()
        for arm in [0,1]:
            log=base[arm][1]
            line=next(l for l in log.splitlines() if l.startswith('resize-case'))
            variants=[log.replace(line+'\n','',1), log+line+'\n',
                      log.replace('expected=3,4','expected=4,5',1),
                      log.replace('rows=4 height=1','rows=5 height=1',1),
                      log.replace('actual=3,4','actual=0,1',1) if arm==0 else log.replace('actual=0,1','actual=3,4',1),
                      log.replace('matched=true','matched=false',1) if arm==0 else log.replace('matched=false','matched=true',1),
                      log.replace('76 independent cases checked','75 independent cases checked')]
            for raw in variants:
                data=copy.deepcopy(base);data[arm][1]=raw;rehash(data)
                with self.subTest(arm=arm,variant=variants.index(raw)),self.assertRaises(ValueError):
                    v.semantic_report(*data)
                ReplayTests.rejections += 1

    def test_history_negative_controls(self):
        base=fixture()
        for arm in [0,1]:
            log=base[arm][2]
            line=next(l for l in log.splitlines() if l.startswith('configured-history'))
            variants=[log.replace(line+'\n','',1),log+line+'\n',log.replace('history=8','history=9',1),
                      log.replace('expected=11997','expected=11996',1),
                      log.replace('actual=3\n','actual=4\n',1) if arm==0 else log.replace('actual=11997','actual=3',1)]
            for raw in variants:
                data=copy.deepcopy(base);data[arm][2]=raw;rehash(data)
                with self.subTest(arm=arm,variant=variants.index(raw)),self.assertRaises(ValueError):
                    v.semantic_report(*data)
                ReplayTests.rejections += 1

    def test_receipt_negative_controls(self):
        base=fixture()
        for arm in [0,1]:
            for index in range(3):
                data=copy.deepcopy(base);data[arm+2][index]['exit']=7
                with self.subTest(arm=arm,index=index),self.assertRaises(ValueError):
                    v.semantic_report(*data)
                ReplayTests.rejections += 1
            data=copy.deepcopy(base);data[arm+2][2]['settings']={}
            with self.assertRaises(ValueError):v.semantic_report(*data)
            ReplayTests.rejections += 1
            data=copy.deepcopy(base);data[arm][0]=data[arm][0].replace('662 independent cases','661 independent cases');rehash(data)
            with self.assertRaises(ValueError):v.semantic_report(*data)
            ReplayTests.rejections += 1
            data=copy.deepcopy(base);data[arm][0]+='changed'
            with self.assertRaises(ValueError):v.semantic_report(*data)
            ReplayTests.rejections += 1


if __name__=='__main__':
    result = unittest.main(exit=False)
    print(f"Rejected semantic corruptions: {ReplayTests.rejections}")
    sys.exit(0 if result.result.wasSuccessful() and ReplayTests.rejections == 36 else 1)
