#!/usr/bin/env python3
"""Real own-parent affinity cleanup, injected waits/failures; NOT timed evidence."""
import importlib.util
import json
import os
from pathlib import Path
import signal
import threading
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
spec = importlib.util.spec_from_file_location('hot_wrapper', ROOT/'bench/linux/hot-placement.py')
w = importlib.util.module_from_spec(spec)
spec.loader.exec_module(w)
protocol = HERE/'protocol.json'
binary = ROOT/'target/release/glass'
parent = os.getppid()
roles, _ = w.own_roles(parent)
original = {k: sorted(os.sched_getaffinity(t['tid'])) for k,t in roles.items()}
output = HERE/'signal-smoke'
output.mkdir()
rows = []

for sig in (signal.SIGTERM, signal.SIGHUP, signal.SIGINT):
    out = output/f'{sig.name}.json'
    def interrupted_payload(*args, **kw):
        def deliver():
            time.sleep(.02)
            os.kill(os.getpid(), sig)
        sender = threading.Thread(target=deliver, daemon=True)
        sender.start()
        try:
            time.sleep(10)
        finally:
            sender.join(timeout=1)
    w.runpy.run_path = interrupted_payload
    try:
        w.run(out, binary, protocol, 'd01')
        raise AssertionError('signal failed to interrupt')
    except InterruptedError:
        pass
    meta = json.loads(out.with_suffix('.placement.json').read_text())
    assert meta['complete'] is False and not meta['cleanup_errors']
    assert not out.exists()
    assert all(sorted(os.sched_getaffinity(t['tid'])) == original[k] == meta['roles_restored'][k]['allowed'] for k,t in roles.items())
    rows.append(dict(case=sig.name, complete=meta['complete'], restored=True))

# Exercise partial setup: first pin really succeeds, second pin throws. Cleanup
# must still attempt both saved masks, not just the last successful assignment.
out = output/'partial-setup.json'
real_set = w.os.sched_setaffinity
calls = []
def fail_second(tid, mask):
    calls.append((tid, list(mask)))
    if len(calls) == 2:
        raise OSError('injected second-pin failure')
    real_set(tid, mask)
w.os.sched_setaffinity = fail_second
try:
    try:
        w.run(out, binary, protocol, 'd01')
        raise AssertionError('pin failure not propagated')
    except OSError as error:
        assert str(error) == 'injected second-pin failure'
finally:
    w.os.sched_setaffinity = real_set
meta = json.loads(out.with_suffix('.placement.json').read_text())
assert meta['complete'] is False and not meta['cleanup_errors'] and len(calls) == 4
assert all(sorted(os.sched_getaffinity(t['tid'])) == original[k] == meta['roles_restored'][k]['allowed'] for k,t in roles.items())
rows.append(dict(case='partial-setup', complete=meta['complete'], restored=True, set_attempts=len(calls)))

report = dict(schema='glass.hot-placement-cleanup/v1', cases=rows,
              note='Real own-parent two-thread pins and mask restoration; injected waits/failure, not benchmark evidence.')
(HERE/'signal-smoke-replay.json').write_text(json.dumps(report, indent=2)+'\n')
print(json.dumps(report), flush=True)
