#!/usr/bin/env python3
"""Read-only local checkpoint. No compilation/timing, model call, or championship inference."""
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

D = Path(__file__).resolve().parent
ROOT = D.parents[2]


def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def load(name):
    spec = importlib.util.spec_from_file_location('i32_' + name, D / (name + '.py'))
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


def main():
    state = json.loads((D / 'starting-state.json').read_text())
    assert sha(ROOT / state['selected_path']) == state['selected_sha256'], 'selected executable changed'
    for p, expected in state['prior_sha256'].items():
        assert sha(ROOT / p) == expected, ('prior evidence changed', p)
    for p, expected in state['shared_docs_sha256'].items():
        assert sha(ROOT / p) == expected, ('shared document changed', p)
    for p, expected in state['rust_sha256'].items():
        if p == 'crates/term/src/engine.rs':
            assert (ROOT / p).read_bytes() == (D / 'control-crates_term_src_engine.rs').read_bytes(), 'retained oracle source changed'
        else:
            assert sha(ROOT / p) == expected, ('other Rust source changed', p)
    for path in ['crates/term/src/engine.rs', 'crates/term/src/speed.rs', 'crates/vte/src/lib.rs', 'crates/vte/src/ansi.rs', 'crates/alacritty-terminal/src/term/mod.rs']:
        assert sha(D / ('original-' + path.replace('/', '_'))) == state['rust_sha256'][path], ('original source baseline', path)
    # Apply the explicit test patch to the frozen original via stdin in a temporary directory.
    # Do not mutate the workspace or use the live VCS HEAD to reconstruct an arm.
    import tempfile
    with tempfile.TemporaryDirectory(prefix='glass-i32-source-') as tmp:
        p = Path(tmp) / 'crates/term/src/engine.rs'
        p.parent.mkdir(parents=True)
        p.write_bytes((D / 'original-crates_term_src_engine.rs').read_bytes())
        r = subprocess.run(['patch', '-p1', '--batch', '--forward', '-i', str(D / 'oracle.patch')], cwd=tmp, capture_output=True, text=True)
        assert r.returncode == 0, r.stdout + r.stderr
        assert p.read_bytes() == (D / 'control-crates_term_src_engine.rs').read_bytes()
    for arm, patchname in [('candidate', 'candidate-runtime.patch'), ('mutant', 'mutant.patch')]:
        with tempfile.TemporaryDirectory(prefix='glass-i32-runtime-') as tmp:
            path = Path(tmp) / 'crates/alacritty-terminal/src/term/mod.rs'
            path.parent.mkdir(parents=True)
            path.write_bytes((D / 'original-crates_alacritty-terminal_src_term_mod.rs').read_bytes())
            r = subprocess.run(['patch', '-p1', '--batch', '--forward', '-i', str(D / patchname)], cwd=tmp, capture_output=True, text=True)
            assert r.returncode == 0, r.stdout + r.stderr
            assert path.read_bytes() == (D / (arm + '-crates_alacritty-terminal_src_term_mod.rs')).read_bytes()
    assert (D / 'candidate-crates_term_src_engine.rs').read_bytes() == (D / 'control-crates_term_src_engine.rs').read_bytes() == (D / 'mutant-crates_term_src_engine.rs').read_bytes(), 'arms have different test sources'
    for arm, receipt in [('control', 'build-control-final'), ('candidate', 'build-candidate-final')]:
        build = json.loads((D / receipt / 'identity.json').read_text())
        builder = load('build')
        cargo = [json.loads(line) for line in (D / receipt / 'cargo.jsonl').read_text().splitlines()]
        builder.select(cargo)
        binary = json.loads((D / 'binaries.json').read_text())[arm]
        assert build['executable'] == binary['path'] and build['sha256'] == binary['sha256'] == sha(binary['path'])
        assert 'crates/alacritty-terminal/src/term/mod.rs' in build['source_sha256']
        for path, digest in build['source_sha256'].items():
            assert sha(D / (arm + '-' + path.replace('/', '_'))) == digest, (arm, path)
        c = json.loads((D / f'{arm}-correctness.json').read_text())
        assert c['sha256'] == binary['sha256']
        for row in c['checks']:
            assert row['exit_code'] == 0 and sha(D / row['log']) == row['sha256']
            text = (D / row['log']).read_text()
            assert 'test result: ok.' in text and '0 failed;' in text
        text = (D / f'{arm}-terminal-tests.log').read_text()
        assert re.search(r'test result: ok\. 384 passed; 0 failed;', text), arm
        assert 'swept 12800 streams over 64 seeds: no divergence' in (D / f'{arm}-sweep.log').read_text()
    a = load('analyze')
    analysis = a.analyze(a.load(D / 'raw.json'))
    assert analysis == a.load(D / 'analysis.json'), 'analysis replay differs'
    corruption = load('corruption').check()
    assert corruption == a.load(D / 'corruption.json')
    codegen = load('codegen').check()
    assert codegen == a.load(D / 'codegen.json')
    mutation = load('mutation-check').verify()
    assert mutation == a.load(D / 'mutation-result.json'), 'mutation replay differs'
    result = dict(schema='glass.pen-dispatch-checkpoint/v1', status='reported', pairs=analysis['blocks'], sessions=analysis['sessions'], cpu_ratios={n: v['median_cpu_ratio'] for n, v in analysis['summary'].items()}, engine_screen_cleared=analysis['engine_screen_cleared'], terminal_tests_per_arm=384, differential_streams_per_arm=12800, oracle_cases_per_arm=int(re.search(r'oracle: (\d+) cases matched', (D / 'control-oracle.log').read_text())[1]), rejected_corruptions=corruption['rejected'], shared_handler_mutation=mutation, static_codegen=codegen, unchanged_prior_evidence_files=len(state['prior_sha256']), unchanged_other_rust_sources=len(state['rust_sha256'])-1, retained_test_source='crates/term/src/engine.rs', selected_sha256=state['selected_sha256'], runtime_promotion=False, championship_established=False, note='Local exact-source/evidence replay only, not fresh timing, causal attribution, Ghostty comparison, independent audit or acceptance.')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
