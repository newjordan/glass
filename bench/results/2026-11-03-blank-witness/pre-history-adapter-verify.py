#!/usr/bin/env python3
"""Read-only bounded evidence replay; no benchmark acceptance or attestation."""
import ast,hashlib,importlib.util,itertools,json,re
from pathlib import Path
D=Path(__file__).resolve().parent
ROOT=D.parents[2]
H=[0,1,2,8,32,10000]
SLOT=re.compile(r'slot-case rows=(\d+) target=(\d+) cursor=(\d+) width=(\d+) marker=(\d+) column=(\d+) kind=([acez]) gap=(\d+) records=(\d+) alt=(false|true) fast=(false|true) step=(\d+) text=(\[[^\]]*\]) expected=(\[[^\]]*\]) pictures=(\[[^\]]*\]) checked=(true|false) ok=(true|false)')
DEL=re.compile(r'deleted-case rows=(\d+) target=(\d+) cols=(\d+) marker=(\d+) cursor=(\d+) column=(\d+) records=(\d+) alt=(false|true) fast=(false|true) own=(\d+) unrelated=(\d+) pictures=(\d+) checked=(true|false) ok=(true|false)')
def need(ok,why):
 if not ok:raise ValueError(why)
def unique(pairs):
 out={}
 for k,v in pairs:
  need(k not in out,'duplicate JSON key');out[k]=v
 return out
def load(p):return json.loads(Path(p).read_text(),object_pairs_hook=unique)
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def vector(s):
 v=ast.literal_eval(s)
 need(type(v) is list and len(v)<=1 and all(type(x) is tuple and len(x)==2 and all(type(n) is int for n in x) for x in v),'integer coordinate vectors')
 return v
def slot_keys():
 return {(r,t,c,w,m,col,k,g,n,a,f,s) for r in [4,6] for t in [2,4,8] for c in [0,r-1] for w in [3,7,14,20] for m in [0,r-1] for col in [0,3] for k in 'acez' for g in [0,2] for n in [0,12] for a in ['false','true'] for f in ['false','true'] for s in range(3)}
def slots(text):
 seen=set();bad=absent=live_cases=live_bad=0;live={}
 for line in text.splitlines():
  if not line.startswith('slot-case'):continue
  m=SLOT.fullmatch(line);need(m is not None,'slot record format');g=m.groups()
  key=(*map(int,g[:6]),g[6],*map(int,g[7:9]),g[9],g[10],int(g[11]));need(key not in seen,'duplicate slot case');seen.add(key)
  r,t,c,w,m,col,k,gap,n,a,f,s=key
  marker,expected,pic=map(vector,g[12:15]);width=10 if s==1 else w;height=r if s==1 else t
  extent=2 if k in 'ce' else 1
  # This is the test's explicit logical-slot contract, not a production map.
  calculated=[]
  for row,column in marker:
   flat=row*width+column+extent+gap;dest=divmod(flat,width)
   if dest[0]<height:calculated.append(dest)
  need(expected==calculated,'independent marker-relative slot destination')
  checked=bool(marker);ok=not checked or pic==calculated
  need(g[15]==str(checked).lower() and g[16]==str(ok).lower(),'slot booleans recomputed')
  absent+=not checked;bad+=not ok
  # A second, stricter lens excludes all later steps after the logical target
  # or its glyph was outside retention. It never demands resurrection.
  chain=key[:-1];need(s==0 or chain in live,'ordered slot chain')
  survives=(s==0 or live[chain]) and bool(marker) and bool(calculated)
  live[chain]=survives;live_cases+=survives;live_bad+=survives and pic!=calculated
 need(seen==slot_keys(),'complete slot Cartesian inventory')
 need(f'slot-summary cases={len(seen)} absent={absent} failures={bad}' in text,'slot summary exact')
 return {'cases':len(seen),'absent':absent,'failures':bad,'continuous_in_bounds_cases':live_cases,'continuous_in_bounds_failures':live_bad}
