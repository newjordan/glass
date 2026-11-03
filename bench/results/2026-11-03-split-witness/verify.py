#!/usr/bin/env python3
"""Finite split-fragment evidence replay, not competitive acceptance or attestation."""
import hashlib
import json
import math
from pathlib import Path
import re

D=Path(__file__).resolve().parent
ROOT=D.parents[2]

def need(ok,why):
    if not ok: raise ValueError(why)

def unique(pairs):
    out={}
    for key,value in pairs:
        need(key not in out,'duplicate JSON key')
        out[key]=value
    return out

def load(raw): return json.loads(raw,object_pairs_hook=unique)
def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest()
def integer(x): return type(x) is int

def coords(rows):
    need(type(rows) is list,'coordinate list')
    for row in rows:
        need(type(row) is list and len(row)==3,'coordinate triple')
        need(integer(row[0]) and row[0]>=0,'absolute row')
        need(all(type(x) in (int,float) and math.isfinite(x) for x in row[1:]),'finite coordinates')
        need(row[1]>=0 and row[2]>0,'coordinate domain')

def shipping(text,arm):
    raw=re.findall(r'split-identity-json (\{[^\n]+\})',text)
    need(len(raw)==4,'four shipping observations')
    rows=[load(x) for x in raw];seen=set();failures=0
    fields={'before','deleted','expected','fast','got','local_death','next','pass','seq','sources','unique'}
    for r in rows:
        need(set(r)==fields,'record fields')
        need(all(type(r[k]) is bool for k in ['deleted','fast','local_death','pass']),'typed flags')
        key=(r['fast'],r['local_death']);need(key not in seen,'duplicate config');seen.add(key)
        for k in ['before','expected','got']:coords(r[k])
        before=[[2,1.0,1.0],[4,1.0,2.0],[7,1.0,5.0]]
        expected=before[1:] if r['local_death'] else before
        need(r['before']==before and r['expected']==expected,'independent physical oracle')
        want_sources=[[0,0,1,1/8],[0,1/8,1,2/8],[0,3/8,1,5/8]]
        need(type(r['sources']) is list and len(r['sources'])==3,'three source slices')
        for got,want in zip(r['sources'],want_sources):
            need(type(got) is list and len(got)==4,'source shape')
            need(all(type(a) in (int,float) and math.isfinite(a) and abs(a-b)<1e-5 for a,b in zip(got,want)),'source partition')
        need(type(r['seq']) is list and len(r['seq'])==3 and all(integer(x) and x>0 for x in r['seq']),'identifiers')
        count=len(set(r['seq']))
        need(integer(r['unique']) and r['unique']==count,'unique count')
        need(integer(r['next']) and r['next']>0,'next identifier')
        need(r['deleted'],'image-wide deletion lost')
        pass_value=r['got']==expected and count==3 and r['next']>max(r['seq'])
        need(r['pass']==pass_value,'computed flag')
        failures+=not pass_value
        if arm=='control':
            need(count==2 and r['seq'][1]==r['seq'][2]==r['seq'][0]+(1<<20),'control alias')
            need(r['next']<max(r['seq']),'control allocator collision')
            need(r['got']==([] if r['local_death'] else before),'control sibling loss')
        else:
            need(pass_value,'repaired fragment invariant')
    need(seen=={(a,b) for a in [False,True] for b in [False,True]},'complete configs')
    need(f'split-identity-summary cases=4 failures={failures}' in text,'computed summary')
    if arm=='control':need('0 passed; 1 failed;' in text and failures==4,'control failure exit evidence')
    else:need(failures==0 and 'test result: ok.' in text,'repair test execution')
    return {'cases':4,'failures':int(failures)}

