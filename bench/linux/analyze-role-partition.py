#!/usr/bin/env python3
"""Read-only own-parent hot-thread placement replay; no repair or publication."""
import argparse
import importlib.util
import json
import math
import random
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location('placement_replay', HERE.parent/'replay-terminal-pairs.py')
replay = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(replay)
need, load, sha = replay.require, replay.load, replay.digest
ARMS = ['auto', 'ab', 'ba', 'aa', 'bb']
ROLES = ('pty-read', 'pty-parse')


def orders(n, seed):
    # Random relabeling, row order, and column order for each 5-round Latin square.
    # Each arm appears at each ordinal position once per square; seed frozen.
    rng, result = random.Random(seed), []
    while len(result) < n:
        labels, rows, columns = ARMS[:], list(range(5)), list(range(5))
        rng.shuffle(labels); rng.shuffle(rows); rng.shuffle(columns)
        result.extend([[labels[(r+c)%5] for c in columns] for r in rows])
    return result[:n]


def lower_bound(ratios, alpha):
    # One-sided distribution-free median bound under independent identically
    # distributed continuous block ratios. Ties make coverage conservative.
    n, k = len(ratios), 0
    for i in range(1,n+1):
        if sum(math.comb(n,j) for j in range(i))/2**n <= alpha:
            k = i
    return dict(order_1based=k, value=sorted(ratios)[k-1] if k else 0.,
                tail_probability=sum(math.comb(n,j) for j in range(k))/2**n)


def holm(rows):
    largest = 0
    for i, (_, row) in enumerate(sorted(rows.items(), key=lambda kv: kv[1]['sign_p_two_sided'])):
        largest = max(largest, min(1., (len(rows)-i)*row['sign_p_two_sided']))
        row['holm_p_six_workloads'] = largest


def sign(ratios):
    w, l = sum(x > 1 for x in ratios), sum(x < 1 for x in ratios)
    return dict(ratios=ratios, median_ratio=statistics.median(ratios), wins=w, losses=l,
                ties=len(ratios)-w-l, sign_p_two_sided=replay.sign_p(w, l))


def valid_mask(mask):
    return isinstance(mask, list) and bool(mask) and all(type(x) is int and 0 <= x < 1024 for x in mask) and sorted(set(mask)) == mask


def raw_validate(raw, payloads):
    need(set(raw) == {'cols', 'rows', 'results'} and type(raw['cols']) is int and type(raw['rows']) is int and
         (raw['cols'], raw['rows']) == (154, 39), 'geometry/raw fields')
    need(set(raw['results']) == set(replay.WORKLOADS), 'workload set')
    for name, row in raw['results'].items():
        need(set(row) == {'bytes', 'secs', 'mb_s', 'term_cpu_s'} | ({'fps'} if name == 'tui_frames' else set()), 'result fields')
        count, secs, rate = row['bytes'], row['secs'], row['mb_s']
        need(replay.positive_int(count) and payloads.setdefault(name, count) == count, 'payload bytes')
        need(isinstance(secs, list) and len(secs) == 3 and all(replay.number(x) for x in secs), 'samples')
        need(replay.number(rate) and replay.number(row['term_cpu_s'], zero=True), 'raw rate/CPU')
        lower, upper = count/((rate+.05)*1e6), count/(max(rate-.05, 1e-300)*1e6)
        need(lower <= min(secs)+.0005+1e-12 and upper >= min(secs)-.0005-1e-12, 'rate/time mismatch')
        if name == 'tui_frames':
            fps = row['fps']
            need(replay.number(fps), 'fps')
            need(max(lower, 300/(fps+.05), min(secs)-.0005) <=
                 min(upper, 300/max(fps-.05, 1e-300), min(secs)+.0005)+1e-12, 'fps/time mismatch')


