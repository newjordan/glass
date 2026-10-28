#!/usr/bin/env python3
"""Write THIRD_PARTY.md: every crate built into the glass binary, its
version and licence, and the licence texts the crates ship.

The crate list is the normal (not dev, not build) dependency graph of the
package that owns the `glass` binary, for one target, as `cargo metadata`
resolves it from Cargo.lock. The texts are read from the crates' sources
in cargo's registry (fetched by the build, or by `cargo fetch`). Texts that
differ only in spacing are written once, with every crate that ships
them. Python 3.8 or later, standard library only.

    packaging/third-party.py                      # host target, ./THIRD_PARTY.md
    packaging/third-party.py --target aarch64-unknown-linux-gnu -o dist/THIRD_PARTY.md
"""

import argparse
import hashlib
import json
import os
import re
import subprocess
import sys

LICENCE_FILE = re.compile(r"^(licen[cs]e|copying|copyright|notice|unlicense|authors)([-._].*)?$", re.IGNORECASE)


def run(cmd):
    return subprocess.run(cmd, check=True, stdout=subprocess.PIPE, universal_newlines=True).stdout


def host_target():
    for line in run(["rustc", "-vV"]).splitlines():
        if line.startswith("host: "):
            return line[len("host: "):].strip()
    sys.exit("third-party: rustc -vV names no host")


def licence_files(package):
    """The licence texts a crate ships: files at its root named like a
    licence, then any under LICENSES/ (REUSE), then `license-file`."""
    root = os.path.dirname(package["manifest_path"])
    found = []
    try:
        names = sorted(os.listdir(root))
    except OSError:
        return found
    for name in names:
        path = os.path.join(root, name)
        if LICENCE_FILE.match(name) and os.path.isfile(path):
            found.append(path)
    reuse = os.path.join(root, "LICENSES")
    if os.path.isdir(reuse):
        found.extend(os.path.join(reuse, n) for n in sorted(os.listdir(reuse)))
    named = package.get("license_file")
    if named:
        path = os.path.normpath(os.path.join(root, named))
        if os.path.isfile(path) and path not in found:
            found.append(path)
    # AUTHORS files are kept only beside a licence, never alone.
    if all(os.path.basename(p).lower().startswith("authors") for p in found):
        return []
    return found


def read_text(path):
    with open(path, "rb") as f:
        data = f.read()
    return data.decode("utf-8", errors="replace").replace("\r\n", "\n").strip("\n") + "\n"


def fence(text):
    ticks = "```"
    while ticks in text:
        ticks += "`"
    return ticks


def main():
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("--manifest-path", default=None, help="the workspace's Cargo.toml (default: cargo's search from here)")
    parser.add_argument("--bin", default="glass", help="the binary whose package is the root (default: glass)")
    parser.add_argument("--target", default=None, help="target triple (default: the host's)")
    parser.add_argument("-o", "--output", default="THIRD_PARTY.md", help="where to write (default: ./THIRD_PARTY.md)")
    args = parser.parse_args()

    target = args.target or host_target()
    cmd = ["cargo", "metadata", "--format-version", "1", "--locked", "--filter-platform", target]
    if args.manifest_path:
        cmd += ["--manifest-path", args.manifest_path]
    meta = json.loads(run(cmd))

    packages = {p["id"]: p for p in meta["packages"]}
    members = set(meta["workspace_members"])
    roots = [
        pid for pid in members
        if any(t["name"] == args.bin and "bin" in t["kind"] for t in packages[pid]["targets"])
    ]
    if len(roots) != 1:
        sys.exit("third-party: expected one workspace package with a `%s` binary, found %d" % (args.bin, len(roots)))
    root = roots[0]

    # Walk normal dependencies only: dev-dependencies are never built into
    # the binary and build-dependencies run at build time only.
    nodes = {n["id"]: n for n in meta["resolve"]["nodes"]}
    seen, stack = set(), [root]
    while stack:
        pid = stack.pop()
        if pid in seen:
            continue
        seen.add(pid)
        for dep in nodes[pid]["deps"]:
            if any(k["kind"] is None for k in dep["dep_kinds"]):
                stack.append(dep["pkg"])

    crates = sorted((packages[pid] for pid in seen if pid not in members), key=lambda p: (p["name"], p["version"]))
    version = packages[root]["version"]

    texts = {}  # sha256 -> (text, [(crate label, file name)])
    order = []
    missing = []
    for p in crates:
        label = "%s %s" % (p["name"], p["version"])
        files = licence_files(p)
        if not files:
            missing.append(p)
        for path in files:
            text = read_text(path)
            # Texts that differ only in spacing or line wrapping are one text.
            key = hashlib.sha256(" ".join(text.split()).encode("utf-8")).hexdigest()
            if key not in texts:
                texts[key] = (text, [])
                order.append(key)
            texts[key][1].append((label, os.path.basename(path)))

    out = []
    w = out.append
    w("# Third-party licences\n")
    w("glass %s is released under the MIT licence (see LICENSE). The `glass` binary for "
      "`%s` is built from the %d crates below, as Cargo.lock pins them. Each crate's "
      "licence is the SPDX expression its Cargo.toml declares; the texts the crates ship "
      "follow the table.\n" % (version, target, len(crates)))
    w("Generated by `packaging/third-party.py` from `cargo metadata`; do not edit by hand.\n")
    w("| Crate | Version | Licence | Source |")
    w("| --- | --- | --- | --- |")
    for p in crates:
        licence = p.get("license") or ("see %s" % p["license_file"] if p.get("license_file") else "unspecified")
        source = p.get("repository") or p.get("homepage") or "https://crates.io/crates/%s" % p["name"]
        w("| %s | %s | %s | %s |" % (p["name"], p["version"], licence.replace("|", "\\|"), source))
    w("")
    if missing:
        w("## Crates that ship no licence file\n")
        w("These crates declare their licence in Cargo.toml but carry no licence text in their "
          "published source. The standard texts are at https://spdx.org/licenses/.\n")
        for p in missing:
            w("- %s %s: %s" % (p["name"], p["version"], p.get("license") or "unspecified"))
        w("")
    w("## Licence texts\n")
    for key in order:
        text, shipped = texts[key]
        names = ", ".join("%s (%s)" % (label, name) for label, name in shipped)
        ticks = fence(text)
        more = "" if len(shipped) == 1 else " and %d more" % (len(shipped) - 1)
        w("### %s%s\n" % (shipped[0][0], more))
        w("Shipped by: %s\n" % names)
        w(ticks + "text")
        out.append(text.rstrip("\n"))
        w(ticks + "\n")

    directory = os.path.dirname(os.path.abspath(args.output))
    os.makedirs(directory, exist_ok=True)
    with open(args.output, "w", encoding="utf-8") as f:
        f.write("\n".join(out))
    print("third-party: %d crates, %d distinct licence texts, %d without one -> %s"
          % (len(crates), len(order), len(missing), args.output), file=sys.stderr)


if __name__ == "__main__":
    main()
