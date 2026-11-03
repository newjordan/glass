#!/usr/bin/env python3
"""Read-only local mark screen checkpoint; not campaign acceptance."""
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess
import sys
import tempfile

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
INPUTS = ['crates/term/src/engine.rs', 'crates/term/src/speed.rs', 'crates/vte/src/lib.rs', 'crates/vte/src/ansi.rs']


def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def need(ok, message):
    if not ok:
        raise ValueError(message)


def module(name, p):
    spec = importlib.util.spec_from_file_location(name, p)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def check():
    index = module('mark_index', ROOT / 'bench/replay-evidence-index.py')
    load = lambda p: index.load(Path(p).read_bytes())
    state = load(D / 'starting-state.json')
    for group in ['rust_sha256', 'prior_sha256']:
        for path, digest in state[group].items():
            need(sha(ROOT / path) == digest, 'preserved input changed: ' + path)
    need(sha(ROOT / state['selected_path']) == state['selected_sha256'], 'selected executable changed')
    inputs = load(D / 'inputs-sha256.json')
    for path, digest in inputs['sha256'].items():
        need(sha(ROOT / path) == digest, 'input snapshot changed: ' + path)
    protocol = load(D / 'protocol.json')
    need(protocol['schema'] == 'glass.local-mark-lane-protocol/v1', 'protocol schema')
    need(protocol['engine']['blocks'] == 12 and protocol['arms'] == ['control', 'candidate'], 'protocol shape')
    builds = module('mark_build', ROOT / 'bench/build-engine-arm.py')
    binaries = load(D / 'binaries.json')
    for arm in ['control', 'candidate', 'census']:
        ident = load(D / f'build-{arm}.json')
        need(ident == load(D / f'build-{arm}/identity.json'), 'identity differs')
        need(sha(ident['executable']) == ident['sha256'], 'executable differs')
        if arm != 'census':
            need(binaries[arm] == dict(path=ident['executable'], sha256=ident['sha256']), 'binary registry')
        for path in INPUTS:
            prefix = 'instrumented' if arm == 'census' and path in INPUTS[:2] else 'candidate' if arm == 'census' else arm
            snapshot = D / (prefix + '-' + path.replace('/', '_'))
            need(ident['source_sha256'][path] == sha(snapshot), 'build source mismatch: ' + path)
        rows = [index.load(row) for row in (D / f'build-{arm}/cargo.jsonl').read_bytes().splitlines()]
        builds.select(rows)
        if arm == 'census':
            continue
        text = (D / f'{arm}-terminal-tests.log').read_text()
        need(re.findall(r'^test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', text, re.M) == [('ok', '384', '0', '11')], 'terminal census')
        text = (D / f'{arm}-mark-test.log').read_text()
        need('local written marks: 1728 scenarios matched' in text and '1 passed; 0 failed;' in text, 'mark scenarios')
        text = (D / f'{arm}-sweep.log').read_text()
        need('swept 12800 streams over 64 seeds: no divergence' in text and '1 passed; 0 failed;' in text, 'differential census')
    for path in INPUTS:
        control = (D / ('control-' + path.replace('/', '_'))).read_bytes()
        if path != INPUTS[1]:
            need(control == (ROOT / path).read_bytes(), 'control runtime differs')
        if path != INPUTS[0]:
            need(control == (D / ('candidate-' + path.replace('/', '_'))).read_bytes(), 'non-engine arm difference')
    control = (D / 'control-crates_term_src_engine.rs').read_bytes()
    candidate = (D / 'candidate-crates_term_src_engine.rs').read_bytes()
    with tempfile.TemporaryDirectory() as tmp:
        path = Path(tmp) / INPUTS[0]
        path.parent.mkdir(parents=True)
        path.write_bytes(control)
        proc = subprocess.run(['git', 'apply', '--whitespace=error', '-'], cwd=tmp, input=(D / 'candidate.patch').read_bytes(), capture_output=True)
        need(proc.returncode == 0 and path.read_bytes() == candidate, 'patch mismatch')
    analysis = module('mark_analysis', D / 'analyze.py').analyze(load(D / 'raw.json'))
    need(analysis == load(D / 'analysis.json') and not analysis['engine_screen_cleared'], 'analysis drift')
    corruption = module('mark_corruption', D / 'corruption.py').check()
    need(corruption == load(D / 'corruption.json') and corruption['rejected'] == 23, 'corruption drift')
    dispersion = module('mark_dispersion', D / 'dispersion.py').check()
    need(dispersion == load(D / 'dispersion.json'), 'dispersion drift')
    codegen = module('mark_codegen', D / 'codegen.py').check()
    need(codegen == load(D / 'codegen.json'), 'codegen drift')
    census = (D / 'census.log').read_text()
    values = re.findall(r'LOCAL_MARK_CENSUS bytes=(\d+) read=4095 expected=(\d+) local=(\d+) fallback=(\d+)', census)
    need(len(values) == 1 and '1 passed; 0 failed;' in census, 'census log')
    size, expected, local, fallback = map(int, values[0])
    need(local > 0 and fallback > 0 and local + fallback == expected, 'census accounting')
    prior = subprocess.run([sys.executable, '-B', str(ROOT / 'bench/results/2026-11-03-campaign-audit-30/verify.py')], cwd=ROOT, capture_output=True, text=True, timeout=120)
    need(prior.returncode == 0, 'prior checkpoint: ' + prior.stderr)
    need(index.load(prior.stdout) == load(D / 'prior-checkpoint.json'), 'prior checkpoint drift')
    frozen = index.validate(ROOT, load(D / 'frozen-index.json'))
    return dict(schema='glass.local-mark-lane-checkpoint/v1', status='reported', runtime_promotion=False,
                championship_established=False, engine_screen_cleared=False, pairs=12, sessions=24,
                cpu_ratios={k: v['median_cpu_ratio'] for k, v in analysis['summary'].items()},
                terminal_tests_per_arm=384, differential_streams_per_arm=12800, mark_scenarios_per_arm=1728,
                census=dict(bytes=size, marks=expected, local=local, fallback=fallback),
                print_utf8={arm: {key: codegen[arm]['print_utf8'][key] for key in ['address', 'bytes', 'instructions']} for arm in ['control', 'candidate']},
                unchanged_rust_sources=len(state['rust_sha256']), unchanged_prior_evidence_files=len(state['prior_sha256']),
                selected_sha256=state['selected_sha256'], frozen_file_references=frozen['file_references'],
                note='Local evidence integrity and exact-source replay, not fresh timing, causal attribution, Ghostty comparison or championship acceptance.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2, sort_keys=True))
