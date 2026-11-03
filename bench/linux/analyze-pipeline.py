#!/usr/bin/env python3
"""Fail-closed replay of run-pipeline-profile.sh's frozen diagnostic artifacts.

No run is discarded for being slow. Estimates are descriptive: correlated passes
and repeated same-host sessions do not constitute independent population samples.
"""
import argparse
import collections
import hashlib
import itertools
import json
import math
from pathlib import Path
import statistics

WORKLOADS = ('ascii', 'unicode', 'truecolor', 'cursor_motion', 'scroll_region', 'tui_frames')


def digest(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def spread(values):
    return {'min': min(values), 'median': statistics.median(values), 'max': max(values)}


def sign_p(w, l):
    n = w + l
    return min(1., 2 * sum(math.comb(n, k) for k in range(min(w, l) + 1)) / 2**n)


def analyze(root):
    manifest_path = root / 'manifest.json'
    manifest = json.loads(manifest_path.read_text())
    assert manifest['complete']
    for p, h in manifest['sha256'].items():
        assert digest(p) == h, f'changed source/binary {p}'
    rounds = manifest['rounds']
    orders = list(itertools.islice(itertools.cycle(itertools.permutations(['plain', 'edges', 'sampled'])), rounds))
    assert manifest['orders'] == manifest['planned_orders'] == [list(x) for x in orders]
    artifacts = {manifest_path.name: digest(manifest_path)}
    raw, passes, byte_counts, payloads = {}, collections.defaultdict(list), {}, {}
    states = collections.defaultdict(collections.Counter)
    observer_cost = []
    sample_intervals = []
    for arm in ('plain', 'edges', 'sampled'):
        raw[arm] = []
        for r in range(1, rounds + 1):
            result_path = root / f'tput-{arm}-{r}.json'
            artifacts[result_path.name] = digest(result_path)
            result = json.loads(result_path.read_text())
            assert (result['cols'], result['rows']) == (154, 39)
            assert set(result['results']) == set(WORKLOADS)
            for name in WORKLOADS:
                item = result['results'][name]
                assert byte_counts.setdefault(name, item['bytes']) == item['bytes']
                assert item['mb_s'] > 0 and len(item['secs']) == 3 and all(s > 0 for s in item['secs'])
            raw[arm].append(result)
            if arm == 'plain':
                continue
            profile_path = result_path.with_suffix('.profile.json')
            derived_path = result_path.with_suffix('.producer.py')
            artifacts[profile_path.name] = digest(profile_path)
            artifacts[derived_path.name] = digest(derived_path)
            profile = json.loads(profile_path.read_text())
            assert profile['complete'] and len(profile['passes']) == 18
            assert profile['result_sha256'] == digest(result_path)
            assert profile['derived_sha256'] == digest(derived_path)
            assert profile['payload_sha256'] == digest(Path(__file__).resolve().parents[1] / 'tput.py')
            assert profile['wrapper_sha256'] == digest(Path(__file__).with_name('pipeline-profile.py'))
            assert profile['sample_ms'] == (5 if arm == 'sampled' else 0)
            expected = [(n, i) for n in WORKLOADS for i in range(3)]
            assert [(c['workload'], c['pass']) for c in profile['passes']] == expected
            samples = []
            if arm == 'sampled':
                sample_path = result_path.with_suffix('.samples.jsonl')
                artifacts[sample_path.name] = digest(sample_path)
                assert digest(sample_path) == profile['samples_sha256']
                samples = [json.loads(line) for line in sample_path.read_text().splitlines()]
                assert samples
                sample_intervals.extend((b['before_ns'] - a['before_ns']) / 1e6 for a, b in zip(samples, samples[1:]))
                observer_cost.extend((s['after_ns'] - s['before_ns']) / 1e6 for s in samples)
            for c in profile['passes']:
                name, i = c['workload'], c['pass']
                assert c['bytes'] == byte_counts[name]
                assert payloads.setdefault(name, c['payload_sha256']) == c['payload_sha256']
                assert round(c['wall_s'], 3) == result['results'][name]['secs'][i]
                assert len(c['writes']) == 2 and [x['bytes'] for x in c['writes']] == [c['bytes'], 3]
                assert all(x['runtime_ns'] >= 0 and x['elapsed_ns'] > 0 for x in c['terminal_deltas'])
                c = dict(c, source=profile_path.name)
                passes[(arm, name)].append(c)
                for sample in samples:
                    if c['begin_ns'] <= sample['before_ns'] <= c['end_ns']:
                        for task in sample['tasks']:
                            states[(name, task['name'])][(task['state'], task['wchan'])] += 1
    comparisons = {}
    for arm in ('edges', 'sampled'):
        comparisons[arm] = {}
        for name in WORKLOADS:
            ratios = [a['results'][name]['mb_s'] / b['results'][name]['mb_s'] for a, b in zip(raw[arm], raw['plain'])]
            w, l = sum(x > 1 for x in ratios), sum(x < 1 for x in ratios)
            comparisons[arm][name] = dict(median_ratio=statistics.median(ratios), wins=w, losses=l,
                                         sign_p_two_sided=sign_p(w, l), ratios=ratios)
    stages = {}
    for (arm, name), cs in passes.items():
        stage = {'wall_ms': spread([c['wall_s'] * 1000 for c in cs]), 'passes': len(cs)}
        for thread, key in [('pty-parse', 'parser'), ('pty-read', 'reader')]:
            rows = [(c, next(x for x in c['terminal_deltas'] if x['name'] == thread)) for c in cs]
            stage[key] = {'runtime_ms': spread([x['runtime_ns'] / 1e6 for _, x in rows]),
                          'cpu_to_wall_ratio': spread([x['runtime_ns'] / (c['wall_s'] * 1e9) for c, x in rows]),
                          'voluntary_switches': spread([x['voluntary'] for _, x in rows]),
                          'involuntary_switches': spread([x['involuntary'] for _, x in rows]),
                          'snapshot_uncertainty_ms': spread([x['snapshot_uncertainty_ns'] / 1e6 for _, x in rows])}
        stage['producer_write_cpu_ms'] = spread([c['writes'][0]['cpu_ns'] / 1e6 for c in cs])
        stage['producer_write_wall_ms'] = spread([c['writes'][0]['wall_ns'] / 1e6 for c in cs])
        stage['producer_write_wall_to_pass_ratio'] = spread([c['writes'][0]['wall_ns'] / (c['wall_s'] * 1e9) for c in cs])
        stage['slowest_pass'] = max(cs, key=lambda c: c['wall_s'])
        stages.setdefault(arm, {})[name] = stage
    return {'schema': 'glass.pipeline-profile-analysis/v1', 'complete': True,
            'rounds': rounds, 'sessions': rounds * 3, 'instrumented_passes': sum(map(len, passes.values())),
            'payload_sha256': payloads, 'byte_counts': byte_counts, 'observer_cost_ms': spread(observer_cost),
            'sample_interval_ms': spread(sample_intervals), 'comparisons_vs_plain': comparisons, 'stages': stages,
            'sampled_states': {f'{name}/{thread}': [{'state': state, 'wchan': channel, 'count': count}
                                                  for (state, channel), count in counts.most_common()]
                               for (name, thread), counts in sorted(states.items())},
            'raw_sha256': artifacts,
            'limits': ['No competitor run; not an official score.', 'Non-atomic proc snapshots, timing windows include boundary uncertainty.',
                       'sched_schedstats disabled; no runnable/blocked decomposition.', 'Clock/sample/snapshot instrumentation can perturb scheduling.',
                       'Passes correlated; sign tests exploratory and not multiple-testing corrected.']}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('root', type=Path)
    p.add_argument('--out', required=True, type=Path)
    args = p.parse_args()
    summary = analyze(args.root)
    # Immutable first publication; an identical replay is permitted.
    text = json.dumps(summary, indent=2) + '\n'
    if args.out.exists():
        assert args.out.read_text() == text, 'changed replay result'
    else:
        with args.out.open('x') as f:
            f.write(text)
    print(f"complete: {summary['sessions']} sessions, {summary['instrumented_passes']} instrumented passes")
    for arm, metrics in summary['comparisons_vs_plain'].items():
        print(arm, {n: (round(m['median_ratio'], 4), m['wins'], m['losses']) for n, m in metrics.items()})
    for name, d in summary['stages']['edges'].items():
        print(name, 'CPU/wall parser,reader =', round(d['parser']['cpu_to_wall_ratio']['median'], 4),
              round(d['reader']['cpu_to_wall_ratio']['median'], 4), 'parser switches =', d['parser']['voluntary_switches']['median'])


if __name__ == '__main__':
    main()
