#!/usr/bin/env python3
"""Read-only local research checkpoint; no rebuild, repair or timing rerun."""
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
D = ROOT / 'bench/results/2026-11-03-authority-handoff'


def need(ok, message):
    if not ok:
        raise ValueError(message)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


index = module('handoff_index', ROOT / 'bench/replay-evidence-index.py')


def load(path):
    return json.loads(Path(path).read_text(), object_pairs_hook=index.unique)


def result(text, passed, failed=0, ignored=None):
    matches = re.findall(r'^test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', text, re.M)
    need(len(matches) == 1, 'missing/ambiguous test result')
    status, p, f, i = matches[0]
    need(int(p) == passed and int(f) == failed and status == ('FAILED' if failed else 'ok'),
         'wrong test census/status')
    need(ignored is None or int(i) == ignored, 'wrong ignored count')


def check():
    state = load(D / 'starting-state.json')
    identities = load(D / 'verification-identities.json')
    changed = [p for p, digest in state['rust_sha256'].items() if sha(ROOT / p) != digest]
    need(changed == ['crates/term/src/speed.rs'], f'unexpected Rust edits: {changed}')
    need(sha(ROOT / changed[0]) == identities['regression_sha256'], 'regression changed')
    for p, digest in state['prior_sha256'].items():
        need(sha(ROOT / p) == digest, f'changed prior result/report: {p}')
    need(sha(ROOT / state['selected_path']) == state['selected_sha256'], 'selected executable changed')
    for p, digest in identities['binaries'].items():
        need(sha(p) == digest, f'changed diagnostic executable: {p}')
    need(sha('/tmp/glass-i24-control-test') == sha('/tmp/glass-i24-restored-test'), 'restored executable differs')
    need(len(set(identities['binaries'].values())) == 3, 'expected control=restored and distinct candidate/mutant')

    arm = module('handoff_arm', ROOT / 'bench/build-engine-arm.py')
    for kind in ('control', 'candidate', 'mutant', 'restored'):
        identity = load(D / f'build-{kind}/identity.json')
        need(identity == load(D / f'build-{kind}.json'), 'build identity copies differ')
        binary = f'/tmp/glass-i24-{kind}-test'
        need(identity['executable'] == binary and identity['sha256'] == sha(binary), 'build binary mismatch')
        need(set(identity['source_sha256']) == set(arm.INPUTS), 'missing build inputs')
        for p in arm.INPUTS:
            prefix = 'control' if kind == 'restored' else kind
            if kind == 'mutant' and p != 'crates/term/src/engine.rs':
                prefix = 'candidate'
            snapshot = D / (prefix + '-' + p.replace('/', '_'))
            need(identity['source_sha256'][p] == sha(snapshot), f'build snapshot mismatch: {kind}/{p}')
            if kind == 'restored':
                need(sha(ROOT / p) == sha(snapshot), 'restored source mismatch')
        rows = [json.loads(line) for line in (D / f'build-{kind}/cargo.jsonl').read_text().splitlines()]
        arm.select(rows)
    candidate = (D / 'candidate-crates_term_src_engine.rs').read_text()
    mutant = (D / 'mutant-crates_term_src_engine.rs').read_text()
    old = '            ground = false;\n'
    need(candidate.count(old) == 1 and mutant == candidate.replace(old,
         '            // MUTANT: incorrectly retain ground across parser advance.\n'), 'mutant scope changed')

    analysis = module('handoff_analysis', D / 'analyze.py')
    report = load(D / 'engine-pairs.json')
    decision = analysis.analyze(report)
    need(decision == load(D / 'engine-decision.json'), 'decision changed')
    need(not decision['engine_screen_cleared'] and not decision['runtime_promotion'], 'unexpected promotion')
    need(decision['cleared_targets'] == ['ascii', 'scroll_region']
         and decision['point_regression_guards_failed'] == ['truecolor'], 'gate outcome changed')
    need(load(D / 'protocol.json')['engine']['pairs'] == 11, 'protocol changed')

    for kind in ('control', 'candidate', 'restored'):
        result((D / f'{kind}-terminal-tests.log').read_text(), 383, ignored=11)
        text = (D / f'{kind}-sweep.log').read_text()
        result(text, 1)
        need('swept 12800 streams over 64 seeds: no divergence' in text, 'missing sweep census')
        text = (D / f'{kind}-handoff.log').read_text()
        result(text, 1)
        need('simple lane ground handoff boundaries: 2160 scenarios matched' in text, 'missing handoff census')
    mutant_log = (D / 'mutant-handoff.log').read_text()
    result(mutant_log, 0, 1)
    need('Some("cells")' in mutant_log, 'mutant failure is not a cell mismatch')
    need(load(D / 'mutant-exit.json') == dict(exit=101, actual_cell_mismatch=True), 'wrong mutant exit')
    python = (D / 'python-tests.log').read_text()
    need('Ran 65 tests' in python and python.rstrip().endswith('OK'), 'Python census mismatch')
    corruption = module('handoff_corruption', D / 'check-corruption.py').check()
    need(corruption == load(D / 'corruption-replay.json'), 'corruption challenge changed')
    need(len(corruption['cases']) == 22 and corruption['canonical_reports_unchanged'] is True,
         'corruption census mismatch')
    ancestor = index.validate(ROOT, load(D / 'ancestor-frozen-index.json'))
    prior = index.validate(ROOT, load(D / 'prior-frozen-index.json'))
    own = index.validate(ROOT, load(HERE / 'prior-own-remapped-index.json'))

    live = []
    for kind in ('control', 'candidate', 'mutant', 'restored'):
        argv = [f'/tmp/glass-i24-{kind}-test', '--exact', 'speed::simple_lane_ground_handoff_boundaries', '--nocapture']
        proc = subprocess.run(argv, cwd=ROOT, capture_output=True, text=True, timeout=60)
        failed = kind == 'mutant'
        need(proc.returncode == (101 if failed else 0), f'live exit mismatch: {kind}')
        result(proc.stdout, 0 if failed else 1, 1 if failed else 0)
        need(('Some("cells")' if failed else '2160 scenarios matched') in proc.stderr, 'missing live semantic marker')
        live.append(dict(argv=argv, exit=proc.returncode))
    argv = [sys.executable, '-B', '-m', 'unittest', 'discover', '-s', 'bench', '-p', 'test*.py']
    proc = subprocess.run(argv, cwd=ROOT, capture_output=True, text=True, timeout=60)
    need(proc.returncode == 0 and 'Ran 65 tests' in proc.stderr and proc.stderr.rstrip().endswith('OK'),
         'live Python suite failed')
    live.append(dict(argv=argv, exit=proc.returncode))
    return dict(schema='glass.authority-handoff-checkpoint/v1', engine_pairs=len(report['pairs']),
                engine_screen_cleared=False, runtime_promotion=False,
                cpu_ratios={p: r['median_cpu_ratio'] for p, r in decision['summary'].items()},
                terminal_tests_per_correct_arm=383, differential_streams_per_correct_arm=12800,
                handoff_scenarios_per_correct_arm=2160, python_tests=65, corruptions_rejected=22,
                unchanged_runtime_rust_sources=sum(p.startswith('crates/') for p in state['rust_sha256']) - 1,
                changed_rust_sources=changed, unchanged_prior_artifacts=len(state['prior_sha256']),
                selected_binary_sha256=state['selected_sha256'],
                ancestor_frozen_file_references=ancestor['file_references'],
                prior_frozen_file_references=prior['file_references'], own_frozen_file_references=own['file_references'],
                live_checks=live,
                note='Integrity/correctness and stored-screen replay only; not new timings or championship acceptance.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
