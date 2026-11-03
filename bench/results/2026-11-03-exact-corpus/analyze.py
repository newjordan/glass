#!/usr/bin/env python3
"""Read-only exact/generated same-ELF corpus replay."""
from datetime import datetime
import hashlib
import json
import lzma
import math
from pathlib import Path
import re
import statistics

D = Path(__file__).resolve().parent

def need(ok, message):
    if not ok:
        raise ValueError(message)

def unique(pairs):
    result = {}
    for k,v in pairs:
        need(k not in result, 'duplicate JSON key')
        result[k] = v
    return result

def load(p):
    return json.loads(Path(p).read_text(),object_pairs_hook=unique)

def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()

def corpus_bytes(directory, name):
    path = D / directory / (name + '.bin')
    if path.exists():
        return path.read_bytes()
    return lzma.decompress(Path(str(path) + '.xz').read_bytes())

def binary_identity(b):
    path = Path(b['path'])
    if path.exists():
        need(sha(path)==b['sha256'], 'live binary changed')
    archived = lzma.decompress((D/'diagnostic-test-elf.xz').read_bytes())
    return hashlib.sha256(archived).hexdigest() == b['sha256']

LINE = re.compile(r'^\s*(\w+):\s+([\d.]+) MB/s\s+([\d.]+) MB/cpu-s\s+\((\d+) bytes, read (\d+)\)',re.M)

def analyze(raw):
    p,b = load(D/'protocol.json'),load(D/'binary.json')
    need(raw['schema']=='glass.exact-corpus-raw/v1','schema')
    need(raw['protocol_sha256']==sha(D/'protocol.json'),'protocol hash')
    need(raw['binary']==b and binary_identity(b),'binary identity')
    settings = dict(GLASS_BENCH_SCALE=str(float(p['scale'])), GLASS_BENCH_ROUNDS=str(p['rounds']),GLASS_BENCH_READ=str(p['read']),GLASS_BENCH_ONLY=','.join(p['workloads']))
    need(raw['settings']==settings,'settings')
    need(set(raw['manifests'])=={'corpus','generated'},'manifest set')
    manifests = {d:load(D/d/'manifest.json') for d in ['corpus','generated']}
    for d,m in manifests.items():
        need(raw['manifests'][d]==sha(D/d/'manifest.json'),'manifest hash')
        need((m['rows'],m['cols'])==(39,154) and set(m['workloads'])==set(p['workloads']),'corpus shape')
        for name,v in m['workloads'].items():
            data = corpus_bytes(d, name)
            need(hashlib.sha256(data).hexdigest()==v['sha256'] and len(data)==v['bytes'],'corpus identity')
    rows = raw['sessions']
    need(len(rows)==p['blocks']*2,'incomplete sessions')
    table,previous = {},-1
    for i,row in enumerate(rows):
        block,slot = divmod(i,2)
        arm = p['orders'][block%len(p['orders'])][slot]
        need((row['block'],row['slot'],row['arm'])==(block,slot,arm),'order')
        need(row['argv']==[b['path'],'--ignored','--exact','--nocapture','speed::speed'],'argv')
        need(row['corpus_env']==(str(D/'corpus') if arm=='exact' else None),'corpus environment')
        need(type(row['start_ns']) is int and type(row['end_ns']) is int and row['start_ns']>=previous and row['end_ns']>row['start_ns'],'overlap/time')
        previous = row['end_ns']
        need(datetime.fromisoformat(row['started_utc']).utcoffset().total_seconds()==0,'UTC')
        census = re.findall(r'^test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;',row['stdout'],re.M)
        need(type(row['exit']) is int and row['exit']==0 and census==[('ok','1','0','0')],'session failure/census')
        matches = LINE.findall(row['stderr'])
        need(len(matches)==6 and {x[0] for x in matches}==set(p['workloads']),'workloads')
        parsed = {}
        for name,wall,cpu,size,read in matches:
            wall,cpu,size,read = float(wall),float(cpu),int(size),int(read)
            need(math.isfinite(wall) and math.isfinite(cpu) and min(wall,cpu)>0,'nonfinite/nonpositive')
            corpus = 'corpus' if arm=='exact' else 'generated'
            need(size==manifests[corpus]['workloads'][name]['bytes'] and read==p['read'],'shape')
            parsed[name] = dict(cpu=cpu,wall=wall)
        table[block,arm] = parsed
    summary = {}
    for name in p['workloads']:
        ratios = [table[i,'exact'][name]['cpu']/table[i,'generated'][name]['cpu'] for i in range(p['blocks'])]
        walls = [table[i,'exact'][name]['wall']/table[i,'generated'][name]['wall'] for i in range(p['blocks'])]
        wins,losses = sum(r>1 for r in ratios),sum(r<1 for r in ratios)
        n = wins+losses
        pv = min(1.,2*sum(math.comb(n,k) for k in range(min(wins,losses)+1))/2**n)
        summary[name] = dict(cpu_ratios=ratios,median_cpu_ratio=statistics.median(ratios),median_wall_ratio=statistics.median(walls),min_cpu_ratio=min(ratios),max_cpu_ratio=max(ratios),wins=wins,losses=losses,sign_p_two_sided=pv)
    running = 0.
    for rank,name in enumerate(sorted(summary,key=lambda n:summary[n]['sign_p_two_sided'])):
        running = max(running,min(1.,(len(summary)-rank)*summary[name]['sign_p_two_sided']))
        summary[name]['holm_p'] = running
    return dict(schema='glass.exact-corpus-analysis/v1',sessions=len(rows),pairs=p['blocks'],summary=summary,runtime_promotion=False,limits=p['limitations'])

if __name__=='__main__':
    print(json.dumps(analyze(load(D/'raw.json')),indent=2))
