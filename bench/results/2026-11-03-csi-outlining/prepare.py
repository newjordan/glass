#!/usr/bin/env python3
"""Prepare fixed arm snapshots and protocol, before builds and timings."""
from pathlib import Path
import json
import subprocess
D = Path(__file__).resolve().parent
ROOT = D.parents[2]
old = ROOT / 'bench/results/2026-11-03-authority-handoff'
inputs = ['crates/term/src/engine.rs', 'crates/term/src/speed.rs', 'crates/vte/src/lib.rs', 'crates/vte/src/ansi.rs']
needle = '#[inline]\nfn simple(rest: &[u8]) -> Option<(usize, Simple)> {'
for parser in ['control', 'authority']:
    for style in ['inline', 'outlined']:
        stem = parser + '-' + style
        for name in inputs:
            text = (old / (('control' if parser == 'control' else 'candidate') + '-' + name.replace('/', '_'))).read_text()
            if parser == 'control':
                assert text == (ROOT / name).read_text(), name
            if name == 'crates/term/src/engine.rs' and style == 'outlined':
                assert text.count(needle) == 1
                text = text.replace(needle, needle.replace('#[inline]', '#[inline(never)]'))
            (D / (stem + '-' + name.replace('/', '_'))).write_text(text)
protocol = dict(
    schema='glass.csi-outlining-protocol/v1',
    hypothesis='Outlining only simple() isolates its CSI decimal index from Engine::apply register pressure. Test a 2x2 parser x scanner-inlining factorial. It changes more than a spill, so even recovery supports codegen sensitivity, not unique causal identification.',
    arms=['control-inline', 'authority-inline', 'control-outlined', 'authority-outlined'],
    build='Four fresh serial builds with build-engine-arm.py; original arms must byte-match retained i24 binaries or stop before timings. Source differences only prior i24 authority patch (including two VTE is_ground accessors) and the single inline attribute. Restore original inputs in finally; selected terminal executable untouched.',
    engine=dict(
        blocks=12, scale=2, rounds=5, read=4095,
        workloads=['ascii', 'unicode', 'truecolor', 'cursor_motion', 'scroll_region', 'tui_frames'],
        orders=[['control-inline', 'authority-inline', 'authority-outlined', 'control-outlined'],
                ['authority-inline', 'control-outlined', 'control-inline', 'authority-outlined'],
                ['control-outlined', 'authority-outlined', 'authority-inline', 'control-inline'],
                ['authority-outlined', 'control-inline', 'control-outlined', 'authority-inline']],
        rotation='Repeat these four Williams orders three times: equal slot counts and equal immediate within-block predecessor counts. 12 chosen prospectively for exact balance, not the earlier contemplated 11.',
        primary='authority-outlined/control-inline: >=.98 median CPU ratio for every workload; at least ascii or scroll_region >=1.02 with positive signs and Holm p<.05 across six workloads. Truecolor >=.98 is a point recovery guard, NOT equivalence.',
        mechanism='Also report authority-outlined/authority-inline, control-outlined/control-inline, authority-inline/control-inline, and per-block ratio-of-ratios. No significance/causality/promotion inference from these secondary contrasts.',
        limits='Shared-host sequential best-of-five in-process CPU rates. Not independent instruction-cost attribution, equivalence, end-to-end PTY throughput, Ghostty comparison or championship.'),
    correctness='Each new outlined arm: all 383 nonignored terminal tests (11 ignored), plus ignored 64x200 deterministic differential streams. Original arms retain i24 correctness provenance; fresh byte identity required. No semantic source change or new test implied.',
    codegen='Save nm and complete apply/simple disassembly for four fresh arms. Record whether outlined decimal loop carries index in a register and that apply actually calls it. If it does not remove index spills, report failed manipulation, no causal conclusion.',
    stop='One source variant, exactly 12 four-arm blocks. No pilot, retry, pooling or rescue variants. If engine gate fails restore/reject; if clears still no promotion without separate prospective PTY + Ghostty gate.',
    review='Optional read-only reviewer timed out after 180 seconds; supplied no accepted findings.',
    preparation_failure='Initial snapshot script incorrectly asserted authority VTE sources equal live control; failed before any runtime edit, build or timing. The two is_ground accessor changes are intentional prior authority prerequisites. Fixed assertion to control snapshots only, retained original starting-state and prior receipt.',
    preservation='All runtime Rust sources, prior tracked result/report files and selected terminal executable remain byte-identical.')
(D / 'protocol.json').write_text(json.dumps(protocol, indent=2) + '\n')
(D / 'toolchain.json').write_text(json.dumps({k: subprocess.check_output(v, text=True) for k, v in {'rustc': ['rustc', '-Vv'], 'cargo': ['cargo', '-V'], 'uname': ['uname', '-a']}.items()}, indent=2) + '\n')
print('prepared four explicit arm snapshots and fixed 12-block protocol')
