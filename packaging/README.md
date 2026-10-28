# Packaging and releases

How glass is built, packed, released and installed, and what each file
here does.

## Files

| File | What it is |
| --- | --- |
| `../.github/workflows/ci.yml` | CI on every push and pull request: build and test on Ubuntu, clippy, a check on Rust 1.95 (the declared `rust-version`), the tarball built, installed into an empty `HOME` with `install.sh`, run and uninstalled, and a macOS build that may fail. |
| `../.github/workflows/release.yml` | On a `v*` tag: Linux x86_64 and aarch64 binaries, packed into tarballs, in a **draft** GitHub release with `install.sh` and `SHA256SUMS`. Run by hand, it only builds the tarballs (a dry run). |
| `make-tarball.sh` | Packs a built binary as `glass-<version>-linux-<arch>.tar.gz` plus its `.sha256`. The release workflow, CI and a local build all use it. |
| `third-party.py` | Writes `THIRD_PARTY.md`: every crate built into the binary for a target, its version and licence, and the licence texts the crates ship. Reads `cargo metadata` and the crates' sources in cargo's registry. Python 3.8+, standard library only. |
| `dist-README.md` | The short README inside the tarball (`@VERSION@` and `@ARCH@` are filled in). |
| `install.sh` | The one-line installer, published with each release. |
| `glass.desktop` | The desktop entry, with the `xdg-terminal-exec` keys. |
| `icons/glass.svg` | The icon: a pane of glass with a cyan prompt lit on it, for 48 px and up. |
| `icons/glass-small.svg` | The same mark drawn on a 16 px grid, for 16 to 32 px. |
| `icons/render.sh`, `icons/png/` | Renders the PNGs (16 to 512 px) with `rsvg-convert`. Run it after changing either SVG and commit the PNGs. |
| `aur/glass-term/` | AUR package built from the release tag's source (`PKGBUILD`, `.SRCINFO`). |
| `aur/glass-term-bin/` | AUR package from the release tarballs. |
| `../CHANGELOG.md` | One section per version; the release notes are that section. |

## The tarball

```
glass-0.1.0-linux-x86_64/
  bin/glass
  share/applications/glass.desktop
  share/icons/hicolor/{16x16,24x24,32x32,48x48,64x64,128x128,256x256,512x512}/apps/glass.png
  share/icons/hicolor/scalable/apps/glass.svg
  LICENSE  THIRD_PARTY.md  README.md  CHANGELOG.md
```

The layout is a prefix, so `bin` and `share` can be copied into `~/.local`
or `/usr/local` as they are. The archive is sorted, owned by root and every
mtime is the commit's time, so the same commit and binary pack to the same
bytes.

To make one locally:

```sh
cargo build --release --locked -p glass-term
packaging/make-tarball.sh            # -> dist/glass-<version>-linux-<arch>.tar.gz
```

`GLASS_PACKAGE` names the cargo package for the version lookup (default
`glass-term`).

## How the binaries are built

- **glibc reach.** Both binaries are built inside an `ubuntu:20.04`
  container, so they need glibc 2.31 at most: Ubuntu 20.04+, Debian 11+,
  RHEL, Rocky and Alma 9+, current Fedora, openSUSE and Arch. The binary
  links only libc, libm and libgcc_s; Vulkan, Wayland, xkbcommon and X11 are
  loaded at run time, so glibc is its only floor. The workflow checks the
  newest `GLIBC_` symbol version the binary needs against `GLIBC_FLOOR` and
  fails if it is newer. The old glibc comes from the container rather than
  an old runner because GitHub is retiring the Ubuntu 22.04 runners
  (deprecated since September 2026, unsupported from April 2027), and
  20.04 runners are already gone.
- **aarch64** is built natively on GitHub's `ubuntu-24.04-arm` runner, in
  the same container. That keeps the two builds identical step for step,
  needs no cross linker or sysroot, and lets the workflow run the aarch64
  binary (`glass --help`) before packing it. The arm64 runners are
  available to private repositories too (billed as Actions minutes there,
  free once the repository is public). If they ever are not, the aarch64
  job can cross-compile from x86_64 with `gcc-aarch64-linux-gnu`, since no
  C library is linked at build time.
- **Toolchain.** Rust `stable` at the time of the tag (`RUST_TOOLCHAIN` in
  the workflow); `rustc -vV` is printed in the build log. The release
  profile is the workspace's (`lto = "thin"`, `codegen-units = 1`).
- **No cache** is used for release builds.

## Tests in CI

The runners have no GPU. The GPU tests (`crates/glass/tests/*_gpu.rs`, and
two unit tests in `crates/glass/src`) already print `no GPU adapter:
skipped` and pass when wgpu finds no adapter. CI does not rely on that
alone:

- the integration tests in `crates/glass/tests` are built but not run
  (CI runs `cargo test --lib --bins` and `--doc`);
- the two GPU unit tests are skipped by name
  (`--skip atlas_gpu_tests:: --skip it_draws_on_a_real_gpu`);
- the Vulkan loader is pointed at no driver (`VK_DRIVER_FILES`), so a GPU
  test added later without a filter skips itself instead of running on a
  software rasterizer.

No test opens a window. Clippy warnings are reported but do not fail the
job until the existing ones are cleared; then the job should use
`cargo clippy ... -- -D warnings`.

