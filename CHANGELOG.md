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

### Reader correctness and measured research

- Linux: drain readable final PTY bytes before honoring a simultaneous
  `POLLHUP`; a deterministic raw-PTY regression failed before the correction
  and passes afterward.
- Return fully copied reader hand-offs before parsing the independent copy,
  allowing the existing two buffers to refill sooner. A fresh-control paired
  comparison measured about +5.1% scroll-region throughput, not a lead on every
  workload. The bounded read-ahead allowance and quiet RTT are documented in
  `bench/results/2026-11-02-early-recycle/README.md`.
- Add balanced six-order terminal comparisons with provenance and workload
  checks. Preserve rejected Unicode and third-buffer experiments rather than
  inferring a terminal win from engine microbenchmarks alone.

### Session-overhead research and regression coverage

- Reject independent opportunistic read coalescing, lazy frame-cut iteration,
  and stack-backed splitter output after full six-order terminal gates;
  preserve the selected runtime and exact executable.
- Cover queued hand-off byte order/credit return across output sizes and
  empty/adjacent/random synchronized-frame cut boundaries. Seven final
  reader/frame-gate tests pass; no universal performance claim.

### Scanner and UTF-8 regression coverage

- Test exact SIMD text masks across 16/32/64/128-byte boundaries and legal
  slice ends immediately before an inaccessible page on Linux x86-64.
- Test every Unicode scalar, encoding truncations, and malformed boundary
  forms against standard-library validation. No runtime decoder change.
- Record four measured scanner/decoder experiments. The SSE2 engine gain did
  not transfer to the full paired terminal gate; retain the selected runtime
  and executable, not a speculative all-metric performance claim.

### Open intake

### Measured research and parser regression coverage

- Test CRLF records across chunking, modes, wide/combining predecessors, REP,
  sync output, suffix retention and actual 10,000-line history recycling.
- Reject bounded bulk-CRLF scrolling and a separate feed-outline ablation after
  complete 18-round terminal comparisons each. Preserve build/source/hash/raw
  receipts; neither runtime change ships. Exact selected executable restored.

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
  as the compositor has settled the window's size, its first output is
  drawn on the CPU too (same fonts, same colours), and the GPU's first
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
startup is the median of 12 launches, caught at 240 Hz.

| | glass | kitty 0.49.2 |
| --- | --- | --- |
| First output on screen | 46.1 ms | 185 ms |
| Window on screen | 27.4 ms | 72.1 ms |
| Program running | 34.0 ms | 174 ms |
| Plain text | 490 MB/s | 326 MB/s |
| Truecolor | 253 MB/s | 91 MB/s |
| Full-screen TUI | 3,457 fps | 917 fps |
| Key press to the program, during a flood | 3.0 ms | 38.6 ms |

On macOS (M4 Pro), against Ghostty 1.4.0, glass is ahead on every measure
but wide text, which is about even; docs/PERFORMANCE.md has the table.

These are one machine's numbers, not a general claim.

### The terminal engine

- glass carries Alacritty's `alacritty_terminal` 0.26.0 as a fork in
  `crates/alacritty-terminal`, Apache-2.0 as upstream. Its README credits
  the authors and its CHANGES.md lists every change.
- It takes upstream's five fixes made since that release. Among them, a
  cell keeps at most nine combining marks, so a program can no longer
  exhaust memory by writing marks onto one cell.

### Platforms and packaging

- Linux on Wayland and X11 with Vulkan, for x86_64 and aarch64. The
  release binaries need glibc 2.31 or newer.
- macOS on Apple Silicon through Metal, from source: tested on an M4 Pro
  with macOS 26. There is no packaged macOS build yet.
- Release tarballs with the binary, a desktop entry, icons and the
  licences of every crate built in; a one-line installer
  (`install.sh`); AUR packages `glass-term` (from source) and
  `glass-term-bin` (from the release tarball).
