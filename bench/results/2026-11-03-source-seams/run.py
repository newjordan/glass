#!/usr/bin/env python3
"""Capture actual subprocess exits, explicit commands, logs and byte identities."""
from pathlib import Path
import hashlib
import json
import os
import subprocess

D = Path(__file__).resolve().parent
runs = []
for label, arm, args in [
    ('control', 'control', ['--exact', 'intake::position_tests::source_seams_real_apc_row_oracle', '--test-threads=1', '--nocapture']),
    ('candidate', 'candidate', ['--exact', 'intake::position_tests::source_seams_real_apc_row_oracle', '--test-threads=1', '--nocapture']),
    ('full-candidate', 'candidate', ['--test-threads=1']),
    ('sweep-control', 'control', ['--exact', 'speed::plain_runs_match_the_parser_over_seeds', '--ignored', '--test-threads=1', '--nocapture']),
    ('sweep-candidate', 'candidate', ['--exact', 'speed::plain_runs_match_the_parser_over_seeds', '--ignored', '--test-threads=1', '--nocapture']),
]:
    binary = Path('/tmp/glass-i43-' + arm)
    env = {'GLASS_SCROLLBACK': '10000'}
    if label.startswith('sweep-'):
        env.update(GLASS_SWEEP_SEEDS='64', GLASS_SWEEP_ROUNDS='200')
    argv = [str(binary), *args]
    log = D / (label + '.log')
    with log.open('wb') as output:
        result = subprocess.run(argv, env={**os.environ, **env}, stdout=output, stderr=subprocess.STDOUT, timeout=90)
    runs.append({'label': label, 'argv': argv, 'environment': env, 'exit': result.returncode,
                 'binary_sha256': hashlib.sha256(binary.read_bytes()).hexdigest(),
                 'log': log.name, 'log_sha256': hashlib.sha256(log.read_bytes()).hexdigest()})
    print(label, result.returncode, flush=True)
(D / 'runs.json').write_text(json.dumps(runs, indent=2) + '\n')
