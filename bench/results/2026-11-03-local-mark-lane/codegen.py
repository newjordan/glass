#!/usr/bin/env python3
"""Static instruction census of the exact two timing ELFs; no runtime launch."""
import collections
import hashlib
import json
from pathlib import Path
import re
import subprocess

D = Path(__file__).resolve().parent


def check(capture=False):
    result = {}
    for arm in ('control', 'candidate'):
        exe = f'/tmp/glass-i31-{arm}-test'
        nm = subprocess.check_output(['nm', '-S', '-n', '-C', exe], text=True)
        if capture:
            (D / f'{arm}.nm').write_text(nm)
        else:
            assert nm == (D / f'{arm}.nm').read_text(), 'symbol listing changed'
        result[arm] = {}
        symbols = [('print_utf8', '<glass::engine::Watch>::print_utf8'), ('apply', '<glass::engine::Engine>::apply')]
        for label, needle in symbols:
            found = [line for line in nm.splitlines() if line.endswith(' ' + needle)]
            assert len(found) == 1
            addr, size, _, name = found[0].split(maxsplit=3)
            start, size = int(addr, 16), int(size, 16)
            text = subprocess.check_output(['objdump', '-d', '-C', '--no-show-raw-insn', f'--start-address={start}', f'--stop-address={start+size}', exe], text=True)
            if capture:
                (D / f'{arm}-{label}.asm').write_text(text)
            else:
                assert text == (D / f'{arm}-{label}.asm').read_text(), 'disassembly changed'
            insns = [(int(m[1], 16), m[2]) for line in text.splitlines() if (m := re.match(r'^\s*([0-9a-f]+):\s+(.+)', line))]
            norm = []
            for pc, line in insns:
                line = re.sub(r'#.*', '', line).strip()
                line = re.sub(r'[-+]?0x[0-9a-f]+\(%rip\)', 'DISP(%rip)', line)
                def target(m):
                    v = int(m[1], 16)
                    return (f'@{v-start:+x}' if start <= v < start+size else '@EXTERNAL') + ' <' + m[2] + '>'
                line = re.sub(r'\b([0-9a-f]+) <([^>]*)>', target, line)
                norm.append(line)
            counts = collections.Counter(re.match(r'\w+', line)[0] for pc, line in insns)
            frame = [line for pc, line in insns[:25] if '%rsp' in line or line.startswith(('push', 'pop'))]
            stack_refs = sum('%rsp' in line or '%rbp)' in line for pc, line in insns)
            result[arm][label] = dict(address=hex(start), bytes=size, instructions=len(insns), normalized_sha256=hashlib.sha256('\n'.join(norm).encode()).hexdigest(), stack_referencing_instructions=stack_refs, prologue=frame, opcode_counts=dict(counts))
    result['limits'] = 'Static disassembly census; stack references include address computations. Same start virtual address controls entry alignment, not full layout/callee identity or causality. No dynamic instruction or timing attribution.'
    return result


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
