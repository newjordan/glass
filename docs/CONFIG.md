# Configuration

glass reads one settings file, `glass.conf`, then the `GLASS_*` environment
variables, which override it. There is nothing else to configure: no
other file is read.

## Where the file is

| | Path |
| --- | --- |
| Default | `$XDG_CONFIG_HOME/glass/glass.conf` |
| When `XDG_CONFIG_HOME` is unset (or not an absolute path) | `~/.config/glass/glass.conf` |
| When `GLASS_CONFIG` is set | the file it names |

- **First launch.** If the file does not exist, glass writes it with every
  setting at its default, ready to edit. Delete it to start again from the
  defaults.
- **Moving from an earlier build.** Builds before 0.1.0 kept the file in
  `~/.angelX/glass.conf`. If the new file does not exist and the old one
  does, glass copies the old one to the new path once, says so on stderr,
  and reads it there from then on. (If the copy fails, it reads the old
  file where it is.) The old file is left in place. This does not happen
  when `GLASS_CONFIG` names a file.
- **Reload.** The file is read at launch; open a new window to see a change.

## The format

```conf
# one setting a line: the key, white space, the value
font_family Berkeley Mono
font_size 13
background_opacity 0.92
background_image ~/Pictures/wall.png
background_image_layout cscaled
background_tint 0.6
```

- A line starting with `#` is a comment; blank lines are skipped.
- The value is the rest of the line, trimmed, so a family name may have
  spaces.
- An unknown key is ignored. A value glass cannot read leaves that setting
  at its default; a number out of range is clamped into it.
- Only the first 1 MiB of the file is read.

## Settings

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `font_family` | text | `monospace` | A fontconfig family name, or the path to a font file. The bold, italic and bold-italic faces are looked up in the same family. |
| `font_size` | points, 1–256 | `13` | Text size, in points at 96 dpi and scale 1. |
| `window_padding_width` | points, ≥ 0 | `0` | Space around the grid, in points like the font size. Only the first number on the line is used. At most 512 logical pixels. |
| `background_opacity` | 0–1 | `1` | Opacity of the default background (needs a compositor that blends). Cells with a background colour of their own stay opaque. |
| `foreground` | colour | `#d0d0d0` | Default text colour. |
| `background` | colour | `#000000` | Default background colour. |
| `cursor` | colour | `#ffffff` | Cursor colour. |
| `cursor_text_color` | colour | `#000000` | Colour of the character under a block cursor. |
| `color0` … `color15` | colour | see below | The 16 ANSI colours. |
| `background_image` | path, or `none` | `none` | A PNG drawn under everything, at most 8192 pixels a side. `~/` is your home; a relative path is relative to the directory `glass.conf` is in. |
| `background_image_layout` | `tiled`, `mirror-tiled`, `scaled`, `clamped`, `centered`, `cscaled` | `tiled` | How the image fills the window: repeated, repeated with every other copy mirrored, stretched to the window, drawn once from the top left with its edge pixels stretched past it, drawn once in the middle at its own size, or scaled to cover the window keeping its shape and cropped. |
| `background_tint` | 0–1 | `0` | How far the image is faded toward the background colour, so text stays readable: `0` shows the image as it is, `1` hides it. |
| `background_image_linear` | `yes`, `no` | `no` | Smooth scaling for the image instead of nearest pixels. |
| `braille` | `dots`, `pixels` | `dots` | How braille characters are drawn: round dots with space between them, as a braille font draws them, or each dot filling its eighth of the cell, so braille art reads as a 2×4 pixel grid. |
| `text_gamma` | 0.3–3 | `1` | The coverage curve for text. Above 1 thins light-on-dark strokes; below 1 thickens them. |

Colours are `#rrggbb` or `#rgb`.

The default ANSI colours:

| | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `color0`–`color7` | `#000000` | `#cd3131` | `#0dbc79` | `#e5e510` | `#2472c8` | `#bc3fbc` | `#11a8cd` | `#e5e5e5` |
| `color8`–`color15` | `#666666` | `#f14c4c` | `#23d18b` | `#f5f543` | `#3b8eea` | `#d670d6` | `#29b8db` | `#ffffff` |

## Command line

```text
glass [--title T] [--class C] [--working-directory D] [--hold] [-e|--] [command [args...]]
```

