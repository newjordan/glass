#!/usr/bin/env python3
"""Read-only, fail-closed sparse own-reader scheduler replay.

No rewriting, repairing or filtering slow sessions. Whole windows only; the
residual is NOT a pure blocking or kernel/line-discipline attribution. Counter
availability must be validated on each kernel by the separate calibration.
"""
import argparse
from collections import defaultdict
import hashlib
import itertools
import json
import math
from pathlib import Path
import statistics
import struct

HERE = Path(__file__).resolve().parent
WORK = ('ascii', 'unicode', 'truecolor', 'cursor_motion', 'scroll_region', 'tui_frames')
ARMS = ('plain', 'clock', 'sched')
HEADER = struct.Struct('<8s8I')
WINDOW = struct.Struct('<16Q')


def need(ok, message):
    if not ok:
        raise ValueError(message)


def unique(pairs):
    d = {}
    for k, v in pairs:
        need(k not in d, f'duplicate key: {k}')
        d[k] = v
    return d


def load(p):
    return json.loads(p.read_text(), object_pairs_hook=unique)


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def number(x):
    return type(x) in (int, float) and math.isfinite(x) and x > 0


def spread(xs):
    need(bool(xs) and all(math.isfinite(x) for x in xs), 'empty/nonfinite aggregate')
    return dict(min=min(xs), median=statistics.median(xs), max=max(xs))


def sign(xs):
    w, l = sum(x > 1 for x in xs), sum(x < 1 for x in xs)
    p = min(1., 2 * sum(math.comb(w+l, k) for k in range(min(w, l)+1)) / 2**(w+l))
    return dict(median_ratio=statistics.median(xs), wins=w, losses=l,
                ties=len(xs)-w-l, sign_p_two_sided=p, ratios=xs)


def interval(before, after, scheduler):
    need(len(before) == len(after) == 7 and all(type(x) is int and x >= 0 for x in before+after), 'snapshot fields')
    for s in (before, after):
        need(0 < s[0] <= s[6] and 0 < s[1] <= s[5], 'snapshot bracket')
        need(s[5]-s[1] <= s[6]-s[0], 'CPU exceeds snapshot wall')
        need(scheduler or s[2:5] == [0, 0, 0], 'clock arm has scheduler fields')
    need(before[6] <= after[0] and before[5] <= after[1], 'snapshot order')
    need(all(after[i] >= before[i] for i in (2, 3, 4)), 'counter regression')
    wall = (after[0]+after[6]-before[0]-before[6])/2
    cpu = (after[1]+after[5]-before[1]-before[5])/2
    rq = after[3]-before[3]
    uncertainty = 2*(before[6]-before[0]+after[6]-after[0])
    residual = wall-cpu-rq
    # Do not clip negative residuals, remove outliers, or silently repair them.
    need(residual >= -uncertainty, 'negative residual beyond bracket uncertainty')
    return dict(wall_ns=wall, cpu_ns=cpu, runqueue_ns=rq, residual_ns=residual,
                uncertainty_ns=uncertainty, timeslices=after[4]-before[4])


def decode(path, arm):
    data = path.read_bytes()
    need(len(data) >= HEADER.size, 'truncated trace header')
    magic, version, size, count, dropped, mode, tid, cap, stride = HEADER.unpack_from(data)
    need(magic == b'RDSCHED1' and version == 1 and size == WINDOW.size, 'trace ABI')
    need(mode == int(arm == 'sched') and tid > 0, 'trace mode/tid')
    need(0 < count <= cap == 65536 and dropped == 0 and stride == 128, 'trace count/drop/stride')
    need(len(data) == HEADER.size+size*count, 'trace length')
    rows, previous = [], None
    for e in WINDOW.iter_unpack(data[HEADER.size:]):
        before, after = list(e[:7]), list(e[7:14])
        d = interval(before, after, bool(mode))
        need(previous is None or before == previous, 'noncontiguous windows')
        previous = after
        need(e[15] == stride and 0 <= e[14] <= stride*16384, 'window reads/bytes')
        rows.append(dict(before=before, after=after, bytes=e[14], reads=e[15], **d))
    return tid, rows


