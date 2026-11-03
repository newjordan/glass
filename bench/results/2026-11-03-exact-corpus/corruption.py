#!/usr/bin/env python3
"""Synthetic malformed copies of actual raw evidence must fail replay."""
import copy
import json
import analyze as a


def check():
    raw = a.load(a.D/'raw.json')
    a.analyze(raw)
    cases = []
    def test(label, mutation):
        changed = copy.deepcopy(raw)
        mutation(changed)
        try:
            a.analyze(changed)
        except (ValueError,KeyError,TypeError,IndexError) as e:
            cases.append(dict(case=label,rejected=True,diagnostic=str(e)))
        else:
            raise ValueError('accepted corruption: '+label)
    test('missing session',lambda r:r['sessions'].pop())
    test('duplicate session',lambda r:r['sessions'].__setitem__(1,copy.deepcopy(r['sessions'][0])))
    test('wrong order',lambda r:r['sessions'][0].__setitem__('arm','exact'))
    test('changed corpus env',lambda r:r['sessions'][1].__setitem__('corpus_env',None))
    test('failed session',lambda r:r['sessions'][0].__setitem__('exit',1))
    test('false test count',lambda r:r['sessions'][0].__setitem__('stdout',r['sessions'][0]['stdout'].replace('1 passed;','2 passed;')))
    test('missing stderr',lambda r:r['sessions'][0].__setitem__('stderr',''))
    test('duplicate workload',lambda r:r['sessions'][0].__setitem__('stderr',r['sessions'][0]['stderr']+r['sessions'][0]['stderr']))
    test('changed shape',lambda r:r['sessions'][0].__setitem__('stderr',r['sessions'][0]['stderr'].replace('25165955 bytes','25165956 bytes')))
    test('changed read',lambda r:r['sessions'][0].__setitem__('stderr',r['sessions'][0]['stderr'].replace('read 4095','read 4096')))
    test('changed setting',lambda r:r['settings'].__setitem__('GLASS_BENCH_SCALE','2.0'))
    test('changed protocol hash',lambda r:r.__setitem__('protocol_sha256','0'*64))
    test('changed manifest hash',lambda r:r['manifests'].__setitem__('corpus','0'*64))
    test('changed binary hash',lambda r:r['binary'].__setitem__('sha256','0'*64))
    test('changed argv',lambda r:r['sessions'][0]['argv'].append('other'))
    test('overlap',lambda r:r['sessions'][1].__setitem__('start_ns',r['sessions'][0]['start_ns']))
    test('empty interval',lambda r:r['sessions'][0].__setitem__('end_ns',r['sessions'][0]['start_ns']))
    test('missing UTC',lambda r:r['sessions'][0].__setitem__('started_utc',''))
    test('different schema',lambda r:r.__setitem__('schema','other'))
    try:
        json.loads('{"schema":1,"schema":2}',object_pairs_hook=a.unique)
    except ValueError as e:
        cases.append(dict(case='duplicate JSON key',rejected=True,diagnostic=str(e)))
    else:
        raise ValueError('accepted duplicate key')
    return dict(schema='glass.exact-corpus-corruptions/v1',rejected=len(cases),cases=cases,limits='Synthetic raw-evidence validation only, not source correctness or timing validity.')

if __name__=='__main__':
    print(json.dumps(check(),indent=2))
