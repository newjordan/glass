#!/usr/bin/env python3
"""Read-only replay of inline-ID evidence; no benchmark/build and no championship claim."""
import copy
import difflib
import hashlib
import importlib.util
import json
from pathlib import Path

D = Path(__file__).resolve().parent
ROOT = D.parents[2]


def need(ok, why):
    if not ok:
        raise ValueError(why)


def unique(pairs):
    result = {}
    for key, value in pairs:
        need(key not in result, 'duplicate JSON key')
        result[key] = value
    return result


def load(path):
    return json.loads(path.read_text(), object_pairs_hook=unique)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def module(path):
    spec = importlib.util.spec_from_file_location('inline_verify_' + path.stem, path)
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value


def corruption_checks(analyzer, raw):
    # Decoded-metadata sensitivity, not a bypass of the frozen byte manifest.
    changes = [lambda r: r['sessions'].pop(),
               lambda r: r['sessions'].append(copy.deepcopy(r['sessions'][0])),
               lambda r: r['sessions'][0].update(arm='candidate'),
               lambda r: r['sessions'][0].update(exit=101),
               lambda r: r['sessions'][0].update(slot=1),
               lambda r: r['sessions'][0].update(end_ns=0),
               lambda r: r['sessions'][0].update(stdout=''),
               lambda r: r['sessions'][0].update(stderr=''),
               lambda r: r['sessions'][0]['argv'].__setitem__(0, r['binaries']['candidate']['path']),
               lambda r: r['settings'].update(GLASS_BENCH_READ='4096'),
               lambda r: r.update(protocol_sha256='0' * 64),
               lambda r: r['binaries']['candidate'].update(sha256='0' * 64)]
    for index, change in enumerate(changes):
        value = copy.deepcopy(raw)
        change(value)
        try:
            analyzer.analyze(value)
        except (ValueError, KeyError, TypeError, IndexError):
            continue
        raise ValueError('corruption accepted: ' + str(index))
    try:
        json.loads('{"sessions":[],"sessions":[]}', object_pairs_hook=analyzer.unique)
    except ValueError:
        pass
    else:
        raise ValueError('duplicate JSON key accepted')
    return len(changes) + 1


