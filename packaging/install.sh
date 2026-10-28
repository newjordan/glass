#!/bin/sh
# Install glass from its GitHub releases, for this user only.
#
#   curl -fsSL https://github.com/newjordan/glass/releases/latest/download/install.sh | sh
#   curl -fsSL https://github.com/newjordan/glass/releases/latest/download/install.sh | sh -s -- --version v0.1.0
#   sh install.sh --uninstall
#
# A release goes into $GLASS_INSTALL_DIR/<version> (default ~/.local/glass),
# `current` points at it, and ~/.local/bin/glass points at current/bin/glass.
# The desktop entry and icons go into ~/.local/share (or $XDG_DATA_HOME).
# The tarball is checked against the release's SHA256SUMS before anything is
# put in place, and nothing outside those places is touched.
#
# Options:
#   --version vX.Y.Z   install that release instead of the latest
#   --uninstall        remove what this script installed
#   -h, --help         this text
#
# Environment:
#   GLASS_INSTALL_DIR  where releases go (default ~/.local/glass)
#   GLASS_BIN_DIR      where the glass link goes (default ~/.local/bin)
#   XDG_DATA_HOME      where the desktop entry and icons go (default ~/.local/share)
#   GLASS_RELEASES     the releases URL (default https://github.com/newjordan/glass/releases);
#                      file:// and http:// work too, for a mirror or a test
set -eu

