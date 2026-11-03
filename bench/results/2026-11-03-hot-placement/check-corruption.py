#!/usr/bin/env python3
"""Read-only checker adversarial cases in temporary copies, not performance tests."""
import copy
import importlib.util
import json
from pathlib import Path
import shutil
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
spec = importlib.util.spec_from_file_location('hot_replay', ROOT/'bench/linux/analyze-hot-placement.py')
r = importlib.util.module_from_spec(spec)
spec.loader.exec_module(r)
source = HERE/'confirmatory'

def fingerprint(root):
    return {str(p.relative_to(root)):r.sha(p) for p in root.rglob('*') if p.is_file()}

def write(path, obj):
    path.write_text(json.dumps(obj, indent=2)+'\n')

before_source = fingerprint(source)
rows = []
for case in ('hash','complete','hot-mask','hot-identity','restore','producer','topology',
             'rate','duplicate-key','source-set','order','actual-order','overlap','non-target-transition'):
    with tempfile.TemporaryDirectory() as tmp:
        root = Path(tmp)/'capture'
        shutil.copytree(source,root)
        manifest = r.load(root/'manifest.json')
        raw = root/'tput-d01-1.json'
        sidecar = raw.with_suffix('.placement.json')
        s = r.load(sidecar)
        if case == 'hash':
            raw.write_text(raw.read_text()+' ')
        elif case == 'complete':
            s['complete'] = False
        elif case == 'hot-mask':
            s['roles_after']['pty-read']['allowed'] = s['original']['pty-read']
        elif case == 'hot-identity':
            s['roles_after']['pty-parse']['start_ticks'] += 1
        elif case == 'restore':
            s['roles_restored']['pty-parse']['allowed'] = s['target']['pty-parse']
        elif case == 'producer':
            s['producer_allowed_after'] = [31]
        elif case == 'topology':
            s['topology']['0']['siblings'] = [0,17]
        elif case == 'rate':
            obj = r.load(raw);obj['results']['ascii']['mb_s'] *= 2;write(raw,obj)
        elif case == 'duplicate-key':
            raw.write_text(raw.read_text().replace('{','{"cols":154,',1))
        elif case == 'source-set':
            del manifest['sha256'][str((ROOT/'bench/tput.py').resolve())]
        elif case == 'order':
            manifest['orders'][0].reverse()
        elif case == 'actual-order':
            other = r.load(root/'tput-auto-1.placement.json')
            s['payload_begin_ns'],s['payload_end_ns'] = other['payload_begin_ns']-2,other['payload_begin_ns']-1
        elif case == 'overlap':
            other = r.load(root/'tput-auto-1.placement.json')
            s['payload_begin_ns'],s['payload_end_ns'] = other['payload_end_ns']-1,other['payload_end_ns']+1
        elif case == 'non-target-transition':
            candidate = next(t for t in s['threads_after'] if t['name'] not in r.ROLES)
            candidate['allowed'] = [31]
        if case != 'hash':
            s['result_sha256'] = r.sha(raw)
            write(sidecar,s)
            manifest['raw_sha256'] = {name:r.sha(root/name) for name in manifest['raw_sha256']}
        write(root/'manifest.json',manifest)
        before = fingerprint(root)
        if case == 'non-target-transition':
            result = r.analyze(root)
            assert any(t['file']==raw.name and t['after']['allowed']==[31] for t in result['non_target_transitions'])
            rows.append(dict(case=case,reported_not_rejected=True,unchanged_files=len(before)))
        else:
            try:
                r.analyze(root)
            except ValueError as error:
                rows.append(dict(case=case,rejected=True,reason=str(error),unchanged_files=len(before)))
            else:
                raise AssertionError(f'accepted corruption: {case}')
        assert fingerprint(root) == before, f'checker mutated {case}'
assert fingerprint(source) == before_source
print(json.dumps(dict(schema='glass.hot-placement-checker-adversarial/v1',cases=rows,
                      canonical_unchanged=True,note='Temporary corruption checks are not timing or authenticity evidence.'),indent=2))
