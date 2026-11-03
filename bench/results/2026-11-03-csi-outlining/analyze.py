#!/usr/bin/env python3
"""Independent raw replay of fixed factorial schedule/metrics, not measurement accuracy."""
from collections import Counter
import hashlib
import importlib.util
import json
import math
from pathlib import Path
import re
import statistics

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
spec = importlib.util.spec_from_file_location('pairs', ROOT / 'bench/replay-engine-pairs.py')
pairs = importlib.util.module_from_spec(spec)
spec.loader.exec_module(pairs)
need = pairs.require
load = lambda p: json.loads(Path(p).read_text(), object_pairs_hook=pairs.unique_object)
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()


def summary(ratios):
    wins, losses = sum(r > 1 for r in ratios), sum(r < 1 for r in ratios)
    n = wins + losses
    p = min(1., 2 * sum(math.comb(n, k) for k in range(min(wins, losses) + 1)) / 2 ** n)
    return dict(ratios=ratios, median_cpu_ratio=statistics.median(ratios), wins=wins, losses=losses,
                sign_p_two_sided=p, min=min(ratios), max=max(ratios))


def analyze(report, verify_binaries=True):
    protocol = load(D / 'protocol.json')
    p = protocol['engine']
    need(report['schema'] == 'glass.csi-factorial-raw/v1', 'wrong schema')
    need(report['protocol_sha256'] == sha(D / 'protocol.json'), 'changed protocol')
    need(report['settings'] == dict(GLASS_BENCH_SCALE='2.0', GLASS_BENCH_ROUNDS='5', GLASS_BENCH_READ='4095', GLASS_BENCH_ONLY=','.join(p['workloads'])), 'wrong settings')
    binaries = load(D / 'binaries.json')
    need(report['binaries'] == binaries and set(binaries) == set(protocol['arms']), 'wrong arms')
    for arm, entry in binaries.items():
        need(entry['path'] == f'/tmp/glass-i26-{arm}-test', 'wrong binary path')
        if verify_binaries:
            need(sha(entry['path']) == entry['sha256'], 'changed binary')
    rows = report['sessions']
    need(len(rows) == 4 * p['blocks'] == 48, 'incomplete/extra sessions')
    table, shapes, last_end = {}, {}, 0
    slots, predecessors = Counter(), Counter()
    for i, row in enumerate(rows):
        block, slot = divmod(i, 4)
        arm = p['orders'][block % len(p['orders'])][slot]
        need((row['block'], row['slot'], row['arm']) == (block, slot, arm), 'wrong schedule')
        need(row['argv'] == [binaries[arm]['path'], '--ignored', '--exact', '--nocapture', 'speed::speed'], 'wrong argv')
        need(type(row['exit']) is int and row['exit'] == 0, 'nonzero/noninteger exit')
        need(type(row['start_ns']) is int and type(row['end_ns']) is int and last_end <= row['start_ns'] < row['end_ns'], 'invalid/overlapping launch interval')
        need(isinstance(row['started_utc'], str) and re.fullmatch(r'\d{4}-\d\d-\d\dT.+\+00:00', row['started_utc']), 'missing UTC provenance')
        last_end = row['end_ns']
        results = re.findall(r'^test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', row['stdout'], re.M)
        need(results == [('ok', '1', '0', '0')], 'wrong/missing/duplicate test census')
        matches = pairs.ROW.findall(row['stderr'])
        need(len(matches) == len(p['workloads']) and {m[0] for m in matches} == set(p['workloads']), 'missing/duplicate workloads')
        parsed = {}
        for name, wall, cpu, size, read in matches:
            wall, cpu, size, read = float(wall), float(cpu), int(size), int(read)
            need(all(math.isfinite(x) and x > 0 for x in (wall, cpu)) and size > 0 and read == p['read'], 'invalid metric/shape')
            need(shapes.setdefault(name, (size, read)) == (size, read), 'changed workload shape')
            parsed[name] = dict(cpu=cpu, wall=wall)
        table[block, arm] = parsed
        slots[arm, slot] += 1
        if slot:
            predecessors[p['orders'][block % 4][slot - 1], arm] += 1
    need(set(slots.values()) == {3} and len(slots) == 16, 'unbalanced slots')
    need(set(predecessors.values()) == {3} and len(predecessors) == 12, 'unbalanced predecessors')
    contrasts = {}
    for label, numerator, denominator in [
        ('primary', 'authority-outlined', 'control-inline'),
        ('authority_outline_effect', 'authority-outlined', 'authority-inline'),
        ('control_outline_effect', 'control-outlined', 'control-inline'),
        ('authority_inline_effect', 'authority-inline', 'control-inline')]:
        contrasts[label] = {name: summary([table[b, numerator][name]['cpu'] / table[b, denominator][name]['cpu'] for b in range(p['blocks'])]) for name in p['workloads']}
    primary = contrasts['primary']
    running = 0.
    for rank, name in enumerate(sorted(primary, key=lambda n: (primary[n]['sign_p_two_sided'], n))):
        running = max(running, min(1., (len(primary) - rank) * primary[name]['sign_p_two_sided']))
        primary[name]['holm_p'] = running
    targets = [n for n in ('ascii', 'scroll_region') if primary[n]['median_cpu_ratio'] >= 1.02 and primary[n]['wins'] > primary[n]['losses'] and primary[n]['holm_p'] < .05]
    regressions = [n for n in sorted(primary) if primary[n]['median_cpu_ratio'] < .98]
    interaction = {name: summary([table[b, 'authority-outlined'][name]['cpu'] / table[b, 'authority-inline'][name]['cpu'] / (table[b, 'control-outlined'][name]['cpu'] / table[b, 'control-inline'][name]['cpu']) for b in range(p['blocks'])]) for name in p['workloads']}
    return dict(schema='glass.csi-factorial-analysis/v1', blocks=p['blocks'], sessions=len(rows), contrasts=contrasts,
                interaction_ratio_of_ratios=interaction, cleared_targets=targets, point_regression_guards_failed=regressions,
                engine_screen_cleared=bool(targets) and not regressions, runtime_promotion=False,
                note='Operational engine screen and descriptive interaction only. No causal identification, equivalence, PTY/Ghostty or championship claim.')


if __name__ == '__main__':
    print(json.dumps(analyze(load(D / 'raw.json')), indent=2))
