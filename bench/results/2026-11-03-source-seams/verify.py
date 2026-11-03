#!/usr/bin/env python3
"""Replay bounded source-seam geometry and pinned receipts, not campaign acceptance."""
from itertools import product
import hashlib
import json
import math
from pathlib import Path
import re

D = Path(__file__).resolve().parent
ROOT = D.parents[2]


def need(ok, why):
    if not ok:
        raise ValueError(why)


def unique(pairs):
    result = {}
    for key, value in pairs:
        need(key not in result, 'duplicate JSON key')
        result[key] = value
    return result


def load(raw):
    return json.loads(raw, object_pairs_hook=unique)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def coords(rows):
    need(type(rows) is list, 'coordinate list')
    for row in rows:
        need(type(row) is list and len(row) == 7, 'coordinate septuple')
        need(all(type(v) in (int, float) and math.isfinite(v) for v in row), 'finite numeric coordinates')
        need(all(v >= 0 for v in row) and all(row[k] > 0 for k in [2, 5, 6]), 'coordinate domain')


def close(a, b):
    return len(a) == len(b) and all(abs(x - y) < 1e-5 for ra, rb in zip(a, b) for x, y in zip(ra, rb))


def oracle(r):
    # One original image row = one cell-height strip. Do not implement
    # rectangle slicing or merging here: enumerate surviving row identities.
    start, height, top, bottom, n = (r[k] for k in ['start', 'height', 'top', 'bottom', 'n'])
    x, y, width, scale = (1, 1, 1, 2) if r['cropped'] else (0, 0, 1, 1)
    result = []
    for old in range(start, start + height):
        new = old
        if top <= old < bottom:
            if r['down']:
                new += n
                if new >= bottom:
                    continue
            else:
                new -= n
                if new < top:
                    continue
        result.append([new, 1, 2, x, y + (old - start) * scale / height, width, scale / height])
    return sorted(result)


def matrix(text, arm):
    need(arm in ['control', 'candidate'], 'known arm')
    rows = [load(raw) for raw in re.findall(r'source-seams-json (\{[^\n]+\})', text)]
    need(len(rows) == 1536, 'complete record count')
    expected_configs = set(product([False, True], [False, True], [False, True], [0, 2, 4, 6], [2, 4, 6, 8], [(2, 7), (4, 9)], [1, 2, 3], [False, True]))
    seen = set()
    failures = 0
    for r in rows:
        need(set(r) == {'fast', 'alternate', 'cropped', 'start', 'height', 'top', 'bottom', 'n', 'down', 'got', 'expected', 'pass'}, 'exact fields')
        need(all(type(r[k]) is bool for k in ['fast', 'alternate', 'cropped', 'down', 'pass']), 'boolean fields')
        need(all(type(r[k]) is int for k in ['start', 'height', 'top', 'bottom', 'n']), 'integer configuration')
        key = tuple(r[k] for k in ['fast', 'alternate', 'cropped', 'start', 'height']) + ((r['top'], r['bottom']), r['n'], r['down'])
        need(key in expected_configs and key not in seen, 'valid unique configuration')
        seen.add(key)
        coords(r['expected'])
        coords(r['got'])
        want = oracle(r)
        need(close(r['expected'], want), 'independently computed row oracle')
        passed = close(r['got'], want)
        need(r['pass'] == passed, 'computed pass flag')
        failures += not passed
        if arm == 'candidate':
            need(passed, 'candidate source geometry')
    need(seen == expected_configs, 'configuration coverage')
    need(f'source-seams-summary cases=1536 failures={failures}' in text, 'computed summary')
    if arm == 'control':
        need(failures == 384 and 'test result: FAILED. 0 passed; 1 failed;' in text, 'observed control defect')
    else:
        need(failures == 0 and 'test result: ok. 1 passed; 0 failed;' in text, 'executed candidate matrix')
    return {'cases': len(rows), 'failures': failures}


