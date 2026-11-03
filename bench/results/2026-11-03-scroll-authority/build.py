#!/usr/bin/env python3
"""Build an exact release test arm after restoring sources, without stale mtimes.

Cargo's mtime fingerprint may reuse a *different* previous arm after copy2/git
restores old mtimes. Touch explicit Rust inputs (no content changes), require
non-fresh receipts for their packages, and bind source/binary hashes. This is
build provenance, not correctness, benchmark accuracy, or source attestation.
The caller must exclusively own source edits and Cargo's target during a build.

Example: python3 -B bench/build-engine-arm.py --out /tmp/glass-control-test \
  --receipt-dir bench/results/my-run/build-control
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import time
import tempfile

ROOT = Path(__file__).resolve().parents[3]
# Include one input for every package whose code differs in row/parser research.
INPUTS = ("crates/alacritty-terminal/src/grid/mod.rs", "crates/alacritty-terminal/src/term/mod.rs", "crates/term/src/engine.rs", "crates/term/src/speed.rs",
          "crates/vte/src/lib.rs", "crates/vte/src/ansi.rs")
PACKAGES = {"glass", "vte", "alacritty_terminal"}


def need(ok, message):
    if not ok:
        raise ValueError(message)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def select(rows):
    """Require real recompilation, not merely one executable-bearing JSON row."""
    artifacts = [r for r in rows if r.get("reason") == "compiler-artifact"]
    for package in PACKAGES:
        found = [r for r in artifacts if r["target"]["name"] == package]
        need(len(found) == 1 and found[0].get("fresh") is False,
             f"missing/ambiguous/stale package receipt: {package}")
    tests = [r for r in artifacts if r["target"]["name"] == "glass"
             and r.get("executable") and r["profile"].get("test") is True]
    need(len(tests) == 1, "missing/ambiguous test executable")
    r = tests[0]
    need(r["profile"].get("opt_level") == "3"
         and r["profile"].get("debug_assertions") is False, "not optimized release test")
    need(any(r.get("reason") == "build-finished" and r.get("success") is True
             for r in rows), "missing successful build completion")
    return Path(r["executable"])


def publish(executable, out):
    """Stage a complete executable, then atomically link without clobbering."""
    out.parent.mkdir(parents=True, exist_ok=True)
    staged = None
    try:
        with tempfile.NamedTemporaryFile(dir=out.parent, prefix=".glass-arm-", delete=False) as target:
            staged = Path(target.name)
            with executable.open("rb") as source:
                shutil.copyfileobj(source, target)
            target.flush()
            os.fsync(target.fileno())
        staged.chmod(executable.stat().st_mode & 0o777)
        os.link(staged, out)
    finally:
        if staged is not None:
            staged.unlink(missing_ok=True)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--out", type=Path, required=True)
    p.add_argument("--receipt-dir", type=Path, required=True,
                   help="new empty directory; never overwrite earlier evidence")
    args = p.parse_args()
    out = args.out.resolve()
    need(not out.exists(), "output already exists")
    need(not args.receipt_dir.exists(), "receipt directory already exists")
    args.receipt_dir.mkdir(parents=True)
    sources = {name: sha(ROOT / name) for name in INPUTS}
    before = {}
    now = time.time_ns()
    for name in INPUTS:
        path = ROOT / name
        need(path.is_file() and not path.is_symlink(), f"invalid input: {name}")
        stat = path.stat()
        before[name] = stat.st_mtime_ns
        os.utime(path, ns=(stat.st_atime_ns, now))
    argv = ["cargo", "test", "--release", "-p", "glass-term", "--locked",
            "--no-run", "--message-format=json"]
    with (args.receipt_dir / "cargo.jsonl").open("xb") as stdout, \
         (args.receipt_dir / "cargo.log").open("xb") as stderr:
        proc = subprocess.run(argv, cwd=ROOT, stdout=stdout, stderr=stderr, timeout=900)
    need(proc.returncode == 0, f"build failed: exit {proc.returncode}")
    rows = [json.loads(line) for line in (args.receipt_dir / "cargo.jsonl").read_text().splitlines()]
    executable = select(rows)
    need(sources == {name: sha(ROOT / name) for name in INPUTS}, "sources changed during build")
    publish(executable, out)
    result = {"schema": "glass.engine-arm-build/v1", "command": argv,
              "source_sha256": sources, "previous_mtime_ns": before,
              "touched_mtime_ns": now, "executable": str(out), "sha256": sha(out),
              "note": "Content-preserving input touch and non-fresh compiler receipts; exclusive build ownership required."}
    (args.receipt_dir / "identity.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
