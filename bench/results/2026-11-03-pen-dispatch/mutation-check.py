#!/usr/bin/env python3
"""Untimed demonstration of common-handler oracle coverage, fail closed."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
D = Path(__file__).resolve().parent
EXE = '/tmp/glass-i32-mutant-test'


def verify():
    build = json.loads((D / 'build-mutant/identity.json').read_text())
    assert build['executable'] == EXE and hashlib.sha256(Path(EXE).read_bytes()).hexdigest() == build['sha256']
    for path, digest in build['source_sha256'].items():
        assert hashlib.sha256((D / ('mutant-' + path.replace('/', '_'))).read_bytes()).hexdigest() == digest
    oracle = (D / 'mutant-oracle.log').read_text()
    sweep = (D / 'mutant-sweep.log').read_text()
    exits = json.loads((D / 'mutation-exits.json').read_text())
    assert exits['oracle'] == 101 and exits['sweep'] == 0
    assert 'pen_dispatch_preserves_template_and_color_boundaries' in oracle
    assert 'assertion `left == right` failed' in oracle and '0 passed; 1 failed;' in oracle
    assert 'swept 12800 streams over 64 seeds: no divergence' in sweep
    assert 'test result: ok. 1 passed; 0 failed;' in sweep
    return dict(schema='glass.pen-oracle-mutation-result/v1', mutant_sha256=build['sha256'], explicit_oracle_rejected=True, differential_sweep_accepted=True, differential_streams=12800, oracle_exit=exits['oracle'], sweep_exit=exits['sweep'], limits='One deliberate common-handler defect, not a benchmark candidate, broad mutation coverage, proof of independence or compatibility guarantee.')


if __name__ == '__main__':
    if '--capture' in sys.argv:
        env = {k: v for k, v in os.environ.items() if not k.startswith('GLASS_')}
        exits = {}
        for label, args in [('oracle', ['engine::tests::pen_dispatch_preserves_template_and_color_boundaries', '--exact', '--nocapture']), ('sweep', ['speed::plain_runs_match_the_parser_over_seeds', '--exact', '--ignored', '--nocapture'])]:
            e = env | (dict(GLASS_SWEEP_SEEDS='64', GLASS_SWEEP_ROUNDS='200') if label == 'sweep' else {})
            with (D / f'mutant-{label}.log').open('xb') as out:
                p = subprocess.run([EXE, *args], env=e, stdout=out, stderr=subprocess.STDOUT, timeout=900)
            exits[label] = p.returncode
        with (D / 'mutation-exits.json').open('x') as f:
            json.dump(exits, f, indent=2)
    print(json.dumps(verify(), indent=2))
