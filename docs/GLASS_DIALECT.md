# glass's own dialect, version 2

This is the reference for programs that want more than any picture
dialect can say. glass takes in pictures through every common dialect;
this one lets a program speak to glass directly and reach what the
window itself can draw: layers of every kind, groups replaced whole
per frame, particles, lit primitives, a placed 3D scene, and the
showcase (a picture, a video, a chart, a model or a page). It is one more
dialect glass takes in, alongside the others.

Other terminals ignore unknown APC strings, so a program can send these
blind. `hello` lets it ask first and know.

## Framing

```
ESC _ glass ; <op> [; <key>=<value>]... [; <payload>] ESC \
```

- `ESC _` is APC (`0x1b 0x5f`); `ESC \` (ST, `0x1b 0x5c`) or BEL
  (`0x07`) terminates, as for other APC strings.
- The body starts `glass;` and is pure ASCII until the payload.
- Fields sit behind `;`. Each key field is one `key=value`; a value may
  hold commas (`at=2,1,4,2`), so never split a value on commas.
- The payload, when the op takes one (`picture`, `group`, `scene`,
  `frame`, `chart`, `model`, `page`), is the last field: base64
  (standard alphabet, padded or not). The payload ops always carry keys
  before it, so a last field that parses as a `key=value` is a key, and
  a payload is recognised by shape: it holds no `=`, or its `=` is only
  base64 padding at the very end.
- Every key, the reply token `r=` included, goes before the payload:
  `picture;id=1;f=32;s=2;v=2;r=7;<payload>`, never `...;<payload>;r=7`.
- Ids are chosen by the program. Each program's ids live in this
  session's own space. A program id is any `u32` below 2^30.

### printf, in bash

```bash
# hello, with a reply token
printf '\033_glass;hello;r=1\033\\'

# one red glow, two cells wide, under the text
printf '\033_glass;layer;id=7;k=glow;c=ff0000;at=2,1,4,2\033\\'

# a raw RGB picture, 2x1 pixels
printf '\033_glass;picture;id=1;f=24;s=2;v=1;%s\033\\' "$(printf '\xff\x00\x00\x00\xff\x00' | base64)"

