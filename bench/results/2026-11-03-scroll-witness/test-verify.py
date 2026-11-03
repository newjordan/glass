#!/usr/bin/env python3
"""Adversarial tests of the independent observation parser, not runtime proof."""
import importlib.util,json,unittest
from pathlib import Path
D=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('scroll_replay',D/'verify.py');v=importlib.util.module_from_spec(spec);spec.loader.exec_module(v)
class Evidence(unittest.TestCase):
 def source(self,arm='aware'):
  prefix={'aware':'aware','transport':'transport-final','stale':'stale-final'}[arm]
  return (D/f'{prefix}-scroll_witness_matrix-0.log').read_text()
 def reject(self,text,arm='aware'):
  with self.assertRaises(ValueError):v.matrix(text,arm)
 def test_complete(self):
  for arm,count in [('stale',372),('transport',24),('aware',0)]:
   with self.subTest(arm=arm):self.assertEqual(v.matrix(self.source(arm),arm)[0],{'cases':480,'failures':count})
 def test_record_corruptions(self):
  text=self.source();first=next(l for l in text.splitlines() if l.startswith('scroll-witness '));changes=[]
  for old,new in [('fast=false','fast=maybe'),('alt=false','alt=maybe'),('row=1','row=0'),('delta=0','delta=1'),('op=SU','op=XX'),('before_m=[(1, 0)]','before_m=[(2, 0)]'),('before_p=[(1, 0)]','before_p=[(1, 1)]'),('after_m=[]','after_m=[(1, 0)]'),('after_p=[]','after_p=[(1, 0)]'),('final_m=[]','final_m=[(0, 0)]'),('got=[]','got=[(0, 0)]'),('expected=[]','expected=[(0, 0)]'),('pass=true','pass=false')]:
   self.assertIn(old,first);changes.append((old,text.replace(first,first.replace(old,new),1)))
  changes.extend([('missing',text.replace(first+'\n','',1)),('duplicate',text+first+'\n'),('summary',text.replace('cases=480 failures=0','cases=480 failures=1')),('zero-test',text.replace('running 1 test','running 0 tests')),('fake-result',text.replace('test result: ok. 1 passed; 0 failed','test result: ok. 0 passed; 0 failed'))])
  self.assertEqual(len(changes),18)
  for name,changed in changes:
   with self.subTest(name=name):self.reject(changed)
 def test_residual_corruptions(self):
  text=self.source('transport');line=next(l for l in text.splitlines() if 'pass=false' in l)
  for old,new in [('op=SU','op=SD'),('row=1','row=2'),('delta=-8','delta=-7'),('got=[(0, 0)]','got=[]'),('expected=[]','expected=[(1, 0)]'),('pass=false','pass=true')]:
   self.assertIn(old,line)
   with self.subTest(field=old):self.reject(text.replace(line,line.replace(old,new),1),'transport')
 def test_bad_shapes(self):
  for shape in ['[(True,0)]','[(0.0,1)]','[[0,1]]','[(0,)]','[(0,1,2)]','[(0,1),(0,1)]','{}']:
   with self.subTest(shape=shape):
    with self.assertRaises(ValueError):v.vector(shape)
 def test_duplicate_json_keys(self):
  with self.assertRaises(ValueError):json.loads('{"x":1,"x":2}',object_pairs_hook=v.unique)
 def test_unknown_arm(self):
  with self.assertRaises(ValueError):v.matrix(self.source(),'unknown')
if __name__=='__main__':unittest.main(verbosity=2)
