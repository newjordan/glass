#!/usr/bin/env python3
"""Export tput.py's exact trusted workload generator, without terminal I/O.

This deliberately executes the existing generator's AST, not a rewritten RNG
or approximate port. Review generator edits as executable Python. Output is a
new directory, manifest last; a partial export cannot be mistaken for complete.
Hashes identify bytes, not their authorship, correctness or performance.
"""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import random
import sys

NAMES = ('ascii', 'unicode', 'truecolor', 'cursor_motion', 'scroll_region', 'tui_frames')
SOURCE = Path(__file__).resolve().with_name('tput.py')


def digest(data):
    return hashlib.sha256(data).hexdigest()


def generator(source):
    tree = ast.parse(source)
    # Named top-level assignments delimit only the corpus generator. Refuse a
    # changed boundary rather than silently including terminal setup/timing.
    def assignment(node, name):
        return isinstance(node, ast.Assign) and any(isinstance(t, ast.Name) and t.id == name for t in node.targets)
    starts = [i for i, n in enumerate(tree.body) if assignment(n, 'rng')]
    ends = [i for i, n in enumerate(tree.body) if assignment(n, 'old')]
    if len(starts) != 1 or len(ends) != 1 or ends[0] <= starts[0]:
        raise ValueError('unrecognized generator boundaries')
    nodes = tree.body[starts[0]:ends[0]]
    if not any(assignment(n, 'W') for n in nodes):
        raise ValueError('missing workload dictionary')
    return ast.Module(body=nodes, type_ignores=[]), (nodes[0].lineno, nodes[-1].end_lineno)


def payloads(rows, cols):
    if type(rows) is not int or type(cols) is not int or not (4 <= rows <= 512 and 9 <= cols <= 512):
        raise ValueError('geometry must have 4..512 rows and 9..512 columns')
    source = SOURCE.read_bytes()
    tree, lines = generator(source)
    namespace = dict(random=random, rows=rows, cols=cols)
    exec(compile(tree, str(SOURCE), 'exec'), namespace)
    data = namespace['W']
    if tuple(data) != NAMES or any(not isinstance(v, bytes) or not v for v in data.values()):
        raise ValueError('unexpected workloads')
    return data, dict(path='bench/tput.py', sha256=digest(source), generator_lines=list(lines))


def export(out, rows, cols):
    out = Path(out)
    if out.exists():
        raise FileExistsError(out)
    data, source = payloads(rows, cols)
    out.mkdir(parents=True, exist_ok=False)
    manifest = dict(schema='glass.tput-corpus/v1', rows=rows, cols=cols,
                    source=source, python=sys.version, workloads={})
    for name, value in data.items():
        with (out / f'{name}.bin').open('xb') as f:
            f.write(value)
        manifest['workloads'][name] = dict(bytes=len(value), sha256=digest(value))
    with (out / 'manifest.json').open('x') as f:
        json.dump(manifest, f, indent=2)
        f.write('\n')
    return manifest


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('out', type=Path)
    p.add_argument('--rows', type=int, default=39)
    p.add_argument('--cols', type=int, default=154)
    a = p.parse_args()
    print(json.dumps(export(a.out, a.rows, a.cols), indent=2))


if __name__ == '__main__':
    main()
