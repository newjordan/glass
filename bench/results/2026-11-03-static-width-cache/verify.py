#!/usr/bin/env python3
"""Read-only checkpoint. No build, source repair, discovery or performance rerun."""
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[3]
D = Path(__file__).resolve().parent


def need(ok, message):
    if not ok:
        raise ValueError(message)


def load(name):
    return json.loads((D / name).read_bytes())


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def module(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value


def text(name):
    return (D / name).read_text()


def run(args, expected):
    result = subprocess.run(args, cwd=ROOT, text=True, capture_output=True, timeout=180)
    need(result.returncode == 0 and expected in result.stdout + result.stderr,
         f'checkpoint command failed/empty: {args}: {result.stdout} {result.stderr}')
    return dict(command=args, exit=result.returncode)


def main():
    state = load('starting-state.json')
    for name, expected in {**state['rust_sha256'], **state['prior_sha256']}.items():
        need(sha(ROOT / name) == expected, f'changed preserved source {name}')
    need(sha(ROOT / state['selected_path']) == state['selected_sha256'], 'changed selected terminal')
    need(sha(D / 'protocol.json') == 'e33e581ff773cc7762b6e6578f21cc4a9d46e5ad484e508bf17e342555cb95a7', 'changed protocol')
    need((ROOT / 'crates/term/src/engine.rs').read_bytes() == (D / 'control-engine.rs').read_bytes(), 'runtime not restored')
    need((ROOT / 'crates/term/src/speed.rs').read_bytes() == (D / 'control-speed.rs').read_bytes(), 'speed changed')
    source_a, source_b = text('diagnostic-control-engine.rs'), text('diagnostic-candidate-engine.rs')
    # Require exact source snapshots to be related by the retained one-change patch.
    patch = subprocess.run(['git', 'apply', '--numstat', str(D / 'candidate.patch')], cwd=ROOT,
                           capture_output=True, text=True, check=True)
    need('crates/term/src/engine.rs' in patch.stdout, 'wrong candidate patch')
    import difflib
    need(text('candidate.patch') == ''.join(difflib.unified_diff(source_a.splitlines(True), source_b.splitlines(True),
         fromfile='a/crates/term/src/engine.rs', tofile='b/crates/term/src/engine.rs')), 'patch/snapshot mismatch')
    for path, expected in load('verification-identities.json').items():
        need(sha(path) == expected, f'changed/missing exact binary: {path}')
    identities = load('binary-identities.json')
    need(identities == {k: v for k, v in load('verification-identities.json').items() if 'i22' in k}, 'identity mismatch')
    for arm in ('control', 'candidate'):
        artifacts = [json.loads(s) for s in text(f'build-{arm}.jsonl').splitlines()]
        artifacts = [r for r in artifacts if r.get('reason') == 'compiler-artifact' and r.get('executable') and r['target']['name'] == 'glass' and r['profile']['test']]
        need(len(artifacts) == 1 and artifacts[0]['profile']['opt_level'] == '3' and
             not artifacts[0]['profile']['debug_assertions'], f'wrong release build: {arm}')
        need('Finished `release` profile' in text(f'build-{arm}.log'), 'build incomplete')
    engine = module(ROOT / 'bench/replay-engine-pairs.py', 'engine_replay')
    raw_engine = load('engine-pairs.json')
    summary = engine.validate(raw_engine, verify_binaries=True, expected_pairs=11)
    expected_ids = {str(Path(v['path'])): v['sha256'] for v in raw_engine['binaries'].values()}
    need(expected_ids == identities, 'engine wrong binaries')
    decision = json.loads(subprocess.check_output(['python3', '-B', str(D / 'analyze.py')], cwd=ROOT, text=True))
    need(decision == load('engine-decision.json') and decision['runtime_promotion'] is False and
         decision['engine_screen_cleared'] is False, 'decision mismatch')
    cold = module(ROOT / 'bench/replay-cold-width-pairs.py', 'cold_replay')
    raw_cold = load('cold-pairs.json')
    need(raw_cold['binaries'] == raw_engine['binaries'], 'cold wrong binaries')
    cold_summary = cold.validate(raw_cold, verify_binaries=True, expected_pairs=15)
    need(cold_summary == load('cold-replay.json') == load('cold-replay-final.json'), 'cold summary mismatch')
    for arm in ('base', 'candidate'):
        raw = [json.loads(re.search(r'^COLD_WIDTH_V1 (.*)$', pair[arm]['stderr'], re.M)[1]) for pair in raw_cold['pairs']]
        distribution = load('cold-distributions.json')[arm]
        import statistics
        for field in cold.FIELDS:
            values = [r[field] for r in raw]
            need(distribution[field] == dict(min=min(values), median=statistics.median(values), max=max(values), all=values), 'distribution mismatch')
    need('382 passed; 0 failed; 12 ignored;' in text('candidate-terminal-tests.log'), 'candidate tests incomplete')
    need('381 passed; 0 failed; 11 ignored;' in text('restored-terminal-tests.log'), 'restored tests incomplete')
    for name in ('candidate-sweep-corrected.log', 'restored-sweep.log'):
        need('swept 12800 streams over 64 seeds: no divergence' in text(name) and
             '1 passed; 0 failed;' in text(name), 'missing actual seeded sweep')
    for name in ('candidate-parser-corrected.log', 'control-parser.log', 'candidate-width.log', 'candidate-concurrent.log'):
        need('1 passed; 0 failed;' in text(name), f'empty/failed correctness receipt {name}')
    for name in ('invalid-selector-parser.log', 'invalid-selector-sweep.log'):
        need('0 passed; 0 failed;' in text(name), 'initial selector evidence lost')
    need('Ran 57 tests' in text('python-tests.log') and text('python-tests.log').strip().endswith('OK'), 'missing Python receipt')
    corruption = json.loads(subprocess.check_output(['python3', '-B', str(D / 'check-corruption.py')], cwd=ROOT, text=True))
    need(corruption == load('corruption-replay.json') and len(corruption['cases']) == 23 and corruption['canonical_reports_unchanged'] is True, 'corruption replay mismatch')
    checks = []
    for path in identities:
        checks.append(run([path, '--exact', 'engine::tests::width_cache_agrees_with_the_crate_everywhere', '--nocapture'], '1 passed; 0 failed;'))
        checks.append(run([path, '--exact', 'engine::tests::width_cache_concurrent_fills_preserve_policy', '--nocapture'], '1 passed; 0 failed;'))
    checks.append(run(['/tmp/glass-i21-restored-test', '--exact', 'speed::c1_row_runs_preserve_parser_state', '--nocapture'], '1 passed; 0 failed;'))
    checks.append(run(['python3', '-B', '-m', 'unittest', 'discover', '-s', 'bench', '-p', 'test*.py'], 'Ran 57 tests'))
    index = module(ROOT / 'bench/replay-evidence-index.py', 'index_replay')
    previous = index.validate(ROOT, load('prior-frozen-index.json'))
    if (D / 'frozen-index.json').exists():
        frozen = index.validate(ROOT, load('frozen-index.json'))
    else:
        frozen = None
    print(json.dumps(dict(schema='glass.static-width-checkpoint/v1', engine_pairs=11, cold_processes=30,
        engine_screen_cleared=False, runtime_promotion=False, unicode_cpu_ratio=summary['unicode']['median_cpu_ratio'],
        unchanged_rust_sources=len(state['rust_sha256']), unchanged_prior_artifacts=len(state['prior_sha256']),
        selected_binary_sha256=state['selected_sha256'], candidate_terminal_tests=382, restored_terminal_tests=381,
        python_tests=57, differential_streams_per_arm=12800, corruptions_rejected=23,
        cold_cpu_medians_ns=cold_summary['metrics']['cpu_ns'], live_checks=checks,
        previous_frozen_files=previous['file_references'], frozen_files=None if frozen is None else frozen['file_references'],
        note='Integrity/correctness replay only; not new timing, source rebuild or championship acceptance.'), indent=2))


if __name__ == '__main__':
    main()
