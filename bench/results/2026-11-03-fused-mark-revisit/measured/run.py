#!/usr/bin/env python3
"""Fixed paired revisit; exclusively owns Cargo target and the two edited sources."""
import hashlib
import json
import lzma
import os
from pathlib import Path
import subprocess
import time

D = Path(__file__).resolve().parent
ROOT = D.parents[3]
SOURCES = ['crates/term/src/engine.rs', 'crates/alacritty-terminal/src/term/cell.rs', 'crates/alacritty-terminal/src/grid/row.rs']


def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def census():
    names = sorted(str(p.relative_to(ROOT)) for p in (ROOT / 'crates').rglob('*')
                   if p.is_file() and (p.suffix == '.rs' or p.name == 'Cargo.toml'))
    names += ['Cargo.toml', 'Cargo.lock']
    return {p: sha(ROOT / p) for p in names}


def main():
    env = os.environ.copy()
    env['RUSTDOC'] = str(Path(env['RUSTC']).parent / 'rustdoc')
    records = []
    binaries = {}
    try:
        for arm in ['control', 'candidate']:
            for name in SOURCES:
                p = ROOT / name
                p.write_bytes((D / (arm + '-' + name.replace('/', '_'))).read_bytes())
                os.utime(p, None)
            sources = census()
            (D / (arm + '-source-sha256.json')).write_text(json.dumps(sources, indent=2) + '\n')
            out = Path('/tmp/glass-i47-fused-mark-measured-' + arm + '-test')
            argv = ['python3', '-B', str(ROOT / 'bench/build-engine-arm.py'), '--out', str(out),
                    '--receipt-dir', str(D / ('build-' + arm))]
            p = subprocess.run(argv, cwd=ROOT, env=env, capture_output=True, timeout=900)
            with (D / (arm + '-build.log')).open('xb') as f:
                f.write(p.stdout + p.stderr)
            assert p.returncode == 0, p.stderr
            identity = json.loads((D / ('build-' + arm) / 'identity.json').read_text())
            assert sha(out) == identity['sha256'] and sources == census()
            with (D / (arm + '-test-elf.xz')).open('xb') as f:
                f.write(lzma.compress(out.read_bytes(), preset=6))
            binaries[arm] = out
            commands = [
                ('literal', [str(out), '--exact', 'engine::tests::partial_utf8_chunks_match_direct_term_input', '--nocapture']),
                ('redraw', [str(out), '--exact', 'engine::tests::fused_mark_redraws_match_direct_term_input', '--nocapture']),
                ('suite', [str(out)]),
            ]
            if arm == 'candidate':
                commands += [('library', ['cargo', 'test', '--release', '--locked', '-p', 'glass-alacritty-terminal'])]
            for label, argv in commands:
                start = time.monotonic_ns()
                p = subprocess.run(argv, cwd=ROOT, env=env, capture_output=True, timeout=900)
                log = D / f'{arm}-{label}.log'
                with log.open('xb') as f:
                    f.write(p.stdout + p.stderr)
                record = dict(arm=arm, label=label, argv=argv, exit=p.returncode,
                              log_sha256=sha(log), binary_sha256=identity['sha256'],
                              source_census_sha256=sha(D / (arm + '-source-sha256.json')),
                              start_ns=start, end_ns=time.monotonic_ns())
                records.append(record)
                (D / 'gates.json').write_text(json.dumps(records, indent=2) + '\n')
                print(arm, label, 'exit', p.returncode, flush=True)
                assert p.returncode == 0, log
                assert sha(out) == identity['sha256'] and sources == census()
        argv = ['python3', '-B', str(ROOT / 'bench/engine-pairs.py'), str(binaries['control']),
                str(binaries['candidate']), '--out', str(D / 'raw.json'), '--pairs', '12',
                '--scale', '1', '--rounds', '5']
        p = subprocess.run(argv, cwd=ROOT, env=env, capture_output=True, timeout=1800)
        with (D / 'timing.log').open('xb') as f:
            f.write(p.stdout + p.stderr)
        (D / 'timing-command.json').write_text(json.dumps(dict(argv=argv, exit=p.returncode), indent=2) + '\n')
        assert p.returncode == 0, p.stderr
        print('exactly 12 fixed pairs completed', flush=True)
    finally:
        # This research candidate is never silently installed, even after a green screen.
        for name in SOURCES:
            (ROOT / name).write_bytes((D / ('original-' + name.replace('/', '_'))).read_bytes())
        print('original production sources restored; selected executable not rebuilt', flush=True)


if __name__ == '__main__':
    main()
