#!/usr/bin/env python3
"""Read-only semantic reproduction and source-preservation checkpoint, not acceptance."""
import ast
import hashlib
import itertools
import json
from pathlib import Path
import re

D=Path(__file__).resolve().parent;ROOT=D.parents[2]
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
load=lambda p:json.loads(Path(p).read_text())

def need(ok,msg):
    if not ok:raise ValueError(msg)

def matrix(raw,kind,arm):
    motion=['None','Some(18446744073709551615)']
    if kind=='primary':
        pattern=r'^movement-case history=(\d+) rows=(\d+) cursor=(\d+) height=(\d+) fast=(false|true) motion=(None|Some\(18446744073709551615\)) expected=(\[[0-9, ]+\]) actual=(\[[0-9, ]+\]) matched=(true|false)$'
        keys={(h,r,c,n,f,m) for h in [0,1,2,8,32,10000] for r in [4,6,12] for c in range(r) for n in range(1,r+1) for f in ['false','true'] for m in motion}
        count=4704;wanted=3136 if arm=='control' else 0
    else:
        pattern=r'^inactive-case history=(\d+) rows=(\d+) cursor=(\d+) height=(\d+) fast=(false|true) expected=(\d+) actual=(\d+),(\d+) matched=(true|false)$'
        keys={(h,r,c,n,f) for h in [0,1,8,10000] for r in [4,6,12] for c in range(r) for n in range(1,r) for f in ['false','true']}
        count=1392;wanted=1218 if arm=='control' else 0
    # Bind observed numeric rows as well as recomputing expectation truth.
    # This is a frozen observation identity, not proof that control is correct.
    observed={('control', 'primary'): '8c375c431cd3ee506620f00ebb18a6f2be3946302f492d8ce62fb2c267309d53', ('control', 'inactive'): '7cac9c23f5c07efc4e333084ca1b7ac39297c8c3d389b683b97fad1ac2ecdcca', ('candidate', 'primary'): 'bc79466e607303b0be19416c33620789ba5b3bf200df3e31ff1d90accaa9622a', ('candidate', 'inactive'): '307d35ee0bafc7dfbf7af0aa88a53f441626b825a7a09317d0927fb44a199162'}
    prefix='movement-case' if kind=='primary' else 'inactive-case'
    projection='\n'.join(s for s in raw.splitlines() if s.startswith(prefix))+'\n'
    need(hashlib.sha256(projection.encode()).hexdigest()==observed[(arm,kind)],'numeric observation identity')
    seen=set();miss=0
    for row in re.findall(pattern,raw,re.M):
        h,r,c,n=map(int,row[:4]);f=row[4]
        key=(h,r,c,n,f,row[5]) if kind=='primary' else (h,r,c,n,f)
        need(key in keys and key not in seen,'matrix case identity');seen.add(key)
        if kind=='primary':
            initial=25-r;shrunk=initial+max(c+1-n,0)
            expected=[initial,shrunk,shrunk+1,shrunk+1,shrunk+1,shrunk+2]
            need(ast.literal_eval(row[6])==expected,'independent primary expected vector')
            actual=ast.literal_eval(row[7]);need(len(actual)==6,'primary actual vector length')
        else:
            expected=25-r+max(c+1-n,0)
            need(int(row[5])==expected,'independent inactive expected coordinate')
            actual=tuple(map(int,row[6:8]));expected=(expected,expected)
        matched=actual==expected
        need(row[-1]==str(matched).lower(),'matrix match flag');miss+=not matched
    need(seen==keys and len(seen)==count,'incomplete matrix')
    need(miss==wanted,'unexpected measured mismatch count')
    label='movement' if kind=='primary' else 'inactive'
    need(f'{label} oracle: {count} cases checked; {miss} mismatches' in raw,'matrix summary')
    need(('test result: ok. 1 passed; 0 failed;' if miss==0 else 'test result: FAILED. 0 passed; 1 failed;') in raw,'matrix test outcome')
    return dict(cases=count,mismatches=miss)

