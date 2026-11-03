#!/usr/bin/env python3
"""Run all requested arms; retain every exit, byte and executed configuration."""
from pathlib import Path
import argparse,subprocess,hashlib,json,os
p=argparse.ArgumentParser();p.add_argument('--binary',required=True);p.add_argument('--arm',required=True);p.add_argument('--tests',nargs='+',default=['blank_witness_marker_matrix','blank_witness_deleted_line_matrix']);a=p.parse_args()
D=Path(__file__).resolve().parent;rows=[]
for cap in [0,1,2,8,32,10000]:
 for test in a.tests:
  argv=[a.binary,'--exact','--ignored','--nocapture','intake::position_tests::'+test]
  log=D/f'{a.arm}-{test}-{cap}.log'
  with log.open('wb') as f:r=subprocess.run(argv,env={**os.environ,'GLASS_SCROLLBACK':str(cap)},stdout=f,stderr=subprocess.STDOUT)
  rows.append({'capacity':cap,'test':test,'argv':argv,'exit':r.returncode,'log':log.name,'log_sha256':hashlib.sha256(log.read_bytes()).hexdigest(),'binary_sha256':hashlib.sha256(Path(a.binary).read_bytes()).hexdigest()})
  print(a.arm,cap,test,r.returncode,flush=True)
(D/f'{a.arm}-runs.json').write_text(json.dumps(rows,indent=2)+'\n')
