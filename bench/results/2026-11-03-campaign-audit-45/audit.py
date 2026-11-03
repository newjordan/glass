#!/usr/bin/env python3
"""Read-only iteration45 audit. Stored observations are not fresh benchmark wins."""
import ast
import copy
import hashlib
import importlib.util
import json
import math
from pathlib import Path
import re
import statistics
from unittest import mock

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
BASE = ROOT / 'bench/results'
STEMS = ['local-mark-lane', 'pen-dispatch', 'exact-corpus', 'pass-samples',
         'scroll-authority', 'movement-authority', 'height-snapshot', 'origin-map',
         'blank-witness', 'persistent-witness', 'scroll-witness', 'split-witness',
         'source-seams', 'cover-transport']


def need(ok, message):
    if not ok:
        raise ValueError(message)


def unique(pairs):
    value = {}
    for key, item in pairs:
        need(key not in value, 'duplicate JSON key: ' + key)
        value[key] = item
    return value


def load(path):
    return json.loads(Path(path).read_text(), object_pairs_hook=unique)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def module(path):
    path = Path(path)
    spec = importlib.util.spec_from_file_location('audit45_' + path.parent.name.replace('-', '_') + path.stem.replace('-', '_'), path)
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value


def directory(stem):
    return BASE / ('2026-11-03-' + stem)


def suite(path):
    rows = re.findall(r'test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored; \d+ measured; (\d+) filtered out;', Path(path).read_text())
    need(len(rows) == 1, 'ambiguous/missing test result: ' + str(path))
    status, passed, failed, ignored, filtered = rows[0]
    return dict(status=status, passed=int(passed), failed=int(failed), ignored=int(ignored), filtered=int(filtered))


def stats(ratios):
    need(bool(ratios) and all(type(x) in (int, float) and math.isfinite(x) and x > 0 for x in ratios), 'bad ratio')
    w, l = sum(x > 1 for x in ratios), sum(x < 1 for x in ratios)
    n = w + l
    p = min(1., 2 * sum(math.comb(n, k) for k in range(min(w, l) + 1)) / 2 ** n)
    med = statistics.median(ratios)
    return dict(paired_median=med, wins=w, losses=l, sign_p=p,
                own_gain_to_observed_parity_percent=max(0., 100 * (1 / med - 1)))


def target():
    p = directory('role-partition') / 'shipping-vs-ghostty'
    replay = module(ROOT / 'bench/replay-terminal-pairs.py').validate(p, verify_binaries=True)
    saved = load(p / 'terminal-summary.json')
    result = {}
    for name in saved['comparisons']['ghostty']:
        ratios = [load(p / f'terminal/tput-glass-{i}.json')['results'][name]['mb_s'] /
                  load(p / f'terminal/tput-ghostty-{i}.json')['results'][name]['mb_s'] for i in range(1, 31)]
        result[name] = stats(ratios)
        need(result[name]['paired_median'] == saved['comparisons']['ghostty'][name]['median_ratio'], 'paired ratio mismatch')
    running = 0.
    for i, name in enumerate(sorted(result, key=lambda k: (result[k]['sign_p'], k))):
        running = max(running, min(1., (len(result) - i) * result[name]['sign_p']))
        result[name]['holm_p'] = running
        result[name]['corrected_positive_lead'] = result[name]['paired_median'] > 1 and running < .05
    need(sum(v['corrected_positive_lead'] for v in result.values()) == 3, 'unexpected competitive score')
    return {'rounds': 30, 'sessions': 60, 'rows': result, 'binaries': saved['binaries'],
            'raw_replay': replay, 'scope': 'Historical selected binary only; not latest runtime sources, latency, memory, platforms or championship.'}


