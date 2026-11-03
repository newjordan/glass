#!/usr/bin/env python3
"""Replay isolated, instrumented cache-state logs. Never measures RSS or time."""
import hashlib
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent


def analyze():
    rows = []
    for arm in ('control', 'candidate'):
        for case in ('c1', 'ascii', 'unicode'):
            path = HERE / f'cold-{arm}-{case}.log'
            text = path.read_text()
            assert 'test result: ok. 1 passed; 0 failed;' in text
            hits = re.findall(r'WIDTH_CACHE_DIAGNOSTIC case=(\w+) initialized=(true|false) entries=(\d+) atomic_bytes=(\d+)', text)
            assert len(hits) == 1
            name, initialized, entries, atomic_bytes = hits[0]
            assert name == case and int(entries) == 0x110000 and int(atomic_bytes) == 1
            wanted = case == 'unicode' or (arm == 'candidate' and case == 'c1')
            assert (initialized == 'true') == wanted
            rows.append(dict(arm=arm, case=case, initialized=initialized == 'true',
                             entries=int(entries), atomic_bytes=int(atomic_bytes),
                             log_sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    return dict(schema='glass.width-handle-cold-observations/v1', observations=rows,
                deduced_cache_payload_bytes=0x110000,
                caveat='Fresh-process instrumented cache-state observations only, not allocator/RSS/timing measurements. '
                       'Same OnceLock relocation for both arms. Post-screen diagnostic cannot reverse failed performance gate.')


if __name__ == '__main__':
    print(json.dumps(analyze(), indent=2))
