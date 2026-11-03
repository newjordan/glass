#!/usr/bin/env python3
"""Read-only replay of the exact height-snapshot experiment; not acceptance."""
import ast
import hashlib
import itertools
import json
from pathlib import Path
import re

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
HISTORIES = [0, 1, 2, 8, 32, 10000]
CONTROL_FAILURES = [2544, 3622, 3554, 3348, 3342, 3342]
HEIGHT = re.compile(r'height-case rows=(\d+) target=(\d+) cursor=(\d+) marker=(\d+) records=(\d+) alt=(false|true) fast=(false|true) step=(\d+) capacity=(\d+) expected=(None|Some\(-?\d+\)) actual=(None|Some\(-?\d+\)) pictures=(\[[^\]]*\]) ok=(false|true)')
MIXED = re.compile(r'mixed-case rows=(\d+) target=(\d+) width=(\d+) cursor=(\d+) marker=(\d+) records=(\d+) dense=(false|true) alt=(false|true) fast=(false|true) step=(\d+) text=(\[[^\]]*\]) pictures=(\[[^\]]*\]) ok=(false|true)')


def need(ok, message):
    if not ok:
        raise ValueError(message)


def unique(pairs):
    out = {}
    for k, v in pairs:
        need(k not in out, 'duplicate JSON key')
        out[k] = v
    return out


def load(path):
    return json.loads(Path(path).read_text(), object_pairs_hook=unique)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def opt(value):
    return None if value == 'None' else int(value[5:-1])


def height_keys():
    return {(r, t, c, m, n, a, f, s)
            for r in [4, 6] for t in [1, 2, 4, 6, 8]
            for c in range(r) for m in range(r) for n in [0, 1, 12]
            for a in ['false', 'true'] for f in ['false', 'true'] for s in range(3)}


def mixed_keys():
    return {(r, t, w, c, m, n, d, a, f, s)
            for r in [4, 6] for t in [2, 4, 8] for w in [5, 10, 14]
            for c in [0, r - 1] for m in [0, r - 1] for n in [0, 12]
            for d in ['false', 'true'] for a in ['false', 'true']
            for f in ['false', 'true'] for s in range(3)}


def expected_height(key, capacity):
    rows, target, cursor, marker, records, _, _, step = key
    history = min(max(records - (rows - 1), 0), capacity)
    expected = marker
    old = rows
    for next_rows in [target, rows, target][:step + 1]:
        if next_rows > old:
            pull = min(history, next_rows - old)
            expected = None if expected is None else expected + pull
            cursor += pull
            history -= pull
        elif next_rows < old:
            push = max(cursor + 1 - next_rows, 0)
            history = min(history + push, capacity)
            cursor = min(cursor, next_rows - 1)
            if expected is not None:
                expected -= push
                if expected < -history or expected >= next_rows:
                    expected = None
        old = next_rows
    return expected


def height_observations(text, capacity, wanted_failures):
    seen = set()
    bad = 0
    records = [line for line in text.splitlines() if line.startswith('height-case')]
    for line in records:
        match = HEIGHT.fullmatch(line)
        need(match is not None, 'height record format')
        g = match.groups()
        key = (*map(int, g[:5]), g[5], g[6], int(g[7]))
        need(key not in seen, 'duplicate height case')
        seen.add(key)
        need(int(g[8]) == capacity, 'history configuration')
        expected = expected_height(key, capacity)
        need(opt(g[9]) == expected, 'independent height expectation')
        actual = opt(g[10])
        need(actual == expected, 'text arithmetic oracle')
        pictures = ast.literal_eval(g[11])
        need(isinstance(pictures, list) and all(type(v) is int for v in pictures), 'picture row types')
        matched = pictures == ([] if expected is None else [expected])
        need((g[12] == 'true') == matched, 'height match flag')
        bad += not matched
    need(seen == height_keys(), 'complete height identities')
    summary = f'height-summary cases=9360 failures={bad} capacity={capacity}'
    need(text.count(summary) == 1 and len(re.findall(r'^height-summary', text, re.M)) == 1, 'height summary')
    need(bad == wanted_failures, 'height failure count')
    need(f'test result: {"FAILED" if bad else "ok"}. {0 if bad else 1} passed; {1 if bad else 0} failed;' in text, 'height test execution')
    return bad


