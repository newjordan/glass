#!/usr/bin/env python3
"""Synthetic raw-receipt mutations; never mutate original timing evidence."""
import copy
import json
import analyze as a


def check():
    raw = a.load(a.D/'raw.json')
    a.analyze(raw)
    rows = []

    def test(label, mutate):
        altered = copy.deepcopy(raw)
        mutate(altered)
        try:
            a.analyze(altered)
        except (ValueError, KeyError, TypeError, IndexError) as e:
            rows.append(dict(case=label, rejected=True, diagnostic=str(e)))
        else:
            raise ValueError('accepted malformed receipt: '+label)

    test('missing session', lambda r: r['sessions'].pop())
    test('duplicate session', lambda r: r['sessions'].__setitem__(1, copy.deepcopy(r['sessions'][0])))
    test('wrong schema', lambda r: r.__setitem__('schema', 'other'))
    test('changed protocol', lambda r: r.__setitem__('protocol_sha256', '0'*64))
    test('changed runner', lambda r: r.__setitem__('runner_sha256', '0'*64))
    test('changed parser', lambda r: r.__setitem__('analyzer_sha256', '0'*64))
    test('changed source', lambda r: r.__setitem__('source_sha256', '0'*64))
    test('changed binary', lambda r: r['binary'].__setitem__('sha256', '0'*64))
    test('changed settings', lambda r: r['settings'].__setitem__('GLASS_BENCH_READ', '4096'))
    for label, key, value in [
        ('wrong order', 'mode', 'on'), ('false pair', 'pair', True),
        ('failed session', 'exit', 1), ('boolean exit', 'exit', False),
        ('empty interval', 'end_ns', raw['sessions'][0]['begin_ns']),
        ('missing UTC', 'started_utc', ''), ('wrong UTC', 'started_utc', '2000-01-01T00:00:00+00:00'),
        ('changed argv', 'argv', []), ('wrong stdout path', 'stdout', '../outside'),
        ('changed stdout hash', 'stdout_sha256', '0'*64),
        ('changed stderr hash', 'stderr_sha256', '0'*64),
        ('wrong settings', 'settings', {}), ('off with samples', 'samples', 'unexpected.jsonl')]:
        test(label, lambda r, k=key, v=value: r['sessions'][0].__setitem__(k,v))
    test('overlapping sessions', lambda r: r['sessions'][1].__setitem__('begin_ns', r['sessions'][0]['begin_ns']))
    test('changed sample hash', lambda r: r['sessions'][1].__setitem__('samples_sha256', '0'*64))
    test('changed sample path', lambda r: r['sessions'][1].__setitem__('samples', 'other.jsonl'))
    test('missing sample hash', lambda r: r['sessions'][1].pop('samples_sha256'))
    return dict(schema='glass.pass-sample-corruptions/v1', rejected=len(rows), cases=rows,
                limits='Synthetic malformed receipt rejection only; not timing accuracy or independent audit.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
