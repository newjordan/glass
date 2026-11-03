#!/usr/bin/env python3
"""Read-only final local checkpoint. This is NOT campaign acceptance."""
import importlib.util
import json
from pathlib import Path

D = Path(__file__).resolve().parent
ROOT = D.parents[2]


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def check():
    audit = module('campaign_audit30', D / 'audit.py')
    index = module('campaign_index30', ROOT / 'bench/replay-evidence-index.py')
    actual = audit.run()
    audit.need(actual == audit.load(D / 'audit-with-sensitivity.json'), 'final audit result drift')
    frozen = index.validate(ROOT, audit.load(D / 'frozen-index.json'))
    return dict(schema='glass.audit30-checkpoint/v1', status='reported',
                runtime_promotion=False, championship_established=False,
                selected_corrected_throughput_leads=actual['selected']['corrected_positive_leads'],
                combined_unpromoted_corrected_throughput_leads=actual['unpromoted_combined']['corrected_positive_leads'],
                engine_screens_rejected=len(actual['engine_experiments']),
                historical_engine_sessions=sum(row['sessions'] for row in actual['engine_experiments'].values()),
                selected_terminal_rounds=actual['selected']['rounds'],
                selected_rounded_pass_sensitivity_leads=actual['selected']['rounded_pass_sensitivity']['conditional_positive_leads'],
                claim_groups=len(actual['active_claim_ledger']),
                unchanged_rust_sources=actual['preserved_rust_files'],
                unchanged_prior_result_report_files=actual['preserved_prior_files'],
                unchanged_shared_docs=actual['preserved_shared_docs'],
                frozen_file_references=frozen['file_references'],
                note='Exact stored-data replay and preservation, not fresh Rust tests, timing, statistical acceptance or worldwide leadership.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2, sort_keys=True))
