#!/usr/bin/env python3
"""Read-only exact-source, binary, correctness and raw-result checkpoint."""
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
INPUTS = ['crates/term/src/engine.rs', 'crates/term/src/speed.rs',
          'crates/vte/src/lib.rs', 'crates/vte/src/ansi.rs']


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def need(ok, message):
    if not ok:
        raise ValueError(message)


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    obj = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(obj)
    return obj


def check():
    index = module('outline_index', ROOT / 'bench/replay-evidence-index.py')
    load = lambda p: index.load(Path(p).read_bytes())
    state = load(D / 'starting-state.json')
    for group in ('rust_sha256', 'prior_sha256'):
        for path, digest in state[group].items():
            need(sha(ROOT / path) == digest, 'preserved source changed: ' + path)
    need(sha(ROOT / state['selected_path']) == state['selected_sha256'], 'selected executable changed')
    prospective = load(D / 'prospective-inputs.json')
    audit = load(D / 'input-audit.json')
    output = str(D.relative_to(ROOT) / 'build-control.json')
    need(audit['original_index_sha256'] == sha(D / 'prospective-inputs.json'), 'original index changed')
    need(set(audit['output_only_exceptions']) == {output}, 'audit exception scope')
    need(prospective['sha256'][output] == hashlib.sha256(b'').hexdigest(), 'original output was not empty')
    need(audit['output_only_exceptions'][output] == dict(indexed_sha256=prospective['sha256'][output], current_sha256=sha(ROOT / output)), 'output audit mismatch')
    actual = {p: h for p, h in prospective['sha256'].items() if p != output}
    need(audit['actual_inputs_unchanged'] == actual and audit['included_actual_inputs'] == 18, 'actual input audit mismatch')
    for path, digest in actual.items():
        need(sha(ROOT / path) == digest, 'prospective input changed: ' + path)
    protocol = load(D / 'protocol.json')
    need(protocol['schema'] == 'glass.multibyte-outline-protocol/v1', 'protocol schema')
    need(protocol['arms'] == ['control', 'candidate'] and protocol['engine']['blocks'] == 12, 'protocol shape')
    helper = module('outline_build', ROOT / 'bench/build-engine-arm.py')
    binaries = load(D / 'binaries.json')
    for arm in protocol['arms']:
        ident = load(D / f'build-{arm}.json')
        need(ident == load(D / f'build-{arm}/identity.json'), 'build identity mismatch')
        binary = ident['executable']
        need(sha(binary) == ident['sha256'], 'timing artifact changed')
        need(binaries[arm] == dict(path=binary, sha256=sha(binary)), 'registry mismatch')
        for path in INPUTS:
            snapshot = D / (arm + '-' + path.replace('/', '_'))
            need(ident['source_sha256'][path] == sha(snapshot), 'build source mismatch')
        artifact = helper.select([index.load(row) for row in (D / f'build-{arm}/cargo.jsonl').read_bytes().splitlines()])
        need(artifact.name.startswith('glass-'), 'unexpected compiler artifact')
        census = re.findall(r'^test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;',
                            (D / f'{arm}-terminal-tests.log').read_text(), re.M)
        need(census == [('ok', '383', '0', '11')], 'terminal test census')
        text = (D / f'{arm}-sweep.log').read_text()
        need('swept 12800 streams over 64 seeds: no divergence' in text and '1 passed; 0 failed;' in text, 'differential census')
    need(binaries['control']['sha256'] == sha('/tmp/glass-i28-control-test'), 'control differs from prior exact ELF')
    for path in INPUTS:
        control = (D / ('control-' + path.replace('/', '_'))).read_bytes()
        need(control == (ROOT / path).read_bytes(), 'source not restored')
        if path != INPUTS[0]:
            need(control == (D / ('candidate-' + path.replace('/', '_'))).read_bytes(), 'non-engine source changed')
    control = (D / 'control-crates_term_src_engine.rs').read_text()
    old = '    let next = |k: usize, low: u8, high: u8| bytes.get(at + k).copied().filter(|b| (low..=high).contains(b));'
    new = '''    utf8_multibyte_at(bytes, at, lead)
}

/// Shared multibyte validation; keep the ASCII fast return in `utf8_at`.
#[inline(never)]
fn utf8_multibyte_at(bytes: &[u8], at: usize, lead: u8) -> Option<(char, usize)> {
    let next = |k: usize, low: u8, high: u8| bytes.get(at + k).copied().filter(|b| (low..=high).contains(b));'''
    need(control.count(old) == 1, 'control anchor')
    need(control.replace(old, new) == (D / 'candidate-crates_term_src_engine.rs').read_text(), 'intervention exceeds exact extraction')
    patch = (D / 'candidate.patch').read_text()
    need(patch.count('--- a/') == 1 and patch.count('+++ b/') == 1, 'patch scope')
    with tempfile.TemporaryDirectory() as tmp:
        target = Path(tmp) / INPUTS[0]
        target.parent.mkdir(parents=True)
        target.write_text(control)
        proc = subprocess.run(['git', 'apply', '--whitespace=error', '-'], cwd=tmp, input=patch, capture_output=True, text=True)
        need(proc.returncode == 0 and target.read_bytes() == (D / 'candidate-crates_term_src_engine.rs').read_bytes(), 'exact patch mismatch')
    analysis = module('outline_analysis', D / 'analyze.py').analyze(load(D / 'raw.json'))
    need(analysis == load(D / 'analysis.json'), 'raw replay differs')
    corruption = module('outline_corruption', D / 'corruption.py').check()
    need(corruption == load(D / 'corruption.json') and corruption['rejected'] == 23, 'corruption replay differs')
    codegen = module('outline_codegen', D / 'codegen.py').check()
    need(codegen == load(D / 'codegen.json'), 'codegen replay differs')
    prior = ROOT / 'bench/results/2026-11-03-scalar-domain/verify-current.py'
    proc = subprocess.run([sys.executable, '-B', str(prior)], cwd=ROOT, capture_output=True, text=True, timeout=120)
    need(proc.returncode == 0, 'prior checkpoint: ' + proc.stderr)
    need(index.load(proc.stdout) == load(D / 'prior-checkpoint.json'), 'prior checkpoint changed')
    frozen = index.validate(ROOT, load(D / 'frozen-index.json'))
    return dict(schema='glass.multibyte-outline-checkpoint/v1', runtime_promotion=False,
                engine_screen_cleared=analysis['engine_screen_cleared'], pairs=12, sessions=24,
                cpu_ratios={n: s['median_cpu_ratio'] for n, s in analysis['summary'].items()},
                failed_point_guards=analysis['point_regression_guards_failed'],
                terminal_tests_per_arm=383, differential_streams_per_arm=12800,
                corruption_cases_rejected=corruption['rejected'],
                print_utf8_bytes={a: codegen[a]['print_utf8']['bytes'] for a in protocol['arms']},
                multibyte_helper_bytes=codegen['candidate']['utf8_multibyte_at']['bytes'],
                unchanged_runtime_rust_sources=len(state['rust_sha256']),
                unchanged_prior_result_report_files=len(state['prior_sha256']),
                selected_binary_sha256=state['selected_sha256'],
                prior_checkpoint_replayed_without_adapter=True,
                frozen_file_references=frozen['file_references'],
                note='Local evidence replay, not dynamic causal attribution, PTY/Ghostty comparison or championship acceptance.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
