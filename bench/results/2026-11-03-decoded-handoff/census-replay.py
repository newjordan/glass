#!/usr/bin/env python3
"""Decode attempt counts from instrumented diagnostic runs; never use their rates."""
import hashlib
import json
from pathlib import Path
import re

D = Path(__file__).resolve().parent
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()


def check():
    p = json.loads((D / 'decode-census-protocol.json').read_text())
    raw = json.loads((D / 'decode-census-raw.json').read_text())
    assert raw['schema'] == 'glass.decode-census-raw/v1'
    assert raw['protocol_sha256'] == sha(D / 'decode-census-protocol.json')
    assert raw['runner_sha256'] == sha(D / 'count-decodes.py')
    assert len(raw['sessions']) == 2
    table = {}
    for arm, session in zip(p['arms'], raw['sessions']):
        binary = f'/tmp/glass-i27-count-{arm}-test'
        assert session['arm'] == arm and session['exit'] == 0
        assert session['argv'] == [binary, '--ignored', '--exact', '--nocapture', 'speed::speed']
        assert session['binary_sha256'] == sha(binary)
        assert session['settings'] == dict(GLASS_BENCH_SCALE=p['scale'], GLASS_BENCH_ROUNDS=p['rounds'], GLASS_BENCH_READ=p['read'], GLASS_BENCH_ONLY=','.join(p['workloads']))
        census = re.findall(r'^test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', session['stdout'], re.M)
        assert census == [('ok', '1', '0', '0')]
        rows = re.findall(r'^decode-calls (\w+): \[(\d+), (\d+), (\d+)\]$', session['stderr'], re.M)
        assert [r[0] for r in rows] == p['workloads']
        table[arm] = {r[0]: list(map(int, r[1:])) for r in rows}
    for arm in p['arms']:
        assert all(table[arm][w] == [0, 0, 0] for w in p['workloads'] if w != 'unicode')
    c, v = table['control']['unicode'], table['candidate']['unicode']
    assert c == [78778, 1410225, 1054160] and v == [39389, 1365614, 1033024]
    return dict(schema='glass.decode-census-analysis/v1', counts=table, unicode_attempt_ratio=sum(v)/sum(c),
                unicode_non_ascii_attempt_ratio=v[2]/c[2], unicode_nonempty_attempt_ratio=sum(v[1:])/sum(c[1:]),
                unicode_removed_attempts=sum(c)-sum(v), timing_rates_used=False,
                note='Instrumented test-only builds, one run per arm at scale .25, not timing data. Lead categories count attempts, not valid codepoints. Fewer calls do not imply fewer cycles, instructions or optimized instructions in the uninstrumented binary.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
