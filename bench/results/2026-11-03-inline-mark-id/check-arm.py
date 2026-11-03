#!/usr/bin/env python3
"""Run existing terminal checks against one exact retained executable, without cargo."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
arm = sys.argv[1]
assert arm in ('control', 'candidate')
identity = json.loads((D / ('build-' + arm) / 'identity.json').read_text())
exe = identity['executable']
assert hashlib.sha256(Path(exe).read_bytes()).hexdigest() == identity['sha256']
env = {k: v for k, v in os.environ.items() if not k.startswith('GLASS_')}
commands = [
    ('edge', ['--exact', 'speed::unicode_row_edges_preserve_pending_wrap', '--nocapture'], {}),
    ('suite', [], {}),
    ('sweep', ['--ignored', '--exact', 'speed::plain_runs_match_the_parser_over_seeds', '--nocapture'],
     dict(GLASS_SWEEP_SEEDS='64', GLASS_SWEEP_ROUNDS='200', GLASS_SWEEP_FROM='1')),
]
rows = []
for label, args, settings in commands:
    argv = [exe] + args
    start = time.monotonic_ns()
    proc = subprocess.run(argv, cwd=ROOT, env=env | settings, capture_output=True, text=True, timeout=900)
    with (D / f'{arm}-{label}.log').open('x') as out:
        out.write(proc.stdout + proc.stderr)
    with (D / f'{arm}-{label}.exit').open('x') as out:
        out.write(str(proc.returncode) + '\n')
    rows.append(dict(label=label, argv=argv, settings=settings, exit=proc.returncode,
                     start_ns=start, end_ns=time.monotonic_ns(),
                     binary_sha256=identity['sha256'],
                     log_sha256=hashlib.sha256((D / f'{arm}-{label}.log').read_bytes()).hexdigest()))
    (D / f'{arm}-checks.json').write_text(json.dumps(rows, indent=2) + '\n')
    print(arm, label, proc.returncode, flush=True)
    assert proc.returncode == 0, (arm, label)
assert hashlib.sha256(Path(exe).read_bytes()).hexdigest() == identity['sha256']