def build(arm):
    folder = D / ('build-' + arm)
    identity = load((folder / 'identity.json').read_text())
    events = [load(row) for row in (folder / 'cargo.jsonl').read_text().splitlines()]
    artifacts = [r for r in events if r.get('reason') == 'compiler-artifact']
    for package in ['glass', 'vte', 'alacritty_terminal']:
        found = [r for r in artifacts if r['target']['name'] == package]
        need(len(found) == 1 and found[0].get('fresh') is False, 'actual compilation')
    need(any(r.get('reason') == 'build-finished' and r.get('success') is True for r in events), 'completed build')
    test = [r for r in artifacts if r['target']['name'] == 'glass' and r.get('executable') and r['profile'].get('test')]
    need(len(test) == 1 and test[0]['profile']['opt_level'] == '3' and test[0]['profile']['debug_assertions'] is False, 'release test build')
    for name, digest in identity['source_sha256'].items():
        prefix = 'original-' if arm == 'control' else 'production-'
        snapshot = D / (prefix + name.replace('/', '_'))
        if arm == 'control' and name.endswith('/position_tests.rs'):
            snapshot = D / 'control-position_tests.rs'
        need(sha(snapshot) == digest, 'source build binding ' + name)
    need(identity['executable'] == '/tmp/glass-i43-' + arm, 'explicit executable')
    executable = Path(identity['executable'])
    if executable.exists():
        need(sha(executable) == identity['sha256'], 'retained executable bytes')
    return identity['sha256']


def verify():
    inventory = load((D / 'evidence-sha256.json').read_text())
    need(inventory['schema'] == 'glass.immutable-research-evidence/v1', 'evidence schema')
    for name, digest in inventory['sha256'].items():
        path = Path(name)
        need(not path.is_absolute() and '..' not in path.parts, 'relative source')
        need(sha(ROOT / path) == digest, 'changed evidence ' + name)
    results = {arm: matrix((D / (arm + '.log')).read_text(), arm) for arm in ['control', 'candidate']}
    binaries = {arm: build(arm) for arm in ['control', 'candidate']}
    runs = load((D / 'runs.json').read_text())
    specs = {
        'control': ('control', 101, ['--exact', 'intake::position_tests::source_seams_real_apc_row_oracle', '--test-threads=1', '--nocapture']),
        'candidate': ('candidate', 0, ['--exact', 'intake::position_tests::source_seams_real_apc_row_oracle', '--test-threads=1', '--nocapture']),
        'full-candidate': ('candidate', 0, ['--test-threads=1']),
        'sweep-control': ('control', 0, ['--exact', 'speed::plain_runs_match_the_parser_over_seeds', '--ignored', '--test-threads=1', '--nocapture']),
        'sweep-candidate': ('candidate', 0, ['--exact', 'speed::plain_runs_match_the_parser_over_seeds', '--ignored', '--test-threads=1', '--nocapture']),
    }
    need(type(runs) is list and len(runs) == len(specs) and {r['label'] for r in runs} == set(specs), 'five explicit runs')
    for r in runs:
        arm, code, args = specs[r['label']]
        need(type(r['exit']) is int and r['exit'] == code, 'actual process exit')
        need(r['argv'] == ['/tmp/glass-i43-' + arm, *args], 'exact command')
        env = {'GLASS_SCROLLBACK': '10000'}
        if r['label'].startswith('sweep-'):
            env.update(GLASS_SWEEP_SEEDS='64', GLASS_SWEEP_ROUNDS='200')
        need(r['environment'] == env, 'run environment')
        need(r['binary_sha256'] == binaries[arm], 'run binary binding')
        need(r['log'] == r['label'] + '.log' and sha(D / r['log']) == r['log_sha256'], 'run log binding')
    full = (D / 'full-candidate.log').read_text()
    need('test result: ok. 394 passed; 0 failed; 14 ignored;' in full, 'full production suite')
    for arm in ['control', 'candidate']:
        text = (D / ('sweep-' + arm + '.log')).read_text()
        need('swept 12800 streams over 64 seeds: no divergence' in text and 'test result: ok. 1 passed; 0 failed;' in text, 'executed differential sweep')
    state = load((D / 'starting-state.json').read_text())
    for name, record in state['sources'].items():
        p = ROOT / name
        if name in ['crates/term/src/intake/motion.rs', 'crates/term/src/intake/position_tests.rs']:
            need(sha(p) == sha(D / ('production-' + name.replace('/', '_'))), 'production source changed')
        elif record is None:
            need(not p.exists(), 'prototype-only source left live')
        else:
            need(sha(p) == record['sha256'], 'unrelated runtime changed')
    need(sha(ROOT / 'target/release/glass') == state['shipping_sha256'], 'selected release changed')
    return {'schema': 'glass.source-seam-replay/v1', **results, 'production_tests': 394, 'ignored': 14, 'differential_streams_per_arm': 12800, 'binary_sha256': binaries, 'selected_executable_unchanged': True, 'note': 'Finite source-row merge fix only. No coverage-mask, resize-witness, timing, memory or competitive acceptance.'}


if __name__ == '__main__':
    print(json.dumps(verify(), indent=2))
