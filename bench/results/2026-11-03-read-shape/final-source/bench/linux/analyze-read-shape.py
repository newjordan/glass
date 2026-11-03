#!/usr/bin/env python3
"""Read-only replay of read-shape diagnostics. Not a timing-accuracy proof.

Each pass is one correlated observation, each session the comparison unit.
Count events join by exit; timed durations join only if wholly within pass.
No scheduler-blocked, ioctl-time, handoff-count, or syscall-kernel-time claims.
"""
import argparse
from collections import Counter
import hashlib
import itertools
import json
import math
from pathlib import Path
import statistics
import struct
import sys

WORK = ('ascii', 'unicode', 'truecolor', 'cursor_motion', 'scroll_region', 'tui_frames')
ARMS = ('plain', 'count', 'timed')
HEADER = struct.Struct('<8s8I')
EVENT = struct.Struct('<4Qq4I')
BENCH = Path(__file__).resolve().parent


def need(ok, message):
    if not ok:
        raise ValueError(message)


def unique(pairs):
    result = {}
    for key, value in pairs:
        need(key not in result, f'duplicate key: {key}')
        result[key] = value
    return result


def load(path):
    return json.loads(path.read_text(), object_pairs_hook=unique)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def number(v):
    return type(v) in (int, float) and math.isfinite(v) and v > 0


def median(values):
    need(bool(values), 'empty aggregate')
    return statistics.median(values)


def sign(ratios):
    w = sum(x > 1 for x in ratios)
    l = sum(x < 1 for x in ratios)
    p = min(1., 2 * sum(math.comb(w+l, i) for i in range(min(w, l)+1)) / 2**(w+l))
    return dict(median_ratio=median(ratios), wins=w, losses=l,
                ties=len(ratios)-w-l, sign_p_two_sided=p, ratios=ratios)


def decode(path, arm):
    data = path.read_bytes()
    need(len(data) >= HEADER.size, f'truncated header: {path}')
    magic, version, size, count, dropped, mode, tid, cap, reserved = HEADER.unpack_from(data)
    need(magic == b'RDSHAPE1' and version == 1 and size == EVENT.size, 'trace ABI')
    need(0 < count <= cap == 1 << 20 and dropped == reserved == 0 and tid > 0, 'trace count/drop')
    need(mode == int(arm == 'timed') and len(data) == HEADER.size + count * size, 'trace size/mode')
    events = list(EVENT.iter_unpack(data[HEADER.size:]))
    last = 0
    for end, begin, cpu, requested, result, kind, error, flags, reserved in events:
        need(end >= last > -1 and reserved == 0, 'nonmonotonic/invalid event')
        if mode:
            need(last <= begin <= end and cpu <= end-begin, 'invalid event interval')
        else:
            need(begin == cpu == 0, 'count mode has timings')
        last = end
        need(kind in (1, 2) and error >= 0, 'invalid event kind/error')
        need(error > 0 if result < 0 else error == 0, 'invalid errno')
        if kind == 1:
            need(0 < requested <= 16384 and flags == 0 and result <= requested and result >= -1,
                 'invalid read event')
        else:
            need(requested == 0 and flags & 0x80000000 and flags & ~0x8000ffff == 0,
                 'unexpected poll shape')
            need(-1 <= result <= 1 and (result > 0 or flags == 0x80000000), 'invalid poll result')
    return tid, events