def calibration(root):
    rows = [json.loads(line, object_pairs_hook=unique) for line in (root/'calibration.jsonl').read_text().splitlines()]
    orders = list(itertools.permutations(('busy', 'sleep', 'contend')))
    need(len(rows) == 36, 'calibration trial count')
    values = defaultdict(list)
    for i, row in enumerate(rows):
        r, p = divmod(i, 3)
        need((row['round'], row['position'], row['mode']) == (r, p, orders[r % 6][p]), 'calibration order')
        need(type(row['cpu']) is int and row['cpu'] == rows[0]['cpu'] >= 0, 'calibration CPU')
        d = interval(row['before'], row['after'], True)
        need(d['wall_ns'] >= 80000000, 'short calibration')
        values[row['mode']].append(d)
    result = {mode: {key: spread([d[key] for d in ds]) for key in ds[0]} for mode, ds in values.items()}
    # Sanity gates, NOT a performance target or proof on any other kernel.
    need(result['sleep']['residual_ns']['median'] > 60000000, 'sleep not distinguishable')
    need(result['contend']['runqueue_ns']['median'] > result['sleep']['runqueue_ns']['median']+10000000,
         'contention not distinguishable')
    need(abs(result['contend']['residual_ns']['median']) < 10000000, 'contention residual unexplained')
    return dict(trials=len(rows), pinned_cpu=rows[0]['cpu'], modes=result)


def summarize_pass(p, windows, tid, scheduler):
    begin, end = p['begin_ns'], p['end_ns']
    need(type(begin) is int and type(end) is int and begin < end, 'pass interval')
    whole = [w for w in windows if begin <= w['before'][0] and w['after'][6] <= end]
    need(bool(whole), 'no whole windows in pass')
    # Count, but do not assign, boundary-straddling and unmeasured tail time.
    overlaps = [w for w in windows if w['before'][0] < end and w['after'][6] > begin]
    task = [t for t in p['terminal_before'] if t['tid'] == tid and t['name'] == 'pty-read']
    need(len(task) == 1, 'wrong reader identity')
    after = [t for t in p['terminal_after'] if t['tid'] == tid and t['name'] == 'pty-read']
    need(len(after) == 1 and after[0]['start_ticks'] == task[0]['start_ticks'], 'reader identity changed')
    need(all(w['timeslices'] >= 0 for w in whole), 'timeslice regression')
    out = {key: sum(w[key] for w in whole) for key in
           ('wall_ns', 'cpu_ns', 'runqueue_ns', 'residual_ns', 'uncertainty_ns', 'bytes', 'reads', 'timeslices')}
    need(0 < out['bytes'] <= p['bytes']+3, 'whole window byte mismatch')
    need(0 < out['wall_ns'] <= end-begin, 'whole window overlap')
    out.update(workload=p['workload'], pass_index=p['pass'], windows=len(whole),
               excluded_overlapping_windows=len(overlaps)-len(whole), pass_wall_ns=end-begin,
               wall_coverage=out['wall_ns']/(end-begin), byte_coverage=out['bytes']/(p['bytes']+3),
               cpu_fraction=out['cpu_ns']/out['wall_ns'],
               uncertainty_fraction=out['uncertainty_ns']/out['wall_ns'])
    if scheduler:
        out.update(runqueue_fraction=out['runqueue_ns']/out['wall_ns'],
                   residual_fraction=out['residual_ns']/out['wall_ns'])
    return out


