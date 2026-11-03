#!/usr/bin/env python3
"""Independent top-level tput.py execution up to its first terminal-mode call.

Mock only terminal size, waiting and the stop point; unlike the exporter, do
not parse AST, copy generator code, or choose statements. No terminal IO occurs.
"""
import hashlib
import json
import lzma
import os
from pathlib import Path
import runpy
import sys
import termios
import time
from unittest.mock import patch

D = Path(__file__).resolve().parent
ROOT = D.parents[2]
class Captured(BaseException):
    pass
captured = {}

def stop(_fd):
    ns = sys._getframe(1).f_globals
    for name,data in ns['W'].items():
        retained = lzma.decompress((D/'corpus'/(name+'.bin.xz')).read_bytes())
        if data != retained:
            raise ValueError('original script byte mismatch: '+name)
        captured[name] = dict(bytes=len(data),sha256=hashlib.sha256(data).hexdigest())
    raise Captured()

with patch.object(sys,'argv',['tput.py','unused.json']), patch.object(os,'get_terminal_size',return_value=os.terminal_size((154,39))), patch.object(time,'sleep',return_value=None), patch.object(termios,'tcgetattr',new=stop):
    try:
        runpy.run_path(str(ROOT/'bench/tput.py'),run_name='__main__')
    except Captured:
        pass
    else:
        raise ValueError('terminal script did not stop at capture boundary')
manifest = json.loads((D/'corpus/manifest.json').read_text())
assert captured == manifest['workloads']
print(json.dumps(dict(schema='glass.exact-corpus-independent-export/v1',source_sha256=hashlib.sha256((ROOT/'bench/tput.py').read_bytes()).hexdigest(),workloads=captured,all_six_byte_equal=True,terminal_io=False,limits='Python terminal setup mocked; real terminal behavior and speed not tested.'),indent=2))
