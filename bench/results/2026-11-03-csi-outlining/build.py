#!/usr/bin/env python3
"""Serial exact arm builds with unconditional restoration, no terminal rebuild."""
from pathlib import Path
import hashlib
import importlib.util
import json
import os
import subprocess
import sys

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
INPUTS = ['crates/term/src/engine.rs', 'crates/term/src/speed.rs', 'crates/vte/src/lib.rs', 'crates/vte/src/ansi.rs']

def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def main():
    state = json.loads((D / 'starting-state.json').read_text())
    protocol = json.loads((D / 'protocol.json').read_text())
    original = {p: (ROOT / p).read_bytes() for p in INPUTS}
    assert all(sha(ROOT / p) == state['rust_sha256'][p] for p in INPUTS)
    metadata = {p: (ROOT / p).stat() for p in INPUTS}
    results = {}
    try:
        for arm in protocol['arms']:
            for p in INPUTS:
                (ROOT / p).write_bytes((D / (arm + '-' + p.replace('/', '_'))).read_bytes())
            binary = f'/tmp/glass-i26-{arm}-test'
            argv = [sys.executable, '-B', str(ROOT / 'bench/build-engine-arm.py'), '--out', binary,
                    '--receipt-dir', str(D / ('build-' + arm))]
            with (D / ('build-' + arm + '.json')).open('x') as out:
                subprocess.run(argv, cwd=ROOT, stdout=out, check=True, timeout=1000)
            if arm.endswith('-inline'):
                old = '/tmp/glass-i24-' + ('control' if arm.startswith('control') else 'candidate') + '-test'
                assert sha(binary) == sha(old), f'fresh inline arm not byte identical: {arm}'
            results[arm] = dict(path=binary, sha256=sha(binary))
            print(arm, results[arm], flush=True)
    finally:
        for p, data in original.items():
            (ROOT / p).write_bytes(data)
            s = metadata[p]
            os.utime(ROOT / p, ns=(s.st_atime_ns, s.st_mtime_ns))
        assert all(sha(ROOT / p) == state['rust_sha256'][p] for p in INPUTS)
        assert sha(ROOT / state['selected_path']) == state['selected_sha256']
        print('all original input contents restored; selected binary unchanged', flush=True)
    (D / 'binaries.json').write_text(json.dumps(results, indent=2) + '\n')
    spec = importlib.util.spec_from_file_location('elf', ROOT / 'bench/linux/symbolize-cpu-sample.py')
    elf = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(elf)
    for arm, identity in results.items():
        binary = identity['path']
        (D / (arm + '.nm')).write_text(subprocess.check_output(['nm', '-S', '-n', '--defined-only', '-C', binary], text=True))
        _, symbols, _ = elf.elf_info(binary)
        for symbol, stem in [('<glass::engine::Engine>::apply', 'apply'), ('glass::engine::simple', 'simple')]:
            found = [s for s in symbols if s[2] == symbol]
            assert len(found) == (1 if stem == 'apply' or arm.endswith('-outlined') else 0), (arm, symbol, found)
            if found:
                addr, size, _ = found[0]
                argv = ['objdump', '-d', '-C', '--no-show-raw-insn', f'--start-address={addr}', f'--stop-address={addr + size}', binary]
                (D / (arm + '-' + stem + '.asm')).write_text(subprocess.check_output(argv, text=True))
    for arm in ['control-outlined', 'authority-outlined']:
        binary = results[arm]['path']
        env = {k: v for k, v in os.environ.items() if not k.startswith('GLASS_')}
        for kind, extra, settings in [('terminal-tests', [], {}), ('sweep', ['--ignored', '--exact', 'speed::plain_runs_match_the_parser_over_seeds', '--nocapture'], {'GLASS_SWEEP_SEEDS': '64', 'GLASS_SWEEP_ROUNDS': '200'})]:
            with (D / (arm + '-' + kind + '.log')).open('x') as out:
                proc = subprocess.run([binary, *extra], cwd=ROOT, env=dict(env, **settings), stdout=out, stderr=subprocess.STDOUT, timeout=300)
            assert proc.returncode == 0, (arm, kind, proc.returncode)
            text = (D / (arm + '-' + kind + '.log')).read_text()
            assert ('383 passed; 0 failed; 11 ignored' if kind == 'terminal-tests' else 'swept 12800 streams over 64 seeds: no divergence') in text
            print(arm, kind, 'exit 0', flush=True)

if __name__ == '__main__':
    main()
