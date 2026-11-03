#!/usr/bin/env python3
"""Disposable real-capture corruption checks; canonical inputs are read only."""
import hashlib
import importlib.util
import json
from pathlib import Path
import shutil
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
spec = importlib.util.spec_from_file_location('replay', ROOT/'bench/linux/analyze-reader-contention.py')
replay = importlib.util.module_from_spec(spec)
spec.loader.exec_module(replay)
source = HERE/'pilot-v2'

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def fingerprint(root):
    return {str(p.relative_to(root)): sha(p) for p in root.rglob('*') if p.is_file()}

def load(p):
    return json.loads(p.read_text())

def write(p, d):
    p.write_text(json.dumps(d, indent=2)+'\n')

before_source = fingerprint(source)
rows = []
for case in ('hash', 'truncated-trace', 'rate', 'reader-identity', 'producer-mask',
             'reader-mask', 'helper-incomplete', 'order', 'source-set', 'duplicate-key'):
    with tempfile.TemporaryDirectory() as temp:
        root = Path(temp)/'capture'
        shutil.copytree(source, root)
        manifest = load(root/'manifest.json')
        stem = root/'tput-sleep-plain-1'
        raw = stem.with_suffix('.json')
        profile = stem.with_suffix('.profile.json')
        sidecar = stem.with_suffix('.contention.json')
        if case == 'hash':
            raw.write_bytes(raw.read_bytes()+b' ')
        elif case == 'truncated-trace':
            p = root/'sleep-sched-1.trace'
            p.write_bytes(p.read_bytes()[:-1])
        elif case == 'rate':
            d = load(raw);d['results']['ascii']['mb_s'] += 1;write(raw,d)
            p = load(profile);p['result_sha256'] = sha(raw);write(profile,p)
            c = load(sidecar);c['result_sha256'] = sha(raw);c['profile_result_sha256'] = sha(profile);write(sidecar,c)
        elif case in ('reader-identity', 'producer-mask', 'reader-mask'):
            p = load(profile)
            if case == 'producer-mask':
                p['passes'][0]['producer_before']['allowed'] = '0'
            else:
                tid = load(sidecar)['reader_tid']
                task = next(t for t in p['passes'][0]['terminal_before'] if t['tid'] == tid)
                if case == 'reader-identity': task['start_ticks'] += 1
                else: task['allowed'] = '0-31'
            write(profile,p)
            c = load(sidecar);c['profile_result_sha256'] = sha(profile);write(sidecar,c)
        elif case == 'helper-incomplete':
            c = load(sidecar);c['helper_finish']['complete'] = False;write(sidecar,c)
        elif case == 'order':
            manifest['orders'][0].reverse()
        elif case == 'source-set':
            del manifest['sha256'][str((ROOT/'bench/tput.py').resolve())]
        elif case == 'duplicate-key':
            raw.write_text(raw.read_text().replace('{', '{"cols":154,', 1))
        if case != 'hash':
            manifest['raw_sha256'] = {name:sha(root/name) for name in manifest['raw_sha256']}
        write(root/'manifest.json',manifest)
        before = fingerprint(root)
        try:
            replay.analyze(root)
            raise AssertionError(f'accepted {case}')
        except ValueError as error:
            assert before == fingerprint(root), f'replay mutated {case}'
            rows.append(dict(case=case, rejected=True, reason=str(error), unchanged_files=len(before)))
assert before_source == fingerprint(source)
print(json.dumps(dict(schema='glass.contention-corruption/v1', cases=rows,
                     canonical_unchanged=True),indent=2))
