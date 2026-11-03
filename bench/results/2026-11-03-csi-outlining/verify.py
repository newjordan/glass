#!/usr/bin/env python3
"""Read-only local checkpoint: no builds, timing reruns, repair or promotion."""
import importlib.util
import json
from pathlib import Path
import re
import subprocess
import sys
import hashlib

D = Path(__file__).resolve().parent
ROOT = D.parents[2]


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    obj = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(obj)
    return obj


def need(ok, message):
    if not ok:
        raise ValueError(message)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def census(text, passed, ignored):
    rows = re.findall(r'^test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', text, re.M)
    need(rows == [('ok', str(passed), '0', str(ignored))], 'wrong test census')


def check():
    index = module('csi_index', ROOT / 'bench/replay-evidence-index.py')
    load = lambda p: index.load(Path(p).read_bytes())
    state = load(D / 'starting-state.json')
    for group in ('rust_sha256', 'prior_sha256'):
        for p, digest in state[group].items():
            need(sha(ROOT / p) == digest, 'changed preserved file: ' + p)
    need(sha(ROOT / state['selected_path']) == state['selected_sha256'], 'selected terminal changed')
    protocol = load(D / 'protocol.json')
    need(protocol['engine']['blocks'] == 12 and len(protocol['arms']) == 4, 'wrong protocol dimensions')
    helper = module('csi_build', ROOT / 'bench/build-engine-arm.py')
    binaries = load(D / 'binaries.json')
    paths = ['crates/term/src/engine.rs', 'crates/term/src/speed.rs', 'crates/vte/src/lib.rs', 'crates/vte/src/ansi.rs']
    prior_dir = ROOT / 'bench/results/2026-11-03-authority-handoff'
    for parser in ('control', 'authority'):
        for p in paths:
            suffix = p.replace('/', '_')
            inline = (D / (parser + '-inline-' + suffix)).read_text()
            outlined = (D / (parser + '-outlined-' + suffix)).read_text()
            old = prior_dir / (('control' if parser == 'control' else 'candidate') + '-' + suffix)
            need(inline == old.read_text(), 'inline source not exact retained parser arm')
            if p == 'crates/term/src/engine.rs':
                needle = '#[inline]\nfn simple(rest: &[u8]) -> Option<(usize, Simple)> {'
                need(inline.count(needle) == 1, 'ambiguous scanner attribute')
                need(outlined == inline.replace(needle, needle.replace('#[inline]', '#[inline(never)]')), 'outlining scope exceeded')
            else:
                need(inline == outlined, 'non-engine outline source changed')
    for kind in [*protocol['arms'], 'restored']:
        identity = load(D / f'build-{kind}.json')
        need(identity == load(D / f'build-{kind}/identity.json'), 'build identity copies differ')
        binary = f'/tmp/glass-i26-{kind}-test'
        need(identity['executable'] == binary and identity['sha256'] == sha(binary), 'build binary changed')
        need(set(identity['source_sha256']) == set(paths) == set(helper.INPUTS), 'wrong build input set')
        for p in paths:
            snapshot = D / (('original' if kind == 'restored' else kind) + '-' + p.replace('/', '_'))
            need(identity['source_sha256'][p] == sha(snapshot), 'build source snapshot mismatch')
            if kind == 'restored':
                need(sha(ROOT / p) == sha(snapshot), 'restored source mismatch')
        rows = [index.load(line) for line in (D / f'build-{kind}/cargo.jsonl').read_bytes().splitlines()]
        helper.select(rows)
        if kind != 'restored':
            need(binaries[kind] == dict(path=binary, sha256=sha(binary)), 'binary registry mismatch')
    need(sha('/tmp/glass-i26-restored-test') == binaries['control-inline']['sha256'], 'restored artifact differs')
    for parser, old in [('control', 'control'), ('authority', 'candidate')]:
        need(binaries[parser + '-inline']['sha256'] == sha(f'/tmp/glass-i24-{old}-test'), 'original arm is not byte identical')
    analysis_module = module('csi_analysis', D / 'analyze.py')
    decision = analysis_module.analyze(load(D / 'raw.json'))
    need(decision == load(D / 'analysis.json'), 'saved analysis differs from raw replay')
    need(not decision['engine_screen_cleared'] and not decision['runtime_promotion'], 'unexpected promotion')
    need(decision['point_regression_guards_failed'] == ['unicode'], 'different guard failure')
    need(decision['cleared_targets'] == ['ascii', 'scroll_region'], 'different target result')
    codegen = module('csi_codegen', D / 'codegen.py').check()
    need(codegen == load(D / 'codegen.json'), 'codegen replay differs')
    print_codegen = module('csi_print', D / 'print-codegen.py').check()
    need(print_codegen == load(D / 'print-codegen.json'), 'print codegen replay differs')
    for kind in ['control-outlined', 'authority-outlined', 'restored']:
        census((D / f'{kind}-terminal-tests.log').read_text(), 383, 11)
        text = (D / f'{kind}-sweep.log').read_text()
        census(text, 1, 0)
        need('swept 12800 streams over 64 seeds: no divergence' in text, 'missing stream census')
    for name, count in [('python-tests.log', 65), ('python-engine-replay.log', 5)]:
        text = (D / name).read_text()
        need(f'Ran {count} tests' in text and text.rstrip().endswith('OK'), 'saved Python suite census mismatch')
    corruption = module('csi_corruption', D / 'corruption.py').check()
    need(corruption == load(D / 'corruption.json') and corruption['rejected'] == 23, 'corruption replay differs')
    diagnostic = load(D / 'counter-diagnostic.json')
    need(len(diagnostic['sessions']) == 4, 'wrong diagnostic census')
    expected = ['control-inline', 'authority-inline', 'control-outlined', 'authority-outlined']
    for arm, row in zip(expected, diagnostic['sessions']):
        need(row['arm'] == arm and row['exit'] == 0, 'wrong diagnostic arm/exit')
        census(row['stdout'], 1, 0)
        match = re.findall(r'\((\d+) \+ (\d+) of (\d+) bytes\)', row['stderr'])
        counts = ('4077084', '3946', '4194372') if arm.startswith('control') else ('4088560', '3946', '4194372')
        need(match == [counts], 'wrong diagnostic byte counters')
    prior = ROOT / 'bench/results/2026-11-03-instruction-attribution'
    adapter = (prior / 'verify-current.py').read_text()
    adapter = adapter.replace('D = Path(__file__).resolve().parent\nROOT = D.parents[2]', "HERE = Path(__file__).resolve().parent\nROOT = HERE.parents[2]\nD = ROOT / 'bench/results/2026-11-03-instruction-attribution'")
    adapter = adapter.replace("frozen = index.validate(ROOT, load(D / 'complete-frozen-index.json'))", "frozen = index.validate(ROOT, load(HERE / 'prior-remapped-index.json'))")
    need(adapter == (D / 'replay-prior.py').read_text(), 'prior adapter exceeds approved path/index remap')
    proc = subprocess.run([sys.executable, '-B', str(D / 'replay-prior.py')], cwd=ROOT, capture_output=True, text=True, timeout=120)
    need(proc.returncode == 0, 'prior checkpoint failed: ' + proc.stderr)
    need(index.load(proc.stdout) == load(D / 'prior-checkpoint.json') == load(D / 'prior-remapped-checkpoint.json'), 'prior checkpoint changed')
    argv = [sys.executable, '-B', '-m', 'unittest', 'discover', '-s', 'bench', '-p', 'test_*.py']
    proc = subprocess.run(argv, cwd=ROOT, capture_output=True, text=True, timeout=60)
    need(proc.returncode == 0 and 'Ran 65 tests' in proc.stderr and proc.stderr.rstrip().endswith('OK'), 'existing Python tests failed')
    frozen = index.validate(ROOT, load(D / 'frozen-index.json'))
    return dict(schema='glass.csi-outlining-checkpoint/v1', sessions=48, blocks=12, runtime_promotion=False,
        engine_screen_cleared=False, primary_cpu_ratios={n: v['median_cpu_ratio'] for n, v in decision['contrasts']['primary'].items()},
        failed_point_guards=['unicode'], terminal_tests_per_new_arm_and_restored_control=383, differential_streams_per_new_arm_and_restored_control=12800,
        existing_python_tests=65, corruption_cases_rejected=23, codegen_decimal_loop_register='r9', print_utf8_normalized_instructions=1967,
        unchanged_crate_rust_sources=len(state['rust_sha256']), unchanged_prior_result_report_files=len(state['prior_sha256']),
        selected_binary_sha256=state['selected_sha256'], frozen_file_references=frozen['file_references'], prior_checkpoint_replayed=True,
        note='Read-only operational research/evidence replay, not unique causal attribution, end-to-end superiority or championship acceptance.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
