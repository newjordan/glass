#!/usr/bin/env python3
"""Run exact isolated test-arm inventory, preserving failures and exits."""
from pathlib import Path
import argparse,os,subprocess,json,hashlib
D=Path(__file__).resolve().parent
p=argparse.ArgumentParser();p.add_argument('--binary',required=True);p.add_argument('--arm',required=True);p.add_argument('--restored',action='store_true');a=p.parse_args()
H=[0,1,2,8,32,10000];tasks=[]
if not a.restored:
 for kind,name in [('height','height_snapshot_marker_picture_matrix'),('mixed','mixed_snapshot_marker_picture_matrix'),('unicode','origin_map_unicode_marker_matrix'),('slots','blank_witness_marker_matrix'),('deleted','blank_witness_deleted_line_matrix')]:
  for h in H:tasks.append((kind+'-'+str(h),['--exact','--ignored','--nocapture','intake::position_tests::'+name],{'GLASS_SCROLLBACK':str(h)}))
 for name in ['persistent_witness_roundtrips','persistent_witness_intervening_scroll_characterization']:
  tasks.append((name,['--exact','--ignored','--nocapture','intake::position_tests::'+name],{'GLASS_SCROLLBACK':'10000'}))
tasks.extend([('terminal',[],{'GLASS_SCROLLBACK':'10000'}),('sweep',['--exact','--ignored','--nocapture','speed::plain_runs_match_the_parser_over_seeds'],{'GLASS_SCROLLBACK':'10000','GLASS_SWEEP_SEEDS':'64','GLASS_SWEEP_ROUNDS':'200'})])
rows=[]
for label,args,settings in tasks:
 log=D/(a.arm+'-'+label+'.log');env=os.environ.copy();env.update(settings)
 with log.open('w') as f:r=subprocess.run([a.binary,*args],env=env,stdout=f,stderr=subprocess.STDOUT,timeout=180)
 rows.append({'label':label,'args':args,'settings':settings,'exit':r.returncode,'log':log.name,'sha256':hashlib.sha256(log.read_bytes()).hexdigest()})
 (D/(a.arm+'-runs.json')).write_text(json.dumps(rows,indent=2)+'\n')
 print(label,r.returncode,flush=True)
