#!/usr/bin/env python3
"""Retain actual commands, exits and byte hashes for three explicit finite arms."""
from pathlib import Path
import hashlib
import json
import os
import subprocess

D=Path(__file__).resolve().parent
rows=[]
for arm,binary,args in [
    ('control','/tmp/glass-i42-shipping-control',['--exact','intake::position_tests::split_identity_repeated_band_scroll']),
    ('production','/tmp/glass-i42-production-final',['--exact','intake::position_tests::split_identity_repeated_band_scroll']),
    ('prototype','/tmp/glass-i42-local-v2',['intake::position_tests::split_witness']),
]:
    argv=[binary,'--test-threads=1','--nocapture',*args]
    log=D/(arm+'-measured.log')
    with log.open('wb') as f:
        result=subprocess.run(argv,env={**os.environ,'GLASS_SCROLLBACK':'10000'},stdout=f,stderr=subprocess.STDOUT,timeout=60)
    rows.append({'arm':arm,'argv':argv,'environment':{'GLASS_SCROLLBACK':'10000'},'exit':result.returncode,'binary_sha256':hashlib.sha256(Path(binary).read_bytes()).hexdigest(),'log':log.name,'log_sha256':hashlib.sha256(log.read_bytes()).hexdigest()})
    print(arm,result.returncode,flush=True)
(D/'runs.json').write_text(json.dumps(rows,indent=2)+'\n')
