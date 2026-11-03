#!/usr/bin/env python3
"""Adversarial finite checker tests, separate from the experiment's oracle."""
import importlib.util,unittest,json
from pathlib import Path
D=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('verify',D/'verify.py');v=importlib.util.module_from_spec(spec);spec.loader.exec_module(v)
class Evidence(unittest.TestCase):
 def test_complete(self):
  result=v.check();self.assertFalse(result['runtime_promoted']);self.assertEqual(result['final_tests'],392)
 def test_slots_reject_mutations(self):
  text=(D/'witness-blank_witness_marker_matrix-0.log').read_text();lines=text.splitlines();i=next(i for i,s in enumerate(lines) if s.startswith('slot-case'))
  mutations=[]
  mutations.append('\n'.join(lines[:i]+lines[i+1:]))
  mutations.append(text+'\n'+lines[i])
  first=lines[i]
  for old,new in [('rows=4','rows=5'),('target=2','target=9'),('cursor=0','cursor=1'),('width=3','width=4'),('marker=0','marker=1'),('column=0','column=1'),('kind=a','kind=q'),('gap=0','gap=1'),('records=0','records=1'),('alt=false','alt=maybe'),('fast=false','fast=maybe'),('step=0','step=3'),('checked=true','checked=false'),('ok=true','ok=false')]:
   self.assertIn(old,first);mutations.append(text.replace(first,first.replace(old,new),1))
  import re
  for name in ['text','expected','pictures']:
   changed=re.sub(r'\b'+name+r'=\[[^\]]*\]',name+'=[(999, 999)]',first)
   mutations.append(text.replace(first,changed,1))
  summary=next(s for s in lines if s.startswith('slot-summary'))
  mutations.append(text.replace(summary,'slot-summary cases=0 absent=0 failures=0'))
  for index,changed in enumerate(mutations):
   with self.subTest(index=index):
    with self.assertRaises(ValueError):v.slots(changed)
  self.assertEqual(len(mutations),20)
 def test_deletion_reject_mutations(self):
  text=(D/'control-blank_witness_deleted_line_matrix-0.log').read_text();first=next(s for s in text.splitlines() if s.startswith('deleted-case'))
  changes=[text+'\n'+first,text.replace(first+'\n','',1)]
  for old,new in [('rows=4','rows=5'),('target=2','target=9'),('cols=3','cols=4'),('marker=0','marker=1'),('cursor=0','cursor=1'),('column=0','column=1'),('records=0','records=1'),('alt=false','alt=maybe'),('fast=false','fast=maybe')]:
   self.assertIn(old,first);changes.append(text.replace(first,first.replace(old,new),1))
  eligible=next(s for s in text.splitlines() if s.startswith('deleted-case') and 'checked=true' in s and 'ok=false' in s)
  for old,new in [('pictures=1','pictures=0'),('own=0','own=1'),('unrelated=1','unrelated=0'),('checked=true','checked=false'),('ok=false','ok=true')]:
   changes.append(text.replace(eligible,eligible.replace(old,new),1))
  for i,changed in enumerate(changes):
   with self.subTest(index=i):
    with self.assertRaises(ValueError):v.deletion(changed)
  self.assertEqual(len(changes),16)
 def test_coordinate_types(self):
  for value in ['[(True, 0)]','[(0.0, 1)]','[[0, 1]]','[(0,)]','[(0, 1, 2)]','[(0,1), (0,1)]','{}']:
   with self.subTest(value=value):
    with self.assertRaises(ValueError):v.vector(value)
 def test_duplicate_keys(self):
  with self.assertRaises(ValueError):json.loads('{"x":1,"x":2}',object_pairs_hook=v.unique)
if __name__=='__main__':unittest.main(verbosity=2)
