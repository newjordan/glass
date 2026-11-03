#!/usr/bin/env python3
"""Rebuild and retain literal regression arms. Never benchmarks or edits old evidence."""
import hashlib
import json
import lzma
import os
from pathlib import Path
import subprocess
import time

D = Path(__file__).resolve().parent
ROOT = D.parents[2]

def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def main():
    env = os.environ.copy()
    env['RUSTDOC'] = str(Path(env['RUSTC']).parent / 'rustdoc')
    records = []
    parser = ROOT / 'crates/vte/src/lib.rs'
    candidate = (D / 'candidate-lib.rs').read_bytes()
    try:
        for arm in ['control', 'candidate']:
            parser.write_bytes((D / (arm + '-lib.rs')).read_bytes())
            out = Path('/tmp/glass-i46b-partial-utf8-' + arm + '-test')
            receipt = D / ('final-build-' + arm)
            command = ['python3', '-B', str(ROOT / 'bench/build-engine-arm.py'),
                       '--out', str(out), '--receipt-dir', str(receipt)]
            p = subprocess.run(command, cwd=ROOT, env=env, capture_output=True, timeout=900)
            (D / ('final-' + arm + '-build.log')).write_bytes(p.stdout + p.stderr)
            assert p.returncode == 0, p.stderr
            identity = json.loads((receipt / 'identity.json').read_text())
            for name, digest in identity['source_sha256'].items():
                snapshot = D / ('final-' + arm + '-' + name.replace('/', '_'))
                snapshot.write_bytes((ROOT / name).read_bytes())
                assert sha(snapshot) == digest
            assert sha(out) == identity['sha256']
            archive = D / ('final-' + arm + '-test-elf.xz')
            with archive.open('xb') as f:
                f.write(lzma.compress(out.read_bytes(), preset=6))
            commands = [
                ('parser', ['cargo', 'test', '--release', '--locked', '-p', 'vte',
                            'partial_utf8_', '--', '--nocapture', '--test-threads=1'], {},
                 101 if arm == 'control' else 0),
                ('engine', [str(out), '--exact', 'engine::tests::partial_utf8_chunks_match_direct_term_input',
                            '--nocapture'], {}, 101 if arm == 'control' else 0),
                ('suite', [str(out)] + (['--skip', 'partial_utf8_chunks_match_direct_term_input'] if arm == 'control' else []), {}, 0),
                ('sweep', [str(out), '--ignored', '--exact', 'speed::plain_runs_match_the_parser_over_seeds', '--nocapture'],
                 dict(GLASS_SWEEP_SEEDS='64', GLASS_SWEEP_ROUNDS='200', GLASS_SWEEP_FROM='1'), 0),
            ]
            if arm == 'candidate':
                commands += [
                    ('library', ['cargo', 'test', '--release', '--locked', '-p', 'glass-alacritty-terminal'], {}, 0),
                    ('parser-full', ['cargo', 'test', '--release', '--locked', '-p', 'vte'], {}, 0),
                    ('parser-no-default', ['cargo', 'test', '--release', '--locked', '-p', 'vte', '--no-default-features'], {}, 0),
                ]
            for label, argv, settings, expected in commands:
                before = time.monotonic_ns()
                p = subprocess.run(argv, cwd=ROOT, env=env | settings, capture_output=True, timeout=900)
                log = D / f'final-{arm}-{label}.log'
                with log.open('xb') as f:
                    f.write(p.stdout + p.stderr)
                record = dict(arm=arm, label=label, argv=argv, settings=settings, exit=p.returncode,
                              expected_exit=expected, log_sha256=sha(log),
                              source_sha256=identity['source_sha256'], binary_sha256=identity['sha256'],
                              start_ns=before, end_ns=time.monotonic_ns())
                records.append(record)
                (D / 'final-gates.json').write_text(json.dumps(records, indent=2) + '\n')
                print(arm, label, 'exit', p.returncode, 'expected', expected, flush=True)
                assert p.returncode == expected
            assert sha(out) == identity['sha256']
    finally:
        parser.write_bytes(candidate)
    print('paired final gates completed; candidate source installed, selected shipping binary not rebuilt', flush=True)

if __name__ == '__main__':
    main()
