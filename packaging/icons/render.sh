#!/bin/sh
# Render glass's icon to the PNG sizes the hicolor theme uses.
# glass-small.svg is drawn on a 16 px grid for 16-32 px; glass.svg is the
# full mark (glow, sheen) for 48 px and up. Needs rsvg-convert (librsvg).
#
#   packaging/icons/render.sh        # writes packaging/icons/png/glass-<size>.png
set -eu

here=$(cd "$(dirname "$0")" && pwd)
out="$here/png"
mkdir -p "$out"

for size in 16 24 32 48 64 128 256 512; do
    if [ "$size" -le 32 ]; then
        src="$here/glass-small.svg"
    else
        src="$here/glass.svg"
    fi
    rsvg-convert --width "$size" --height "$size" --format png \
        --output "$out/glass-$size.png" "$src"
    echo "$out/glass-$size.png"
done
