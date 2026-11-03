#!/usr/bin/env python3
"""Read-only evidence receipt replay. Does not execute Rust, timing, or repair files."""
import hashlib
import importlib.util
import json
import lzma
from pathlib import Path
import re

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
M = D / 'measured'
CHANGED = ['crates/term/src/engine.rs', 'crates/alacritty-terminal/src/term/cell.rs', 'crates/alacritty-terminal/src/grid/row.rs']


def module(p):
    spec = importlib.util.spec_from_file_location(p.stem.replace('-', '_'), p)
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


A = module(D / 'analyze.py')
load, need = A.load, A.need
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()


def census():
    names = sorted(str(p.relative_to(ROOT)) for p in (ROOT / 'crates').rglob('*')
                   if p.is_file() and (p.suffix == '.rs' or p.name == 'Cargo.toml'))
    names += ['Cargo.toml', 'Cargo.lock']
    return {p: sha(ROOT / p) for p in names}


def check_records(records, identities, logs, censuses):
    expected = {(arm, label) for arm in ['control', 'candidate'] for label in ['literal', 'redraw', 'suite']}
    expected.add(('candidate', 'library'))
    need(len(records) == 7 and {(r['arm'], r['label']) for r in records} == expected, 'gate key census')
    for r in records:
        arm, label = r['arm'], r['label']
        ident = identities[arm]
        need(r['exit'] == 0 and type(r['start_ns']) is int and type(r['end_ns']) is int and 0 < r['start_ns'] < r['end_ns'], 'gate exit/time')
        need(r['binary_sha256'] == ident['sha256'], 'gate binary binding')
        need(r['source_census_sha256'] == censuses[arm], 'gate source binding')
        text = logs[arm, label]
        need(hashlib.sha256(text.encode()).hexdigest() == r['log_sha256'], 'gate log binding')
        executable = ident['executable']
        if label in ['literal', 'redraw']:
            test = 'engine::tests::' + ('partial_utf8_chunks_match_direct_term_input' if label == 'literal' else 'fused_mark_redraws_match_direct_term_input')
            need(r['argv'] == [executable, '--exact', test, '--nocapture'], 'exact oracle command')
            need('running 1 test' in text and 'test result: ok. 1 passed; 0 failed;' in text and f'test {test} ... ok' in text, 'nonempty oracle')
            count = 'partial-utf8 direct-Term matrix cases=3816 failures=0' if label == 'literal' else 'fused-mark redraw cases=86784 observations=520704 failures=0'
            need(count in text, 'literal oracle census')
        elif label == 'suite':
            need(r['argv'] == [executable], 'suite command')
            passed = 397
            need(f'test result: ok. {passed} passed; 0 failed; 14 ignored; 0 measured; 0 filtered out;' in text, 'terminal census')
        else:
            need(r['argv'] == ['cargo', 'test', '--release', '--locked', '-p', 'glass-alacritty-terminal'], 'library command')
            for passed in [139, 45, 1]:
                need(f'test result: ok. {passed} passed; 0 failed; 0 ignored; 0 measured; 0 filtered out;' in text, 'library census')
    return True


def verify():
    manifest = load(D / 'evidence-manifest.json')
    need(set(manifest) == {'schema', 'files'} and manifest['schema'] == 'glass.fused-mark-evidence/v1', 'manifest schema')
    need(len(manifest['files']) >= 70, 'manifest census')
    for name, digest in manifest['files'].items():
        rel = Path(name)
        need(not rel.is_absolute() and '..' not in rel.parts and rel.as_posix() == name, 'manifest path')
        need(re.fullmatch('[a-f0-9]{64}', digest) is not None and sha(D / rel) == digest, 'artifact binding: ' + name)
    start = load(D / 'starting-state.json')
    restored = load(M / 'restoration.json')
    need(restored == dict(sources_restored=True, selected_unchanged=True), 'restoration receipt')
    need(sha(ROOT / 'target/release/glass') == start['selected_sha256'], 'selected executable changed')
    for name in CHANGED:
        need(sha(ROOT / name) == sha(M / ('original-' + name.replace('/', '_'))), 'live runtime not restored')
    for name, digest in start['sources'].items():
        need(sha(ROOT / name) == digest, 'starting source changed')
    builder = module(ROOT / 'bench/build-engine-arm.py')
    identities = {}
    census_hashes = {}
    actual = census()
    for arm in ['control', 'candidate']:
        identity = load(M / ('build-' + arm) / 'identity.json')
        rows = [json.loads(line, object_pairs_hook=A.unique) for line in (M / ('build-' + arm) / 'cargo.jsonl').read_text().splitlines()]
        builder.select(rows)
        need(identity['command'] == ['cargo', 'test', '--release', '-p', 'glass-term', '--locked', '--no-run', '--message-format=json'], 'fresh build command')
        source = load(M / (arm + '-source-sha256.json'))
        expected = dict(actual)
        for name in CHANGED:
            expected[name] = sha(M / (arm + '-' + name.replace('/', '_')))
        need(source == expected, 'full source census')
        need(identity['source_sha256'] == {name: source[name] for name in builder.INPUTS}, 'build source binding')
        census_hashes[arm] = sha(M / (arm + '-source-sha256.json'))
        data = lzma.decompress((M / (arm + '-test-elf.xz')).read_bytes())
        need(data.startswith(b'\x7fELF') and hashlib.sha256(data).hexdigest() == identity['sha256'], 'retained executable binding')
        identities[arm] = identity
    records = load(M / 'gates.json')
    logs = {(r['arm'], r['label']): (M / f'{r["arm"]}-{r["label"]}.log').read_text() for r in records}
    check_records(records, identities, logs, census_hashes)
    computed = A.analyze(load(M / 'raw.json'), identities)
    need(computed == load(D / 'analysis.json'), 'analysis disagrees with raw')
    need((M / 'run.exit').read_text().strip() == '0', 'run failed')
    prior = module(ROOT / 'bench/replay-evidence-index.py').validate(ROOT, load(D / 'prior-frozen-index.json'))
    return dict(schema='glass.fused-mark-revisit-checkpoint/v1', status='reported',
                terminal_passed_per_arm=397, terminal_ignored=14, literal_cases_per_arm=3816,
                long_redraw_cases_per_arm=86784, long_observations_per_arm=520704,
                candidate_library_passed=139, reference_fixtures=45, library_doctests=1,
                pairs=12, timing_sessions=24, source_bound_fresh_builds=2,
                artifact_references=len(manifest['files']), engine_screen_cleared=computed['engine_screen_cleared'],
                point_regression_guards_failed=computed['point_regression_guards_failed'],
                production_restored=True, selected_executable_unchanged=True,
                prior_references=prior['file_references'], prior_versions=prior['unique_source_versions'], runtime_promotion=False,
                note='Byte-integrity and receipt replay only, not fresh test execution, PTY or Ghostty timing, or championship acceptance.')


if __name__ == '__main__':
    print(json.dumps(verify(), indent=2, sort_keys=True))
