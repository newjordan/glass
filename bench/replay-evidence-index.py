#!/usr/bin/env python3
"""Replay an explicit, pinned historical evidence index without discovery or repair.

A manifest may name workspace sources which intentionally evolved later. An
index can bind those names to exact retained snapshots. No fallback to another
path, git revision, or directory scan is allowed. This checks byte integrity,
not measurement accuracy, authorship, safety, or competitive superiority.
"""
import argparse
import hashlib
import json
from pathlib import Path, PurePosixPath
import re

SCHEMA = "glass.historical-evidence-index/v1"


def need(ok, message):
    if not ok:
        raise ValueError(message)


def unique(pairs):
    result = {}
    for key, value in pairs:
        need(key not in result, f"duplicate JSON key: {key}")
        result[key] = value
    return result


def load(data):
    return json.loads(data, object_pairs_hook=unique)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def hash_value(value):
    need(isinstance(value, str) and re.fullmatch(r"[a-f0-9]{64}", value) is not None,
         "invalid SHA-256")
    return value


def relative(value):
    need(isinstance(value, str) and bool(value) and "\\" not in value, "invalid relative path")
    path = PurePosixPath(value)
    need(not path.is_absolute() and path.as_posix() == value and ".." not in path.parts,
         f"noncanonical workspace path: {value}")
    need(value != ".", "empty source path")
    return path


def read(root, name):
    path = root
    for part in relative(name).parts:
        path = path / part
        need(not path.is_symlink(), f"symlink source: {name}")
    need(path.is_file(), f"missing source: {name}")
    return path.read_bytes()


def validate(root, index):
    root = Path(root).resolve(strict=True)
    need(isinstance(index, dict) and set(index) == {"schema", "manifests"}, "invalid index fields")
    need(index["schema"] == SCHEMA, "unknown index schema")
    entries = index["manifests"]
    need(isinstance(entries, list) and bool(entries), "empty manifest list")
    seen = set()
    results = []
    unique_sources = set()
    for entry in entries:
        need(isinstance(entry, dict) and set(entry) == {"path", "sha256", "source_root", "snapshots"},
             "invalid manifest entry")
        name = relative(entry["path"]).as_posix()
        need(name not in seen, "duplicate manifest")
        seen.add(name)
        prefix = entry["source_root"]
        need(prefix == "." or relative(prefix).as_posix() == prefix, "invalid source root")
        snapshots = entry["snapshots"]
        need(isinstance(snapshots, dict), "invalid snapshot mappings")
        for old, new in snapshots.items():
            relative(old)
            relative(new)
            need(old != new, "snapshot must name a distinct retained source")
        raw = read(root, name)
        need(digest(raw) == hash_value(entry["sha256"]), f"changed manifest: {name}")
        manifest = load(raw)
        need(isinstance(manifest, dict), "invalid manifest object")
        if "schema" in manifest:
            need(manifest["schema"] in ("glass.research-evidence/v1", "glass.immutable-research-evidence/v1"),
                 "unknown evidence manifest schema")
            hashes = manifest["sha256"]
        else:
            hashes = manifest
        need(isinstance(hashes, dict) and bool(hashes), "empty manifest sources")
        used = set()
        live = historical = total = 0
        for source, expected in hashes.items():
            relative(source)
            expected = hash_value(expected)
            original = (PurePosixPath(prefix) / source).as_posix() if prefix != "." else source
            actual = snapshots.get(original, original)
            if original in snapshots:
                used.add(original)
                historical += 1
            else:
                live += 1
            data = read(root, actual)
            need(digest(data) == expected, f"changed source: {original} (read {actual})")
            total += len(data)
            unique_sources.add((actual, expected))
        need(used == set(snapshots), "unused snapshot mapping")
        results.append({"path": name, "manifest_sha256": digest(raw), "files": len(hashes),
                        "live_paths": live, "historical_paths": historical, "bytes": total})
    return {"schema": "glass.historical-evidence-replay/v1", "manifests": results,
            "manifest_count": len(results), "file_references": sum(r["files"] for r in results),
            "historical_references": sum(r["historical_paths"] for r in results),
            "unique_source_versions": len(unique_sources),
            "note": "Explicit historical byte-integrity replay only; not timing, safety or championship acceptance."}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("index", type=Path)
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[1])
    args = parser.parse_args()
    raw = args.index.read_bytes()
    result = validate(args.root, load(raw))
    result["index_sha256"] = digest(raw)
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
