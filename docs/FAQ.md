# FAQ

- [Is glass a fork of another terminal?](#is-glass-a-fork-of-another-terminal)
- [Is the 31 ms window honest?](#is-the-31-ms-window-honest)
- [How does it compare with alacritty, ghostty, foot or wezterm?](#how-does-it-compare-with-alacritty-ghostty-foot-or-wezterm)
- [Why not use kitty, ghostty or wezterm?](#why-not-use-kitty-ghostty-or-wezterm)
- [What does it run on?](#what-does-it-run-on)
- [Can a program make glass read my files?](#can-a-program-make-glass-read-my-files)
- [Does it work over ssh, and in tmux?](#does-it-work-over-ssh-and-in-tmux)
- [How does a program know it is in glass?](#how-does-a-program-know-it-is-in-glass)
- [Where are the settings?](#where-are-the-settings)

## Is glass a fork of another terminal?

No. The text engine underneath is
[`alacritty_terminal`](https://crates.io/crates/alacritty_terminal), used as
a library. The window, the renderer (wgpu), the picture store, the
keyboard handling, glass's own dialect and every adapter for the other
dialects (APC graphics, sixel, OSC 1337) are glass's own code.

## Is the 31 ms window honest?

It is when the window, with its real background, is on screen: Hyprland's
`openwindow` event, which it sends when the window's first buffer arrives,
and the same event is used for kitty (73 ms).

What makes it fast: the NVIDIA driver takes about 100 ms to open, so glass
draws the window on the CPU into shared memory first, and the window maps
then. Your shell starts as soon as the compositor has settled the window's
size, at about 40 ms. Its first output is drawn on the CPU too, with the
same fonts and colours. The GPU's first frame replaces the CPU-drawn one
when the driver is ready, with nothing visibly changing.

The number to judge by is when your prompt is on screen: **61.5 ms for
glass, 206 ms for kitty**. That's the median of 12 launches each, caught
frame by frame on a 240 Hz output.

The early frame is Wayland only. On X11 there is no early frame, and the
program starts after the GPU's first frame.

All of it, with the method: [PERFORMANCE.md](PERFORMANCE.md#when-the-prompt-appears).

## How does it compare with alacritty, ghostty, foot or wezterm?

Not measured yet, so there is no answer to give. Only kitty 0.49.2 has
been run through the harness, on one machine. Adding a terminal to
[`bench/`](../bench/README.md#add-another-terminal) is one line; if you run
it, please post the numbers, whatever they say.

## Why not use kitty, ghostty or wezterm?

Use them; they're great terminals. glass is for when you want the terminal
to be a compositor: a program can put layers, particles, lit 3D scenes,
glTF models and video around and under its text through escape codes
alone, over ssh too, and glass takes in the picture dialects other
programs already write.

## What does it run on?

| Platform | Status |
| --- | --- |
| Linux, Wayland, NVIDIA | Tested: one machine, an RTX 3090 on the proprietary driver, Hyprland on Omarchy (Arch Linux). All published numbers come from it. |
| Linux, Wayland, AMD or Intel (Mesa) | Should work through Vulkan; not tested yet. |
| Linux, X11 | Supported through winit, without the early frame; not tested for this release. |
| macOS | A Metal path exists in the renderer; not tested yet. |
| Windows | Not supported yet. |

glass needs a Vulkan driver (on Linux), fontconfig (`fc-match`) for fonts,
and `wl-copy`/`wl-paste` (Wayland) or `xclip` (X11) for the clipboard.
Prebuilt binaries are Linux x86_64.

## Can a program make glass read my files?

Yes, in three narrow ways, all of them the "file" kinds of transmission
the dialects define. Here is exactly what they do; the code is
`crates/term/src/intake/apc_graphics.rs` and
`crates/term/src/intake/glass_dialect.rs`.

**What reads a file.**

- **APC graphics, `t=f` (a file) and `t=t` (a temporary file).** The
  payload is a path. glass reads it only if all of these hold:
  - The path is made canonical first (symlinks resolved), and must not be
    under `/proc` or `/sys`, or under `/dev` other than `/dev/shm`.
  - It must be a regular file: no directories, devices, FIFOs or sockets.
    This is checked before the open, so opening a device can't have side
    effects.
  - It is opened with `O_NOFOLLOW`, and checked again through the open
    handle, so swapping the file between the check and the open is caught.
  - It is at most 64 MiB. `S` and `O` read a span of it.

  Otherwise there is no list of allowed directories: any regular file the
  user running glass can read qualifies. A relative path is resolved from
  glass's own working directory, not the program's.
- **APC graphics, `t=s` (shared memory).** The payload names a POSIX
  shared-memory object (one name, no `/` after the leading one). glass
  opens it read-only, requires a regular object of at most 64 MiB, reads
  it, then closes it and unlinks it, as the dialect specifies, after a
  failed read too.
- **glass's own dialect, `asset;t=f`.** The payload is the path of a glTF
  model. It is read under exactly the same rules as `t=f` above, and never
  deleted. A `.gltf` must carry its buffers inside it as base64 `data:`
  URIs: glass does not follow a model's external URIs, so it reads no
  other file.

**What is done with what was read.** The bytes are decoded as a picture
(PNG, JPEG, GIF, TIFF, WebP, BMP, ICO, TGA, PNM, or raw RGB/RGBA) or as a
glTF model, and drawn. They are never sent back to the program. The
program gets a reply only if it asked for one: `OK` or an error code
(`EBADF` with a reason such as "not a readable path"), and for a model
its counts (nodes, meshes, vertices and so on). So a program can learn
whether glass could read and decode a path, never what is in it. A program
running in your terminal could read the file directly anyway; the case
that matters is output you didn't write, below.

**What is deleted.** Two things, both as the dialects define them:

- After a `t=t` read, glass deletes the file, but only when its canonical
  path is inside `/tmp`, `/dev/shm` or `$TMPDIR`, its name contains
  `tty-graphics-protocol`, and the path still names the file that was
  read.
- After a `t=s` read, glass unlinks the shared-memory object it named.

**What never touches the disk.** Sixel, OSC 1337 inline images, direct
APC graphics payloads (`t=d`, the default) and every other op of glass's
own dialect carry their data inside the escape sequence. glass never
writes a file a program sends: OSC 1337 downloads (`inline=0`) are taken
in and ignored. Programs can set the clipboard with OSC 52, but glass
does not answer clipboard reads. Links (OSC 8, or URLs in the text) open
only when you Ctrl+click them, and only `http`, `https`, `file` and
`mailto` ones.

**So can `cat`-ing a file make glass read my files?** It can make glass
read and *draw* a file, under the rules above: if the file you `cat`
contains an APC `t=f` sequence naming `~/Pictures/x.png`, that picture
appears on your screen. It can't make glass send a file's contents
anywhere. It can also delete a `t=t` temporary file or a shared-memory
object as described. The same holds for a program on a remote host over
ssh: the path names a file on the machine glass runs on, and glass can't
tell a remote program from a local one. There is no setting to turn the
file and shared-memory media off yet.

glass's own reads, which program output does not steer: `glass.conf`, the
`background_image` it names, fonts (through fontconfig), and the CPU's
cache layout under `/sys/devices/system/cpu` (for
[`GLASS_AFFINITY`](CONFIG.md#speed-and-the-gpu)).

## Does it work over ssh, and in tmux?

Over ssh, yes: everything is escape codes in the byte stream, so a remote
program can use every dialect. Pictures should be sent inline (APC
graphics `t=d`, sixel, OSC 1337, or glass's dialect with `t=d`), because a
file or shared-memory transmission names something on the machine glass
runs on.

In tmux, glass takes in sequences wrapped in tmux's passthrough
(`ESC P tmux; … ESC \`) and unwraps them. tmux 3.3 and later pass them on
only with `set -g allow-passthrough on`.

## How does a program know it is in glass?

glass sets `TERM_PROGRAM=glass` and `TERM=xterm-256color`, and removes the
variables other terminals set (`KITTY_*`, `WEZTERM_*`, `TMUX` and so on)
when it is started from inside one. To know for sure, send glass's
`hello` followed by a DA1 query; if the DA1 answer comes back first,
it isn't glass:

```sh
printf '\033_glass;hello;r=1\033\\\033[c'
```

glass answers `ESC _ glass;r=1;OK;v=3,ops=… ESC \` before the DA1 answer.
See [GLASS_DIALECT.md](GLASS_DIALECT.md#discovery).

## Where are the settings?

`~/.config/glass/glass.conf` (or `$XDG_CONFIG_HOME/glass/glass.conf`),
written with the defaults on the first launch. Every key and every
`GLASS_*` variable is in [CONFIG.md](CONFIG.md).
