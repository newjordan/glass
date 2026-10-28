# Changelog

All notable changes to glass are recorded here. Versions follow
[Semantic Versioning](https://semver.org/).

## 0.1.0 - unreleased

The first release. glass is a terminal that draws in its own GPU window
(wgpu on Vulkan, winit, with `alacritty_terminal` as the terminal engine).
A program runs in a pseudo-terminal, and what it writes comes in through
**open intake**: glass takes in the dialects programs already speak and
**expands** them into the window as text, pictures, layers and 3D scenes.
No dialect is the reference one; each is an adapter onto one shared
description of what to show.

### Open intake

- APC graphics (`ESC _ G …`): transmit and place over every transmission
  medium (direct, file, temporary file, shared memory), chunking, `o=z`
  compression, z-index above and below text, source rectangles, Unicode
  placeholders, relative placements, animation (`a=f`, `a=a`, `a=c`) and
  the full delete table.
- DCS sixel, with raster attributes and aspect.
- OSC 1337 inline images, `File=` and the multipart form: PNG, JPEG, GIF,
  TIFF, WebP, BMP, ICO, TGA and PNM.
- CSI u keyboard: the progressive key flags, alongside legacy key bytes.
- OSC 8 hyperlinks, opened with Ctrl+click (`http`, `https`, `file` and
  `mailto` only).
- tmux passthrough: wrapped sequences are unwrapped and taken in.
- Pictures follow the text: they move with scroll regions and the
  alternate screen, keep their place through reflow on resize, and text
  written over an in-cell picture hides only the cells it covers.

### glass's own dialect

`ESC _ glass; …` (reference: `docs/GLASS_DIALECT.md`):

- layers and groups, glows, ring and line strokes, particles;
- lit primitives and 3D scenes, with chrome and liquid materials;
- glTF 2.0 models with skinning and their animations;
- tweens that glass plays itself;
- video frames, charts, and a showcase panel above and below the text.

### The window

- The early window: on Wayland the window is on screen before the GPU is
  open. Its background (colour, image and tint) is drawn on the CPU into
  shared memory as soon as the window exists, the program starts as soon
  as the compositor has settled the window's size, and the GPU's first
  frame takes over when the driver is ready.
- On processors whose dies carry last-level caches of different sizes
  (AMD's X3D parts), the pty read and parse threads stay on the largest
  one; `GLASS_AFFINITY=off` leaves them to the scheduler.
- `GLASS_RECORD=film.mp4` films the window as it is drawn, through ffmpeg
  and the GPU's encoder.
- Command-line flags follow the `xdg-terminal-exec` convention: `-e`,
  `--title`, `--class`, `--working-directory` and `--hold`.
- Settings live in `$XDG_CONFIG_HOME/glass/glass.conf`; glass's
  environment variables are named `GLASS_*`.

### Speed

Measured against kitty 0.49.2 on one machine (Ryzen 9 9950X3D, RTX 3090,
Hyprland), both in the same 154×39 window. Throughput workloads are timed
until the terminal answers DA1, as the median of five interleaved rounds;
startup is the median of 16 launches.

| | glass | kitty 0.49.2 |
| --- | --- | --- |
| Window on screen | 31 ms | 73 ms |
| Program running | 39.5 ms | 193 ms |
| Plain text | 497 MB/s | 314 MB/s |
| Full-screen TUI | 2,673 fps | 902 fps |

These are one machine's numbers, not a general claim.

### Platforms and packaging

- Linux on Wayland and X11 with Vulkan, for x86_64 and aarch64. The
  release binaries need glibc 2.31 or newer.
- A Metal path for macOS exists but is untested; there is no macOS build.
- Release tarballs with the binary, a desktop entry, icons and the
  licences of every crate built in; a one-line installer
  (`install.sh`); AUR packages `glass-term` (from source) and
  `glass-term-bin` (from the release tarball).
