#!/usr/bin/env python3
"""Read-only finite replay of origin-map research; not acceptance or attestation."""
import ast
import hashlib
import importlib.util
import itertools
import json
from pathlib import Path
import re

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
H = [0, 1, 2, 8, 32, 10000]
CONTROL = [10288, 8496, 9728, 7616, 5756, 5756]
V3 = [0, 256, 48, 328, 432, 432]
PAT = re.compile(r'unicode-case rows=(\d+) target=(\d+) width=(\d+) cursor=(\d+) marker=(\d+) kind=([acez]) column=(\d+) records=(\d+) alt=(false|true) fast=(false|true) step=(\d+) text=(\[[^\]]*\]) pictures=(\[[^\]]*\]) ok=(true|false)')

def need(ok, why):
    if not ok:
        raise ValueError(why)

def unique(pairs):
    out = {}
    for k, v in pairs:
        need(k not in out, 'duplicate JSON key')
        out[k] = v
    return out

def load(path):
    return json.loads(Path(path).read_text(), object_pairs_hook=unique)

def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def keys():
    return {(r,t,w,c,m,k,col,n,a,f,s) for r in [4,6] for t in [2,4,8]
            for w in [3,7,14] for c in [0,r-1] for m in [0,r-1] for k in 'acez'
            for col in [0,3,8] for n in [0,12] for a in ['false','true']
            for f in ['false','true'] for s in range(3)}

def observations(text, wanted):
    seen = set()
    failures = 0
    for line in text.splitlines():
        if not line.startswith('unicode-case'):
            continue
        match = PAT.fullmatch(line)
        need(match is not None, 'unicode record format')
        g = match.groups()
        key = (*map(int,g[:5]),g[5],*map(int,g[6:8]),g[8],g[9],int(g[10]))
        need(key not in seen, 'duplicate unicode observation')
        seen.add(key)
        vectors = [ast.literal_eval(g[11]), ast.literal_eval(g[12])]
        for vector in vectors:
            need(isinstance(vector,list) and len(vector) <= 1 and all(isinstance(x,tuple) and len(x)==2 and all(type(c) is int for c in x) for x in vector), 'coordinate types and unique marker')
        ok = vectors[0] == vectors[1]
        need((g[13] == 'true') == ok, 'unicode match flag')
        failures += not ok
    need(seen == keys(), 'complete unicode identities')
    need(failures == wanted, 'unicode failure count')
    need(text.count(f'unicode-summary cases=20736 failures={failures}') == 1, 'unicode summary')
    need(len(re.findall(r'^unicode-summary',text,re.M))==1, 'single unicode summary')
    need(f'test result: {"FAILED" if failures else "ok"}. {0 if failures else 1} passed; {1 if failures else 0} failed;' in text,'nonzero unicode execution')
    return failures

def build(arm):
    folder = D / ('build-' + arm)
    identity = load(folder / 'identity.json')
    need(identity['command'] == ['cargo','test','--release','-p','glass-term','--locked','--no-run','--message-format=json'], 'build command')
    expected = {'crates/alacritty-terminal/src/grid/mod.rs','crates/alacritty-terminal/src/term/mod.rs','crates/term/src/engine.rs','crates/term/src/speed.rs','crates/vte/src/lib.rs','crates/vte/src/ansi.rs','crates/term/src/intake/position_tests.rs','crates/term/src/intake/motion.rs'}
    if arm.startswith('candidate'):
        expected |= {'crates/alacritty-terminal/src/grid/origin.rs','crates/alacritty-terminal/src/grid/storage.rs','crates/alacritty-terminal/src/grid/row.rs','crates/alacritty-terminal/src/grid/resize.rs'}
    need(set(identity['source_sha256'])==expected,'complete source bindings')
    for path,digest in identity['source_sha256'].items():
        frozen = D / (arm+'-'+path.replace('/','_'))
        need(sha(frozen if frozen.exists() else ROOT/path)==digest,'build source '+arm+':'+path)
    binary = Path(identity['executable'])
    if binary.exists():
        need(sha(binary)==identity['sha256'],'binary changed')
    cargo = [json.loads(line) for line in (folder/'cargo.jsonl').read_text().splitlines()]
    for target in ['glass','vte','alacritty_terminal']:
        rows = [r for r in cargo if r.get('reason')=='compiler-artifact' and r['target']['name']==target]
        need(len(rows)==1 and rows[0]['fresh'] is False,'nonfresh artifact '+target)
    need(cargo[-1]=={'reason':'build-finished','success':True},'build completed')
    return identity

