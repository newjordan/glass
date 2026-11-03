#!/usr/bin/env python3
"""Iteration 19 canonical read-only checkpoint. No capture, repair or promotion."""
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]

def load_module(name,path):
    spec=importlib.util.spec_from_file_location(name,path)
    result=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def fingerprint(root):
    return {str(p.relative_to(root)):hashlib.sha256(p.read_bytes()).hexdigest()
            for p in root.rglob('*') if p.is_file() and '__pycache__' not in p.parts}


def check():
    before=fingerprint(HERE)
    starting=json.loads((HERE/'starting-state.json').read_text())
    for field in ('rust_sha256','prior_sha256'):
        for path,digest in starting[field].items():
            assert hashlib.sha256((ROOT/path).read_bytes()).hexdigest()==digest,path
    binary=ROOT/'target/release/glass'
    assert hashlib.sha256(binary.read_bytes()).hexdigest()==starting['binary_sha256']
    assert binary.read_bytes()==Path('/tmp/glass-i17-selected').read_bytes()
    analyzer=load_module('partition_final',ROOT/'bench/linux/analyze-role-partition.py')
    sessions=0
    for name in ('pilot','confirmatory'):
        result=analyzer.analyze(HERE/name)
        assert result==analyzer.load(HERE/f'{name}-replay.json'),name
        sessions+=result['sessions']
    assert sessions==155
    confirm=analyzer.load(HERE/'confirmatory-replay.json')
    assert confirm['prospective_gate_clears'] is False
    corruption=json.loads(subprocess.check_output([sys.executable,'-B',str(HERE/'check-corruption.py')],cwd=ROOT,text=True))
    assert corruption==analyzer.load(HERE/'corruption-replay.json')
    assert sum(x.get('rejected',False) for x in corruption['cases'])==15
    assert sum(x.get('reported_not_rejected',False) for x in corruption['cases'])==1
    cleanup=analyzer.load(HERE/'signal-smoke-replay.json')
    assert len(cleanup['cases'])==4 and all(x['restored'] and not x['complete'] for x in cleanup['cases'])
    for case in cleanup['cases']:
        meta=analyzer.load(HERE/'signal-smoke'/f"{case['case']}.placement.json")
        assert not meta['complete'] and not meta['cleanup_errors']
        assert all(meta['roles_restored'][k]['allowed']==v for k,v in meta['original'].items())
    competitor=load_module('competitor_final',HERE/'summarize-competitor.py').summarize()
    assert competitor==analyzer.load(HERE/'competitor-summary.json')
    commands=[
        [sys.executable,'-B',str(HERE/'recompute-primary.py')],
        [sys.executable,'-B','-m','unittest','discover','-s','bench','-p','test_*.py'],
        [sys.executable,'-B','bench/replay-evidence-index.py','bench/results/2026-11-03-hot-placement/frozen-index.json'],
        [sys.executable,'-B','bench/results/2026-11-03-hot-placement/replay-initial-rejection.py'],
    ]
    if (HERE/'frozen-index.json').is_file():
        commands.append([sys.executable,'-B','bench/replay-evidence-index.py','bench/results/2026-11-03-role-partition/frozen-index.json'])
    for cmd in commands:
        result=subprocess.run(cmd,cwd=ROOT,text=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        assert result.returncode==0,(cmd,result.stdout,result.stderr)
    assert fingerprint(HERE)==before,'canonical checkpoint changed evidence'
    return dict(schema='glass.role-partition-checkpoint/v1',policy_sessions=sessions,
                competitor_sessions=competitor['sessions'],corruption_rejections=15,
                reported_transition_positive_controls=1,cleanup_cases=4,python_tests=49,
                rust_sources_unchanged=len(starting['rust_sha256']),
                prior_artifacts_unchanged=len(starting['prior_sha256']),
                binary_sha256=starting['binary_sha256'],binary_byte_comparison=True,
                role_policy_promoted=False,all_six_competitor_throughput_leads=competitor['all_six_throughput_leads'],
                canonical_evidence_unchanged=True,
                note='Executable local integrity/checker checkpoint, not timing accuracy, default-runtime change or championship acceptance.')

if __name__=='__main__':
    print(json.dumps(check(),indent=2))