def negative_results():
    out = {}
    for stem in STEMS[:4]:
        p = directory(stem)
        a = module(p / 'analyze.py')
        actual = a.analyze(a.load(p / 'raw.json'))
        need(actual == load(p / 'analysis.json'), 'analysis replay changed: ' + stem)
        out[stem] = actual
    need(out['local-mark-lane']['engine_screen_cleared'] is False, 'mark promotion')
    need(out['pen-dispatch']['engine_screen_cleared'] is False, 'pen promotion')
    p = directory('pen-dispatch')
    mutation = load(p / 'mutation-result.json')
    need(mutation['oracle_exit'] == 101 and mutation['sweep_exit'] == 0 and mutation['differential_streams'] == 12800, 'shared oracle blindspot')
    out['shared_handler_mutation'] = mutation
    p = directory('scroll-authority')
    observed = module(p / 'verify.py').measured()
    need(observed['candidate_resize_mismatches'] == 76 and observed['control_resize_mismatches'] == 0, 'height authority negative')
    out['scroll_authority'] = observed
    p = directory('movement-authority')
    v = module(p / 'verify.py')
    out['movement_authority'] = {}
    for arm in ['control', 'candidate']:
        rows = load(p / ('bound-' + arm + '-tests.json'))
        logs = {r['label']: (p / r['log']).read_text() for r in rows}
        out['movement_authority'][arm] = v.observations(arm, rows, logs)
    filtered = suite(p / 'bound-candidate-terminal-tests.log')
    need(filtered['filtered'] == 2, 'candidate exclusions hidden')
    out['movement_authority_candidate_suite'] = filtered
    p = directory('height-snapshot')
    v = module(p / 'verify.py')
    out['height_snapshot'] = {}
    cp = load(p / 'checkpoint-post-commit.json')
    for arm in ['control', 'candidate-v5']:
        want = cp['arms'][arm]
        failures = [v.height_observations((p / f'{arm}-height-{cap}.log').read_text(), cap, n)
                    for cap, n in zip(v.HISTORIES, want['height_failures'])]
        mixed = v.mixed_observations((p / f'{arm}-mixed-10000.log').read_text(), want['mixed_failures'])
        out['height_snapshot'][arm] = {'height_failures': failures, 'mixed_failures': mixed}
    need(out['height_snapshot']['candidate-v5']['mixed_failures'] == 32, 'mixed residual hidden')
    p = directory('origin-map')
    v = module(p / 'verify.py')
    for arm, wanted in [('control', v.CONTROL), ('candidate-v3', v.V3), ('candidate-v4', [0] * 6)]:
        v.unicode_arm(arm, wanted)
    # The exact candidate suite path is retained in the original verifier.
    paths = [q for q in p.glob('*.log') if '388 passed; 4 failed; 16 ignored;' in q.read_text()]
    need(len(paths) >= 1, 'origin candidate failures missing')
    out['origin_map_failing_suites'] = {q.name: suite(q) for q in paths}
    p = directory('blank-witness')
    bw = module(p / 'verify.py')
    out['blank_witness'] = {}
    for arm in ['control', 'physical', 'witness']:
        rows = bw.rows(arm + '-runs.json')
        slots, deletion = [], []
        for row in rows:
            text = (p / row['log']).read_text()
            if row['test'] == 'blank_witness_marker_matrix':
                slots.append(bw.slots(text))
            elif row['test'] == 'blank_witness_deleted_line_matrix':
                deletion.append(bw.deletion(text))
        need(len(slots) == len(deletion) == 6, 'blank matrix inventory')
        out['blank_witness'][arm] = {'slot_failures': sum(x['failures'] for x in slots),
                                    'deleted_failures': sum(x['failures'] for x in deletion),
                                    'deleted_eligible': sum(x['eligible'] for x in deletion)}
    p = directory('persistent-witness')
    pv = module(p / 'verify.py')
    slots = [bw.slots((p / f'candidate-final-slots-{cap}.log').read_text()) for cap in [0, 1, 2, 8, 32, 10000]]
    pv.roundtrips((p / 'candidate-final-persistent_witness_roundtrips.log').read_text())
    pv.scroll((p / 'candidate-final-persistent_witness_intervening_scroll_characterization.log').read_text())
    out['persistent_witness'] = {'broader_slot_failures': sum(x['failures'] for x in slots),
                                 'continuous_in_bounds_failures': sum(x['continuous_in_bounds_failures'] for x in slots),
                                 'suite': suite(p / 'candidate-final-terminal.log')}
    need(out['persistent_witness']['broader_slot_failures'] == 2728, 'residual slot failures')
    p = directory('scroll-witness')
    v = module(p / 'verify.py')
    result = {}
    for arm, prefix in [('stale', 'stale-final'), ('transport', 'transport-final'), ('aware', 'aware')]:
        runs = load(p / (prefix + '-runs.json'))
        need(len(runs) == 6, 'scroll matrix inventory')
        values = [v.matrix((p / r['log']).read_text(), arm)[0] for r in runs]
        result[arm] = {'cases': sum(x['cases'] for x in values), 'failures': sum(x['failures'] for x in values)}
    need(result['aware'] == {'cases': 2880, 'failures': 0}, 'aware bound')
    out['scroll_witness'] = {'matrices': result, 'suite': suite(p / 'aware-terminal.log')}
    return out


