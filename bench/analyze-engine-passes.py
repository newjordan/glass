#!/usr/bin/env python3
"""Validate engine-pass JSONL against caller-owned shape; descriptive only.

Nanoseconds are clock readings, not an accuracy or independence guarantee.
Never use the fastest wall pass as though it also had the fastest CPU time.
"""
import argparse
import json
import math
from pathlib import Path
import statistics

FIELDS = {'schema', 'workload', 'pass', 'rounds', 'bytes', 'read', 'wall_ns', 'cpu_ns'}


def need(ok, message):
    if not ok:
        raise ValueError(message)


def unique(pairs):
    result = {}
    for key, value in pairs:
        need(key not in result, 'duplicate JSON key: ' + key)
        result[key] = value
    return result


def integer(x):
    return type(x) is int and 0 < x <= 2**64 - 1


def parse(text, shapes, rounds=3, read=4095):
    """Require exactly the specified workloads, in order, with contiguous passes."""
    need(integer(rounds) and integer(read), 'invalid expected rounds/read')
    need(type(shapes) is dict and bool(shapes), 'empty expected shape')
    need(all(type(n) is str and n and integer(b) for n, b in shapes.items()), 'invalid expected shape')
    lines = text.splitlines()
    need(len(lines) == len(shapes) * rounds, 'missing/extra pass records')
    expected = [(name, p) for name in shapes for p in range(rounds)]
    rows = {name: [] for name in shapes}
    for line, (name, p) in zip(lines, expected):
        row = json.loads(line, object_pairs_hook=unique)
        need(type(row) is dict and set(row) == FIELDS, 'invalid pass fields')
        need(row['schema'] == 'glass.engine-pass/v1', 'unknown pass schema')
        need(row['workload'] == name and type(row['workload']) is str, 'missing/reordered workload')
        need(type(row['pass']) is int and row['pass'] == p, 'missing/reordered pass')
        need(integer(row['rounds']) and row['rounds'] == rounds, 'changed rounds')
        need(integer(row['bytes']) and row['bytes'] == shapes[name], 'changed payload length')
        need(integer(row['read']) and row['read'] == read, 'changed read')
        need(integer(row['wall_ns']) and integer(row['cpu_ns']), 'invalid duration')
        rows[name].append(row)
    return rows


def describe(rows):
    out = {}
    for name, passes in rows.items():
        best_wall = min(range(len(passes)), key=lambda p: passes[p]['wall_ns'])
        best_cpu = min(range(len(passes)), key=lambda p: passes[p]['cpu_ns'])
        item = {'best_wall_pass': best_wall, 'best_cpu_pass': best_cpu,
                'minima_on_different_passes': best_wall != best_cpu}
        for clock in ('wall', 'cpu'):
            durations = [r[clock + '_ns'] for r in passes]
            med = statistics.median(durations)
            item[clock] = dict(ns=durations, min_ns=min(durations), median_ns=med,
                               max_ns=max(durations), median_over_min=med/min(durations),
                               median_mb_s=passes[0]['bytes']*1000/med,
                               min_mb_s=passes[0]['bytes']*1000/min(durations))
        out[name] = item
    return out


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('samples', type=Path)
    p.add_argument('--manifest', type=Path, required=True, help='caller-authenticated fixed-corpus manifest')
    p.add_argument('--rounds', type=int, default=3)
    p.add_argument('--read', type=int, default=4095)
    args = p.parse_args()
    manifest = json.loads(args.manifest.read_text(), object_pairs_hook=unique)
    shapes = {name: item['bytes'] for name, item in manifest['workloads'].items()}
    rows = parse(args.samples.read_text(), shapes, args.rounds, args.read)
    print(json.dumps(dict(schema='glass.engine-pass-description/v1', workloads=describe(rows),
                         limits='Descriptive paired-clock pass data; not a score, accuracy certificate, significance or runtime-promotion gate.'), indent=2, allow_nan=False))


if __name__ == '__main__':
    main()
