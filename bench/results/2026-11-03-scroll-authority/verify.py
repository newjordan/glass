#!/usr/bin/env python3
"""Read-only exact-source, semantic-rejection and preservation checkpoint; not acceptance."""
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()
load = lambda p: json.loads(Path(p).read_text())


def need(ok, message):
    if not ok:
        raise ValueError(message)


def text(name):
    return (D/name).read_text()


def semantic_report(control, candidate, control_rows, candidate_rows):
    """Recompute facts from complete logs, not a worker's success boolean."""
    pattern = re.compile(r'^resize-case rows=(\d+) height=(\d+) fast=(false|true) motion=(None|Some\(18446744073709551615\)) expected=(\d+),(\d+) actual=(\d+),(\d+) matched=(false|true)$', re.M)
    expected = {(r, h, f, m) for r in [4, 6, 12] for h in range(1, r)
                for f in ['false', 'true'] for m in ['None', 'Some(18446744073709551615)']}
    for arm, raw, rows, resize_exit in [('control', control, control_rows, 0), ('candidate', candidate, candidate_rows, 101)]:
        need([r['exit'] for r in rows] == [0, resize_exit, 101 if arm == 'control' else 0], arm+' expected test outcomes')
        need([r['test'] for r in rows] == ['scroll_authority_literal_boundaries', 'scroll_authority_height_only_resize_preserves_absolute_lines', 'scroll_authority_configured_history_diagnostic'], arm+' test ordering')
        need(rows[0]['settings'] == rows[1]['settings'] == {} and rows[2]['settings'] == {'GLASS_SCROLLBACK':'8'}, arm+' explicit environment')
        for i, log in enumerate(raw):
            need(hashlib.sha256(log.encode()).hexdigest() == rows[i]['sha256'], arm+' log hash')
            need(('test result: ok.' if rows[i]['exit'] == 0 else 'test result: FAILED.') in log, arm+' test outcome marker')
        need('scroll literal oracle: 662 independent cases matched' in raw[0], arm+' literal cases')
        seen = set()
        for row in pattern.findall(raw[1]):
            r,h,f,m,er,eo,ar,ao,matched = row
            r,h,er,eo,ar,ao = map(int, [r,h,er,eo,ar,ao])
            key = (r,h,f,m)
            need(key in expected and key not in seen, arm+' resize identity')
            seen.add(key)
            need((er,eo) == (r-h,r-h+1), arm+' resize expectation')
            wanted = (er,eo,'true') if arm == 'control' else (0,1,'false')
            need((ar,ao,matched) == wanted, arm+' resize measurement')
        need(seen == expected, arm+' incomplete resize matrix')
        summary = '76 independent cases checked; '+('0' if arm == 'control' else '76')+' mismatches'
        need(summary in raw[1], arm+' resize summary')
        tiny = re.findall(r'^configured-history fast=(false|true) motion=(None|Some\(18446744073709551615\)) history=(\d+) expected=(\d+) actual=(\d+)$', raw[2], re.M)
        need(len(tiny) == 4 and len({(f,m) for f,m,*_ in tiny}) == 4, arm+' configured history matrix')
        for f,m,h,e,a in tiny:
            want = 11997 if arm == 'candidate' else (3 if m == 'None' else 10664)
            need((int(h),int(e),int(a)) == (8,11997,want), arm+' configured history result')
    return {'literal_cases_per_arm':662,'resize_cases_per_arm':76,'control_resize_mismatches':0,
            'candidate_resize_mismatches':76,'configured_history_cases_per_arm':4,
            'control_history_counts':{'no_picture':3,'unknown_picture_extent':10664},
            'candidate_history_count':11997,'expected_history_count':11997}


def measured():
    rows = [load(D/(arm+'-finaldiag-results.json')) for arm in ['control','candidate']]
    logs = [[text(row['log']) for row in group] for group in rows]
    return semantic_report(*logs,*rows)


