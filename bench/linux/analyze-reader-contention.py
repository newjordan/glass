#!/usr/bin/env python3
"""Read-only replay of predeclared own-reader competition (not a score)."""
import argparse
from collections import defaultdict
import importlib.util
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location('contention_sched', HERE/'analyze-sched-shape.py')
sched = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(sched)
need, load, sha = sched.need, sched.load, sched.sha
ARMS = [f'{mode}-{obs}' for mode in ('sleep', 'busy') for obs in sched.ARMS]


def orders(rounds):
    rows = [[ARMS[(i+j)%6] for j in (0, 1, 5, 2, 4, 3)] for i in range(6)]
    rows += [list(reversed(row)) for row in rows]
    return [rows[i%12] for i in range(rounds)]


def cpu_set(text):
    result = set()
    for part in text.split(','):
        bounds = [int(x) for x in part.split('-')]
        need(len(bounds) in (1, 2), 'CPU mask shape')
        result.update(range(bounds[0], bounds[-1]+1))
    return result


def holm(rows):
    largest = 0
    for i, (_, row) in enumerate(sorted(rows.items(), key=lambda item: item[1]['sign_p_two_sided'])):
        largest = max(largest, min(1., (len(rows)-i)*row['sign_p_two_sided']))
        row['holm_p_six_workloads'] = largest


