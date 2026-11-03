#!/usr/bin/env python3
"""Read-only local diagnostic checkpoint. No repair, build or timing rerun."""
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

D = Path(__file__).resolve().parent
ROOT = D.parents[2]


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    obj = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(obj)
    return obj


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def need(ok, message):
    if not ok:
        raise ValueError(message)


def check():
    index = module('attribution_index', ROOT / 'bench/replay-evidence-index.py')
    load = lambda p: index.load(Path(p).read_bytes())
    state = load(D / 'starting-state.json')
    for group in ('rust_sha256', 'prior_sha256'):
        for path, digest in state[group].items():
            need(sha(ROOT / path) == digest, 'changed preserved file: ' + path)
    need(sha(ROOT / state['selected_path']) == state['selected_sha256'], 'selected binary changed')
    for row in state['binaries'].values():
        need(sha(row['path']) == row['sha256'], 'exact diagnostic binary missing/changed')
    frozen = index.validate(ROOT, load(D / 'frozen-index.json'))
    need(len(frozen['manifests']) == 1, 'unexpected own evidence manifests')
    analysis = module('attribution_analysis', D / 'analyze.py')
    for mode in ('pilot', 'main'):
        need(analysis.analyze(D, mode) == load(D / f'{mode}-analysis.json'), 'analysis replay differs')
    cross = module('attribution_crosscheck', D / 'crosscheck.py').check()
    need(cross == load(D / 'crosscheck.json'), 'cross-check changed')
    prior = subprocess.run([sys.executable, '-B', str(ROOT / 'bench/results/2026-11-03-authority-handoff/verify.py')], cwd=ROOT, capture_output=True, text=True, timeout=120)
    need(prior.returncode == 0, 'prior checkpoint failed: ' + prior.stderr)
    need(json.loads(prior.stdout) == load(D / 'prior-checkpoint.json'), 'prior checkpoint result differs')
    argv = [sys.executable, '-B', '-m', 'unittest', 'discover', '-s', 'bench', '-p', 'test_replay_engine_pairs.py']
    tests = subprocess.run(argv, cwd=ROOT, capture_output=True, text=True, timeout=60)
    need(tests.returncode == 0 and 'Ran 5 tests' in tests.stderr and tests.stderr.rstrip().endswith('OK'), 'existing engine replay tests failed')
    report = load(D / 'main-analysis.json')
    need(report['sessions'] == 24 and report['sampled_sessions'] == 12, 'wrong capture count')
    return dict(schema='glass.instruction-attribution-checkpoint/v1', runtime_promotion=False,
                sessions=24, sampled_sessions=12, excluded_pilot_sessions=1,
                confirmatory_samples=sum(p['samples'] for p in report['profiles']),
                crosscheck=cross, own_frozen_file_references=frozen['file_references'],
                unchanged_tracked_rust_sources=len(state['rust_sha256']),
                unchanged_prior_result_report_files=len(state['prior_sha256']),
                selected_binary_sha256=state['selected_sha256'],
                existing_engine_replay_tests=5, prior_checkpoint_replayed=True,
                plain_cpu_rate_ratios=report['cpu_rate_comparisons'],
                note='Read-only diagnostic replay and integrity; not causal attribution, new timings or championship acceptance.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