# replace a whole group in one go: here two layers
printf '\033_glass;group;g=1;n=2;r=2;%s\033\\' "$(printf 'layer;id=1;k=solid;c=ff0000;at=0,0,1,1\nlayer;id=2;k=solid;c=00ff00;at=1,1,1,1' | base64 -w0)"
```

## Discovery

```
ESC _ glass ; hello ESC \
```

is answered

```
ESC _ glass ; r=<token> ; OK ; v=2,ops=hello,picture,layer,group,remove,showcase,scene,frame,chart,model,page,progress ESC \
```

A program sends `hello` (with `r=`) then DA1 (`CSI c`). If the DA1
answer comes first with no hello answer before it, the terminal is not
glass: stop and draw plain. Replies go out in stream order with every
other reply, through `pump`.

## Id ranges

| who | ids |
| --- | --- |
| program ids (this dialect) | `0`..`2^30-1` |
| this dialect's window picture ids | `2^30`..`2^31-1` (program id + 2^30) |
| this dialect's window layer ids | `2^30`..`2^31-1` (program id + 2^30) |
| the store's minted ids, the intake's client ids and everything else | below `2^30` |

A program id is mapped by `+ 2^30` into a window id that cannot meet
the intake's picture group ids or anything else glass draws. `remove
id=a-b` spans program ids.

## picture

Upload a picture under a program id. The payload is base64 of the
picture bytes.

| key | type | range | default | meaning |
| --- | --- | --- | --- | --- |
| `id` | u32 | 0..2^30 | — | the program id to upload under |
| `f` | 100\|32\|24 | 100, 32, 24 | 32 | PNG (100), RGBA (32) or RGB (24) |
| `s` | u32 | 0..4096 | 0 | width in pixels, for `f=32`/`24` |
| `v` | u32 | 0..4096 | 0 | height in pixels, for `f=32`/`24` |
| `o` | `z` | `z` | — | zlib-compressed payload (as the APC graphics dialect) |
| `m` | 0\|1 | 0, 1 | 0 | `1` on every piece but the last of a chunked transmission |
| `r` | token | ascii | — | reply token; without it the op is silent |

Chunking follows the APC graphics dialect's own rule: `m=1` on every
piece but the last, the first piece's keys govern, and only the last
piece answers. A payload-less continuation writes its last field empty
(`picture;id=9;m=0;`). Decoding runs through the APC graphics
adapter's own loader, under its caps (4096 px per side, 64 MiB) and the
store's budget.

Reuploading under an id replaces that picture.

 Replies: `OK`, or `EINVAL` (bad keys, id out of range, format the
loader refuses), `EBADF` (payload not base64), `EFBIG` (past the
budget), `ENOMEM` (budget full).

## layer

Create or replace one layer by `id`.

| key | type | range | default | meaning |
| --- | --- | --- | --- | --- |
| `id` | u32 | 0..2^30 | — | the program id; reusing it replaces the layer |
| `k` | solid\|picture\|part\|glow\|particles\|prim | | solid | the kind |
| `z` | i32 | −2^15..2^15 | 0 | depth; negative sits under the text |
| `o` | f32 | 0..1 | 1 | opacity; outside the range is an error, not a clamp |
| `a` | f32 | radians | 0 | angle |
| `h` | f32 | 0..8192 cells | 0 | lift height (how far the layer rides above its stand) |
| `b` | f32 | 0..8192 cells | 0 | breathe amplitude |
| `add` | 0\|1 | | 0 | additive blend |
| `fl` | f32 | 0..1 | 0 | flicker amount |
| `stand` | floor\|up\|screen | | floor | how it stands: floor, upright at `up=`, or screen |
| `up` | x,y | cells | 0,0 | the upright foot, for `stand=up` |
| `at` | x,y,w,h | cells, fractions allowed | — | placement in cells, anchored to the text (default) |
| `px` | x,y,w,h | pixels | — | placement in window pixels, always pinned to the window |
| `anchor` | window | | text | `anchor=window` pins an `at=` placement to the window |
| `c` | rrggbb or rrggbbaa | hex | ffffff | colour, straight RGBA in 0..1 |
| `p` | u32 | a picture id | — | picture program id, for `k=picture`/`part` |
| `src` | x,y,w,h | pixels | — | source rect, for `k=part` |
| `n` | u16 | 1..4096 | 64 | mote count, for `k=particles` |
| `size` | f32 | 0.5..64 px | 3 | mote size |
| `life` | f32 | 0.05..600 s | 2 | mote life |
| `rise` | f32 | −8192..8192 px/s | 20 | rise speed |
| `sway` | f32 | −8192..8192 px | 8 | sway width |
| `seed` | u32 | | 0 | mote seed |
| `burst` | f32 | | — | burst, once, when given |
| `shape` | 0..6 | | 0 | lit primitive shape, for `k=prim` |
| `speed` | f32 | | 1 | primitive speed |
| `phase` | f32 | radians | 0 | primitive phase |
| `r` | token | | — | reply token |

Every kind: `k=solid` (a colour block), `k=picture` (a whole uploaded
picture, `p=`), `k=part` (a source rect of one, `p=` + `src=`),
`k=glow` (a soft light), `k=particles` (an emitter), `k=prim` (a lit
primitive).

`at=` is anchored to the text: it scrolls with the text exactly as
intake pictures do, using the same anchor maths in the store, on the
screen it was placed on. The anchor is the cursor's absolute line at
placement time; `at=`'s row counts from there. `anchor=window` pins
it. `px=` places it in window pixels, always pinned.

Bash:

```bash
# a glow under some text, additive
printf '\033_glass;layer;id=1;k=glow;c=8844ccff;add=1;at=0,0,80,3\033\\'

# particles
printf '\033_glass;layer;id=2;k=particles;c=ffd080;n=120;size=2;life=3;rise=30;sway=12;at=0,20,80,4\033\\'

# a lit primitive
printf '\033_glass;layer;id=3;k=prim;shape=3;c=4060ff;at=30,8,20,10\033\\'

# window-pinned, in pixels
printf '\033_glass;layer;id=4;k=solid;c=000000;o=0.5;px=0,0,1920,32\033\\'
```

## group

Replace a whole set of layers in one go, for per-frame animation. The
payload is `n` layer records, newline-separated, in the same key syntax
as `layer`, base64-encoded.

| key | type | range | default | meaning |
| --- | --- | --- | --- | --- |
| `g` | u32 | | — | the group id |
| `n` | u32 | 0..65536 | — | how many records the payload holds |
| `r` | token | | — | reply token |

A group of up to the stage's layer limit (65536) must not stall the
reader; the measured time for 10 000 layers is printed by the test
(`a_group_replaces_whole_and_ten_thousand_layers_settle_fast`): parse
about 4 ms, with the frame about 6 ms, on the CI machine. Replacing a
group id does not add: it replaces whole.

Bash, animating a glow:

```bash
g=1
while true; do
  for t in $(seq 0 49); do
    y=$(( t / 5 ))
    printf '\033_glass;group;g=1;n=1;%s\033\\' \
      "$(printf 'layer;id=1;k=glow;c=ff8800;at=10,%d,8,2' "$y" | base64 -w0)"
    sleep 0.033
  done
