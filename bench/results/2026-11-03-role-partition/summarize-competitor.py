#!/usr/bin/env python3
"""Read-only independent exact-build competitor summary. No launch or repair."""
import hashlib
import importlib.util
import json
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
spec = importlib.util.spec_from_file_location('terminal_replay', ROOT/'bench/replay-terminal-pairs.py')
r = importlib.util.module_from_spec(spec)
spec.loader.exec_module(r)

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def summarize():
    directory = HERE/'shipping-vs-ghostty'
    report = r.load(directory/'terminal-summary.json')
    protocol = r.load(HERE/'competitor-protocol.json')
    r.require(report['rounds'] == protocol['rounds'] == 30 and report['terms'] == protocol['terms'] == ['glass','ghostty'], 'not frozen competitor design')
    for path, digest in protocol['sha256'].items():
        r.require(sha(Path(path)) == digest, 'changed protocol source/executable')
    result = r.validate(directory,verify_binaries=True)
    metrics = {}
    for name in r.WORKLOADS:
        ratios, cpu = [], []
        for i in range(1,31):
            rows = {t:r.load(directory/'terminal'/f'tput-{t}-{i}.json')['results'][name] for t in ('glass','ghostty')}
            ratios.append(rows['glass']['mb_s']/rows['ghostty']['mb_s'])
            r.require(rows['glass']['term_cpu_s'] > 0 and rows['ghostty']['term_cpu_s'] > 0, 'cannot calculate CPU ratio')
            cpu.append(rows['glass']['term_cpu_s']/rows['ghostty']['term_cpu_s'])
        wins,losses = sum(x>1 for x in ratios),sum(x<1 for x in ratios)
        metrics[name] = dict(ratios=ratios,median_ratio=statistics.median(ratios),wins=wins,losses=losses,
                             ties=30-wins-losses,sign_p_two_sided=r.sign_p(wins,losses),
                             descriptive_median_cpu_ratio=statistics.median(cpu))
    largest = 0.
    for i,(_,row) in enumerate(sorted(metrics.items(),key=lambda item:item[1]['sign_p_two_sided'])):
        largest=max(largest,min(1.,(6-i)*row['sign_p_two_sided']))
        row['holm_p_six_workloads']=largest
        row['throughput_lead_clears']=row['median_ratio']>1 and row['wins']>row['losses'] and largest<.05
    return dict(schema='glass.champion-refresh-summary/v1',sessions=60,rounds=30,metrics=metrics,
                all_six_throughput_leads=all(row['throughput_lead_clears'] for row in metrics.values()),
                note='Integrity and conditional within-series throughput only. CPU ratios descriptive. No world title, every-metric or cross-series pooled claim.',
                replay=result,protocol_sha256=sha(HERE/'competitor-protocol.json'))

if __name__ == '__main__':
    print(json.dumps(summarize(),indent=2))
