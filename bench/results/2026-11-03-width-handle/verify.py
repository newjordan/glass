#!/usr/bin/env python3
"""Read-only iteration-21 checkpoint: no timing, rebuilding, discovery or repair."""
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


def load(path):
    return json.loads(path.read_bytes())


def main():
    replay = module('width_handle_engine_replay', ROOT / 'bench/replay-engine-pairs.py')
    historical = module('width_handle_historical', ROOT / 'bench/replay-evidence-index.py')
    decision = module('width_handle_decision', HERE / 'analyze.py')
    cold = module('width_handle_cold', HERE / 'analyze-cold.py')
    start = load(HERE / 'starting-state.json')
    rust = start['rust_sha256']
    assert len(rust) == 120
    assert set(p for p in rust if sha(ROOT / p) != rust[p]) == {'crates/term/src/speed.rs'}
    assert (ROOT / 'crates/term/src/speed.rs').read_bytes() == (HERE / 'regression-speed.rs').read_bytes()
    assert (ROOT / 'crates/term/src/engine.rs').read_bytes() == (HERE / 'control-engine.rs').read_bytes()
    for p, expected in start['prior_sha256'].items():
        assert sha(ROOT / p) == expected, p
    assert sha(ROOT / start['selected_path']) == start['selected_sha256']
    prior = historical.validate(ROOT, load(HERE / 'prior-frozen-index.json'))
    saved_prior = load(HERE / 'prior-frozen-replay.json')
    saved_prior.pop('index_sha256')
    assert prior == saved_prior
    report = load(HERE / 'engine-pairs.json')
    summary = replay.validate(report, expected_pairs=11, verify_binaries=True)
    assert decision.analyze() == load(HERE / 'engine-decision.json')
    assert not load(HERE / 'engine-decision.json')['engine_screen_cleared']
    assert cold.analyze() == load(HERE / 'cold-result.json') == load(HERE / 'cold-replay.json')
    corruption = subprocess.run([sys.executable, '-B', str(HERE / 'check-corruption.py')],
                                text=True, capture_output=True, check=True)
    assert json.loads(corruption.stdout) == load(HERE / 'corruption-replay.json')
    assert len(load(HERE / 'corruption-replay.json')['cases']) == 9
    for name in ('candidate-width.log', 'candidate-parser.log', 'candidate-boundary.log'):
        assert '1 passed; 0 failed' in (HERE / name).read_text(), name
    assert '381 passed; 0 failed; 11 ignored' in (HERE / 'restored-terminal-tests.log').read_text()
    assert '381 passed; 0 failed; 11 ignored' in (HERE / 'restored-cargo-tests.log').read_text()
    assert 'swept 12800 streams over 64 seeds: no divergence' in (HERE / 'restored-sweep.log').read_text()
    assert 'Ran 49 tests' in (HERE / 'python-tests.log').read_text()
    assert '\nOK\n' in (HERE / 'python-tests.log').read_text()
    mutation = load(HERE / 'mutation-result.json')
    assert mutation['exit'] == 101 and mutation['detected_field'] == 'cells'
    assert 'Some("cells")' in (HERE / 'mutant-c1.log').read_text()
    assert 'speed::c1_row_runs_preserve_parser_state ... FAILED' in (HERE / 'mutant-c1.log').read_text()
    # Rerun exact regression binaries, not benchmarks. Bind even temporary
    # executables to their retained compiler-artifact hashes first.
    binary_replays = []
    for path, expected in load(HERE / 'verification-identities.json').items():
        assert sha(Path(path)) == expected, path
        mutant = 'mutant' in path
        result = subprocess.run([path, '--exact', 'speed::c1_row_runs_preserve_parser_state', '--nocapture'],
                                text=True, capture_output=True)
        assert result.returncode == (101 if mutant else 0), (path, result.stdout, result.stderr)
        if mutant:
            assert 'Some("cells")' in result.stderr
        else:
            assert '1 passed; 0 failed' in result.stdout
        binary_replays.append(dict(binary=Path(path).name, exit=result.returncode))
    frozen = historical.validate(ROOT, load(HERE / 'frozen-index.json')) if (HERE / 'frozen-index.json').exists() else None
    print(json.dumps(dict(schema='glass.width-handle-checkpoint/v1',
                         engine_pairs=11, engine_runs=22, engine_screen_cleared=False,
                         runtime_promotion=False, unicode_cpu_ratio=summary['unicode']['median_cpu_ratio'],
                         unchanged_rust_sources=119, regression_only_rust_sources=1,
                         unchanged_prior_artifacts=len(start['prior_sha256']),
                         selected_binary_sha256=start['selected_sha256'], terminal_tests=381,
                         ignored_terminal_tests=11, python_tests=49, reported_sweep_streams=12800,
                         report_corruptions_rejected=9, cold_diagnostic_processes=6,
                         cold_diagnostic='instrumented state, not RSS/latency',
                         binary_replays=binary_replays, prior_frozen=prior, frozen=frozen,
                         note='Correctness and evidence replay only. No Ghostty timing or world-title acceptance.'), indent=2))


if __name__ == '__main__':
    main()
