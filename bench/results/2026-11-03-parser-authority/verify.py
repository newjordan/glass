#!/usr/bin/env python3
"""Read-only checkpoint: no builds, source repair, discovery or performance rerun."""
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess
import sys

D = Path(__file__).resolve().parent
ROOT = D.parents[2]


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


def load(path):
    return json.loads(Path(path).read_text(), object_pairs_hook=index.unique)


def result(path, passed, failed=0, ignored=None):
    text = Path(path).read_text()
    matches = re.findall(r'^test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', text, re.M)
    need(len(matches) == 1, f'missing/ambiguous test result: {path}')
    status, p, f, i = matches[0]
    need(int(p) == passed and int(f) == failed and status == ('FAILED' if failed else 'ok'),
         f'unexpected test count/status: {path}')
    if ignored is not None:
        need(int(i) == ignored, f'wrong ignored count: {path}')
    return text


index = module('authority_index', ROOT / 'bench/replay-evidence-index.py')


def check():
    state = load(D / 'starting-state.json')
    expected = load(D / 'verification-identities.json')
    changed = []
    for name, digest in state['rust_sha256'].items():
        if sha(ROOT / name) != digest:
            changed.append(name)
    need(changed == ['crates/term/src/speed.rs'], f'unexpected Rust changes: {changed}')
    need(sha(ROOT / changed[0]) == expected['regression_sha256'], 'regression changed')
    for name, digest in state['prior_sha256'].items():
        need(sha(ROOT / name) == digest, f'prior artifact changed: {name}')
    need(sha(ROOT / state['selected_path']) == state['selected_sha256'], 'selected executable changed')
    for path, digest in load(D / 'binary-identities.json').items():
        need(sha(path) == digest, f'diagnostic executable changed: {path}')
    final_binary = '/tmp/glass-i23-final-restored-test'
    need(sha(final_binary) == sha('/tmp/glass-i23-control-test'), 'restored executable mismatch')
    need(sha('/tmp/glass-i23-stale-control-test') == sha('/tmp/glass-i23-mutant-test'),
         'stale build diagnosis no longer reproduces')
    need(sha('/tmp/glass-i23-control-test') != sha('/tmp/glass-i23-mutant-test'), 'stale measured control')

    prior = index.validate(ROOT, load(D / 'prior-frozen-index.json'))
    frozen = index.validate(ROOT, load(D / 'frozen-index.json'))
    replay = module('authority_checkpoint_engine', ROOT / 'bench/replay-engine-pairs.py')
    analysis = module('authority_checkpoint_analysis', D / 'analyze.py')
    report = load(D / 'engine-pairs.json')
    replay.validate(report, verify_binaries=True, expected_pairs=11)
    decision = analysis.analyze(report)
    need(decision == load(D / 'engine-decision.json'), 'decision replay mismatch')
    need(not decision['engine_screen_cleared'] and not decision['runtime_promotion'], 'promotion mismatch')
    need(decision['cleared_targets'] == ['ascii', 'scroll_region']
         and decision['point_regression_guards_failed'] == ['truecolor'], 'gate changed')
    arm = module('authority_checkpoint_arm', ROOT / 'bench/build-engine-arm.py')
    for name in ('build-control-corrected.jsonl', 'build-candidate-corrected.jsonl',
                 'build-helper-final/cargo.jsonl'):
        rows = [json.loads(line) for line in (D / name).read_text().splitlines()]
        arm.select(rows)
    identity = load(D / 'build-helper-final/identity.json')
    need(identity['sha256'] == sha(final_binary), 'helper executable mismatch')
    need(identity['source_sha256'] == {name: sha(ROOT / name) for name in arm.INPUTS},
         'helper built different restored inputs')
    integration = load(D / 'build-helper-final-integration.json')
    need(integration['identical'] is True and integration['duplicate_output_exit'] != 0
         and integration['duplicate_output_refused_before_receipt_creation'] is True,
         'helper live integration mismatch')

    for name in ('control-terminal-tests.log', 'candidate-terminal-tests-final.log',
                 'final-restored-terminal-tests.log'):
        result(D / name, 382, ignored=11)
    for name in ('control-sweep.log', 'candidate-sweep-final.log', 'final-restored-sweep.log'):
        text = result(D / name, 1)
        need('swept 12800 streams over 64 seeds: no divergence' in text, 'missing sweep census')
    for name in ('control-boundaries-corrected.log', 'candidate-boundaries-corrected.log'):
        need('parser ground chunk boundaries: 1092 scenarios matched' in result(D / name, 1),
             'missing boundary census')
    need('Some("cells")' in result(D / 'mutant-boundaries.log', 0, 1), 'non-semantic mutant failure')
    need(load(D / 'mutant-exit.json')['exit'] == 101, 'mutant did not fail')
    need('Ran 65 tests' in (D / 'python-tests-final.log').read_text()
         and (D / 'python-tests-final.log').read_text().rstrip().endswith('OK'), 'Python tests mismatch')
    corruption = module('authority_checkpoint_corruption', D / 'check-corruption.py').check()
    need(corruption == load(D / 'corruption-replay-final.json'), 'corruption replay changed')
    need(len(corruption['cases']) == 17 and corruption['canonical_reports_unchanged'] is True,
         'corruption census mismatch')

    live = []
    commands = [([binary, '--exact', 'speed::parser_ground_chunk_boundaries', '--nocapture'], 0)
                for binary in ('/tmp/glass-i23-control-test', '/tmp/glass-i23-candidate-test')]
    commands += [(['/tmp/glass-i23-mutant-test', '--exact', 'speed::parser_ground_chunk_boundaries', '--nocapture'], 101),
                 ([sys.executable, '-B', '-m', 'unittest', 'discover', '-s', 'bench', '-p', 'test*.py'], 0)]
    for argv, exitcode in commands:
        proc = subprocess.run(argv, cwd=ROOT, capture_output=True, text=True, timeout=60)
        need(proc.returncode == exitcode, f'live exit mismatch: {argv}: {proc.stderr}')
        if exitcode == 101:
            need('Some("cells")' in proc.stderr, 'live mutant lacks cell mismatch')
        elif argv[0] == sys.executable:
            need('Ran 65 tests' in proc.stderr and proc.stderr.rstrip().endswith('OK'), 'live Python mismatch')
        else:
            need('1 passed; 0 failed' in proc.stdout
                 and '1092 scenarios matched' in proc.stderr, 'live regression missing')
        live.append(dict(argv=argv, exit=proc.returncode))
    return dict(schema='glass.parser-authority-checkpoint/v1', engine_pairs=11,
                engine_screen_cleared=False, runtime_promotion=False,
                ascii_cpu_ratio=decision['summary']['ascii']['median_cpu_ratio'],
                scroll_region_cpu_ratio=decision['summary']['scroll_region']['median_cpu_ratio'],
                truecolor_cpu_ratio=decision['summary']['truecolor']['median_cpu_ratio'],
                unchanged_runtime_rust_sources=sum(name.startswith('crates/') for name in state['rust_sha256']) - 1,
                changed_rust_sources=changed, unchanged_prior_artifacts=len(state['prior_sha256']),
                selected_binary_sha256=state['selected_sha256'], terminal_tests_per_arm=382,
                differential_streams_per_arm=12800, boundary_scenarios_per_arm=1092,
                python_tests=65, corruptions_rejected=len(corruption['cases']),
                prior_frozen_file_references=prior['file_references'], frozen_file_references=frozen['file_references'],
                live_checks=live,
                note='Integrity/correctness replay only; not new timing, terminal throughput or championship acceptance.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
