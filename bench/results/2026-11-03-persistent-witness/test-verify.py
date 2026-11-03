#!/usr/bin/env python3
"""Adversarial replay-checker tests, independent of Rust runtime."""
import importlib.util,unittest,json,re
from pathlib import Path
D=Path(__file__).resolve().parent
sp=importlib.util.spec_from_file_location('v',D/'verify.py');v=importlib.util.module_from_spec(sp);sp.loader.exec_module(v)
class Evidence(unittest.TestCase):
 def reject(self,check,changes):
  for label,changed in changes:
   with self.subTest(mutation=label):
    with self.assertRaises(ValueError):check(changed)
 def test_complete(self):
  r=v.check();self.assertFalse(r['runtime_promoted']);self.assertEqual(r['continuous_in_bounds_observations'],168296);self.assertEqual(r['broader_slot_failures'],2728)
 def test_roundtrip_mutations(self):
  text=(D/'candidate-final-persistent_witness_roundtrips.log').read_text();first=next(l for l in text.splitlines() if l.startswith('roundtrip-case'))
  changes=[('missing',text.replace(first+'\n','',1)),('duplicate',text+'\n'+first)]
  for old,new in [('alt=false','alt=maybe'),('fast=false','fast=maybe'),('name=tail','name=blank'),('step=0','step=4'),('pictures=[(1, 0)]','pictures=[]'),('expected=(1, 0)','expected=(0, 3)'),('delta: 3.0','delta: 0.0'),('Witness','Physical')]:
   self.assertIn(old,first);changes.append((old,text.replace(first,first.replace(old,new),1)))
  for old,new in [('roundtrip-summary cases=64','roundtrip-summary cases=0'),('test result: ok. 1 passed;','test result: ok. 0 passed;')]:changes.append((old,text.replace(old,new)))
  changes.append(('boolean coordinate',text.replace('pictures=[(1, 0)]','pictures=[(True, 0)]',1)))
  self.assertEqual(len(changes),13);self.reject(v.roundtrips,changes)
 def test_scroll_mutations(self):
  text=(D/'candidate-final-persistent_witness_intervening_scroll_characterization.log').read_text();first=next(l for l in text.splitlines() if l.startswith('scroll-characterization'))
  changes=[('missing',text.replace(first+'\n','',1)),('duplicate',text+'\n'+first),('wrong marker',text.replace('markers=[(1, 0)]','markers=[(2, 0)]',1)),('fake repair',text.replace('pictures=[(2, 3)]','pictures=[(1, 3)]',1)),('no execution',text.replace('test result: ok. 1 passed;','test result: ok. 0 passed;'))]
  self.assertEqual(len(changes),5);self.reject(v.scroll,changes)
 def test_slot_mutations(self):
  text=(D/'candidate-final-slots-0.log').read_text();first=next(l for l in text.splitlines() if l.startswith('slot-case'))
  changes=[('missing',text.replace(first+'\n','',1)),('duplicate',text+'\n'+first)]
  for old,new in [('rows=4','rows=5'),('target=2','target=9'),('cursor=0','cursor=1'),('width=3','width=4'),('marker=0','marker=1'),('column=0','column=1'),('kind=a','kind=q'),('gap=0','gap=1'),('records=0','records=1'),('alt=false','alt=maybe'),('fast=false','fast=maybe'),('step=0','step=3'),('checked=true','checked=false'),('ok=true','ok=false')]:
   self.assertIn(old,first);changes.append((old,text.replace(first,first.replace(old,new),1)))
  for name in ['text','expected','pictures']:changes.append((name,text.replace(first,re.sub(r'\b'+name+r'=\[[^\]]*\]',name+'=[(999, 999)]',first),1)))
  summary=next(l for l in text.splitlines() if l.startswith('slot-summary'));changes.append(('summary',text.replace(summary,'slot-summary cases=0 absent=0 failures=0')))
  self.assertEqual(len(changes),20);self.reject(v.BW.slots,changes)
 def test_deletion_mutations(self):
  text=(D/'candidate-final-deleted-0.log').read_text();first=next(l for l in text.splitlines() if l.startswith('deleted-case'))
  changes=[('missing',text.replace(first+'\n','',1)),('duplicate',text+'\n'+first)]
  for old,new in [('rows=4','rows=5'),('target=2','target=9'),('cols=3','cols=4'),('marker=0','marker=1'),('cursor=0','cursor=1'),('column=0','column=1'),('records=0','records=1'),('alt=false','alt=maybe'),('fast=false','fast=maybe'),('own=0','own=1'),('unrelated=0','unrelated=1'),('pictures=0','pictures=1'),('checked=false','checked=true')]:
   source=next(l for l in text.splitlines() if l.startswith('deleted-case') and 'checked=true' in l) if old in ['own=0','pictures=0'] else first
   self.assertIn(old,source);changes.append((old,text.replace(source,source.replace(old,new),1)))
  summary=next(l for l in text.splitlines() if l.startswith('deleted-summary'));changes.append(('summary',text.replace(summary,'deleted-summary cases=0 eligible=0 failures=0')))
  self.assertEqual(len(changes),16);self.reject(v.BW.deletion,changes)
 def test_coordinate_types(self):
  for text in ['[(True,0)]','[(0.0,1)]','[[0,1]]','[(0,)]','[(0,1,2)]','[(0,1),(0,1)]','{}']:
   with self.subTest(text=text):
    with self.assertRaises(ValueError):v.BW.vector(text)
 def test_duplicate_keys(self):
  with self.assertRaises(ValueError):json.loads('{"x":1,"x":2}',object_pairs_hook=v.unique)
if __name__=='__main__':unittest.main(verbosity=2)
