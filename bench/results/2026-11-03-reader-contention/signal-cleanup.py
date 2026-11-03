#!/usr/bin/env python3
"""Separate diagnostic cleanup smoke. Not performance evidence."""
import importlib.util
import json
import os
from pathlib import Path
import signal
import sys
import threading
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
spec = importlib.util.spec_from_file_location('wrapper', ROOT/'bench/linux/reader-contention.py')
wrapper = importlib.util.module_from_spec(spec)
spec.loader.exec_module(wrapper)
terminal = os.getppid()
reader, _ = wrapper.find_reader(terminal)
original = os.sched_getaffinity(reader['tid'])
helper = HERE/'reader-contender'
rows = []

for sig in (signal.SIGTERM, signal.SIGHUP, signal.SIGINT):
    out = HERE/'signal-smoke'/f'{sig.name}.json'
    out.parent.mkdir(exist_ok=True)
    def interrupt_payload(_out, _sample):
        # The hook runs after the real reader pin and real helper readiness.
        def deliver():
            time.sleep(.05)
            os.kill(os.getpid(), sig)
        sender = threading.Thread(target=deliver, daemon=True)
        sender.start()
        try:
            time.sleep(10)
        finally:
            sender.join(timeout=1)
    wrapper.profile.run = interrupt_payload
    try:
        wrapper.run(out, helper, ROOT/'target/release/glass', 'busy', 0)
        raise AssertionError('signal did not interrupt')
    except InterruptedError:
        pass
    meta = json.loads(out.with_suffix('.contention.json').read_text())
    restored = os.sched_getaffinity(reader['tid']) == original
    assert restored and meta['complete'] is False
    assert meta['reader_allowed_restored'] == sorted(original)
    assert meta['helper_finish']['complete'] is True
    helper_pid = meta['helper_ready']['pid']
    assert not Path(f'/proc/{helper_pid}').exists()
    rows.append(dict(signal=sig.name, interrupted=True, restored=restored,
                     helper_gone=True, complete=meta['complete']))
report = dict(schema='glass.contention-signal-smoke/v1', cases=rows,
              note='Injected payload wait, real reader pin/helper, not benchmark evidence.')
(HERE/'signal-smoke-replay.json').write_text(json.dumps(report, indent=2)+'\n')
print(json.dumps(report), flush=True)
