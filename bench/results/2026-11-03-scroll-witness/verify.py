#!/usr/bin/env python3
"""Read-only bounded research replay; neither promotion nor championship acceptance."""
import ast,hashlib,importlib.util,itertools,json,re,subprocess
from pathlib import Path
D=Path(__file__).resolve().parent; ROOT=D.parents[2]; H=[0,1,2,8,32,10000]
def need(ok,why):
 if not ok:raise ValueError(why)
def unique(pairs):
 out={}
 for k,v in pairs:need(k not in out,'duplicate JSON key');out[k]=v
 return out
def load(p):return json.loads(Path(p).read_text(),object_pairs_hook=unique)
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def module(name,p):
 spec=importlib.util.spec_from_file_location(name,p);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m
P=module('persistent_i41',ROOT/'bench/results/2026-11-03-persistent-witness/verify.py')
FIELDS=['before_m','before_p','after_m','after_p','final_m','got','expected']
PAT=re.compile(r'scroll-witness fast=(false|true) alt=(false|true) row=([1-5]) delta=(-?\d+) op=(SU|SD|IL|DL|RI|LF) '+ ' '.join(k+r'=(\[[^\]]*\])' for k in FIELDS)+r' pass=(false|true)')
KEYS=set(itertools.product(['false','true'],['false','true'],range(1,6),[0,3,8,-8],['SU','SD','IL','DL','RI','LF']))
def shift(r,top,down):
 if r<top or r>=7:return r
 if down:return r+1 if r<6 else None
 return r-1 if r>top else None
def vector(text):return P.BW.vector(text)
def matrix(text,arm):
 need(arm in ['stale','transport','aware'],'unknown arm');seen={};bad=[]
 for line in text.splitlines():
  if not line.startswith('scroll-witness '):continue
  m=PAT.fullmatch(line);need(m is not None,'record shape');f,a,r,d,op,*tail=m.groups();r=int(r);d=int(d);key=f,a,r,d,op
  need(key in KEYS and key not in seen,'invalid/duplicate configuration')
  *coords,flag=tail;bm,bp,am,ap,fm,got,reported=[vector(s) for s in coords]
  need(len(bm)==len(bp)==1 and len(fm)<=1,'marker/picture multiplicity')
  need(bool(am)==bool(fm),'marker survival across width-only resize')
  need((bp[0][0]-bm[0][0])*7+bp[0][1]-bm[0][1]==d,'initial signed offset')
  need(all(0<=c<7 for _,c in bm+bp+am+ap),'intermediate column range')
  need(all(0<=c<10 for _,c in fm+got+reported),'final column range')
  top=3 if op in ['IL','DL'] else 1;down=op in ['SD','IL','RI']
  sm=shift(bm[0][0],top,down);sp=shift(bp[0][0],top,down)
  need(am==([] if sm is None else [(sm,bm[0][1])]),'independent marker scroll')
  suppressed=bp[0][0]+1<=top
  physical=[] if sp is None else [(sp,bp[0][1])]
  want_ap=[] if (arm=='aware' or arm=='transport' and not suppressed) and sm is None else physical
  need(ap==want_ap,'independent picture scroll')
  expected=[]
  if sm is not None and sp is not None and fm:
   offset=(sp-sm)*7+bp[0][1]-bm[0][1];flat=fm[0][0]*10+fm[0][1]+offset
   row,col=divmod(flat,10)
   if 0<=row<8:expected=[(row,col)]
  need(reported==expected,'oracle expectation mismatch')
  passed=got==expected;need(flag==str(passed).lower(),'copied pass flag')
  if not passed:bad.append(key)
  seen[key]=(bm,bp,am,fm,expected)
 need(set(seen)==KEYS,'incomplete configuration set')
 expected_failures={'stale':372,'transport':24,'aware':0}[arm]
 need(len(bad)==expected_failures,'wrong failure count')
 if arm=='transport':
  residual={(f,a,r,-8,op) for f,a in itertools.product(['false','true'],repeat=2) for r,ops in [(1,['SU','SD','RI','LF']),(3,['IL','DL'])] for op in ops}
  need(set(bad)==residual,'residuals not confined to witness-only authority')
 need(text.count(f'scroll-witness-summary cases=480 failures={expected_failures}')==1,'summary mismatch')
 need('running 1 test\n' in text,'zero-test receipt')
 result='ok. 1 passed; 0 failed' if expected_failures==0 else 'FAILED. 0 passed; 1 failed'
 need('test result: '+result in text,'matrix test result')
 return {'cases':480,'failures':len(bad)},seen

