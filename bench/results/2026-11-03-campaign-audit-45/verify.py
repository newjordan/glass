#!/usr/bin/env python3
"""Exact saved audit replay; not a new Rust suite, timing or acceptance gate."""
import hashlib
import importlib.util
import json
from pathlib import Path

D = Path(__file__).resolve().parent
ROOT = D.parents[2]


def load(path):
    return json.loads(path.read_text())


def module(path):
    spec = importlib.util.spec_from_file_location('audit45_checkpoint_' + path.stem, path)
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value


def verify():
    manifest = load(D / 'evidence-sha256.json')
    for path, expected in manifest['sha256'].items():
        actual = hashlib.sha256((ROOT / path).read_bytes()).hexdigest()
        if actual != expected:
            raise ValueError('audit evidence changed: ' + path)
    if (D / 'audit.exit').read_text().strip() != '0':
        raise ValueError('saved audit did not exit zero')
    if (D / 'prior-checkpoint.exit').read_text().strip() != '0':
        raise ValueError('prior checkpoint did not exit zero')
    actual = module(D / 'audit.py').run()
    if actual != load(D / 'audit.json'):
        raise ValueError('audit output differs from saved receipt')
    replay = module(ROOT / 'bench/replay-evidence-index.py').validate(ROOT, load(D / 'final-frozen-index.json'))
    tests = (D / 'existing-index-tests.log').read_text()
    if 'Ran 6 tests' not in tests or not tests.rstrip().endswith('OK'):
        raise ValueError('existing index test receipt failed')
    return {'schema': 'glass.audit45-checkpoint/v1', 'status': 'reported',
            'preserved_paths': actual['preserved_paths'], 'claims': len(actual['claims']),
            'historical_combined_references': actual['frozen_scopes']['combined']['file_references'],
            'historical_combined_versions': actual['frozen_scopes']['combined']['unique_source_versions'],
            'final_frozen_replay': replay,
            'checker_source_counts': actual['checker_correction']['actual_source_inventory'],
            'path_binding_mutation_rejected_by_new_check': actual['provenance_sensitivity']['new_binding_rejects'],
            'selected_build_corrected_throughput_leads': sum(v['corrected_positive_lead'] for v in actual['target']['rows'].values()),
            'championship_established': False,
            'note': 'Recomputed stored observations and exact bytes, not new benchmark or Rust suite execution.'}


if __name__ == '__main__':
    print(json.dumps(verify(), indent=2, sort_keys=True))
