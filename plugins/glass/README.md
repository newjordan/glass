# Glass Display Plugin for Hermes (`glass`)

Session-scoped [Glass](https://github.com/newjordan/glass) visual terminal plugin for Hermes (`>=0.19.0`).

Renders native bar charts, images, text pages, 3D meshes and multi-piece stages, animated glTF/GLB models, video showcase frames, and live visual overlays directly in a bound Glass terminal—with hardware-confirmed placement (`rendered: true`, `confirmed: true`) and automatic plain-text/PPM file fallback when running outside Glass.

---

## Installation

Install directly from GitHub or a local checkout:

```bash
# From GitHub subdirectory
hermes plugins install newjordan/glass/plugins/glass
hermes plugins enable glass

# Or copy into your local Hermes plugins directory
mkdir -p ~/.hermes/plugins
cp -r plugins/glass ~/.hermes/plugins/glass
hermes plugins enable glass
```

Inside your Glass terminal window, expose its slave pty (or pass it once via `glass_bind`):

```bash
export GLASS_TTY="$(tty)"
```

---

## Tools (`toolset="glass"`)

| Tool | Description |
| --- | --- |
| `glass_show` | Show or update a bar chart (`title`, `series="alpha=3, beta=8"`). Always returns a plain-text chart in `text` and saves a fallback PPM at `artifact_path` if no Glass terminal is bound. |
| `glass_image` | Display a local image file (`PNG`, `JPEG`, `GIF`, `WebP`, `BMP`, `PPM` up to 750 KB) in the Glass showcase or picture layer. |
| `glass_page` | Open a scrollable text page (up to 256 lines x 256 columns) in the Glass showcase. |
| `glass_scene` | Render a 3D mesh (`cube`, `sphere`, `gem`, `roundcube`, `cone`, `cylinder`, `frustum`, `arch`, `stairs`, `rock`, `blob`, `fence`, `quad`, `plane`, `wedge`, `gable`, `hip`, `pyramid`) or parented stage (`stage="court"` or `pieces="plane;gem@0,0.6,0"`), with `finish` (`plain`, `chrome`, `mercury`) and optional `spin`. |
| `glass_model` | Upload and display a `.glb` or embedded `.gltf` model (inline up to 256 KiB; file path up to 64 MiB), with optional animation playback (`play`, `clip`, `speed`, `loop`) and `spin`. |
| `glass_tween` | Animate the active 3D scene root rotation (`yaw`) or camera position (`eye="2.4,1.6,3.2"`) with `spring`, `sine`, `linear`, `cubic`, or `bounce` easing. |
| `glass_frame` | Open a sized video panel in the Glass showcase and push an RGBA frame (from `path` or built-in color bars) with optional playhead progress `t` (`0..1`) and `pause`. |
| `glass_layer` | Place a live visual overlay (`glow`, `particles`, `ring`, `line`, `prim`, `solid`) over the terminal without removing the active chart, scene, model, or video panel. |
| `glass_events` | Arm/disarm showcase event reporting (`showcase;events=1`) and read operator events (`clicks`, `seek`, `steps`, `dismissals`, `close`). |
| `glass_bind` | Probe a slave pty (`/dev/pts/N`) with `hello` + `DA1` and bind it to the current Hermes session. |
| `glass_probe` | Probe whether a terminal pty speaks the Glass protocol and list its supported operations without claiming or drawing. |
| `glass_clear` | Remove the session's active visuals and release its terminal claim (or pass `all=true` to wipe all session visuals in one `remove;all=1` frame). |

Slash command:
```text
/glass Queue | alpha=3, beta=8
```

---

## Honest Confirmation & Fallback Contract

1. **Non-Glass Safety (`hello` + `DA1`):** Before sending any visual frame, the plugin sends `ESC _ glass;hello;r=<token> ESC \` followed by `CSI c` (`DA1`). If a standard terminal replies with `DA1` before a Glass `hello` arrives, the plugin writes nothing further and returns `rendered: false`.
2. **Confirmed Only After `OK`:** `rendered: true` and `confirmed: true` are set **only** after Glass replies `OK` for the placement token (`r=<token>`). Tool output is never treated as a display.
3. **Session Claim Isolation:** Claims are persisted in `${XDG_RUNTIME_DIR:-/tmp}/hermes-glass/claims.json` keyed by `(st_dev, st_ino)` of the slave pty. A second Hermes session cannot overwrite or clear another active session's terminal.
4. **Turn-Safe Lifecycle:** Hermes 0.19 fires `on_session_end` after every turn; the plugin retains the session's Glass claim across turns and releases/clears it only on `on_session_finalize` and `on_session_reset`.

---

## CLI & Verification

Run the standalone CLI or the 198-test verification suite (zero external dependencies):

```bash
# Run unit and scripted-transport tests
python3 plugins/glass/tests/test_glass.py

# Run the built-in scripted verification demo
python3 plugins/glass/cli.py demo

# Probe or render from the CLI against a live Glass pty
python3 plugins/glass/cli.py probe --tty /dev/pts/N
python3 plugins/glass/cli.py show --title "Queue" --series "alpha=3,beta=8" --tty /dev/pts/N
python3 plugins/glass/cli.py scene --mesh sphere --finish mercury --spin --tty /dev/pts/N
python3 plugins/glass/cli.py clear --tty /dev/pts/N
```
