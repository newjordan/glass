#!/usr/bin/env python3
"""Replay finite no-op ownership evidence; never infer throughput from it."""
import hashlib
import importlib.util
import json
from pathlib import Path
import re

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
SOURCE = 'crates/alacritty-terminal/src/term/cell.rs'


def need(ok, message):
    if not ok:
        raise ValueError(message)


def unique(pairs):
    value = {}
    for key, item in pairs:
        need(key not in value, 'duplicate JSON key')
        value[key] = item
    return value


def load(path):
    return json.loads(path.read_text(), object_pairs_hook=unique)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def observations(text, arm):
    rows = re.findall(r'extra-noop owners=([0-2]) occupied=(0|9) retained=(true|false) strong=(true|false) weak=(true|false)', text)
    keys = [(int(o), int(n)) for o, n, *_ in rows]
    need(keys == [(o, n) for o in range(3) for n in [0, 9]], 'ownership matrix identity/order')
    failures = 0
    for owner, occupied, retained, strong, weak in rows:
        expected = ('true', 'true', 'true')
        if arm == 'control':
            if owner == '1':
                expected = ('false', 'true', 'false')
            elif owner == '2':
                expected = ('false', 'false', 'true')
        need((retained, strong, weak) == expected, 'ownership observation mismatch')
        failures += retained != 'true'
    status = 'FAILED. 7 passed; 1 failed;' if arm == 'control' else 'ok. 8 passed; 0 failed;'
    need('test result: ' + status in text, 'cell-suite result')
    need('test term::cell::tests::real_extra_updates_still_isolate_shared_and_weak_owners ... ok' in text, 'real mutation gate')
    return {'cases': len(rows), 'ownership_detachments': failures}


def verify():
    manifest = load(D / 'evidence-sha256.json')
    for path, digest in manifest['sha256'].items():
        need(sha(ROOT / path) == digest, 'changed evidence: ' + path)
    for path in [SOURCE, 'crates/alacritty-terminal/CHANGES.md', 'CHANGELOG.md']:
        need((ROOT / path).read_bytes() == (D / ('production-' + path.replace('/', '_'))).read_bytes(), 'production changed: ' + path)
    control = (D / 'control-cell.rs').read_text()
    expected = control.replace('// - single-mark extras share one bounded per-thread cache; mutations remain copy-on-write.\n', '// - single-mark extras share one bounded per-thread cache; mutations remain copy-on-write.\n// - no-op mark updates preserve shared extras instead of triggering copy-on-write.\n', 1)
    expected = expected.replace('        let extra = self.extra.as_mut().unwrap();\n        let _ = Arc::make_mut(extra).zerowidth.try_push(character);', '        let extra = self.extra.as_mut().unwrap();\n        // A full buffer ignores this mark. Check before `make_mut`: cloning\n        // shared attributes (or dissociating Weak owners) cannot change it.\n        if extra.zerowidth.is_full() {\n            return;\n        }\n        let _ = Arc::make_mut(extra).zerowidth.try_push(character);', 1)
    expected = expected.replace('        if let Some(extra) = self.extra.as_mut() {\n            Arc::make_mut(extra).zerowidth = ArrayVec::new();', '        if let Some(extra) = self.extra.as_mut().filter(|extra| !extra.zerowidth.is_empty()) {\n            Arc::make_mut(extra).zerowidth = ArrayVec::new();', 1)
    need(expected == (ROOT / SOURCE).read_text(), 'candidate/control differ beyond two guards and header')
    need((D / 'control.exit').read_text().strip() == '101', 'control did not fail')
    need((D / 'candidate.exit').read_text().strip() == '0', 'candidate did not pass')
    result = {a: observations((D / (a + '.log')).read_text(), a) for a in ['control', 'candidate']}
    need((D / 'terminal-integration.exit').read_text().strip() == '0', 'terminal gate exit')
    need('test result: ok. 395 passed; 0 failed; 14 ignored; 0 measured; 0 filtered out;' in (D / 'terminal-integration.log').read_text(), 'terminal gate result')
    need(sha(ROOT / 'target/release/glass') == load(D / 'starting-state.json')['selected_sha256'], 'selected release changed')
    spec = importlib.util.spec_from_file_location('noop_prior_index', ROOT / 'bench/replay-evidence-index.py')
    replay = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(replay)
    prior = replay.validate(ROOT, load(D / 'prior-frozen-index.json'))
    need(prior['file_references'] == 1980 and prior['unique_source_versions'] == 1886, 'prior frozen scope')
    return {'schema': 'glass.extra-noop-checkpoint/v1', 'status': 'reported', 'ownership_matrices': result,
            'cell_tests': 8, 'terminal_tests': 395, 'terminal_ignored': 14,
            'prior_frozen_references': prior['file_references'], 'prior_frozen_versions': prior['unique_source_versions'],
            'selected_executable_unchanged': True, 'timing_sessions': 0, 'championship_established': False,
            'limits': 'Finite shared/weak/unique ownership cases. No allocation counter, new differential sweep, throughput, memory total or competitive measurement.'}


if __name__ == '__main__':
    print(json.dumps(verify(), indent=2, sort_keys=True))