def observations(arm,rows,logs):
    primary='movement_authority_cursor_history_resize_matrix';inactive='movement_authority_inactive_primary_resize';coord='movement_authority_growth_coordinate_diagnostic';pic='growth_keeps_picture_on_marker_diagnostic'
    labels=['terminal-tests',primary,inactive,coord,pic]+['history-'+str(h) for h in [0,1,2,8,32,10000]]+['sweep']
    need([r['label'] for r in rows]==labels and set(logs)==set(labels),'observation identity')
    codes=[0,101,101,101,101]+[101]*5+[0,0] if arm=='control' else [0,0,0,101,101]+[0]*7
    need([r['exit'] for r in rows]==codes,'expected reproduction exits')
    for row in rows:
        raw=logs[row['label']]
        need(hashlib.sha256(raw.encode()).hexdigest()==row['sha256'],'observation hash')
        need(('test result: ok.' if row['exit']==0 else 'test result: FAILED.') in raw,'observation test result')
        if row['label']!='terminal-tests':
            need(('1 passed; 0 failed;' if row['exit']==0 else '0 passed; 1 failed;') in raw,'exactly one test executed')
            need(row['args'][:2]==['--exact','--nocapture'] or row['label']=='sweep','exact test invocation')
        expected_settings={'GLASS_SCROLLBACK':row['label'].removeprefix('history-') if row['label'].startswith('history-') else '10000'}
        if row['label']=='sweep':expected_settings.update(GLASS_SWEEP_SEEDS='64',GLASS_SWEEP_ROUNDS='200')
        need(row['settings']==expected_settings,'explicit isolated test settings')
    result={kind:matrix(logs[label],kind,arm) for kind,label in [('primary',primary),('inactive',inactive)]}
    need('growth-coordinate before=9 marker_row=2 after=11 reflow=false' in logs[coord],'coordinate growth defect')
    need('growth-picture before_row=0 marker_row=2 picture_row=0 reflow=false' in logs[pic],'picture growth defect')
    for h in [0,1,2,8,32,10000]:
        records=re.findall(r'^configured-movement history=(\d+) fast=(false|true) motion=(None|Some\(18446744073709551615\)) expected=(\d+) actual=(\d+)$',logs['history-'+str(h)],re.M)
        if arm=='control' and h!=10000:
            need(records==[(str(h),'false','None','11997','0' if h==0 else '3')],'short-history reproduction')
        else:
            need(records==[(str(h),f,m,'11997','11997') for f in ['false','true'] for m in ['None','Some(18446744073709551615)']],'configured history completeness')
    need('swept 12800 streams over 64 seeds: no divergence' in logs['sweep'],'nonzero sweep')
    need(f'test result: ok. {388 if arm=="control" else 391} passed; 0 failed;' in logs['terminal-tests'],'existing suite count')
    return result

