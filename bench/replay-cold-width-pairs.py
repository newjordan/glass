#!/usr/bin/env python3
"""Read-only replay of cold-width-pairs/v1; consistency, not timing accuracy.

Each process must run exactly the named ignored test and emit one diagnostic.
PID/timestamp checks catch duplicate or overlapping captures, not fabricated logs.
Thread CPU and wall spans include timer overhead. maxrss is a process high-water
mark; its delta is NOT current RSS and cannot establish retained-memory savings.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import statistics

ARMS = ('base', 'candidate')
TEST = 'engine::tests::width_cache_cold_first_lookup'
FIELDS = ('cpu_ns', 'wall_ns', 'minor_faults', 'maxrss_delta_kib')


def require(condition, message):
    if not condition:
        raise ValueError(message)


def unique_object(pairs):
    out = {}
    for key, value in pairs:
        require(key not in out, f'duplicate JSON key: {key}')
        out[key] = value
    return out


def integer(value, minimum):
    return type(value) is int and value >= minimum


def validate(report, verify_binaries=False, expected_pairs=None):
    require(set(report) == {'schema', 'test', 'binaries', 'pairs', 'complete', 'unchanged_binaries'},
            'incomplete/unknown report fields')
    require(report['schema'] == 'glass.cold-width-pairs/v1' and report['test'] == TEST, 'wrong schema/test')
    require(report['complete'] is True and report['unchanged_binaries'] is True, 'incomplete/changed binaries')
    binaries = report['binaries']
    require(set(binaries) == set(ARMS), 'wrong arms')
    for arm, entry in binaries.items():
        require(set(entry) == {'path', 'sha256'}, f'wrong binary fields: {arm}')
        require(isinstance(entry['path'], str) and Path(entry['path']).is_absolute(), 'bad path')
        require(isinstance(entry['sha256'], str) and re.fullmatch(r'[a-f0-9]{64}', entry['sha256']), 'bad hash')
        if verify_binaries:
            require(hashlib.sha256(Path(entry['path']).read_bytes()).hexdigest() == entry['sha256'],
                    f'changed binary: {arm}')
    pairs = report['pairs']
    require(isinstance(pairs, list) and bool(pairs), 'no pairs')
    require(expected_pairs is None or len(pairs) == expected_pairs, 'wrong pair count')
    metrics = {arm: {field: [] for field in FIELDS} for arm in ARMS}
    pids, last_end = set(), 0
    for i, pair in enumerate(pairs):
        require(set(pair) == {'order', *ARMS}, f'incomplete pair: {i}')
        order = list(ARMS if i % 2 == 0 else reversed(ARMS))
        require(pair['order'] == order, f'wrong order: {i}')
        for arm in order:
            row = pair[arm]
            require(set(row) == {'pid', 'begin_ns', 'end_ns', 'exit', 'stdout', 'stderr'}, f'bad run fields: {i}/{arm}')
            require(type(row['exit']) is int and row['exit'] == 0, f'failed exit: {i}/{arm}')
            require(integer(row['pid'], 1) and row['pid'] not in pids, 'duplicate/invalid pid')
            pids.add(row['pid'])
            require(integer(row['begin_ns'], 1) and integer(row['end_ns'], 1) and
                    last_end <= row['begin_ns'] < row['end_ns'], 'overlapping/invalid timing')
            last_end = row['end_ns']
            require(isinstance(row['stdout'], str) and isinstance(row['stderr'], str), 'bad raw output')
            require(re.findall(r'^running .*$', row['stdout'], re.M) == ['running 1 test'] and
                    re.findall(r'^test (\S+) \.\.\. (\S+)$', row['stdout'], re.M) == [(TEST, 'ok')] and
                    len(re.findall(r'^test result:', row['stdout'], re.M)) == 1 and
                    re.search(r'^test result: ok\. 1 passed; 0 failed; 0 ignored; 0 measured; \d+ filtered out;', row['stdout'], re.M),
                    f'not exactly one successful test: {i}/{arm}')
            markers = re.findall(r'^COLD_WIDTH_V1 (.*)$', row['stderr'], re.M)
            require(len(markers) == 1, f'missing/duplicate cold marker: {i}/{arm}')
            raw = json.loads(markers[0], object_pairs_hook=unique_object)
            require(set(raw) == {'codepoint', 'width', *FIELDS}, 'wrong marker fields')
            require(type(raw['codepoint']) is int and raw['codepoint'] == 30028 and
                    type(raw['width']) is int and raw['width'] == 2, 'changed scalar/width')
            for field in FIELDS:
                require(integer(raw[field], 1 if field.endswith('_ns') else 0), f'invalid {field}')
                metrics[arm][field].append(raw[field])
            require(max(raw['cpu_ns'], raw['wall_ns']) <= row['end_ns'] - row['begin_ns'],
                    'diagnostic span exceeds process span')
    summaries = {}
    for field in FIELDS:
        base, candidate = metrics['base'][field], metrics['candidate'][field]
        deltas = [c - b for b, c in zip(base, candidate)]
        result = dict(base_median=statistics.median(base), candidate_median=statistics.median(candidate),
                      paired_median_delta=statistics.median(deltas),
                      candidate_lower=sum(c < b for b, c in zip(base, candidate)),
                      candidate_higher=sum(c > b for b, c in zip(base, candidate)),
                      ties=sum(c == b for b, c in zip(base, candidate)))
        if field.endswith('_ns'):
            result['paired_median_candidate_over_base'] = statistics.median(c / b for b, c in zip(base, candidate))
        summaries[field] = result
    return dict(schema='glass.cold-width-replay/v1', pairs=len(pairs), processes=len(pids), metrics=summaries,
                note='Descriptive fixed-series diagnostic, no terminal/startup or retained-RSS claim. '
                     'Clock overhead and shared-host variation remain; maxrss is high-water only.')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('report', type=Path)
    parser.add_argument('--pairs', type=int)
    parser.add_argument('--verify-binaries', action='store_true')
    args = parser.parse_args()
    if args.pairs is not None and args.pairs <= 0:
        parser.error('--pairs must be positive')
    report = json.loads(args.report.read_bytes(), object_pairs_hook=unique_object)
    print(json.dumps(validate(report, args.verify_binaries, args.pairs), indent=2, allow_nan=False))


if __name__ == '__main__':
    main()
