#!/usr/bin/env python3
"""Read-only final source/receipt/archive checkpoint; no performance acceptance."""
import hashlib
import importlib.util
import json
import lzma
from pathlib import Path
import analyze as a
import corruption

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()


def check():
    state = a.load(D/'starting-state.json')
    for path, expected in state['prior_evidence'].items():
        a.need(sha(ROOT/path) == expected, 'changed previous evidence: '+path)
    for path, expected in state['docs'].items():
        a.need(sha(ROOT/path) == expected, 'changed shared docs: '+path)
    speed = 'crates/term/src/speed.rs'
    for path, expected in state['sources'].items():
        if path != speed:
            a.need(sha(ROOT/path) == expected, 'changed runtime source: '+path)
    a.need(sha(D/'original-speed.rs') == state['sources'][speed], 'changed original source')
    selected = state['selected']
    a.need(sha(ROOT/selected['path']) == selected['sha256'], 'changed selected executable')
    a.need('#[cfg(test)]\nmod speed;' in (ROOT/'crates/term/src/main.rs').read_text(), 'diagnostic not test-only')
    identity = a.load(D/'build-final/identity.json')
    binary = a.load(D/'binary.json')
    a.need(binary == a.load(D/'binary-final.json'), 'changed final identity')
    a.need(identity['sha256'] == binary['sha256'] and identity['executable'] == binary['path'], 'identity mismatch')
    for path, expected in identity['source_sha256'].items():
        a.need(sha(ROOT/path) == expected, 'wrong build source')
    receipts = [json.loads(line) for line in (D/'build-final/cargo.jsonl').read_text().splitlines()]
    a.need(any(r.get('reason') == 'build-finished' and r.get('success') for r in receipts), 'missing successful build')
    artifact = [r for r in receipts if r.get('reason') == 'compiler-artifact' and r.get('executable')
                and r['target']['name'] == 'glass' and r['profile']['test']]
    a.need(len(artifact) == 1 and artifact[0]['fresh'] is False, 'stale test artifact')
    a.need('test result: ok. 1 passed; 0 failed;' in (D/'existing-parser.log').read_text(), 'missing final existing parser test')
    a.need('Ran 5 tests' in (D/'python-tests.log').read_text() and '\nOK\n' in (D/'python-tests.log').read_text(), 'Python tests')
    analysis = a.analyze(a.load(D/'raw.json'))
    a.need(analysis == a.load(D/'analysis.json'), 'analysis replay differs')
    cases = corruption.check()
    a.need(cases == a.load(D/'corruption.json') and cases['rejected'] == 26, 'corruption replay differs')
    guards = a.load(D/'guards.json')
    a.need(guards['rejected'] == len(guards['cases']) == 6, 'guard census')
    for g in guards['cases']:
        text = (D/(g['case']+'.guard.log')).read_text()
        a.need(g['exit'] != 0 and g['expected_diagnostic'] in text
               and 'test result: FAILED. 0 passed; 1 failed;' in text, 'guard evidence')
    a.need((D/'must-not-overwrite.txt').read_text() == 'retained sentinel\n', 'clobbered existing output')
    a.need(not (D/'pty-refused.jsonl').exists() and not (D/'partial-refused.jsonl').exists(), 'unsupported mode created output')
    archive = a.load(D/'archive.json')
    for entry in archive['entries']:
        blob = D/entry['path']
        data = lzma.decompress(blob.read_bytes())
        a.need(sha(blob) == entry['xz_sha256'] and len(data) == entry['bytes']
               and hashlib.sha256(data).hexdigest() == entry['sha256'], 'archive mismatch')
    manifest = a.load(D/'evidence-sha256.json')
    for path, expected in manifest.items():
        a.need(sha(ROOT/path) == expected, 'changed frozen artifact: '+path)
    return dict(schema='glass.pass-sample-checkpoint/v1', status='reported',
                sessions=analysis['sessions'], pairs=analysis['pairs'], captured_passes=analysis['captured_passes'],
                different_cpu_wall_minima=analysis['different_minima'],
                observer_cpu_ratios={n:r['median_observer_cpu_ratio'] for n,r in analysis['summary'].items()},
                parser_tests=1, python_tests=5, rejected_corruptions=cases['rejected'], rejected_guard_cases=6,
                unchanged_prior_evidence_files=len(state['prior_evidence']), unchanged_other_rust_sources=len(state['sources'])-1,
                selected_sha256=selected['sha256'], retained_test_source=speed,
                runtime_promotion=False, championship_established=False,
                note='Local source/raw-clock/archive replay only. One existing parser test, not a full suite. No independent audit, speed acceptance or Ghostty comparison.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
