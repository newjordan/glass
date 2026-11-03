#!/usr/bin/env python3
"""Disjoint whole-core role masks within one L3; unchanged tput.py.

No sampling, preload, pass instrumentation, producer pinning, or runtime build.
This artificial topology experiment is not a default terminal score.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import runpy
import signal
import sys
import time

BENCH = Path(__file__).resolve().parents[1]
ROLES = ('pty-read', 'pty-parse')
ARMS = ('auto', 'ab', 'ba', 'aa', 'bb')


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def cpu_list(text):
    cpus = set()
    for part in text.strip().split(','):
        ends = part.split('-')
        if len(ends) not in (1, 2) or not all(x.isdecimal() for x in ends):
            raise ValueError('invalid CPU list')
        low, high = int(ends[0]), int(ends[-1])
        if not 0 <= low <= high < 1024:
            raise ValueError('invalid CPU range')
        cpus.update(range(low, high + 1))
    return sorted(cpus)


def topology(cpus):
    result = {}
    for cpu in cpus:
        root = Path(f'/sys/devices/system/cpu/cpu{cpu}')
        caches = [p for p in (root/'cache').glob('index*') if (p/'level').read_text().strip() == '3']
        if len(caches) != 1:
            raise ValueError('ambiguous L3')
        cache = caches[0]
        result[str(cpu)] = dict(siblings=cpu_list((root/'topology/thread_siblings_list').read_text()),
                               core=(root/'topology/core_id').read_text().strip(),
                               package=(root/'topology/physical_package_id').read_text().strip(),
                               l3=cpu_list((cache/'shared_cpu_list').read_text()),
                               l3_size=(cache/'size').read_text().strip())
    return result


def validate_topology(cpus, rows):
    if sorted(set(cpus)) != cpus or len(cpus) < 4 or set(rows) != {str(c) for c in cpus}:
        raise ValueError('invalid L3 CPUs')
    if len({(x['package'], tuple(x['l3']), x['l3_size']) for x in rows.values()}) != 1:
        raise ValueError('different L3 domains')
    groups = set()
    for cpu in cpus:
        row = rows[str(cpu)]
        siblings = row['siblings']
        if row['l3'] != cpus or len(siblings) != 2 or cpu not in siblings or not set(siblings) <= set(cpus):
            raise ValueError('need whole two-way SMT cores in one L3')
        for sibling in siblings:
            other = rows[str(sibling)]
            if other['siblings'] != siblings or (other['core'], other['package']) != (row['core'], row['package']):
                raise ValueError('nonreciprocal SMT topology')
        groups.add(tuple(siblings))
    groups = sorted(groups)
    if len(groups) % 2 or len({(rows[str(g[0])]['package'], rows[str(g[0])]['core']) for g in groups}) != len(groups):
        raise ValueError('need even number of distinct whole cores')
    half = len(groups)//2
    return [sorted(c for group in subset for c in group) for subset in (groups[:half], groups[half:])]


def targets(arm, cpus, original):
    a, b = validate_topology(cpus, topology(cpus))
    pairs = dict(ab=(a,b), ba=(b,a), aa=(a,a), bb=(b,b))
    return original if arm == 'auto' else dict(zip(ROLES, pairs[arm]))


def task(pid, tid):
    root = Path(f'/proc/{pid}/task/{tid}')
    try:
        fields = (root/'stat').read_text().rsplit(')', 1)[1].split()
        return dict(tid=tid, name=(root/'comm').read_text().strip(),
                    start_ticks=int(fields[19]), allowed=sorted(os.sched_getaffinity(tid)))
    except (FileNotFoundError, ProcessLookupError):
        return None


def tasks(pid):
    return [s for p in sorted(Path(f'/proc/{pid}/task').glob('*')) if (s := task(pid, int(p.name)))]


def own_roles(pid):
    deadline = time.monotonic() + 10
    while time.monotonic() < deadline:
        rows = tasks(pid)
        found = {role: [s for s in rows if s['name'] == role] for role in ROLES}
        if all(len(v) == 1 for v in found.values()):
            return {k: v[0] for k, v in found.items()}, rows
        if any(len(v) > 1 for v in found.values()):
            raise ValueError('ambiguous own hot thread')
        time.sleep(.01)
    raise ValueError('missing own hot thread')


def same_task(pid, saved):
    live = task(pid, saved['tid'])
    if not live or (live['name'], live['start_ticks']) != (saved['name'], saved['start_ticks']):
        raise ValueError('hot thread identity changed')
    return live


def atomic_record(path, data):
    # Only the exclusively-created sidecar for this invocation is finalized.
    tmp = path.with_suffix(path.suffix + '.tmp')
    with tmp.open('x') as f:
        f.write(json.dumps(data, indent=2) + '\n')
    os.replace(tmp, path)


def run(out, binary, protocol_path, arm):
    out = out.resolve()
    sidecar = out.with_suffix('.placement.json')
    if out.exists() or sidecar.exists():
        raise ValueError('refusing to overwrite measurement')
    protocol = json.loads(protocol_path.read_text())
    cpus = protocol['cpus']
    topo = topology(cpus)
    validate_topology(cpus, topo)
    if topo != protocol['topology'] or sha(binary) != protocol['binary_sha256']:
        raise ValueError('changed topology or executable')
    pid = os.getppid()
    if Path(f'/proc/{pid}/exe').resolve() != binary.resolve():
        raise ValueError('must be direct child of exact terminal')
    roles, before = own_roles(pid)
    original = {k: s['allowed'] for k, s in roles.items()}
    if not all(cpus == mask for mask in original.values()):
        raise ValueError('not shipping full-L3 original hot masks')
    wanted = targets(arm, cpus, original)
    meta = dict(schema='glass.role-partition/v1', complete=False, arm=arm, terminal_pid=pid,
                roles=roles, original=original, target=wanted, topology=topo,
                producer_allowed=sorted(os.sched_getaffinity(0)), threads_before=before,
                binary_sha256=sha(binary), payload_sha256=sha(BENCH/'tput.py'),
                wrapper_sha256=sha(__file__), protocol_sha256=sha(protocol_path))
    with sidecar.open('x') as f:
        f.write(json.dumps(meta, indent=2)+'\n')
    handlers, saved_argv = {}, sys.argv
    def interrupted(signum, _frame):
        raise InterruptedError(f'capture interrupted: {signum}')
    succeeded = False
    try:
        for sig in (signal.SIGTERM, signal.SIGHUP, signal.SIGINT):
            handlers[sig] = signal.signal(sig, interrupted)
        for role in ROLES:
            same_task(pid, roles[role])
            if arm != 'auto':
                os.sched_setaffinity(roles[role]['tid'], wanted[role])
        during = {k: same_task(pid, s) for k, s in roles.items()}
        if any(s['allowed'] != wanted[k] for k, s in during.items()):
            raise ValueError('affinity did not take effect')
        meta['roles_during'] = during
        meta['threads_during'] = tasks(pid)
        meta['payload_begin_ns'] = time.monotonic_ns()
        sys.argv = [str(BENCH/'tput.py'), str(out)]
        runpy.run_path(str(BENCH/'tput.py'), run_name='__main__')
        meta['payload_end_ns'] = time.monotonic_ns()
        meta['roles_after'] = {k: same_task(pid, s) for k, s in roles.items()}
        meta['threads_after'] = tasks(pid)
        if any(s['allowed'] != wanted[k] for k, s in meta['roles_after'].items()):
            raise ValueError('affinity changed during payload')
        if sorted(os.sched_getaffinity(0)) != meta['producer_allowed']:
            raise ValueError('producer mask changed')
        succeeded = True
    finally:
        sys.argv = saved_argv
        for sig in handlers:
            signal.signal(sig, signal.SIG_IGN)
        errors = []
        restored = {}
        for role, s in roles.items():
            try:
                same_task(pid, s)
                if arm != 'auto':
                    os.sched_setaffinity(s['tid'], original[role])
                restored[role] = same_task(pid, s)
                if restored[role]['allowed'] != original[role]:
                    raise ValueError('restore mask mismatch')
            except Exception as error:
                errors.append(f'{role}: {error}')
        meta.update(roles_restored=restored, cleanup_errors=errors,
                    producer_allowed_after=sorted(os.sched_getaffinity(0)))
        if succeeded and not errors:
            meta.update(complete=True, result_sha256=sha(out))
        try:
            atomic_record(sidecar, meta)
        finally:
            for sig, handler in handlers.items():
                signal.signal(sig, handler)
        if errors:
            raise ValueError('; '.join(errors))


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('out', type=Path)
    p.add_argument('--binary', type=Path, required=True)
    p.add_argument('--protocol', type=Path, required=True)
    p.add_argument('--arm', choices=ARMS, required=True)
    a = p.parse_args()
    run(a.out, a.binary, a.protocol, a.arm)