def deletion_keys():
 return {(r,t,w,m,c,col,n,a,f) for r in [4,6] for t in [2,4,8] for w in [3,7,14] for m in [0,r-1] for c in [0,r-1] for col in [0,6] for n in [0,12] for a in ['false','true'] for f in ['false','true']}
def deletion(text):
 seen=set();eligible=bad=0
 for line in text.splitlines():
  if not line.startswith('deleted-case'):continue
  m=DEL.fullmatch(line);need(m is not None,'deletion record format');g=m.groups();key=(*map(int,g[:7]),g[7],g[8]);need(key not in seen,'duplicate deletion case');seen.add(key)
  own,other,pics=map(int,g[9:12]);checked=own==0 and other==1;ok=not checked or pics==0
  need(g[12]==str(checked).lower() and g[13]==str(ok).lower(),'deletion booleans recomputed');eligible+=checked;bad+=not ok
 need(seen==deletion_keys(),'complete deletion Cartesian inventory')
 need(f'deleted-summary cases={len(seen)} eligible={eligible} failures={bad}' in text,'deletion summary exact')
 return {'cases':len(seen),'eligible':eligible,'failures':bad}
def rows(name):
 records=load(D/name)
 for row in records:
  need(sha(D/row['log'])==row['log_sha256'],'raw run hash '+row['log'])
 return records
def build(name,experimental=True):
 b=D/('build-'+name);receipt=load(b/'identity.json')
 need(receipt['sha256'] and receipt['source_sha256'],'build identities')
 binary=Path(receipt['executable'])
 if binary.exists():need(sha(binary)==receipt['sha256'],'local exact binary '+name)
 need(receipt['command']==['cargo','test','--release','-p','glass-term','--locked','--no-run','--message-format=json'],'locked release build command')
 events=[json.loads(l) for l in (b/'cargo.jsonl').read_text().splitlines() if l.strip()]
 for package in ['glass','vte','alacritty_terminal']:
  match=[e for e in events if e.get('reason')=='compiler-artifact' and e['target']['name']==package]
  need(len(match)==1 and match[0].get('fresh') is False,'nonfresh package '+name+package)
 need(any(e.get('reason')=='build-finished' and e.get('success') is True for e in events),'build completion')
 return receipt