def source_fixes():
    out = {}
    p = directory('split-witness')
    v = module(p / 'verify.py')
    out['split_fragments'] = {'control': v.shipping((p / 'shipping-control.log').read_text(), 'control'),
                              'production': v.shipping((p / 'production-regressions.log').read_text(), 'production'),
                              'prototype': v.matrix((p / 'local-split.log').read_text())}
    p = directory('source-seams')
    v = module(p / 'verify.py')
    out['source_seams'] = {arm: v.matrix((p / (arm + '.log')).read_text(), arm) for arm in ['control', 'candidate']}
    p = directory('cover-transport')
    v = module(p / 'check-cells.py')
    out['cover_transport'] = {arm: v.validate_records(v.parse((p / (arm + '.log')).read_text()), arm) for arm in ['control', 'candidate']}
    out['production_suite'] = suite(p / 'full-candidate.log')
    need(out['production_suite'] == dict(status='ok', passed=395, failed=0, ignored=14, filtered=0), 'current source full-suite receipt')
    return out


def bind_invocation(run, identity):
    need(run['argv'][0] == identity['executable'], 'measured executable path is not receipt path')
    need(run['binary_sha256'] == identity['sha256'], 'measured binary hash is not receipt hash')


def binding_sensitivity():
    p = directory('cover-transport')
    runs = load(p / 'runs.json')
    ids = {a: load(p / b / 'identity.json') for a, b in [('control', 'build-control-v3'), ('candidate', 'build-candidate')]}
    for row in runs:
        identity = ids['control' if row['label'] in ['control', 'sweep-control'] else 'candidate']
        bind_invocation(row, identity)
        need(sha(identity['executable']) == identity['sha256'], 'retained test executable changed')
    mutant = copy.deepcopy(runs)
    mutant[1]['argv'][0] = ids['control']['executable']
    # Substitute only decoded JSON, after byte-manifest validation, to measure a
    # cross-field semantic blindspot; this is NOT an on-disk integrity bypass.
    old = module(p / 'verify.py')
    original = old.load
    def injected(path):
        return mutant if Path(path) == p / 'runs.json' else original(path)
    with mock.patch.object(old, 'load', side_effect=injected):
        accepted = old.verify()
    need(accepted == load(D / 'prior-checkpoint.json'), 'existing verifier no longer accepts path-only mutation')
    try:
        bind_invocation(mutant[1], ids['candidate'])
    except ValueError:
        rejected = True
    else:
        rejected = False
    need(rejected, 'new semantic binding accepted mutant')
    return {'mutation': 'candidate argv[0] replaced with retained control executable path; claimed hash and logs unchanged',
            'existing_checkpoint_accepts_in_memory_mutation': True, 'new_binding_rejects': True,
            'scope': 'Decoded-metadata semantic sensitivity only. Ordinary on-disk changes remain protected by manifests; no falsified timing or execution alleged.'}


