# glass

glass is a terminal that draws in its own GPU window. A program runs in a
pseudo-terminal, and what it writes comes in through **open intake**. glass
takes in the dialects programs already speak and **expands** them into the
window: the text grid, plus pictures, layers, particles, 3D scenes and a
showcase panel above and below it.

No dialect is the reference one. Each is an adapter that turns its own
escape sequences into one shared description of what to show:

| Dialect | What glass takes in |
| --- | --- |
| APC graphics (`ESC _ G …`) | transmit and place, every transmission medium (direct, file, temporary file, shared memory), chunking, `o=z`, z-index above and below text, source rectangles, Unicode placeholders, relative placements, animation (`a=f`, `a=a`, `a=c`), the full delete table |
| DCS sixel | sixel pictures, with raster attributes and aspect |
| OSC 1337 inline images | `File=` and the multipart form: PNG, JPEG, GIF, TIFF, WebP, BMP, ICO, TGA, PNM |
| CSI u keyboard | the progressive key flags, alongside legacy key bytes |
| OSC 8 | hyperlinks, opened with Ctrl+click |
| tmux passthrough | wrapped sequences are unwrapped and taken in |
| glass's own dialect (`ESC _ glass; …`) | layers, groups, glows, rings and lines, particles, lit primitives, 3D scenes with chrome and liquid materials, glTF 2.0 models with skinning and their animations, tweens glass plays itself, video frames, charts, models and pages in the showcase |

Pictures follow the text. They move with scroll regions and the alternate
screen, keep their place through reflow on resize, and text written over an
in-cell picture hides only the cells it covers.

The terminal engine underneath is `alacritty_terminal`.

## Build

```sh
cargo build --release -p angel-glass-term
```

The binary is `target/release/glass`. It needs a Wayland or X11 desktop with
Vulkan, Metal or DX12 (through `wgpu`).

```sh
glass                       # your shell
glass -e htop               # a command
glass --class my.app --title T --working-directory ~/src --hold -e make
```

The flags follow the `xdg-terminal-exec` convention, so glass can be a
desktop's default terminal through a `.desktop` entry with
`X-TerminalArgExec=-e`, `X-TerminalArgAppId=--class`,
`X-TerminalArgTitle=--title`, `X-TerminalArgDir=--working-directory` and
`X-TerminalArgHold=--hold`.

## See what it does

Inside a glass window:

```sh
cargo run --release -p angel-glass-term --example glass_sampler
```

The sampler walks through each dialect in under two minutes: styled text,
a sixel sunset, APC graphics with alpha, Unicode placeholders, a ray-traced
inline image and an animation. Then comes glass's own dialect: lit solids
orbiting the text, a 720-light cloud that changes shape, a tesseract, a glass
knot, an equaliser city, an orrery under the text, a chart, a video, and a
finale that stacks them. `--scene knot,orrery` plays only those scenes,
`--list` names them, and `--loop` repeats the show.
`--example glass_demo` is a shorter tour of glass's own dialect.

## Mind's eye

```sh
cargo run --release -p angel-glass-term --example glass_mindseye -- --surreal
```

A 95-second film of sacred geometry, streamed live through the pty as
escape codes: the flower of life, Metatron's cube, the Platonic solids, an
eye, a torus, up to about 9,600 layers a frame at 60 fps. `--surreal` adds
floating video cubes, balloons, pizza, Matrix rain and dancing chrome
figures; the figures are Mixamo glTF characters read from
`MINDSEYE_ASSETS`, which are not included. `MINDSEYE_BENCH` names a
scoreboard (from the bench harness) to draw as a web among the layers.

## Recording

`ANGEL_GLASS_RECORD=film.mp4` films the window as it is drawn, through
ffmpeg and the GPU's encoder (`hevc_nvenc` by default), with
`ANGEL_GLASS_RECORD_FPS`, `_SECONDS`, `_DELAY_MS` and `_CODEC`. A frame the
window was too slow for is repeated, not caught up, and the count is
printed at the end.

## Speed

On processors whose dies carry last-level caches of different sizes (AMD's
X3D parts), glass keeps its pty read and parse threads on the largest one.
`GLASS_AFFINITY=off` leaves them to the scheduler. `GLASS_STARTUP_TRACE=1`
prints where startup time goes.

## Layout

- `crates/term`: the terminal (`angel-glass-term`, binary `glass`): the engine,
  the pseudo-terminal, keys, and `src/intake/`, the dialect adapters and the
  picture store.
- `crates/glass`: the GPU window and its host API (`angel-glass`).
- `crates/gpu`: rendering (`angel-gpu`).
- `crates/stage`: layers, scenes and the shared types (`angel-stage`).
- `docs/GLASS_TERM.md`: the design, and what each part takes in.
- `docs/GLASS_DIALECT.md`: the reference for glass's own dialect, with
  `printf` examples.

## License

MIT. See [LICENSE](LICENSE).
