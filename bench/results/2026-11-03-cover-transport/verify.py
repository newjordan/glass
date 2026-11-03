#!/usr/bin/env python3
"""Exact local checkpoint: build provenance, independent cell oracle and replay."""
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess

D = Path(__file__).resolve().parent
ROOT = D.parents[2]

def need(ok, message):
    if not ok:
        raise ValueError(message)

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def load(p):
    return json.loads(p.read_text())

def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value

def verify():
    manifest = load(D / 'evidence-sha256.json')
    for path, digest in manifest['sha256'].items():
        need(sha(ROOT / path) == digest, 'changed evidence: ' + path)
    start = load(D / 'starting-state.json')
    changed = {'crates/term/src/intake/mod.rs', 'crates/term/src/intake/motion.rs',
               'crates/term/src/intake/position_tests.rs'}
    for path, digest in start['sources'].items():
        if path not in changed:
            need(sha(ROOT / path) == digest, 'unrelated source changed: ' + path)
    need(sha(ROOT / 'target/release/glass') == start['shipping_sha256'], 'selected binary changed')
    test = ROOT / 'crates/term/src/intake/position_tests.rs'
    original = (D / 'original-crates_term_src_intake_position_tests.rs').read_bytes()
    need(test.read_bytes() == original + b'\n' + (D / 'new-tests.rs').read_bytes(), 'original tests altered')
    build = module('build_arm', D / 'build.py')
    identities = {}
    for arm, folder in [('control', 'build-control-v3'), ('candidate', 'build-candidate')]:
        receipt = load(D / folder / 'identity.json')
        rows = [json.loads(line) for line in (D / folder / 'cargo.jsonl').read_text().splitlines()]
        build.select(rows)
        identities[arm] = receipt['sha256']
        for path, digest in receipt['source_sha256'].items():
            if arm == 'candidate':
                actual = ROOT / path
            elif path == 'crates/term/src/intake/position_tests.rs':
                actual = D / 'control-position_tests.rs'
            else:
                retained = D / ('original-' + path.replace('/', '_'))
                actual = retained if retained.exists() else ROOT / path
            need(sha(actual) == digest, 'build input mismatch: ' + path)
    runs = load(D / 'runs.json')
    labels = ['control', 'candidate', 'full-candidate', 'sweep-control', 'sweep-candidate']
    need([r['label'] for r in runs] == labels, 'run order/completeness')
    for r in runs:
        label = r['label']
        arm = 'control' if label in ('control', 'sweep-control') else 'candidate'
        need(r['binary_sha256'] == identities[arm], 'wrong measured binary')
        need(r['exit'] == (101 if label == 'control' else 0), 'unexpected measured exit')
        need(r['log'] == label + '.log' and sha(D / r['log']) == r['log_sha256'], 'run log mismatch')
        expected_env = {'GLASS_SCROLLBACK': '10000'}
        if label.startswith('sweep-'):
            expected_env.update(GLASS_SWEEP_SEEDS='64', GLASS_SWEEP_ROUNDS='200')
        need(r['environment'] == expected_env, 'run environment')
        if label in ('control', 'candidate'):
            args = ['--exact', 'intake::position_tests::cover_transport_real_intake_cell_oracle', '--test-threads=1', '--nocapture']
        elif label == 'full-candidate':
            args = ['--test-threads=1']
        else:
            args = ['--exact', 'speed::plain_runs_match_the_parser_over_seeds', '--ignored', '--test-threads=1', '--nocapture']
        need(r['argv'][1:] == args, 'measured command changed')
    full = (D / 'full-candidate.log').read_text()
    need('test result: ok. 395 passed; 0 failed; 14 ignored;' in full, 'full suite result')
    for arm in ['control', 'candidate']:
        text = (D / ('sweep-' + arm + '.log')).read_text()
        need('swept 12800 streams over 64 seeds: no divergence' in text and 'test result: ok. 1 passed;' in text, 'differential result')
    cells = module('check_cells', D / 'check-cells.py')
    result = {a: cells.validate_records(cells.parse((D / (a + '.log')).read_text()), a) for a in ['control', 'candidate']}
    checks = subprocess.run(['python3', '-B', str(D / 'test-check-cells.py')], cwd=ROOT, capture_output=True, text=True, timeout=60)
    need(checks.returncode == 0 and 'Ran 5 tests' in checks.stderr and 'OK' in checks.stderr, 'checker tests failed')
    replay = module('replay', ROOT / 'bench/replay-evidence-index.py')
    prior = replay.validate(ROOT, load(D / 'prior-frozen-index.json'))
    need(prior['file_references'] == 1752 and prior['unique_source_versions'] == 1729, 'historical replay count')
    return {'matrices': result, 'final_tests': {'passed': 395, 'ignored': 14}, 'differential_streams_per_arm': 12800,
            'checker_tests': 5, 'evidence_sources': len(manifest['sha256']),
            'historical_references': prior['file_references'], 'historical_versions': prior['unique_source_versions'],
            'selected_executable_unchanged': True}

if __name__ == '__main__':
    print(json.dumps(verify(), indent=2))
