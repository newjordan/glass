#!/usr/bin/env python3
"""Exact source copies, sequential release builds and frozen diagnostic runs."""
import hashlib,json,os,subprocess,sys
from pathlib import Path
D=Path(__file__).resolve().parent;ROOT=D.parents[2]
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
paths=['crates/alacritty-terminal/src/grid/mod.rs','crates/alacritty-terminal/src/term/mod.rs','crates/term/src/engine.rs','crates/term/src/intake/position_tests.rs']
final={p:(ROOT/p).read_bytes() for p in paths}
try:
 for arm in ['control','candidate','final']:
  for p in paths:
   if arm=='final': data=final[p]
   elif p=='crates/term/src/intake/position_tests.rs':data=(D/'control-crates_term_src_intake_position_tests.rs').read_bytes()
   else:data=(D/((('control-' if arm=='control' else 'candidate-v2-'))+p.replace('/','_'))).read_bytes()
   (ROOT/p).write_bytes(data)
   (D/('bound-'+arm+'-'+p.replace('/','_'))).write_bytes(data)
  binary='/tmp/glass-i36-bound-'+arm
  with (D/('build-bound-'+arm+'.stdout')).open('xb') as out,(D/('build-bound-'+arm+'.stderr')).open('xb') as err:
   subprocess.run([sys.executable,'-B',str(D/'build.py'),'--out',binary,'--receipt-dir',str(D/('build-bound-'+arm))],stdout=out,stderr=err,check=True)
  tests=[('terminal-tests',(['--skip','movement_authority','--skip','growth_keeps_picture_on_marker_diagnostic'] if arm=='control' else ['--skip','movement_authority_growth_coordinate_diagnostic','--skip','growth_keeps_picture_on_marker_diagnostic']) if arm!='final' else [],{'GLASS_SCROLLBACK':'10000'})]
  if arm!='final':
   tests +=[(n,['--exact','--nocapture',ns+n],{'GLASS_SCROLLBACK':'10000'}) for n,ns in [('movement_authority_cursor_history_resize_matrix','engine::tests::'),('movement_authority_inactive_primary_resize','engine::tests::'),('movement_authority_growth_coordinate_diagnostic','engine::tests::'),('growth_keeps_picture_on_marker_diagnostic','intake::position_tests::')]]
   tests +=[('history-'+str(h),['--exact','--nocapture','engine::tests::movement_authority_configured_history'],{'GLASS_SCROLLBACK':str(h)}) for h in [0,1,2,8,32,10000]]
  else:
   tests +=[(n,['--exact','--nocapture',ns+n],{'GLASS_SCROLLBACK':'10000'}) for n,ns in [('inactive_primary_height_shrink_coordinate_defect_is_reproducible','engine::tests::'),('height_growth_picture_coordinate_defect_is_reproducible','intake::position_tests::')]]
  tests += [('sweep',['--ignored','--exact','--nocapture','speed::plain_runs_match_the_parser_over_seeds'],{'GLASS_SWEEP_SEEDS':'64','GLASS_SWEEP_ROUNDS':'200','GLASS_SCROLLBACK':'10000'})]
  rows=[]
  for label,args,settings in tests:
   log=D/('bound-'+arm+'-'+label+'.log')
   env={k:v for k,v in os.environ.items() if not k.startswith(('GLASS_','LD_PRELOAD'))};env.update(settings)
   with log.open('xb') as f:r=subprocess.run([binary,*args],stdout=f,stderr=subprocess.STDOUT,env=env,timeout=120)
   rows.append(dict(label=label,args=args,settings=settings,exit=r.returncode,log=log.name,sha256=sha(log)))
   print(arm,label,r.returncode,flush=True)
  (D/('bound-'+arm+'-tests.json')).write_text(json.dumps(rows,indent=2)+'\n')
finally:
 for p,data in final.items():(ROOT/p).write_bytes(data)