def check():
 seals=load(D/'evidence-sha256.json')
 for name,digest in seals.items():
  p=Path(name);need(not p.is_absolute() and '..' not in p.parts,'confined seal');need(sha(ROOT/p)==digest,'sealed evidence changed '+name)
 state=load(D/'starting-state.json');updates={'CHANGELOG.md','docs/PERFORMANCE.md','bench/README.md'}
 for path,digest in state['preserve'].items():
  if path not in updates:need(sha(ROOT/path)==digest,'prior tracked content '+path)
 for name in updates:need((ROOT/name).read_bytes().startswith((D/('original-'+name.replace('/','_'))).read_bytes()),'append-only notes')
 for path,item in state['sources'].items():
  if item:need(sha(ROOT/path)==item['sha256']==sha(D/item['source']),'restored source '+path)
  else:need(not (ROOT/path).exists(),'no experimental module')
 need(sha(ROOT/'target/release/glass')==state['shipping_sha256'],'selected executable unchanged')
 prior_path=ROOT/'bench/results/2026-11-03-origin-map/verify.py';sp=importlib.util.spec_from_file_location('prior',prior_path);prior=importlib.util.module_from_spec(sp);sp.loader.exec_module(prior)
 need(prior.check()==load(D/'prior-checkpoint.json')==load(D/'restored-prior-checkpoint.json'),'prior checkpoint unchanged')
 summary={};builds={n:build(n) for n in ['control','physical','candidate-v4','control-v5','final']}
 for arm in ['control','physical','witness']:
  records=rows(arm+'-runs.json');expected={(h,t) for h in H for t in ['blank_witness_marker_matrix','blank_witness_deleted_line_matrix']}
  if arm=='witness':expected|={(h,t) for h in H for t in ['origin_map_unicode_marker_matrix','height_picture_marker_matrix','mixed_resize_picture_marker_matrix']}
  need({(r['capacity'],r['test']) for r in records}==expected and len(records)==len(expected),'run inventory '+arm)
  summaries=[]
  for h in H:
   local={}
   for t in ['blank_witness_marker_matrix','blank_witness_deleted_line_matrix']:
    row=next(r for r in records if r['capacity']==h and r['test']==t);text=(D/row['log']).read_text()
    need(row['argv'][1:]==['--exact','--ignored','--nocapture','intake::position_tests::'+t],'exact matrix command')
    need(row['binary_sha256']==builds['candidate-v4' if arm=='witness' else arm]['sha256'],'matrix binary binding')
    result=slots(text) if t=='blank_witness_marker_matrix' else deletion(text)
    need(row['exit']==(101 if result['failures'] else 0),'matrix exit');need('running 1 test' in text,'matrix executed')
    local['slots' if t=='blank_witness_marker_matrix' else 'deletion']=result
   summaries.append({'capacity':h,**local})
  summary[arm]=summaries
  if arm=='witness':
   for r in records:
    text=(D/r['log']).read_text()
    if r['test']=='origin_map_unicode_marker_matrix':need(r['exit']==0,'unicode exit');prior.observations(text,0)
    if r['test'] in ['height_picture_marker_matrix','mixed_resize_picture_marker_matrix']:need(r['exit']==0 and 'running 0 tests' in text,'retained zero-test setup mistake, never a gate')
 corrected=rows('corrected-legacy-runs.json');need(len(corrected)==12,'legacy run count')
 sp=importlib.util.spec_from_file_location('height',ROOT/'bench/results/2026-11-03-height-snapshot/verify.py');height=importlib.util.module_from_spec(sp);sp.loader.exec_module(height)
 need({(r['capacity'],r['test']) for r in corrected}=={(h,t) for h in H for t in ['height_snapshot_marker_picture_matrix','mixed_snapshot_marker_picture_matrix']},'legacy inventory')
 for r in corrected:
  need(r['exit']==0 and r['binary_sha256']==builds['candidate-v4']['sha256'],'corrected run identity')
  text=(D/r['log']).read_text()
  if r['test'].startswith('height_'):height.height_observations(text,r['capacity'],0)
  else:prior.mixed_observations(text,height)
 suites=rows('corrected-suite-runs.json');need(len(suites)==6,'corrected suites inventory')
 for r in suites:
  text=(D/r['log']).read_text();arm=r['arm'];need(r['settings']['GLASS_SCROLLBACK']=='10000','suite history capacity')
  need(r['binary_sha256']==builds['candidate-v4' if arm=='witness' else arm]['sha256'],'suite binary identity')
  if r['label']=='sweep':need(r['exit']==0 and 'swept 12800 streams over 64 seeds: no divergence' in text and 'test result: ok. 1 passed; 0 failed;' in text,'executed differential sweep')
  else:
   wanted={'control':(0,'ok. 392 passed; 0 failed; 17 ignored;'),'physical':(101,'FAILED. 388 passed; 4 failed; 19 ignored;'),'witness':(101,'FAILED. 389 passed; 3 failed; 19 ignored;')}[arm]
   need(r['exit']==wanted[0] and 'test result: '+wanted[1] in text,'suite characterizations')
 characterizations=rows('characterization-runs.json')
 need(len(characterizations)==2 and {r['arm'] for r in characterizations}=={'control-v5','candidate-v4'},'characterization inventory')
 for r in characterizations:
  arm=r['arm'];identity=builds[arm]
  test='blank_witness_shipping_ghost_characterization' if arm=='control-v5' else 'blank_witness_indistinguishable_histories'
  need(r['argv'][1:]==['--exact','--ignored','--nocapture','intake::position_tests::'+test] and r['exit']==0 and r['settings']=={'GLASS_SCROLLBACK':'0'},'characterization actual command')
  need(r['binary_sha256']==identity['sha256'] and r['test_source_sha256']==sha(D/(arm+'-crates_term_src_intake_position_tests.rs')),'characterization binary and test-source binding')
  need('test result: ok. 1 passed; 0 failed;' in (D/r['log']).read_text(),'characterization really executed')
 # Standard helper does not hash the diagnostics file: bind its build copy
 # explicitly and prove the entire shipping runtime remained the control.
 for arm in ['control','control-v5']:
  for path,digest in builds[arm]['source_sha256'].items():need(sha(ROOT/path)==digest,'control runtime binding '+arm+path)
 need((D/'control-v5-crates_term_src_intake_position_tests.rs').read_text()==(D/'original-crates_term_src_intake_position_tests.rs').read_text()+'\n'+(D/'new-tests.rs').read_text(),'control-v5 diagnostic source exact')
 # Candidate differs from physical guarded arm in exactly one runtime source.
 for p,digest in builds['physical']['source_sha256'].items():
  if p!='crates/alacritty-terminal/src/grid/origin.rs':need(digest==builds['candidate-v4']['source_sha256'][p],'single intervention '+p)
 need(builds['physical']['source_sha256']['crates/alacritty-terminal/src/grid/origin.rs']==sha(ROOT/'bench/results/2026-11-03-origin-map/candidate-v4-crates_alacritty-terminal_src_grid_origin.rs'),'physical origin source')
 for p,digest in builds['candidate-v4']['source_sha256'].items():
  snapshot=D/('candidate-v4-'+p.replace('/','_'))
  need(sha(snapshot if snapshot.exists() else ROOT/p)==digest,'candidate source binding '+p)
 for p,digest in builds['final']['source_sha256'].items():need(sha(ROOT/p)==digest,'final build current source '+p)
 ghost=(D/'control-v5-ghost.log').read_text();need('test result: ok. 1 passed; 0 failed;' in ghost,'ghost characterization executed')
 found=re.findall(r'ghost-case alt=(false|true) fast=(false|true) text=(\[[^\n]*\]) own=(false|true) unrelated=(false|true) pictures=(\[[^\n]*\]) base=(\d+) history=(\d+)',ghost)
 need(len(found)==4 and {(r[0],r[1]) for r in found}==set(itertools.product(['false','true'],repeat=2)),'ghost four configurations')
 for a,f,txt,own,other,pic,base,hist in found:
  text=ast.literal_eval(txt);need(not any('M' in s for s in text) and any('W' in s for s in text),'ghost actual glyph content')
  need(vector(pic)==([(1,1)] if a=='true' else []) and int(base)==(2 if a=='true' else 0) and int(hist)==0,'ghost shipping geometry')
 identity=(D/'candidate-v4-indistinguishable.log').read_text();need('a_mid=[(1, 0)] b_mid=[(1, 0)] a_final=[(1, 0)] b_final=[(1, 0)] same_text=true same_map=true' in identity and 'test result: ok. 1 passed; 0 failed;' in identity,'indistinguishable-history runtime assertions')
 need('test result: ok. 392 passed; 0 failed; 14 ignored;' in (D/'final-terminal.log').read_text(),'final restored terminal suite')
 need('swept 12800 streams over 64 seeds: no divergence' in (D/'final-sweep.log').read_text() and 'test result: ok. 1 passed; 0 failed;' in (D/'final-sweep.log').read_text(),'final restored sweep')
 return {'schema':'glass.blank-witness-checkpoint/v1','matrices':summary,'unicode_observations':124416,'height_observations':56160,'mixed_observations':20736,'final_tests':392,'streams_per_arm':12800,'runtime_promoted':False,'selected_sha256':state['shipping_sha256']}
if __name__=='__main__':print(json.dumps(check(),indent=2,sort_keys=True))
