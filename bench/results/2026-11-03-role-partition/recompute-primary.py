#!/usr/bin/env python3
"""Independent raw median/ninth-order calculation, not another experiment."""
import json
from pathlib import Path
import statistics

root=Path(__file__).resolve().parent
report=json.loads((root/'confirmatory-replay.json').read_text())
for name,row in report['comparisons']['split_vs_auto'].items():
    ratios=[]
    for i in range(1,31):
        rates={arm:json.loads((root/'confirmatory'/f'tput-{arm}-{i}.json').read_text())['results'][name]['mb_s'] for arm in ('auto','ab','ba')}
        ratios.append((rates['ab']*rates['ba'])**.5/rates['auto'])
    assert statistics.median(ratios)==row['median_ratio'], name
    assert sorted(ratios)[8]==row['prospective_lower_bound']['value'], name
print('Six primary paired medians and ninth-order lower bounds reproduced from raw MB/s.')
