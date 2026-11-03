#!/usr/bin/env python3
"""Read-only canonical local checkpoint. No builds, reruns, repair or promotion."""
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess
import sys

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
    index = module('dh_index', ROOT / 'bench/replay-evidence-index.py')
    load = lambda p: index.load(Path(p).read_bytes())
    state = load(D / 'starting-state.json')
    for group in ('rust_sha256', 'prior_sha256'):
        for path, digest in state[group].items():
            need(sha(ROOT / path) == digest, 'preserved source changed: ' + path)
    need(sha(ROOT / state['selected_path']) == state['selected_sha256'], 'selected executable changed')
    protocol = load(D / 'protocol.json')
    need(protocol['arms'] == ['control', 'candidate'] and protocol['engine']['blocks'] == 12, 'protocol shape')
    helper = module('dh_build', ROOT / 'bench/build-engine-arm.py')
    binaries = load(D / 'binaries.json')
    for kind in ('control', 'candidate', 'census-control', 'census-candidate', 'restored'):
        ident = load(D / f'build-{kind}.json')
        need(ident == load(D / f'build-{kind}/identity.json'), 'build identity differs')
        binary = ident['executable']
        need(sha(binary) == ident['sha256'], 'artifact changed')
        for path in INPUTS:
            suffix = path.replace('/', '_')
            snapshot = D / (('count-' + kind.removeprefix('census-')) if kind.startswith('census-') else ('control' if kind == 'restored' else kind))
            snapshot = Path(str(snapshot) + '-' + suffix)
            need(ident['source_sha256'][path] == sha(snapshot), 'build source hash mismatch')
        helper.select([load_line(index, row) for row in (D / f'build-{kind}/cargo.jsonl').read_bytes().splitlines()])
        if kind in protocol['arms']:
            need(binaries[kind] == dict(path=binary, sha256=sha(binary)), 'binary registry mismatch')
        if kind == 'restored':
            need(ident['sha256'] == binaries['control']['sha256'], 'restored build differs')
    need(binaries['control']['sha256'] == sha('/tmp/glass-i26-control-inline-test'), 'control differs from prior exact ELF')
    for path in INPUTS:
        suffix = path.replace('/', '_')
        control = (D / ('control-' + suffix)).read_bytes()
        candidate = (D / ('candidate-' + suffix)).read_bytes()
        need(control == (ROOT / path).read_bytes(), 'source not restored')
        if path != 'crates/term/src/engine.rs':
            need(control == candidate, 'non-engine source change')
        need(control == (ROOT / 'bench/results/2026-11-03-csi-outlining' / ('control-inline-' + suffix)).read_bytes(), 'control source changed')
    patch = (D / 'candidate.patch').read_text()
    need(patch.count('diff --git') == 1 and 'crates/term/src/engine.rs' in patch, 'patch scope')
    # Live source is control, so validate applying the patch against a disposable copy instead.
    import tempfile
    with tempfile.TemporaryDirectory() as tmp:
        target = Path(tmp) / 'crates/term/src/engine.rs'
        target.parent.mkdir(parents=True)
        target.write_bytes((D / 'control-crates_term_src_engine.rs').read_bytes())
        proc = subprocess.run(['git', 'apply', '--unsafe-paths', '-'], cwd=tmp, input=patch, capture_output=True, text=True)
        need(proc.returncode == 0 and target.read_bytes() == (D / 'candidate-crates_term_src_engine.rs').read_bytes(), 'candidate patch mismatch')
    for arm in protocol['arms']:
        text = (D / f'{arm}-terminal-tests.log').read_text()
        census = re.findall(r'^test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', text, re.M)
        need(census == [('ok', '383', '0', '11')], 'terminal test census')
        text = (D / f'{arm}-sweep.log').read_text()
        need('swept 12800 streams over 64 seeds: no divergence' in text and '1 passed; 0 failed;' in text, 'differential census')
    a = module('dh_analysis', D / 'analyze.py')
    decision = a.analyze(load(D / 'raw.json'))
    need(decision == load(D / 'analysis.json') == load(D / 'analysis-replay.json'), 'raw replay differs')
    need(not decision['engine_screen_cleared'] and decision['point_regression_guards_failed'] == ['unicode'], 'unexpected decision')
    c = module('dh_corruption', D / 'corruption.py').check()
    need(c == load(D / 'corruption.json') and c['rejected'] == 23, 'corruption challenges differ')
    codegen = module('dh_codegen', D / 'codegen.py').check()
    need(codegen == load(D / 'codegen.json') == load(D / 'codegen-replay.json'), 'disassembly differs')
    need(codegen['control']['apply']['normalized_sha256'] == codegen['candidate']['apply']['normalized_sha256'], 'caller normalized code changed')
    need(codegen['control']['print_utf8']['address'] == codegen['candidate']['print_utf8']['address'], 'entry address changed')
    census = module('dh_census', D / 'census-replay.py').check()
    need(census == load(D / 'decode-census-analysis.json'), 'decode census differs')
    # Exact adapter only substitutes location and historical-doc index. Original checker is frozen.
    prior = ROOT / 'bench/results/2026-11-03-csi-outlining'
    adapter = (prior / 'verify.py').read_text().replace('D = Path(__file__).resolve().parent\nROOT = D.parents[2]', "HERE = Path(__file__).resolve().parent\nROOT = HERE.parents[2]\nD = ROOT / 'bench/results/2026-11-03-csi-outlining'")
    adapter = adapter.replace("frozen = index.validate(ROOT, load(D / 'frozen-index.json'))", "frozen = index.validate(ROOT, load(HERE / 'prior-own-remapped-index.json'))")
    need(adapter == (D / 'replay-prior.py').read_text(), 'prior adapter exceeds location/index changes')
    proc = subprocess.run([sys.executable, '-B', str(D / 'replay-prior.py')], cwd=ROOT, capture_output=True, text=True, timeout=120)
    need(proc.returncode == 0, 'prior checkpoint: ' + proc.stderr)
    need(load_line(index, proc.stdout) == load(D / 'prior-checkpoint.json'), 'prior result changed')
    frozen = index.validate(ROOT, load(D / 'frozen-index.json'))
    return dict(schema='glass.decoded-handoff-checkpoint/v1', runtime_promotion=False, engine_screen_cleared=False, pairs=12, sessions=24,
                cpu_ratios={n: s['median_cpu_ratio'] for n, s in decision['summary'].items()}, failed_point_guards=['unicode'],
                terminal_tests_per_arm=383, differential_streams_per_arm=12800, existing_python_tests_via_prior_checkpoint=65,
                corruption_cases_rejected=23, unicode_decode_attempt_ratio=census['unicode_attempt_ratio'],
                unicode_removed_decode_attempts=census['unicode_removed_attempts'], instrumented_rates_used=False,
                print_utf8_bytes={a: codegen[a]['print_utf8']['bytes'] for a in protocol['arms']}, same_print_utf8_entry_address=True,
                unchanged_runtime_rust_sources=len(state['rust_sha256']), unchanged_prior_result_report_files=len(state['prior_sha256']),
                selected_binary_sha256=state['selected_sha256'], restored_build_byte_identical=True, prior_checkpoint_replayed=True,
                frozen_file_references=frozen['file_references'], note='Local evidence replay, not unique causal attribution, PTY/Ghostty comparison or championship acceptance.')


def load_line(index, text):
    return index.load(text)


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