def build(folder):
 identity=load(D/folder/'identity.json');rows=[json.loads(l) for l in (D/folder/'cargo.jsonl').read_text().splitlines()]
 for package in ['vte','alacritty_terminal','glass']:
  found=[r for r in rows if r.get('reason')=='compiler-artifact' and r['target']['name']==package]
  need(len(found)==1 and found[0]['fresh'] is False,'stale build')
 need(any(r.get('reason')=='build-finished' and r.get('success') is True for r in rows),'build completion')
 binary=Path(identity['executable'])
 # Native commands are not re-executed by this checker. A retained executable,
 # if still available, must agree; source and compiler receipts are mandatory.
 if binary.exists():need(sha(binary)==identity['sha256'],'changed retained executable')
 return identity

def verify():
 state=load(D/'starting-state.json')
 for name,r in state['sources'].items():
  if r:need(sha(ROOT/name)==r['sha256']==sha(D/r['source']),'shipping source changed: '+name)
  else:need(not (ROOT/name).exists(),'research source not removed: '+name)
 need(sha(ROOT/'target/release/glass')==state['shipping_sha256'],'shipping executable changed')
 for name in ['CHANGELOG.md','bench/README.md','docs/PERFORMANCE.md']:
  need((ROOT/name).read_bytes().startswith((D/('original-'+name.replace('/','_'))).read_bytes()),'append-only note '+name)
 # Prior tracked files are immutable; the three additive narrative documents
 # have independent pre-iteration snapshots and are intentionally excluded.
 protected={n:b for n,b in state['preserve'].items() if n not in ['CHANGELOG.md','bench/README.md','docs/PERFORMANCE.md']}
 raw=subprocess.check_output(['git','hash-object','--stdin-paths'],input='\n'.join(protected)+'\n',text=True,cwd=ROOT).splitlines()
 need(raw==list(protected.values()),'prior tracked bytes changed')
 identities={k:build(v) for k,v in {'stale':'build-stale-final','transport':'build-transport-final','aware':'build-aware-final','restored':'build-restored'}.items()}
 for arm,ident in identities.items():
  for name,hash_ in ident['source_sha256'].items():
   if arm=='restored':p=ROOT/name
   elif name in ['crates/term/src/intake/mod.rs','crates/term/src/intake/motion.rs'] and arm=='transport':p=D/('transport-only-'+name.replace('/','_'))
   elif name in ['crates/term/src/intake/mod.rs','crates/term/src/intake/motion.rs'] and arm=='stale':p=ROOT/'bench/results/2026-11-03-persistent-witness'/('candidate-final-'+name.replace('/','_'))
   else:p=D/('candidate-final-'+name.replace('/','_'))
   need(sha(p)==hash_,'build/source binding '+arm+' '+name)
 result={};reference={}
 for arm,prefix in [('stale','stale-final'),('transport','transport-final'),('aware','aware')]:
  runs=load(D/(prefix+'-runs.json'));need(len(runs)==6,'matrix run inventory')
  aggregate=[]
  for cap,run in zip(H,runs):
   need(run['capacity']==cap and run['test']=='scroll_witness_matrix','settings receipt')
   need(run['exit']==(0 if arm=='aware' else 101),'matrix exit')
   need(run['binary_sha256']==identities[arm]['sha256'],'matrix binary binding')
   need(run['argv']==[identities[arm]['executable'],'--exact','--ignored','--nocapture','intake::position_tests::scroll_witness_matrix'],'matrix argv')
   p=D/run['log'];need(sha(p)==run['log_sha256'],'matrix log hash')
   summary,oracle=matrix(p.read_text(),arm);aggregate.append({'capacity':cap,**summary})
   if arm=='stale':reference[cap]=oracle
   else:need(oracle==reference[cap],'arm oracle mismatch')
  result[arm]=aggregate
 # Exact pre-existing matrix parsers independently re-derive all old expectations.
 runs=load(D/'aware-bound-exact-runs.json');need(len(runs)==30,'bound matrix inventory')
 totals={'height':0,'mixed':0,'unicode':0,'deleted_eligible':0,'slots_continuous':0}
 names=[('height','height_snapshot_marker_picture_matrix'),('mixed','mixed_snapshot_marker_picture_matrix'),('unicode','origin_map_unicode_marker_matrix'),('slots','blank_witness_marker_matrix'),('deleted','blank_witness_deleted_line_matrix')]
 for idx,run in enumerate(runs):
  cap=H[idx//5];kind,name=names[idx%5];need((run['capacity'],run['test'])==(cap,name),'bound settings')
  need(run['binary_sha256']==identities['aware']['sha256'],'bound binary binding')
  need(run['exit']==(101 if kind=='slots' else 0),'bound exit')
  p=D/run['log'];need(sha(p)==run['log_sha256'],'bound log hash');text=p.read_text();need('running 1 test\n' in text,'zero-test bound matrix')
  if kind=='height':P.HS.height_observations(text,cap,0);totals['height']+=9360
  elif kind=='mixed':P.OM.mixed_observations(text,P.HS);totals['mixed']+=3456
  elif kind=='unicode':P.OM.observations(text,0);totals['unicode']+=20736
  elif kind=='deleted':x=P.BW.deletion(text);totals['deleted_eligible']+=x['eligible']
  else:
   x=P.BW.slots(text);totals['slots_continuous']+=x['continuous_in_bounds_cases']
   need(x['continuous_in_bounds_failures']==0 and x['failures']==[560,400,424,448,448,448][H.index(cap)],'known slot limits changed')
 need(totals=={'height':56160,'mixed':20736,'unicode':124416,'deleted_eligible':1632,'slots_continuous':168296},'bound totals')
 P.roundtrips((D/'aware-roundtrip.log').read_text());need((D/'aware-roundtrip.exit').read_text().strip()=='0','roundtrip exit')
 for row in load(D/'reset-runs.json'):
  arm=row['arm'];need(arm in identities and row['binary_sha256']==identities[arm]['sha256'],'reset binary binding')
  need(row['settings']=={'GLASS_SCROLLBACK':'10000'},'reset settings')
  need(row['argv']==[identities[arm]['executable'],'--exact','--ignored','--nocapture','intake::position_tests::scroll_witness_reset_lifetime'],'reset argv')
  p=D/row['log'];need(sha(p)==row['sha256'],'reset log hash');text=p.read_text()
  need(row['exit']==(101 if arm=='stale' else 0) and 'running 1 test' in text,'reset executed')
  for fast in (['false'] if arm=='stale' else ['false','true']):
   need(f'reset-lifetime fast={fast} placements=0 saved={1 if arm=="stale" else 0}' in text,'reset lifetime state')
 need([r['arm'] for r in load(D/'reset-runs.json')]==['stale','transport','aware'],'reset inventory')
 for fast in ['false','true']:need(f'reset-lifetime fast={fast} placements=0 saved=0' in (D/'aware-reset.log').read_text(),'reset cleanup')
 need((D/'aware-reset.exit').read_text().strip()=='0','reset exit')
 need('placements=0 saved=1' in (D/'stale-scroll_witness_reset_lifetime.log').read_text(),'reset control not reproduced')
 for prefix in ['aware-sweep-exact','restored-sweep']:
  text=(D/(prefix+'.log')).read_text();need('swept 12800 streams over 64 seeds: no divergence' in text and 'test result: ok. 1 passed; 0 failed' in text,'differential sweep')
 need('test result: ok. 392 passed; 0 failed; 14 ignored' in (D/'restored-terminal.log').read_text(),'restored full suite')
 need('test result: FAILED. 389 passed; 3 failed; 23 ignored' in (D/'aware-terminal.log').read_text(),'research full suite limits')
 need(set(re.findall(r'^    ((?:engine|intake)::[^\n]+)$',(D/'aware-terminal.log').read_text(),re.M))=={'engine::tests::inactive_primary_height_shrink_coordinate_defect_is_reproducible','intake::position_tests::height_growth_picture_coordinate_defect_is_reproducible','intake::position_tests::mixed_resize_round_trip_picture_defect_is_reproducible'},'unexpected research failures')
 need('Ran 6 tests' in (D/'python-tests.log').read_text() and (D/'python-tests.log').read_text().rstrip().endswith('OK'),'checker adversarial tests')
 return {'schema':'glass.scroll-witness-replay/v1','matrices':result,'prior_bounds':totals,'reset_saved_control':1,'reset_saved_candidate':0,'restored_tests':392,'differential_streams_per_arm':12800,'shipping_sha256':state['shipping_sha256'],'note':'Research-only finite scope; broad slots and three defect-characterization tests still fail. No timing, memory, general-write or competitive acceptance.'}
if __name__=='__main__':print(json.dumps(verify(),indent=2))
