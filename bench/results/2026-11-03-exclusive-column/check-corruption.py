#!/usr/bin/env python3
"""Reject disposable report corruptions without writing canonical evidence."""
import copy
import hashlib
import importlib.util
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
spec = importlib.util.spec_from_file_location('replay_corruption', ROOT / 'bench/replay-engine-pairs.py')
replay = importlib.util.module_from_spec(spec)
spec.loader.exec_module(replay)


def check():
    path = HERE / 'engine-pairs.json'
    before = path.read_bytes()
    original = json.loads(before, object_pairs_hook=replay.unique_object)
    mutations = {
        'truncated_pairs': lambda r: r['pairs'].pop(),
        'summary_ratio': lambda r: r['summary']['unicode'].update(median_cpu_ratio=1.2),
        'parsed_without_raw': lambda r: r['pairs'][0]['candidate']['results']['unicode'].update(mb_cpu_s=1.),
        'duplicate_row': lambda r: r['pairs'][0]['candidate'].update(stderr=r['pairs'][0]['candidate']['stderr'] * 2),
        'wrong_order': lambda r: r['pairs'][0].update(order=['candidate', 'base']),
        'changed_binary_hash': lambda r: r['binaries']['candidate'].update(sha256='0' * 64),
        'nonzero_exit': lambda r: r['pairs'][0]['candidate'].update(exit=101),
        'workload_shape': lambda r: r['pairs'][0]['candidate']['results']['unicode'].update(read=17),
    }
    cases = []
    for name, mutate in mutations.items():
        report = copy.deepcopy(original)
        mutate(report)
        try:
            replay.validate(report, verify_binaries=True, expected_pairs=11)
        except (ValueError, KeyError) as exc:
            cases.append(dict(case=name, rejected=True, reason=str(exc)))
        else:
            raise ValueError(f'accepted corruption: {name}')
    try:
        json.loads('{"pairs":[],"pairs":[]}', object_pairs_hook=replay.unique_object)
    except ValueError as exc:
        cases.append(dict(case='duplicate_json_key', rejected=True, reason=str(exc)))
    else:
        raise ValueError('accepted duplicate JSON key')
    assert path.read_bytes() == before, 'canonical data changed'
    return dict(schema='glass.exclusive-column-corruption/v1', cases=cases,
                report_sha256=hashlib.sha256(before).hexdigest(), canonical_report_unchanged=True)


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
