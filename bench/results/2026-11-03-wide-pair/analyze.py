#!/usr/bin/env python3
"""Read-only replay of raw sessions and protocol, no producer or model calls."""
from datetime import datetime
import hashlib
import json
import math
from pathlib import Path
import re
import statistics

D = Path(__file__).resolve().parent


def unique(pairs):
    result = {}
    for key, value in pairs:
        need(key not in result, 'duplicate JSON key: ' + key)
        result[key] = value
    return result


def load(path):
    return json.loads(Path(path).read_text(), object_pairs_hook=unique)


LINE = re.compile(r'^\s*(\w+):\s+([\d.]+) MB/s\s+([\d.]+) MB/cpu-s\s+\((\d+) bytes, read (\d+)\)', re.M)


def need(ok, message):
    if not ok:
        raise ValueError(message)


def analyze(raw, protocol=None):
    protocol = protocol or load(D / 'protocol.json')
    p = protocol['engine']
    need(raw['schema'] == 'glass.wide-pair-raw/v1', 'schema')
    need(raw['protocol_sha256'] == hashlib.sha256((D / 'protocol.json').read_bytes()).hexdigest(), 'protocol hash')
    settings = dict(GLASS_BENCH_SCALE=str(float(p['scale'])), GLASS_BENCH_ROUNDS=str(p['rounds']),
                    GLASS_BENCH_READ=str(p['read']), GLASS_BENCH_ONLY=','.join(p['workloads']))
    need(raw['settings'] == settings, 'settings')
    need(raw['binaries'] == load(D / 'binaries.json') and set(raw['binaries']) == set(protocol['arms']), 'binary identities')
    for arm, entry in raw['binaries'].items():
        need(entry['path'] == f'/tmp/glass-wide-pair-{arm}-test', 'binary path')
        need(hashlib.sha256(Path(entry['path']).read_bytes()).hexdigest() == entry['sha256'], 'changed binary')
    rows = raw['sessions']
    need(len(rows) == p['blocks'] * 2, 'incomplete sessions')
    table, shapes = {}, {}
    previous = -1
    for i, row in enumerate(rows):
        block, slot = divmod(i, 2)
        arm = p['orders'][block % len(p['orders'])][slot]
        need((row['block'], row['slot'], row['arm']) == (block, slot, arm), 'order')
        need(row['argv'] == [raw['binaries'][arm]['path'], '--ignored', '--exact', '--nocapture', 'speed::speed'], 'argv')
        need(type(row['start_ns']) is int and type(row['end_ns']) is int and row['start_ns'] >= previous and row['end_ns'] > row['start_ns'], 'overlap/time')
        need(isinstance(row['started_utc'], str) and re.fullmatch(r'\d{4}-\d\d-\d\dT.+\+00:00', row['started_utc']), 'missing UTC')
        need(datetime.fromisoformat(row['started_utc']).utcoffset().total_seconds() == 0, 'not UTC')
        previous = row['end_ns']
        census = re.findall(r'^test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', row['stdout'], re.M)
        need(type(row['exit']) is int and row['exit'] == 0 and census == [('ok', '1', '0', '0')], 'session failure/census')
        matches = LINE.findall(row['stderr'])
        need(len(matches) == len(p['workloads']) and {x[0] for x in matches} == set(p['workloads']), 'workloads')
        parsed = {}
        for name, wall, cpu, size, read in matches:
            wall, cpu, size, read = float(wall), float(cpu), int(size), int(read)
            need(math.isfinite(cpu) and math.isfinite(wall) and min(cpu, wall, size) > 0, 'nonpositive/nonfinite result')
            need(read == p['read'], 'read size')
            shape = (size, read)
            need(shapes.setdefault(name, shape) == shape, 'workload shape drift')
            parsed[name] = dict(cpu=cpu, wall=wall, bytes=size, read=read)
        table[block, arm] = parsed
    summary = {}
    for name in sorted(p['workloads']):
        ratios = [table[b, 'candidate'][name]['cpu'] / table[b, 'control'][name]['cpu'] for b in range(p['blocks'])]
        walls = [table[b, 'candidate'][name]['wall'] / table[b, 'control'][name]['wall'] for b in range(p['blocks'])]
        wins, losses = sum(r > 1 for r in ratios), sum(r < 1 for r in ratios)
        n = wins + losses
        pv = min(1., 2 * sum(math.comb(n, k) for k in range(min(wins, losses) + 1)) / 2 ** n)
        summary[name] = dict(cpu_ratios=ratios, median_cpu_ratio=statistics.median(ratios),
                             median_wall_ratio=statistics.median(walls), wins=wins, losses=losses, sign_p_two_sided=pv)
    running = 0.
    for rank, name in enumerate(sorted(summary, key=lambda n: summary[n]['sign_p_two_sided'])):
        running = max(running, min(1., (len(summary) - rank) * summary[name]['sign_p_two_sided']))
        summary[name]['holm_p'] = running
    failed = [n for n, v in summary.items() if v['median_cpu_ratio'] < .98]
    uni = summary['unicode']
    target = uni['median_cpu_ratio'] >= 1.02 and uni['wins'] > uni['losses'] and uni['holm_p'] < .05
    return dict(schema='glass.wide-pair-analysis/v1', blocks=p['blocks'], sessions=len(rows), summary=summary,
                engine_screen_cleared=target and not failed, point_regression_guards_failed=failed, unicode_target_cleared=target,
                runtime_promotion=False, note='Operational engine screen, not proof of noninferiority, mechanism, terminal/Ghostty throughput or championship. Best-of-five invocations are not five independent trials. Sign tests assume independent fair signs; balanced sequential order does not establish independence.')


if __name__ == '__main__':
    print(json.dumps(analyze(load(D / 'raw.json')), indent=2))
