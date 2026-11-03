#!/usr/bin/env python3
"""Read-only checkpoint verification, not performance/competitive acceptance."""
import hashlib
import importlib.util
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def load(p):
    return json.loads(p.read_text())

def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result

start = load(HERE/'starting-state.json')
for category in ('runtime_sources', 'prior_artifacts'):
    for name, expected in start[category].items():
        assert sha(ROOT/name) == expected, f'changed {name}'
assert {str(p.relative_to(ROOT)) for p in (ROOT/'crates').rglob('*.rs')} == set(start['runtime_sources'])
selected = ROOT/'target/release/glass'
assert sha(selected) == start['selected_sha256']
assert selected.read_bytes() == Path('/tmp/glass-i17-selected').read_bytes()

replay = module('contention_replay', ROOT/'bench/linux/analyze-reader-contention.py')
sessions = {}
for series in ('pilot-v2', 'balanced', 'safe-smoke'):
    actual = replay.analyze(HERE/series)
    assert actual == load(HERE/f'{series}-replay.json'), series
    sessions[series] = actual['sessions']

# Recovered earlier iteration remains numerically reproducible, unmodified.
sched_root = ROOT/'bench/results/2026-11-03-scheduler-shape'
prior = replay.sched.analyze(sched_root/'balanced')
prior['calibration'] = replay.sched.calibration(sched_root)
assert prior == load(sched_root/'balanced-final-replay.json')

corrupt = load(HERE/'corruption-replay.json')
assert len(corrupt['cases']) == 10 and corrupt['canonical_unchanged']
assert all(c['rejected'] and c['unchanged_files'] == 30 for c in corrupt['cases'])
cleanup = load(HERE/'signal-smoke-replay.json')
assert {c['signal'] for c in cleanup['cases']} == {'SIGTERM', 'SIGHUP', 'SIGINT'}
assert all(c['restored'] and c['helper_gone'] and c['interrupted'] and not c['complete'] for c in cleanup['cases'])

integrity = module('historical_replay', ROOT/'bench/replay-evidence-index.py')
frozen = integrity.validate(ROOT, load(HERE/'frozen-index.json'))
print(json.dumps(dict(schema='glass.contention-final-verification/v1',
    sessions=sessions, session_total=sum(sessions.values()), prior_scheduler_sessions=36,
    rust_sources_unchanged=len(start['runtime_sources']),
    prior_artifacts_unchanged=len(start['prior_artifacts']),
    selected_sha256=sha(selected), selected_byte_comparison=True,
    corruption_cases=10, catchable_signal_cases=3, frozen=frozen,
    note='Byte consistency and replay only; not a world title or global acceptance.'),indent=2))