done
```

## remove

| key | type | range | default | meaning |
| --- | --- | --- | --- | --- |
| `id` | u32 or `a-b` | 0..2^30 | — | one layer or scene, or a span of program ids |
| `g` | u32 | | — | one group |
| `all` | 0\|1 | | — | `1` removes everything this dialect made |
| `r` | token | | — | reply token |

```bash
printf '\033_glass;remove;id=3\033\\'
printf '\033_glass;remove;id=10-19\033\\'
printf '\033_glass;remove;g=1\033\\'
printf '\033_glass;remove;all=1\033\\'
```

## showcase

Open the showcase on an uploaded picture, or open a video panel of a
pixel size. The panel opens and changes only when this request changes,
never once per frame. Frames and progress ride beside it.

| key | type | range | default | meaning |
| --- | --- | --- | --- | --- |
| `id` | u32 | an uploaded picture id | — | open on that picture |
| `s` | u32 | 1..=2048 | — | video panel width, with `v` |
| `v` | u32 | 1..=2048 | — | video panel height, with `s` |
| `fit` | contain\|width | | contain | how the panel fits |
| `events` | 0\|1 | | 0 | `1` opts into showcase events |
| `close` | 0\|1 | | — | `1` closes the showcase |
| `r` | token | | — | reply token |

`id` and `s`/`v` are alternatives. `events=1` may travel alone or with
either. Closing does not clear the opt-in; `events=0` or a reset does.
Sending the same video size and fit again does not reopen the panel.

```bash
printf '\033_glass;showcase;id=5\033\\'
printf '\033_glass;showcase;s=160;v=90;fit=width;events=1\033\\'
printf '\033_glass;showcase;close=1\033\\'
```

## scene

A 3D scene as data. The payload is base64 of a versioned JSON envelope.
The window draws it into a picture of `s` by `v` pixels and places that
picture the way a layer is placed. `remove id=` covers the scene as
well as a layer of the same program id. A text-anchored scene leaves
with its text, the same way a layer does.

| key | type | range | default | meaning |
| --- | --- | --- | --- | --- |
| `id` | u32 | 0..2^30 | required | program id; also the picture id |
| `at` | four numbers | finite, width and height > 0 | — | cells, anchored to text |
| `px` | four numbers | finite, width and height > 0 | — | window pixels, pinned |
| `anchor` | text\|window | | text | `window` pins an `at` placement |
| `s` | u32 | 1..=2048 | required | render width, pixels |
| `v` | u32 | 1..=2048 | required | render height, pixels |
| `z` | i32 | | 1 | layer order |
| `o` | number | 0..=1 | 1 | opacity |
| `r` | token | | — | reply token |

The envelope is pinned so the window's internal types can change behind
it. Unknown fields are errors. Every number must be finite.

```json
{"v":1,"scene":{"camera":{...},"nodes":[...]}}
```

| field | type | range | default |
| --- | --- | --- | --- |
| `v` | number | 1 | required |
| `scene` | object | | required |
| `scene.camera` | object | | the defaults below |
| `scene.camera.eye` | [number, number, number] | finite | [0, 0, 3] |
| `scene.camera.target` | [number, number, number] | finite, not the eye | [0, 0, 0] |
| `scene.camera.up` | [number, number, number] | finite, not parallel to the view | [0, 1, 0] |
| `scene.camera.fov` | number | (0, pi) radians | pi/4 |
| `scene.camera.near` | number | > 0 | 0.1 |
| `scene.camera.far` | number | > near | 100 |
| `scene.camera.clear` | [number x4] or null | each 0..=1; null draws over | [0, 0, 0, 0] |
| `scene.camera.ortho` | number | > 0; present selects orthographic | absent (perspective) |
| `scene.nodes` | array | at most 256 | [] |
| `scene.nodes[].id` | number | integer, unique | required |
| `scene.nodes[].parent` | number or null | an earlier node id | null |
| `scene.nodes[].at` | [number x3] | finite | [0, 0, 0] |
| `scene.nodes[].rot` | [number x4] | finite quaternion, not all zero | [0, 0, 0, 1] |
| `scene.nodes[].scale` | [number x3] | finite | [1, 1, 1] |
| `scene.nodes[].mesh` | string or object | see below | none |
| `scene.nodes[].color` | [number x4] | each 0..=1 | [1, 1, 1, 1] |
| `scene.nodes[].visible` | bool | | true |
| `scene.nodes[].lit` | bool | | false |
| `scene.nodes[].emissive` | number | 0..=1 | 0 |

A mesh string is one of `quad`, `cube`, `plane`, `gem`, `wedge`,
`gable`, `hip`, `pyramid`. A mesh object has `kind`:

| kind | fields | range | default |
| --- | --- | --- | --- |
| sphere, cone, cylinder, frustum, arch | `segments` | 3..=64 | 16 |
| stairs | `steps` | 1..=64 | 8 |
| rock, blob | `seed` | 0..=65535 | 1 |
| fence | `posts` | 2..=64 | 4 |
| inline | `positions`, `indices`, optional `normals`, `uvs`, `colors` | see caps | — |

Inline `positions` are `[x,y,z]` triples, `indices` a triangle list,
`normals` triples, `uvs` pairs, `colors` `[r,g,b,a]`. Across one
envelope, at most 4096 vertices and 12288 indices. A missing parent or
a parent cycle is an error. The decoded payload is at most 1 MiB.

```bash
printf '\033_glass;scene;id=1;px=40,40,160,120;s=160;v=120;%s\033\\' \
  "$(printf '%s' '{"v":1,"scene":{"nodes":[{"id":1,"mesh":"cube","color":[0.85,0.45,0.2,1]}]}}' | base64 -w0)"