[ -n "${HOME:-}" ] || { echo "glass: HOME is not set" >&2; exit 1; }
releases=${GLASS_RELEASES:-https://github.com/newjordan/glass/releases}
releases=${releases%/}
install_dir=${GLASS_INSTALL_DIR:-$HOME/.local/glass}
bin_dir=${GLASS_BIN_DIR:-$HOME/.local/bin}
data_dir=${XDG_DATA_HOME:-$HOME/.local/share}
# Written into the install dir and the desktop entry, so --uninstall only
# removes what this script put there.
marker=.glass-install
desktop_key=X-Glass-Installer

say() {
    printf 'glass: %s\n' "$*"
}

die() {
    printf 'glass: %s\n' "$*" >&2
    exit 1
}

usage() {
    # Piped into sh, $0 is the shell, not this file.
    if [ -f "$0" ] && grep -q '^# Install glass from its GitHub releases' "$0"; then
        sed -n '2,/^set -eu/p' "$0" | sed '$d; s/^# \{0,1\}//'
    else
        echo "usage: install.sh [--version vX.Y.Z] [--uninstall]"
    fi
}

# Refuse an install dir that is not one of ours to delete into.
check_install_dir() {
    case $install_dir in
        "" | / | "$HOME" | "$HOME/" | "$HOME/.local" | "$HOME/.local/") die "GLASS_INSTALL_DIR=$install_dir is too broad" ;;
        /*) ;;
        *) die "GLASS_INSTALL_DIR must be an absolute path (got $install_dir)" ;;
    esac
}

fetch() { # url file
    case $1 in
        file://*) cp "${1#file://}" "$2" ;;
        https://*)
            if command -v curl >/dev/null 2>&1; then
                curl --proto '=https' --proto-redir '=https' --tlsv1.2 -fsSL --retry 3 -o "$2" "$1"
            elif command -v wget >/dev/null 2>&1; then
                wget -q --https-only -O "$2" "$1"
            else
                die "needs curl or wget"
            fi
            ;;
        *)
            # A plain-http mirror (GLASS_RELEASES), e.g. for a local test.
            if command -v curl >/dev/null 2>&1; then
                curl -fsSL --retry 3 -o "$2" "$1"
            elif command -v wget >/dev/null 2>&1; then
                wget -q -O "$2" "$1"
            else
                die "needs curl or wget"
            fi
            ;;
    esac
}

sha256_of() { # file
    if command -v sha256sum >/dev/null 2>&1; then
        sha256sum "$1" | cut -d ' ' -f 1
    elif command -v shasum >/dev/null 2>&1; then
        shasum -a 256 "$1" | cut -d ' ' -f 1
    elif command -v openssl >/dev/null 2>&1; then
        openssl dgst -sha256 -r "$1" | cut -d ' ' -f 1
    else
        die "needs sha256sum, shasum or openssl to check the download"
    fi
}

refresh_caches() {
    if command -v update-desktop-database >/dev/null 2>&1; then
        update-desktop-database -q "$data_dir/applications" 2>/dev/null || true
    fi
    if command -v gtk-update-icon-cache >/dev/null 2>&1 && [ -f "$data_dir/icons/hicolor/index.theme" ]; then
        gtk-update-icon-cache -q -t "$data_dir/icons/hicolor" 2>/dev/null || true
    fi
}

uninstall() {
    check_install_dir
    removed=0
    link=$bin_dir/glass
    if [ -L "$link" ]; then
        case $(readlink "$link") in
            "$install_dir"/*) rm -f "$link"; say "removed $link"; removed=1 ;;
            *) say "left $link: it does not point into $install_dir" ;;
        esac
    fi
    entry=$data_dir/applications/glass.desktop
    if [ -f "$entry" ]; then
        if grep -q "^$desktop_key=" "$entry"; then
            rm -f "$entry"
            say "removed $entry"
            removed=1
            if [ -f "$entry.before-install" ]; then
                mv "$entry.before-install" "$entry"
                say "put back your own $entry"
            fi
        else
            say "left $entry: this installer did not write it"
        fi
    fi
    if [ -f "$install_dir/$marker" ]; then
        while IFS= read -r icon; do
            case $icon in
                "$data_dir"/icons/*) rm -f "$icon" ;;
            esac
        done < "$install_dir/$marker"
        rm -rf "$install_dir"
        say "removed $install_dir and its icons"
        removed=1
    elif [ -e "$install_dir" ]; then
        say "left $install_dir: it has no $marker, so this installer did not make it"
    fi
    refresh_caches
    [ "$removed" = 1 ] || say "nothing to remove"
}

install_release() {
    check_install_dir
    case $(uname -s) in
        Linux) ;;
        Darwin) die "there is no macOS build yet; build from source: https://github.com/newjordan/glass#build" ;;
        *) die "there are Linux builds only (this is $(uname -s))" ;;
    esac
    case $(uname -m) in
        x86_64 | amd64) arch=x86_64 ;;
        aarch64 | arm64) arch=aarch64 ;;
        *) die "there is no build for $(uname -m); build from source: https://github.com/newjordan/glass#build" ;;
    esac

    if [ -e "$bin_dir/glass" ] && [ ! -L "$bin_dir/glass" ]; then
        die "$bin_dir/glass exists and is not a link; move it aside and run this again"
    fi
    if [ -d "$install_dir" ] && [ ! -f "$install_dir/$marker" ] && [ -n "$(ls -A "$install_dir")" ]; then
        die "$install_dir has files this installer did not put there; set GLASS_INSTALL_DIR to another place"
    fi

    if [ -n "$want" ]; then
        base=$releases/download/v${want#v}
    else
        base=$releases/latest/download
    fi

    tmp=$(mktemp -d "${TMPDIR:-/tmp}/glass-install.XXXXXX")
    trap 'rm -rf "$tmp"' EXIT INT TERM

    # The sums name the tarballs, so they also say which version "latest" is.
    fetch "$base/SHA256SUMS" "$tmp/SHA256SUMS" || die "could not download $base/SHA256SUMS"
    line=$(grep -E "^[0-9a-f]{64} [ *]?glass-[0-9]+\\.[0-9]+\\.[0-9]+([-+][0-9A-Za-z.-]+)?-linux-$arch\\.tar\\.gz\$" "$tmp/SHA256SUMS" | head -n 1)
    [ -n "$line" ] || die "the release at $base has no tarball for linux-$arch"
    sum=${line%% *}
    file=${line##* }
    file=${file#\*}
    version=${file#glass-}
    version=${version%-linux-"$arch".tar.gz}

    say "downloading glass $version for linux-$arch"
    fetch "$base/$file" "$tmp/$file" || die "could not download $base/$file"
    got=$(sha256_of "$tmp/$file")
    [ "$got" = "$sum" ] || die "checksum mismatch for $file: expected $sum, got $got"
    say "checksum ok ($sum)"

    tar -xzf "$tmp/$file" -C "$tmp"
    tree=$tmp/glass-$version-linux-$arch
    [ -x "$tree/bin/glass" ] || die "$file has no bin/glass"

    # The new version is unpacked beside the old one and `current` is
    # pointed at it; a running glass keeps its open files until it exits.
    mkdir -p "$install_dir"
    [ -f "$install_dir/$marker" ] || : > "$install_dir/$marker"
    rm -rf "${install_dir:?}/${version:?}.new"
    mv "$tree" "$install_dir/$version.new"
    rm -rf "${install_dir:?}/${version:?}"
    mv "$install_dir/$version.new" "$install_dir/$version"
    ln -sfn "$version" "$install_dir/current"
    # Earlier versions are no longer pointed at.
    for old in "$install_dir"/*; do
        [ -d "$old" ] && [ ! -L "$old" ] && [ -x "$old/bin/glass" ] || continue
        case ${old##*/} in
            "$version") continue ;;
            [0-9]*.[0-9]*.[0-9]*) rm -rf "$old"; say "removed the earlier ${old##*/}" ;;
        esac
    done

    mkdir -p "$bin_dir"
    ln -sfn "$install_dir/current/bin/glass" "$bin_dir/glass"

    # Desktop entry, with the binary's full path so a desktop session whose
    # PATH lacks $bin_dir still finds it.
    mkdir -p "$data_dir/applications"
    sed -e "s|^Exec=glass\$|Exec=$bin_dir/glass|" -e "s|^TryExec=glass\$|TryExec=$bin_dir/glass|" \
        "$install_dir/current/share/applications/glass.desktop" > "$tmp/glass.desktop"
    echo "$desktop_key=install.sh" >> "$tmp/glass.desktop"
    entry=$data_dir/applications/glass.desktop
    if [ -f "$entry" ] && ! grep -q "^$desktop_key=" "$entry"; then
        mv "$entry" "$entry.before-install"
        say "kept your own $entry as $entry.before-install"
    fi
    mv "$tmp/glass.desktop" "$entry"

    # Icons, each recorded in the marker so --uninstall removes exactly them.
    : > "$install_dir/$marker"
    (cd "$install_dir/current/share/icons" && find . -type f) | while IFS= read -r icon; do
        icon=${icon#./}
        mkdir -p "$data_dir/icons/${icon%/*}"
        cp "$install_dir/current/share/icons/$icon" "$data_dir/icons/$icon"
        echo "$data_dir/icons/$icon" >> "$install_dir/$marker"
    done
    refresh_caches

    say "installed glass $version in $install_dir/$version"
    say "  $bin_dir/glass -> $install_dir/current/bin/glass"
    say "  $data_dir/applications/glass.desktop"
    case :${PATH:-}: in
        *:"$bin_dir":*) ;;
        *) say "$bin_dir is not on your PATH; add it, e.g. in ~/.profile:"
           say "  export PATH=\"$bin_dir:\$PATH\"" ;;
    esac
    list=${XDG_CONFIG_HOME:-$HOME/.config}/xdg-terminals.list
    cat <<EOF

To make glass the default terminal where the desktop launches terminals
through xdg-terminal-exec, put glass.desktop on the first line of
$list. With no such file yet:

    mkdir -p "${list%/*}" && echo glass.desktop > "$list"

To remove glass, run this script again with --uninstall:

    curl -fsSL $releases/latest/download/install.sh | sh -s -- --uninstall
EOF
}

want=
action=install
while [ $# -gt 0 ]; do
    case $1 in
        --version) want=${2:-}; [ -n "$want" ] || die "--version needs a value, like v0.1.0"; shift 2 ;;
        --version=*) want=${1#--version=}; shift ;;
        --uninstall) action=uninstall; shift ;;
        -h | --help) usage; exit 0 ;;
        *) die "unknown option $1 (try --help)" ;;
    esac
done

case $action in
    install) install_release ;;
    uninstall) uninstall ;;
esac