def pass_summary(p, events, timed, tid):
    begin, end = p['begin_ns'], p['end_ns']
    need(type(begin) is int and type(end) is int and begin < end, 'invalid pass window')
    inside = [e for e in events if begin <= e[0] <= end]
    reads = [e for e in inside if e[5] == 1]
    polls = [e for e in inside if e[5] == 2]
    positive = [e for e in reads if e[4] > 0]
    total = sum(e[4] for e in positive)
    need(total == p['bytes'] + 3, f'byte mismatch: {p["workload"]}/{p["pass"]}: {total}')
    sizes = Counter(e[4] for e in positive)
    out = {'workload': p['workload'], 'pass': p['pass'], 'bytes_with_query': total,
           'read_calls': len(reads), 'poll_calls': len(polls),
           'read_sizes': dict(sorted(sizes.items())),
           'read_errors': dict(Counter(e[6] for e in reads if e[4] < 0)),
           'poll_quiet': sum(e[4] == 0 for e in polls),
           'mean_positive_read_bytes': total / len(positive),
           'reads_over_4096': sum(e[4] > 4096 for e in positive),
           'bytes_in_reads_over_4096': sum(e[4] for e in positive if e[4] > 4096),
           'pass_wall_ns': end-begin}
    if timed:
        # Entry may precede the pass for a read blocked waiting for producer data.
        # Its result still belongs by exit, but its whole latency does not.
        whole = [e for e in inside if e[1] >= begin]
        straddles = [e for e in events if e[1] < begin < e[0] or e[1] < end < e[0]]
        task = [d for d in p['terminal_deltas'] if d['tid'] == tid and d['name'] == 'pty-read']
        need(len(task) == 1, 'missing reader CPU delta')
        out.update(boundary_straddles=len(straddles),
                   reader_snapshot_runtime_ns=task[0]['runtime_ns'],
                   snapshot_uncertainty_ns=task[0]['snapshot_uncertainty_ns'])
        for kind, name in ((1, 'read'), (2, 'poll')):
            calls = [e for e in whole if e[5] == kind]
            out[name+'_whole_calls'] = len(calls)
            out[name+'_wall_ns'] = sum(e[0]-e[1] for e in calls)
            out[name+'_cpu_ns'] = sum(e[2] for e in calls)
        # Inclusive wrapper time, not kernel-only or pure syscall CPU time.
        out['whole_call_wall_fraction'] = (out['read_wall_ns']+out['poll_wall_ns'])/(end-begin)
        need(0 <= out['whole_call_wall_fraction'] <= 1, 'overlapping call time')
    return out


