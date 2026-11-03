#!/usr/bin/env python3
"""Fixed 12-pair recording observer check, one exact executable, no tuning."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import time
from datetime import datetime, timezone

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()


def main():
    protocol = json.loads((D/'protocol.json').read_text())
    binary = json.loads((D/'binary.json').read_text())
    corpus = ROOT / protocol['corpus']
    manifest = json.loads((corpus/'manifest.json').read_text())
    assert sha(binary['path']) == binary['sha256']
    assert sha(corpus/'manifest.json') == protocol['corpus_manifest_sha256']
    for name, item in manifest['workloads'].items():
        p = corpus/(name+'.bin')
        assert p.stat().st_size == item['bytes'] and sha(p) == item['sha256']
    env = {k:v for k,v in os.environ.items() if not k.startswith(('GLASS_', 'LD_PRELOAD'))}
    settings = dict(GLASS_BENCH_CORPUS=str(corpus), GLASS_BENCH_SCALE='1', GLASS_BENCH_READ='4095',
                    GLASS_BENCH_ROUNDS='5', GLASS_BENCH_ONLY=','.join(protocol['workloads']))
    raw = dict(schema='glass.pass-sample-screen/v1', protocol_sha256=sha(D/'protocol.json'),
               runner_sha256=sha(__file__), analyzer_sha256=sha(ROOT/'bench/analyze-engine-passes.py'),
               source_sha256=sha(ROOT/'crates/term/src/speed.rs'), binary=binary, settings=settings,
               sessions=[])
    for pair in range(protocol['pairs']):
        for mode in (['off', 'on'] if pair % 2 == 0 else ['on', 'off']):
            stem = f'{pair:02}-{mode}'
            more = {} if mode == 'off' else dict(GLASS_BENCH_SAMPLES=str(D/(stem+'.jsonl')))
            assert sha(binary['path']) == binary['sha256']
            begin = time.time_ns()
            proc = subprocess.run([binary['path'], '--exact', '--ignored', '--nocapture', 'speed::speed'],
                                  env=env|settings|more, capture_output=True, text=True, timeout=600)
            end = time.time_ns()
            for kind in ('stdout', 'stderr'):
                with (D/(stem+'.'+kind)).open('x') as f:
                    f.write(getattr(proc, kind))
            receipt = dict(pair=pair, mode=mode, begin_ns=begin, end_ns=end,
                           started_utc=datetime.fromtimestamp(begin/1e9, timezone.utc).isoformat(),
                           exit=proc.returncode, argv=[binary['path'], '--exact', '--ignored', '--nocapture', 'speed::speed'],
                           settings=settings|more, stdout=stem+'.stdout', stderr=stem+'.stderr',
                           stdout_sha256=sha(D/(stem+'.stdout')), stderr_sha256=sha(D/(stem+'.stderr')))
            if mode == 'on':
                receipt.update(samples=stem+'.jsonl', samples_sha256=sha(D/(stem+'.jsonl')))
            raw['sessions'].append(receipt)
            with (D/(stem+'.receipt.json')).open('x') as f:
                json.dump(receipt, f, indent=2); f.write('\n')
            print(pair, mode, proc.returncode, flush=True)
            assert proc.returncode == 0, stem
    with (D/'raw.json').open('x') as f:
        json.dump(raw, f, indent=2); f.write('\n')


if __name__ == '__main__':
    main()