def mixed_observations(text, wanted_failures):
    seen = set()
    bad = 0
    for line in [line for line in text.splitlines() if line.startswith('mixed-case')]:
        match = MIXED.fullmatch(line)
        need(match is not None, 'mixed record format')
        g = match.groups()
        key = (*map(int, g[:6]), *g[6:9], int(g[9]))
        need(key not in seen, 'duplicate mixed case')
        seen.add(key)
        cells, pictures = ast.literal_eval(g[10]), ast.literal_eval(g[11])
        for vector in [cells, pictures]:
            need(isinstance(vector, list) and all(isinstance(v, tuple) and len(v) == 2 and all(type(x) is int for x in v) for v in vector), 'mixed coordinate types')
        need(len(cells) <= 1, 'one real marker maximum')
        match_flag = cells == pictures
        need((g[12] == 'true') == match_flag, 'mixed match flag')
        bad += not match_flag
    need(seen == mixed_keys(), 'complete mixed identities')
    need(bad == wanted_failures, 'mixed failure count')
    need(text.count(f'mixed-summary cases=3456 failures={bad}') == 1, 'mixed summary')
    need('test result: FAILED. 0 passed; 1 failed;' in text, 'nonzero mixed failure')
    return bad


def build(arm):
    folder = D / ('build-' + arm)
    identity = load(folder / 'identity.json')
    need(identity['command'] == ['cargo', 'test', '--release', '-p', 'glass-term', '--locked', '--no-run', '--message-format=json'], 'build command')
    inputs = identity['source_sha256']
    expected = {'crates/alacritty-terminal/src/grid/mod.rs', 'crates/alacritty-terminal/src/term/mod.rs', 'crates/term/src/engine.rs', 'crates/term/src/speed.rs', 'crates/vte/src/lib.rs', 'crates/vte/src/ansi.rs', 'crates/term/src/intake/position_tests.rs', 'crates/term/src/intake/motion.rs'}
    need(set(inputs) == expected, 'complete build source binding')
    for name, digest in inputs.items():
        frozen = D / (arm + '-' + name.replace('/', '_'))
        need(sha(frozen if frozen.exists() else ROOT / name) == digest, 'bound build source ' + arm + ':' + name)
    if Path(identity['executable']).exists():
        need(sha(identity['executable']) == identity['sha256'], 'built ELF changed')
    cargo = [json.loads(line) for line in (folder / 'cargo.jsonl').read_text().splitlines()]
    for package in ['glass', 'vte', 'alacritty_terminal']:
        targets = [r for r in cargo if r.get('reason') == 'compiler-artifact' and r['target']['name'] == package]
        need(len(targets) == 1 and targets[0]['fresh'] is False, 'nonfresh compiler receipt ' + package)
    need(cargo[-1] == {'reason': 'build-finished', 'success': True}, 'build completed')
    return identity


