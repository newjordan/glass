#!/usr/bin/env python3
"""Disposable in-memory corruption challenges. Never rewrite canonical evidence."""
import copy
import hashlib
import importlib.util
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value


def check():
    engine = module('static_corrupt_engine', ROOT / 'bench/replay-engine-pairs.py')
    cold = module('static_corrupt_cold', ROOT / 'bench/replay-cold-width-pairs.py')
    paths = {kind: HERE / (kind + '-pairs.json') for kind in ('engine', 'cold')}
    before = {kind: path.read_bytes() for kind, path in paths.items()}
    engine_mutations = {
        'truncated_pairs': lambda r: r['pairs'].pop(),
        'summary_ratio': lambda r: r['summary']['unicode'].update(median_cpu_ratio=1.2),
        'parsed_without_raw': lambda r: r['pairs'][0]['candidate']['results']['unicode'].update(mb_cpu_s=1.),
        'duplicate_row': lambda r: r['pairs'][0]['candidate'].update(stderr=r['pairs'][0]['candidate']['stderr'] * 2),
        'wrong_order': lambda r: r['pairs'][0].update(order=['candidate', 'base']),
        'changed_binary_hash': lambda r: r['binaries']['candidate'].update(sha256='0' * 64),
        'nonzero_exit': lambda r: r['pairs'][0]['candidate'].update(exit=101),
        'workload_shape': lambda r: r['pairs'][0]['candidate']['results']['unicode'].update(read=17),
    }
    cold_mutations = {
        'truncated_pairs': lambda r: r['pairs'].pop(),
        'incomplete': lambda r: r.update(complete=False),
        'changed_binaries_flag': lambda r: r.update(unchanged_binaries=False),
        'wrong_test': lambda r: r.update(test='wrong'),
        'wrong_order': lambda r: r['pairs'][0].update(order=['candidate', 'base']),
        'nonzero_exit': lambda r: r['pairs'][0]['candidate'].update(exit=1),
        'zero_tests': lambda r: r['pairs'][0]['candidate'].update(stdout='running 0 tests\n'),
        'duplicate_test_receipt': lambda r: r['pairs'][0]['candidate'].update(stdout=r['pairs'][0]['candidate']['stdout'] * 2),
        'duplicate_marker': lambda r: r['pairs'][0]['candidate'].update(stderr=r['pairs'][0]['candidate']['stderr'] * 2),
        'duplicate_pid': lambda r: r['pairs'][0]['candidate'].update(pid=r['pairs'][0]['base']['pid']),
        'overlapping_processes': lambda r: r['pairs'][0]['candidate'].update(begin_ns=r['pairs'][0]['base']['begin_ns']),
        'diagnostic_span_exceeds_process': lambda r: r['pairs'][0]['candidate'].update(end_ns=r['pairs'][0]['candidate']['begin_ns'] + 1),
        'changed_binary_hash': lambda r: r['binaries']['candidate'].update(sha256='0' * 64),
    }
    cases = []
    for kind, checker, mutations, pairs in [('engine', engine, engine_mutations, 11),
                                            ('cold', cold, cold_mutations, 15)]:
        unique = engine.unique_object if kind == 'engine' else cold.unique_object
        original = json.loads(before[kind], object_pairs_hook=unique)
        for name, mutate in mutations.items():
            report = copy.deepcopy(original)
            mutate(report)
            try:
                checker.validate(report, verify_binaries=True, expected_pairs=pairs)
            except (ValueError, KeyError) as exc:
                cases.append(dict(kind=kind, case=name, rejected=True, reason=str(exc)))
            else:
                raise ValueError(f'accepted corruption: {kind}/{name}')
        try:
            json.loads('{"pairs":[],"pairs":[]}', object_pairs_hook=unique)
        except ValueError as exc:
            cases.append(dict(kind=kind, case='duplicate_json_key', rejected=True, reason=str(exc)))
        else:
            raise ValueError(f'accepted duplicate JSON key: {kind}')
    assert all(path.read_bytes() == before[kind] for kind, path in paths.items())
    return dict(schema='glass.static-width-corruption/v1', cases=cases,
                sha256={kind: hashlib.sha256(data).hexdigest() for kind, data in before.items()},
                canonical_reports_unchanged=True)


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
