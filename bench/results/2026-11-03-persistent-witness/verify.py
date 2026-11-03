#!/usr/bin/env python3
"""Read-only finite research replay, not campaign acceptance or attestation."""
import ast,hashlib,importlib.util,itertools,json,re
from pathlib import Path
D=Path(__file__).resolve().parent
ROOT=D.parents[2]
H=[0,1,2,8,32,10000]
def need(ok,why):
 if not ok:raise ValueError(why)
def unique(pairs):
 out={}
 for k,v in pairs:need(k not in out,'duplicate JSON key');out[k]=v
 return out
def load(p):return json.loads(Path(p).read_text(),object_pairs_hook=unique)
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def module(name,path):
 spec=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m
BW=module('bw',ROOT/'bench/results/2026-11-03-blank-witness/verify.py')
OM=module('om',ROOT/'bench/results/2026-11-03-origin-map/verify.py')
HS=module('hs',ROOT/'bench/results/2026-11-03-height-snapshot/verify.py')
ROUND=re.compile(r'roundtrip-case alt=(false|true) fast=(false|true) name=(tail|blank|right|wide) step=([0-3]) pictures=(\[[^\]]*\]) expected=(\([^)]*\)) anchor=(\{.*\})')
def roundtrips(text):
 seen={}
 for line in text.splitlines():
  if not line.startswith('roundtrip-case'):continue
  m=ROUND.fullmatch(line);need(m is not None,'roundtrip shape');a,f,name,step,pics,expected,anchor=m.groups();key=(a,f,name,int(step));need(key not in seen,'duplicate roundtrip')
  p=BW.vector(pics);e=ast.literal_eval(expected);need(type(e) is tuple and len(e)==2 and all(type(v)is int for v in e),'roundtrip integer coordinate')
  want= (1,0) if name=='blank' or (name=='tail' and int(step)%2==0) else (0,3) if name=='tail' else ((-1,1) if int(step)==0 else (-1,4)) if name=='right' else ((1,0) if int(step)==0 else (-1,5))
  need(e==want and p==[want],'independent roundtrip destination')
  mode='{3: Physical}' if name=='blank' else re.fullmatch(r'\{3: Witness \{ line: \d+, column: \d+\.0, delta: '+('3' if name in ['tail','wide'] else '-2')+r'\.0 \}\}',anchor)
  need(anchor=='{3: Physical}' if name=='blank' else mode is not None,'persistent mode and offset')
  seen[key]=p
 need(set(seen)==set(itertools.product(['false','true'],['false','true'],['tail','blank','right','wide'],range(4))),'complete 64 roundtrips')
 need(text.count('roundtrip-summary cases=64')==1 and len(re.findall('^roundtrip-summary',text,re.M))==1,'roundtrip summary')
 need('test result: ok. 1 passed; 0 failed;' in text,'roundtrip nonempty test')
 return 64
def scroll(text):
 rows=[l for l in text.splitlines() if l.startswith('scroll-characterization')]
 need(rows==[f'scroll-characterization fast={f} markers=[(1, 0)] pictures=[(2, 3)]' for f in ['false','true']],'independently known scroll counterexample')
 need('test result: ok. 1 passed; 0 failed;' in text,'scroll characterization ran')
 return 2
def binding(arm):
 folder=D/('build-'+arm);r=load(folder/'identity.json')
 expected={p.name[len('candidate-final-'):].replace('_','/').replace('position/tests.rs','position_tests.rs') for p in D.glob('candidate-final-crates*')}
 if arm=='restored':expected.remove('crates/alacritty-terminal/src/grid/origin.rs')
 need(set(r['source_sha256'])==expected,'all stateful source bindings')
 for name,digest in r['source_sha256'].items():need(sha(D/('candidate-final-'+name.replace('/','_')) if arm=='candidate-bound' else ROOT/name)==digest,'exact build source '+name)
 need(r['command']==['cargo','test','--release','-p','glass-term','--locked','--no-run','--message-format=json'],'release locked build')
 events=[json.loads(l) for l in (folder/'cargo.jsonl').read_text().splitlines()]
 for name in ['glass','vte','alacritty_terminal']:
  rows=[e for e in events if e.get('reason')=='compiler-artifact' and e['target']['name']==name];need(len(rows)==1 and rows[0]['fresh'] is False,'nonfresh '+name)
 need(events[-1]=={'reason':'build-finished','success':True},'build finished')
 if Path(r['executable']).exists():need(sha(r['executable'])==r['sha256'],'exact local binary')
 return r
