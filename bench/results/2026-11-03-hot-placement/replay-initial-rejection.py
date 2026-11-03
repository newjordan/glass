#!/usr/bin/env python3
"""Replay strict rejection without moving imports or editing the v1 snapshot."""
import importlib.util
from pathlib import Path
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
p = HERE/'source-snapshots/analyze-hot-placement-v1.py'
spec = importlib.util.spec_from_file_location('frozen_v1', p)
m = importlib.util.module_from_spec(spec)
# Preserve original logical source location for its relative imports.
m.__file__ = str(ROOT/'bench/linux/analyze-hot-placement.py')
exec(compile(p.read_text(), str(p), 'exec'), m.__dict__)
try:
    m.analyze(HERE/'balanced')
except ValueError as error:
    if str(error) != 'non-target thread mask changed':
        raise
    print('Original strict replay rejection reproduced:', error)
else:
    raise AssertionError('Initial run unexpectedly accepted')