def analyze(root):
    root = root.resolve()
    m = load(root/'manifest.json')
    need(m['schema'] == 'glass.reader-contention-run/v1' and m['complete'] is True, 'manifest incomplete/schema')
    n = m['rounds']
    need(type(n) is int and n > 0 and m['arms'] == ARMS and m['cpu'] == 0, 'design')
    need(m['orders'] == m['planned_orders'] == orders(n), 'arm order')
    source_set = {str(p.resolve()) for p in [Path(m[k]) for k in ('binary', 'observer', 'helper', 'protocol')] +
                  [HERE/p for p in ('sched-shape.c', 'sched-snapshot.h', 'reader-contender.c', 'reader-contention.py',
                                   'run-reader-contention.sh', 'pipeline-profile.py')] +
                  [HERE.parent/p for p in ('lib.sh', 'tput.py')]}
    need(set(m['sha256']) == source_set, 'source set')
    snapshot_file = root/'source-snapshots.json'
    snapshots = load(snapshot_file) if snapshot_file.exists() else {}
    need(set(snapshots) <= {str((HERE/'reader-contention.py').resolve())}, 'unsupported historical source')
    for path, digest in m['sha256'].items():
        selected = Path(snapshots[path]) if path in snapshots else Path(path)
        need(not selected.is_symlink() and sha(selected) == digest, f'changed source: {path}')
    expected = set()
    for arm in ARMS:
        for r in range(1, n+1):
            expected.update(f'tput-{arm}-{r}{s}' for s in ('.json', '.profile.json', '.producer.py', '.contention.json'))
            if not arm.endswith('plain'):
                expected.add(f'{arm}-{r}.trace')
    need(set(m['raw_sha256']) == expected, 'raw manifest set')
    need({p.name for p in root.iterdir() if p.is_file() and p.name not in ('manifest.json', 'source-snapshots.json')} == expected, 'raw file set')
    for name, digest in m['raw_sha256'].items():
        p = root/name
        need(not p.is_symlink() and p.resolve().is_relative_to(root) and sha(p) == digest, f'changed raw artifact: {name}')
    sessions, observations, payloads = defaultdict(list), [], {}
    protocol = load(Path(m['protocol']))
    need(protocol['binary_sha256'] == m['sha256'][m['binary']], 'protocol binary')
    for arm in ARMS:
        mode, obs = arm.split('-')
        for r in range(1, n+1):
            stem = root/f'tput-{arm}-{r}'
            raw, profile, c = (load(stem.with_suffix(s)) for s in ('.json', '.profile.json', '.contention.json'))
            need((raw['cols'], raw['rows']) == (154, 39) and set(raw['results']) == set(sched.WORK), 'raw shape')
            need(profile['schema'] == 'glass.pipeline-profile/v1' and profile['complete'] is True and
                 profile['sample_ms'] == 0 and len(profile['passes']) == 18, 'profile shape')
            need(profile['result_sha256'] == sha(stem.with_suffix('.json')) and
                 profile['derived_sha256'] == sha(stem.with_suffix('.producer.py')) and
                 profile['payload_sha256'] == sha(HERE.parent/'tput.py') and
                 profile['wrapper_sha256'] == sha(HERE/'pipeline-profile.py'), 'profile provenance')
            need(c['schema'] == 'glass.reader-contention/v1' and c['complete'] is True and c['mode'] == mode and c['cpu'] == m['cpu'], 'treatment metadata')
            need(c['result_sha256'] == profile['result_sha256'] and c['profile_result_sha256'] == sha(stem.with_suffix('.profile.json')), 'treatment result hashes')
            for key, path in (('binary_sha256', m['binary']), ('helper_sha256', m['helper']),
                              ('wrapper_sha256', str(HERE/'reader-contention.py')), ('profile_sha256', str(HERE/'pipeline-profile.py'))):
                need(c[key] == m['sha256'][path], 'treatment provenance')
            need(c['reader_allowed_during'] == c['helper_allowed'] == [m['cpu']] and
                 c['reader_allowed_restored'] == c['reader_allowed_before'] and m['cpu'] in c['reader_allowed_before'], 'affinity treatment/restore')
            need(c['helper_ready'] == dict(pid=c['helper_ready']['pid'], cpu=m['cpu'], mode=mode, ready=True) and
                 c['helper_finish']['complete'] is True and
                 0 <= c['helper_finish']['cpu_ns'] <= c['helper_finish']['wall_ns'], 'helper lifecycle')
            tid, windows = sched.decode(root/f'{arm}-{r}.trace', obs) if obs != 'plain' else (c['reader_tid'], [])
            need(tid == c['reader_tid'] and profile['terminal_pid'] == c['terminal_pid'], 'reader/terminal identity')
            for i, p in enumerate(profile['passes']):
                name = sched.WORK[i//3]
                need((p['workload'], p['pass']) == (name, i%3), 'pass sequence')
                need((p['bytes'], p['payload_sha256']) == payloads.setdefault(name, (p['bytes'], p['payload_sha256'])), 'payload mismatch')
                need(c['treatment_begin_ns'] <= p['begin_ns'] < p['end_ns'] <= c['treatment_end_ns'], 'treatment coverage')
                need(i == 0 or p['begin_ns'] > profile['passes'][i-1]['end_ns'], 'pass overlap')
                need(p['bytes'] == raw['results'][name]['bytes'] and sched.number(p['wall_s']), 'pass size/time')
                need([w['bytes'] for w in p['writes']] == [p['bytes'], 3], 'producer writes')
                for boundary in ('before', 'after'):
                    rs = [t for t in p[f'terminal_{boundary}'] if t['tid'] == tid and t['name'] == 'pty-read']
                    need(len(rs) == 1 and rs[0]['start_ticks'] == c['reader_start_ticks'] and rs[0]['allowed'] == str(m['cpu']), 'reader pass identity/affinity')
                    producer = p[f'producer_{boundary}']
                    need(producer['pid'] == profile['producer_pid'] and
                         cpu_set(producer['allowed']) == set(c['producer_allowed']), 'producer identity/affinity')
                    original = {(t['tid'], t['start_ticks']): t['allowed'] for t in c['terminal_threads_before']}
                    for task in p[f'terminal_{boundary}']:
                        identity = (task['tid'], task['start_ticks'])
                        if task['tid'] != tid and identity in original:
                            need(task['allowed'] == original[identity], 'non-reader affinity changed')
                if obs != 'plain':
                    observations.append(dict(arm=arm, round=r, **sched.summarize_pass(p, windows, tid, obs == 'sched')))
            for name, row in raw['results'].items():
                ps = [p for p in profile['passes'] if p['workload'] == name]
                need(type(row['bytes']) is int and row['bytes'] > 0 and sched.number(row['mb_s']) and
                     len(row['secs']) == 3 and all(sched.number(s) for s in row['secs']) and
                     type(row['term_cpu_s']) in (int, float) and math.isfinite(row['term_cpu_s']) and row['term_cpu_s'] >= 0, 'raw numeric fields')
                need(row['secs'] == [round(p['wall_s'], 3) for p in ps] and
                     row['mb_s'] == round(row['bytes']/min(p['wall_s'] for p in ps)/1e6, 1), 'rate/time mismatch')
                if name == 'tui_frames':
                    need(row['fps'] == round(300/min(p['wall_s'] for p in ps), 1), 'frame-rate mismatch')
            sessions[arm].append(raw)
    comparisons = {}
    for obs in sched.ARMS:
        comparisons[obs] = {name: sched.sign([a['results'][name]['mb_s']/b['results'][name]['mb_s']
                             for a, b in zip(sessions[f'busy-{obs}'], sessions[f'sleep-{obs}'])]) for name in sched.WORK}
        holm(comparisons[obs])
    # Each round contributes one median across its three correlated passes.
    decomposition = {}
    for name in sched.WORK:
        decomposition[name] = {}
        keys = ('wall_coverage', 'byte_coverage', 'cpu_fraction', 'runqueue_fraction', 'residual_fraction', 'uncertainty_fraction')
        for key in keys:
            per_mode = {}
            for mode in ('sleep', 'busy'):
                per_mode[mode] = [statistics.median(p[key] for p in observations if
                    p['arm'] == f'{mode}-sched' and p['round'] == r and p['workload'] == name) for r in range(1, n+1)]
            diffs = [b-s for b, s in zip(per_mode['busy'], per_mode['sleep'])]
            w, l = sum(d>0 for d in diffs), sum(d<0 for d in diffs)
            decomposition[name][key] = dict(sleep=sched.spread(per_mode['sleep']), busy=sched.spread(per_mode['busy']),
                differences=diffs, median_difference=statistics.median(diffs), positive=w, negative=l,
                sign_p_two_sided=min(1., 2*sum(math.comb(w+l,k) for k in range(min(w,l)+1))/2**(w+l)))
    return dict(schema='glass.reader-contention-analysis/v1', sessions=6*n, rounds=n,
                manifest_sha256=sha(root/'manifest.json'), busy_vs_sleep=comparisons,
                medians_mb_s={arm:{name:statistics.median(s['results'][name]['mb_s'] for s in ss) for name in sched.WORK}
                              for arm,ss in sessions.items()}, decomposition=decomposition, passes=observations,
                limits=protocol['limits'])


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('directory', type=Path)
    a = p.parse_args()
    print(json.dumps(analyze(a.directory), indent=2, allow_nan=False))


if __name__ == '__main__':
    main()