def analyze(root):
    root = root.resolve()
    m = load(root/'manifest.json')
    need(m['schema'] == 'glass.sched-shape-run/v1' and m['complete'] is True, 'incomplete/unknown manifest')
    rounds = m['rounds']
    need(type(rounds) is int and rounds > 0, 'invalid rounds')
    orders = [list(o) for o in itertools.islice(itertools.cycle(itertools.permutations(ARMS)), rounds)]
    need(m['orders'] == m['planned_orders'] == orders, 'arm order')
    sources = {str((HERE/n).resolve()) for n in ('sched-shape.c', 'sched-snapshot.h', 'run-sched-shape.sh', 'pipeline-profile.py')}
    sources |= {str((HERE.parent/n).resolve()) for n in ('lib.sh', 'tput.py')}
    sources |= {m['binary'], m['observer']}
    need(set(m['sha256']) == sources, 'source set')
    snapshot_file = root/'source-snapshots.json'
    snapshots = load(snapshot_file) if snapshot_file.exists() else {}
    historical_source = str((HERE/'sched-shape.c').resolve())
    need(set(snapshots) <= {historical_source}, 'only explicit observer source snapshots allowed')
    for path, digest in m['sha256'].items():
        # Exact explicit historical source only: no search or fallback.
        selected = Path(snapshots[path]) if path in snapshots else Path(path)
        need(not selected.is_symlink() and sha(selected) == digest, f'changed source/binary: {path}')
    expected = set()
    for arm in ARMS:
        for r in range(1, rounds+1):
            expected.update(f'tput-{arm}-{r}{s}' for s in ('.json', '.profile.json', '.producer.py'))
            if arm != 'plain':
                expected.add(f'{arm}-{r}.trace')
    need(set(m['raw_sha256']) == expected, 'raw manifest set')
    actual = {p.name for p in root.iterdir() if p.suffix in ('.json', '.jsonl', '.py', '.trace') and p.name not in ('manifest.json', 'source-snapshots.json')}
    need(actual == expected, 'missing/unexpected raw file')
    for path, digest in m['raw_sha256'].items():
        need(not (root/path).is_symlink() and sha(root/path) == digest, f'changed raw artifact: {path}')
    sessions, observations, payloads = defaultdict(list), [], {}
    for arm in ARMS:
        for r in range(1, rounds+1):
            stem = root/f'tput-{arm}-{r}'
            raw, profile = load(stem.with_suffix('.json')), load(stem.with_suffix('.profile.json'))
            need((raw['cols'], raw['rows']) == (154, 39) and set(raw['results']) == set(WORK), 'raw shape')
            need(profile['schema'] == 'glass.pipeline-profile/v1' and profile['complete'] is True
                 and profile['sample_ms'] == 0 and len(profile['passes']) == 18, 'profile shape')
            need(profile['result_sha256'] == sha(stem.with_suffix('.json')) and
                 profile['derived_sha256'] == sha(stem.with_suffix('.producer.py')) and
                 profile['payload_sha256'] == sha(HERE.parent/'tput.py') and
                 profile['wrapper_sha256'] == sha(HERE/'pipeline-profile.py'), 'profile provenance')
            tid, windows = decode(root/f'{arm}-{r}.trace', arm) if arm != 'plain' else (None, [])
            for i, p in enumerate(profile['passes']):
                name = WORK[i//3]
                need((p['workload'], p['pass']) == (name, i%3), 'pass sequence')
                need((p['bytes'], p['payload_sha256']) == payloads.setdefault(name, (p['bytes'], p['payload_sha256'])), 'payload mismatch')
                need(p['bytes'] == raw['results'][name]['bytes'] and number(p['wall_s']), 'pass size/time')
                need([w['bytes'] for w in p['writes']] == [p['bytes'], 3], 'producer write boundaries')
                need(i == 0 or p['begin_ns'] > profile['passes'][i-1]['end_ns'], 'pass overlap')
                if arm != 'plain':
                    row = summarize_pass(p, windows, tid, arm == 'sched')
                    observations.append(dict(arm=arm, round=r, **row))
            for name, row in raw['results'].items():
                ps = [p for p in profile['passes'] if p['workload'] == name]
                need(type(row['bytes']) is int and row['bytes'] > 0 and number(row['mb_s']) and
                     len(row['secs']) == 3 and all(number(s) for s in row['secs']), 'raw numeric fields')
                need(row['secs'] == [round(p['wall_s'], 3) for p in ps], 'rounded time mismatch')
                need(row['mb_s'] == round(row['bytes']/min(p['wall_s'] for p in ps)/1e6, 1), 'rate mismatch')
            sessions[arm].append(raw)
    comparisons = {arm: {name: sign([a['results'][name]['mb_s']/b['results'][name]['mb_s']
                   for a, b in zip(sessions[arm], sessions['plain'])]) for name in WORK} for arm in ARMS[1:]}
    comparisons['sched_vs_clock'] = {name: sign([a['results'][name]['mb_s']/b['results'][name]['mb_s']
                                  for a, b in zip(sessions['sched'], sessions['clock'])]) for name in WORK}
    aggregates = {}
    for arm in ARMS[1:]:
        aggregates[arm] = {}
        for name in WORK:
            rows = [r for r in observations if r['arm'] == arm and r['workload'] == name]
            keys = ['wall_coverage', 'byte_coverage', 'cpu_fraction', 'uncertainty_fraction', 'windows']
            if arm == 'sched':
                keys += ['runqueue_fraction', 'residual_fraction']
            aggregates[arm][name] = {key: spread([r[key] for r in rows]) for key in keys}
    return dict(schema='glass.sched-shape-analysis/v1', complete=True, sessions=rounds*3, rounds=rounds,
                comparisons_vs_plain=comparisons, aggregates=aggregates, passes=observations,
                manifest_sha256=sha(root/'manifest.json'), historical_sources=snapshots,
                limits=['Diagnostic only: no competitor, no runtime change, no promotion.',
                        'Whole-window decomposition only; excluded boundaries/tails are not extrapolated.',
                        'Residual includes sleeping, interrupts, accounting error and unclassified off-CPU time; not pure blocking.',
                        'Reader windows include userspace/channel waits and intervening syscalls, not kernel function attribution.',
                        'Clock/proc observer effects measured against profile-only plain arm, not the uninstrumented scoreboard.',
                        'Same-host correlated passes and exploratory sign tests, not independent population or corrected significance.'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('directory', type=Path)
    parser.add_argument('--calibration', type=Path)
    args = parser.parse_args()
    result = analyze(args.directory)
    if args.calibration:
        result['calibration'] = calibration(args.calibration)
    print(json.dumps(result, indent=2, allow_nan=False))


if __name__ == '__main__':
    main()
