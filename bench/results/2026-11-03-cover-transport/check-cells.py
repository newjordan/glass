#!/usr/bin/env python3
"""Validate exact coverage observations against an independent per-cell oracle."""
import itertools
import json
import math
from pathlib import Path

D = Path(__file__).resolve().parent
FIELDS = {'fast', 'alternate', 'osc', 'start', 'height', 'top', 'bottom', 'n', 'down', 'mask', 'step', 'expected', 'got', 'pass'}

def need(ok, message):
    if not ok:
        raise ValueError(message)

def unique(pairs):
    result = {}
    for key, value in pairs:
        need(key not in result, 'duplicate JSON key')
        result[key] = value
    return result

def oracle(r):
    result = []
    for row in range(r['height']):
        for col in range(3):
            hidden = (col == row % 3) if r['mask'] == 0 else ((col != row % 3) if r['mask'] == 1 else row % 2 == 0)
            if hidden:
                continue
            y = r['start'] + row
            for step in range(1, r['step'] + 1):
                down = r['down'] if step < 3 else not r['down']
                if r['top'] <= y < r['bottom']:
                    y += r['n'] if down else -r['n']
                    if not r['top'] <= y < r['bottom']:
                        break
            else:
                result.append([y, col, (col + .5) / 3, (row + .5) / r['height']])
    return sorted(result)

def cells(value):
    need(type(value) is list, 'cell set is not a list')
    for cell in value:
        need(type(cell) is list and len(cell) == 4, 'invalid cell shape')
        need(all(type(x) in (int, float) and math.isfinite(x) for x in cell), 'invalid coordinate')
    need(value == sorted(value), 'unsorted cells')
    return value

def close(a, b):
    return len(a) == len(b) and all(abs(x - y) < .001 for ac, bc in zip(a, b) for x, y in zip(ac, bc))

def validate_records(rows, arm):
    need(arm in ('control', 'candidate'), 'unknown arm')
    keys = set()
    failures = [0] * 4
    total = [0] * 4
    for r in rows:
        need(type(r) is dict and set(r) == FIELDS, 'invalid record fields')
        for key in ('fast', 'alternate', 'osc', 'down', 'pass'):
            need(type(r[key]) is bool, 'invalid boolean')
        for key in ('start', 'height', 'top', 'bottom', 'n', 'mask', 'step'):
            need(type(r[key]) is int, 'invalid integer')
        key = tuple(r[k] for k in ('fast', 'alternate', 'osc', 'start', 'height', 'top', 'bottom', 'n', 'down', 'mask', 'step'))
        need(key not in keys, 'duplicate observation')
        keys.add(key)
        want = oracle(r)
        expected, got = cells(r['expected']), cells(r['got'])
        need(close(expected, want), 'expectation differs from independent oracle')
        matched = close(got, want)
        need(r['pass'] == matched, 'pass flag differs from coordinates')
        total[r['step']] += 1
        failures[r['step']] += not matched
    grid = set(itertools.product([False, True], [False, True], [False, True], [0, 3, 6], [2, 4, 6], [2, 4], [7, 9], [1, 2, 3], [False, True], [0, 1, 2], [0, 1, 2, 3]))
    grid = {k for k in grid if (k[5], k[6]) in ((2, 7), (4, 9))}
    need(keys == grid, 'incomplete or extra observation grid')
    need(failures[0] == 0, 'invalid intake setup')
    if arm == 'candidate':
        need(sum(failures) == 0, 'candidate cells differ')
    else:
        need(all(x > 0 for x in failures[1:]), 'control did not reproduce coverage loss')
    return {'observations': len(keys), 'cases': total[0], 'total_by_step': total, 'failures_by_step': failures}

def parse(raw):
    return [json.loads(line.split('cover-transport-json ', 1)[1], object_pairs_hook=unique)
            for line in raw.splitlines() if 'cover-transport-json ' in line]

def main():
    print(json.dumps({arm: validate_records(parse((D / (arm + '.log')).read_text()), arm)
                      for arm in ('control', 'candidate')}, indent=2))

if __name__ == '__main__':
    main()
