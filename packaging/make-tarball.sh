#!/bin/sh
# Package a built glass binary as the release tarball
#
#   glass-<version>-linux-<arch>.tar.gz
#     glass-<version>-linux-<arch>/
#       bin/glass
#       share/applications/glass.desktop
#       share/icons/hicolor/{16x16,...,512x512}/apps/glass.png
#       share/icons/hicolor/scalable/apps/glass.svg
#       LICENSE  THIRD_PARTY.md  README.md  CHANGELOG.md
#
# and its sha256 beside it. The release workflow and a local build run this
# same script; the layout is a prefix, so the tree can also be copied
# straight into ~/.local or /usr/local.
#
#   cargo build --release --locked -p glass-term
#   packaging/make-tarball.sh                     # -> dist/
#
# Options:
#   --bin PATH       the binary (default: $CARGO_TARGET_DIR or target, then
#                    [<triple>/]release/glass)
#   --target TRIPLE  the triple it was built for (default: the host's)
#   --version V      the version (default: the package's, from cargo pkgid)
#   --out DIR        where the tarball goes (default: dist)
#   --third-party F  a THIRD_PARTY.md already written (default: generate it
#                    with packaging/third-party.py, which needs python3)
#
# GLASS_PACKAGE names the cargo package (default glass-term) for the version
# lookup. SOURCE_DATE_EPOCH, when set, fixes every mtime in the tarball;
# otherwise the last commit's time is used, so a rebuild of the same commit
# gives the same archive.
set -eu

die() {
    echo "make-tarball: $*" >&2
    exit 1
}

root=$(cd "$(dirname "$0")/.." && pwd)
package=${GLASS_PACKAGE:-glass-term}
bin=
target=
version=
out=dist
third_party=

while [ $# -gt 0 ]; do
    case $1 in
        --bin) bin=${2:?--bin needs a path}; shift 2 ;;
        --target) target=${2:?--target needs a triple}; shift 2 ;;
        --version) version=${2:?--version needs a value}; shift 2 ;;
        --out) out=${2:?--out needs a directory}; shift 2 ;;
        --third-party) third_party=${2:?--third-party needs a file}; shift 2 ;;
        -h | --help) sed -n '2,/^set -eu/p' "$0" | sed '$d; s/^# \{0,1\}//'; exit 0 ;;
        *) die "unknown option $1 (see --help)" ;;
    esac
done

if [ -z "$target" ]; then
    target=$(rustc -vV | sed -n 's/^host: //p')
fi
case $target in
    x86_64-*-linux-*) arch=x86_64 ;;
    aarch64-*-linux-*) arch=aarch64 ;;
    *) die "no Linux tarball for target $target" ;;
esac

if [ -z "$bin" ]; then
    target_dir=${CARGO_TARGET_DIR:-$root/target}
    if [ -x "$target_dir/$target/release/glass" ]; then
        bin=$target_dir/$target/release/glass
    else
        bin=$target_dir/release/glass
    fi
fi
[ -x "$bin" ] || die "no binary at $bin (build it with: cargo build --release --locked -p $package)"

if [ -z "$version" ]; then
    # path+file:///.../crates/term#glass-term@0.1.0, or ...#0.1.0
    version=$(cd "$root" && cargo pkgid -p "$package" | sed 's/.*[#@]//')
fi
version=${version#v}
case $version in
    [0-9]*.[0-9]*.[0-9]*) ;;
    *) die "version '$version' is not x.y.z" ;;
esac

if [ -z "${SOURCE_DATE_EPOCH:-}" ]; then
    SOURCE_DATE_EPOCH=$(git -C "$root" log -1 --format=%ct 2>/dev/null || date +%s)
fi

name=glass-$version-linux-$arch
mkdir -p "$out"
out=$(cd "$out" && pwd)
stage=$(mktemp -d "${TMPDIR:-/tmp}/glass-tarball.XXXXXX")
trap 'rm -rf "$stage"' EXIT INT TERM
tree=$stage/$name

install -d "$tree/bin" "$tree/share/applications" "$tree/share/icons/hicolor/scalable/apps"
install -m 755 "$bin" "$tree/bin/glass"
install -m 644 "$root/packaging/glass.desktop" "$tree/share/applications/glass.desktop"
install -m 644 "$root/packaging/icons/glass.svg" "$tree/share/icons/hicolor/scalable/apps/glass.svg"
for png in "$root"/packaging/icons/png/glass-*.png; do
    size=${png##*/glass-}
    size=${size%.png}
    install -d "$tree/share/icons/hicolor/${size}x${size}/apps"
    install -m 644 "$png" "$tree/share/icons/hicolor/${size}x${size}/apps/glass.png"
done
install -m 644 "$root/LICENSE" "$tree/LICENSE"
[ -f "$root/CHANGELOG.md" ] && install -m 644 "$root/CHANGELOG.md" "$tree/CHANGELOG.md"
sed "s/@VERSION@/$version/g; s/@ARCH@/$arch/g" "$root/packaging/dist-README.md" > "$tree/README.md"
chmod 644 "$tree/README.md"

if [ -n "$third_party" ]; then
    install -m 644 "$third_party" "$tree/THIRD_PARTY.md"
else
    python3 -I "$root/packaging/third-party.py" --manifest-path "$root/Cargo.toml" \
        --target "$target" --output "$tree/THIRD_PARTY.md"
fi

tarball=$out/$name.tar.gz
# Sorted, owned by root, one mtime and no gzip timestamp: the same inputs
# give the same bytes.
(cd "$stage" && tar --sort=name --owner=0 --group=0 --numeric-owner \
    --mtime="@$SOURCE_DATE_EPOCH" --format=gnu -cf - "$name") | gzip -9n > "$tarball"
(cd "$out" && sha256sum "$name.tar.gz" > "$name.tar.gz.sha256")

echo "$tarball"
