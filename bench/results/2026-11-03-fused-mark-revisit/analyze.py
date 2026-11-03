#!/usr/bin/env python3
"""Read-only fixed 12-pair analysis. Not a terminal or Ghostty measurement."""
import hashlib
import json
import math
from pathlib import Path
import re
import statistics

D = Path(__file__).resolve().parent
NAMES = ['ascii', 'unicode', 'truecolor', 'cursor_motion', 'scroll_region', 'tui_frames']
LINE = re.compile(r'^\s*(\w+):\s+([\d.]+) MB/s\s+([\d.]+) MB/cpu-s\s+\((\d+) bytes, read (\d+)\)', re.M)


def unique(pairs):
    result = {}
    for k, v in pairs:
        if k in result:
            raise ValueError('duplicate JSON key: ' + k)
        result[k] = v
    return result


def load(p):
    return json.loads(Path(p).read_text(), object_pairs_hook=unique)


def need(ok, message):
    if not ok:
        raise ValueError(message)


def sign_p(wins, losses):
    n = wins + losses
    return min(1., 2 * sum(math.comb(n, k) for k in range(min(wins, losses) + 1)) / 2**n)


def analyze(raw, identities):
    need(raw['schema'] == 'glass.engine-pairs/v1', 'raw schema')
    need(raw['settings'] == dict(GLASS_BENCH_SCALE='1.0', GLASS_BENCH_ROUNDS='5', GLASS_BENCH_ONLY=','.join(NAMES)), 'timing settings')
    need(len(raw['pairs']) == 12 and 'failure' not in raw, 'fixed complete pair count')
    need(set(raw['binaries']) == {'base', 'candidate'}, 'arm keys')
    for arm, source in [('base', 'control'), ('candidate', 'candidate')]:
        need(raw['binaries'][arm]['sha256'] == identities[source]['sha256'], 'timed ELF identity')
        need(raw['binaries'][arm]['path'] == identities[source]['executable'], 'timed ELF path')
    summaries = {}
    shape = {}
    for i, pair in enumerate(raw['pairs']):
        need(set(pair) == {'order', 'base', 'candidate'}, 'pair keys')
        need(pair['order'] == (['base', 'candidate'] if i % 2 == 0 else ['candidate', 'base']), 'balanced order')
        for arm in ['base', 'candidate']:
            r = pair[arm]
            need(r['exit'] == 0 and set(r['results']) == set(NAMES), 'complete successful session')
            need('test result: ok. 1 passed;' in r['stdout'] and '0 failed;' in r['stdout'], 'nonempty timing test')
            matches = LINE.findall(r['stderr'])
            need(len(matches) == 6 and len({m[0] for m in matches}) == 6, 'unique six timing rows')
            parsed = {m[0]: dict(mb_s=float(m[1]), mb_cpu_s=float(m[2]), bytes=int(m[3]), read=int(m[4])) for m in matches}
            need(parsed == r['results'], 'timing parsed/raw disagreement')
            for name, v in parsed.items():
                need(all(math.isfinite(v[k]) and v[k] > 0 for k in ['mb_s', 'mb_cpu_s']), 'invalid rate')
                need(v['bytes'] > 0 and v['read'] == 4095, 'workload read shape')
                current = (v['bytes'], v['read'])
                need(shape.setdefault(name, current) == current, 'workload size changed')
    for name in NAMES:
        ratios = [p['candidate']['results'][name]['mb_cpu_s'] / p['base']['results'][name]['mb_cpu_s'] for p in raw['pairs']]
        walls = [p['candidate']['results'][name]['mb_s'] / p['base']['results'][name]['mb_s'] for p in raw['pairs']]
        wins, losses = sum(x > 1 for x in ratios), sum(x < 1 for x in ratios)
        summaries[name] = dict(cpu_ratios=ratios, wall_ratios=walls, median_cpu_ratio=statistics.median(ratios), median_wall_ratio=statistics.median(walls), wins=wins, losses=losses, sign_p_two_sided=sign_p(wins, losses))
    running = 0.
    for rank, name in enumerate(sorted(summaries, key=lambda k: summaries[k]['sign_p_two_sided'])):
        running = max(running, min(1., (6 - rank) * summaries[name]['sign_p_two_sided']))
        summaries[name]['holm_p'] = running
    failed = [n for n in NAMES if summaries[n]['median_cpu_ratio'] < .98]
    u = summaries['unicode']
    target = u['median_cpu_ratio'] >= 1.02 and u['wins'] > u['losses'] and u['holm_p'] < .05
    return dict(schema='glass.fused-mark-revisit-analysis/v1', pairs=12, sessions=24, summary=summaries,
                unicode_target_cleared=target, point_regression_guards_failed=failed,
                engine_screen_cleared=target and not failed, runtime_promotion=False,
                note='Operational engine screen only. Not noninferiority proof, mechanism isolation, terminal throughput, Ghostty comparison or championship. Best-of-five samples are one invocation, not five independent trials. Sign tests assume independent fair signs; balanced sequential order does not establish independence.')


if __name__ == '__main__':
    identities = {arm: load(D / 'measured' / ('build-' + arm) / 'identity.json') for arm in ['control', 'candidate']}
    print(json.dumps(analyze(load(D / 'measured/raw.json'), identities), indent=2))
