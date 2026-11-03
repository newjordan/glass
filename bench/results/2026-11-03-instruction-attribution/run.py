#!/usr/bin/env python3
"""Frozen exact-binary diagnostic capture. Never builds or promotes a runtime."""
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import time

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
LINE = re.compile(r'^\s*(\w+):\s+([\d.]+) MB/s\s+([\d.]+) MB/cpu-s\s+\((\d+) bytes, read (\d+)\)', re.M)


def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def capture(out, round_, workload, label, scale, rounds, state):
    arm, observer = label.split('-')
    binary = Path(state['binaries'][arm]['path'])
    assert sha(binary) == state['binaries'][arm]['sha256']
    env = {k: v for k, v in os.environ.items() if not k.startswith('GLASS_') and k != 'LD_PRELOAD'}
    settings = dict(GLASS_BENCH_SCALE=str(scale), GLASS_BENCH_ROUNDS=str(rounds), GLASS_BENCH_ONLY=workload)
    name = f'{round_}-{workload}-{label}'
    trace = out / (name + '.pcs')
    if observer == 'profiled':
        settings.update(LD_PRELOAD=str(D / 'cpu-sample.so'), GLASS_SAMPLE_EXE=str(binary),
                        GLASS_SAMPLE_THREAD='speed::speed', GLASS_SAMPLE_OUT=str(trace), GLASS_SAMPLE_US='100')
    env.update(settings)
    argv = [str(binary), '--ignored', '--exact', '--nocapture', 'speed::speed']
    before = time.monotonic_ns()
    proc = subprocess.Popen(argv, env=env, cwd=ROOT, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    try:
        stdout, stderr = proc.communicate(timeout=300)
    except BaseException:
        proc.kill()
        stdout, stderr = proc.communicate()
        (out / (name + '.stdout')).write_bytes(stdout)
        (out / (name + '.stderr')).write_bytes(stderr)
        raise
    after = time.monotonic_ns()
    stdout_path, stderr_path = (out / (name + suffix) for suffix in ('.stdout', '.stderr'))
    stdout_path.write_bytes(stdout)
    stderr_path.write_bytes(stderr)
    row = dict(round=round_, workload=workload, arm=arm, observer=observer, label=label,
               command=argv, settings=settings, pid=proc.pid, begin_ns=before, end_ns=after, exit=proc.returncode,
               stdout=stdout_path.name, stderr=stderr_path.name,
               stdout_sha256=sha(stdout_path), stderr_sha256=sha(stderr_path), binary_sha256=sha(binary))
    if trace.exists():
        row.update(trace=trace.name, trace_sha256=sha(trace))
    # Retain a receipt even for a malformed/nonzero result.
    (out / (name + '.json')).write_text(json.dumps(row, indent=2) + '\n')
    assert proc.returncode == 0, row
    assert 'test result: ok. 1 passed; 0 failed; 0 ignored;' in stdout.decode(), stdout
    matches = LINE.findall(stderr.decode())
    assert len(matches) == 1 and matches[0][0] == workload, matches
    name_, wall, cpu, size, read = matches[0]
    row['result'] = dict(mb_s=float(wall), mb_cpu_s=float(cpu), bytes=int(size), read=int(read))
    assert float(cpu) > 0 and float(wall) > 0 and int(read) == 4095
    if observer == 'profiled':
        header = trace.read_text().splitlines()[0]
        assert re.fullmatch(r'cpu-sample-v2 tid=\d+ period_us=100 samples=[1-9]\d* dropped=0 armed=1 overruns=\d+', header), header
    else:
        assert not trace.exists()
    assert row['binary_sha256'] == state['binaries'][arm]['sha256']
    (out / (f'{round_}-{workload}-{label}.json')).write_text(json.dumps(row, indent=2) + '\n')
    print(round_, workload, label, row['result'], flush=True)
    return row


def main():
    assert len(sys.argv) == 2 and sys.argv[1] in ('pilot', 'main')
    mode = sys.argv[1]
    state = json.loads((D / 'starting-state.json').read_text())
    out = D / mode
    out.mkdir()  # fail rather than overwrite any previous capture
    report = dict(schema='glass.instruction-capture/v1', mode=mode, complete=False,
                  protocol_sha256=sha(D / 'protocol.json'), runner_sha256=sha(__file__),
                  sampler_sha256=sha(D / 'cpu-sample.so'), sessions=[])
    manifest = out / 'manifest.json'
    manifest.write_text(json.dumps(report, indent=2) + '\n')
    try:
        if mode == 'pilot':
            report['sessions'].append(capture(out, 0, 'truecolor', 'control-profiled', 1, 1, state))
        else:
            assert json.loads((D / 'pilot-analysis.json').read_text())['pilot_valid'] is True
            arms = ['control-plain', 'candidate-profiled', 'candidate-plain', 'control-profiled']
            for r in range(3):
                order = arms[r:] + arms[:r]
                if r % 2:
                    order.reverse()
                for workload in ('truecolor', 'unicode'):
                    for label in order:
                        report['sessions'].append(capture(out, r, workload, label, 12, 5, state))
                        manifest.write_text(json.dumps(report, indent=2) + '\n')
        report['complete'] = True
    finally:
        manifest.write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
