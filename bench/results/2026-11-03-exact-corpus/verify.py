#!/usr/bin/env python3
"""Read-only exact-source checkpoint; no compilation, timing, or acceptance."""
import hashlib
import importlib.util
import json
import lzma
from pathlib import Path
import re
import subprocess
import tempfile

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()

def load(name):
    spec = importlib.util.spec_from_file_location('i33_'+name,D/(name+'.py'))
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m

def main():
    state = json.loads((D/'starting-state.json').read_text())
    assert sha(ROOT/state['selected_path']) == state['selected_sha256'], 'selected executable changed'
    for paths in [state['prior_sha256'],state['shared_docs_sha256']]:
        for p,h in paths.items():
            assert sha(ROOT/p)==h,('earlier evidence/document changed',p)
    for p,h in state['rust_sha256'].items():
        if p!='crates/term/src/speed.rs':
            assert sha(ROOT/p)==h,('runtime/test Rust source changed',p)
    assert sha(D/'original-speed.rs')==state['rust_sha256']['crates/term/src/speed.rs']
    with tempfile.TemporaryDirectory(prefix='glass-i33-source-') as tmp:
        dst=Path(tmp)/'crates/term/src/speed.rs'
        dst.parent.mkdir(parents=True)
        dst.write_bytes((D/'original-speed.rs').read_bytes())
        proc=subprocess.run(['patch','-p1','--batch','--forward','-i',str(D/'test-only.patch')],cwd=tmp,capture_output=True,text=True)
        assert proc.returncode==0,proc.stdout+proc.stderr
        assert dst.read_bytes()==(ROOT/'crates/term/src/speed.rs').read_bytes()
    main_rs=(ROOT/'crates/term/src/main.rs').read_text()
    assert '#[cfg(test)]\nmod speed;' in main_rs
    b=json.loads((D/'binary.json').read_text())
    for p,h in b['source_sha256'].items():
        assert sha(ROOT/p)==h,('diagnostic source changed',p)
    cargo=[json.loads(l) for l in (D/'build.jsonl').read_text().splitlines() if l.startswith('{')]
    exes=[r for r in cargo if r.get('reason')=='compiler-artifact' and r.get('executable') and r.get('profile',{}).get('test')]
    assert len(exes)==1 and exes[0]['executable']==b['cargo_artifact']
    assert exes[0]['target']['name']=='glass' and exes[0]['target']['kind']==['bin'] and exes[0]['profile']['opt_level']=='3' and exes[0]['fresh'] is False
    assert cargo[-1]==dict(reason='build-finished',success=True) and b['build_exit']==0
    archive=json.loads((D/'archive.json').read_text())
    assert archive['format']=='xz' and len(archive['files'])==13
    expected={'diagnostic-test-elf.xz'}|{f'{d}/{n}.bin.xz' for d in ['corpus','generated'] for n in json.loads((D/'protocol.json').read_text())['workloads']}
    assert {r['path'] for r in archive['files']}==expected
    for r in archive['files']:
        packed=(D/r['path']).read_bytes()
        assert hashlib.sha256(packed).hexdigest()==r['sha256']
        raw=lzma.decompress(packed)
        assert len(raw)==r['uncompressed_bytes'] and hashlib.sha256(raw).hexdigest()==r['uncompressed_sha256']
        if r['path']=='diagnostic-test-elf.xz':
            assert r['uncompressed_sha256']==b['sha256']
    correct=json.loads((D/'correctness.json').read_text())
    assert correct['binary']==b and len(correct['checks'])==3
    for r in correct['checks']:
        assert r['exit']==0 and sha(D/r['log'])==r['sha256']
        text=(D/r['log']).read_text()
        assert 'test result: ok.' in text and '0 failed;' in text
    assert 'test result: ok. 385 passed; 0 failed; 12 ignored;' in (D/'terminal-tests.log').read_text()
    assert 'swept 12800 streams over 64 seeds: no divergence' in (D/'sweep.log').read_text()
    for name in ['existing-parser','corpus-loader']:
        assert '1 passed; 0 failed;' in (D/(name+'.log')).read_text()
    py=(D/'python-tests.log').read_text()
    assert re.search(r'Ran 72 tests in [\d.]+s\n\nOK\s*$',py)
    a=load('analyze')
    analysis=a.analyze(a.load(D/'raw.json'))
    assert analysis==a.load(D/'analysis.json')==a.load(D/'analysis-replay.json')
    corruption=load('corruption').check()
    assert corruption==a.load(D/'corruption.json')==a.load(D/'corruption-replay.json')
    independent=subprocess.run(['python3','-B',str(D/'verify-export.py')],capture_output=True,text=True,timeout=120)
    assert independent.returncode==0,independent.stderr
    original=a.load(D/'independent-export.json')
    assert json.loads(independent.stdout)==original==a.load(D/'independent-export-replay.json')
    manifest=a.load(D/'corpus/manifest.json')
    assert manifest['source']['sha256']==sha(ROOT/'bench/tput.py')==original['source_sha256']
    generated=a.load(D/'generated/manifest.json')
    assert generated['source_sha256']==sha(ROOT/'crates/term/src/speed.rs')
    equal=[n for n in manifest['workloads'] if manifest['workloads'][n]==generated['workloads'][n]]
    assert equal==['tui_frames']
    result=dict(schema='glass.exact-corpus-checkpoint/v1',status='reported',pairs=analysis['pairs'],sessions=analysis['sessions'],cpu_ratios={n:v['median_cpu_ratio'] for n,v in analysis['summary'].items()},all_six_export_payloads_byte_equal=True,generated_payloads_identical=equal,terminal_tests=385,differential_streams=12800,python_tests=72,rejected_corruptions=corruption['rejected'],unchanged_prior_evidence_files=len(state['prior_sha256']),unchanged_other_rust_sources=len(state['rust_sha256'])-1,selected_sha256=state['selected_sha256'],retained_test_source='crates/term/src/speed.rs',runtime_promotion=False,championship_established=False,note='Local archived-source/evidence replay; no new timing, independent audit, terminal/Ghostty comparison, causal inference or acceptance.')
    print(json.dumps(result,indent=2))

if __name__=='__main__':
    main()