def matrix(text):
    pattern=r'split-case fast=(false|true) inactive=(false|true) marker=(\d+) picture=(\d+) height=(\d+) above=(\d+) down=(\d+) got=(.*?) expected=(.*?) sources=(.*?) saved=(\d+) unique=(\d+) pass=(false|true)'
    matches=re.findall(pattern,text);need(len(matches)==1680,'1680 matrix observations')
    seen=set()
    for fast,inactive,marker,pic,height,above,down,got,expected,sources,saved,nunique,flag in matches:
        marker,pic,height,above,down=map(int,[marker,pic,height,above,down])
        key=(fast,inactive,marker,pic,height,above,down);need(key not in seen,'duplicate matrix config');seen.add(key)
        need(0<=marker<5 and pic in [8,9] and height in [3,4,5,6] and 1<=above<height and down in [1,2,3],'matrix domains')
        # Rust debug tuples parsed as JSON by delimiters only, not eval.
        parse=lambda v:load(v.replace('(', '[').replace(')', ']'))
        got,expected=map(parse,[got,expected]);coords(got);coords(expected)
        flat=10+pic+7*(above+down)
        want=[[1,pic,above],[flat//10,flat%10,height-above]]
        need(expected==want and got==want,'independent 7-column displacement oracle')
        source=load(sources);want_source=[[0,0,1,above/height],[0,above/height,1,(height-above)/height]]
        need(type(source) is list and len(source)==2,'matrix source shape')
        for a,b in zip(source,want_source):
            need(type(a) is list and len(a)==4 and all(type(x) in (int,float) and math.isfinite(x) and abs(x-y)<1e-5 for x,y in zip(a,b)),'matrix source crop')
        need(saved=='2' and nunique=='2' and flag=='true','matrix invariants')
    need('split-summary cases=1680 failures=0' in text,'matrix summary')
    need('test result: ok. 3 passed; 0 failed;' in text,'matrix executed tests')
    repeat=re.findall(r'split-repeat fast=(false|true) local_death=(false|true) unique=(\d+) saved=(\d+) got=(.*?) expected=([^\n]+)',text)
    need(len(repeat)==4 and len({r[:2] for r in repeat})==4,'four repeat configurations')
    for fast,death,unique_count,saved,got,expected in repeat:
        parse=lambda v:load(v.replace('(', '[').replace(')', ']'))
        got,expected=map(parse,[got,expected]);coords(got);coords(expected)
        want=[[1,8,1],[3,2,2],[5,3,5]]
        if death=='true':want=want[1:]
        need(got==expected==want and unique_count==saved=='3','repeat and local death oracle')
    return {'cases':1680,'failures':0,'repeat_cases':4}

def build(label):
    folder=D/('build-'+label);identity=load((folder/'identity.json').read_text())
    events=[load(x) for x in (folder/'cargo.jsonl').read_text().splitlines()]
    artifacts=[r for r in events if r.get('reason')=='compiler-artifact']
    for package in ['glass','vte','alacritty_terminal']:
        rows=[r for r in artifacts if r['target']['name']==package]
        need(len(rows)==1 and rows[0].get('fresh') is False,'actual package compilation')
    need(any(r.get('reason')=='build-finished' and r.get('success') is True for r in events),'completed build')
    test=[r for r in artifacts if r['target']['name']=='glass' and r.get('executable') and r['profile'].get('test')]
    need(len(test)==1 and test[0]['profile']['opt_level']=='3','release test build')
    for name,digest in identity['source_sha256'].items():
        prefix={'local-v2':'candidate-final-','shipping-control':'original-','production-final':'production-final-'}[label]
        snapshot=D/(prefix+name.replace('/','_'))
        # Control shares original runtime but contains the new regression test.
        if label=='shipping-control' and name.endswith('/position_tests.rs'):snapshot=D/'control-position_tests.rs'
        need(sha(snapshot)==digest,'build source binding '+name)
    executable=Path(identity['executable'])
    if executable.exists():need(sha(executable)==identity['sha256'],'retained binary changed')
    return identity['sha256']

def verify():
    inventory=load((D/'evidence-sha256.json').read_text())
    need(inventory['schema']=='glass.immutable-research-evidence/v1','manifest schema')
    for name,digest in inventory['sha256'].items():
        p=Path(name);need(not p.is_absolute() and '..' not in p.parts,'relative source')
        need(sha(ROOT/p)==digest,'changed evidence '+name)
    control=shipping((D/'shipping-control.log').read_text(),'control')
    production=shipping((D/'production-regressions.log').read_text(),'production')
    prototype=matrix((D/'local-split.log').read_text())
    need('test result: ok. 393 passed; 0 failed; 14 ignored;' in (D/'production-regressions.log').read_text(),'full production suite')
    binaries={a:build(a) for a in ['shipping-control','local-v2','production-final']}
    runs=load((D/'runs.json').read_text())
    need(type(runs) is list and len(runs)==3,'three measured runs')
    labels={'control':('shipping-control',101),'production':('production-final',0),'prototype':('local-v2',0)}
    need({r['arm'] for r in runs}==set(labels),'run arms')
    for r in runs:
        label,exit_code=labels[r['arm']]
        need(integer(r['exit']) and r['exit']==exit_code,'actual run exit')
        need(r['environment']=={'GLASS_SCROLLBACK':'10000'},'executed history configuration')
        need(r['binary_sha256']==binaries[label],'run binary binding')
        need(sha(D/r['log'])==r['log_sha256'],'run log binding')
        need(r['argv'][0]=='/tmp/glass-i42-'+label,'exact executable command')
        if r['arm']=='prototype':matrix((D/r['log']).read_text())
        else:shipping((D/r['log']).read_text(),'control' if r['arm']=='control' else 'production')
    state=load((D/'starting-state.json').read_text())
    need(sha(ROOT/'target/release/glass')==state['shipping_sha256'],'selected shipping executable changed')
    for name in state['sources']:
        p=ROOT/name
        if name in ['crates/term/src/intake/mod.rs','crates/term/src/intake/position_tests.rs']:
            need(sha(p)==sha(D/('production-final-'+name.replace('/','_'))),'production source changed')
        elif state['sources'][name] is None:need(not p.exists(),'prototype-only source left live')
        else:need(sha(p)==state['sources'][name]['sha256'],'unrelated runtime changed')
    return {'schema':'glass.split-fragment-replay/v1','shipping_control':control,'production':production,'prototype':prototype,'production_tests':393,'ignored':14,'binary_sha256':binaries,'selected_executable_unchanged':True,'note':'Finite physical-split fix; witness inheritance remains research-only. No benchmark, latency, memory, competitive or campaign acceptance.'}

if __name__=='__main__':print(json.dumps(verify(),indent=2))