def unicode_arm(arm, wanted):
    rows = load(D/(arm+'-tests.json'))[:6]
    need([r['label'] for r in rows]==['unicode-'+str(h) for h in H], 'ordered unicode histories')
    for row,h,w in zip(rows,H,wanted):
        need(row['args']==['--exact','--ignored','--nocapture','intake::position_tests::origin_map_unicode_marker_matrix'],'unicode command')
        need(row['settings']=={'GLASS_SCROLLBACK':str(h)},'unicode environment')
        need(row['exit']==(101 if w else 0),'unicode exit')
        path=D/row['log']
        need(path.name==arm+'-unicode-'+str(h)+'.log' and sha(path)==row['sha256'],'unicode log binding')
        observations(path.read_text(),w)

def mixed_observations(text, prior):
    seen=set()
    for line in text.splitlines():
        if not line.startswith('mixed-case'):
            continue
        match=prior.MIXED.fullmatch(line)
        need(match is not None,'mixed record format')
        g=match.groups()
        key=(*map(int,g[:6]),*g[6:9],int(g[9]))
        need(key not in seen,'duplicate mixed identity')
        seen.add(key)
        cells,pictures=ast.literal_eval(g[10]),ast.literal_eval(g[11])
        need(len(cells)<=1 and all(isinstance(v,list) and all(isinstance(x,tuple) and len(x)==2 and all(type(c) is int for c in x) for x in v) for v in [cells,pictures]),'mixed coordinate types')
        need(cells==pictures and g[12]=='true','mixed actual match')
    need(seen==prior.mixed_keys(),'complete mixed identities')
    need(text.count('mixed-summary cases=3456 failures=0')==1 and len(re.findall(r'^mixed-summary',text,re.M))==1,'mixed actual summary')
    need('test result: ok. 1 passed; 0 failed;' in text,'mixed actual execution')

def seal():
    manifest=load(D/'evidence-sha256.json')
    need(manifest.get('schema')=='glass.immutable-research-evidence/v1','evidence schema')
    need(isinstance(manifest.get('sha256'),dict) and manifest['sha256'],'nonempty evidence seal')
    for name,digest in manifest['sha256'].items():
        p=Path(name)
        need(not p.is_absolute() and '..' not in p.parts,'confined evidence name')
        need(sha(ROOT/p)==digest,'sealed evidence changed '+name)

