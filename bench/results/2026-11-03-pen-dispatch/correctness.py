#!/usr/bin/env python3
"""Fail-closed correctness receipts for the exact arm binaries (no compiler)."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

D = Path(__file__).resolve().parent
arm = sys.argv[1]
assert arm in ('control', 'candidate')
exe = f'/tmp/glass-i32-{arm}-test'
env = {k: v for k, v in os.environ.items() if not k.startswith('GLASS_')}
tasks = [('terminal-tests', []), ('oracle', ['engine::tests::pen_dispatch_preserves_template_and_color_boundaries', '--exact', '--nocapture']), ('sweep', ['speed::plain_runs_match_the_parser_over_seeds', '--exact', '--ignored', '--nocapture'])]
rows = []
for label, args in tasks:
    e = env | (dict(GLASS_SWEEP_SEEDS='64', GLASS_SWEEP_ROUNDS='200') if label == 'sweep' else {})
    with (D / f'{arm}-{label}.log').open('xb') as out:
        p = subprocess.run([exe, *args], env=e, stdout=out, stderr=subprocess.STDOUT, timeout=900)
    text = (D / f'{arm}-{label}.log').read_text()
    assert p.returncode == 0 and 'test result: ok.' in text and '0 failed;' in text, (arm, label, p.returncode)
    if label == 'oracle':
        assert 'pen dispatch explicit oracle:' in text
    if label == 'sweep':
        assert 'swept 12800 streams over 64 seeds: no divergence' in text
    rows.append(dict(task=label, exit_code=p.returncode, log=f'{arm}-{label}.log', sha256=hashlib.sha256(text.encode()).hexdigest()))
print(json.dumps(dict(arm=arm, executable=exe, sha256=hashlib.sha256(Path(exe).read_bytes()).hexdigest(), checks=rows), indent=2))
