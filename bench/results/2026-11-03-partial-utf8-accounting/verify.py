#!/usr/bin/env python3
"""Read-only byte/evidence replay. Does not execute tests or establish championship fitness."""
import hashlib
import importlib.util
import json
import lzma
from pathlib import Path

D = Path(__file__).resolve().parent
ROOT = D.parents[2]


def need(ok, why):
    if not ok:
        raise ValueError(why)


def unique(pairs):
    result = {}
    for key, value in pairs:
        need(key not in result, 'duplicate JSON key: ' + key)
        result[key] = value
    return result


def load(path):
    return json.loads(path.read_text(), object_pairs_hook=unique)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def module(path):
    spec = importlib.util.spec_from_file_location('partial_utf8_' + path.stem, path)
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value


def check_records(records, identities, log_text):
    need(isinstance(records, list), 'gate list')
    labels = ['parser', 'engine', 'suite', 'sweep']
    expected_keys = [(a, l) for a in ['control', 'candidate'] for l in labels]
    expected_keys += [('candidate', l) for l in ['library', 'parser-full', 'parser-no-default']]
    need([(r['arm'], r['label']) for r in records] == expected_keys, 'gate order/scope')
    previous = -1
    for r in records:
        arm, label = r['arm'], r['label']
        identity = identities[arm]
        exe = identity['executable']
        argv = {
            'parser': ['cargo', 'test', '--release', '--locked', '-p', 'vte', 'partial_utf8_', '--', '--nocapture', '--test-threads=1'],
            'engine': [exe, '--exact', 'engine::tests::partial_utf8_chunks_match_direct_term_input', '--nocapture'],
            'suite': [exe] + (['--skip', 'partial_utf8_chunks_match_direct_term_input'] if arm == 'control' else []),
            'sweep': [exe, '--ignored', '--exact', 'speed::plain_runs_match_the_parser_over_seeds', '--nocapture'],
            'library': ['cargo', 'test', '--release', '--locked', '-p', 'glass-alacritty-terminal'],
            'parser-full': ['cargo', 'test', '--release', '--locked', '-p', 'vte'],
            'parser-no-default': ['cargo', 'test', '--release', '--locked', '-p', 'vte', '--no-default-features'],
        }[label]
        settings = dict(GLASS_SWEEP_SEEDS='64', GLASS_SWEEP_ROUNDS='200', GLASS_SWEEP_FROM='1') if label == 'sweep' else {}
        expected = 101 if arm == 'control' and label in ['parser', 'engine'] else 0
        need(r['argv'] == argv and r['settings'] == settings, 'wrong gate command/settings')
        need(type(r['exit']) is int and r['exit'] == expected and r['expected_exit'] == expected, 'wrong gate exit')
        need(r['binary_sha256'] == identity['sha256'] and r['source_sha256'] == identity['source_sha256'], 'wrong gate provenance')
        need(type(r['start_ns']) is int and type(r['end_ns']) is int and r['start_ns'] >= 0 and r['start_ns'] >= previous and r['end_ns'] > r['start_ns'], 'gate timestamps')
        previous = r['end_ns']
        text = log_text[(arm, label)]
        need(hashlib.sha256(text.encode()).hexdigest() == r['log_sha256'], 'gate log digest')
        if label == 'parser':
            need(f'partial-utf8 literal matrix cases=2478 failures={48 if arm == "control" else 0}' in text, 'parser matrix census')
            need(f'partial-utf8 termination matrix cases=21 failures={2 if arm == "control" else 0}' in text, 'termination census')
            need(('test result: FAILED. 2 passed; 3 failed;' if arm == 'control' else 'test result: ok. 5 passed; 0 failed;') in text, 'literal parser tests')
        elif label == 'engine':
            need(f'partial-utf8 direct-Term matrix cases=3816 failures={72 if arm == "control" else 0}' in text, 'engine matrix census')
            need(('test result: FAILED. 0 passed; 1 failed;' if arm == 'control' else 'test result: ok. 1 passed; 0 failed;') in text, 'literal engine test')
        elif label == 'suite':
            need(('test result: ok. 395 passed; 0 failed; 14 ignored; 0 measured; 1 filtered out;' if arm == 'control' else 'test result: ok. 396 passed; 0 failed; 14 ignored; 0 measured; 0 filtered out;') in text, 'terminal suite census')
        elif label == 'sweep':
            need('swept 12800 streams over 64 seeds: no divergence' in text and 'test result: ok. 1 passed; 0 failed;' in text, 'differential sweep census')
        elif label == 'library':
            for n in [138, 45, 1]:
                need(f'test result: ok. {n} passed; 0 failed; 0 ignored; 0 measured; 0 filtered out;' in text, 'library census')
        elif label == 'parser-full':
            need('test result: ok. 34 passed; 0 failed;' in text, 'full parser census')
        elif label == 'parser-no-default':
            need('test result: ok. 37 passed; 0 failed;' in text and 'test result: ok. 1 passed; 0 failed;' in text, 'no-default parser census')
    return True


