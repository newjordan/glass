#!/usr/bin/env python3
"""Read-only relevant symbol/disassembly replay; static code is not dynamic cost."""
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys
D = Path(__file__).resolve().parent


def check(capture=False):
    result = {}
    for arm in ('control', 'candidate'):
        exe = f'/tmp/glass-i32-{arm}-test'
        nm = subprocess.check_output(['nm', '-S', '-n', '-C', exe], text=True)
        symbols = [('apply', '<glass::engine::Engine>::apply'), ('print_utf8', '<glass::engine::Watch>::print_utf8')]
        if arm == 'candidate':
            symbols += [('attribute_cold', '<alacritty_terminal::term::Term<glass::engine::Listener>>::terminal_attribute_cold')]
        else:
            symbols += [('attribute', '<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute')]
        result[arm] = {}
        for label, name in symbols:
            matches = [s for s in nm.splitlines() if s.endswith(' ' + name)]
            assert len(matches) == 1, (arm, label, matches)
            address, size, _, _ = matches[0].split(maxsplit=3)
            address, size = int(address, 16), int(size, 16)
            asm = subprocess.check_output(['objdump', '-d', '-C', '--no-show-raw-insn', f'--start-address={address}', f'--stop-address={address+size}', exe], text=True)
            out = D / f'{arm}-{label}.asm'
            if capture:
                out.write_text(asm)
            else:
                assert out.read_text() == asm, (arm, label, 'disassembly changed')
            instructions = [s for s in asm.splitlines() if re.match(r'^\s*[0-9a-f]+:\s+\S', s)]
            calls = [s.strip() for s in instructions if '\tcall' in s]
            result[arm][label] = dict(address=hex(address), bytes=size, instructions=len(instructions), asm_sha256=hashlib.sha256(asm.encode()).hexdigest(), attribute_calls=[s for s in calls if 'terminal_attribute' in s])
    return result

if __name__ == '__main__':
    print(json.dumps(check('--capture' in sys.argv), indent=2))