def checker_inventory():
    path = directory('cover-transport') / 'test-check-cells.py'
    tree = ast.parse(path.read_text())
    cls = next(n for n in tree.body if isinstance(n, ast.ClassDef) and n.name == 'Evidence')
    methods = {n.name: n for n in cls.body if isinstance(n, ast.FunctionDef)}
    record = methods['test_record_corruptions']
    mutation_list = next(n.value for n in record.body if isinstance(n, ast.Assign) and any(isinstance(t, ast.Name) and t.id == 'changes' for t in n.targets))
    shapes = next(n.iter for n in ast.walk(methods['test_coordinate_shapes']) if isinstance(n, ast.For))
    counts = {'unittest_methods': sum(k.startswith('test_') for k in methods),
              'record_mutations': len(mutation_list.elts), 'invalid_coordinate_shapes': len(shapes.elts)}
    need(counts == {'unittest_methods': 5, 'record_mutations': 14, 'invalid_coordinate_shapes': 7}, 'checker source inventory changed')
    readme = (directory('cover-transport') / 'README.md').read_text()
    need('18 record corruptions, six invalid coordinate shapes' in readme, 'historical contradiction changed')
    return {'actual_source_inventory': counts, 'historical_readme_claim': {'record_mutations': 18, 'invalid_coordinate_shapes': 6},
            'correction': '14 record mutations and seven invalid shapes. Duplicate JSON key and unknown arm are separate tests. Historical file preserved.'}


def run():
    start = load(D / 'starting-state.json')
    for path, digest in start['sha256'].items():
        need(sha(ROOT / path) == digest, 'pre-existing file changed: ' + path)
    need(sha(ROOT / start['selected_path']) == start['selected_sha256'], 'selected executable changed')
    for path, digest in load(D / 'input-sha256.json')['sha256'].items():
        need(sha(ROOT / path) == digest, 'audit input changed: ' + path)
    index = module(ROOT / 'bench/replay-evidence-index.py')
    latest = index.validate(ROOT, load(directory('cover-transport') / 'final-frozen-index.json'))
    mark = index.validate(ROOT, load(directory('local-mark-lane') / 'final-frozen-index.json'))
    combined = load(directory('cover-transport') / 'final-frozen-index.json')
    combined['manifests'] += load(directory('local-mark-lane') / 'final-frozen-index.json')['manifests']
    union = index.validate(ROOT, combined)
    need(latest['file_references'] == 1819 and latest['unique_source_versions'] == 1790, 'latest scope changed')
    need(mark['file_references'] == 136, 'mark scope changed')
    claims = load(D / 'claims.json')
    need([c['iteration'] for c in claims] == list(range(31, 45)), 'claim inventory')
    for claim, stem in zip(claims, STEMS):
        need(ROOT / claim['directory'] == directory(stem), 'claim source scope')
        load(ROOT / claim['checkpoint'])
        need(claim['competitive_acceptance'] is False, 'unbound acceptance')
    return {'schema': 'glass.campaign-audit45/v1', 'status': 'reported', 'preserved_paths': len(start['sha256']),
            'claims': claims, 'target': target(), 'negative_results': negative_results(), 'source_fixes': source_fixes(),
            'frozen_scopes': {'latest': latest, 'iteration31': mark, 'combined': union},
            'checker_correction': checker_inventory(), 'provenance_sensitivity': binding_sensitivity(),
            'runtime_promotion': False, 'championship_established': False,
            'limitations': ['No fresh benchmark, build, deploy or submission.',
                            'Stored suite counts are historical executions, not newly executed Rust tests.',
                            'Hash consistency is not authenticity or timing accuracy.',
                            'Parity reciprocals are observed point gaps, not superiority margins.',
                            'Within-series Holm correction does not correct campaign-wide adaptive search or establish independent serial signs.',
                            'Selected executable is unchanged; source fixes have not been competitively measured in that executable.',
                            'No acceptance command is bound. Startup, resources, displayed key/frame latency and supported-platform scope remain unresolved.']}


if __name__ == '__main__':
    print(json.dumps(run(), indent=2, sort_keys=True))
