#!/usr/bin/env python3
"""Read-only paired sign-test family report, never reruns or repairs measurements."""
import hashlib
import json
from pathlib import Path
import sys

source = Path(sys.argv[1])
d = json.loads(source.read_text())
assert d['schema'] == 'glass.terminal-pairs/v1' and d['complete']
assert len(d['orders']) == d['rounds'] == 18
out = {'schema': 'glass.exploratory-holm/v1', 'source': str(source),
       'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
       'note': 'Six workloads per comparator; two-sided signs, alpha .05. Not campaign-wide correction. Direction is separate from significance.',
       'families': {}}
for comparator, metrics in d['comparisons'].items():
    assert len(metrics) == 6
    ordered = sorted(metrics.items(), key=lambda item: item[1]['sign_p_two_sided'])
    family = {}; running = 0.
    for i, (name, m) in enumerate(ordered):
        running = min(1., max(running, (6-i)*m['sign_p_two_sided']))
        family[name] = {'median_ratio':m['median_ratio'], 'wins':m['wins'],
                        'losses':m['losses'], 'ties':18-m['wins']-m['losses'],
                        'sign_p_two_sided':m['sign_p_two_sided'], 'holm_adjusted_p':running,
                        'holm_reject_at_05':running <= .05}
    out['families'][comparator] = family
print(json.dumps(out, indent=2))
