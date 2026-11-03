"""Read-only scheduler replay guard regressions; measurement remains separate.

Small synthetic traces exercise format/error paths, not terminal performance.
The complete capture is independently replayed by the analyzer CLI.
"""
import importlib.util
import json
from pathlib import Path
import struct
import tempfile
import unittest

SPEC = importlib.util.spec_from_file_location('scheduler_replay', Path(__file__).parent/'linux/analyze-sched-shape.py')
replay = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(replay)


def snapshot(wall, cpu, rq, runtime=None, slices=1):
    return [wall, cpu, cpu if runtime is None else runtime, rq, slices, cpu+10, wall+10]


def trace(rows, **kw):
    fields = dict(magic=b'RDSCHED1', version=1, size=128, count=len(rows), dropped=0,
                  mode=1, tid=123, cap=65536, stride=128)
    fields.update(kw)
    return struct.pack('<8s8I', *fields.values()) + b''.join(struct.pack('<16Q', *r) for r in rows)


class SchedulerReplayTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.path = Path(self.temp.name)/'capture.trace'
        self.b = snapshot(100, 100, 10)
        self.a = snapshot(1100, 500, 210, slices=3)
        self.row = self.b+self.a+[16384, 128]

    def decode(self, data, arm='sched'):
        self.path.write_bytes(data)
        try:
            return replay.decode(self.path, arm)
        finally:
            self.assertEqual(self.path.read_bytes(), data, 'checker changed trace')

    def reject(self, data, arm='sched'):
        with self.assertRaises(ValueError):
            self.decode(data, arm)

    def test_scheduler_interval_and_trace(self):
        tid, rows = self.decode(trace([self.row]))
        self.assertEqual(tid, 123)
        self.assertEqual(rows[0]['wall_ns'], 1000)
        self.assertEqual(rows[0]['cpu_ns'], 400)
        self.assertEqual(rows[0]['runqueue_ns'], 200)
        self.assertEqual(rows[0]['residual_ns'], 400)
        self.assertEqual(rows[0]['timeslices'], 2)

    def test_clock_mode_has_no_sched_fields(self):
        row = self.b+self.a+[128, 128]
        row[2:5] = row[9:12] = [0, 0, 0]
        self.decode(trace([row], mode=0), 'clock')
        self.reject(trace([self.row], mode=0), 'clock')
        self.reject(trace([row], mode=0), 'sched')

    def test_header_length_drop_and_tail_rejected(self):
        data = trace([self.row])
        for changed in (data[:20], data[:-1], data+b'X', trace([self.row], dropped=1),
                        trace([self.row], count=2), trace([self.row], cap=4),
                        trace([self.row], stride=64), trace([self.row], version=2),
                        trace([self.row], size=56), trace([self.row], magic=b'BADMAGIC'),
                        trace([self.row], tid=0), trace([])):
            with self.subTest(length=len(changed)):
                self.reject(changed)

    def test_counter_regression_and_invalid_time(self):
        for i, v in ((7, 99), (8, 99), (9, 0), (10, 0), (11, 0), (12, 4999), (15, 127), (14, 128*16384+1)):
            row = self.row.copy(); row[i] = v
            with self.subTest(field=i):
                self.reject(trace([row]))

    def test_window_contiguity(self):
        after = snapshot(2100, 900, 410, slices=5)
        second = self.a+after+[16384, 128]
        self.decode(trace([self.row, second]))
        second[0] += 1
        self.reject(trace([self.row, second]))

    def test_negative_residual_not_repaired(self):
        a = snapshot(1100, 500, 630, slices=3)
        _, rows = self.decode(trace([self.b+a+[100, 128]]))
        self.assertEqual(rows[0]['residual_ns'], -20)
        a[3] = 900
        self.reject(trace([self.b+a+[100, 128]]))

    def test_whole_windows_only(self):
        _, windows = self.decode(trace([self.row]))
        p = dict(begin_ns=99, end_ns=1111, workload='ascii', **{'pass': 0}, bytes=16384,
                 terminal_before=[dict(tid=123, name='pty-read', start_ticks=45)],
                 terminal_after=[dict(tid=123, name='pty-read', start_ticks=45)])
        result = replay.summarize_pass(p, windows, 123, True)
        self.assertEqual(result['windows'], 1)
        self.assertLess(result['wall_coverage'], 1)
        p['begin_ns'] = 101
        with self.assertRaisesRegex(ValueError, 'no whole windows'):
            replay.summarize_pass(p, windows, 123, True)

    def test_recycled_reader_rejected(self):
        _, windows = self.decode(trace([self.row]))
        p = dict(begin_ns=99, end_ns=1111, workload='ascii', **{'pass': 0}, bytes=16384,
                 terminal_before=[dict(tid=123, name='pty-read', start_ticks=45)],
                 terminal_after=[dict(tid=123, name='pty-read', start_ticks=46)])
        with self.assertRaisesRegex(ValueError, 'identity changed'):
            replay.summarize_pass(p, windows, 123, True)

    def test_duplicate_json_rejected_without_change(self):
        text = '{"complete": true, "complete": false}'
        path = Path(self.temp.name)/'metadata.json'
        path.write_text(text)
        with self.assertRaisesRegex(ValueError, 'duplicate key'):
            replay.load(path)
        self.assertEqual(path.read_text(), text)


if __name__ == '__main__':
    unittest.main()