def verify():
    for name, digest in load(D / 'evidence-sha256.json')['sha256'].items():
        need(sha(ROOT / name) == digest, 'evidence changed: ' + name)
    state = load(D / 'starting-state.json')
    need(sha(ROOT / 'target/release/glass') == state['selected_sha256'], 'selected executable changed')
    for name, digest in state['sources'].items():
        need(sha(ROOT / name) == digest, 'runtime source not restored: ' + name)
        need(sha(D / ('original-' + name.replace('/', '_'))) == digest, 'original source not bound')
    build = module(D / 'build.py')
    binaries = load(D / 'binaries.json')
    patches = {}
    changed = set()
    for arm in ['control', 'candidate']:
        p = D / ('build-' + arm)
        identity = load(p / 'identity.json')
        rows = [json.loads(line) for line in (p / 'cargo.jsonl').read_text().splitlines()]
        build.select(rows)
        need(identity['command'] == ['cargo', 'test', '--release', '-p', 'glass-term', '--locked', '--no-run', '--message-format=json'], 'build command')
        need(set(identity['source_sha256']) == set(build.INPUTS), 'build inputs')
        need(binaries[arm] == {'path': identity['executable'], 'sha256': identity['sha256']}, 'binary receipt not bound')
        need(sha(Path(identity['executable'])) == identity['sha256'], 'retained measured executable changed')
        for name, digest in identity['source_sha256'].items():
            snap = D / (arm + '-' + name.replace('/', '_'))
            need(sha(snap) == digest, 'build source not bound: ' + name)
            if arm == 'candidate':
                control = D / ('control-' + name.replace('/', '_'))
                if snap.read_bytes() != control.read_bytes():
                    changed.add(name)
                patches[name] = ''.join(difflib.unified_diff(control.read_text().splitlines(True), snap.read_text().splitlines(True), fromfile='a/' + name, tofile='b/' + name))
        checks = load(D / (arm + '-checks.json'))
        need(len(checks) == 3, 'terminal check count')
        previous = -1
        for label, record in zip(['edge', 'suite', 'sweep'], checks):
            args = {'edge': ['--exact', 'speed::unicode_row_edges_preserve_pending_wrap', '--nocapture'],
                    'suite': [], 'sweep': ['--ignored', '--exact', 'speed::plain_runs_match_the_parser_over_seeds', '--nocapture']}[label]
            settings = dict(GLASS_SWEEP_SEEDS='64', GLASS_SWEEP_ROUNDS='200', GLASS_SWEEP_FROM='1') if label == 'sweep' else {}
            log = D / f'{arm}-{label}.log'
            need(record['label'] == label and record['argv'] == [identity['executable']] + args and record['settings'] == settings, 'terminal check invocation')
            need(record['binary_sha256'] == identity['sha256'] and record['log_sha256'] == sha(log), 'terminal log identity')
            need(type(record['start_ns']) is int and type(record['end_ns']) is int and record['start_ns'] >= previous and record['end_ns'] > record['start_ns'], 'check timestamps')
            previous = record['end_ns']
            need(record['exit'] == 0 and (D / f'{arm}-{label}.exit').read_text().strip() == '0', 'correctness command failed')
            text = log.read_text()
            if label == 'suite':
                need('test result: ok. 395 passed; 0 failed; 14 ignored; 0 measured; 0 filtered out;' in text, 'full suite scope')
            else:
                need('test result: ok. 1 passed; 0 failed;' in text, 'exact test did not run')
                if label == 'edge':
                    need('test speed::unicode_row_edges_preserve_pending_wrap ... ok' in text, 'wrong edge test')
                else:
                    need('swept 12800 streams over 64 seeds: no divergence' in text, 'differential census')
        need((D / f'{arm}-library.exit').read_text().strip() == '0', 'library command failed')
        text = (D / f'{arm}-library.log').read_text()
        for count in [140 if arm == 'candidate' else 139, 45, 1]:
            need(f'test result: ok. {count} passed; 0 failed; 0 ignored; 0 measured; 0 filtered out;' in text, 'library/reference/doctest scope')
        need('inline-layout bytes=24 align=8' in text, 'layout gate')
        cell = (D / (arm + '-crates_alacritty-terminal_src_term_cell.rs')).read_text()
        need((D / 'common-tests.rs').read_text() in cell, 'common logical tests absent')
    need(changed == {'crates/alacritty-terminal/src/term/cell.rs'}, 'unrelated arm difference')
    need(''.join(patches[name] for name in sorted(patches)) == (D / 'candidate.patch').read_text(), 'candidate patch')
    candidate = (D / 'candidate-crates_alacritty-terminal_src_term_cell.rs').read_text()
    need('unsafe' not in candidate and 'increment_strong_count' not in candidate and 'from_raw' not in candidate, 'unsafe storage')
    need('if offset < 112 { Some(offset as u16 + 1) } else { None }' in candidate, 'unchecked ID narrowing')
    need((D / 'candidate-debug-invariant.exit').read_text().strip() == '0', 'debug invariant command')
    need('test term::cell::tests::inline_id_storage_and_scalar_mapping ... ok' in (D / 'candidate-debug-invariant.log').read_text(), 'debug scalar gate')
    analyzer = module(D / 'analyze.py')
    raw = analyzer.load(D / 'raw.json')
    actual = analyzer.analyze(raw)
    need(actual == load(D / 'analysis.json'), 'stored analysis mismatch')
    rejected = corruption_checks(analyzer, raw)
    need((D / 'run.exit').read_text().strip() == '0', 'runner failed')
    codegen = module(D / 'codegen.py').check()
    need(codegen == load(D / 'codegen.json'), 'codegen changed')
    prior = module(ROOT / 'bench/replay-evidence-index.py').validate(ROOT, load(D / 'prior-frozen-index.json'))
    return {'schema': 'glass.inline-mark-id-checkpoint/v1', 'status': 'reported',
            'pairs': actual['blocks'], 'sessions': actual['sessions'],
            'engine_screen_cleared': actual['engine_screen_cleared'],
            'cpu_ratios': {k: v['median_cpu_ratio'] for k, v in actual['summary'].items()},
            'point_regression_guards_failed': actual['point_regression_guards_failed'],
            'library_tests': {'control': 139, 'candidate': 140}, 'reference_fixtures_per_arm': 45, 'doctests_per_arm': 1,
            'cell_bytes_per_arm': 24, 'correctness_tests_per_arm': 395, 'ignored_per_arm': 14,
            'differential_streams_per_arm': 12800, 'rejected_metadata_corruptions': rejected,
            'runtime_candidate_restored': True, 'selected_executable_unchanged': True,
            'prior_references': prior['file_references'], 'prior_versions': prior['unique_source_versions'],
            'note': 'Fixed local engine screen and historical byte replay; not timing causality, fresh Rust tests, PTY/Ghostty superiority, resource measurement, API compatibility or championship acceptance.'}


if __name__ == '__main__':
    print(json.dumps(verify(), indent=2, sort_keys=True))
