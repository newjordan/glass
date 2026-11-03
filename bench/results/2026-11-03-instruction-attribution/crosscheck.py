#!/usr/bin/env python3
"""Cross-check new attribution against the existing ELF reader and instruction starts.

No synthetic pass windows, no workload execution and no score/promotion gate.
"""
import bisect
from collections import Counter
import importlib.util
import json
from pathlib import Path
import re
import subprocess

D = Path(__file__).resolve().parent
ROOT = D.parents[2]


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    obj = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(obj)
    return obj


def check():
    old = module('existing_cpu_symbolizer', ROOT / 'bench/linux/symbolize-cpu-sample.py')
    new = module('instruction_attribution', D / 'analyze.py')
    state = json.loads((D / 'starting-state.json').read_text())
    info = {}
    for arm in ('control', 'candidate'):
        binary = state['binaries'][arm]['path']
        new.need(new.sha(binary) == state['binaries'][arm]['sha256'], 'binary changed')
        info[arm] = old.elf_info(binary)
        new.need(info[arm] == new.tables(D, arm), 'existing ELF reader differs from frozen tables')
        for suffix, argv in [('elf', ['readelf', '-lW', binary]), ('nm', ['nm', '-S', '-n', '--defined-only', '-C', binary])]:
            new.need(subprocess.check_output(argv, text=True) == (D / f'{arm}.{suffix}').read_text(), 'live ELF dump differs')
    traces = 0
    executable_samples = 0
    instruction_ips = 0
    for mode in ('pilot', 'main'):
        analysis = new.analyze(D, mode)
        new.need(analysis == json.loads((D / f'{mode}-analysis.json').read_text()), 'stored analysis differs')
        manifest = json.loads((D / mode / 'manifest.json').read_text())
        for row in manifest['sessions']:
            if row['observer'] != 'profiled':
                continue
            traces += 1
            arm = row['arm']
            binary = state['binaries'][arm]['path']
            lines = (D / mode / row['trace']).read_text().splitlines()
            split = lines.index('PCS')
            maps = []
            for line in lines[2:split]:
                f = line.split(maxsplit=5)
                if len(f) == 6 and 'x' in f[1] and f[5] == binary:
                    lo, hi = (int(x, 16) for x in f[0].split('-'))
                    maps.append((lo, hi, int(f[2], 16)))
            new.need(len(maps) == 1, 'ambiguous executable mapping')
            lo, hi, mapped_off = maps[0]
            loads, symbols, starts = info[arm]
            counts = Counter()
            for line in lines[split + 1:]:
                pc = int(line.split()[0], 16)
                if not lo <= pc < hi:
                    continue
                executable_samples += 1
                file_off = pc - lo + mapped_off
                segs = [(off, va) for off, va, size in loads if (off & ~4095) <= file_off < off + size]
                new.need(len(segs) == 1, 'segment ambiguity')
                off, va = segs[0]
                relative = file_off + va - off
                i = bisect.bisect_right(starts, relative) - 1
                new.need(i >= 0 and relative < symbols[i][0] + symbols[i][1], 'no exact containing symbol')
                counts[symbols[i][2]] += 1
            header, new_counts, offsets = new.trace_data(D / mode / row['trace'], binary, info[arm])
            new.need(counts == Counter({k: v for k, v in new_counts.items() if not k.startswith('[')}), 'old ELF symbol counts differ')
            for name, stem in [('<glass::engine::Engine>::apply', 'apply'), ('<glass::engine::Watch>::print_utf8', 'print_utf8')]:
                addr, size, _ = next(x for x in symbols if x[2] == name)
                argv = ['objdump', '-d', '-C', '--no-show-raw-insn', f'--start-address={addr}', f'--stop-address={addr+size}', binary]
                actual = subprocess.check_output(argv, text=True)
                new.need(actual == (D / f'{arm}-{stem}.asm').read_text(), 'disassembly changed')
                instructions = {int(m[1], 16) for line in actual.splitlines() if (m := re.match(r'\s*([a-f0-9]+):', line))}
                new.need(set(offsets.get(name, {})) <= instructions, 'sample does not map to instruction start')
                instruction_ips += sum(offsets.get(name, {}).values())
    return dict(schema='glass.instruction-attribution-crosscheck/v1', traces=traces,
                executable_samples=executable_samples, apply_and_print_utf8_instruction_samples=instruction_ips,
                existing_symbol_reader_matched=True, saved_instruction_starts_matched=True,
                limits='Shared ELF address formula; cross-check is integrity/implementation consistency, not independent timing or causality.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