def verify():
    manifest = load(D / 'evidence-sha256.json')
    need(manifest['schema'] == 'glass.research-evidence/v1', 'manifest schema')
    for name, digest in manifest['sha256'].items():
        need(sha(ROOT / name) == digest, 'evidence changed: ' + name)
    need((D / 'final-run.exit').read_text().strip() == '0', 'runner failed')
    state = load(D / 'starting-state.json')
    need(sha(ROOT / 'target/release/glass') == state['selected_sha256'], 'selected executable changed')
    control = (D / 'control-lib.rs').read_text()
    candidate = (D / 'candidate-lib.rs').read_text()
    old = '                    return valid_bytes - old_bytes;'
    new = '''                    // Only the first scalar was emitted. A valid prefix can
                    // also contain ASCII before the next partial/invalid
                    // scalar; leave those bytes to the main dispatch loop.
                    return c.len_utf8() - old_bytes;'''
    need(candidate.count(new) == 1 and candidate.replace(new, old) == control, 'runtime arm difference')
    start = control.index('    /// Literal valid text and explicit control-sequence dispatch expectations.')
    end = control.index('    #[test]\n    fn partial_utf8()', start)
    need(control[:start] + control[end:] == (D / 'original-lib.rs').read_text(), 'unrelated parser runtime change')
    engine = (D / 'candidate-engine.rs').read_text()
    start = engine.index('    /// A direct upstream Term::input oracle')
    end = engine.index('    /// Explicit template expectations', start)
    original_engine = ROOT / 'bench/results/2026-11-03-fused-mark-reuse/original-crates_term_src_engine.rs'
    need(engine[:start] + engine[end:] == original_engine.read_text(), 'unrelated engine runtime change')
    need((ROOT / 'crates/term/src/engine.rs').read_text() == engine, 'installed engine changed')
    need((ROOT / 'crates/vte/src/lib.rs').read_text() == candidate, 'candidate not installed')
    need(sha(ROOT / 'crates/alacritty-terminal/src/term/cell.rs') == state['sources']['crates/alacritty-terminal/src/term/cell.rs'], 'shelved cell experiment remains installed')
    builder = module(ROOT / 'bench/build-engine-arm.py')
    identities = {}
    for arm in ['control', 'candidate']:
        receipt = D / ('final-build-' + arm)
        identity = load(receipt / 'identity.json')
        rows = [json.loads(line, object_pairs_hook=unique) for line in (receipt / 'cargo.jsonl').read_text().splitlines()]
        builder.select(rows)
        need(identity['command'] == ['cargo', 'test', '--release', '-p', 'glass-term', '--locked', '--no-run', '--message-format=json'], 'build command')
        need(set(identity['source_sha256']) == set(builder.INPUTS), 'build inputs')
        for name, digest in identity['source_sha256'].items():
            need(sha(D / ('final-' + arm + '-' + name.replace('/', '_'))) == digest, 'build source snapshot')
        data = lzma.decompress((D / ('final-' + arm + '-test-elf.xz')).read_bytes())
        need(data.startswith(b'\x7fELF') and hashlib.sha256(data).hexdigest() == identity['sha256'], 'retained test ELF changed')
        need(identity['source_sha256']['crates/vte/src/lib.rs'] == sha(D / (arm + '-lib.rs')), 'parser source identity')
        need(identity['source_sha256']['crates/term/src/engine.rs'] == sha(D / 'candidate-engine.rs'), 'engine source identity')
        identities[arm] = identity
    for name in builder.INPUTS:
        if name != 'crates/vte/src/lib.rs':
            need(identities['control']['source_sha256'][name] == identities['candidate']['source_sha256'][name], 'unrelated build arm difference')
    records = load(D / 'final-gates.json')
    logs = {(r['arm'], r['label']): (D / f'final-{r["arm"]}-{r["label"]}.log').read_text() for r in records}
    check_records(records, identities, logs)
    replay = module(ROOT / 'bench/replay-evidence-index.py').validate(ROOT, load(D / 'prior-frozen-index.json'))
    return dict(schema='glass.partial-utf8-accounting-checkpoint/v1', status='reported',
                parser_cases=2478, parser_control_failures=48, parser_candidate_failures=0,
                termination_cases=21, termination_control_failures=2, termination_candidate_failures=0,
                engine_cases=3816, engine_control_failures=72, engine_candidate_failures=0,
                candidate_terminal_passed=396, candidate_terminal_ignored=14,
                differential_streams_per_arm=12800, candidate_library_passed=138,
                reference_fixtures=45, library_doctests=1, parser_passed=34, parser_no_default_passed=37,
                source_bound_fresh_builds=2, retained_elf_archives=2,
                prior_references=replay['file_references'], prior_versions=replay['unique_source_versions'],
                selected_executable_unchanged=True, candidate_source_installed=True,
                note='Recorded correctness and byte-integrity replay only. Not fresh test execution, performance, PTY/Ghostty comparison or championship acceptance.')


if __name__ == '__main__':
    print(json.dumps(verify(), indent=2, sort_keys=True))