def check():
    state=load(D/'starting-state.json')
    for field in ['prior_evidence','docs']:
        for p,h in state[field].items():need(sha(ROOT/p)==h,'preservation '+p)
    modified={'crates/term/src/engine.rs','crates/term/src/intake/position_tests.rs'}
    for p,h in state['sources'].items():
        if p not in modified:need(sha(ROOT/p)==h,'unchanged source '+p)
    for p in modified:
        original=(D/('original-'+p.replace('/','_'))).read_text()
        need(hashlib.sha256(original.encode()).hexdigest()==state['sources'][p],'original source hash')
        addition=(D/('final-engine-regression-v2.rs.txt' if p.endswith('engine.rs') else 'final-picture-regression-v2.rs.txt')).read_text()
        need(addition.count('#[test]')==1,'regression test-only scope')
        final=original.replace('    #[test]\n    fn lines_scrolled_off_top_count_exactly()',addition+'    #[test]\n    fn lines_scrolled_off_top_count_exactly()') if p.endswith('engine.rs') else original+addition
        need((ROOT/p).read_text()==final,'final exact test-only delta')
    need(sha(ROOT/state['selected']['path'])==state['selected']['sha256'],'shipping binary preservation')
    changed=['crates/alacritty-terminal/src/grid/mod.rs','crates/alacritty-terminal/src/term/mod.rs',*sorted(modified)]
    result={}
    for arm in ['control','candidate','final']:
        b=D/('build-bound-'+arm);ident=load(b/'identity.json')
        need(set(ident['source_sha256'])==set(changed+['crates/term/src/speed.rs','crates/vte/src/lib.rs','crates/vte/src/ansi.rs']),'complete build source binding')
        for p,h in ident['source_sha256'].items():
            need(sha(D/('bound-'+arm+'-'+p.replace('/','_')) if p in changed else ROOT/p)==h,'exact arm source '+arm+':'+p)
        if Path(ident['executable']).exists():
            need(sha(ident['executable'])==ident['sha256'],'built binary hash')
        # Receipts/snapshots remain replayable after temporary ELFs expire;
        # a receipt is not compiler attestation or reproduction of the ELF.
        if arm=='final':
            for path in changed:need(sha(ROOT/path)==ident['source_sha256'][path],'final live build source binding')
        cargo=[json.loads(s) for s in (b/'cargo.jsonl').read_text().splitlines()]
        for name in ['glass','vte','alacritty_terminal']:
            targets=[r for r in cargo if r.get('reason')=='compiler-artifact' and r['target']['name']==name]
            need(len(targets)==1 and targets[0]['fresh'] is False,'nonfresh package receipt')
        need(cargo[-1].get('success') is True,'build completion')
        rows=load(D/('bound-'+arm+'-tests.json'));logs={r['label']:(D/r['log']).read_text() for r in rows}
        if arm!='final':result[arm]=observations(arm,rows,logs)
        else:
            need([r['exit'] for r in rows]==[0]*4,'final test exits')
            for row in rows:need(sha(D/row['log'])==row['sha256'],'final log binding')
            need('test result: ok. 390 passed; 0 failed; 12 ignored;' in logs['terminal-tests'],'final suite')
            for r in rows[1:]:need('test result: ok. 1 passed; 0 failed;' in logs[r['label']],'final exact tests')
            need('swept 12800 streams over 64 seeds: no divergence' in logs['sweep'],'final differential streams')
    # Ensure both diagnostic arms used identical oracles; not an easier candidate test.
    e='crates/term/src/engine.rs';needle='    #[test]\n    fn lines_scrolled_off_top_count_exactly()'
    addition=(D/'oracle.rs.txt').read_text()+(D/'alt-oracle.rs.txt').read_text()
    control=(D/'bound-control-crates_term_src_engine.rs').read_text()
    need(control==(D/'original-crates_term_src_engine.rs').read_text().replace(needle,addition+needle),'control test-only diagnostic delta')
    need(addition in (D/'bound-candidate-crates_term_src_engine.rs').read_text(),'identical candidate oracle')
    need(sha(D/'bound-control-crates_term_src_intake_position_tests.rs')==sha(D/'bound-candidate-crates_term_src_intake_position_tests.rs'),'identical picture oracle')
    # New experiment checker must itself retain its measured negative tests.
    probe=load(D/'probe-100.json')
    need(probe['exit']==101 and sha(D/probe['log'])==probe['sha256'],'active mutation receipt')
    raw=(D/probe['log']).read_text()
    need('diverges' in raw and 'test result: FAILED. 0 passed; 1 failed;' in raw,'active mutation failed exactly one test')
    inert=load(D/'negative-probe.json')
    need(inert['exit']==0 and inert['settings']['GLASS_RUN_PROBE']=='5' and sha(D/inert['log'])==inert['sha256'],'inert probe receipt')
    need('swept 12800 streams over 64 seeds: no divergence' in (D/inert['log']).read_text(),'inert probe sweep')
    py=(D/'python-tests.log').read_text()
    need('Ran 4 tests' in py and '\nOK\n' in py and 'Rejected rehashed/receipt evidence corruptions: 56' in py,'Python negative tests')
    if (D/'evidence-sha256.json').exists():
        for p,h in load(D/'evidence-sha256.json').items():need(sha(ROOT/p)==h,'frozen evidence '+p)
    result.update(schema='glass.movement-authority-checkpoint/v1',status='reported',runtime_promotion=False,performance_sessions=0,championship_established=False,final_terminal_tests=390,streams_per_arm=12800,python_tests=4,rejected_evidence_corruptions=56,selected_sha256=state['selected']['sha256'],unchanged_prior_evidence_files=len(state['prior_evidence']),unchanged_other_rust_sources=sum(p.startswith('crates/') for p in state['sources'])-2,unfixed_defects=['short-history counting','inactive-primary shrink coordinates','height-growth picture coordinates'])
    return result

if __name__=='__main__':print(json.dumps(check(),indent=2))
