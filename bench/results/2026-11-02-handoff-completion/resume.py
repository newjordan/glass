#!/usr/bin/env python3
"""Complete frozen interrupted gate in a fresh directory; keep old evidence intact."""
import hashlib
import importlib.util
import itertools
import json
import os
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[3]
OLD = ROOT / 'bench/results/2026-11-02-bounded-handoff/gate'
OUT = Path(__file__).resolve().parent / 'gate'
spec = importlib.util.spec_from_file_location('compare', ROOT / 'bench/compare-tput.py')
compare = importlib.util.module_from_spec(spec)
spec.loader.exec_module(compare)
report = json.loads((OLD / 'terminal-summary.json').read_text())
assert report['complete'] is False and report['rounds'] == 18
terms = report['terms']
orders = list(itertools.permutations(terms))
assert report['orders'] == [list(orders[i % len(orders)]) for i in range(14)]
for binary in report['binaries'].values():
    assert compare.digest(binary['path']) == binary['sha256']
for path, sha in report['harness_sha256'].items():
    assert compare.digest(path) == sha
assert compare.digest(ROOT / 'bench/compare-tput.py') == report['runner_sha256']
inherited = compare.summarize(OLD, terms, 14)
assert len(inherited['raw_sha256']) == 42
OUT.mkdir(exist_ok=False)
shutil.copytree(OLD / 'terminal', OUT / 'terminal')
(OUT / 'continuation.json').write_text(json.dumps({
    'source_report': str((OLD / 'terminal-summary.json').relative_to(ROOT)),
    'source_report_sha256': compare.digest(OLD / 'terminal-summary.json'),
    'inherited_rounds': 14, 'inherited_raw_sha256': inherited['raw_sha256'],
    'note': 'Rounds 1-14 inherited unchanged; 15-18 after turn interruption. Not an uninterrupted replication.'
}, indent=2) + '\n')
env = {k:v for k,v in os.environ.items() if not k.startswith('GLASS_') and k != 'GLASS'}
env.update({compare.ENV_BIN[t]: b['path'] for t,b in report['binaries'].items()})
with (OUT / 'terminal.log').open('w') as log:
    for r in range(15,19):
        order = orders[(r-1) % len(orders)]
        run_env = dict(env, TERMS=' '.join(order), ROUNDS=str(r), OUT=str(OUT / 'terminal'))
        subprocess.run(['bash', str(ROOT / 'bench/run-tput.sh')], env=run_env,
                       stdout=log, stderr=subprocess.STDOUT, check=True, timeout=3600)
        compare.summarize(OUT, terms, r)
        report['orders'].append(list(order))
        print(f'round {r}/18: {order}', flush=True)
for binary in report['binaries'].values():
    assert compare.digest(binary['path']) == binary['sha256']
for path, sha in report['harness_sha256'].items():
    assert compare.digest(path) == sha
assert compare.summarize(OUT, terms, 14)['raw_sha256'] == inherited['raw_sha256']
report.update(compare.summarize(OUT, terms, 18))
report['complete'] = True
report['continuation'] = 'continuation.json'
(OUT / 'terminal-summary.json').write_text(json.dumps(report, indent=2) + '\n')
for other, metrics in report['comparisons'].items():
    print(other)
    for name, m in metrics.items():
        print(name, m['median_ratio'], m['wins'], m['sign_p_two_sided'])
