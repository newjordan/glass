#!/usr/bin/env python3
"""Fresh-process width-cache diagnostic, not terminal startup/RSS acceptance.

Requires exact test binaries containing engine::tests::width_cache_cold_first_lookup.
Every invocation measures just one first lookup. Retains raw outputs and executable
identities; refuses to overwrite a previous capture, including an interrupted one.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import time

TEST = 'engine::tests::width_cache_cold_first_lookup'
ARMS = ('base', 'candidate')


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def capture(base, candidate, out, pairs):
    if type(pairs) is not int or pairs < 1:
        raise ValueError('pairs must be a positive integer')
    paths = dict(zip(ARMS, (Path(base).resolve(), Path(candidate).resolve())))
    report = dict(schema='glass.cold-width-pairs/v1', test=TEST,
                  binaries={arm: dict(path=str(path), sha256=digest(path))
                            for arm, path in paths.items()}, pairs=[])
    env = {k: v for k, v in os.environ.items() if not k.startswith('GLASS_')}
    env['RUST_TEST_THREADS'] = '1'
    out = Path(out)
    out.parent.mkdir(parents=True, exist_ok=True)
    # Hold one exclusive destination through completion. A crash leaves an
    # incomplete receipt which must not be silently repaired/replaced.
    with out.open('x', encoding='utf-8') as file:
        def save():
            file.seek(0)
            json.dump(report, file, indent=2, allow_nan=False)
            file.write('\n')
            file.truncate()
            file.flush()
            os.fsync(file.fileno())
        save()
        for index in range(pairs):
            order = list(ARMS if index % 2 == 0 else reversed(ARMS))
            row = dict(order=order)
            report['pairs'].append(row)
            for arm in order:
                begin = time.monotonic_ns()
                with subprocess.Popen([str(paths[arm]), '--ignored', '--exact', TEST, '--nocapture'],
                                      env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                      text=True) as proc:
                    try:
                        stdout, stderr = proc.communicate(timeout=60)
                    except subprocess.TimeoutExpired:
                        proc.kill()
                        stdout, stderr = proc.communicate()
                        row[arm] = dict(pid=proc.pid, begin_ns=begin, end_ns=time.monotonic_ns(),
                                        exit=proc.returncode, stdout=stdout, stderr=stderr, timeout=True)
                        save()
                        raise RuntimeError(f'cold timeout {index}/{arm}')
                    row[arm] = dict(pid=proc.pid, begin_ns=begin, end_ns=time.monotonic_ns(),
                                    exit=proc.returncode, stdout=stdout, stderr=stderr)
                save()
                if row[arm]['exit'] != 0:
                    raise RuntimeError(f'cold test failed {index}/{arm}')
        report['complete'] = True
        report['unchanged_binaries'] = all(digest(paths[a]) == report['binaries'][a]['sha256']
                                           for a in ARMS)
        save()
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('base', type=Path)
    parser.add_argument('candidate', type=Path)
    parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--pairs', type=int, default=15)
    args = parser.parse_args()
    capture(args.base, args.candidate, args.out, args.pairs)
    print(json.dumps(dict(out=str(args.out), pairs=args.pairs, complete=True)))


if __name__ == '__main__':
    main()