def check():
    state = load(D/'starting-state.json')
    for p,h in state['prior_evidence'].items():
        need(sha(ROOT/p)==h,'changed prior evidence: '+p)
    for p,h in state['docs'].items():
        need(sha(ROOT/p)==h,'changed shared docs: '+p)
    engine = 'crates/term/src/engine.rs'
    for p,h in state['sources'].items():
        if p != engine:
            need(sha(ROOT/p)==h,'changed runtime/source: '+p)
    original = text('original-crates_term_src_engine.rs')
    need(hashlib.sha256(original.encode()).hexdigest()==state['sources'][engine],'original engine hash')
    needle = '    #[test]\n    fn lines_scrolled_off_top_count_exactly()'
    oracle = text('oracle.rs.txt')
    need(original.count(needle)==1 and (ROOT/engine).read_text()==original.replace(needle,oracle+needle),'final engine is not exact test-only addition')
    need(oracle.count('#[test]')==2 and oracle.count('    fn ')==2,'retained regression test scope')
    need('configured_history_diagnostic' not in (ROOT/engine).read_text(),'archive-only failing diagnostic leaked')
    need(sha(ROOT/state['selected']['path'])==state['selected']['sha256'],'selected executable changed')
    diagnostic = text('configured-history-diagnostic.rs.txt')
    # Bind raw observations to exact recompiled source sets for both diagnostic arms.
    for arm in ['control-initial','candidate-initial','control','candidate','final']:
        b = ('build-'+arm.removesuffix('-initial') if arm.endswith('-initial') else
             'build-final' if arm=='final' else 'build-'+arm+'-finaldiag')
        identity = load(D/b/'identity.json')
        for p,h in identity['source_sha256'].items():
            if p==engine:
                if arm=='control-initial':
                    want = state['sources'][p]
                elif arm=='candidate-initial':
                    candidate_source = text('candidate-crates_term_src_engine.rs')
                    need(candidate_source.count(oracle+diagnostic)==1,'candidate diagnostic scope')
                    want = hashlib.sha256(candidate_source.replace(oracle+diagnostic,'').encode()).hexdigest()
                elif arm=='control':
                    want = hashlib.sha256(original.replace(needle,oracle+diagnostic+needle).encode()).hexdigest()
                elif arm=='candidate':
                    want = sha(D/'candidate-crates_term_src_engine.rs')
                    need((oracle+diagnostic) in text('candidate-crates_term_src_engine.rs'),'candidate oracle source mismatch')
                else:
                    want = sha(ROOT/p)
            elif arm.startswith('candidate') and p in ['crates/alacritty-terminal/src/grid/mod.rs','crates/alacritty-terminal/src/term/mod.rs']:
                want=sha(D/('candidate-'+p.replace('/','_')))
            else:
                want=state['sources'][p]
            need(h==want,arm+' build source mismatch: '+p)
        receipts=[json.loads(line) for line in (D/b/'cargo.jsonl').read_text().splitlines()]
        need(any(r.get('reason')=='build-finished' and r.get('success') for r in receipts),arm+' missing successful build')
        for package in ['glass','vte','alacritty_terminal']:
            artifacts=[r for r in receipts if r.get('reason')=='compiler-artifact' and r['target']['name']==package]
            need(len(artifacts)==1 and artifacts[0]['fresh'] is False,arm+' stale build '+package)
        artifact=[r for r in receipts if r.get('reason')=='compiler-artifact' and r.get('executable') and r['target']['name']=='glass' and r['profile']['test']]
        need(len(artifact)==1,arm+' executable ambiguity')
        if Path(identity['executable']).exists():
            need(sha(identity['executable'])==identity['sha256'],arm+' local executable changed')
    result = measured()
    for arm in ['control','candidate']:
        need('test result: ok. 386 passed; 0 failed; 12 ignored;' in text(arm+'-terminal-tests.log'),arm+' full suite')
        need('swept 12800 streams over 64 seeds: no divergence' in text(arm+'-sweep.log'),arm+' sweep')
    final=load(D/'final-tests.json')
    need([r['label'] for r in final]==['terminal-tests','literal','resize','sweep'],'final tests ordering')
    for r in final:
        need(r['exit']==0 and sha(D/r['log'])==r['sha256'],'final tests failed/log changed')
    need('test result: ok. 388 passed; 0 failed; 12 ignored;' in text('final-terminal-tests.log'),'final full suite')
    need('662 independent cases matched' in text('final-literal.log'),'final literal oracle')
    need('76 independent cases checked; 0 mismatches' in text('final-resize.log'),'final resize oracle')
    need('swept 12800 streams over 64 seeds: no divergence' in text('final-sweep.log'),'final sweep')
    need(not list(D.glob('*-passes.jsonl')) and not (D/'raw.json').exists(),'performance branch unexpectedly ran')
    # Frozen bytes are replayed separately; these are not independent truth or compiler proof.
    if (D/'evidence-sha256.json').exists():
        for p,h in load(D/'evidence-sha256.json').items():
            need(sha(ROOT/p)==h,'frozen artifact changed: '+p)
    need('Ran 4 tests' in text('python-tests.log') and '\nOK\n' in text('python-tests.log') and 'Rejected semantic corruptions: 36' in text('python-tests.log'),'Python negative tests')
    result.update(python_tests=4, rejected_semantic_corruptions=36, schema='glass.scroll-authority-checkpoint/v1',status='reported',runtime_promotion=False,
                  championship_established=False,performance_sessions=0,
                  tests_per_initial_arm=386,final_terminal_tests=388,streams_per_arm=12800,
                  unchanged_other_rust_sources=len(state['sources'])-1,
                  unchanged_prior_evidence_files=len(state['prior_evidence']),selected_sha256=state['selected']['sha256'],
                  note='Local semantic rejection and archive replay. Resize rows enter history even without output; authoritative output-only counter is incomplete. Small-history defect is reported, not fixed. No performance/competitor acceptance or independent audit.')
    return result


if __name__=='__main__':
    print(json.dumps(check(),indent=2))
