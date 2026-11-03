#!/usr/bin/env python3
"""Own-reader contention capture. Artificial diagnostic, never a default score."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import select
import subprocess
import time

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location('contention_profile', HERE/'pipeline-profile.py')
profile = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(profile)


def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def find_reader(pid):
    deadline = time.monotonic()+10
    while time.monotonic() < deadline:
        rows = profile.terminal_snapshot(pid)
        reader = [r for r in rows if r['name'] == 'pty-read']
        if len(reader) == 1:
            return reader[0], rows
        if len(reader) > 1:
            raise ValueError('ambiguous reader')
        time.sleep(.01)
    raise ValueError('no own reader')


def run(out, helper, binary, mode, cpu):
    out = out.resolve()
    sidecar = out.with_suffix('.contention.json')
    if any(p.exists() for p in (out, sidecar, out.with_suffix('.profile.json'))):
        raise ValueError('refusing to overwrite measurement')
    terminal = os.getppid()
    if Path(f'/proc/{terminal}/exe').resolve() != binary.resolve():
        raise ValueError('not a direct child of exact terminal')
    reader, threads = find_reader(terminal)
    tid, original = reader['tid'], os.sched_getaffinity(reader['tid'])
    if cpu not in original or cpu not in os.sched_getaffinity(0):
        raise ValueError('CPU outside original reader/producer masks')
    meta = dict(schema='glass.reader-contention/v1', complete=False, mode=mode, cpu=cpu,
                terminal_pid=terminal, reader_tid=tid, reader_start_ticks=reader['start_ticks'],
                reader_allowed_before=sorted(original), producer_allowed=sorted(os.sched_getaffinity(0)),
                terminal_threads_before=threads, binary_sha256=sha(binary), helper_sha256=sha(helper),
                wrapper_sha256=sha(__file__), profile_sha256=sha(HERE/'pipeline-profile.py'))
    # Initial record is exclusive; a failed capture retains complete:false.
    with sidecar.open('x') as f:
        f.write(json.dumps(meta, indent=2)+'\n')
    child = None
    succeeded = False
    try:
        os.sched_setaffinity(tid, {cpu})
        meta['reader_allowed_during'] = sorted(os.sched_getaffinity(tid))
        child = subprocess.Popen([str(helper.resolve()), mode, str(cpu)], stdin=subprocess.PIPE,
                                 stdout=subprocess.PIPE, text=True)
        if not select.select([child.stdout], [], [], 10)[0]:
            raise ValueError('helper readiness timeout')
        ready = json.loads(child.stdout.readline())
        if ready != dict(pid=child.pid, cpu=cpu, mode=mode, ready=True):
            raise ValueError('helper readiness mismatch')
        meta['helper_ready'] = ready
        meta['helper_allowed'] = sorted(os.sched_getaffinity(child.pid))
        meta['treatment_begin_ns'] = time.monotonic_ns()
        profile.run(out, 0)
        if child.poll() is not None:
            raise ValueError('helper exited before payload completed')
        meta['treatment_end_ns'] = time.monotonic_ns()
        after, rows = find_reader(terminal)
        if after['tid'] != tid or after['start_ticks'] != reader['start_ticks']:
            raise ValueError('reader identity changed')
        meta['terminal_threads_during_after'] = rows
        if os.sched_getaffinity(tid) != {cpu}:
            raise ValueError('reader affinity changed')
        succeeded = True
    finally:
        cleanup_ok = False
        try:
            if child:
                child.stdin.close()  # EOF is the normal helper exit signal.
                try:
                    child.wait(timeout=10)
                except subprocess.TimeoutExpired:
                    child.kill()
                    child.wait()
                    raise ValueError('helper teardown timeout')
                remaining = child.stdout.read()
                child.stdout.close()
                if child.returncode != 0:
                    raise ValueError(f'helper exit {child.returncode}')
                meta['helper_finish'] = json.loads(remaining)
                if meta['helper_finish'].get('complete') is not True:
                    raise ValueError('helper incomplete')
            cleanup_ok = True
        finally:
            # Do not act on a recycled TID, even during exceptional cleanup.
            live = profile.task_snapshot(terminal, tid)
            if live and live['start_ticks'] == reader['start_ticks']:
                os.sched_setaffinity(tid, original)
                meta['reader_allowed_restored'] = sorted(os.sched_getaffinity(tid))
            else:
                succeeded = False
                meta['cleanup_error'] = 'reader no longer exists or identity changed'
            if succeeded and cleanup_ok:
                meta.update(complete=True, result_sha256=sha(out),
                            profile_result_sha256=sha(out.with_suffix('.profile.json')))
            sidecar.write_text(json.dumps(meta, indent=2)+'\n')
    if not succeeded:
        raise ValueError('incomplete capture')


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('out', type=Path)
    p.add_argument('--helper', required=True, type=Path)
    p.add_argument('--binary', required=True, type=Path)
    p.add_argument('--mode', required=True, choices=('sleep', 'busy'))
    p.add_argument('--cpu', required=True, type=int)
    a = p.parse_args()
    run(a.out, a.helper, a.binary, a.mode, a.cpu)


if __name__ == '__main__':
    main()
