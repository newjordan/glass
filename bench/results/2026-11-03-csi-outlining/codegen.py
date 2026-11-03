#!/usr/bin/env python3
"""Check exact emitted instructions, not timing or unique causal attribution."""
import hashlib
import json
from pathlib import Path
import re
import subprocess

D = Path(__file__).resolve().parent


def need(ok, message):
    if not ok:
        raise ValueError(message)


def instructions(text):
    return [(int(m[1], 16), m[2].strip()) for m in re.finditer(r'^\s*([0-9a-f]+):\s+(.+)$', text, re.M)]


def check():
    out = {}
    for parser in ('control', 'authority'):
        arm = parser + '-outlined'
        ident = json.loads((D / ('build-' + arm + '.json')).read_text())
        binary = Path(ident['executable'])
        need(hashlib.sha256(binary.read_bytes()).hexdigest() == ident['sha256'], 'changed outlined binary')
        names = (D / (arm + '.nm')).read_text().splitlines()
        for short, symbol in [('apply', '<glass::engine::Engine>::apply'), ('simple', 'glass::engine::simple')]:
            rows = [line.split() for line in names if line.endswith(' ' + symbol)]
            need(len(rows) == 1, 'ambiguous symbol ' + symbol)
            row = rows[0]
            start, size = int(row[0], 16), int(row[1], 16)
            argv = ['objdump', '-d', '--no-show-raw-insn', '--demangle', '--start-address=' + str(start), '--stop-address=' + str(start + size), str(binary)]
            need(subprocess.check_output(argv, text=True) == (D / (arm + '-' + short + '.asm')).read_text(), 'saved disassembly differs')
        text = (D / (arm + '-simple.asm')).read_text()
        inst = instructions(text)
        need(inst and len(inst) > 40, 'empty scanner')
        # The decimal scanner loads the next byte using r9. Bound its loop
        # by its two instruction endpoints, not by unrelated stack arrays.
        lo = [i for i, (_, op) in enumerate(inst) if op == 'mov    $0xffff,%dx']
        hi = [i for i, (_, op) in enumerate(inst) if op == 'cmp    $0x3b,%edx']
        need(len(lo) == len(hi) == 1 and lo[0] < hi[0], 'unknown decimal-loop code shape')
        loop = inst[lo[0]:hi[0]]
        need(any(op == 'inc    %r9' for _, op in loop), 'index not carried in r9')
        need(any(op == 'movzbl -0x1(%rsi,%r9,1),%r11d' for _, op in loop), 'next-byte load not register indexed')
        need(not any('%rsp' in op or '%rbp' in op for _, op in loop), 'stack reference in selected decimal loop')
        apply = instructions((D / (arm + '-apply.asm')).read_text())
        calls = [(addr, op) for addr, op in apply if 'call' in op and '<glass::engine::simple>' in op]
        need(len(calls) == 1, 'apply does not call outlined scanner exactly once')
        out[arm] = dict(binary_sha256=ident['sha256'], scanner_decimal_loop_start=hex(loop[0][0]), scanner_decimal_loop_end=hex(loop[-1][0]), loop_instructions=len(loop), register_index='r9', selected_loop_stack_references=0, apply_call_address=hex(calls[0][0]))
    return dict(schema='glass.csi-outlining-codegen/v1', arms=out, note='Checks the decimal-digit loop only. Parameter arrays and caller spills remain. Outlining also changes ABI, layout and optimization context; no unique causal/timing conclusion.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
