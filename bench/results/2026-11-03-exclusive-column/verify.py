#!/usr/bin/env python3
"""Read-only iteration-20 checkpoint; never captures timing or repairs evidence."""
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def fingerprint():
    return {str(p.relative_to(HERE)): sha(p) for p in HERE.rglob('*')
            if p.is_file() and '__pycache__' not in p.parts}


def check():
    before = fingerprint()
    analyze = module('exclusive_final', HERE / 'analyze.py')
    load = analyze.load
    start = load(HERE / 'starting-state.json')
    for path, expected in start['rust_sha256'].items():
        source = ROOT / path
        if path == 'crates/term/src/speed.rs':
            assert sha(HERE / 'control-speed.rs') == expected
            assert source.read_bytes() == (HERE / 'regression-speed.rs').read_bytes()
            assert source.read_bytes().startswith((HERE / 'control-speed.rs').read_bytes())
        else:
            assert sha(source) == expected, path
    assert (ROOT / 'crates/term/src/engine.rs').read_bytes() == (HERE / 'control-engine.rs').read_bytes()
    for path, expected in start['prior_sha256'].items():
        assert sha(ROOT / path) == expected, path
    assert sha(ROOT / start['selected_path']) == start['selected_sha256']
    decision = analyze.analyze()
    assert decision == load(HERE / 'engine-decision.json')
    assert not decision['engine_screen_cleared'] and not decision['runtime_promotion']
    corruption = module('exclusive_corruption_final', HERE / 'check-corruption.py').check()
    assert corruption == load(HERE / 'corruption-replay.json')
    assert len(corruption['cases']) == 9 and all(c['rejected'] for c in corruption['cases'])
    historical = module('exclusive_historical_final', ROOT / 'bench/replay-evidence-index.py')
    for name in ('prior-frozen-index.json', 'frozen-index.json'):
        if name == 'frozen-index.json' and not (HERE / name).exists():
            continue
        result = historical.validate(ROOT, load(HERE / name))
        if name == 'prior-frozen-index.json':
            saved = load(HERE / 'prior-frozen-replay-corrected.json')
            saved.pop('index_sha256')
            assert result == saved
            assert result['file_references'] == 535 and result['historical_references'] == 1
    # Run exact retained executables, not generated fixture logs, for correctness.
    base = Path('/tmp/glass-i20-control-test')
    candidate = Path('/tmp/glass-i20-candidate-test')
    mutant = Path('/tmp/glass-i20-mutant-test')
    positive = load(HERE / 'positive-control-result.json')
    assert sha(mutant) == positive['mutant_sha256']
    regression_results = []
    for binary, expected in ((base, 0), (candidate, 0), (mutant, 101)):
        proc = subprocess.run([str(binary), '--exact', 'speed::unicode_row_edges_preserve_pending_wrap', '--nocapture'],
                              cwd=ROOT, text=True, capture_output=True, timeout=60)
        assert proc.returncode == expected, (str(binary), proc.stdout, proc.stderr)
        if expected:
            assert 'assertion `left == right` failed' in proc.stderr
            assert 'test result: FAILED. 0 passed; 1 failed' in proc.stdout
        else:
            assert 'test result: ok. 1 passed; 0 failed' in proc.stdout
        regression_results.append(dict(binary=binary.name, exit=proc.returncode))
    suite = subprocess.run([str(base)], cwd=ROOT, text=True, capture_output=True, timeout=120)
    assert suite.returncode == 0 and '380 passed; 0 failed; 11 ignored' in suite.stdout
    tests = subprocess.run([sys.executable, '-B', '-m', 'unittest', 'discover', '-s', 'bench', '-p', 'test_*.py'],
                           cwd=ROOT, text=True, capture_output=True, timeout=60)
    assert tests.returncode == 0 and 'Ran 49 tests' in tests.stderr and '\nOK\n' in tests.stderr
    assert 'swept 12800 streams over 64 seeds: no divergence' in (HERE / 'restored-sweep.log').read_text()
    assert 'test result: ok. 1 passed; 0 failed' in (HERE / 'restored-cargo-boundary.log').read_text()
    assert fingerprint() == before, 'checkpoint changed evidence'
    return dict(schema='glass.exclusive-column-checkpoint/v1', engine_pairs=11,
                engine_runs=22, engine_screen_cleared=False, runtime_promotion=False,
                unchanged_rust_sources=119, regression_only_rust_sources=1,
                unchanged_prior_artifacts=len(start['prior_sha256']),
                selected_binary_sha256=start['selected_sha256'],
                terminal_tests=380, ignored_terminal_tests=11, python_tests=49,
                reported_parser_sweep_streams=12800, report_corruptions_rejected=9,
                regression_runs=regression_results, historical_file_references=535,
                historical_source_snapshots=1, canonical_evidence_unchanged=True,
                note='Integrity and executable local correctness checkpoint, not a timing rerun, '
                     'statistical effect proof, runtime promotion or championship acceptance.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