def inventory():
 tasks=[]
 for kind,name in [('height','height_snapshot_marker_picture_matrix'),('mixed','mixed_snapshot_marker_picture_matrix'),('unicode','origin_map_unicode_marker_matrix'),('slots','blank_witness_marker_matrix'),('deleted','blank_witness_deleted_line_matrix')]:
  for h in H:tasks.append((kind+'-'+str(h),['--exact','--ignored','--nocapture','intake::position_tests::'+name],{'GLASS_SCROLLBACK':str(h)}))
 for name in ['persistent_witness_roundtrips','persistent_witness_intervening_scroll_characterization']:tasks.append((name,['--exact','--ignored','--nocapture','intake::position_tests::'+name],{'GLASS_SCROLLBACK':'10000'}))
 tasks.extend([('terminal',[],{'GLASS_SCROLLBACK':'10000'}),('sweep',['--exact','--ignored','--nocapture','speed::plain_runs_match_the_parser_over_seeds'],{'GLASS_SCROLLBACK':'10000','GLASS_SWEEP_SEEDS':'64','GLASS_SWEEP_ROUNDS':'200'})]);return tasks
def check():
 for name,digest in load(D/'evidence-sha256.json').items():
  p=Path(name);need(not p.is_absolute() and '..' not in p.parts,'confined evidence');need(sha(ROOT/p)==digest,'sealed evidence '+name)
 state=load(D/'starting-state.json')
 for name,blob in state['preserve'].items():
  b=(ROOT/name).read_bytes();need(hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()==blob,'unchanged earlier tracked file '+name)
 for name,r in state['sources'].items():
  if r:need(sha(ROOT/name)==r['sha256']==sha(D/r['source']),'restored '+name)
  else:need(not(ROOT/name).exists(),'experimental source removed')
 need(sha(ROOT/'target/release/glass')==state['shipping_sha256'],'selected executable unchanged')
 binding('candidate-bound');binding('restored');summary=[]
 for arm in ['candidate-final','restored']:
  rows=load(D/(arm+'-runs.json'));tasks=inventory() if arm=='candidate-final' else inventory()[-2:]
  need(len(rows)==len(tasks),'exact run count')
  for row,(label,args,settings) in zip(rows,tasks):
   need(row['label']==label and row['args']==args and row['settings']==settings,'exact command inventory')
   need(row['log']==arm+'-'+label+'.log' and sha(D/row['log'])==row['sha256'],'bound log');text=(D/row['log']).read_text()
   wanted=101 if arm=='candidate-final' and (label.startswith('slots-') or label=='terminal') else 0;need(row['exit']==wanted,'actual exit')
   if label.startswith('height-'):HS.height_observations(text,int(label.split('-')[1]),0)
   elif label.startswith('mixed-'):OM.mixed_observations(text,HS)
   elif label.startswith('unicode-'):OM.observations(text,0)
   elif label.startswith('slots-'):
    v=BW.slots(text);h=int(label.split('-')[1]);need(v['failures']==[560,400,424,448,448,448][H.index(h)] and v['continuous_in_bounds_failures']==0,'slot failures and continuous gate');summary.append({'capacity':h,**v})
   elif label.startswith('deleted-'):
    v=BW.deletion(text);need(v['eligible']==[352,352,368,272,144,144][H.index(int(label.split('-')[1]))] and v['failures']==0,'deleted witness gate')
   elif label=='persistent_witness_roundtrips':roundtrips(text)
   elif label=='persistent_witness_intervening_scroll_characterization':scroll(text)
   elif label=='sweep':need('swept 12800 streams over 64 seeds: no divergence' in text and 'test result: ok. 1 passed; 0 failed;' in text,'nonempty 12800 differential streams')
   elif arm=='restored':need('test result: ok. 392 passed; 0 failed; 14 ignored;' in text,'restored suite')
   else:
    need('test result: FAILED. 389 passed; 3 failed; 21 ignored;' in text,'candidate suite')
    fail=[l.strip() for l in text.split('failures:\n')[-1].splitlines() if l.startswith('    ')]
    need(fail==['engine::tests::inactive_primary_height_shrink_coordinate_defect_is_reproducible','intake::position_tests::height_growth_picture_coordinate_defect_is_reproducible','intake::position_tests::mixed_resize_round_trip_picture_defect_is_reproducible'],'exact old defect characterizations')
 need(BW.check()==load(D/'prior-checkpoint.json'),'prior checkpoint unchanged')
 return {'schema':'glass.persistent-witness-checkpoint/v1','runtime_promoted':False,'slots':summary,'continuous_in_bounds_observations':sum(v['continuous_in_bounds_cases'] for v in summary),'continuous_in_bounds_failures':0,'broader_slot_failures':sum(v['failures'] for v in summary),'height_observations':56160,'mixed_observations':20736,'unicode_observations':124416,'deleted_observations':6912,'deleted_eligible':1632,'deleted_failures':0,'roundtrip_observations':64,'scroll_counterexamples':2,'restored_tests':392,'restored_ignored':14,'differential_streams_per_arm':12800,'preserved_tracked_files':len(state['preserve']),'selected_sha256':state['shipping_sha256']}
if __name__=='__main__':print(json.dumps(check(),indent=2,sort_keys=True))
