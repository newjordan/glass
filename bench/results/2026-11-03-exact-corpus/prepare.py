#!/usr/bin/env python3
"""Run correctness and non-timed byte exports once; never overwrites receipts."""
import hashlib
import json
import os
from pathlib import Path
import subprocess

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()
b = json.loads((D / 'binary.json').read_text())
assert sha(b['path']) == b['sha256']
env = {k:v for k,v in os.environ.items() if not k.startswith('GLASS_')}
rows = []
for label, args, more in [
    ('terminal-tests', [], {}),
    ('sweep', ['speed::plain_runs_match_the_parser_over_seeds', '--exact', '--ignored', '--nocapture'], dict(GLASS_SWEEP_SEEDS='64', GLASS_SWEEP_ROUNDS='200')),
    ('dump-generated', ['speed::dump_generated_corpus', '--exact', '--ignored', '--nocapture'], dict(GLASS_BENCH_DUMP=str(D / 'generated'))),
]:
    with (D / (label + '.log')).open('x') as f:
        proc = subprocess.run([b['path'], *args], env=env|more, stdout=f, stderr=subprocess.STDOUT, timeout=900)
    text = (D / (label + '.log')).read_text()
    assert proc.returncode == 0 and 'test result: ok.' in text and '0 failed;' in text, label
    if label == 'sweep':
        assert 'swept 12800 streams over 64 seeds: no divergence' in text
    rows.append(dict(task=label, exit=proc.returncode, log=label+'.log', sha256=sha(D / (label+'.log'))))
names = json.loads((D / 'protocol.json').read_text())['workloads']
m = dict(schema='glass.generated-corpus/v1', rows=39, cols=154, source_sha256=sha(ROOT / 'crates/term/src/speed.rs'), workloads={})
for name in names:
    path = D / 'generated' / (name + '.bin')
    m['workloads'][name] = dict(bytes=path.stat().st_size, sha256=sha(path))
with (D / 'generated' / 'manifest.json').open('x') as f:
    json.dump(m,f,indent=2); f.write('\n')
with (D / 'correctness.json').open('x') as f:
    json.dump(dict(binary=b, checks=rows),f,indent=2); f.write('\n')
print(json.dumps(rows,indent=2))
