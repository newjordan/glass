#!/usr/bin/env python3
"""Replay the prospectively fixed screen; do not tune thresholds or pool runs."""
import importlib.util
import json
from pathlib import Path

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
spec = importlib.util.spec_from_file_location('authority_engine', ROOT / 'bench/replay-engine-pairs.py')
engine = importlib.util.module_from_spec(spec)
spec.loader.exec_module(engine)


def analyze(report):
    summary = engine.validate(report, verify_binaries=True, expected_pairs=11)
    expected = {'ascii', 'unicode', 'truecolor', 'cursor_motion', 'scroll_region', 'tui_frames'}
    engine.require(set(summary) == expected, 'requires all six workloads')
    engine.require(report['settings'] == {'GLASS_BENCH_SCALE': '2.0', 'GLASS_BENCH_ROUNDS': '5',
        'GLASS_BENCH_ONLY': 'ascii,unicode,truecolor,cursor_motion,scroll_region,tui_frames'}, 'wrong settings')
    # Holm across all six tested workloads. Serial AB/BA signs need not be
    # independent; this is an operational screen, not a causal confidence bound.
    adjusted = {}
    running = 0.
    ordered = sorted(summary, key=lambda name: (summary[name]['sign_p_two_sided'], name))
    for rank, name in enumerate(ordered):
        running = max(running, min(1., (len(ordered) - rank) * summary[name]['sign_p_two_sided']))
        adjusted[name] = running
    rows = {name: dict(row, holm_p=adjusted[name]) for name, row in summary.items()}
    targets = [name for name in ('ascii', 'scroll_region') if rows[name]['median_cpu_ratio'] >= 1.02
               and rows[name]['wins'] > rows[name]['losses'] and rows[name]['holm_p'] < .05]
    regressions = [name for name in sorted(rows) if rows[name]['median_cpu_ratio'] < .98]
    return dict(schema='glass.parser-authority-decision/v1', summary=rows, cleared_targets=targets,
                point_regression_guards_failed=regressions,
                engine_screen_cleared=bool(targets) and not regressions, runtime_promotion=False,
                note='Engine diagnostic only; no equivalence, causality, terminal throughput or championship acceptance.')


if __name__ == '__main__':
    print(json.dumps(analyze(json.loads((D / 'engine-pairs.json').read_text(),
                                      object_pairs_hook=engine.unique_object)), indent=2))
