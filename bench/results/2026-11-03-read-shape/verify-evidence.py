#!/usr/bin/env python3
"""Replay the explicitly frozen campaign manifest; does not validate timing accuracy.

Run from the workspace root. Temporary executable checks live in the original
measurement replay tools; this manifest preserves source/log/raw-data integrity
when those binaries no longer exist. No directory discovery or fallback occurs.
"""
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[3]
MANIFEST = Path(__file__).with_name("evidence-sha256.json")


def unique_object(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f"duplicate key: {key}")
        result[key] = value
    return result


def main():
    document = json.loads(MANIFEST.read_text(), object_pairs_hook=unique_object)
    if document["schema"] != "glass.immutable-research-evidence/v1":
        raise ValueError("unknown evidence schema")
    hashes = document["sha256"]
    if not hashes:
        raise ValueError("empty evidence manifest")
    total = 0
    for relative, expected in hashes.items():
        path = Path(relative)
        if path.is_absolute() or ".." in path.parts or not path.parts:
            raise ValueError(f"non-workspace source: {relative}")
        if len(expected) != 64 or any(c not in "0123456789abcdef" for c in expected):
            raise ValueError(f"invalid digest: {relative}")
        source = ROOT / path
        if source.is_symlink() or not source.is_file() or not source.resolve().is_relative_to(ROOT):
            raise ValueError(f"invalid source: {relative}")
        data = source.read_bytes()
        if hashlib.sha256(data).hexdigest() != expected:
            raise ValueError(f"changed source: {relative}")
        total += len(data)
    print(json.dumps({"schema": "glass.evidence-replay/v1", "files": len(hashes),
                      "bytes": total, "manifest_sha256": hashlib.sha256(MANIFEST.read_bytes()).hexdigest(),
                      "note": "Integrity replay only, not a timing or safety proof."}, indent=2))


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, KeyError, TypeError) as error:
        print(f"evidence replay failed: {error}", file=sys.stderr)
        raise SystemExit(1)
