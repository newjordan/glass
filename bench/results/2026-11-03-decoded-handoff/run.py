#!/usr/bin/env python3
"""Run the prospective balanced two-arm screen; no retry or partial-to-success repair."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import time

D = Path(__file__).resolve().parent
ROOT = D.parents[2]


def stamp():
    return datetime.now(timezone.utc).isoformat()


def main():
    protocol = json.loads((D / 'protocol.json').read_text())
    p = protocol['engine']
    binaries = json.loads((D / 'binaries.json').read_text())
    assert set(binaries) == set(protocol['arms'])
    for arm, entry in binaries.items():
        assert hashlib.sha256(Path(entry['path']).read_bytes()).hexdigest() == entry['sha256'], arm
    env = {k: v for k, v in os.environ.items() if not k.startswith('GLASS_')}
    settings = dict(GLASS_BENCH_SCALE=str(float(p['scale'])), GLASS_BENCH_ROUNDS=str(p['rounds']),
                    GLASS_BENCH_READ=str(p['read']), GLASS_BENCH_ONLY=','.join(p['workloads']))
    env.update(settings)
    report = dict(schema='glass.decoded-handoff-raw/v1', protocol_sha256=hashlib.sha256((D / 'protocol.json').read_bytes()).hexdigest(),
                  settings=settings, binaries=binaries, sessions=[])
    # Exclusive run sentinel means accidental reruns cannot replace earlier data.
    with (D / 'started.json').open('x') as out:
        json.dump(dict(started=stamp(), protocol_sha256=report['protocol_sha256']), out, indent=2)
    for block in range(p['blocks']):
        for slot, arm in enumerate(p['orders'][block % len(p['orders'])]):
            argv = [binaries[arm]['path'], '--ignored', '--exact', '--nocapture', 'speed::speed']
            start, utc = time.monotonic_ns(), stamp()
            proc = subprocess.run(argv, cwd=ROOT, env=env, capture_output=True, text=True, timeout=600)
            report['sessions'].append(dict(block=block, slot=slot, arm=arm, argv=argv, started_utc=utc,
                start_ns=start, end_ns=time.monotonic_ns(), exit=proc.returncode,
                stdout=proc.stdout, stderr=proc.stderr))
            temp = D / 'raw.partial.json'
            temp.write_text(json.dumps(report, indent=2) + '\n')
            os.replace(temp, D / 'raw.json')
            assert proc.returncode == 0, (block, arm, proc.stderr)
            assert 'test result: ok. 1 passed; 0 failed;' in proc.stdout
            print(f'block {block + 1}/{p["blocks"]} slot {slot + 1}/2 {arm}: exit {proc.returncode}', flush=True)
    print('all 24 prescribed sessions retained; independent raw replay still required', flush=True)


if __name__ == '__main__':
    main()
