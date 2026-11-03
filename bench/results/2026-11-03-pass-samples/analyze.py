#!/usr/bin/env python3
"""Replay the fixed observer check; only descriptive statistics, never acceptance."""
from datetime import datetime
import hashlib
import importlib.util
import json
import lzma
from pathlib import Path
import re
import statistics

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
spec = importlib.util.spec_from_file_location('passes', ROOT/'bench/analyze-engine-passes.py')
a = importlib.util.module_from_spec(spec)
spec.loader.exec_module(a)
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()
need = a.need


def load(p):
    return json.loads(Path(p).read_text(), object_pairs_hook=a.unique)


def analyze(raw):
    p = load(D/'protocol.json')
    binary = load(D/'binary.json')
    corpus = ROOT/p['corpus']
    manifest = load(corpus/'manifest.json')
    need(raw['schema'] == 'glass.pass-sample-screen/v1', 'schema')
    need(raw['protocol_sha256'] == sha(D/'protocol.json'), 'changed protocol')
    need(raw['binary'] == binary, 'changed binary identity')
    need(raw['runner_sha256'] == sha(D/'run.py'), 'changed runner')
    need(raw['analyzer_sha256'] == sha(ROOT/'bench/analyze-engine-passes.py'), 'changed parser')
    need(raw['source_sha256'] == binary['source_sha256'] == sha(ROOT/'crates/term/src/speed.rs'), 'changed test source')
    if Path(binary['path']).exists():
        need(sha(binary['path']) == binary['sha256'], 'changed executable')
    else:
        need(hashlib.sha256(lzma.decompress((D/'diagnostic-test-elf.xz').read_bytes())).hexdigest() == binary['sha256'], 'changed archived executable')
    need(sha(corpus/'manifest.json') == p['corpus_manifest_sha256'], 'changed corpus manifest')
    need(list(manifest['workloads']) == p['workloads'], 'workload set/order')
    shapes = {name: m['bytes'] for name, m in manifest['workloads'].items()}
    for name, m in manifest['workloads'].items():
        path = corpus/(name+'.bin')
        data = path.read_bytes() if path.exists() else lzma.decompress(Path(str(path)+'.xz').read_bytes())
        need(len(data) == m['bytes'] and hashlib.sha256(data).hexdigest() == m['sha256'], 'changed corpus payload')
    settings = dict(GLASS_BENCH_CORPUS=str(corpus), GLASS_BENCH_SCALE='1', GLASS_BENCH_READ=str(p['read']),
                    GLASS_BENCH_ROUNDS=str(p['rounds']), GLASS_BENCH_ONLY=','.join(p['workloads']))
    need(raw['settings'] == settings, 'changed settings')
    sessions = raw['sessions']
    need(len(sessions) == p['pairs']*2, 'incomplete/extra sessions')
    previous = -1
    all_rates, all_passes, sample_rows = {}, {}, {}
    for n, s in enumerate(sessions):
        pair, slot = divmod(n, 2)
        mode = p['orders'][pair % 2][slot]
        stem = f'{pair:02}-{mode}'
        need(type(s['pair']) is int and (s['pair'], s['mode']) == (pair, mode), 'session order')
        need(type(s['begin_ns']) is int and type(s['end_ns']) is int
             and previous <= s['begin_ns'] < s['end_ns'], 'overlap/empty interval')
        previous = s['end_ns']
        utc = datetime.fromisoformat(s['started_utc'])
        need(utc.utcoffset() is not None and utc.utcoffset().total_seconds() == 0
             and abs(utc.timestamp() - s['begin_ns']/1e9) < 0.001, 'missing/mismatched UTC')
        need(type(s['exit']) is int and s['exit'] == 0, 'session failed')
        need(s['argv'] == [binary['path'], '--exact', '--ignored', '--nocapture', 'speed::speed'], 'argv')
        more = {} if mode == 'off' else dict(GLASS_BENCH_SAMPLES=str(D/(stem+'.jsonl')))
        need(s['settings'] == settings|more, 'session settings')
        for kind in ('stdout', 'stderr'):
            need(s[kind] == stem+'.'+kind and sha(D/s[kind]) == s[kind+'_sha256'], 'changed/misnamed log')
        stdout = (D/s['stdout']).read_text()
        need(re.findall(r'^test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', stdout, re.M)
             == [('ok','1','0','0')], 'failed/missing test census')
        text = (D/s['stderr']).read_text()
        rates = re.findall(r'^\s*(\w+):\s+([\d.]+) MB/s\s+([\d.]+) MB/cpu-s\s+\((\d+) bytes, read (\d+)\)$', text, re.M)
        need([r[0] for r in rates] == p['workloads'], 'missing/extra/reordered rate lines')
        parsed = {}
        for name, wall, cpu, size, read in rates:
            need(int(size) == shapes[name] and int(read) == p['read'] and min(float(wall),float(cpu)) > 0, 'invalid rate shape')
            parsed[name] = dict(wall=float(wall), cpu=float(cpu))
        all_rates[pair, mode] = parsed
        if mode == 'on':
            need(s['samples'] == stem+'.jsonl' and sha(D/s['samples']) == s['samples_sha256'], 'changed sample file')
            rows = a.parse((D/s['samples']).read_text(), shapes, p['rounds'], p['read'])
            description = a.describe(rows)
            for name, item in description.items():
                for clock in ('wall', 'cpu'):
                    need(abs(item[clock]['min_mb_s'] - parsed[name][clock]) <= 0.050001, 'summary not derived from retained passes')
            all_passes[pair] = description
            sample_rows[pair] = rows
        else:
            need('samples' not in s and 'samples_sha256' not in s, 'samples in off mode')
    summary = {}
    for name in p['workloads']:
        ratios = [all_rates[i,'on'][name]['cpu']/all_rates[i,'off'][name]['cpu'] for i in range(p['pairs'])]
        walls = [all_rates[i,'on'][name]['wall']/all_rates[i,'off'][name]['wall'] for i in range(p['pairs'])]
        descriptions = [all_passes[i][name] for i in range(p['pairs'])]
        summary[name] = dict(observer_cpu_ratios=ratios, median_observer_cpu_ratio=statistics.median(ratios),
                             observer_wall_ratios=walls, median_observer_wall_ratio=statistics.median(walls),
                             minima_on_different_passes=sum(d['minima_on_different_passes'] for d in descriptions),
                             cpu_median_over_min=[d['cpu']['median_over_min'] for d in descriptions],
                             wall_median_over_min=[d['wall']['median_over_min'] for d in descriptions],
                             retained_cpu_ns=[d['cpu']['ns'] for d in descriptions],
                             retained_wall_ns=[d['wall']['ns'] for d in descriptions],
                             cpu_best_pass_histogram=[sum(d['best_cpu_pass'] == j for d in descriptions) for j in range(p['rounds'])],
                             wall_best_pass_histogram=[sum(d['best_wall_pass'] == j for d in descriptions) for j in range(p['rounds'])])
    return dict(schema='glass.pass-sample-analysis/v1', status='reported', sessions=len(sessions), pairs=p['pairs'],
                captured_passes=p['pairs']*len(shapes)*p['rounds'],
                different_minima=sum(s['minima_on_different_passes'] for s in summary.values()),
                measured_workload_sessions=p['pairs']*len(shapes), summary=summary,
                runtime_promotion=False, championship_established=False, limits=p['limits'])


if __name__ == '__main__':
    print(json.dumps(analyze(load(D/'raw.json')), indent=2, allow_nan=False))