def check():
    state = load(D / 'starting-state.json')
    updates = {'CHANGELOG.md', 'bench/README.md', 'docs/PERFORMANCE.md'}
    for name, digest in state['preserve'].items():
        if name not in updates:
            need(sha(ROOT / name) == digest, 'preserved file ' + name)
    for name, row in state['sources'].items():
        need(sha(D / row['source']) == row['sha256'], 'retained original ' + name)
        if not name.endswith('position_tests.rs'):
            need(sha(ROOT / name) == row['sha256'], 'shipping runtime unchanged ' + name)
    motion = 'crates/term/src/intake/motion.rs'
    need(sha(ROOT / motion) == sha(D / 'original-crates_term_src_intake_motion.rs'), 'shipping motion unchanged')
    position = 'crates/term/src/intake/position_tests.rs'
    live = (ROOT / position).read_bytes()
    original = (D / 'original-crates_term_src_intake_position_tests.rs').read_bytes()
    need(live.startswith(original) and live[len(original):].count(b'#[test]') == 4, 'four test-only additions')
    need(sha(ROOT / 'target/release/glass') == 'd75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c', 'selected shipping executable unchanged')
    outputs = {}
    for arm in ['control', 'candidate-v5']:
        build(arm)
        rows = load(D / (arm + '-tests.json'))
        need([r['label'] for r in rows] == ['height-' + str(h) for h in HISTORIES] + ['mixed-10000'], 'ordered test set')
        failures = []
        for row, capacity, wanted in zip(rows[:6], HISTORIES, CONTROL_FAILURES if arm == 'control' else [0] * 6):
            need(row['args'] == ['--exact', '--nocapture', 'intake::position_tests::height_snapshot_marker_picture_matrix'], 'height command')
            need(row['settings'] == {'GLASS_SCROLLBACK': str(capacity)}, 'height environment')
            need(row['exit'] == (101 if wanted else 0), 'height exit')
            path = D / row['log']
            need(path.name == arm + '-height-' + str(capacity) + '.log' and sha(path) == row['sha256'], 'height log hash')
            failures.append(height_observations(path.read_text(), capacity, wanted))
        row = rows[-1]
        need(row['args'] == ['--exact', '--nocapture', 'intake::position_tests::mixed_snapshot_marker_picture_matrix'] and row['settings'] == {'GLASS_SCROLLBACK': '10000'} and row['exit'] == 101, 'mixed command/exit')
        path = D / row['log']
        need(path.name == arm + '-mixed-10000.log' and sha(path) == row['sha256'], 'mixed log hash')
        mixed = mixed_observations(path.read_text(), 942 if arm == 'control' else 32)
        outputs[arm] = {'height_cases': 56160, 'height_failures': failures, 'mixed_cases': 3456, 'mixed_failures': mixed}
    final = build('final')
    for name, digest in final['source_sha256'].items():
        need(sha(ROOT / name) == digest, 'final live source binding')
    terminal = (D / 'final-terminal.log').read_text()
    need('test result: ok. 392 passed; 0 failed; 14 ignored; 0 measured; 0 filtered out;' in terminal, 'final test suite')
    for test in ['mixed_resize_round_trip_picture_defect_is_reproducible', 'truncated_tail_reflow_drops_unrelated_anchor_defect_is_reproducible']:
        need(f'test intake::position_tests::{test} ... ok' in terminal, 'new characterization executed')
    sweep = (D / 'final-sweep.log').read_text()
    need('swept 12800 streams over 64 seeds: no divergence' in sweep and 'test result: ok. 1 passed; 0 failed;' in sweep, 'final nonzero sweep')
    diagnostic = (D / 'control-round-trip.log').read_text()
    need('round-trip resize=8x5 base=9 history=9 pictures=[(0.0, 3.0)]' in diagnostic and 'round-trip resize=4x10 base=9 history=9 pictures=[]' in diagnostic and 'test result: FAILED. 0 passed; 1 failed;' in diagnostic, 'shipping desired-invariant failure')
    need(load(D / 'prior-checkpoint.json') == load(ROOT / 'bench/results/2026-11-03-movement-authority/checkpoint-post-commit.json'), 'prior exact checkpoint')
    return {'schema': 'glass.height-snapshot-checkpoint/v1', 'arms': outputs, 'final_tests': 392, 'ignored_tests': 14, 'final_sweep_streams': 12800, 'runtime_promoted': False, 'preserved_tracked_files': len(state['preserve']) - len(updates), 'selected_sha256': sha(ROOT / 'target/release/glass')}


if __name__ == '__main__':
    print(json.dumps(check(), indent=2, sort_keys=True))