printf '\033_glass;remove;id=1\033\\'
```

## frame

One video frame for an open video showcase (`showcase` with `s` and
`v`). A picture upload or raw RGBA, chunked the way `picture` is
(`m=1` on every piece but the last). `id` names an already uploaded
picture instead of a payload. A frame does not reopen the showcase.

| key | type | range | default | meaning |
| --- | --- | --- | --- | --- |
| `id` | u32 | an uploaded picture id | — | use that picture's pixels |
| `f` | 100\|32\|24 | | 32 | payload format, as `picture` |
| `s` | u32 | 1..=2048 | 0 | raw width |
| `v` | u32 | 1..=2048 | 0 | raw height |
| `o` | z or empty | | empty | `z` is zlib |
| `m` | 0\|1 | | 0 | more pieces follow |
| `r` | token | | — | reply token; on a chunked frame, the first piece's |

```bash
printf '\033_glass;showcase;s=8;v=4\033\\'
printf '\033_glass;frame;f=32;s=2;v=1;%s\033\\' "$(printf '\xff\x00\x00\xff\x00\xff\x00\xff' | base64 -w0)"
printf '\033_glass;frame;id=5\033\\'
```

## progress

Playback position and pause. This does not reopen the showcase.

| key | type | range | default | meaning |
| --- | --- | --- | --- | --- |
| `t` | number | 0..=1 | — | position; omit to leave it unset |
| `pause` | 0\|1 | | 0 if `t` is set | paused |
| `r` | token | | — | reply token |

At least one of `t` and `pause` is required.

```bash
printf '\033_glass;progress;t=0.5;pause=0\033\\'
printf '\033_glass;progress;pause=1\033\\'
```

## chart

Marks over a picture uploaded with `picture`. `p` names that picture,
and its size is the chart's size. The marks lie over it. Without `p=`
it is an error. Sending a chart opens the showcase on that picture and
those marks; the same request does not reopen it.

| key | type | range | default | meaning |
| --- | --- | --- | --- | --- |
| `p` | u32 | under `0x40000000` | required | a picture uploaded with `picture`; its size is the chart's size |
| `n` | u32 | 0..=4096 | required | record count |
| `fit` | contain\|width | | contain | how the panel fits |
| `r` | token | | — | reply token |

A mark record:

| key | type | range | default | meaning |
| --- | --- | --- | --- | --- |
| `x`,`y`,`w`,`h` | number | finite | required | the mark's rectangle, content pixels |
| `ax`,`ay` | number | finite | the rectangle's centre | where the mark is anchored |
| `t` | text | | empty | tip lines; `\|` splits lines |

```bash
printf '\033_glass;picture;id=1;f=32;s=2;v=1;%s\033\\' \
  "$(printf '\xff\x00\x00\xff\x00\xff\x00\xff' | base64 -w0)"
