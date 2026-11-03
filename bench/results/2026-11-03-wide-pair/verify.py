#!/usr/bin/env python3
"""Replay exact wide-pair screen; an exited runner is not a passing screen."""
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
    spec = importlib.util.spec_from_file_location('wide_verify_' + path.stem, path)
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
    # A rejected screen must not leave the measured runtime candidate installed.
    for name, digest in state['sources'].items():
        need(sha(ROOT / name) == digest, 'runtime source not restored: ' + name)
    build = module(D / 'build.py')
    binaries = load(D / 'binaries.json')
    for arm in ['control', 'candidate']:
        p = D / ('build-' + arm)
        identity = load(p / 'identity.json')
        build.select([json.loads(line) for line in (p / 'cargo.jsonl').read_text().splitlines()])
        need(binaries[arm] == {'path': identity['executable'], 'sha256': identity['sha256']}, 'binary receipt not bound')
        need(sha(Path(identity['executable'])) == identity['sha256'], 'retained measured executable changed')
        for name, digest in identity['source_sha256'].items():
            snap = D / (arm + '-' + name.replace('/', '_'))
            need(sha(snap) == digest, 'build source not bound: ' + name)
            if name != 'crates/term/src/engine.rs':
                need(snap.read_bytes() == (D / ('control-' + name.replace('/', '_'))).read_bytes(), 'unrelated arm difference')
        for label in ['edge', 'suite', 'sweep']:
            need((D / f'{arm}-{label}.exit').read_text().strip() == '0', 'correctness command failed')
            text = (D / f'{arm}-{label}.log').read_text()
            if label == 'suite':
                need('test result: ok. 395 passed; 0 failed; 14 ignored; 0 measured; 0 filtered out;' in text, 'full suite scope')
            else:
                need('test result: ok. 1 passed; 0 failed;' in text, 'exact test did not run')
                if label == 'edge':
                    need('test speed::unicode_row_edges_preserve_pending_wrap ... ok' in text, 'wrong edge test')
                else:
                    need('swept 12800 streams over 64 seeds: no divergence' in text, 'differential census')
    old = (D / 'control-crates_term_src_engine.rs').read_text()
    new = (D / 'candidate-crates_term_src_engine.rs').read_text()
    patch = ''.join(difflib.unified_diff(old.splitlines(True), new.splitlines(True),
                                       fromfile='a/crates/term/src/engine.rs', tofile='b/crates/term/src/engine.rs'))
    need(patch == (D / 'candidate.patch').read_text(), 'runtime patch changed')
    need(patch.count('@@') == 2 and 'Replace the pair together.' in patch, 'runtime edit scope')
    analyzer = module(D / 'analyze.py')
    raw = analyzer.load(D / 'raw.json')
    actual = analyzer.analyze(raw)
    need(actual == load(D / 'analysis.json'), 'stored analysis mismatch')
    need(actual['engine_screen_cleared'] is False, 'screen survived; restoration policy needs separate decision')
    rejected = corruption_checks(analyzer, raw)
    need((D / 'run.exit').read_text().strip() == '0', 'runner failed')
    codegen = module(D / 'codegen.py').check()
    need(codegen == load(D / 'codegen.json'), 'codegen changed')
    need(codegen['control']['print_utf8']['normalized_sha256'] != codegen['candidate']['print_utf8']['normalized_sha256'], 'protocol codegen stop violated')
    prior = module(ROOT / 'bench/replay-evidence-index.py').validate(ROOT, load(D / 'prior-frozen-index.json'))
    return {'schema': 'glass.wide-pair-checkpoint/v1', 'status': 'reported',
            'pairs': actual['blocks'], 'sessions': actual['sessions'],
            'engine_screen_cleared': actual['engine_screen_cleared'],
            'cpu_ratios': {k: v['median_cpu_ratio'] for k, v in actual['summary'].items()},
            'point_regression_guards_failed': actual['point_regression_guards_failed'],
            'correctness_tests_per_arm': 395, 'ignored_per_arm': 14,
            'differential_streams_per_arm': 12800, 'rejected_metadata_corruptions': rejected,
            'print_utf8_instructions': {a: codegen[a]['print_utf8']['instructions'] for a in ['control', 'candidate']},
            'runtime_candidate_restored': True, 'selected_executable_unchanged': True,
            'prior_references': prior['file_references'], 'prior_versions': prior['unique_source_versions'],
            'note': 'Fixed engine screen and historical byte replay; not timing causality, PTY comparison, campaign acceptance or a fresh Rust-suite run.'}


if __name__ == '__main__':
    print(json.dumps(verify(), indent=2, sort_keys=True))
