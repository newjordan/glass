#!/usr/bin/env python3
"""Read-only prospective engine screen; does not grant terminal promotion."""
import hashlib
import importlib.util
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
PROTOCOL_SHA = 'd1cdcc86a5fe9e4ff36ff9ba82e648e0a74de222412b5bfeb6a3de3c5b07cdcc'


def load(path):
    return json.loads(path.read_text(), object_pairs_hook=replay.unique_object)


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def holm(rows):
    ordered = sorted(rows, key=lambda name: (rows[name]['sign_p_two_sided'], name))
    corrected, running = {}, 0.
    for i, name in enumerate(ordered):
        running = max(running, min(1., (len(ordered) - i) * rows[name]['sign_p_two_sided']))
        corrected[name] = running
    return corrected


spec = importlib.util.spec_from_file_location('replay', ROOT / 'bench/replay-engine-pairs.py')
replay = importlib.util.module_from_spec(spec)
spec.loader.exec_module(replay)


def analyze():
    assert digest(HERE / 'protocol.json') == PROTOCOL_SHA, 'protocol changed'
    report = load(HERE / 'engine-pairs.json')
    assert report['settings'] == {
        'GLASS_BENCH_SCALE': '2.0', 'GLASS_BENCH_ROUNDS': '5',
        'GLASS_BENCH_ONLY': 'ascii,unicode,truecolor,cursor_motion,scroll_region,tui_frames'}, 'wrong settings'
    rows = replay.validate(report, verify_binaries=True, expected_pairs=11)
    assert set(rows) == replay.WORKLOADS
    identities = load(HERE / 'engine-identities.json')
    for path, expected in identities.items():
        assert digest(Path(path)) == expected, f'identity changed: {path}'
    for arm in ('base', 'candidate'):
        assert identities[report['binaries'][arm]['path']] == report['binaries'][arm]['sha256']
    adjusted = holm(rows)
    decisions = {
        'unicode_median_at_least_1_02': rows['unicode']['median_cpu_ratio'] >= 1.02,
        'unicode_positive_direction': rows['unicode']['wins'] > rows['unicode']['losses'],
        'unicode_six_workload_holm_below_0_05': adjusted['unicode'] < .05,
        'all_six_point_ratios_at_least_0_98': all(r['median_cpu_ratio'] >= .98 for r in rows.values()),
    }
    return dict(schema='glass.width-handle-engine-decision/v1', pairs=11,
                protocol_sha256=PROTOCOL_SHA, report_sha256=digest(HERE / 'engine-pairs.json'),
                metrics={n: dict(**rows[n], holm_p=adjusted[n]) for n in sorted(rows)},
                criteria=decisions, engine_screen_cleared=all(decisions.values()),
                runtime_promotion=False,
                note='Diagnostic CPU-throughput screen, not terminal timing or every-metric acceptance. '
                     'Alternation does not establish iid round signs; no pooling or rescue series.')


if __name__ == '__main__':
    print(json.dumps(analyze(), indent=2))