def check():
    seal()
    state=load(D/'starting-state.json')
    updates={'CHANGELOG.md','bench/README.md','docs/PERFORMANCE.md'}
    for name in updates:
        need((ROOT/name).read_bytes().startswith((D/('original-'+name.replace('/','_'))).read_bytes()),'append-only research note '+name)
    for path,digest in state['preserve'].items():
        if path not in updates:
            need(sha(ROOT/path)==digest,'preserved tracked file '+path)
    for path,row in state['sources'].items():
        need(sha(D/row['source'])==row['sha256'] and sha(ROOT/path)==row['sha256'],'restored source '+path)
    need(not (ROOT/'crates/alacritty-terminal/src/grid/origin.rs').exists(),'experimental module removed')
    need(sha(ROOT/'target/release/glass')==state['shipping_sha256'],'selected executable unchanged')
    for arm in ['candidate-v1','candidate-v3','candidate-v4','candidate-v5','control','final','final-restored']:
        build(arm)
    for name,digest in build('final-restored')['source_sha256'].items():
        need(sha(ROOT/name)==digest,'final live source binding '+name)
    unicode_arm('control',CONTROL)
    unicode_arm('candidate-v3',V3)
    unicode_arm('candidate-v4',[0]*6)
    # The v3->v4 runtime contrast is exactly the absolute-base lower bound.
    old=(D/'candidate-v3-crates_term_src_engine.rs').read_text()
    new=(D/'candidate-v4-crates_term_src_engine.rs').read_text()
    need(new==old.replace('            reflow.exact = origin_map;', '            reflow.new_scrolled = reflow.new_scrolled.max(after.history as u64);\n            reflow.exact = origin_map;'),'single runtime contrast')
    for name in build('candidate-v4')['source_sha256']:
        if name!='crates/term/src/engine.rs':
            need((D/('candidate-v3-'+name.replace('/','_'))).read_bytes()==(D/('candidate-v4-'+name.replace('/','_'))).read_bytes(),'non-engine contrast unchanged')
    spec=importlib.util.spec_from_file_location('prior',ROOT/'bench/results/2026-11-03-height-snapshot/verify.py')
    prior=importlib.util.module_from_spec(spec);spec.loader.exec_module(prior)
    rows=load(D/'candidate-v4-regressions.json')
    need([r['label'] for r in rows]==[k+'-'+str(h) for k in ['height','mixed'] for h in H]+['terminal','sweep'],'regression inventory')
    for i,row in enumerate(rows):
        path=D/row['log'];need(sha(path)==row['sha256'],'regression hash')
        if i<12:
            kind='height' if i<6 else 'mixed';h=H[i%6]
            need(row['exit']==0 and row['args']==['--exact','--ignored','--nocapture','intake::position_tests::'+('height_snapshot_marker_picture_matrix' if kind=='height' else 'mixed_snapshot_marker_picture_matrix')] and row['settings']=={'GLASS_SCROLLBACK':str(h)},'regression command/exit')
            text=path.read_text()
            if kind=='height':prior.height_observations(text,h,0)
            else:
                mixed_observations(text, prior)
        elif i==12:
            text=path.read_text()
            need(row['exit']==101 and row['args']==[] and 'test result: FAILED. 388 passed; 4 failed; 16 ignored;' in text,'candidate suite rejection')
            need('intake::position_tests::a_reflow_keeps_a_picture_on_the_same_text' in text,'existing real regression')
        else:
            need(row['exit']==0 and 'swept 12800 streams over 64 seeds: no divergence' in path.read_text(),'candidate sweep executed')
    blank=(D/'candidate-v5-blank.log').read_text()
    need('exact=Some((0, 14.0)) inferred=Some((0, 14.0))' in blank and 'exact=None inferred=Some((1, 4.0))' in blank,'blank semantic contrast')
    need('blank slot after MARK is a semantic anchor' in blank and 'left: 0' in blank and 'right: 1' in blank and 'test result: FAILED. 0 passed; 1 failed;' in blank,'corrected blank probe fails on placement')
    need('test result: ok. 392 passed; 0 failed; 14 ignored;' in (D/'final-restored-terminal.log').read_text(),'restored suite executed')
    need('swept 12800 streams over 64 seeds: no divergence' in (D/'final-restored-sweep.log').read_text() and 'test result: ok. 1 passed; 0 failed;' in (D/'final-restored-sweep.log').read_text(),'restored sweep executed')
    need(load(D/'prior-checkpoint.json')==load(D/'restored-prior-checkpoint.json')==prior.check(),'prior exact checkpoint')
    return {'schema':'glass.origin-map-checkpoint/v1','histories':H,'unicode_observations_per_arm':124416,'control_failures':CONTROL,'untreated_base_failures':V3,'guarded_failures':[0]*6,'height_observations':56160,'mixed_observations':20736,'candidate_suite':{'passed':388,'failed':4,'ignored':16},'final_tests':392,'final_sweep_streams':12800,'runtime_promoted':False,'selected_sha256':state['shipping_sha256'],'preserved_tracked_files':len(state['preserve'])-len(updates)}

if __name__=='__main__':
    print(json.dumps(check(),indent=2,sort_keys=True))
