#!/usr/bin/env python3
"""Iteration-30 evidence reconciliation. No capture, builds, repair or promotion.

Existing validators replay recorded data; independent statistics below reconcile
selected and unpromoted binary claims without pooling series or internal passes.
"""
import hashlib
import importlib.util
import json
import math
from pathlib import Path
import statistics

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
RESULTS = ROOT / 'bench/results'
WORKLOADS = ('ascii', 'unicode', 'truecolor', 'cursor_motion', 'scroll_region', 'tui_frames')
SELECTED = 'd75cb26fb48120df841ff876ee110c1e45e5feb6c3996ddc90d01e681200805c'


def need(ok, message):
    if not ok:
        raise ValueError(message)


def unique(pairs):
    result = {}
    for key, value in pairs:
        need(key not in result, 'duplicate JSON key: ' + key)
        result[key] = value
    return result


def load(path):
    return json.loads(Path(path).read_text(), object_pairs_hook=unique,
                      parse_constant=lambda value: (_ for _ in ()).throw(ValueError(value)))


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def module(path):
    path = Path(path)
    spec = importlib.util.spec_from_file_location('audit30_' + path.parent.name.replace('-', '_') + path.stem.replace('-', '_'), path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def stats(ratios):
    need(bool(ratios) and all(type(x) in (float, int) and math.isfinite(x) and x > 0 for x in ratios), 'invalid ratios')
    wins, losses = sum(x > 1 for x in ratios), sum(x < 1 for x in ratios)
    n = wins + losses
    p = min(1., 2 * sum(math.comb(n, k) for k in range(min(wins, losses) + 1)) / 2 ** n)
    median = statistics.median(ratios)
    return dict(median_ratio=median, wins=wins, losses=losses, ties=len(ratios)-n,
                sign_p_two_sided=p, observed_deficit_percent=max(0., (1-median)*100),
                own_gain_to_observed_parity_percent=max(0., (1/median-1)*100))


def holm(rows):
    running = 0.
    for i, name in enumerate(sorted(rows, key=lambda key: (rows[key]['sign_p_two_sided'], key))):
        running = max(running, min(1., (len(rows)-i)*rows[name]['sign_p_two_sided']))
        rows[name]['holm_p_six_workloads'] = running
        rows[name]['conditional_positive_lead'] = (rows[name]['median_ratio'] > 1 and rows[name]['wins'] > rows[name]['losses'] and running < .05)
    return rows


def rounded_pass_sensitivity(directory, report, term):
    """Retrospective session-median estimand using 1ms-rounded retained passes.

    No extra samples: one paired ratio per captured round. The producer records
    MB/s from an unrounded fastest tuple and rounds every stored secs to 3dp.
    Thus secs cannot exactly reproduce official MB/s; the intervals bound the
    median-time estimand's quantization only, NOT sampling uncertainty.
    """
    rows = {}
    for name in WORKLOADS:
        ratios, lower, upper = [], [], []
        for i in range(1, report['rounds'] + 1):
            a = load(directory / 'terminal' / f'tput-{term}-{i}.json')['results'][name]
            b = load(directory / 'terminal' / f'tput-ghostty-{i}.json')['results'][name]
            need(a['bytes'] == b['bytes'], 'sensitivity payload mismatch')
            for entry in (a, b):
                need(len(entry['secs']) == 3 and all(type(x) in (float, int) and math.isfinite(x) and x > .0005 for x in entry['secs']), 'invalid retained pass times')
            am, bm = statistics.median(a['secs']), statistics.median(b['secs'])
            ratios.append(bm/am)
            lower.append((bm-.0005)/(am+.0005))
            upper.append((bm+.0005)/(am-.0005))
        rows[name] = dict(**stats(ratios), quantization_only_median_interval=[statistics.median(lower), statistics.median(upper)], guaranteed_round_wins=sum(x > 1 for x in lower), guaranteed_round_losses=sum(x < 1 for x in upper), ambiguous_rounds=sum(lo <= 1 <= hi for lo, hi in zip(lower, upper)))
    holm(rows)
    return dict(estimand='paired per-session median-of-three rounded wall-time rate ratio', retrospective=True, internal_passes_are_not_independent=True, metrics=rows, conditional_positive_leads=sum(row['conditional_positive_lead'] for row in rows.values()), limits='1ms quantization intervals are NOT confidence intervals. Rounded ties are not proven exact ties. Retrospective estimator cannot replace frozen fastest-pass scoring or rescue promotion.')


def terminal(relative, term, expected_sha):
    directory = ROOT / relative
    replay = module(ROOT / 'bench/replay-terminal-pairs.py')
    replay.validate(directory, verify_binaries=True)
    report = load(directory / 'terminal-summary.json')
    need(report['binaries'][term]['sha256'] == expected_sha, 'wrong scored executable')
    producer = ROOT / 'bench/tput.py'
    need(report['harness_sha256'][str(producer)] == sha(producer), 'changed pass-time producer')
    rows = {}
    for name in WORKLOADS:
        ratios = []
        for i in range(1, report['rounds']+1):
            a = load(directory / 'terminal' / f'tput-{term}-{i}.json')['results'][name]
            b = load(directory / 'terminal' / f'tput-ghostty-{i}.json')['results'][name]
            ratios.append(a['mb_s'] / b['mb_s'])
        rows[name] = stats(ratios)
    holm(rows)
    return dict(source=relative, rounds=report['rounds'], sessions=report['rounds']*len(report['terms']),
                scored_sha256=expected_sha, competitor=report['binaries']['ghostty'], metrics=rows,
                rounded_pass_sensitivity=rounded_pass_sensitivity(directory, report, term),
                corrected_positive_leads=sum(x['conditional_positive_lead'] for x in rows.values()),
                all_six=all(x['conditional_positive_lead'] for x in rows.values()))


def engine(name):
    directory = RESULTS / ('2026-11-03-' + name)
    raw_path = directory / ('engine-pairs.json' if (directory / 'engine-pairs.json').exists() else 'raw.json')
    raw = load(raw_path)
    analyzer = module(directory / 'analyze.py')
    analysis = analyzer.analyze() if name in ('exclusive-column', 'width-handle', 'static-width-cache') else analyzer.analyze(raw)
    saved = directory / ('analysis.json' if (directory / 'analysis.json').exists() else 'engine-decision.json')
    need(analysis == load(saved), 'analysis drift: ' + name)
    rows = analysis.get('summary', analysis.get('metrics', analysis.get('contrasts', {}).get('primary')))
    need(set(rows) == set(WORKLOADS), 'six workloads required')
    need(analysis['engine_screen_cleared'] is False and analysis['runtime_promotion'] is False, 'unexpected promotion: ' + name)
    return dict(source=str(raw_path.relative_to(ROOT)), analysis=str(saved.relative_to(ROOT)),
                protocol=str((directory / 'protocol.json').relative_to(ROOT)),
                pairs=len(raw['pairs']) if 'pairs' in raw else analysis['blocks'],
                sessions=2*len(raw['pairs']) if 'pairs' in raw else len(raw['sessions']),
                binaries=raw['binaries'], metrics={key: {k: v for k, v in value.items() if k in ('median_cpu_ratio', 'wins', 'losses', 'sign_p_two_sided', 'holm_p')} for key, value in rows.items()},
                screen_cleared=False, runtime_promotion=False)


def diagnostic_replays():
    results = {}
    sched_dir = RESULTS / '2026-11-03-scheduler-shape'
    sched = module(ROOT / 'bench/linux/analyze-sched-shape.py')
    value = sched.analyze(sched_dir / 'balanced')
    value['calibration'] = sched.calibration(sched_dir)
    need(value == load(sched_dir / 'balanced-final-replay.json'), 'scheduler replay drift')
    results['scheduler-shape'] = dict(sessions=value['sessions'], receipt='balanced-final-replay.json')
    for experiment, script, series in (
        ('reader-contention', 'analyze-reader-contention.py', ('balanced',)),
        ('hot-placement', 'analyze-hot-placement.py', ('confirmatory', 'replication')),
        ('role-partition', 'analyze-role-partition.py', ('confirmatory',))):
        analyzer = module(ROOT / 'bench/linux' / script)
        directory = RESULTS / ('2026-11-03-' + experiment)
        results[experiment] = {}
        for name in series:
            value = analyzer.analyze(directory / name)
            need(value == load(directory / (name + '-replay.json')), experiment + '/' + name + ' replay drift')
            results[experiment][name] = dict(sessions=value['sessions'], receipt=name + '-replay.json')
    return results


def run():
    start = load(D / 'starting-state.json')
    need({str(p.relative_to(ROOT)) for p in (ROOT / 'crates').rglob('*.rs')} == set(start['rust_sha256']), 'runtime source inventory changed')
    need(sha(ROOT / start['selected_path']) == start['selected_sha256'] == SELECTED, 'selected executable changed')
    for group in ('rust_sha256', 'prior_sha256', 'shared_docs_sha256'):
        for path, digest in start[group].items():
            need(sha(ROOT / path) == digest, 'preserved input changed: ' + path)
    for path, digest in load(D / 'input-sha256.json')['files'].items():
        need(sha(ROOT / path) == digest, 'audit input changed: ' + path)
    selected = terminal('bench/results/2026-11-03-role-partition/shipping-vs-ghostty', 'glass', SELECTED)
    combined = terminal('bench/results/2026-11-03-marks-width/replication-gate', 'glass', '6111147b21a4bc6d112cfb359bd8e3535b4c7bdd03e0803b550534e8e45c3369')
    historical = terminal('bench/results/2026-11-03-read-shape/tail-policy/gate', 'glass-alt', SELECTED)
    temporal = {name: dict(earlier_ratio=historical['metrics'][name]['median_ratio'], latest_ratio=selected['metrics'][name]['median_ratio'], latest_over_earlier=selected['metrics'][name]['median_ratio']/historical['metrics'][name]['median_ratio']) for name in WORKLOADS}
    # Compare emitting harness, geometry and competitor identity, not just scores.
    old_summary = load(ROOT / historical['source'] / 'terminal-summary.json')
    new_summary = load(ROOT / selected['source'] / 'terminal-summary.json')
    for key in ('harness_sha256', 'geometry'):
        need(old_summary[key] == new_summary[key], 'changed temporal comparison: ' + key)
    need(historical['competitor'] == selected['competitor'], 'changed temporal competitor')
    need(selected['corrected_positive_leads'] == 3 and combined['corrected_positive_leads'] == 4, 'competitive claim drift')
    diagnostics = diagnostic_replays()
    engines = {name: engine(name) for name in ('exclusive-column', 'width-handle', 'static-width-cache', 'parser-authority', 'authority-handoff', 'csi-outlining', 'decoded-handoff', 'scalar-domain', 'multibyte-outline')}
    codegen = {}
    for name in ('decoded-handoff', 'scalar-domain', 'multibyte-outline'):
        value = load(RESULTS / ('2026-11-03-' + name) / 'codegen.json')
        codegen[name] = {arm: {routine: {k: v for k, v in row.items() if k in ('address', 'bytes', 'instructions', 'normalized_sha256')} for routine, row in value[arm].items()} for arm in ('control', 'candidate')}
    receipts = {}
    for name in ('role-partition', 'exclusive-column', 'width-handle', 'static-width-cache', 'parser-authority', 'authority-handoff', 'instruction-attribution', 'csi-outlining', 'decoded-handoff', 'scalar-domain', 'multibyte-outline'):
        receipt_dir = RESULTS / ('2026-11-03-' + name)
        receipt = next(p for p in (receipt_dir / n for n in ('checkpoint-final.json', 'checkpoint-current.json', 'checkpoint-initial.json')) if p.is_file() and p.stat().st_size)
        receipts[name] = dict(source=str(receipt.relative_to(ROOT)), scope='stored historical receipt, not newly executed full suite', census={k: v for k, v in load(receipt).items() if any(word in k for word in ('tests', 'streams', 'corruption'))})
    # Identical repeated binaries are paired within each series only. These
    # differences are descriptive temporal variation, NOT an independent trial.
    a, b = engines['authority-handoff'], engines['csi-outlining']
    need(a['binaries']['base']['sha256'] == b['binaries']['control-inline']['sha256'], 'control identity')
    need(a['binaries']['candidate']['sha256'] == b['binaries']['authority-inline']['sha256'], 'candidate identity')
    later = load(RESULTS / '2026-11-03-csi-outlining/analysis.json')['contrasts']['authority_inline_effect']
    repeated = {name: dict(earlier_ratio=a['metrics'][name]['median_cpu_ratio'], later_ratio=later[name]['median_cpu_ratio'],
                          later_over_earlier=later[name]['median_cpu_ratio']/a['metrics'][name]['median_cpu_ratio']) for name in WORKLOADS}
    return dict(schema='glass.campaign-audit30/v1', status='reported', runtime_promotion=False,
                championship_established=False, selected=selected, unpromoted_combined=combined,
                historical_selected=historical, selected_temporal_contrasts=temporal, historical_receipt_scopes=receipts,
                literal_target=load(D / 'target-contract.json'),
                engine_experiments=engines, diagnostic_replays=diagnostics, exact_repeated_arm_contrasts=repeated, codegen=codegen,
                preserved_rust_files=len(start['rust_sha256']), preserved_prior_files=len(start['prior_sha256']),
                preserved_shared_docs=len(start['shared_docs_sha256']),
                active_claim_ledger=load(D / 'claims.json'),
                limitations=['No new benchmark, build, submission or deployment.', 'Parity deltas are reciprocals of observed paired medians, not superiority bounds.', 'Within-series Holm families do not correct adaptive campaign-wide search.', 'Fastest internal passes are not independent trials; shared host and serial signs limit inference.', 'Hash consistency is not authenticity, timing accuracy, safety or championship acceptance.', 'Previous checkpoint passed; historical full test counts are retained receipts, not new full-suite executions.', 'Temporary binaries are required for exact replay; no rebuild or fallback is performed.'])


if __name__ == '__main__':
    print(json.dumps(run(), indent=2, sort_keys=True))
