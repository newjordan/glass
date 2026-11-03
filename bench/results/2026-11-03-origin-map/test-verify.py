#!/usr/bin/env python3
"""Finite negative checks. Not proof of adversarial integrity."""
import importlib.util
from pathlib import Path
import unittest
import copy
from unittest.mock import patch

D=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('origin_verify',D/'verify.py')
v=importlib.util.module_from_spec(spec);spec.loader.exec_module(v)

class Evidence(unittest.TestCase):
    def test_complete(self):
        self.assertEqual(v.check()['final_tests'],392)

    def test_unicode_corruptions(self):
        text=(D/'candidate-v4-unicode-1.log').read_text()
        first=next(line for line in text.splitlines() if line.startswith('unicode-case'))
        variants=[
            text.replace(first+'\n','',1),
            text+first+'\n',
            text.replace('kind=a','kind=q',1),
            text.replace('ok=true','ok=false',1),
            text.replace('column=0','column=1',1),
            text.replace('records=0','records=1',1),
            text.replace('step=0','step=9',1),
            text.replace('unicode-summary cases=20736 failures=0','unicode-summary cases=20736 failures=1',1),
            text+'unicode-summary cases=20736 failures=0\n',
            text.replace('test result: ok. 1 passed;','test result: ok. 0 passed;',1),
            text.replace('unicode-case rows=','unicode-case broken=',1),
            text.replace('pictures=[]','pictures=[(0, 0)]',1),
        ]
        for i,changed in enumerate(variants):
            with self.subTest(i=i),self.assertRaises(ValueError):v.observations(changed,0)
        with self.assertRaises(ValueError):v.observations(text,1)

    def test_failure_not_laundered(self):
        text=(D/'control-unicode-10000.log').read_text()
        v.observations(text,5756)
        for wanted in [0,5755,5757]:
            with self.subTest(wanted=wanted),self.assertRaises(ValueError):v.observations(text,wanted)

    def test_mixed_corruptions(self):
        spec=importlib.util.spec_from_file_location('prior',D.parent/'2026-11-03-height-snapshot/verify.py')
        prior=importlib.util.module_from_spec(spec);spec.loader.exec_module(prior)
        text=(D/'candidate-v4-mixed-1.log').read_text()
        first=next(line for line in text.splitlines() if line.startswith('mixed-case'))
        for i,changed in enumerate([text.replace(first+'\n','',1),text+first+'\n',text.replace('ok=true','ok=false',1),text.replace('width=5','width=6',1),text.replace('test result: ok. 1 passed;','test result: ok. 0 passed;',1),text+'mixed-summary cases=3456 failures=0\n']):
            with self.subTest(i=i),self.assertRaises(ValueError):v.mixed_observations(changed,prior)

    def test_build_binding_corruptions(self):
        original=v.load(D/'build-candidate-v4/identity.json')
        path='crates/term/src/engine.rs'
        variants=[]
        for change in ['command','missing-source','wrong-source','binary']:
            obj=copy.deepcopy(original)
            if change=='command':obj['command']=['true']
            elif change=='missing-source':del obj['source_sha256'][path]
            elif change=='wrong-source':obj['source_sha256'][path]='0'*64
            else:obj['sha256']='0'*64
            variants.append(obj)
        for i,obj in enumerate(variants):
            with self.subTest(i=i),patch.object(v,'load',return_value=obj),self.assertRaises(ValueError):v.build('candidate-v4')

    def test_configuration_corruptions(self):
        original=v.load(D/'candidate-v4-tests.json')
        variants=[]
        for change in ['absent','duplicate','wrong-env','ignored-omitted','zero-test','wrong-exit','wrong-hash']:
            rows=copy.deepcopy(original)
            if change=='absent':del rows[0]
            elif change=='duplicate':rows[1]=copy.deepcopy(rows[0])
            elif change=='wrong-env':rows[0]['settings']={'GLASS_SCROLLBACK':'1'}
            elif change=='ignored-omitted':rows[0]['args'].remove('--ignored')
            elif change=='zero-test':rows[0]['args'][-1]='nonexistent'
            elif change=='wrong-exit':rows[0]['exit']=101
            else:rows[0]['sha256']='0'*64
            variants.append(rows)
        for i,rows in enumerate(variants):
            with self.subTest(i=i),patch.object(v,'load',return_value=rows),self.assertRaises(ValueError):v.unicode_arm('candidate-v4',[0]*6)

    def test_duplicate_json(self):
        with self.assertRaises(ValueError):v.unique([('a',1),('a',1)])

if __name__=='__main__':unittest.main(verbosity=2)
