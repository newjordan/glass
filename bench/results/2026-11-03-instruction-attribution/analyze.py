#!/usr/bin/env python3
"""Strict descriptive replay of exact-binary engine CPU samples. No score gate."""
import bisect
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import re
import statistics
import sys

D = Path(__file__).resolve().parent
LINE = re.compile(r'^\s*(\w+):\s+([\d.]+) MB/s\s+([\d.]+) MB/cpu-s\s+\((\d+) bytes, read (\d+)\)', re.M)


def need(ok, msg):
    if not ok:
        raise ValueError(msg)


def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def spread(xs):
    need(bool(xs), 'empty distribution')
    return dict(min=min(xs), median=statistics.median(xs), max=max(xs))


def tables(root, arm):
    loads = []
    for line in (root / f'{arm}.elf').read_text().splitlines():
        f = line.split()
        if f and f[0] == 'LOAD':
            loads.append(tuple(int(x, 16) for x in (f[1], f[2], f[4])))
    need(bool(loads), 'missing ELF LOAD segments')
    symbols = []
    for line in (root / f'{arm}.nm').read_text().splitlines():
        m = re.fullmatch(r'([0-9a-f]+) ([0-9a-f]+) [tTwWiI] (.+)', line)
        if m:
            a, size, name = m.groups()
            symbols.append((int(a, 16), int(size, 16), name))
    need(bool(symbols), 'empty symbol table')
    symbols.sort()
    return loads, symbols, [x[0] for x in symbols]


def trace_data(path, binary, info):
    lines = path.read_text().splitlines()
    m = re.fullmatch(r'cpu-sample-v2 tid=(\d+) period_us=100 samples=([1-9]\d*) dropped=0 armed=1 overruns=(\d+)', lines[0])
    need(m is not None, 'unarmed/dropped/invalid sample header')
    tid, count, overruns = map(int, m.groups())
    need(lines[1] == 'MAPS' and lines.count('PCS') == 1, 'invalid trace delimiters')
    split = lines.index('PCS')
    mappings = []
    for line in lines[2:split]:
        f = line.split(maxsplit=5)
        need(len(f) in (5, 6), 'invalid mapping')
        lo, hi = (int(x, 16) for x in f[0].split('-'))
        need(lo < hi, 'invalid mapping range')
        if 'x' in f[1]:
            mappings.append((lo, hi, int(f[2], 16), f[5] if len(f) == 6 else '[anonymous]'))
    need(sum(p == binary for _, _, _, p in mappings) == 1, 'missing/ambiguous exact executable mapping')
    samples = []
    for line in lines[split + 1:]:
        f = line.split()
        need(len(f) == 3 and f[2] == '0', 'invalid sample or unexpected read-shape label')
        samples.append((int(f[0], 16), int(f[1])))
    need(len(samples) == count and count > 1, 'sample count mismatch')
    need(all(b[1] > a[1] for a, b in zip(samples, samples[1:])), 'nonmonotonic sample timestamps')
    loads, symbols, starts = info
    counts, offsets = Counter(), defaultdict(Counter)
    for pc, stamp in samples:
        hits = [x for x in mappings if x[0] <= pc < x[1]]
        need(len(hits) <= 1, 'overlapping executable mappings')
        label = '[unmapped]'
        if hits:
            low, high, mapped_off, mapped_path = hits[0]
            if mapped_path != binary:
                label = '[other ELF] ' + mapped_path
            else:
                file_off = pc - low + mapped_off
                segs = [(off, va) for off, va, size in loads if (off & ~4095) <= file_off < off + size]
                need(len(segs) == 1, 'ambiguous ELF segment')
                off, va = segs[0]
                relative = file_off + va - off
                i = bisect.bisect_right(starts, relative) - 1
                if i >= 0 and relative < symbols[i][0] + symbols[i][1]:
                    start, size, label = symbols[i]
                    offsets[label][relative] += 1
                else:
                    label = '[executable: no containing symbol]'
        counts[label] += 1
    return dict(tid=tid, samples=count, overruns=overruns,
                delivered_spacing_ms=spread([(b[1]-a[1])/1e6 for a, b in zip(samples, samples[1:])])), counts, offsets