def analyze(root):
    root = Path(root).resolve()
    m = load(root/'manifest.json')
    need(m['schema'] == 'glass.role-partition-run/v1' and m['complete'] is True, 'incomplete/schema')
    n = m['rounds']
    need(replay.positive_int(n) and m['arms'] == ARMS, 'design/arms')
    paths = {str(p.resolve()) for p in [Path(m['binary']), Path(m['protocol']), HERE/'role-partition.py',
             HERE/'run-role-partition.sh', HERE.parent/'lib.sh', HERE.parent/'tput.py', HERE/'analyze-role-partition.py', HERE/'hot-placement.py', HERE.parent/'replay-terminal-pairs.py']}
    need(set(m['sha256']) == paths, 'source set')
    for path, digest in m['sha256'].items():
        need(replay.valid_digest(digest) and not Path(path).is_symlink() and sha(path) == digest, f'changed source: {path}')
    protocol = load(m['protocol'])
    need(protocol['schema'] == 'glass.role-partition-protocol/v1' and
         protocol['binary_sha256'] == m['sha256'][m['binary']], 'protocol binary')
    observe_non_target = True
    need(n in (protocol['rounds'], protocol['pilot_rounds']), 'round count not declared')
    need(m['orders'] == m['planned_orders'] == orders(n, protocol['seed']) == protocol['planned_orders'][:n], 'design/order')
    cpus, topo = protocol['cpus'], protocol['topology']
    # Recorded topology is checked independently of the current host topology.
    spec = importlib.util.spec_from_file_location('partition_wrapper', HERE/'role-partition.py')
    wrapper = importlib.util.module_from_spec(spec); spec.loader.exec_module(wrapper)
    halves = wrapper.validate_topology(cpus, topo)
    need(halves == protocol['halves'], 'partition halves')
    full = cpus
    need(len(m['admissions']) == n, 'missing load admission')
    admission_times = []
    for admission in m['admissions']:
        need(admission['accepted'] is True and bool(admission['attempts']), 'load admission incomplete')
        times = []
        for index, row in enumerate(admission['attempts']):
            need(replay.positive_int(row['monotonic_ns']), 'admission time')
            times.append(row['monotonic_ns'])
            avg10 = float(dict(x.split('=') for x in row['cpu_pressure'].splitlines()[0].split()[1:])['avg10'])
            accepted = float(row['loadavg'].split()[0]) <= protocol['load_gate']['load1_max'] and avg10 <= protocol['load_gate']['cpu_psi_avg10_max']
            need(accepted == (index == len(admission['attempts'])-1), 'admission criterion/order')
        need(all(a < b for a,b in zip(times,times[1:])), 'admission time order')
        admission_times.append(times[-1])
    expected = {f'tput-{arm}-{r}{suffix}' for arm in ARMS for r in range(1,n+1) for suffix in ('.json','.placement.json')}
    need(set(m['raw_sha256']) == expected and {p.name for p in root.iterdir()} == expected | {'manifest.json'}, 'raw set')
    for name, digest in m['raw_sha256'].items():
        p = root/name
        need(not p.is_symlink() and p.resolve().is_relative_to(root) and sha(p) == digest, f'raw hash: {name}')
    sessions, payloads = {arm: [] for arm in ARMS}, {}
    transitions, timeline = [], []
    a,b = halves
    pairs = dict(ab=(a,b), ba=(b,a), aa=(a,a), bb=(b,b))
    for arm in ARMS:
        for r in range(1,n+1):
            raw_path = root/f'tput-{arm}-{r}.json'
            raw, s = load(raw_path), load(raw_path.with_suffix('.placement.json'))
            raw_validate(raw, payloads)
            need(s['schema'] == 'glass.role-partition/v1' and s['complete'] is True and s['arm'] == arm and
                 not s['cleanup_errors'], 'session state')
            need(s['result_sha256'] == sha(raw_path) and s['topology'] == topo, 'result/topology provenance')
            for key, path in [('binary_sha256',m['binary']), ('protocol_sha256',m['protocol']),
                              ('payload_sha256',str((HERE.parent/'tput.py').resolve())),
                              ('wrapper_sha256',str((HERE/'role-partition.py').resolve()))]:
                need(s[key] == m['sha256'][path], f'session provenance: {key}')
            need(type(s['terminal_pid']) is int and s['terminal_pid'] > 0 and
                 type(s['payload_begin_ns']) is int and type(s['payload_end_ns']) is int and
                 0 < s['payload_begin_ns'] < s['payload_end_ns'], 'session identity/times')
            timeline.append((s['payload_begin_ns'],s['payload_end_ns'],r,arm))
            need(valid_mask(s['producer_allowed']) and s['producer_allowed_after'] == s['producer_allowed'], 'producer mask changed')
            original = s['original']
            need(set(original) == set(ROLES) and all(mask == full for mask in original.values()), 'not shipping original hot mask')
            target = original if arm == 'auto' else dict(zip(ROLES, pairs[arm]))
            need(s['target'] == target and set(s['roles']) == set(ROLES), 'target/role set')
            need(len({t['tid'] for t in s['roles'].values()}) == 2, 'hot TID collision')
            for role in ROLES:
                identity = s['roles'][role]
                need(identity['name'] == role and replay.positive_int(identity['tid']) and
                     replay.positive_int(identity['start_ticks']) and identity['allowed'] == original[role], 'role identity')
                for field, mask in [('roles_during',target[role]), ('roles_after',target[role]), ('roles_restored',original[role])]:
                    need(set(s[field]) == set(ROLES), 'role set')
                    row = s[field][role]
                    need({k: row[k] for k in ('tid','name','start_ticks')} ==
                         {k: identity[k] for k in ('tid','name','start_ticks')} and row['allowed'] == mask, 'role identity/mask')
            baseline = {(t['tid'],t['start_ticks']):t for t in s['threads_before']}
            for field in ('threads_before','threads_during','threads_after'):
                ts = s[field]
                need(len(ts) == len({t['tid'] for t in ts}), 'duplicate task')
                for role in ROLES:
                    found = [t for t in ts if t['name'] == role]
                    identity = s['roles'][role]
                    need(len(found) == 1 and (found[0]['tid'],found[0]['start_ticks']) ==
                         (identity['tid'],identity['start_ticks']), 'hot snapshot identity')
                    need(found[0]['allowed'] == (original if field == 'threads_before' else target)[role], 'hot snapshot mask')
                for t in ts:
                    need(valid_mask(t['allowed']), 'invalid mask')
                    old = baseline.get((t['tid'],t['start_ticks']))
                    if old and t['name'] not in ROLES:
                        if observe_non_target and (t['allowed'] != old['allowed'] or t['name'] != old['name']):
                            transitions.append(dict(file=raw_path.name,phase=field,before=old,after=t))
                        elif not observe_non_target:
                            need(t['allowed'] == old['allowed'], 'non-target thread mask changed')
            sessions[arm].append(raw)
    timeline.sort()
    need([(r,arm) for _,_,r,arm in timeline] ==
         [(r,arm) for r,row in enumerate(m['orders'],1) for arm in row], 'actual capture order')
    need(all(a[1] < b[0] for a,b in zip(timeline,timeline[1:])), 'overlapping payloads')
    for i, t in enumerate(admission_times):
        need(t < timeline[i*5][0] and (i == 0 or timeline[i*5-1][1] < t), 'admission outside block boundary')
    comparisons = {}
    for contrast in ('split_vs_auto','split_vs_shared','shared_vs_auto'):
        metrics = {}
        for name in replay.WORKLOADS:
            ratios = []
            for i in range(n):
                rates = {arm:sessions[arm][i]['results'][name]['mb_s'] for arm in ARMS}
                split = math.sqrt(rates['ab']*rates['ba'])
                shared = math.sqrt(rates['aa']*rates['bb'])
                ratios.append(split/shared if contrast == 'split_vs_shared' else
                              (split if contrast == 'split_vs_auto' else shared)/rates['auto'])
            metrics[name] = sign(ratios)
            if contrast == 'split_vs_auto':
                bound = lower_bound(ratios, protocol['family_alpha']/len(replay.WORKLOADS))
                bound.update(threshold=protocol['margins'][name], clears=bound['value'] > protocol['margins'][name])
                metrics[name]['prospective_lower_bound'] = bound
        holm(metrics)
        comparisons[contrast] = metrics
    result = dict(schema='glass.role-partition-analysis/v1',sessions=5*n,rounds=n,
                manifest_sha256=sha(root/'manifest.json'),payload_bytes=payloads,comparisons=comparisons,
                medians_mb_s={arm:{name:statistics.median(s['results'][name]['mb_s'] for s in ss) for name in replay.WORKLOADS}
                              for arm,ss in sessions.items()},limits=protocol['limitations'])
    if observe_non_target:
        result.update(schema='glass.role-partition-analysis/v2',non_target_transitions=transitions,
                      transition_session_count=len({row['file'] for row in transitions}))
    result['prospective_gate_clears'] = n == protocol['rounds'] and all(row['prospective_lower_bound']['clears'] for row in comparisons['split_vs_auto'].values())
    result['admission_wait_count'] = sum(len(x['attempts'])-1 for x in m['admissions'])
    return result


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('directory', type=Path)
    p.add_argument('--expect', type=Path, help='Require exact stored replay, never rewrite it')
    a = p.parse_args()
    result = analyze(a.directory)
    if a.expect:
        need(json.dumps(result,sort_keys=True,allow_nan=False) == json.dumps(load(a.expect),sort_keys=True,allow_nan=False), 'stored analysis mismatch')
    print(json.dumps(result, indent=2, allow_nan=False))
