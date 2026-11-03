"""Reject stale/malformed real Cargo arm receipts before accepting an executable."""
import copy
import importlib.util
from pathlib import Path
import unittest
import tempfile
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('build_arm', Path(__file__).with_name('build-engine-arm.py'))
arm = importlib.util.module_from_spec(spec)
spec.loader.exec_module(arm)


def rows():
    return [dict(reason='compiler-artifact', target=dict(name=name), fresh=False,
                 executable='/tmp/test' if name == 'glass' else None,
                 profile=dict(test=name == 'glass', opt_level='3', debug_assertions=False))
            for name in ('vte', 'glass', 'alacritty_terminal')] + [dict(reason='build-finished', success=True)]


class BuildArmReceipts(unittest.TestCase):
    def test_valid_release(self):
        self.assertEqual(arm.select(rows()), Path('/tmp/test'))

    def test_stale_packages(self):
        for index in (0, 1, 2):
            with self.subTest(index=index):
                r = rows()
                r[index]['fresh'] = True
                with self.assertRaisesRegex(ValueError, 'stale package'):
                    arm.select(r)

    def test_ambiguous_package(self):
        r = rows()
        r.append(copy.deepcopy(r[1]))
        with self.assertRaisesRegex(ValueError, 'ambiguous'):
            arm.select(r)

    def test_missing_package(self):
        with self.assertRaises(ValueError):
            arm.select(rows()[1:])

    def test_missing_executable(self):
        r = rows()
        r[1]['executable'] = None
        with self.assertRaisesRegex(ValueError, 'test executable'):
            arm.select(r)

    def test_not_release(self):
        for key, value in [('opt_level', '0'), ('debug_assertions', True)]:
            with self.subTest(key=key):
                r = rows()
                r[1]['profile'][key] = value
                with self.assertRaisesRegex(ValueError, 'optimized release'):
                    arm.select(r)

    def test_failed_or_absent_completion(self):
        for r in (rows()[:-1], rows()[:-1] + [dict(reason='build-finished', success=False)]):
            with self.subTest(r=r):
                with self.assertRaisesRegex(ValueError, 'build completion'):
                    arm.select(r)

    def test_publish_no_clobber_and_no_partial_file(self):
        with tempfile.TemporaryDirectory() as name:
            root = Path(name)
            source, out = root / 'source', root / 'out'
            source.write_bytes(b'executable')
            source.chmod(0o755)
            arm.publish(source, out)
            self.assertEqual(out.read_bytes(), b'executable')
            self.assertEqual(out.stat().st_mode & 0o777, 0o755)
            source.write_bytes(b'other')
            with self.assertRaises(FileExistsError):
                arm.publish(source, out)
            self.assertEqual(out.read_bytes(), b'executable')
            self.assertEqual(sorted(p.name for p in root.iterdir()), ['out', 'source'])
            with patch.object(arm.shutil, 'copyfileobj', side_effect=OSError('copy failed')):
                with self.assertRaises(OSError):
                    arm.publish(source, root / 'failed')
            self.assertFalse((root / 'failed').exists())
            self.assertEqual(sorted(p.name for p in root.iterdir()), ['out', 'source'])


if __name__ == '__main__':
    unittest.main()
