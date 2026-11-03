#!/usr/bin/env python3
"""Serial builds of frozen inputs; restore source bytes in all exit paths."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
INPUTS = ['crates/term/src/engine.rs', 'crates/term/src/speed.rs', 'crates/vte/src/lib.rs', 'crates/vte/src/ansi.rs']
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()


def main():
    state = json.loads((D / 'starting-state.json').read_text())
    original = {p: (D / ('control-' + p.replace('/', '_'))).read_bytes() for p in INPUTS}
    results = {}
    try:
        for arm in ['control', 'candidate']:
            for p in INPUTS:
                (ROOT / p).write_bytes((D / (arm + '-' + p.replace('/', '_'))).read_bytes())
            binary = f'/tmp/glass-i28-{arm}-test'
            argv = [sys.executable, '-B', str(ROOT / 'bench/build-engine-arm.py'), '--out', binary,
                    '--receipt-dir', str(D / ('build-' + arm))]
            with (D / ('build-' + arm + '.json')).open('x') as out:
                subprocess.run(argv, cwd=ROOT, stdout=out, check=True, timeout=1000)
            if arm == 'control':
                assert sha(binary) == sha('/tmp/glass-i27-control-test'), 'control not byte-identical'
            results[arm] = dict(path=binary, sha256=sha(binary))
            env = {k: v for k, v in os.environ.items() if not k.startswith('GLASS_')}
            for kind, extra, settings in [
                ('terminal-tests', [], {}),
                ('sweep', ['--ignored', '--exact', 'speed::plain_runs_match_the_parser_over_seeds', '--nocapture'],
                 {'GLASS_SWEEP_SEEDS': '64', 'GLASS_SWEEP_ROUNDS': '200'})]:
                with (D / (arm + '-' + kind + '.log')).open('x') as out:
                    proc = subprocess.run([binary, *extra], cwd=ROOT, env=dict(env, **settings), stdout=out,
                                          stderr=subprocess.STDOUT, timeout=300)
                assert proc.returncode == 0, (arm, kind, proc.returncode)
                text = (D / (arm + '-' + kind + '.log')).read_text()
                assert ('383 passed; 0 failed; 11 ignored' if kind == 'terminal-tests' else
                        'swept 12800 streams over 64 seeds: no divergence') in text
                print(arm, kind, 'exit 0', flush=True)
    finally:
        for p, data in original.items():
            (ROOT / p).write_bytes(data)
        assert all(sha(ROOT / p) == state['rust_sha256'][p] for p in INPUTS)
        assert sha(ROOT / state['selected_path']) == state['selected_sha256']
        print('original source contents restored; selected binary unchanged', flush=True)
    (D / 'binaries.json').write_text(json.dumps(results, indent=2) + '\n')


if __name__ == '__main__':
    main()
