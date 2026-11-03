#!/usr/bin/env python3
"""Read-only dispersion of the completed fixed screen; no new gate or pooling."""
import json
from pathlib import Path
import importlib.util
import math
import statistics

D = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('mark_replay', D / 'analyze.py')
a = importlib.util.module_from_spec(spec)
spec.loader.exec_module(a)


def check():
    report = a.analyze(a.load(D / 'raw.json'))
    rows = {}
    for name, entry in report['summary'].items():
        ratios = entry['cpu_ratios']
        ordered = sorted(ratios)
        rows[name] = dict(
            ratios=ratios,
            median=statistics.median(ratios),
            min=min(ratios), max=max(ratios),
            control_first_median=statistics.median(ratios[::2]),
            candidate_first_median=statistics.median(ratios[1::2]),
            first_six_median=statistics.median(ratios[:6]),
            last_six_median=statistics.median(ratios[6:]),
            iid_continuous_median_interval_coverage=1 - 2 * sum(math.comb(12, k) for k in range(3)) / 2**12,
            iid_continuous_median_interval=[ordered[2], ordered[9]],
        )
    return dict(schema='glass.local-mark-dispersion/v1', workloads=rows,
                limits='Post-hoc description, not an additional acceptance gate or a causal diagnosis. '
                       'Order strata each have six pairs. Exact order-statistic interval assumes independent '
                       'identically distributed continuous ratios; shared-host drift can invalidate that assumption. '
                       'No sensitivity filter, exclusions, new timing or pooling. Original failed screen unchanged.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