| Flag | Meaning |
| --- | --- |
| `-e`, `--` | The rest of the line is the command to run. A bare command (`glass htop`) works too. Without one, glass runs `$SHELL` (`/bin/bash` if that is unset). |
| `--title T`, `-T T` | The window title. Default: the command's name, or `glass`. Programs can change it (OSC 0/2). |
| `--class C`, `--app-id C` | The Wayland app id and X11 class, for window rules. Default: `glass`. |
| `--working-directory D`, `--dir D`, `-d D` | Where the command starts. Default: the directory glass was started in, else your home. |
| `--hold` | Keep the window open after the command exits, until a key is pressed. |

These follow the `xdg-terminal-exec` convention, so glass can be a
desktop's default terminal through a `.desktop` entry with
`X-TerminalArgExec=-e`, `X-TerminalArgAppId=--class`,
`X-TerminalArgTitle=--title`, `X-TerminalArgDir=--working-directory` and
`X-TerminalArgHold=--hold`.

## Keys and mouse

| | |
| --- | --- |
| Ctrl+Shift+C, Ctrl+Insert | Copy the selection |
| Ctrl+Shift+V, Shift+Insert | Paste: bracketed when the program asks for it, with any escape character in the text removed |
| Ctrl+Shift+= / Ctrl+Shift+− | Text bigger / smaller |
| Ctrl+Shift+0, Ctrl+Shift+Backspace | Text back to `font_size` |
| Shift+PageUp / Shift+PageDown | Page through the scrollback (on the main screen) |
| Mouse wheel | Scroll back; in a full-screen program without mouse reporting (`less`, `man`), the wheel sends arrow keys |
| Drag | Select. Hold Shift to select when the program has asked for the mouse. |
| Ctrl+click | Open a link (OSC 8, or a URL in the text) with `xdg-open`. Only `http`, `https`, `file` and `mailto` links open. |

Copy and paste use `wl-copy`/`wl-paste` on Wayland and `xclip` on X11.
Programs can set the clipboard with OSC 52; they cannot read it.

## Environment glass sets for the program

| Variable | Value |
| --- | --- |
| `TERM` | `xterm-256color` |
| `COLORTERM` | `truecolor` |
| `TERM_PROGRAM` | `glass` |
| `TERM_PROGRAM_VERSION` | glass's version |

