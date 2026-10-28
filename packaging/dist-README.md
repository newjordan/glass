# glass @VERSION@ for Linux @ARCH@

glass is a terminal that draws in its own GPU window. It takes in the
graphics dialects programs already speak (APC graphics, sixel, OSC 1337
inline images, CSI u keys, OSC 8 links, tmux passthrough) and its own
dialect of layers, glows, particles, lit 3D scenes and glTF models.

https://github.com/newjordan/glass

## Install

The installer puts this release in `~/.local/glass` and links
`~/.local/bin/glass`, with the desktop entry and icons in `~/.local/share`:

    curl -fsSL https://github.com/newjordan/glass/releases/latest/download/install.sh | sh

To install this tree by hand instead, copy it into a prefix:

    cp -r bin share ~/.local/

## Run

    glass                       # your shell
    glass -e htop               # a command
    glass --class my.app --title T --working-directory ~/src --hold -e make

glass needs a Wayland or X11 desktop and a Vulkan driver (Mesa's radv,
anv or nvk, or NVIDIA's). The binary needs glibc 2.31 or newer; it loads
libvulkan, libwayland-client, libxkbcommon and libX11 at run time, and
uses fontconfig's `fc-match` to find fonts. The clipboard goes through
`wl-copy`/`wl-paste` on Wayland and `xclip` on X11.

## Default terminal

With `xdg-terminal-exec`, put `glass.desktop` first in
`~/.config/xdg-terminals.list`.

## Files

- `bin/glass`: the terminal
- `share/applications/glass.desktop`, `share/icons/hicolor/`: desktop entry and icons
- `LICENSE`: glass's licence (MIT)
- `THIRD_PARTY.md`: every crate built into the binary, its licence and the licence texts
- `CHANGELOG.md`: what changed in each release
