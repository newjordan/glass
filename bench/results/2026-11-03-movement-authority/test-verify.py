#!/usr/bin/env python3
import copy
import hashlib
import importlib.util
from pathlib import Path
import unittest

D=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('checkpoint',D/'verify.py');v=importlib.util.module_from_spec(spec);spec.loader.exec_module(v)

class EvidenceTests(unittest.TestCase):
    def data(self,arm):
        rows=v.load(D/('bound-'+arm+'-tests.json'))
        return rows,{r['label']:(D/r['log']).read_text() for r in rows}

    def test_actual_results(self):
        for arm in ['control','candidate']:
            rows,logs=self.data(arm);out=v.observations(arm,rows,logs)
            self.assertEqual(out['primary']['cases'],4704);self.assertEqual(out['inactive']['cases'],1392)

    def test_complete_checkpoint(self):
        self.assertEqual(v.check()['final_terminal_tests'],390)

    def test_rehashed_semantic_corruptions_rejected(self):
        total=0
        for arm in ['control','candidate']:
            base_rows,base_logs=self.data(arm)
            def reject(label,edit,receipt_edit=None):
                nonlocal total
                rows,logs=copy.deepcopy(base_rows),copy.deepcopy(base_logs)
                if label:logs[label]=edit(logs[label])
                for r in rows:r['sha256']=hashlib.sha256(logs[r['label']].encode()).hexdigest()
                if receipt_edit:receipt_edit(rows)
                with self.assertRaises(ValueError,msg=f'{arm}:{label}:{total}'):
                    v.observations(arm,rows,logs)
                total+=1
            for label,prefix in [('movement_authority_cursor_history_resize_matrix','movement-case'),('movement_authority_inactive_primary_resize','inactive-case')]:
                lines=base_logs[label].splitlines(True);line=next(s for s in lines if s.startswith(prefix))
                reject(label,lambda raw:raw.replace(line,'',1))
                reject(label,lambda raw:raw.replace(line,line+line,1))
                reject(label,lambda raw:raw.replace('history=0','history=999',1))
                reject(label,lambda raw:raw.replace('matched=true','matched=false',1))
                reject(label,lambda raw:raw.replace('expected=[21,','expected=[22,',1) if prefix=='movement-case' else raw.replace('expected=21','expected=22',1))
                reject(label,lambda raw:raw.replace('cases checked;','cases claimed;',1))
                reject(label,lambda raw:raw.replace('test result:','test claimed:',1))
                reject(label,lambda raw:raw.replace('actual=[0,','actual=[999,',1) if arm=='control' and prefix=='movement-case' else raw.replace('matched=false','matched=true',1) if arm=='control' else raw.replace('actual=[21,','actual=[999,',1) if prefix=='movement-case' else raw.replace('actual=21,21','actual=999,21',1))
            reject('movement_authority_growth_coordinate_diagnostic',lambda s:s.replace('after=11','after=9'))
            reject('growth_keeps_picture_on_marker_diagnostic',lambda s:s.replace('picture_row=0','picture_row=2'))
            reject('history-10000',lambda s:s.replace('actual=11997','actual=0',1))
            reject('history-10000',lambda s:s.replace('motion=None','motion=Some(18446744073709551615)',1))
            reject('sweep',lambda s:s.replace('swept 12800','swept 0'))
            reject('sweep',lambda s:s.replace('1 passed;','0 passed;'))
            reject('terminal-tests',lambda s:s.replace(f'{388 if arm=="control" else 391} passed;', '0 passed;'))
            reject(None,None,lambda rs:rs[1].update(exit=0 if arm=='control' else 101))
            reject(None,None,lambda rs:rs[1].update(label='unexecuted-test'))
            reject(None,None,lambda rs:rs[1].update(settings={}))
            reject(None,None,lambda rs:rs[1].update(args=['--list']))
            reject(None,None,lambda rs:rs[1].update(sha256='0'*64))
        self.assertEqual(total,56)
        print(f'Rejected rehashed/receipt evidence corruptions: {total}',flush=True)

    def test_preservation_and_scope(self):
        state=v.load(D/'starting-state.json')
        for p in ['crates/alacritty-terminal/src/term/mod.rs','crates/alacritty-terminal/src/grid/mod.rs']:
            self.assertEqual(v.sha(v.ROOT/p),state['sources'][p])
        for p in ['crates/term/src/engine.rs','crates/term/src/intake/position_tests.rs']:
            self.assertNotEqual(v.sha(v.ROOT/p),state['sources'][p])

if __name__=='__main__':unittest.main(verbosity=2)