Variables another terminal set, when glass is started from inside one, are
removed so they don't tell the program it runs somewhere it doesn't:
`KITTY_*`, `ALACRITTY_*`, `GHOSTTY_*`, `WEZTERM_*`, `KONSOLE_*`,
`WINDOWID`, `TERMINFO`, `VTE_VERSION`, `TMUX`, `TMUX_PANE` and `STY`.
Programs learn what glass takes in by asking it (DA1, XTVERSION, the glass
dialect's `hello`).

## Environment variables

Every variable is `GLASS_<NAME>`. The `ANGEL_GLASS_<NAME>` spelling that
builds before 0.1.0 read still works; when both are set, `GLASS_` wins. In
the Settings table, an empty value counts as unset.

### Settings

These override `glass.conf` for one launch.

| Variable | Overrides | Value |
| --- | --- | --- |
| `GLASS_CONFIG` | the file's location | a path |
| `GLASS_FONT` | `font_family` | a family name or font file |
| `GLASS_FONT_SIZE` | `font_size` | points, 1–256 |
| `GLASS_PADDING` | `window_padding_width` | **logical pixels** (not points), 0–512 |
| `GLASS_OPACITY` | `background_opacity` | 0–1 |
| `GLASS_WALLPAPER` | `background_image` | a path (`~/` expands; relative to the current directory), or `none` |
| `GLASS_TEXT_GAMMA` | `text_gamma` | 0.3–3 |
| `GLASS_BRAILLE` | `braille` | `dots` or `pixels` |
| `GLASS_SIZE` | the window's first size | `COLSxROWS`, default `160x48`. A tiling compositor gives the window its own size anyway. |
| `GLASS_APP_ID` | the window's app id | For programs that use the window crate as a library. The `glass` terminal sets its own from `--class`, so this has no effect on it. |

### Speed and the GPU

| Variable | Default | Meaning |
| --- | --- | --- |
| `GLASS_AFFINITY` | `auto` | `off` (or `0`, `no`, `false`) leaves the pty read and parse threads to the scheduler. With `auto`, on a CPU whose L3 caches differ in size (AMD's X3D parts) they are kept on the CPUs of the largest; elsewhere nothing is done. See [PERFORMANCE.md](PERFORMANCE.md#plain-ascii-and-the-cpus-cache). |
| `GLASS_STARTUP_TRACE` | off | `1` prints each step of startup on stderr: milliseconds since `main`, the wall clock in nanoseconds, the thread and the step. |
| `GLASS_GPU` | the system's choice | `low` asks for the low-power GPU, `high` for the high-performance one. |
| `GLASS_PRESENT` | `mailbox` | The present mode: `mailbox`, `immediate` or `fifo`. Without the one asked for, glass falls back through mailbox, immediate and fifo, and says so on stderr; `fifo` is used only when asked for, or when nothing else is available. |
| `GLASS_FRAME_LATENCY` | `1` | Frames in flight, 1–4. One keeps key latency low; the knob is for latency experiments. |
| `GLASS_POST` | on | `0` turns off the renderer's post pass (bloom, vignette, grain and dither) where it runs. |
| `GLASS_GPU_PREMULTIPLY` | off | `1` premultiplies uploaded pictures' alpha in the shader instead of on the CPU. |

### Recording and capture

| Variable | Default | Meaning |
| --- | --- | --- |
| `GLASS_RECORD` | off | A path (`film.mp4`): the window films itself as it is drawn, through ffmpeg. A frame the window was too slow for is repeated, not caught up; the counts are printed when the film closes. Needs `ffmpeg` on `PATH`. |
| `GLASS_RECORD_FPS` | `60` | Frames a second, 1–240. |
| `GLASS_RECORD_SECONDS` | `30` | How long, 1–3600. |
| `GLASS_RECORD_DELAY_MS` | `2000` | The wait before the first frame. |
| `GLASS_RECORD_CODEC` | `hevc_nvenc` | The ffmpeg encoder. NVENC takes the RGBA as it is and converts on the GPU; another encoder (`libx264`) converts on the CPU. |
| `GLASS_SHOT` | off | A path (`shot.png`): save one frame after a delay. |
| `GLASS_SHOT_DELAY_MS` | `5000` | The delay. |
| `GLASS_SHOT_CLOSE` | off | `1` closes the window half a second after the shot. |
| `GLASS_FILM` | off | A directory: after `GLASS_FILM_DELAY_MS` (8000), writes the window's opening transition there as PNG frames at 30 a second. A development aid; the terminal does not play that transition. |
| `GLASS_TRANSITION` | on | `0` skips the window's opening transition. The `glass` terminal always skips it. |

### Measurement

| Variable | Meaning |
| --- | --- |
| `GLASS_STATS` | `1` prints frame times on stderr every two seconds: percentiles, the mean and worst of each part of a frame (build, acquire, submit, present), and how long keys took to reach a presented frame. |
| `GLASS_STATS_RAW` | With `GLASS_STATS`, a file each two-second batch of frame times is appended to, in milliseconds, one JSON array a line. |
| `GLASS_PROBE` | `1` runs the latency probe: once `GLASS_PROBE_READY` is on screen, it types `GLASS_PROBE_TEXT` one key at a time through the window's own keyboard path and times each key until a presented frame shows it. |
| `GLASS_PROBE_READY` | The text to wait for (default `Write a message`; set it to something your prompt shows). |
| `GLASS_PROBE_TEXT` | What to type (default `snappy-input-0123456789-abcdef`). |
| `GLASS_PROBE_OUT` | A file for the results. |
| `GLASS_PROBE_ENTER` | `1` presses Enter after the text. |
| `GLASS_PROBE_CLOSE` | `1` closes the window when done. |

### Tests only

`GLASS_BENCH_SCALE`, `GLASS_BENCH_READ`, `GLASS_BENCH_ONLY`,
`GLASS_BENCH_READS`, `GLASS_BENCH_READ_ONLY`, `GLASS_BENCH_ROUNDS`,
`GLASS_BENCH_AHEAD`, `GLASS_BENCH_PTY` and `GLASS_BENCH_SLOW` steer the
headless parse benchmark in `crates/term/src/speed.rs`, which runs only
under `cargo test` (`-- --ignored`). The `glass` binary never reads them.

### The examples

`glass_mindseye` reads `MINDSEYE_ASSETS` (the glTF figures for
`--surreal`, not in the repository), `MINDSEYE_BENCH` (the scoreboard its
board draws) and `MINDSEYE_SKIP` (pieces to leave out, to see what each
costs). `glass_sampler` reads `SAMPLER_DUMP` (a directory to write its
stills into).