printf '\033_glass;chart;p=1;n=1;%s\033\\' \
  "$(printf '%s' 'mark;x=0;y=0;w=1;h=1;t=glass' | base64 -w0)"
```

## model

Scene nodes for the showcase, through the scene wire form above. The
payload is the same envelope. The camera is validated and ignored; the
nodes are shown. Inline meshes are uploaded before the panel opens.
Sending a model opens the showcase; the same nodes do not reopen it.

| key | type | range | default | meaning |
| --- | --- | --- | --- | --- |
| `s` | u32 | 1..=2048 | required | panel width |
| `v` | u32 | 1..=2048 | required | panel height |
| `fit` | contain\|width | | contain | how the panel fits |
| `r` | token | | — | reply token |

```bash
printf '\033_glass;model;s=160;v=120;%s\033\\' \
  "$(printf '%s' '{"v":1,"scene":{"nodes":[{"id":1,"mesh":"cube"}]}}' | base64 -w0)"
```

## page

Text the window rasterises as a page and shows in the showcase. The
payload is base64 UTF-8; newlines separate lines. The window pads to
`rows` and shows the raster with `fit=width`, so a tall page scrolls.
A missing font leaves the request stored and the panel unchanged.

| key | type | range | default | meaning |
| --- | --- | --- | --- | --- |
| `cols` | u32 | 1..=256 | required | page columns |
| `rows` | u32 | 1..=256 | required | page rows |
| `r` | token | | — | reply token |

The payload is at most 1 MiB.

```bash
printf '\033_glass;page;cols=24;rows=4;%s\033\\' \
  "$(printf '%s' 'a page of text' | base64 -w0)"
```

## Showcase events

What the operator does in the showcase reaches the program only when it
opted in with `showcase;events=1`. As the counters change, glass writes,
in this order, through the session's writer:

```
ESC _ glass ; event ; showcase ; <key>=<value> ESC \
```

| key | when |
| --- | --- |
| `seek` | the operator seeked; the value is the position |
| `steps` | the step counter changed |
| `copies` | the copy counter changed |
| `dismissals` | the dismissal counter changed |
| `clicks` | the click counter changed |
| `close` | the operator closed the showcase; the value is `1` |

The program sees none of these unless it opted in. A producer's own
close does not count as `close`.

## Replies

Every op answers only when the program gave `r=<token>`:

```
ESC _ glass ; r=<token> ; OK [; extra] ESC \        success
ESC _ glass ; r=<token> ; <CODE>:<message> ESC \    failure
```

Codes: `EINVAL` (unknown op, unknown key, malformed or out-of-range
value), `EBADF` (payload not base64 or not layer records), `EFBIG`
(payload past its cap), `ENOMEM` (the store's picture budget is full),
Unknown ops, unknown keys and malformed
values are errors and never panic. Every count, size and allocation is
capped before anything is allocated.

## Lifecycle

- A layer anchored to text leaves with its text: on ED 3 (history
  cleared), when it is pruned out of history, and when its screen is
  cleared (ED 2). On the alternate screen it goes when that screen is
  left.
- Window-pinned layers and scenes stay until removed, a RIS, or the program exits.
- A text-anchored scene leaves with its text, the same way a layer does.
- RIS removes everything this dialect made.
- When the child process exits, everything this dialect made is
  removed.

These ride the store's existing clear and reset operations; no new
engine events were added.

## Limits

| limit | value |
| --- | --- |
| program ids | 0..2^30−1 |
| this dialect's window layer ids | 2^30..2^31−1 |
| one `group` | at most 65536 records |
| one `group` payload | at most 1 MiB decoded |
| picture sides | at most 4096 px |
| picture budget | the store's own, shared with the intake's pictures |
| `h=`, `b=`, `rise=`, `sway=` | at most 8192 |
| `n=` (particles) | at most 4096 motes |
| scene nodes | at most 256 |
| scene vertices | at most 4096 |
| scene indices | at most 12288 |
| scene, chart, model, page payload | at most 1 MiB decoded |
| scene and showcase pixel sides | 1..=2048 |
| chart marks | at most 4096 |
| page columns and rows | 1..=256 |
| inline mesh ids | from `0xC0000000` |