def analyze(root, mode):
    need(mode in ('pilot', 'main'), 'unknown mode')
    state = json.loads((root / 'starting-state.json').read_text())
    protocol = root / 'protocol.json'
    out = root / mode
    manifest = json.loads((out / 'manifest.json').read_text())
    need(manifest['complete'] is True and manifest['mode'] == mode, 'incomplete capture')
    for key, path in [('protocol_sha256', protocol), ('runner_sha256', root / 'run.py'), ('sampler_sha256', root / 'cpu-sample.so')]:
        need(manifest[key] == sha(path), f'changed {path.name}')
    expected = [(0, 'truecolor', 'control-profiled')]
    if mode == 'main':
        expected = []
        arms = ['control-plain', 'candidate-profiled', 'candidate-plain', 'control-profiled']
        for r in range(3):
            order = arms[r:] + arms[:r]
            if r % 2:
                order.reverse()
            expected += [(r, w, a) for w in ('truecolor', 'unicode') for a in order]
    sessions = manifest['sessions']
    need([(x['round'], x['workload'], x['label']) for x in sessions] == expected, 'missing/duplicate/reordered session')
    info = {a: tables(root, a) for a in ('control', 'candidate')}
    total, offsets, profiles, rates, sizes = defaultdict(Counter), defaultdict(Counter), [], {}, {}
    previous_end = 0
    for row in sessions:
        r, workload, label = row['round'], row['workload'], row['label']
        arm, observer = label.split('-')
        name = f'{r}-{workload}-{label}'
        binary = state['binaries'][arm]['path']
        need(row == json.loads((out / (name + '.json')).read_text()), 'receipt not identical to manifest')
        need(row['arm'] == arm and row['observer'] == observer and row['exit'] == 0, 'invalid arm/exit')
        need(row['binary_sha256'] == state['binaries'][arm]['sha256'] == sha(binary), 'changed exact binary')
        need(row['command'] == [binary, '--ignored', '--exact', '--nocapture', 'speed::speed'], 'changed command')
        settings = dict(GLASS_BENCH_SCALE='1' if mode == 'pilot' else '12', GLASS_BENCH_ROUNDS='1' if mode == 'pilot' else '5', GLASS_BENCH_ONLY=workload)
        if observer == 'profiled':
            settings.update(LD_PRELOAD=str(root / 'cpu-sample.so'), GLASS_SAMPLE_EXE=binary,
                            GLASS_SAMPLE_THREAD='speed::speed', GLASS_SAMPLE_OUT=str(out / (name + '.pcs')), GLASS_SAMPLE_US='100')
        need(row['settings'] == settings, 'changed benchmark environment')
        need(0 < previous_end <= row['begin_ns'] < row['end_ns'] if previous_end else 0 < row['begin_ns'] < row['end_ns'], 'overlapping sessions')
        previous_end = row['end_ns']
        for kind in ('stdout', 'stderr'):
            need(row[kind] == name + '.' + kind, 'noncanonical log path')
            need(sha(out / row[kind]) == row[kind + '_sha256'], 'changed log')
        stdout, stderr = ((out / row[k]).read_text() for k in ('stdout', 'stderr'))
        need('test result: ok. 1 passed; 0 failed; 0 ignored;' in stdout, 'failed/empty test')
        matches = LINE.findall(stderr)
        need(len(matches) == 1 and matches[0][0] == workload, 'missing/duplicate/wrong workload')
        w, wall, cpu, size, read = matches[0]
        result = dict(mb_s=float(wall), mb_cpu_s=float(cpu), bytes=int(size), read=int(read))
        need(row['result'] == result and float(wall) > 0 and float(cpu) > 0 and int(read) == 4095, 'bad result')
        need(sizes.setdefault(workload, int(size)) == int(size), 'unequal payload bytes')
        rates[r, workload, label] = result['mb_cpu_s']
        if observer == 'plain':
            need('trace' not in row and 'trace_sha256' not in row and not (out / (name + '.pcs')).exists(), 'plain trace contamination')
            continue
        need(row['trace'] == name + '.pcs' and sha(out / row['trace']) == row['trace_sha256'], 'changed trace')
        header, counts, off = trace_data(out / row['trace'], binary, info[arm])
        need(header['tid'] > row['pid'], 'sampler not armed on a child test thread')
        key = workload + '/' + arm
        total[key].update(counts)
        for symbol, values in off.items():
            offsets[key, symbol].update(values)
        profiles.append(dict(name=name, **header, symbols=dict(counts)))
    report = dict(schema='glass.instruction-attribution-analysis/v1', complete=True, mode=mode,
                  sessions=len(sessions), sampled_sessions=len(profiles), bytes=sizes, profiles=profiles)
    report['workloads'] = {key: dict(samples=sum(counts.values()), symbols=[dict(symbol=s, count=n, fraction=n/sum(counts.values())) for s, n in counts.most_common()]) for key, counts in sorted(total.items())}
    report['hotspots'] = {key + '/' + sym: [dict(elf_va=hex(pc), count=n, fraction_of_symbol=n/sum(counts.values())) for pc, n in counts.most_common(24)] for (key, sym), counts in sorted(offsets.items()) if sum(counts.values()) >= 20}
    if mode == 'pilot':
        counts = total['truecolor/control']
        need(counts['<glass::engine::Engine>::apply'] > 0, 'pilot did not hit engine apply')
        need(sum(n for s, n in counts.items() if s.startswith('[')) / sum(counts.values()) < 0.5, 'mostly unattributed pilot')
        report['pilot_valid'] = True
    else:
        comparisons = {}
        for w in ('truecolor', 'unicode'):
            pairs = {'plain_candidate_over_control': [rates[r, w, 'candidate-plain']/rates[r, w, 'control-plain'] for r in range(3)]}
            for a in ('control', 'candidate'):
                pairs[a + '_profiled_over_plain'] = [rates[r, w, a + '-profiled']/rates[r, w, a + '-plain'] for r in range(3)]
            comparisons[w] = {k: dict(ratios=v, **spread(v)) for k, v in pairs.items()}
        report['cpu_rate_comparisons'] = comparisons
    report['limits'] = ['Diagnostic leaf instruction pointers over whole test thread, including setup and all internal passes; not only the fastest timed round.', 'Requested 100us period is coalesced by CPU timer delivery; overruns are retained, not missing buffer records.', 'Profiles are conditional sample shares, not instructions retired, cycles, call stacks or causal lost time. Layout and signal perturbation can alias.', 'Three sessions per exact arm/workload on shared host; no significance, optimization promotion, terminal/Ghostty timing or championship claim.']
    return report


if __name__ == '__main__':
    need(len(sys.argv) == 2, 'expected pilot or main')
    mode = sys.argv[1]
    report = analyze(D, mode)
    text = json.dumps(report, indent=2) + '\n'
    path = D / (mode + '-analysis.json')
    if path.exists():
        need(path.read_text() == text, 'changed analysis replay')
    else:
        with path.open('x') as f:
            f.write(text)
    print(json.dumps({k: v for k, v in report.items() if k not in ('profiles', 'hotspots')}, indent=2))
