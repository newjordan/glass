#!/usr/bin/env python3
"""Compare saved print_utf8 instructions while explicitly masking relocations."""
import hashlib
import json
from pathlib import Path
import re
import subprocess

D = Path(__file__).resolve().parent


def need(ok, message):
    if not ok:
        raise ValueError(message)


def normalized(text):
    result = []
    for m in re.finditer(r'^\s*([0-9a-f]+):\s+(.+)$', text, re.M):
        op = re.sub(r'\s+#.*$', '', m[2])
        op = re.sub(r'-?0x[0-9a-f]+\(%rip\)', 'RIP_RELOC(%rip)', op)
        op = re.sub(r'\b[0-9a-f]+ (?=<)', 'TARGET ', op)
        result.append(op)
    return result


def check():
    binaries = json.loads((D / 'binaries.json').read_text())
    symbols = json.loads((D / 'print-utf8-symbols.json').read_text())
    result = {}
    for parser in ('control', 'authority'):
        shapes = []
        for style in ('inline', 'outlined'):
            arm = parser + '-' + style
            binary = binaries[arm]['path']
            need(hashlib.sha256(Path(binary).read_bytes()).hexdigest() == binaries[arm]['sha256'], 'changed binary')
            rows = [line.split() for line in (D / (arm + '.nm')).read_text().splitlines() if line.endswith(' <glass::engine::Watch>::print_utf8')]
            need(len(rows) == 1, 'ambiguous print symbol')
            start, size = int(rows[0][0], 16), int(rows[0][1], 16)
            need(symbols[arm] == dict(address=hex(start), size=size), 'symbol summary differs')
            argv = ['objdump', '-d', '-C', '--no-show-raw-insn', f'--start-address={start}', f'--stop-address={start+size}', binary]
            saved = (D / (arm + '-print_utf8.asm')).read_text()
            need(subprocess.check_output(argv, text=True) == saved, 'saved print disassembly differs')
            shape = normalized(saved)
            need(len(shape) == 1967, 'unexpected instruction count')
            shapes.append(shape)
        need(shapes[0] == shapes[1], 'relocation-masked print instruction listings differ')
        result[parser] = dict(instructions=1967, size_bytes=symbols[parser + '-inline']['size'],
            inline_address=symbols[parser + '-inline']['address'], outlined_address=symbols[parser + '-outlined']['address'],
            same_relocation_masked_instructions=True, normalized_sha256=hashlib.sha256(('\n'.join(shapes[0])+'\n').encode()).hexdigest())
    return dict(schema='glass.csi-outlining-print-codegen/v1', parsers=result,
        limits='Masks only absolute target addresses, RIP-relative displacements and comments. Keeps annotated branch offsets and operations. Same listing is not byte identity, a full relocation/callee equality proof, or a cause of the Unicode loss. No instruction timing measured.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
