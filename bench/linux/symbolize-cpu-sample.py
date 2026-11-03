#!/usr/bin/env python3
"""Symbolize cpu-sample.c traces against their exact ELF mapping and pass windows.

Leaf IP only, no call graph or source-line claim. Thread CPU timer delivery is
coarse and sampling can alias; treat counts as diagnostic, not precise costs.
"""
import argparse
import bisect
import collections
import hashlib
import json
from pathlib import Path
import re
import subprocess


def digest(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def elf_info(path):
    headers = subprocess.check_output(['readelf', '-lW', path], text=True)
    loads = []
    for line in headers.splitlines():
        fields = line.split()
        if fields and fields[0] == 'LOAD':
            loads.append(tuple(int(x, 16) for x in (fields[1], fields[2], fields[4])))
    assert loads
    # Unstripped executable has local Rust symbols. DSOs generally only expose
    # dynamic symbols; never guess that a non-containing predecessor is a hit.
    args = ['nm', '-S', '-n', '-C', path]
    text = subprocess.run(args, capture_output=True, text=True, check=True).stdout
    if not text.strip():
        text = subprocess.check_output(['nm', '-D', '-S', '-n', '-C', path], text=True)
    symbols = []
    for line in text.splitlines():
        match = re.match(r'^([0-9a-f]+) ([0-9a-f]+) [tTwWiI] (.+)$', line)
        if match:
            address, size, name = match.groups()
            symbols.append((int(address, 16), int(size, 16), name))
    symbols.sort()
    return loads, symbols, [a for a, _, _ in symbols]


def analyze(root):
    info, known_hashes = {}, {}
    total, by_run, offsets = collections.defaultdict(collections.Counter), {}, collections.defaultdict(collections.Counter)
    raw_hashes = {}
    call_labels = collections.defaultdict(collections.Counter)
    headers = {}
    sample_spacing = {}
    for trace in sorted(root.glob('*.pcs')):
        target, run = trace.stem.rsplit('-', 1)
        profile_path = root / f'tput-{target}-{run}.profile.json'
        profile = json.loads(profile_path.read_text())
        assert profile['complete'] and len(profile['passes']) == 18
        lines = trace.read_text().splitlines()
        header = dict(item.split('=', 1) for item in lines[0].split()[1:])
        assert header['armed'] == '1' and header['dropped'] == '0'
        expected = {'ascii', 'unicode', 'truecolor', 'cursor_motion', 'scroll_region', 'tui_frames'}
        assert {(x['workload'], x['pass']) for x in profile['passes']} == {(n, i) for n in expected for i in range(3)}
        for window in profile['passes']:
            tasks = [x for x in window['terminal_before'] if x['name'] == target]
            assert len(tasks) == 1 and tasks[0]['tid'] == int(header['tid'])
        split = lines.index('PCS')
        mappings = []
        for line in lines[2:split]:
            fields = line.split(maxsplit=5)
            if len(fields) < 6 or not fields[5].startswith('/'):
                continue
            lo, hi = (int(x, 16) for x in fields[0].split('-'))
            path = fields[5]
            if 'x' not in fields[1]:
                continue
            mappings.append((lo, hi, int(fields[2], 16), path))
        records = [line.split() for line in lines[split + 1:]]
        assert all(len(x) in (2, 3) for x in records)
        samples = [(int(x[0], 16), int(x[1]), int(x[2]) if len(x) == 3 else -1) for x in records]
        headers[trace.name] = header
        spacing = sorted((b[1] - a[1]) / 1e6 for a, b in zip(samples, samples[1:]))
        sample_spacing[trace.name] = {"min": min(spacing), "median": spacing[len(spacing)//2], "max": max(spacing)}
        assert len(samples) == int(header['samples']) > 0
        run_counts = collections.defaultdict(collections.Counter)
        for pc, stamp, call in samples:
            windows = [p for p in profile['passes'] if p['begin_ns'] <= stamp <= p['end_ns']]
            if not windows:
                continue
            assert len(windows) == 1
            name = windows[0]['workload']
            call_labels[target, name].update([{1: 'read', 2: 'poll', 0: 'outside', -1: 'unavailable'}[call]])
            label = '[unmapped]'
            relative = None
            for low, high, map_offset, path in mappings:
                if not low <= pc < high:
                    continue
                if path not in info:
                    info[path] = elf_info(path)
                    known_hashes[path] = digest(path)
                loads, symbols, starts = info[path]
                file_offset = pc - low + map_offset
                candidates = [(off, virt) for off, virt, size in loads if (off & ~4095) <= file_offset < off + size]
                assert len(candidates) == 1, (path, hex(file_offset), candidates)
                off, virt = candidates[0]
                relative = file_offset + virt - off
                pos = bisect.bisect_right(starts, relative) - 1
                if pos >= 0 and relative < symbols[pos][0] + symbols[pos][1]:
                    address, size, symbol = symbols[pos]
                    label = f'{Path(path).name}!{symbol}'
                    offsets[(target, name, label)][hex(relative - address)] += 1
                else:
                    label = f'{Path(path).name}![no containing symbol]'
                break
            total[(target, name)][label] += 1
            run_counts[name][label] += 1
        by_run[trace.name] = {n: dict(c.most_common()) for n, c in run_counts.items()}
        raw_hashes[trace.name] = digest(trace)
        raw_hashes[profile_path.name] = digest(profile_path)
    assert len(by_run) in (3, 6), "expected three sessions per selected thread"
    for target in {key.rsplit("-", 1)[0] for key in by_run}:
        assert {f"{target}-{i}.pcs" for i in (1, 2, 3)} <= by_run.keys()
    assert all(len(x) == 6 for x in by_run.values())
    return {'schema': 'glass.cpu-sample-symbols/v2', 'complete': True, 'raw_sha256': raw_hashes,
            'mapped_elf_sha256': known_hashes,
            'headers': headers, 'observed_sample_spacing_ms': sample_spacing,
            'call_labels': {f'{t}/{n}': dict(c) for (t, n), c in sorted(call_labels.items())},
            'workloads': {f'{t}/{n}': {'samples': sum(c.values()), 'symbols': [dict(symbol=s, count=k, fraction=k/sum(c.values()))
                                                                                            for s, k in c.most_common()]}
                          for (t, n), c in sorted(total.items())}, 'by_run': by_run,
            'symbol_offsets': {f'{t}/{n}/{s}': dict(c.most_common()) for (t, n, s), c in sorted(offsets.items())},
            'limits': ['LD_PRELOAD injection adds signals and can perturb timing; diagnostic only.',
                       'Leaf PCs, coarse thread-clock timer delivery; no call graph, system CPU stack, or causal cost estimate.',
                       'Matched payloads, three sessions per thread, correlated passes; no significance or championship claim.']}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('root', type=Path)
    p.add_argument('--out', type=Path, required=True)
    args = p.parse_args()
    summary = analyze(args.root)
    text = json.dumps(summary, indent=2) + '\n'
    if args.out.exists():
        assert args.out.read_text() == text, 'changed replay'
    else:
        with args.out.open('x') as f:
            f.write(text)
    for name, counts in summary['workloads'].items():
        print(name, counts['samples'], [(s['symbol'], round(s['fraction'] * 100, 1)) for s in counts['symbols'][:5]])


if __name__ == '__main__':
    main()
