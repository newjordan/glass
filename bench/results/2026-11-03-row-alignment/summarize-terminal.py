#!/usr/bin/env python3
"""Replay this cyclic (not full-permutation) terminal run without relabeling it."""
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import shutil
import statistics

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('compare', ROOT / 'bench/compare-tput.py')
compare = importlib.util.module_from_spec(spec)
spec.loader.exec_module(compare)
terms = ['glass-alt', 'glass', 'ghostty']  # Candidate is numerator.
s = compare.summarize(OUT, terms, 18)
orders = [['glass', 'glass-alt', 'ghostty'], ['glass-alt', 'ghostty', 'glass'],
          ['ghostty', 'glass', 'glass-alt']] * 6
observed = [(term, int(r)) for term, r in re.findall(
    r'^(glass|glass-alt|ghostty) (\d+) 154 x 39 ',
    (OUT / 'terminal-run.log').read_text(), re.MULTILINE)]
expected = [(term, r) for r, order in enumerate(orders, 1) for term in order]
if observed != expected:
    raise ValueError('launch log does not match all 54 cyclic terminal records')
s.update(schema='glass.cyclic-terminal-comparison/v1', rounds=18, terms=terms,
         orders=orders, complete=True, multiple_testing_corrected=False,
         caveat='Cyclic balance only, not six-permutation compare-tput protocol; shared host.')
s['medians_fps'] = {}
s['medians_term_cpu_s'] = {}
s['cpu_ratios'] = {}
for term in terms:
    ds = [json.loads((OUT / 'terminal' / f'tput-{term}-{r}.json').read_text()) for r in range(1, 19)]
    s['medians_fps'][term] = statistics.median(d['results']['tui_frames']['fps'] for d in ds)
    s['medians_term_cpu_s'][term] = {w: statistics.median(d['results'][w]['term_cpu_s'] for d in ds)
                                       for w in compare.WORKLOADS}
    if term != terms[0]:
        cand = [json.loads((OUT / 'terminal' / f'tput-glass-alt-{r}.json').read_text()) for r in range(1, 19)]
        s['cpu_ratios'][term] = {w: statistics.median(b['results'][w]['term_cpu_s'] / a['results'][w]['term_cpu_s']
            for a, b in zip(cand, ds)) for w in compare.WORKLOADS}
paths = {'glass': Path('/tmp/glass-i12-control-bin'),
         'glass-alt': Path('/tmp/glass-i12-aligned-bin'),
         'ghostty': Path(shutil.which('ghostty'))}
s['binaries'] = {k: {'path': str(p.resolve()), 'sha256': hashlib.sha256(p.read_bytes()).hexdigest()} for k, p in paths.items()}
s['harness_sha256'] = {name: hashlib.sha256((ROOT / 'bench' / name).read_bytes()).hexdigest()
                       for name in ['lib.sh', 'run-tput.sh', 'tput.py', 'compare-tput.py']}
p = OUT / 'terminal-summary.json'
text = json.dumps(s, indent=2) + '\n'
if p.exists():
    assert p.read_text() == text, 'terminal replay differs'
else:
    p.write_text(text)
print(json.dumps(s, indent=2))
