# Glass Display Plugin Installed

Render hardware-confirmed charts, images, text pages, 3D scenes, glTF models, video frames, and live overlays in a [Glass](https://github.com/newjordan/glass) terminal—with automatic text and file fallback in standard terminals.

### Quickstart

1. **Enable the plugin** (if not enabled during install):
   ```bash
   hermes plugins enable glass
   ```
2. **Bind your Glass terminal** (inside a Glass window):
   ```bash
   export GLASS_TTY="$(tty)"
   ```
   Or tell Hermes in chat: `Bind Glass to /dev/pts/N` (using the output of `tty` inside your Glass window).
3. **Try it out** in Hermes:
   - `/glass Queue | alpha=3, beta=8, gamma=5`
   - *"Show a spinning mercury sphere in Glass"*
   - *"Render a bar chart of our build times in Glass"*