def analyze(root):
    root = root.resolve()
    manifest = load(root/'manifest.json')
    need(manifest['schema'] == 'glass.read-shape-run/v1' and manifest['complete'] is True,
         'incomplete/unknown manifest')
    rounds = manifest['rounds']
    need(type(rounds) is int and rounds > 0, 'invalid rounds')
    orders = [list(x) for x in itertools.islice(itertools.cycle(itertools.permutations(ARMS)), rounds)]
    need(manifest['orders'] == manifest['planned_orders'] == orders, 'invalid order')
    expected_sources = {str((BENCH/name).resolve()) for name in ('read-shape.c', 'run-read-shape.sh', 'pipeline-profile.py')}
    expected_sources |= {str((BENCH.parent/name).resolve()) for name in ('lib.sh', 'tput.py')}
    expected_sources |= {manifest['binary'], manifest['observer']}
    need(set(manifest['sha256']) == expected_sources, 'invalid source set')
    for path, digest in manifest['sha256'].items():
        need(sha(Path(path)) == digest, f'changed executable/harness: {path}')
    expected_raw = set()
    for arm in ARMS:
        for r in range(1, rounds+1):
            expected_raw.update(f'tput-{arm}-{r}{suffix}' for suffix in ('.json', '.profile.json', '.producer.py'))
            if arm != 'plain':
                expected_raw.add(f'{arm}-{r}.trace')
    need(set(manifest['raw_sha256']) == expected_raw, 'invalid raw manifest')
    actual = {p.name for p in root.iterdir() if p.suffix in ('.json', '.jsonl', '.py', '.trace') and p.name != 'manifest.json'}
    need(actual == expected_raw, 'unexpected/missing raw file')
    for path, digest in manifest['raw_sha256'].items():
        p = root/path
        need(not p.is_symlink() and sha(p) == digest, f'changed raw: {path}')
    sessions, observations, payloads = {}, [], {}
    for arm in ARMS:
        sessions[arm] = []
        for r in range(1, rounds+1):
            stem = root/f'tput-{arm}-{r}'
            raw, profile = load(stem.with_suffix('.json')), load(stem.with_suffix('.profile.json'))
            need((raw['cols'], raw['rows']) == (154, 39) and set(raw['results']) == set(WORK), 'raw shape')
            need(profile['schema'] == 'glass.pipeline-profile/v1' and profile['complete'] is True
                 and profile['sample_ms'] == 0 and len(profile['passes']) == 18, 'profile shape')
            need(profile['result_sha256'] == sha(stem.with_suffix('.json')) and
                 profile['derived_sha256'] == sha(stem.with_suffix('.producer.py')) and
                 profile['payload_sha256'] == sha(BENCH.parent/'tput.py') and
                 profile['wrapper_sha256'] == sha(BENCH/'pipeline-profile.py'), 'profile provenance')
            tid, events = decode(root/f'{arm}-{r}.trace', arm) if arm != 'plain' else (None, [])
            if arm != 'plain':
                # A process destructor may snapshot before its last reader call.
                # Require that the actually dumped prefix encloses every pass;
                # do not advertise an exhaustive process-lifetime syscall log.
                need(events and events[0][0] < profile['passes'][0]['begin_ns']
                     and events[-1][0] > profile['passes'][-1]['end_ns'], 'trace does not enclose passes')
            for i, p in enumerate(profile['passes']):
                name = WORK[i//3]
                need((p['workload'], p['pass']) == (name, i%3), 'pass sequence')
                need((p['bytes'], p['payload_sha256']) == payloads.setdefault(name, (p['bytes'], p['payload_sha256'])), 'payload changed')
                need(p['bytes'] == raw['results'][name]['bytes'] and number(p['wall_s']), 'pass size/time')
                need([w['bytes'] for w in p['writes']] == [p['bytes'], 3], 'producer writes')
                need(i == 0 or p['begin_ns'] > profile['passes'][i-1]['end_ns'], 'pass overlap')
                if arm != 'plain':
                    row = pass_summary(p, events, arm == 'timed', tid)
                    row.update(arm=arm, round=r)
                    observations.append(row)
            for name, row in raw['results'].items():
                passes = [p for p in profile['passes'] if p['workload'] == name]
                need(all(number(x) for x in row['secs']) and len(row['secs']) == 3 and number(row['mb_s']), 'invalid result')
                need(row['secs'] == [round(p['wall_s'], 3) for p in passes], 'pass time mismatch')
                need(row['mb_s'] == round(row['bytes']/min(p['wall_s'] for p in passes)/1e6, 1), 'rate mismatch')
            sessions[arm].append(raw)
    comparisons = {arm: {name: sign([a['results'][name]['mb_s']/b['results'][name]['mb_s']
                    for a,b in zip(sessions[arm],sessions['plain'])]) for name in WORK} for arm in ARMS[1:]}
    aggregates = {}
    for arm in ARMS[1:]:
        aggregates[arm] = {}
        for name in WORK:
            rows = [p for p in observations if p['arm'] == arm and p['workload'] == name]
            sizes = Counter()
            for row in rows:
                sizes.update(row['read_sizes'])
            total, calls = sum(p['bytes_with_query'] for p in rows), sum(p['read_calls'] for p in rows)
            a = dict(passes=len(rows), positive_read_bytes=total, read_calls=calls,
                     poll_calls=sum(p['poll_calls'] for p in rows),
                     mean_positive_read_bytes=total/sum(sizes.values()),
                     read_fraction_over_4096=sum(p['reads_over_4096'] for p in rows)/sum(sizes.values()),
                     byte_fraction_in_reads_over_4096=sum(p['bytes_in_reads_over_4096'] for p in rows)/total,
                     maximum_read_bytes=max(sizes), top_read_sizes=sizes.most_common(12),
                     median_pass_mean_read_bytes=median([p['mean_positive_read_bytes'] for p in rows]),
                     poll_quiet_fraction=sum(p['poll_quiet'] for p in rows)/sum(p['poll_calls'] for p in rows))
            if arm == 'timed':
                a.update({f'median_{key}':median([p[key] for p in rows]) for key in
                          ('whole_call_wall_fraction', 'read_wall_ns', 'read_cpu_ns', 'poll_wall_ns', 'poll_cpu_ns',
                           'reader_snapshot_runtime_ns', 'snapshot_uncertainty_ns', 'boundary_straddles')})
            aggregates[arm][name] = a
    return dict(schema='glass.read-shape-analysis/v1', rounds=rounds, sessions=rounds*3,
                passes=rounds*54, manifest_sha256=sha(root/'manifest.json'),
                comparisons_to_plain=comparisons, aggregates=aggregates, observations=observations,
                note='Read-only integrity/consistency replay, not timing accuracy or an official score. '
                     'Correlated passes; shared host; uncorrected sign tests. Instrumentation perturbs scheduling. '
                     'Timed whole calls exclude boundary straddles; inclusive wrapper clocks, not kernel-only. '
                     'Outside calls includes ioctl, handoff and scheduling; no blocked/runnable decomposition.')


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('directory', type=Path)
    p.add_argument('--check', type=Path, help='compare stored derived report; never rewrite it')
    args = p.parse_args()
    try:
        result = analyze(args.directory)
        if args.check:
            need(load(args.check) == json.loads(json.dumps(result)), 'derived report changed')
            print(json.dumps({'replayed':result['sessions'], 'manifest_sha256':result['manifest_sha256']}))
        else:
            print(json.dumps(result, indent=2))
    except (OSError, ValueError, KeyError, TypeError, struct.error, ZeroDivisionError) as e:
        print(f'read-shape replay failed: {e}', file=sys.stderr)
        raise SystemExit(1)


if __name__ == '__main__':
    main()
