#!/usr/bin/env python3
"""Read-only local checkpoint: exact sources, binary identities and raw replay."""
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
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    obj = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(obj)
    return obj


def need(ok, message):
    if not ok:
        raise ValueError(message)


def check():
    index = module('sd_index', ROOT / 'bench/replay-evidence-index.py')
    load = lambda p: index.load(Path(p).read_bytes())
    state = load(D / 'starting-state.json')
    for group in ('rust_sha256', 'prior_sha256'):
        for path, digest in state[group].items():
            need(sha(ROOT / path) == digest, 'preserved source changed: ' + path)
    need(sha(ROOT / state['selected_path']) == state['selected_sha256'], 'selected binary changed')
    protocol = load(D / 'protocol.json')
    need(protocol['arms'] == ['control', 'candidate'] and protocol['engine']['blocks'] == 12, 'protocol shape')
    note = load(D / 'protocol-clarification.json')
    need(note['protocol_sha256'] == sha(D / 'protocol.json'), 'clarification hash')
    need('minimum decoded scalar' in protocol['intervention'], 'intervention')
    helper = module('sd_build', ROOT / 'bench/build-engine-arm.py')
    binaries = load(D / 'binaries.json')
    for kind in ('control', 'candidate', 'restored'):
        ident = load(D / f'build-{kind}.json')
        need(ident == load(D / f'build-{kind}/identity.json'), 'build identity mismatch')
        binary = ident['executable']
        need(sha(binary) == ident['sha256'], 'artifact changed')
        for path in INPUTS:
            snapshot = D / (('control' if kind == 'restored' else kind) + '-' + path.replace('/', '_'))
            need(ident['source_sha256'][path] == sha(snapshot), 'build source mismatch')
        helper.select([index.load(row) for row in (D / f'build-{kind}/cargo.jsonl').read_bytes().splitlines()])
        if kind in protocol['arms']:
            need(binaries[kind] == dict(path=binary, sha256=sha(binary)), 'registry mismatch')
        else:
            need(ident['sha256'] == binaries['control']['sha256'], 'restored build differs')
    need(binaries['control']['sha256'] == sha('/tmp/glass-i27-control-test'), 'control differs from prior')
    for path in INPUTS:
        suffix = path.replace('/', '_')
        control = (D / ('control-' + suffix)).read_bytes()
        candidate = (D / ('candidate-' + suffix)).read_bytes()
        need(control == (ROOT / path).read_bytes(), 'source not restored')
        if path != 'crates/term/src/engine.rs':
            need(control == candidate, 'non-engine source changed')
    patch = (D / 'candidate.patch').read_text()
    need(patch.count('--- a/') == 1 and patch.count('+++ b/') == 1, 'patch scope')
    with tempfile.TemporaryDirectory() as tmp:
        target = Path(tmp) / 'crates/term/src/engine.rs'
        target.parent.mkdir(parents=True)
        target.write_bytes((D / 'control-crates_term_src_engine.rs').read_bytes())
        proc = subprocess.run(['git', 'apply', '-'], cwd=tmp, input=patch, capture_output=True, text=True)
        need(proc.returncode == 0 and target.read_bytes() == (D / 'candidate-crates_term_src_engine.rs').read_bytes(), 'patch mismatch')
    for arm in protocol['arms']:
        text = (D / f'{arm}-terminal-tests.log').read_text()
        census = re.findall(r'^test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', text, re.M)
        need(census == [('ok', '383', '0', '11')], 'terminal test census')
        text = (D / f'{arm}-sweep.log').read_text()
        need('swept 12800 streams over 64 seeds: no divergence' in text and '1 passed; 0 failed;' in text, 'differential census')
    analysis = module('sd_analysis', D / 'analyze.py').analyze(load(D / 'raw.json'))
    need(analysis == load(D / 'analysis.json') == load(D / 'analysis-replay.json'), 'raw replay differs')
    corruption = module('sd_corruption', D / 'corruption.py').check()
    need(corruption == load(D / 'corruption.json') and corruption['rejected'] == 23, 'corruption differs')
    codegen = module('sd_codegen', D / 'codegen.py').check()
    need(codegen == load(D / 'codegen.json') == load(D / 'codegen-replay.json'), 'codegen replay differs')
    prior = ROOT / 'bench/results/2026-11-03-decoded-handoff'
    adapter = (prior / 'verify.py').read_text().replace('D = Path(__file__).resolve().parent\nROOT = D.parents[2]', "HERE = Path(__file__).resolve().parent\nROOT = HERE.parents[2]\nD = ROOT / 'bench/results/2026-11-03-decoded-handoff'")
    adapter = adapter.replace("\n    frozen = index.validate(ROOT, load(D / 'frozen-index.json'))\n", "\n    frozen = index.validate(ROOT, load(HERE / 'prior-own-remapped-index.json'))\n")
    need(adapter == (D / 'replay-prior-corrected.py').read_text(), 'prior adapter exceeds location/index changes')
    proc = subprocess.run([sys.executable, '-B', str(D / 'replay-prior-corrected.py')], cwd=ROOT, capture_output=True, text=True, timeout=120)
    need(proc.returncode == 0, 'prior checkpoint: ' + proc.stderr)
    need(index.load(proc.stdout) == load(D / 'prior-checkpoint.json'), 'prior result changed')
    frozen = index.validate(ROOT, load(D / 'final-frozen-index.json'))
    return dict(schema='glass.scalar-domain-checkpoint/v1', runtime_promotion=False,
                engine_screen_cleared=analysis['engine_screen_cleared'], pairs=12, sessions=24,
                cpu_ratios={n: s['median_cpu_ratio'] for n, s in analysis['summary'].items()},
                failed_point_guards=analysis['point_regression_guards_failed'],
                terminal_tests_per_arm=383, differential_streams_per_arm=12800,
                corruption_cases_rejected=corruption['rejected'],
                print_utf8_bytes={a: codegen[a]['print_utf8']['bytes'] for a in protocol['arms']},
                unchanged_runtime_rust_sources=len(state['rust_sha256']), unchanged_prior_result_report_files=len(state['prior_sha256']),
                selected_binary_sha256=state['selected_sha256'], restored_build_byte_identical=True,
                prior_checkpoint_replayed=True, frozen_file_references=frozen['file_references'],
                note='Local evidence replay, not dynamic causal attribution, PTY/Ghostty comparison or championship acceptance.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