## Cutting a release

1. **Get main ready.** CI is green. The `glass-term` package's version in
   `crates/term/Cargo.toml` is the one being released (keep the four
   crates in step). `CHANGELOG.md` has a section `## X.Y.Z - YYYY-MM-DD`
   (the release workflow warns while it still says `unreleased`).
2. **Dry run (optional).** Actions → Release → Run workflow on `main`. It
   builds and checks both tarballs and keeps them as workflow artifacts;
   no release is made.
3. **Tag and push the tag.**

   ```sh
   git tag -a vX.Y.Z -m "glass X.Y.Z"
   git push origin vX.Y.Z
   ```

   The workflow checks that the tag matches the package version, builds
   both arches, checks the glibc floor, runs each binary, packs it, and
   creates a **draft** release named `glass X.Y.Z` with
   `glass-X.Y.Z-linux-x86_64.tar.gz`, `glass-X.Y.Z-linux-aarch64.tar.gz`,
   `install.sh` and `SHA256SUMS`, and the changelog section plus install
   instructions as its notes. Re-running the workflow replaces the assets
   and keeps the notes.
4. **Review the draft.** Read the notes. Check the assets the way a user
   gets them:

   ```sh
   d=$(mktemp -d)
   gh release download vX.Y.Z --repo newjordan/glass --dir "$d/download/vX.Y.Z"
   (cd "$d/download/vX.Y.Z" && sha256sum -c SHA256SUMS)
   HOME=$(mktemp -d) GLASS_RELEASES=file://$d sh "$d/download/vX.Y.Z/install.sh" --version vX.Y.Z
   ```

5. **Publish.** Press *Publish release* on the draft (or
   `gh release edit vX.Y.Z --repo newjordan/glass --draft=false`). From then
   on `releases/latest/download/install.sh` and `SHA256SUMS` are this
   release's, so the one-line installer installs it.
6. **Update the AUR.** For each of `aur/glass-term` and
   `aur/glass-term-bin`:

   ```sh
   cd packaging/aur/glass-term          # then glass-term-bin
   sed -i 's/^pkgver=.*/pkgver=X.Y.Z/; s/^pkgrel=.*/pkgrel=1/' PKGBUILD
   updpkgsums                           # fills sha256sums from the tag / the tarballs
   makepkg --printsrcinfo > .SRCINFO
   makepkg -sf                          # or a clean chroot: extra-x86_64-build
   ```

   Commit the updated files here, then copy `PKGBUILD` and `.SRCINFO` into
   the AUR's git repository for the package and push:

   ```sh
   git clone ssh://aur@aur.archlinux.org/glass-term.git /tmp/aur-glass-term
   cp PKGBUILD .SRCINFO /tmp/aur-glass-term/
   cd /tmp/aur-glass-term && git add PKGBUILD .SRCINFO && git commit -m "X.Y.Z" && git push
   ```

   The first push creates the package; it needs an AUR account with an SSH
   key. `glass-term-bin` needs the release published (step 5), since
   `updpkgsums` downloads its tarballs.

## The installer

```sh
curl -fsSL https://github.com/newjordan/glass/releases/latest/download/install.sh | sh
curl -fsSL https://github.com/newjordan/glass/releases/latest/download/install.sh | sh -s -- --version v0.1.0
curl -fsSL https://github.com/newjordan/glass/releases/latest/download/install.sh | sh -s -- --uninstall
```

It reads the release's `SHA256SUMS`, which names the tarballs and so also
says which version `latest` is (no GitHub API, no rate limit), downloads
the tarball for `uname -m`, checks its sha256, and unpacks it into
`$GLASS_INSTALL_DIR/<version>` (default `~/.local/glass`). `current` points
at that version and `~/.local/bin/glass` at `current/bin/glass`; earlier
versions are removed. The desktop entry (with `Exec` set to the full path)
and the icons go into `~/.local/share`. It prints how to make glass the
default terminal through `xdg-terminal-exec` but changes no configuration.

It removes only what it put in place: the install dir carries a
`.glass-install` marker listing the icons, the desktop entry carries
`X-Glass-Installer=install.sh`, and the link is removed only if it points
into the install dir. A desktop entry of the user's own is set aside as
`glass.desktop.before-install` and put back on `--uninstall`. An existing
`~/.local/bin/glass` that is not a link, or an install dir it did not make,
stops it.

`GLASS_RELEASES` points it at another releases URL with GitHub's layout
(`latest/download/…`, `download/vX.Y.Z/…`); `file://` and `http://` work,
which is how CI and the review step test it. `GLASS_BIN_DIR` and
`XDG_DATA_HOME` move the link and the desktop files.

## The AUR names

Checked on 2026-10-27: `glass-term` and `glass-term-bin` are free on the
AUR, and no package in the official repositories is named `glass`,
`glass-term` or `glass-term-bin`. A plain `glass` is free on the AUR too,
but `glass-git` there is an unrelated program (a frameless web browser)
that installs `/usr/bin/glass`, `glass.desktop` and a `glass` icon, so a
package named `glass` would read as that program's release package. glass
ships as `glass-term`, the name of its cargo package. Both packages
conflict with each other and with `glass-git`; `glass-term-bin` provides
`glass-term`.
