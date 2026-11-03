#!/usr/bin/env python3
"""Untimed guard checks through the real speed entry point; separate from screen."""
import hashlib
import json
import os
from pathlib import Path
import subprocess

D = Path(__file__).resolve().parent
b = json.loads((D/'binary.json').read_text())
assert hashlib.sha256(Path(b['path']).read_bytes()).hexdigest() == b['sha256']
env = {k:v for k,v in os.environ.items() if not k.startswith('GLASS_')}
rows = []
sentinel = D/'must-not-overwrite.txt'
with sentinel.open('x') as f:
    f.write('retained sentinel\n')

for label, more, message in [
    ('existing-file', dict(GLASS_BENCH_SAMPLES=str(sentinel)), 'sample path must be new and writable'),
    ('zero-rounds', dict(GLASS_BENCH_ROUNDS='0'), 'rounds and read must be positive'),
    ('zero-read', dict(GLASS_BENCH_READ='0'), 'rounds and read must be positive'),
    ('pty-clock', dict(GLASS_BENCH_SAMPLES=str(D/'pty-refused.jsonl'), GLASS_BENCH_PTY='1'), 'pass samples support only the in-memory path'),
    ('partial-feed', dict(GLASS_BENCH_SAMPLES=str(D/'partial-refused.jsonl'), GLASS_BENCH_STAGE='1'), 'pass samples require the complete feed path'),
    ('no-workloads', dict(GLASS_BENCH_ONLY='not-a-workload'), 'no workload matched GLASS_BENCH_ONLY'),
]:
    settings = dict(GLASS_BENCH_SCALE='0.0001', GLASS_BENCH_ONLY='ascii', GLASS_BENCH_ROUNDS='1') | more
    p = subprocess.run([b['path'], '--exact', '--ignored', '--nocapture', 'speed::speed'],
                       env=env|settings, capture_output=True, text=True, timeout=60)
    with (D/(label+'.guard.log')).open('x') as f:
        f.write(p.stdout+p.stderr)
    assert p.returncode != 0 and message in p.stderr and 'test result: FAILED. 0 passed; 1 failed;' in p.stdout, label
    rows.append(dict(case=label, exit=p.returncode, expected_diagnostic=message, rejected=True))
assert sentinel.read_text() == 'retained sentinel\n'
assert not (D/'pty-refused.jsonl').exists() and not (D/'partial-refused.jsonl').exists()
print(json.dumps(dict(schema='glass.pass-sample-guards/v1', rejected=len(rows), cases=rows,
                      limits='Failure-path checks only. No performance sample or runtime correctness claim.'), indent=2))
