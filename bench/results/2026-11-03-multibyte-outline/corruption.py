#!/usr/bin/env python3
"""Exercise read-only paired replay with actual retained-report corruptions."""
import copy
import importlib.util
import json
from pathlib import Path

D = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('decoded', D / 'analyze.py')
a = importlib.util.module_from_spec(spec)
spec.loader.exec_module(a)


def check():
    raw = a.load(D / 'raw.json')
    a.analyze(raw)
    cases = []
    def test(label, mutate):
        report = copy.deepcopy(raw)
        mutate(report)
        try:
            a.analyze(report)
        except (ValueError, KeyError, TypeError, ZeroDivisionError) as exc:
            cases.append(dict(case=label, rejected=True, diagnostic=str(exc)))
        else:
            raise ValueError('accepted corrupt report: ' + label)
    test('missing session', lambda r: r['sessions'].pop())
    test('extra session', lambda r: r['sessions'].append(copy.deepcopy(r['sessions'][-1])))
    test('swapped sessions', lambda r: r['sessions'].__setitem__(slice(0, 2), list(reversed(r['sessions'][:2]))))
    test('wrong arm', lambda r: r['sessions'][0].__setitem__('arm', 'invalid-arm'))
    test('wrong block', lambda r: r['sessions'][0].__setitem__('block', 3))
    test('wrong slot', lambda r: r['sessions'][0].__setitem__('slot', 2))
    test('failed test', lambda r: r['sessions'][0].__setitem__('exit', 1))
    test('boolean exit', lambda r: r['sessions'][0].__setitem__('exit', False))
    test('zero tests', lambda r: r['sessions'][0].__setitem__('stdout', r['sessions'][0]['stdout'].replace('1 passed', '0 passed')))
    test('duplicate census', lambda r: r['sessions'][0].__setitem__('stdout', r['sessions'][0]['stdout'] + r['sessions'][0]['stdout']))
    test('missing workloads', lambda r: r['sessions'][0].__setitem__('stderr', ''))
    test('duplicate workloads', lambda r: r['sessions'][0].__setitem__('stderr', r['sessions'][0]['stderr'] * 2))
    test('zero rate', lambda r: r['sessions'][0].__setitem__('stderr', a.LINE.sub(lambda m: m[0].replace(m[3] + ' MB/cpu-s', '0.0 MB/cpu-s'), r['sessions'][0]['stderr'], count=1)))
    test('different bytes', lambda r: r['sessions'][0].__setitem__('stderr', a.LINE.sub(lambda m: m[0].replace(m[4] + ' bytes', str(int(m[4]) + 1) + ' bytes'), r['sessions'][0]['stderr'], count=1)))
    test('different read size', lambda r: r['sessions'][0].__setitem__('stderr', r['sessions'][0]['stderr'].replace('read 4095', 'read 4096')))
    test('wrong settings', lambda r: r['settings'].__setitem__('GLASS_BENCH_SCALE', '1.0'))
    test('wrong protocol hash', lambda r: r.__setitem__('protocol_sha256', '0' * 64))
    test('wrong binary hash', lambda r: r['binaries']['control'].__setitem__('sha256', '0' * 64))
    test('different launch argv', lambda r: r['sessions'][0]['argv'].append('other-test'))
    test('overlap', lambda r: r['sessions'][1].__setitem__('start_ns', r['sessions'][0]['start_ns']))
    test('empty interval', lambda r: r['sessions'][0].__setitem__('end_ns', r['sessions'][0]['start_ns']))
    test('missing UTC', lambda r: r['sessions'][0].__setitem__('started_utc', ''))
    text = (D / 'raw.json').read_text()
    corrupt = text.replace('"schema":', '"schema": "duplicate", "schema":', 1)
    try:
        json.loads(corrupt, object_pairs_hook=a.unique)
    except ValueError as exc:
        cases.append(dict(case='duplicate JSON key', rejected=True, diagnostic=str(exc)))
    else:
        raise ValueError('accepted duplicate JSON key')
    return dict(schema='glass.multibyte-outline-corruption/v1', rejected=len(cases), cases=cases, limits='Synthetic corruption of real evidence checks replay validation, not benchmark accuracy or source semantics.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
