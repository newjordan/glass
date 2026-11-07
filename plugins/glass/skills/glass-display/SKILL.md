---
name: glass-display
description: Render hardware-confirmed charts, images, text pages, 3D scenes, glTF models, video frames, and overlays in a session-bound Glass terminal, with honest text/file fallback.
version: 1.0.0
---

# Glass Visual Terminal Display Skill

Use the `glass` toolset when the user wants to render visual output in a [Glass](https://github.com/newjordan/glass) terminal or inspect Glass capabilities.

## Core Rules (Honest Confirmation)

1. **Tool output is not a display.** Never claim a chart, image, page, 3D scene, model, video frame, or overlay is visible on screen unless the tool result has both `"rendered": true` and `"confirmed": true`.
2. **Automatic Fallback.** When no Glass terminal is bound or the terminal does not answer the `hello` probe (e.g. a standard terminal answers `DA1` first), `glass_show` and `glass_image` return `"rendered": false` along with a plain-text chart (`"text"`) and/or a local file (`"artifact_path"` with `"artifact_role": "fallback"`). Present the text chart or fallback file path honestly without pretending a Glass panel opened.
3. **Session Isolation.** Each Hermes session claims at most one Glass slave pty (e.g. `/dev/pts/N`). Do not guess a `tty` path, never pass `/dev/ptmx`, and never attempt to write to a pty claimed by another active session.

## Tool Selection

| Goal | Tool | Key Arguments |
| --- | --- | --- |
| Bind session to a Glass pty | `glass_bind` | `tty` (`/dev/pts/N` from `tty` inside Glass) |
| Check terminal capabilities | `glass_probe` | Optional `tty` |
| Show or update a bar chart | `glass_show` | `title`, `series` (`"alpha=3, beta=8"`) |
| Show an image file | `glass_image` | `path` (`PNG`, `JPEG`, `GIF`, `WebP`, `BMP`, `PPM`) |
| Show a text page | `glass_page` | `text` (up to 256 lines x 256 cols) |
| Show a 3D mesh or stage | `glass_scene` | `mesh` (`cube`, `sphere`, `gem`, `roundcube`, etc.), `stage` (`court`), `pieces`, `finish` (`plain`, `chrome`, `mercury`), `spin` |
| Show/animate a glTF model | `glass_model` | `path` (`.glb`/`.gltf`), `play`, `clip`, `loop`, `spin`, `finish` |
| Animate active 3D scene/camera | `glass_tween` | `yaw` or `eye` (`"2.4,1.6,3.2"`), `ease`, `forever` |
| Show a video panel frame | `glass_frame` | Optional `path`, `width`, `height`, `t`, `pause` |
| Place a live visual overlay | `glass_layer` | `kind` (`glow`, `particles`, `ring`, `line`, `prim`, `solid`), `color`, `x`, `y`, `width`, `height` |
| Read showcase user events | `glass_events` | `arm` (`true`/`false`), `wait` (0 to 8s) |
| Clear session visuals | `glass_clear` | Optional `all=true` to wipe all session visuals in one `remove;all=1` op |
