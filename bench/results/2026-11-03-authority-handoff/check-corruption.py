#!/usr/bin/env python3
"""Mutate disposable report objects; reject them, leave source evidence intact."""
import copy
import hashlib
import importlib.util
import json
from pathlib import Path

D = Path(__file__).resolve().parent
ROOT = D.parents[2]


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def check():
    replay = module('handoff_corruption_engine', ROOT / 'bench/replay-engine-pairs.py')
    arm = module('handoff_corruption_arm', ROOT / 'bench/build-engine-arm.py')
    paths = [D / 'engine-pairs.json'] + [D / f'build-{name}/cargo.jsonl'
             for name in ('control', 'candidate', 'mutant', 'restored')]
    before = {str(p): p.read_bytes() for p in paths}
    original = json.loads(before[str(paths[0])], object_pairs_hook=replay.unique_object)
    mutations = {
        'truncated_pairs': lambda r: r['pairs'].pop(),
        'summary_ratio': lambda r: r['summary']['ascii'].update(median_cpu_ratio=2.),
        'parsed_without_raw': lambda r: r['pairs'][0]['candidate']['results']['unicode'].update(mb_cpu_s=1.),
        'duplicate_row': lambda r: r['pairs'][0]['candidate'].update(stderr=r['pairs'][0]['candidate']['stderr'] * 2),
        'wrong_order': lambda r: r['pairs'][0].update(order=['candidate', 'base']),
        'failed_exit': lambda r: r['pairs'][0]['base'].update(exit=101),
        'wrong_binary': lambda r: r['binaries']['base'].update(sha256='0' * 64),
        'wrong_shape': lambda r: r['pairs'][0]['candidate']['results']['ascii'].update(read=1),
        'missing_summary': lambda r: r.pop('summary'),
    }
    cases = []
    for name, change in mutations.items():
        report = copy.deepcopy(original)
        change(report)
        try:
            replay.validate(report, verify_binaries=True, expected_pairs=11)
        except (ValueError, KeyError) as exc:
            cases.append(dict(case=name, rejected=True, reason=str(exc)))
        else:
            raise ValueError(f'accepted corruption: {name}')
    try:
        json.loads('{"pairs":[],"pairs":[]}', object_pairs_hook=replay.unique_object)
    except ValueError as exc:
        cases.append(dict(case='duplicate_key', rejected=True, reason=str(exc)))
    else:
        raise ValueError('accepted duplicate key')
    for kind, path in zip(('control', 'candidate', 'mutant', 'restored'), paths[1:]):
        rows = [json.loads(line) for line in before[str(path)].decode().splitlines()]
        arm.select(rows)
        # Exactly one stale package per challenge: diagnostic is deterministic
        # despite set iteration order. No broad diagnostic normalization.
        for name in ('vte', 'glass', 'alacritty_terminal'):
            mutated = copy.deepcopy(rows)
            for row in mutated:
                if row.get('reason') == 'compiler-artifact' and row['target']['name'] == name:
                    row['fresh'] = True
            try:
                arm.select(mutated)
            except ValueError as exc:
                cases.append(dict(case=f'{kind}_stale_{name}', rejected=True, reason=str(exc)))
            else:
                raise ValueError(f'accepted stale build: {kind}/{name}')
    if not all(p.read_bytes() == before[str(p)] for p in paths):
        raise ValueError('changed canonical evidence')
    return dict(schema='glass.authority-handoff-corruption/v1', cases=cases,
                canonical_reports_unchanged=True,
                sha256={name: hashlib.sha256(raw).hexdigest() for name, raw in before.items()})


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
