#!/usr/bin/env python3
"""Post-timing, test-only call census. Never use these binaries as timing evidence."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
PATHS = ['crates/term/src/engine.rs', 'crates/term/src/speed.rs', 'crates/vte/src/lib.rs', 'crates/vte/src/ansi.rs']
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()
put = lambda p, v: p.write_text(json.dumps(v, indent=2) + '\n')
protocol = dict(schema='glass.decode-census-protocol/v1', arms=['control', 'candidate'], scale='.25', rounds='1', read='4095', workloads=['ascii', 'unicode', 'truecolor', 'cursor_motion', 'scroll_region', 'tui_frames'],
                question='Does the exact candidate reduce utf8_at invocations on the measured workload shapes?',
                observation='Thread-local [end-of-slice, ASCII-lead, non-ASCII-lead] attempt counters, reset immediately after round reset sequence, report immediately after feed. One fixed run per arm. No decode validity inference.',
                limits='Test-only instrumentation changes codegen. Rates printed by speed are discarded, not pooled with uninstrumented screen. Attempts are not cycles or independently executed instructions.')


def main():
    assert json.loads((D / 'decode-census-protocol.json').read_text()) == protocol
    originals = {p: (ROOT / p).read_bytes() for p in PATHS}
    selected = sha(ROOT / 'target/release/glass')
    result = dict(schema='glass.decode-census-raw/v1', protocol_sha256=sha(D / 'decode-census-protocol.json'), runner_sha256=sha(__file__), sessions=[])
    try:
        for arm in protocol['arms']:
            for p in PATHS:
                (ROOT / p).write_bytes((D / (arm + '-' + p.replace('/', '_'))).read_bytes())
            p = ROOT / PATHS[0]
            s = p.read_text()
            needle = '#[inline(always)]\nfn utf8_at(bytes: &[u8], at: usize) -> Option<(char, usize)> {'
            assert s.count(needle) == 1
            prelude = '''#[cfg(test)]
thread_local! {
    static DECODE_ATTEMPTS: std::cell::Cell<[u64; 3]> = const { std::cell::Cell::new([0; 3]) };
}
#[cfg(test)]
pub(crate) fn decode_calls_reset() {
    DECODE_ATTEMPTS.with(|c| c.set([0; 3]));
}
#[cfg(test)]
pub(crate) fn decode_calls_take() -> [u64; 3] {
    DECODE_ATTEMPTS.with(|c| c.get())
}
'''
            entry = '''
    #[cfg(test)]
    DECODE_ATTEMPTS.with(|count| {
        let mut values = count.get();
        let lane = bytes.get(at).map_or(0, |b| if *b < 0x80 { 1 } else { 2 });
        values[lane] += 1;
        count.set(values);
    });'''
            p.write_text(s.replace(needle, prelude + needle + entry))
            p = ROOT / PATHS[1]
            s = p.read_text()
            needle = '            let (t, c) = (Instant::now(), cpu_seconds());'
            assert s.count(needle) == 1
            s = s.replace(needle, '            crate::engine::decode_calls_reset();\n' + needle)
            needle = '            best = best.min(t.elapsed().as_secs_f64());'
            assert s.count(needle) == 1
            s = s.replace(needle, '            eprintln!("decode-calls {name}: {:?}", crate::engine::decode_calls_take());\n' + needle)
            p.write_text(s)
            for p in PATHS:
                (D / ('count-' + arm + '-' + p.replace('/', '_'))).write_bytes((ROOT / p).read_bytes())
            dest = f'/tmp/glass-i27-count-{arm}-test'
            argv = [sys.executable, '-B', 'bench/build-engine-arm.py', '--out', dest, '--receipt-dir', str(D / ('build-census-' + arm))]
            proc = subprocess.run(argv, cwd=ROOT, capture_output=True, text=True, timeout=600)
            (D / f'build-census-{arm}.json').write_text(proc.stdout)
            assert proc.returncode == 0, proc.stderr
            env = {k: v for k, v in os.environ.items() if not k.startswith(('GLASS_', 'LD_PRELOAD', 'CPU_SAMPLE_'))}
            settings = dict(GLASS_BENCH_SCALE=protocol['scale'], GLASS_BENCH_ROUNDS=protocol['rounds'], GLASS_BENCH_READ=protocol['read'], GLASS_BENCH_ONLY=','.join(protocol['workloads']))
            argv = [dest, '--ignored', '--exact', '--nocapture', 'speed::speed']
            proc = subprocess.run(argv, cwd=ROOT, env=env | settings, capture_output=True, text=True, timeout=120)
            result['sessions'].append(dict(arm=arm, argv=argv, settings=settings, binary_sha256=sha(dest), exit=proc.returncode, stdout=proc.stdout, stderr=proc.stderr))
            put(D / 'decode-census-raw.json', result)
            assert proc.returncode == 0, proc.stderr
            print(arm, 'decode census retained; rates excluded', flush=True)
    finally:
        for p, content in originals.items():
            (ROOT / p).write_bytes(content)
        assert sha(ROOT / 'target/release/glass') == selected
        print('sources restored; selected terminal untouched', flush=True)


if __name__ == '__main__':
    main()
