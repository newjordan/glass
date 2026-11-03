#!/usr/bin/env python3
import copy
import importlib.util
import json
from pathlib import Path
import re
import unittest

D=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('evidence',D/'verify.py')
V=importlib.util.module_from_spec(spec);spec.loader.exec_module(V)

class Evidence(unittest.TestCase):
    def text(self):return (D/'production-regressions.log').read_text()
    def change(self,callback):
        text=self.text();match=re.search(r'split-identity-json (\{[^\n]+\})',text)
        row=json.loads(match[1]);callback(row)
        return text[:match.start(1)]+json.dumps(row)+text[match.end(1):]
    def test_complete(self):
        out=V.verify();self.assertEqual(out['production_tests'],393)
        self.assertEqual(out['shipping_control']['failures'],4)
    def test_record_corruption(self):
        changes=[
            lambda r:r.update(got=[]),lambda r:r.update(expected=[]),
            lambda r:r.update(before=[]),lambda r:r.update(unique=2),
            lambda r:r.update(next=1),lambda r:r.update(seq=[3,5,5]),
            lambda r:r.update(sources=[[0,0,1,1]]),lambda r:r.update(deleted=False),
            lambda r:r.update(fast=True),lambda r:r.update(local_death=True),
            lambda r:r.update(fast=0),lambda r:r.update(pass_value=True),
            lambda r:r.update({'pass':False}),lambda r:r.update(seq=[True,5,4]),
            lambda r:r.update(next=True),lambda r:r.update(sources=[[0,0,1,0],[0,0,1,0],[0,0,1,1]]),
        ]
        for change in changes:
            with self.subTest(change=changes.index(change)):
                with self.assertRaises(ValueError):V.shipping(self.change(change),'production')
    def test_shape_rejection(self):
        bad=[None,{},[1],[[1]],[[True,1,1]],[[-1,1,1]],[[1,float('nan'),1]],[[1,1,0]],[[1,1,1,1]]]
        for shape in bad:
            with self.subTest(shape=shape):
                with self.assertRaises(ValueError):V.shipping(self.change(lambda r:r.update(got=shape)),'production')
    def test_missing_duplicate_summary_and_json_keys(self):
        text=self.text();match=re.search(r'split-identity-json (\{[^\n]+\})',text)
        variants=[text[:match.start()]+text[match.end():],text+'\n'+match[0],text.replace('cases=4 failures=0','cases=4 failures=1'),text.replace('393 passed','392 passed')]
        # Wrong whole-suite count is a verify-level assertion, not a record parser field.
        for damaged in variants[:3]:
            with self.assertRaises(ValueError):V.shipping(damaged,'production')
        row=match[1];damaged=text[:match.start(1)]+row[:-1]+',"fast":false}'+text[match.end(1):]
        with self.assertRaises(ValueError):V.shipping(damaged,'production')
    def test_matrix_corruptions(self):
        text=(D/'local-split.log').read_text()
        changes=[('marker=0','marker=9'),('picture=8','picture=7'),('height=3','height=9'),('above=1','above=8'),('down=1','down=8'),('saved=2','saved=1'),('unique=2','unique=1'),('pass=true','pass=false'),('expected=[(1, 8.0, 1.0)','expected=[(1, 7.0, 1.0)'),('sources=[[0.0, 0.0, 1.0,','sources=[[0.0, 0.0, 0.5,')]
        for old,new in changes:
            self.assertIn(old,text)
            with self.subTest(old=old):
                with self.assertRaises(ValueError):V.matrix(text.replace(old,new,1))
        with self.assertRaises(ValueError):V.matrix(text.replace('split-case','missing-case',1))

if __name__=='__main__':unittest.main(verbosity=2)
