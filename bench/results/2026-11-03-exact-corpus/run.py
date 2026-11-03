#!/usr/bin/env python3
"""Fixed same-executable corpus comparison. Does not select runtime candidates."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import time

D = Path(__file__).resolve().parent
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()
load = lambda p: json.loads(Path(p).read_text())
p = load(D/'protocol.json')
b = load(D/'binary.json')

def check_inputs():
    assert sha(b['path']) == b['sha256']
    for directory, schema in [('corpus','glass.tput-corpus/v1'), ('generated','glass.generated-corpus/v1')]:
        m = load(D/directory/'manifest.json')
        assert m['schema'] == schema and (m['rows'],m['cols']) == (39,154)
        assert set(m['workloads']) == set(p['workloads'])
        for name,v in m['workloads'].items():
            file = D/directory/(name+'.bin')
            assert sha(file) == v['sha256'] and file.stat().st_size == v['bytes']
    for file,digest in b['source_sha256'].items():
        assert sha(D.parents[2]/file) == digest

check_inputs()
assert not (D/'started.json').exists() and not (D/'raw.json').exists()
settings = dict(GLASS_BENCH_SCALE=str(float(p['scale'])), GLASS_BENCH_ROUNDS=str(p['rounds']),
                GLASS_BENCH_READ=str(p['read']), GLASS_BENCH_ONLY=','.join(p['workloads']))
base_env = {k:v for k,v in os.environ.items() if not k.startswith('GLASS_')} | settings
raw = dict(schema='glass.exact-corpus-raw/v1', protocol_sha256=sha(D/'protocol.json'), binary=b,
           manifests={d:sha(D/d/'manifest.json') for d in ['corpus','generated']}, settings=settings,sessions=[])
with (D/'started.json').open('x') as f:
    json.dump(dict(started_utc=datetime.now(timezone.utc).isoformat(), protocol_sha256=raw['protocol_sha256']),f,indent=2)
for block in range(p['blocks']):
    for slot,arm in enumerate(p['orders'][block%len(p['orders'])]):
        check_inputs()
        env = base_env | (dict(GLASS_BENCH_CORPUS=str(D/'corpus')) if arm == 'exact' else {})
        argv = [b['path'],'--ignored','--exact','--nocapture','speed::speed']
        row = dict(block=block,slot=slot,arm=arm,argv=argv,corpus_env=env.get('GLASS_BENCH_CORPUS'),
                   start_ns=time.monotonic_ns(), started_utc=datetime.now(timezone.utc).isoformat())
        proc = subprocess.run(argv,env=env,capture_output=True,text=True,timeout=900)
        row.update(end_ns=time.monotonic_ns(),exit=proc.returncode,stdout=proc.stdout,stderr=proc.stderr)
        raw['sessions'].append(row)
        (D/'raw.tmp').write_text(json.dumps(raw,indent=2)+'\n'); (D/'raw.tmp').replace(D/'raw.json')
        print(block,slot,arm,proc.returncode,flush=True)
        assert proc.returncode == 0
check_inputs()
