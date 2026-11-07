"""Glass dialect frames and replies.

The published framing is ``ESC _ glass ; <op> [; key=value]... ESC \\``.
A program sends ``hello`` with ``r=`` and then DA1. If the DA1 answer
comes first, the terminal is not glass and nothing is drawn.
"""

from __future__ import annotations

import base64
import json
import math
import re
from dataclasses import dataclass

APC = b"\x1b_"
ST = b"\x1b\\"
DA1 = b"\x1b[c"
_TOKEN = re.compile(r"^[A-Za-z0-9]{1,16}$")
_OPS = re.compile(r"ops=([A-Za-z0-9,]+)")
_VERSION = re.compile(r"\bv=(\d+)")

# Program ids stay below 2^30. Pictures and layers are both mapped by
# +2^30 in the window, so a layer never reuses its picture id.
PICTURE_BASE = 0x16000000
LAYER_OFFSET = 0x10000
# A picture overlay cites an uploaded picture. The layer id is not the
# picture id. 33 stays off the single overlay at 32 and the group at 40.
# 0x14000001 stays under the face ids at 0x15000000 and the chart ids.
PLATE_PICTURE = 0x14000001
PLATE_LAYER = 33
WRAP_PICTURE = 0x14000002
# A named-file overlay. 34 stays off the plate at 33, the glow at 32,
# and the group layers at 40. 0x14000003 is not the plate or the wrap.
CARD_PICTURE = 0x14000003
CARD_LAYER = 34


def token_ok(token: str) -> bool:
    return bool(_TOKEN.fullmatch(token))


def apc(body: str) -> bytes:
    if not body.isascii() or "\x1b" in body or "\x07" in body:
        raise ValueError("glass body must be ascii without a terminator")
    return APC + b"glass;" + body.encode("ascii") + ST


def hello(token: str) -> bytes:
    _check_token(token)
    return apc(f"hello;r={token}")


def picture(picture_id: int, rgb: bytes, width: int, height: int, token: str | None) -> bytes:
    _check_id(picture_id)
    if width < 1 or height < 1 or width > 4096 or height > 4096:
        raise ValueError("picture size out of range")
    if len(rgb) != width * height * 3:
        raise ValueError("rgb byte count does not match the picture size")
    payload = base64.b64encode(rgb).decode("ascii")
    keys = f"picture;id={picture_id};f=24;s={width};v={height}"
    if token is not None:
        _check_token(token)
        keys += f";r={token}"
    return apc(f"{keys};{payload}")


def showcase(picture_id: int, token: str, fit: str = "contain") -> bytes:
    _check_id(picture_id)
    _check_token(token)
    if fit not in ("contain", "width"):
        raise ValueError("fit must be contain or width")
    return apc(f"showcase;id={picture_id};fit={fit};r={token}")


def close_showcase(token: str) -> bytes:
    _check_token(token)
    return apc(f"showcase;close=1;r={token}")


def layer_picture(
    layer_id: int,
    picture_id: int,
    token: str,
    *,
    x: int = 24,
    y: int = 24,
    width: int = 480,
    height: int = 270,
) -> bytes:
    _check_id(layer_id)
    _check_id(picture_id)
    _check_token(token)
    if layer_id == picture_id:
        raise ValueError("layer id must not reuse the picture id")
    return apc(
        f"layer;id={layer_id};k=picture;p={picture_id};px={x},{y},{width},{height};r={token}"
    )


def chart(picture_id: int, marks: list[str], token: str, fit: str = "contain") -> bytes:
    """Native chart op. The payload is newline-separated mark records."""
    _check_id(picture_id)
    _check_token(token)
    if fit not in ("contain", "width"):
        raise ValueError("fit must be contain or width")
    if not marks or len(marks) > 4096:
        raise ValueError("chart needs 1 to 4096 marks")
    for record in marks:
        if not record.startswith("mark;") or "\n" in record or not record.isascii():
            raise ValueError("chart mark is not an ascii mark record")
    payload = base64.b64encode("\n".join(marks).encode("ascii")).decode("ascii")
    return apc(f"chart;p={picture_id};n={len(marks)};fit={fit};r={token};{payload}")


def page(text: str, cols: int, rows: int, token: str | None) -> bytes:
    """Page op. Glass rasterises the UTF-8 payload. cols and rows are 1..=256."""
    if cols < 1 or rows < 1 or cols > 256 or rows > 256:
        raise ValueError("page size out of range")
    raw = text.encode("utf-8")
    if len(raw) > 1 << 20:
        raise ValueError("page payload is too large")
    payload = base64.b64encode(raw).decode("ascii")
    keys = f"page;cols={cols};rows={rows}"
    if token is not None:
        _check_token(token)
        keys += f";r={token}"
    return apc(f"{keys};{payload}")


def remove(program_id: int, token: str | None = None) -> bytes:
    _check_id(program_id)
    body = f"remove;id={program_id}"
    if token is not None:
        _check_token(token)
        body += f";r={token}"
    return apc(body)


def remove_all(token: str) -> bytes:
    """One remove op. all=1. No id, no span, no group, no asset."""
    _check_token(token)
    return apc(f"remove;all=1;r={token}")


def plate_card(colors: str | None = None) -> tuple[bytes, int, int]:
    """A small RGB card for a picture overlay. The default is 4 by 2."""
    if colors in (None, ""):
        pixels = (
            "ff0000",
            "00ff00",
            "0000ff",
            "ffff00",
            "00ffff",
            "ff00ff",
            "ffffff",
            "ff8800",
        )
        return b"".join(face_rgb(item) for item in pixels), 4, 2
    parts = [part.strip() for part in str(colors).split(";") if part.strip()]
    if not 1 <= len(parts) <= 8:
        raise ValueError("colors must be 1 to 8")
    return b"".join(face_rgb(part) for part in parts), len(parts), 1


def parse_src(text: str, width: int, height: int) -> tuple[int, int, int, int]:
    parts = [part.strip() for part in str(text).split(",")]
    if len(parts) != 4:
        raise ValueError("src must be x,y,width,height")
    nums = []
    for part in parts:
        if not re.fullmatch(r"\d{1,5}", part):
            raise ValueError("src must be four picture pixels")
        nums.append(int(part))
    x, y, w, h = nums
    if w < 1 or h < 1:
        raise ValueError("src width and height must be at least 1")
    if x + w > width or y + h > height:
        raise ValueError("src is outside the picture")
    return x, y, w, h


def layer_plate(
    layer_id: int,
    picture_id: int,
    token: str,
    *,
    kind: str,
    x: int,
    y: int,
    width: int,
    height: int,
    src: tuple[int, int, int, int] | None = None,
    pin: str | None = None,
) -> bytes:
    """A picture or part overlay. Does not alter layer_picture or effect_layer."""
    _check_id(layer_id)
    _check_id(picture_id)
    _check_token(token)
    if layer_id == picture_id:
        raise ValueError("layer id must not reuse the picture id")
    name = str(kind).strip().lower()
    if name not in ("picture", "part"):
        raise ValueError("plate kind must be picture or part")
    _origin(x, "x")
    _origin(y, "y")
    _pixel(width, "width")
    _pixel(height, "height")
    if pin not in (None, "window"):
        raise ValueError("pin must be window")
    if name == "picture" and src is not None:
        raise ValueError("src is only for part")
    if name == "part" and src is None:
        raise ValueError("part needs src")
    parts = [f"layer;id={layer_id}", f"k={name}", f"p={picture_id}"]
    if name == "part":
        sx, sy, sw, sh = src
        parts.append(f"src={sx},{sy},{sw},{sh}")
    if pin == "window":
        parts.append(f"at={x},{y},{width},{height}")
        parts.append("anchor=window")
    else:
        parts.append(f"px={x},{y},{width},{height}")
    parts.append(f"r={token}")
    return apc(";".join(parts))


def layer_card(
    layer_id: int,
    picture_id: int,
    token: str,
    *,
    x: int,
    y: int,
    width: int,
    height: int,
    z: int | None = None,
    pin: str | None = None,
) -> bytes:
    """A named-image picture overlay. Does not alter layer_plate.

    ``z`` is omitted when it is missing or 0, which is this engine's default.
    """
    _check_id(layer_id)
    _check_id(picture_id)
    _check_token(token)
    if layer_id == picture_id:
        raise ValueError("layer id must not reuse the picture id")
    _origin(x, "x")
    _origin(y, "y")
    _pixel(width, "width")
    _pixel(height, "height")
    if pin not in (None, "window"):
        raise ValueError("pin must be window")
    sent_z = None
    if z is not None:
        sent_z = _count(z, "z", -32768, 32767)
        if sent_z == 0:
            sent_z = None
    parts = [f"layer;id={layer_id}", "k=picture", f"p={picture_id}"]
    if pin == "window":
        parts.append(f"at={x},{y},{width},{height}")
        parts.append("anchor=window")
    else:
        parts.append(f"px={x},{y},{width},{height}")
    if sent_z is not None:
        parts.append(f"z={sent_z}")
    parts.append(f"r={token}")
    return apc(";".join(parts))


def picture_file(picture_id: int, data: bytes, token: str) -> bytes:
    """One encoded image. Glass decodes `f=100`; this side does not."""
    _check_id(picture_id)
    _check_token(token)
    if not data or len(data) > 750_000:
        raise ValueError("image file is empty or over 750000 bytes")
    payload = base64.b64encode(data).decode("ascii")
    return apc(f"picture;id={picture_id};f=100;r={token};{payload}")


def probe_query(token: str) -> bytes:
    """``hello`` then DA1, in the order the dialect requires."""
    return hello(token) + DA1


@dataclass(frozen=True)
class Reply:
    token: str
    ok: bool
    code: str
    extra: str
    ops: tuple[str, ...]
    version: int | None


def iter_replies(buf: bytes):
    start = 0
    prefix = b"\x1b_glass;"
    while True:
        at = buf.find(prefix, start)
        if at < 0:
            return
        body_at = at + len(prefix)
        end_st = buf.find(ST, body_at)
        end_bel = buf.find(b"\x07", body_at)
        ends = [item for item in (end_st, end_bel) if item >= 0]
        if not ends:
            return
        end = min(ends)
        term = 2 if end == end_st else 1
        body = buf[body_at:end].decode("ascii", "replace")
        yield Reply(**_reply_fields(body))
        start = end + term


def find_reply(buf: bytes, token: str) -> Reply | None:
    for reply in iter_replies(buf):
        if reply.token == token:
            return reply
    # A live pty on this machine delivered `_glass;r=<token>;OK;ST` with the
    # leading ESC already gone. That is still Glass's answer. A different
    # token, or a buffer with no ST, is not a confirmation.
    bare = b"_glass;"
    start = 0
    while True:
        at = buf.find(bare, start)
        if at < 0:
            return None
        if at > 0 and buf[at - 1 : at] == b"\x1b":
            start = at + len(bare)
            continue
        body_at = at + len(bare)
        end = buf.find(b"\x1b\\", body_at)
        if end < 0:
            return None
        reply = Reply(**_reply_fields(buf[body_at:end].decode("ascii", "replace")))
        if reply.token == token:
            return reply
        start = end + 2


def da1_before_glass(buf: bytes) -> bool:
    """True when a finished DA1 answer begins before any glass APC."""
    glass_at = buf.find(b"\x1b_glass;")
    index = 0
    while True:
        csi = buf.find(b"\x1b[", index)
        if csi < 0 or (glass_at >= 0 and csi > glass_at):
            return False
        cursor = csi + 2
        while cursor < len(buf) and 0x20 <= buf[cursor] <= 0x3F:
            cursor += 1
        if cursor < len(buf) and buf[cursor] == ord("c"):
            return glass_at < 0 or csi < glass_at
        index = csi + 2


def _reply_fields(body: str) -> dict:
    fields = body.split(";")
    token = ""
    status = ""
    extra_fields: list[str] = []
    for field in fields:
        if field.startswith("r=") and not token:
            token = field[2:]
            continue
        if not status:
            status = field
            continue
        extra_fields.append(field)
    extra = ";".join(extra_fields)
    ok = status == "OK"
    code = "OK" if ok else status.split(":", 1)[0]
    ops_match = _OPS.search(extra)
    version_match = _VERSION.search(extra)
    ops = tuple(ops_match.group(1).split(",")) if ops_match else ()
    version = int(version_match.group(1)) if version_match else None
    return {
        "token": token,
        "ok": ok,
        "code": code,
        "extra": extra,
        "ops": ops,
        "version": version,
    }


def _check_token(token: str) -> None:
    if not token_ok(token):
        raise ValueError("reply token must be 1 to 16 ascii letters or digits")


def _check_id(program_id: int) -> None:
    if not isinstance(program_id, int) or isinstance(program_id, bool):
        raise ValueError("program id must be an integer")
    if program_id < 0 or program_id >= 2**30:
        raise ValueError("program id out of range")


# String meshes. "sphere" as a string is EINVAL; that shape is a kind object.
NAMED_MESHES = ("quad", "cube", "plane", "gem", "wedge", "gable", "hip", "pyramid")
KIND_MESHES = (
    "sphere",
    "cone",
    "cylinder",
    "frustum",
    "arch",
    "stairs",
    "rock",
    "blob",
    "fence",
    "roundcube",
)
MESHES = NAMED_MESHES
_SEGMENT_KINDS = ("sphere", "cone", "cylinder", "frustum", "arch")
EASES = {
    "linear": "linear",
    "spring": "spring(170,12)",
    "sine": "sine-in-out",
    "cubic": "cubic-in-out",
    "bounce": "bounce-out",
}
_ROT = re.compile(r"^-?\d+(?:\.\d+)?(?:,-?\d+(?:\.\d+)?){3}$")
_EYE = re.compile(r"^-?\d+(?:\.\d+)?(?:,-?\d+(?:\.\d+)?){2}$")


def parse_color(text: str | None) -> tuple[float, float, float, float]:
    """RRGGBB or RRGGBBAA. Empty means the orange cube this engine already accepts."""
    if text is None or str(text).strip() == "":
        return (1.0, 0.4, 0.2, 1.0)
    raw = str(text).strip().lstrip("#")
    if re.fullmatch(r"[0-9A-Fa-f]{6}", raw):
        parts = tuple(int(raw[i : i + 2], 16) / 255 for i in (0, 2, 4))
        return (parts[0], parts[1], parts[2], 1.0)
    if re.fullmatch(r"[0-9A-Fa-f]{8}", raw):
        parts = tuple(int(raw[i : i + 2], 16) / 255 for i in (0, 2, 4, 6))
        return (parts[0], parts[1], parts[2], parts[3])
    raise ValueError("color must be RRGGBB")


def scene_payload(
    mesh: str,
    color: tuple[float, float, float, float],
    *,
    lit: bool = True,
    chrome: float = 0,
    liquid: float = 0,
    segments: int | None = None,
    radius: float | None = None,
    seed: int | None = None,
    steps: int | None = None,
    posts: int | None = None,
) -> bytes:
    """One-node envelope. Node id 1 is what a later tween targets.

    A named mesh stays a string, so the orange cube frame already accepted
    on this machine does not gain fields. A shaped mesh is ``{"kind": ...}``.
    The string ``"sphere"`` is never sent.
    """
    shaped = _mesh_value(
        mesh,
        segments=segments,
        radius=radius,
        seed=seed,
        steps=steps,
        posts=posts,
    )
    chrome_amount = _amount(chrome, "chrome")
    liquid_amount = _amount(liquid, "liquid")
    if len(color) != 4:
        raise ValueError("color must be four numbers")
    node = {"id": 1, "mesh": shaped, "color": [_unit(part) for part in color], "lit": bool(lit)}
    if chrome_amount:
        node["chrome"] = chrome_amount
    if liquid_amount:
        node["liquid"] = liquid_amount
    camera = {"eye": [1.8, 1.2, 2.4], "fov": 0.9}
    if chrome_amount or liquid_amount:
        camera["clear"] = [0.0, 0.0, 0.0, 1.0]
    envelope = {"v": 1, "scene": {"camera": camera, "nodes": [node]}}
    return json.dumps(envelope, separators=(",", ":")).encode("ascii")


def parse_opacity(value) -> float:
    """Scene-op opacity. 0 to 1. Outside that range is an error, not a clamp."""
    if isinstance(value, bool) or value is None or (isinstance(value, str) and not str(value).strip()):
        raise ValueError("opacity must be a number from 0 to 1")
    try:
        amount = float(value)
    except (TypeError, ValueError) as exc:
        raise ValueError("opacity must be a number from 0 to 1") from exc
    if amount != amount or amount in (float("inf"), float("-inf")):
        raise ValueError("opacity must be a number from 0 to 1")
    amount = round(amount, 4)
    if amount < 0 or amount > 1:
        raise ValueError("opacity must be a number from 0 to 1")
    return amount


def parse_scene_z(value) -> int:
    """Scene-op depth. An i32. The engine default is 1 and is omitted when not asked."""
    if isinstance(value, bool) or value is None:
        raise ValueError("z must be an integer")
    if isinstance(value, str):
        text = value.strip()
        if not re.fullmatch(r"-?\d+", text):
            raise ValueError("z must be an integer")
        number = int(text)
    elif isinstance(value, int):
        number = value
    elif isinstance(value, float) and value == value and value == int(value):
        number = int(value)
    else:
        raise ValueError("z must be an integer")
    if number < -2147483648 or number > 2147483647:
        raise ValueError("z must be an i32")
    return number


def parse_cells(value) -> tuple[float, float, float, float]:
    """Scene cell box for `at=`. Four finite numbers. Width and height greater than 0.

    This is not `px=` and not `x=` `y=` `w=` `h=`. Those keys were refused.
    """
    if value is None or isinstance(value, bool):
        raise ValueError("at must be four numbers x,y,w,h")
    if isinstance(value, str):
        parts = [part.strip() for part in value.split(",")]
    elif isinstance(value, (list, tuple)):
        parts = list(value)
    else:
        raise ValueError("at must be four numbers x,y,w,h")
    if len(parts) != 4:
        raise ValueError("at must be four numbers x,y,w,h")
    numbers = []
    for part in parts:
        if isinstance(part, bool) or part is None:
            raise ValueError("at must be four numbers x,y,w,h")
        if isinstance(part, str):
            if not re.fullmatch(r"-?\d+(?:\.\d+)?", part):
                raise ValueError("at must be four numbers x,y,w,h")
            number = float(part)
        elif isinstance(part, (int, float)):
            number = float(part)
        else:
            raise ValueError("at must be four numbers x,y,w,h")
        if number != number or number in (float("inf"), float("-inf")):
            raise ValueError("at must be four finite numbers")
        number = round(number, 4)
        if abs(number) > 8192:
            raise ValueError("at must stay within -8192 to 8192")
        numbers.append(number)
    origin_x, origin_y, box_w, box_h = numbers
    if box_w <= 0 or box_h <= 0:
        raise ValueError("at width and height must be greater than 0")
    return origin_x, origin_y, box_w, box_h


def parse_ortho(value) -> float:
    """Orthographic half-height. Greater than 0 and at most 64. Not a fov."""
    if isinstance(value, bool) or value is None or (isinstance(value, str) and not value.strip()):
        raise ValueError("ortho must be a number greater than 0 and at most 64")
    try:
        height = float(value)
    except (TypeError, ValueError) as exc:
        raise ValueError("ortho must be a number greater than 0 and at most 64") from exc
    if height != height or height == float("inf") or height == float("-inf"):
        raise ValueError("ortho must be a number greater than 0 and at most 64")
    height = round(height, 4)
    if height <= 0 or height > 64:
        raise ValueError("ortho must be a number greater than 0 and at most 64")
    return height


def flat_payload(
    mesh: str,
    color: tuple[float, float, float, float],
    ortho: float,
) -> bytes:
    """One-node envelope whose camera is orthographic.

    ``ortho`` is the half-height in world units. ``fov`` is omitted, so this
    is not the orange cube envelope. ``scene_payload`` still sends ``fov``
    and does not send ``ortho``.
    """
    height = parse_ortho(ortho)
    body = json.loads(scene_payload(mesh, color))
    camera = body["scene"]["camera"]
    camera.pop("fov", None)
    camera["ortho"] = height
    if "fov" in camera or camera.get("ortho") != height:
        raise ValueError("flat camera must send ortho and not fov")
    return json.dumps(body, separators=(",", ":")).encode("ascii")


def _unit_part(value, name: str) -> float:
    if isinstance(value, bool):
        raise ValueError(f"{name} must be a number from 0 to 1")
    try:
        number = float(value)
    except (TypeError, ValueError) as exc:
        raise ValueError(f"{name} must be a number from 0 to 1") from exc
    if number != number or number in (float("inf"), float("-inf")):
        raise ValueError(f"{name} must be a number from 0 to 1")
    number = round(number, 4)
    if number < 0 or number > 1:
        raise ValueError(f"{name} must be a number from 0 to 1")
    return number


def parse_clear(value) -> tuple[float, float, float, float]:
    """Backdrop color. Three or four numbers, or RRGGBB / RRGGBBAA.

    rgb and alpha are 0 to 1. Empty is refused. This is not the node color.
    """
    if value is None or (isinstance(value, str) and not str(value).strip()):
        raise ValueError("clear must be a color")
    if isinstance(value, str) and "," not in value:
        return parse_color(value)
    if isinstance(value, str):
        parts = value.split(",")
    elif isinstance(value, (list, tuple)):
        parts = list(value)
    else:
        raise ValueError("clear must be a color")
    if len(parts) == 3:
        red, green, blue = (_unit_part(part, "clear") for part in parts)
        return (red, green, blue, 1.0)
    if len(parts) == 4:
        red, green, blue, alpha = (_unit_part(part, "clear") for part in parts)
        return (red, green, blue, alpha)
    raise ValueError("clear must be three or four numbers")


def parse_near(value) -> float:
    """Clip start. Greater than 0 and less than 8. The engine default is 0.05."""
    if isinstance(value, bool) or value is None or (isinstance(value, str) and not str(value).strip()):
        raise ValueError("near must be greater than 0 and less than 8")
    try:
        near = float(value)
    except (TypeError, ValueError) as exc:
        raise ValueError("near must be greater than 0 and less than 8") from exc
    if near != near or near in (float("inf"), float("-inf")):
        raise ValueError("near must be greater than 0 and less than 8")
    near = round(near, 4)
    if near <= 0 or near >= 8:
        raise ValueError("near must be greater than 0 and less than 8")
    return near


def parse_far(value, near: float | None = None) -> float:
    """Clip end. Greater than near, or 0.05 when near is omitted, and at most 256."""
    floor = 0.05 if near is None else near
    if isinstance(value, bool) or value is None or (isinstance(value, str) and not str(value).strip()):
        raise ValueError("far must be greater than near and at most 256")
    try:
        far = float(value)
    except (TypeError, ValueError) as exc:
        raise ValueError("far must be greater than near and at most 256") from exc
    if far != far or far in (float("inf"), float("-inf")):
        raise ValueError("far must be greater than near and at most 256")
    far = round(far, 4)
    if far <= floor or far > 256:
        raise ValueError("far must be greater than near and at most 256")
    return far


def parse_up(value) -> tuple[float, float, float]:
    """Camera up. Three numbers, not parallel to the default view."""
    if value is None or (isinstance(value, str) and not str(value).strip()):
        raise ValueError("up must be three numbers x,y,z")
    if isinstance(value, str):
        parts = value.split(",")
    elif isinstance(value, (list, tuple)):
        parts = list(value)
    else:
        raise ValueError("up must be three numbers x,y,z")
    if len(parts) != 3:
        raise ValueError("up must be three numbers x,y,z")
    parsed: list[float] = []
    for part in parts:
        if isinstance(part, bool) or (isinstance(part, str) and not part.strip()):
            raise ValueError("up must be three numbers x,y,z")
        try:
            number = float(part)
        except (TypeError, ValueError) as exc:
            raise ValueError("up must be three numbers x,y,z") from exc
        if number != number or number in (float("inf"), float("-inf")):
            raise ValueError("up must be three numbers x,y,z")
        parsed.append(round(number, 4))
    up = (parsed[0], parsed[1], parsed[2])
    if sum(part * part for part in up) <= 1e-8:
        raise ValueError("up must not be zero")
    forward = (-1.8, -1.2, -2.4)
    cross = (
        up[1] * forward[2] - up[2] * forward[1],
        up[2] * forward[0] - up[0] * forward[2],
        up[0] * forward[1] - up[1] * forward[0],
    )
    if sum(part * part for part in cross) <= 1e-8:
        raise ValueError("up must not be parallel to the view")
    return up


def lens_payload(
    mesh: str,
    color: tuple[float, float, float, float],
    clear: tuple[float, float, float, float] | str,
    near: float | None = None,
    far: float | None = None,
    up: tuple[float, float, float] | str | None = None,
) -> bytes:
    """One-node envelope whose camera sends a backdrop.

    clear is always sent. near, far, and up are sent only when asked. fov stays.
    ortho is not sent. scene_payload is unchanged, so the orange cube envelope
    still omits clear.
    """
    backdrop = parse_clear(clear)
    clip_near = None if near is None else parse_near(near)
    clip_far = None if far is None else parse_far(far, clip_near)
    tilt = None if up is None else parse_up(up)
    body = json.loads(scene_payload(mesh, color))
    camera = body["scene"]["camera"]
    if any(key in camera for key in ("clear", "near", "far", "up", "ortho")):
        raise ValueError("lens starts from the plain camera")
    if "fov" not in camera:
        raise ValueError("lens keeps fov")
    camera["clear"] = [backdrop[0], backdrop[1], backdrop[2], backdrop[3]]
    if clip_near is not None:
        camera["near"] = clip_near
    if clip_far is not None:
        camera["far"] = clip_far
    if tilt is not None:
        camera["up"] = [tilt[0], tilt[1], tilt[2]]
    return json.dumps(body, separators=(",", ":")).encode("ascii")


def wrap_payload(
    mesh: str,
    color: list[float] | tuple[float, float, float, float],
    picture_id: int,
    sampling: str | None = None,
) -> bytes:
    """Scene envelope whose node cites an uploaded picture.

    ``sampling`` is sent only for nearest. linear is the engine default and
    is omitted, so a wrap that does not ask for nearest does not gain that
    key. This is not the orange cube envelope.
    """
    if isinstance(picture_id, bool) or not isinstance(picture_id, int) or picture_id < 1 or picture_id >= (1 << 30):
        raise ValueError("wrap picture id is not a picture id")
    sample = None if sampling in (None, "") else str(sampling).strip().lower()
    if sample not in (None, "linear", "nearest"):
        raise ValueError("sampling is linear or nearest")
    if len(color) != 4:
        raise ValueError("color must be four numbers")
    node = {
        "id": 1,
        "mesh": _mesh_value(mesh, segments=None, radius=None, seed=None, steps=None, posts=None),
        "color": [_unit(part) for part in color],
        "lit": True,
        "picture": picture_id,
    }
    if sample == "nearest":
        node["sampling"] = "nearest"
    envelope = {
        "v": 1,
        "scene": {"camera": {"eye": [1.8, 1.2, 2.4], "fov": 0.9}, "nodes": [node]},
    }
    return json.dumps(envelope, separators=(",", ":")).encode("ascii")


FACE_PICTURE_BASE = 0x15000001
FACE_COUNT = 6
DIE_COLORS = ("ff3355", "33cc66", "3388ff", "ffcc33", "cc66ff", "f2f2f2")


def parse_face_colors(text: str | None) -> list[str | None]:
    """Six face colors. Empty uses the die preset. `none` is a null face."""
    if text is None or str(text).strip() == "":
        return list(DIE_COLORS)
    raw = str(text).strip()
    if raw.endswith(";") or ";;" in raw or any(ch in raw for ch in " \t\n\r\"'{}[]"):
        raise ValueError("faces is 1 to 6 RRGGBB colors separated by semicolons")
    parts = raw.split(";")
    if not 1 <= len(parts) <= FACE_COUNT:
        raise ValueError("faces is 1 to 6 RRGGBB colors separated by semicolons")
    colors: list[str | None] = []
    for part in parts:
        if part.lower() == "none":
            colors.append(None)
            continue
        parse_color(part)
        colors.append(part.strip().lstrip("#").lower())
    if not any(colors):
        raise ValueError("faces need at least one color")
    while len(colors) < FACE_COUNT:
        colors.append(None)
    return colors


def face_rgb(color: str) -> bytes:
    rgba = parse_color(color)
    return bytes(int(round(part * 255)) for part in rgba[:3])


def die_payload(
    mesh: str,
    colors: list[str | None],
    face_ids: list[int | None],
    *,
    radius: float | None = 0.18,
    segments: int | None = 8,
    edge_color: str | None = "f0c040",
    edge_width: int | None = None,
    edge_glow: float | None = 0.85,
) -> bytes:
    """A cube or roundcube with uploaded face pictures. Does not alter scene_payload."""
    name = str(mesh).strip().lower()
    if name not in ("cube", "roundcube"):
        raise ValueError("faces mesh must be cube or roundcube")
    if len(colors) != FACE_COUNT or len(face_ids) != FACE_COUNT:
        raise ValueError("faces need six slots")
    faces: list[int | None] = []
    for color, face in zip(colors, face_ids):
        if color is None:
            if face is not None:
                raise ValueError("a null face has no picture")
            faces.append(None)
            continue
        if not isinstance(face, int) or isinstance(face, bool):
            raise ValueError("a face picture was not accepted")
        _check_id(face)
        faces.append(face)
    if not any(item is not None for item in faces):
        raise ValueError("faces need at least one accepted picture")
    if name == "cube":
        shaped: str | dict = "cube"
    else:
        shaped = _mesh_value(
            "roundcube",
            segments=8 if segments is None else segments,
            radius=0.18 if radius is None else radius,
            seed=None,
            steps=None,
            posts=None,
        )
    node: dict = {
        "id": 1,
        "mesh": shaped,
        "color": [1.0, 1.0, 1.0, 1.0],
        "lit": True,
        "faces": faces,
    }
    # This engine's edge object is color and glow. width is an unknown key and
    # the scene comes back EINVAL, so it is not sent.
    if edge_width not in (None, 0):
        raise ValueError("this glass edge has color and glow, not width")
    glow = 0.0 if edge_glow in (None, 0, 0.0) else _amount(edge_glow, "glow")
    if glow:
        node["edge"] = {
            "color": [_unit(part) for part in parse_color(edge_color or "f0c040")],
            "glow": glow,
        }
    camera = {"eye": [1.8, 1.2, 2.4], "fov": 0.9}
    raw = json.dumps(
        {"v": 1, "scene": {"camera": camera, "nodes": [node]}},
        separators=(",", ":"),
    ).encode("ascii")
    if b'"mesh":"roundcube"' in raw or b'"mesh":"sphere"' in raw:
        raise ValueError("a shaped face mesh must be a kind object")
    return raw


MARK_SHAPES = ("chevron", "tetra")


def _pt(x: float, y: float, z: float) -> list[float]:
    return [round(float(x), 4), round(float(y), 4), round(float(z), 4)]


def _rgba(r: float, g: float, b: float, a: float = 1.0) -> list[float]:
    return [round(float(r), 4), round(float(g), 4), round(float(b), 4), round(float(a), 4)]


def _chevron_mesh() -> dict:
    """A two-wing mark. Both windings are sent so a culled side still has triangles."""
    tip = _pt(0.0, 0.62, 0.0)
    left = _pt(-0.62, -0.34, 0.0)
    inner_l = _pt(-0.16, -0.08, 0.0)
    right = _pt(0.62, -0.34, 0.0)
    inner_r = _pt(0.16, -0.08, 0.0)
    gold = _rgba(0.96, 0.78, 0.28)
    ink = _rgba(0.12, 0.10, 0.16)
    ember = _rgba(0.86, 0.42, 0.16)
    triangles = (
        ([tip, inner_l, left], [gold, ember, ink]),
        ([tip, right, inner_r], [gold, ink, ember]),
        ([tip, left, inner_l], [gold, ink, ember]),
        ([tip, inner_r, right], [gold, ember, ink]),
    )
    positions: list[list[float]] = []
    colors: list[list[float]] = []
    for verts, cols in triangles:
        positions.extend(verts)
        colors.extend(cols)
    return {
        "kind": "inline",
        "positions": positions,
        "indices": list(range(len(positions))),
        "colors": colors,
    }


def _tetra_mesh() -> dict:
    top = _pt(0.0, 0.55, 0.0)
    left = _pt(-0.48, -0.32, 0.36)
    right = _pt(0.48, -0.32, 0.36)
    back = _pt(0.0, -0.16, -0.5)
    positions = [
        top, left, right,
        top, right, back,
        top, back, left,
        left, back, right,
    ]
    return {"kind": "inline", "positions": positions, "indices": list(range(len(positions)))}


def mark_payload(
    shape: str = "chevron",
    color: tuple[float, float, float, float] | None = None,
    emissive: float = 0.4,
) -> bytes:
    """One scene whose mesh is a kind object, never the string inline."""
    name = str(shape).strip().lower()
    if name not in MARK_SHAPES:
        raise ValueError("shape must be chevron or tetra")
    mesh = _chevron_mesh() if name == "chevron" else _tetra_mesh()
    if color is None:
        tint = (1.0, 1.0, 1.0, 1.0) if name == "chevron" else (1.0, 0.72, 0.22, 1.0)
    else:
        tint = color
    node: dict = {
        "id": 1,
        "mesh": mesh,
        "color": [_unit(part) for part in tint],
        "lit": True,
    }
    glow = _amount(emissive, "emissive")
    if glow:
        node["emissive"] = glow
    raw = json.dumps(
        {"v": 1, "scene": {"camera": {"eye": [1.8, 1.2, 2.4], "fov": 0.9}, "nodes": [node]}},
        separators=(",", ":"),
    ).encode("ascii")
    if b'"mesh":"inline"' in raw:
        raise ValueError("an inline mark must be a kind object")
    if b'"kind":"inline"' not in raw:
        raise ValueError("mark mesh was not inline")
    return raw


def mark_counts(raw: bytes) -> tuple[int, int]:
    """Counts in the envelope we built. Not a count Glass reported."""
    mesh = json.loads(raw)["scene"]["nodes"][0]["mesh"]
    indices = mesh["indices"]
    if len(indices) % 3:
        raise ValueError("mark indices must be a multiple of 3")
    return len(mesh["positions"]), len(indices) // 3


# Ground, gem, and sphere inside the default camera. Later pieces parent to the first.
COURT_PIECES = "plane*3,0.08,3#1c1c24;gem@0,0.55,0#ff6633;sphere@1.05,0.42,0.35#ebf0ff"
_PIECE = re.compile(
    r"^(?P<mesh>[a-z]+)"
    r"(?:@(?P<at>-?\d+(?:\.\d+)?(?:,-?\d+(?:\.\d+)?){2}))?"
    r"(?:\*(?P<scale>\d+(?:\.\d+)?(?:,\d+(?:\.\d+)?){2}))?"
    r"(?:#(?P<color>[0-9A-Fa-f]{6}))?$"
)
_STAGE_MAX = 6
_AT_LIMIT = 3.0
_SCALE_MIN = 0.05
_SCALE_MAX = 4.0
_NODE_FIELDS = {"id", "parent", "at", "scale", "mesh", "color", "lit", "chrome", "liquid"}
_SHAPE_OF = {
    "sphere": ("segments",),
    "cone": ("segments",),
    "cylinder": ("segments",),
    "frustum": ("segments",),
    "arch": ("segments",),
    "roundcube": ("segments", "radius"),
    "stairs": ("steps",),
    "rock": ("seed",),
    "blob": ("seed",),
    "fence": ("posts",),
}


def parse_pieces(text: str) -> list[dict]:
    """mesh[@x,y,z][*sx,sy,sz][#RRGGBB], two to six, separated by semicolons."""
    raw = str(text).strip()
    if not raw or raw.endswith(";") or ";;" in raw or any(ch in raw for ch in " \t\n\r\"'{}[]"):
        raise ValueError("pieces is mesh[@x,y,z][*sx,sy,sz][#RRGGBB] separated by semicolons")
    parts = raw.split(";")
    if not 2 <= len(parts) <= _STAGE_MAX:
        raise ValueError("pieces needs 2 to 6 meshes; one mesh uses mesh=")
    parsed = []
    for part in parts:
        match = _PIECE.fullmatch(part.lower())
        if not match:
            raise ValueError("pieces is mesh[@x,y,z][*sx,sy,sz][#RRGGBB] separated by semicolons")
        name = match.group("mesh")
        if name not in NAMED_MESHES and name not in KIND_MESHES:
            raise ValueError("mesh must be one of " + ", ".join(NAMED_MESHES + KIND_MESHES))
        parsed.append(
            {
                "mesh": name,
                "at": _axis(match.group("at"), "at", -_AT_LIMIT, _AT_LIMIT) if match.group("at") else None,
                "scale": _axis(match.group("scale"), "scale", _SCALE_MIN, _SCALE_MAX) if match.group("scale") else None,
                "color": parse_color(match.group("color")) if match.group("color") else parse_color(None),
            }
        )
    return parsed


def stage_payload(
    pieces: str,
    *,
    chrome=0,
    liquid=0,
    segments=None,
    radius=None,
    seed=None,
    steps=None,
    posts=None,
    auto_segments: bool = False,
) -> bytes:
    """Parented scene. The first piece is the root. The rest parent to it.

    Chrome and liquid go on shaped pieces only. A named ground stays matte.
    """
    parsed = parse_pieces(pieces)
    chrome_amount = _amount(chrome, "chrome")
    liquid_amount = _amount(liquid, "liquid")
    if (chrome_amount or liquid_amount) and not any(item["mesh"] in KIND_MESHES for item in parsed):
        raise ValueError("finish needs a shaped mesh in the stage")
    overrides = {
        "segments": segments,
        "radius": radius,
        "seed": seed,
        "steps": steps,
        "posts": posts,
    }
    for field, value in overrides.items():
        if value is None:
            continue
        matches = [item for item in parsed if field in _SHAPE_OF.get(item["mesh"], ())]
        if len(matches) != 1:
            raise ValueError(field + " must match one piece")
        matches[0][field] = value
    if auto_segments:
        for item in parsed:
            if "segments" in _SHAPE_OF.get(item["mesh"], ()) and "segments" not in item:
                item["segments"] = 8 if item["mesh"] == "roundcube" else 48
    nodes = []
    for index, item in enumerate(parsed, start=1):
        shaped = _mesh_value(
            item["mesh"],
            segments=item.get("segments"),
            radius=item.get("radius"),
            seed=item.get("seed"),
            steps=item.get("steps"),
            posts=item.get("posts"),
        )
        node = {
            "id": index,
            "mesh": shaped,
            "color": [_unit(part) for part in item["color"]],
            "lit": True,
        }
        if index > 1:
            node["parent"] = 1
        if item["at"] and any(part != 0 for part in item["at"]):
            node["at"] = item["at"]
        if item["scale"] and any(part != 1 for part in item["scale"]):
            node["scale"] = item["scale"]
        if item["mesh"] in KIND_MESHES and chrome_amount:
            node["chrome"] = chrome_amount
        if item["mesh"] in KIND_MESHES and liquid_amount:
            node["liquid"] = liquid_amount
        if set(node) - _NODE_FIELDS:
            raise ValueError("stage node has a field this parser rejects")
        nodes.append(node)
    camera = {"eye": [1.8, 1.2, 2.4], "target": [0.0, 0.4, 0.0], "fov": 0.9}
    if any("chrome" in node or "liquid" in node for node in nodes):
        camera["clear"] = [0.0, 0.0, 0.0, 1.0]
    return json.dumps(
        {"v": 1, "scene": {"camera": camera, "nodes": nodes}},
        separators=(",", ":"),
    ).encode("ascii")


def _axis(text: str, name: str, lo: float, hi: float) -> list[float]:
    parts = text.split(",")
    if len(parts) != 3:
        raise ValueError(name + " must be three numbers")
    values = []
    for part in parts:
        value = float(part)
        if value < lo or value > hi:
            raise ValueError(f"{name} must be {lo:g} to {hi:g}")
        values.append(round(value, 4))
    return values


def asset(asset_id: int, token: str, *, data: bytes | None = None, path: str | None = None) -> bytes:
    """One glTF upload. Bytes use t=d. An absolute path uses t=f. Never both."""
    _check_asset_id(asset_id)
    _check_token(token)
    if (data is None) == (path is None):
        raise ValueError("asset is bytes or a path, not both")
    if data is not None:
        if not isinstance(data, (bytes, bytearray)) or not data:
            raise ValueError("asset bytes are empty")
        if len(data) > 256 * 1024:
            raise ValueError("inline asset must be 1..262144 bytes")
        encoded = base64.b64encode(bytes(data)).decode("ascii")
        return apc(f"asset;id={asset_id};t=d;r={token};{encoded}")
    text = str(path)
    raw = text.encode("utf-8")
    if not text.startswith("/") or not raw or len(raw) > 4096:
        raise ValueError("asset path must be an absolute path of 1..4096 bytes")
    encoded = base64.b64encode(raw).decode("ascii")
    return apc(f"asset;id={asset_id};t=f;r={token};{encoded}")


def gltf_payload(
    asset_id: int,
    color: tuple[float, float, float, float] | None = None,
    chrome: float = 0.0,
    liquid: float = 0.0,
    clear: tuple[float, float, float, float] | None = None,
) -> bytes:
    """One node whose mesh is a kind object, not the string gltf."""
    _check_asset_id(asset_id)
    node: dict = {"id": 1, "mesh": {"kind": "gltf", "asset": asset_id}}
    if color is not None:
        node["color"] = [_unit(part) for part in color]
    if chrome:
        node["chrome"] = round(float(chrome), 4)
    if liquid:
        node["liquid"] = round(float(liquid), 4)
    scene: dict = {"nodes": [node]}
    if clear is not None:
        scene["camera"] = {"clear": [_unit(part) for part in clear]}
    return json.dumps({"v": 1, "scene": scene}, separators=(",", ":")).encode("ascii")


def play(
    scene_id: int,
    token: str,
    *,
    clip=None,
    speed=None,
    loop=None,
    pause=None,
    stop: bool = False,
    node=None,
    at=None,
) -> bytes:
    """Play, pause, or stop a clip on a scene that is already showing."""
    _positive_id(scene_id)
    _check_token(token)
    if clip is None and pause is None and not stop:
        raise ValueError("play needs a clip, pause, or stop")
    parts = [f"play;id={scene_id}"]
    if node is not None:
        if isinstance(node, bool) or not isinstance(node, int) or node < 1 or node > 64:
            raise ValueError("node out of range")
        parts.append(f"node={node}")
    if clip is not None:
        if clip == "all":
            parts.append("clip=all")
        else:
            if isinstance(clip, bool):
                raise ValueError("clip must be an index or all")
            index = int(clip)
            if index < 0 or index > 64:
                raise ValueError("clip must be 0..64 or all")
            parts.append(f"clip={index}")
    if speed is not None:
        value = float(speed)
        if value < -16 or value > 16:
            raise ValueError("speed must be -16 to 16")
        parts.append(f"speed={round(value, 4)}")
    if at is not None:
        value = float(at)
        if value < 0 or value > 3600:
            raise ValueError("t must be 0 to 3600")
        parts.append(f"t={round(value, 4)}")
    if loop is True:
        parts.append("loop=1")
    elif loop is False:
        parts.append("loop=0")
    elif loop is not None:
        raise ValueError("loop must be true or false")
    if pause is True:
        parts.append("pause=1")
    elif pause is False:
        parts.append("pause=0")
    elif pause is not None:
        raise ValueError("pause must be true or false")
    if stop:
        parts.append("stop=1")
    parts.append(f"r={token}")
    return apc(";".join(parts))


_SUMMARY = re.compile(r"\b(nodes|meshes|primitives|vertices|triangles|materials|textures|clips)=(\d+)")
_SECONDS = re.compile(r"\bseconds=([0-9.]+(?:/[0-9.]+)*)")


def asset_summary(extra: str) -> dict:
    """Copy only the counts Glass put on the asset OK. Missing fields stay missing."""
    found: dict = {}
    for match in _SUMMARY.finditer(extra or ""):
        found[match.group(1)] = int(match.group(2))
    seconds = _SECONDS.search(extra or "")
    if seconds:
        found["seconds"] = [float(part) for part in seconds.group(1).split("/") if part]
    return found


def _check_asset_id(asset_id: int) -> None:
    if not isinstance(asset_id, int) or isinstance(asset_id, bool):
        raise ValueError("asset id must be an integer")
    if asset_id < 1 or asset_id >= PICTURE_BASE:
        raise ValueError("asset id must be under 0x16000000")


def scene(
    scene_id: int,
    payload: bytes,
    token: str,
    *,
    width: int,
    height: int,
    x: int,
    y: int,
    opacity: float | None = None,
    z: int | None = None,
    cells: tuple[float, float, float, float] | None = None,
    anchor: str | None = None,
) -> bytes:
    """Place one scene.

    The default placement is window pixels (`px=`). Keys `x=` `y=` `w=` `h=`
    are not used: this machine refused them. `cells` with the default anchor
    sends `at=` and `anchor=window` and omits `px=`. `anchor="text"` sends
    `anchor=text`. `anchor="omit"` sends `at=` and omits `anchor`. ``o=`` and
    ``z=`` are omitted unless asked, so the orange-cube, orthographic, mist,
    and window-pinned frames stay the same.
    """
    _positive_id(scene_id)
    _check_token(token)
    _pixel(width, "width")
    _pixel(height, "height")
    placed = None
    pin = None
    if cells is not None:
        placed = parse_cells(cells)
        if anchor is None or anchor == "window":
            pin = "window"
        elif anchor in ("text", "omit"):
            pin = anchor
        else:
            raise ValueError("anchor must be window, text, or omit")
    else:
        if anchor is not None:
            raise ValueError("anchor is only for a cell box")
        _origin(x, "x")
        _origin(y, "y")
    if not isinstance(payload, bytes) or len(payload) > 1 << 20:
        raise ValueError("scene payload is too large")
    if opacity is not None:
        opacity = parse_opacity(opacity)
    if z is not None:
        z = parse_scene_z(z)
    encoded = base64.b64encode(payload).decode("ascii")
    if placed is not None:
        cell_x, cell_y, cell_w, cell_h = placed
        head = (
            f"scene;id={scene_id};at={_plain(cell_x)},{_plain(cell_y)},{_plain(cell_w)},{_plain(cell_h)}"
        )
        if pin == "window":
            head += ";anchor=window"
        elif pin == "text":
            head += ";anchor=text"
        head += f";s={width};v={height}"
    else:
        head = f"scene;id={scene_id};px={x},{y},{width},{height};s={width};v={height}"
    if z is not None:
        head += f";z={z}"
    if opacity is not None:
        head += f";o={_plain(opacity)}"
    return apc(f"{head};r={token};{encoded}")


def scene_body(frame: bytes) -> bytes:
    """JSON envelope from a scene APC. The wire form is base64, not raw JSON."""
    text = frame.decode("ascii")
    start = text.find("scene;")
    if start < 0 or ";r=" not in text[start:]:
        raise ValueError("not a scene frame")
    encoded = text[start:].split(";r=", 1)[1].split(";", 1)[1]
    encoded = encoded.split("\x1b", 1)[0]
    return base64.b64decode(encoded)


def tween_node(
    scene_id: int,
    token: str,
    rot: str,
    *,
    node: int = 1,
    ease: str = "spring",
    repeat: str | None = "forever",
    yoyo: bool = True,
    tid: int | None = None,
    after: int | None = None,
    dur: float | None = None,
) -> bytes:
    """One rotation channel. yoyo=1 rocks it; repeat=ping is not a value this engine accepts."""
    _positive_id(scene_id)
    _check_token(token)
    if not isinstance(node, int) or isinstance(node, bool) or node < 1 or node > 64:
        raise ValueError("node out of range")
    if not _ROT.fullmatch(rot):
        raise ValueError("rotation must be four numbers")
    return _tween_body(
        f"tween;id={scene_id};node={node};rot={rot}",
        token,
        ease=ease,
        repeat=repeat,
        yoyo=yoyo,
        tid=tid,
        after=after,
        dur=dur,
    )


def tween_camera(
    scene_id: int,
    token: str,
    eye: str,
    *,
    ease: str = "sine",
    repeat: str | None = "forever",
    yoyo: bool = True,
    tid: int | None = None,
    after: int | None = None,
    dur: float | None = None,
) -> bytes:
    _positive_id(scene_id)
    _check_token(token)
    if not _EYE.fullmatch(eye):
        raise ValueError("eye must be three numbers")
    if any(abs(float(part)) > 64 for part in eye.split(",")):
        raise ValueError("eye is out of range")
    return _tween_body(
        f"tween;id={scene_id};camera=1;eye={eye}",
        token,
        ease=ease,
        repeat=repeat,
        yoyo=yoyo,
        tid=tid,
        after=after,
        dur=dur,
    )


def parse_eyes(text: str) -> list[str]:
    """Two or three camera eyes, separated by semicolons. One eye is not a chain."""
    parts = [part.strip() for part in str(text or "").split(";") if part.strip()]
    if len(parts) < 2 or len(parts) > 3:
        raise ValueError("a chain needs two or three eyes")
    for eye in parts:
        if not _EYE.fullmatch(eye):
            raise ValueError("eye must be three numbers")
        if any(abs(float(part)) > 64 for part in eye.split(",")):
            raise ValueError("eye is out of range")
    return parts


def tween_stop(token: str, tid: int) -> bytes:
    """Stop one named tween. An OK means Glass accepted the stop, not that it was running."""
    _check_token(token)
    return apc(f"tween;tid={_tid(tid)};stop=1;r={token}")


def parse_shift(at: str | None = None, scale: str | None = None, color: str | None = None) -> dict[str, str]:
    """Normalize one node move. An omitted channel is not sent. None of them is not a shift."""
    fields: dict[str, str] = {}
    if at not in (None, ""):
        fields["at"] = _vec3(at, "at", 64)
    if scale not in (None, ""):
        fields["scale"] = _vec3(scale, "scale", 8)
    if color not in (None, ""):
        fields["color"] = _color4(color)
    if not fields:
        raise ValueError("a shift needs at, scale, or color")
    return fields


def tween_shift(
    scene_id: int,
    token: str,
    *,
    node: int = 1,
    at: str | None = None,
    scale: str | None = None,
    color: str | None = None,
    ease: str = "sine",
    dur: float = 0.6,
    tid: int | None = None,
) -> bytes:
    """One once-only node move. Does not send rot, camera, repeat, or yoyo."""
    _positive_id(scene_id)
    _check_token(token)
    if isinstance(node, bool) or not isinstance(node, int) or node < 1 or node > 64:
        raise ValueError("node out of range")
    fields = parse_shift(at, scale, color)
    body = ";".join(f"{key}={fields[key]}" for key in ("at", "scale", "color") if key in fields)
    return _tween_body(
        f"tween;id={scene_id};node={node};{body}",
        token,
        ease=ease,
        repeat=None,
        yoyo=False,
        tid=tid,
        dur=dur,
    )


def parse_turn(yaw=None, rot=None) -> str:
    """One node rotation. yaw is degrees around y. rot is x,y,z,w. Not both, and not neither."""
    has_yaw = yaw not in (None, "")
    has_rot = rot not in (None, "")
    if has_yaw and has_rot:
        raise ValueError("a turn takes yaw or rot, not both")
    if not has_yaw and not has_rot:
        raise ValueError("a turn needs yaw or rot")
    if has_rot:
        text = str(rot).strip()
        if not _ROT.fullmatch(text):
            raise ValueError("rotation must be four numbers")
        parts = []
        for part in text.split(","):
            value = float(part)
            if abs(value) > 1:
                raise ValueError("rotation is out of range")
            parts.append(value)
        length = sum(part * part for part in parts)
        if abs(length - 1.0) > 0.02:
            raise ValueError("rotation must be a unit quaternion")
        return ",".join(_compact(part) for part in parts)
    if isinstance(yaw, str):
        try:
            yaw = float(yaw)
        except ValueError as exc:
            raise ValueError("yaw must be a number") from exc
    return yaw_rot(yaw)


def tween_turn(
    scene_id: int,
    token: str,
    *,
    node: int = 1,
    yaw=None,
    rot: str | None = None,
    ease: str = "spring",
    dur: float | None = None,
    tid: int | None = None,
) -> bytes:
    """One once-only node rotation. Does not send at, scale, color, camera, repeat, or yoyo.

    The forever spin is tween_node with repeat=forever and yoyo=1. This frame is not that.
    dur is omitted when None, so a spring turn can match the published quarter-turn frame.
    """
    _positive_id(scene_id)
    _check_token(token)
    if isinstance(node, bool) or not isinstance(node, int) or node < 1 or node > 64:
        raise ValueError("node out of range")
    quaternion = parse_turn(yaw, rot)
    return _tween_body(
        f"tween;id={scene_id};node={node};rot={quaternion}",
        token,
        ease=ease,
        repeat=None,
        yoyo=False,
        tid=tid,
        dur=dur,
    )


def parse_veil(emissive=None, visible=None) -> dict[str, str]:
    """Normalize one node shine or visibility. An omitted channel is not sent.

    ``emissive`` is 0 to 1. ``visible`` is 0 or 1. This parser does not accept
    rot, at, scale, color, or camera. ``visible=0`` hides at the end of the
    tween; the frame still only carries the flag.
    """
    fields: dict[str, str] = {}
    if emissive not in (None, ""):
        amount = _effect_amount(_as_number(emissive, "emissive"), "emissive", 0, 1)
        fields["emissive"] = _plain(amount)
    if visible not in (None, ""):
        fields["visible"] = _visible_flag(visible)
    if not fields:
        raise ValueError("a veil needs emissive or visible")
    return fields


def _visible_flag(value) -> str:
    if isinstance(value, bool):
        return "1" if value else "0"
    if isinstance(value, str):
        text = value.strip()
        if text in ("0", "1"):
            return text
        raise ValueError("visible must be 0 or 1")
    if isinstance(value, int) and value in (0, 1):
        return str(value)
    if isinstance(value, float) and value in (0.0, 1.0):
        return "1" if value == 1.0 else "0"
    raise ValueError("visible must be 0 or 1")


def tween_veil(
    scene_id: int,
    token: str,
    *,
    node: int = 1,
    emissive=None,
    visible=None,
    ease: str = "sine",
    dur: float | None = None,
    tid: int | None = None,
) -> bytes:
    """One once-only node shine or visibility.

    Does not send rot, at, scale, color, camera, repeat, or yoyo. The forever
    spin is tween_node with repeat=forever and yoyo=1. This frame is not that.
    dur is omitted when None, so a spring veil can omit a duration.
    """
    _positive_id(scene_id)
    _check_token(token)
    if isinstance(node, bool) or not isinstance(node, int) or node < 1 or node > 64:
        raise ValueError("node out of range")
    fields = parse_veil(emissive, visible)
    body = ";".join(f"{key}={fields[key]}" for key in ("emissive", "visible") if key in fields)
    return _tween_body(
        f"tween;id={scene_id};node={node};{body}",
        token,
        ease=ease,
        repeat=None,
        yoyo=False,
        tid=tid,
        dur=dur,
    )


def parse_look(target: str | None, fov) -> dict[str, str]:
    """Camera target and fov only. Neither asked is not a look."""
    fields: dict[str, str] = {}
    if target not in (None, ""):
        fields["target"] = _vec3(str(target), "target", 64)
    if fov not in (None, ""):
        number = _as_number(fov, "fov")
        if isinstance(number, bool) or not isinstance(number, (int, float)):
            raise ValueError("fov must be a number")
        value = float(number)
        if value != value or value >= math.pi or value <= 0:
            raise ValueError("fov must be greater than 0 and less than pi")
        fields["fov"] = _plain(value)
    if not fields:
        raise ValueError("a look needs target or fov")
    return fields


def tween_look(
    scene_id: int,
    token: str,
    target: str | None = None,
    fov=None,
    *,
    ease: str = "sine",
    dur: float | None = None,
    tid: int | None = None,
) -> bytes:
    """Aim the camera once. Does not send eye, node channels, repeat, or yoyo.

    The forever camera rock is tween_camera with eye, repeat=forever, and yoyo=1.
    This frame is not that.
    """
    _positive_id(scene_id)
    _check_token(token)
    fields = parse_look(target, fov)
    body = ";".join(f"{key}={fields[key]}" for key in ("target", "fov") if key in fields)
    return _tween_body(
        f"tween;id={scene_id};camera=1;{body}",
        token,
        ease=ease,
        repeat=None,
        yoyo=False,
        tid=tid,
        dur=dur,
    )


def parse_curve(text: str) -> dict[str, object]:
    """Four cubic-bezier controls. x is 0 to 1. y is -100 to 100.

    The returned ease is the literal this call will send, not a measurement.
    overshot is true when a y control sits outside 0 to 1.
    """
    raw = str(text or "").strip()
    if raw.startswith("cubic-bezier(") and raw.endswith(")"):
        raw = raw[len("cubic-bezier("):-1]
    parts = [part.strip() for part in raw.split(",")]
    if len(parts) != 4 or any(not re.fullmatch(r"-?\d+(?:\.\d+)?", part) for part in parts):
        raise ValueError("curve needs four numbers x1,y1,x2,y2")
    numbers = [float(part) for part in parts]
    if any(value != value or abs(value) == float("inf") for value in numbers):
        raise ValueError("curve needs four finite numbers")
    x1, y1, x2, y2 = numbers
    if x1 < 0 or x1 > 1 or x2 < 0 or x2 > 1:
        raise ValueError("curve x1 and x2 must be 0 to 1")
    if abs(y1) > 100 or abs(y2) > 100:
        raise ValueError("curve y1 and y2 must be -100 to 100")
    ease = "cubic-bezier(" + ",".join(_compact(value) for value in numbers) + ")"
    return {
        "ease": ease,
        "controls": numbers,
        "overshot": y1 < 0 or y1 > 1 or y2 < 0 or y2 > 1,
    }


def tween_curve(
    scene_id: int,
    token: str,
    at: str,
    curve: str,
    *,
    node: int = 1,
    dur: float = 1.0,
    tid: int | None = None,
) -> bytes:
    """One once-only node move. The ease is cubic-bezier, never a named ease.

    repeat, yoyo, camera, rot, scale, and color are not sent.
    """
    _positive_id(scene_id)
    _check_token(token)
    if isinstance(node, bool) or not isinstance(node, int) or node < 1 or node > 64:
        raise ValueError("node out of range")
    parsed = parse_curve(curve)
    place = _vec3(str(at), "at", 64)
    return _tween_body(
        f"tween;id={scene_id};node={node};at={place}",
        token,
        ease="linear",
        repeat=None,
        yoyo=False,
        tid=tid,
        dur=dur,
        ease_literal=str(parsed["ease"]),
    )


NAMED_EASES = (
    "back-in",
    "back-out",
    "back-in-out",
    "elastic-in",
    "elastic-out",
    "elastic-in-out",
)


def parse_named_ease(text: str) -> dict[str, object]:
    """Accept one dialect back or elastic ease. Short names are not mapped."""
    raw = str(text or "").strip()
    if raw not in NAMED_EASES:
        raise ValueError(
            "ease must be back-in, back-out, back-in-out, elastic-in, elastic-out, or elastic-in-out"
        )
    family = "back" if raw.startswith("back-") else "elastic"
    return {
        "ease": raw,
        "family": family,
        "recoil": family == "back",
        "wobble": family == "elastic",
    }


def tween_named(
    scene_id: int,
    token: str,
    at: str,
    ease: str,
    dur: float | None = None,
    node: int = 1,
    tid: int = 1,
) -> bytes:
    """One once-only node move. Sends a named back or elastic ease and a duration.

    It does not send cubic-bezier, spring, repeat, or yoyo. Older tween frames
    still use ``_ease`` and still refuse these names.
    """
    parsed = parse_named_ease(ease)
    place = _vec3(str(at), "at", 64)
    return _tween_body(
        f"tween;id={scene_id};node={node};at={place}",
        token,
        ease="linear",
        repeat=None,
        yoyo=False,
        tid=tid,
        dur=0.8 if dur is None else dur,
        named_literal=str(parsed["ease"]),
    )


def parse_glide(
    px=None,
    opacity=None,
    color=None,
    angle=None,
) -> dict[str, str]:
    """Normalize one layer move. An omitted channel is not sent.

    A layer this plugin placed used ``px=``. ``at=`` on that layer is EINVAL, so
    this parser does not accept a cell target.
    """
    fields: dict[str, str] = {}
    if px not in (None, ""):
        fields["px"] = _px4(px)
    if opacity not in (None, ""):
        fields["o"] = _plain(_effect_amount(_as_number(opacity, "opacity"), "opacity", 0, 1))
    if color not in (None, ""):
        fields["c"] = _effect_color(color)
    if angle not in (None, ""):
        fields["a"] = _plain(_effect_amount(_as_number(angle, "angle"), "angle", -8, 8))
    if not fields:
        raise ValueError("a glide needs px, opacity, color, or angle")
    return fields


def tween_glide(
    layer_id: int,
    token: str,
    *,
    px=None,
    opacity=None,
    color=None,
    angle=None,
    ease: str = "sine",
    dur: float = 0.6,
    tid: int | None = None,
) -> bytes:
    """One once-only layer tween. Uses layer=, not id= or node=.

    Does not send at, rot, camera, repeat, or yoyo.
    """
    _check_id(layer_id)
    if isinstance(layer_id, bool) or not isinstance(layer_id, int) or layer_id < 1:
        raise ValueError("layer id must be at least 1")
    _check_token(token)
    fields = parse_glide(px, opacity, color, angle)
    body = ";".join(f"{key}={fields[key]}" for key in ("px", "o", "c", "a") if key in fields)
    return _tween_body(
        f"tween;layer={layer_id};{body}",
        token,
        ease=ease,
        repeat=None,
        yoyo=False,
        tid=tid,
        dur=dur,
    )


def parse_float(to_lift=None, to_breathe=None) -> dict[str, str]:
    """Normalize one lift or breathe tween. An omitted channel is not sent."""
    fields: dict[str, str] = {}
    if to_lift not in (None, ""):
        fields["h"] = _plain(_effect_amount(_as_number(to_lift, "lift"), "lift", 0, 8192))
    if to_breathe not in (None, ""):
        fields["b"] = _plain(_effect_amount(_as_number(to_breathe, "breathe"), "breathe", 0, 8192))
    if not fields:
        raise ValueError("name a lift or a breathe to tween")
    return fields


def tween_float(
    layer_id: int,
    token: str,
    *,
    to_lift=None,
    to_breathe=None,
    ease: str = "sine",
    dur: float | None = 0.6,
    delay: float | None = None,
    tid: int | None = None,
) -> bytes:
    """One once-only lift or breathe tween. Uses layer=, not id= or node=.

    delay is omitted when not asked. Does not send px, at, rot, camera, repeat, or yoyo.
    """
    _check_id(layer_id)
    if isinstance(layer_id, bool) or not isinstance(layer_id, int) or layer_id < 1:
        raise ValueError("layer id must be at least 1")
    _check_token(token)
    fields = parse_float(to_lift, to_breathe)
    body = ";".join(f"{key}={fields[key]}" for key in ("h", "b") if key in fields)
    return _tween_body(
        f"tween;layer={layer_id};{body}",
        token,
        ease=ease,
        repeat=None,
        yoyo=False,
        tid=tid,
        dur=dur,
        delay=delay,
    )


def parse_size(to_size) -> str:
    """Normalize one particle size tween. An omitted size is not a tween."""
    if to_size in (None, ""):
        raise ValueError("name a mote size to tween")
    return _plain(_effect_amount(_as_number(to_size, "size"), "size", 0.5, 64))


def tween_size(
    layer_id: int,
    token: str,
    *,
    to_size,
    ease: str = "sine",
    dur: float | None = 0.6,
    delay: float | None = None,
    tid: int | None = None,
) -> bytes:
    """One once-only particle size tween. Uses layer=, not id= or node=.

    delay is omitted when not asked. Does not send h, b, px, at, o, a, c,
    node, camera, repeat, or yoyo.
    """
    _check_id(layer_id)
    if isinstance(layer_id, bool) or not isinstance(layer_id, int) or layer_id < 1:
        raise ValueError("layer id must be at least 1")
    _check_token(token)
    size = parse_size(to_size)
    return _tween_body(
        f"tween;layer={layer_id};size={size}",
        token,
        ease=ease,
        repeat=None,
        yoyo=False,
        tid=tid,
        dur=dur,
        delay=delay,
    )


def _px4(text) -> str:
    parts = [part.strip() for part in str(text).split(",")]
    if len(parts) != 4:
        raise ValueError("px must be four numbers")
    numbers = []
    for index, part in enumerate(parts):
        if not re.fullmatch(r"-?\d+(?:\.\d+)?", part):
            raise ValueError("px must be four numbers")
        value = float(part)
        limit = 8192
        if index < 2:
            if value < 0 or value > limit:
                raise ValueError("px is out of range")
        elif value <= 0 or value > limit:
            raise ValueError("px is out of range")
        numbers.append(_compact(value))
    return ",".join(numbers)


def _vec3(text, name: str, limit: float) -> str:
    parts = [part.strip() for part in str(text).split(",")]
    if len(parts) != 3:
        raise ValueError(f"{name} must be three numbers")
    numbers = []
    for part in parts:
        if not re.fullmatch(r"-?\d+(?:\.\d+)?", part):
            raise ValueError(f"{name} must be three numbers")
        value = float(part)
        if abs(value) > limit:
            raise ValueError(f"{name} is out of range")
        numbers.append(_compact(value))
    return ",".join(numbers)


def _color4(text) -> str:
    parts = [part.strip() for part in str(text).split(",") if part.strip()]
    if len(parts) != 4:
        raise ValueError("color must be four numbers, r,g,b,a, each 0 to 1")
    numbers = []
    for part in parts:
        if not re.fullmatch(r"-?\d+(?:\.\d+)?", part):
            raise ValueError("color must be four numbers, r,g,b,a, each 0 to 1")
        value = float(part)
        if value < 0 or value > 1:
            raise ValueError("color channels must be 0 to 1")
        numbers.append(_compact(value))
    return ",".join(numbers)


def _compact(value: float) -> str:
    text = f"{float(value):.4f}".rstrip("0").rstrip(".")
    if text in ("", "-0"):
        return "0"
    return text


def yaw_rot(degrees: float) -> str:
    if isinstance(degrees, bool) or not isinstance(degrees, (int, float)):
        raise ValueError("yaw must be a number")
    if degrees < -720 or degrees > 720:
        raise ValueError("yaw must be within 720 degrees")
    half = math.radians(float(degrees)) / 2.0
    return f"0,{math.sin(half):.4f},0,{math.cos(half):.4f}"


def _bezier_literal(value: str) -> str:
    parsed = parse_curve(value)
    literal = str(parsed["ease"])
    if ";" in literal or "\x1b" in literal:
        raise ValueError("curve ease must be one cubic-bezier")
    return literal


def _named_literal(value: str) -> str:
    parsed = parse_named_ease(value)
    literal = str(parsed["ease"])
    if ";" in literal or "\x1b" in literal:
        raise ValueError("named ease must be one back or elastic name")
    return literal


def _tween_body(
    prefix: str,
    token: str,
    *,
    ease: str,
    repeat: str | None,
    yoyo: bool,
    tid: int | None = None,
    after: int | None = None,
    dur: float | None = None,
    delay: float | None = None,
    ease_literal: str | None = None,
    named_literal: str | None = None,
) -> bytes:
    named = _tid(tid) if tid is not None else None
    waits = _tid(after, "after") if after is not None else None
    if named is not None and waits is not None and named == waits:
        raise ValueError("a tween cannot wait on itself")
    if named_literal is not None and ease_literal is not None:
        raise ValueError("one ease")
    if named_literal is not None:
        chosen = _named_literal(named_literal)
    elif ease_literal is not None:
        chosen = _bezier_literal(ease_literal)
    else:
        chosen = _ease(ease)
    body = f"{prefix};ease={chosen}"
    repeat_value = _repeat(repeat)
    if repeat_value:
        body += f";repeat={repeat_value}"
    if yoyo:
        body += ";yoyo=1"
    if dur is not None:
        body += f";dur={_seconds(dur)}"
    if delay is not None:
        body += f";delay={_delay_seconds(delay)}"
    if named is not None:
        body += f";tid={named}"
    if waits is not None:
        body += f";after={waits}"
    body += f";r={token}"
    return apc(body)


def _tid(value, name: str = "tween id") -> int:
    if isinstance(value, bool) or not isinstance(value, int) or value < 1 or value > 64:
        raise ValueError(f"{name} must be 1 to 64")
    return value


def _seconds(value) -> str:
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        raise ValueError("duration must be a number")
    number = float(value)
    if number != number or number < 0.05 or number > 8:
        raise ValueError("duration must be 0.05 to 8")
    text = f"{number:.4f}".rstrip("0").rstrip(".")
    if "." not in text:
        text += ".0"
    return text


def _delay_seconds(value) -> str:
    """A tween delay. 0 is sent when asked. Omitted callers do not reach here."""
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        raise ValueError("delay must be a number")
    number = float(value)
    if number != number or number < 0 or number > 8:
        raise ValueError("delay must be 0 to 8")
    text = f"{number:.4f}".rstrip("0").rstrip(".")
    if "." not in text:
        text += ".0"
    return text


def _positive_id(scene_id: int) -> None:
    _check_id(scene_id)
    if scene_id < 1:
        raise ValueError("scene id out of range")


def _unit(part: float) -> float:
    if isinstance(part, bool) or not isinstance(part, (int, float)):
        raise ValueError("color must be four numbers")
    value = float(part)
    if value < 0 or value > 1:
        raise ValueError("color components must be in 0..1")
    return round(value, 4)


def _amount(value, name: str, hi: float = 1) -> float:
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        raise ValueError(f"{name} must be a number")
    number = float(value)
    if number != number or number < 0 or number > hi:
        raise ValueError(f"{name} must be 0 to {hi}")
    return round(number, 4)


def _count(value, name: str, lo: int, hi: int) -> int:
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        raise ValueError(f"{name} must be an integer")
    if isinstance(value, float) and not value.is_integer():
        raise ValueError(f"{name} must be an integer")
    number = int(value)
    if number < lo or number > hi:
        raise ValueError(f"{name} must be {lo} to {hi}")
    return number


def _mesh_value(
    mesh: str,
    *,
    segments: int | None,
    radius: float | None,
    seed: int | None,
    steps: int | None,
    posts: int | None,
):
    name = str(mesh).strip().lower()
    if name in NAMED_MESHES:
        if any(value is not None for value in (segments, radius, seed, steps, posts)):
            raise ValueError("named mesh does not take shape fields")
        return name
    if name not in KIND_MESHES:
        raise ValueError("mesh must be one of " + ", ".join(NAMED_MESHES + KIND_MESHES))
    body: dict[str, object] = {"kind": name}
    if name in _SEGMENT_KINDS:
        _reject_shape(radius=radius, seed=seed, steps=steps, posts=posts)
        if segments is not None:
            body["segments"] = _count(segments, "segments", 3, 64)
    elif name == "roundcube":
        _reject_shape(seed=seed, steps=steps, posts=posts)
        if radius is not None:
            body["radius"] = _amount(radius, "radius", 0.5)
        if segments is not None:
            body["segments"] = _count(segments, "segments", 1, 16)
    elif name == "stairs":
        _reject_shape(segments=segments, radius=radius, seed=seed, posts=posts)
        if steps is not None:
            body["steps"] = _count(steps, "steps", 1, 64)
    elif name in ("rock", "blob"):
        _reject_shape(segments=segments, radius=radius, steps=steps, posts=posts)
        if seed is not None:
            body["seed"] = _count(seed, "seed", 0, 65535)
    elif name == "fence":
        _reject_shape(segments=segments, radius=radius, seed=seed, steps=steps)
        if posts is not None:
            body["posts"] = _count(posts, "posts", 2, 64)
    return body


def _reject_shape(**fields) -> None:
    for name, value in fields.items():
        if value is not None:
            raise ValueError(f"{name} is not a field of this mesh")


def _pixel(value: int, name: str) -> None:
    if not isinstance(value, int) or isinstance(value, bool) or value < 1 or value > 2048:
        raise ValueError(f"{name} must be 1 to 2048")


def _origin(value: int, name: str) -> None:
    if not isinstance(value, int) or isinstance(value, bool) or value < 0 or value > 8192:
        raise ValueError(f"{name} must be 0 to 8192")


def _ease(name: str) -> str:
    try:
        return EASES[name]
    except KeyError:
        raise ValueError("ease must be linear, spring, sine, cubic, or bounce") from None


def _repeat(value: str | None) -> str | None:
    if value is None or value == "" or value == "once":
        return None
    if value == "forever":
        return "forever"
    if value == "ping":
        raise ValueError("repeat=ping is not accepted; use yoyo=1")
    if isinstance(value, int) and not isinstance(value, bool) and 0 <= value <= 8:
        return str(value)
    raise ValueError("repeat must be once, forever, or 0 to 8")


FRAME_CAP = 1 << 20


def view_model(
    payload: bytes,
    token: str,
    *,
    width: int,
    height: int,
    fit: str = "contain",
) -> bytes:
    """Open the showcase on scene nodes. id= and px= are scene keys, so they are not sent."""
    _pixel(width, "width")
    _pixel(height, "height")
    _check_token(token)
    if fit not in ("contain", "width"):
        raise ValueError("fit must be contain or width")
    if not isinstance(payload, (bytes, bytearray)) or not payload or len(payload) > FRAME_CAP:
        raise ValueError("model payload is empty or over 1 MiB")
    encoded = base64.b64encode(bytes(payload)).decode("ascii")
    return apc(f"model;s={width};v={height};fit={fit};r={token};{encoded}")


def view_body(frame: bytes) -> bytes:
    text = frame.decode("ascii")
    start = text.find("model;")
    if start < 0 or ";r=" not in text[start:]:
        raise ValueError("not a model frame")
    encoded = text[start:].split(";r=", 1)[1].split(";", 1)[1]
    encoded = encoded.split("\x1b", 1)[0]
    return base64.b64decode(encoded)


def video_showcase(width: int, height: int, token: str, fit: str = "contain") -> bytes:
    """Open a sized video panel. id= is a picture showcase, so it is not sent."""
    _pixel(width, "width")
    _pixel(height, "height")
    _check_token(token)
    if fit not in ("contain", "width"):
        raise ValueError("fit must be contain or width")
    return apc(f"showcase;s={width};v={height};fit={fit};r={token}")


def video_frame(width: int, height: int, rgba: bytes, token: str) -> bytes:
    """One RGBA frame. The last field is base64, which this parser caps at 1 MiB."""
    _pixel(width, "width")
    _pixel(height, "height")
    _check_token(token)
    if not isinstance(rgba, bytes) or len(rgba) != width * height * 4:
        raise ValueError("frame pixels must be width*height*4")
    encoded = base64.b64encode(rgba).decode("ascii")
    if len(encoded) > FRAME_CAP:
        raise ValueError("frame is over 1 MiB")
    return apc(f"frame;f=32;s={width};v={height};r={token};{encoded}")


def video_file(data: bytes, token: str, width: int | None = None, height: int | None = None) -> bytes:
    """A still Glass can decode, used as the current video frame."""
    _check_token(token)
    if not isinstance(data, bytes) or not data:
        raise ValueError("frame file is empty")
    encoded = base64.b64encode(data).decode("ascii")
    if len(encoded) > FRAME_CAP:
        raise ValueError("frame is over 1 MiB")
    keys = "frame;f=100"
    if width is not None and height is not None:
        _pixel(width, "width")
        _pixel(height, "height")
        keys += f";s={width};v={height}"
    return apc(f"{keys};r={token};{encoded}")


def progress_frame(token: str, t: float | None = None, pause: bool | None = None) -> bytes:
    """Seek or pause the open video panel. At least one of t or pause is required."""
    _check_token(token)
    if t is None and pause is None:
        raise ValueError("progress needs t or pause")
    parts = ["progress"]
    if t is not None:
        parts.append(f"t={_unit_text(t)}")
    if pause is True:
        parts.append("pause=1")
    elif pause is False:
        parts.append("pause=0")
    elif pause is not None:
        raise ValueError("pause must be true or false")
    parts.append(f"r={token}")
    return apc(";".join(parts))


def _unit_text(value: float) -> str:
    number = float(value)
    if number < 0 or number > 1:
        raise ValueError("t must be a number from 0 to 1")
    text = f"{number:.6f}".rstrip("0").rstrip(".")
    return text or "0"


# Program id for one overlay. It is not a picture id and not an asset id.
EFFECT_ID = 32
GROUP_ID = 1
GROUP_LAYER_BASE = 40
GROUP_CAP = 8
HUD = "glow@48,48,180,72#8844cc;ring@248,40,84,84#40b0ff;line@48,132,284,8#ff60c0"
EFFECT_KINDS = ("glow", "particles", "ring", "line", "prim", "solid")


def _foot(value) -> str:
    """``up=x,y`` in placement pixels. Only ``stand=up`` uses it."""
    if isinstance(value, str):
        parts = [part.strip() for part in value.split(",")]
    elif isinstance(value, (list, tuple)) and len(value) == 2:
        parts = list(value)
    else:
        raise ValueError("up must be two numbers")
    if len(parts) != 2:
        raise ValueError("up must be two numbers")
    numbers = []
    for part in parts:
        if isinstance(part, str):
            if not re.fullmatch(r"-?\d+(?:\.\d+)?", part):
                raise ValueError("up must be two numbers")
            part = float(part)
        numbers.append(_plain(_effect_amount(part, "up", -8192, 8192)))
    return ",".join(numbers)


def _stand_parts(stand, foot) -> list[str]:
    """``stand=`` and ``up=`` only when asked. Omitted leaves the glow frame unchanged."""
    if stand in (None, "") and foot in (None, ""):
        return []
    if stand in (None, ""):
        raise ValueError("up is only used by stand=up")
    name = str(stand).strip().lower()
    if name not in {"floor", "up", "screen"}:
        raise ValueError("stand must be floor, up, or screen")
    parts = [f"stand={name}"]
    if foot not in (None, ""):
        if name != "up":
            raise ValueError("up is only used by stand=up")
        parts.append(f"up={_foot(foot)}")
    return parts


def layer_record(
    layer_id: int,
    kind: str,
    *,
    x: int,
    y: int,
    width: int,
    height: int,
    color: str | None = None,
    opacity: float | None = None,
    z: int | None = None,
    add: bool | None = None,
    count: int | None = None,
    size: float | None = None,
    life: float | None = None,
    rise: float | None = None,
    sway: float | None = None,
    seed: int | None = None,
    stroke: float | None = None,
    glow: float | None = None,
    shape: int | None = None,
    speed: float | None = None,
    phase: float | None = None,
    lift: float | None = None,
    breathe: float | None = None,
    flicker: float | None = None,
    stand: str | None = None,
    foot: str | None = None,
    burst: float | None = None,
    pin: str | None = None,
) -> str:
    """One layer record. picture and part are not sent; they need an uploaded picture.

    lift, breathe, flicker, stand, burst, and a window pin are omitted when not asked,
    so the glow frame stays the same.
    """
    _check_id(layer_id)
    if layer_id < 1:
        raise ValueError("layer id must be at least 1")
    if kind not in EFFECT_KINDS:
        raise ValueError("kind must be glow, particles, ring, line, prim, or solid")
    _origin(x, "x")
    _origin(y, "y")
    _pixel(width, "width")
    _pixel(height, "height")
    extras = {
        "count": count,
        "size": size,
        "life": life,
        "rise": rise,
        "sway": sway,
        "seed": seed,
        "stroke": stroke,
        "glow": glow,
        "shape": shape,
        "speed": speed,
        "phase": phase,
    }
    allowed = {
        "glow": set(),
        "solid": set(),
        "particles": {"count", "size", "life", "rise", "sway", "seed"},
        "ring": {"stroke", "glow"},
        "line": {"stroke", "glow"},
        "prim": {"shape", "speed", "phase"},
    }[kind]
    unused = [name for name, value in extras.items() if value is not None and name not in allowed]
    if unused:
        raise ValueError(unused[0] + " is not used by k=" + kind)
    if pin not in (None, "window"):
        raise ValueError("pin must be window")
    if burst is not None and kind != "particles":
        raise ValueError("burst is only for particles")
    if add is None:
        add = kind in ("glow", "ring", "line")
    elif not isinstance(add, bool):
        raise ValueError("add must be true or false")
    if opacity is not None:
        opacity = _effect_amount(opacity, "opacity", 0, 1)
    if z is not None:
        z = _count(z, "z", -32768, 32767)
    parts = [
        f"layer;id={layer_id}",
        f"k={kind}",
    ]
    if pin == "window":
        parts.append(f"at={x},{y},{width},{height}")
        parts.append("anchor=window")
    else:
        parts.append(f"px={x},{y},{width},{height}")
    parts.append(f"c={_effect_color(color)}")
    if opacity is not None and opacity != 1:
        parts.append(f"o={_plain(opacity)}")
    if z not in (None, 0):
        parts.append(f"z={z}")
    if add:
        parts.append("add=1")
    if lift is not None:
        parts.append(f"h={_plain(_effect_amount(lift, 'lift', 0, 8192))}")
    if breathe is not None:
        parts.append(f"b={_plain(_effect_amount(breathe, 'breathe', 0, 8192))}")
    if flicker is not None:
        parts.append(f"fl={_plain(_effect_amount(flicker, 'flicker', 0, 1))}")
    parts.extend(_stand_parts(stand, foot))
    if kind == "particles":
        count = 64 if count is None else _count(count, "count", 1, 4096)
        size = 6.0 if size is None else _effect_amount(size, "size", 0.5, 64)
        life = 2.0 if life is None else _effect_amount(life, "life", 0.05, 600)
        rise = 18.0 if rise is None else _effect_amount(rise, "rise", -8192, 8192)
        sway = 6.0 if sway is None else _effect_amount(sway, "sway", -8192, 8192)
        parts.append(f"n={count}")
        parts.append(f"size={_plain(size)}")
        parts.append(f"life={_plain(life)}")
        parts.append(f"rise={_plain(rise)}")
        parts.append(f"sway={_plain(sway)}")
        if seed is not None:
            parts.append(f"seed={_count(seed, 'seed', 0, 2**32 - 1)}")
        if burst is not None:
            parts.append(f"burst={_plain(_effect_amount(burst, 'burst', 0, 600))}")
    elif kind in ("ring", "line"):
        stroke = (2.5 if kind == "ring" else 2.0) if stroke is None else _effect_amount(stroke, "stroke", 0.25, 256)
        glow = (16.0 if kind == "ring" else 8.0) if glow is None else _effect_amount(glow, "glow", 0, 256)
        parts.append(f"lw={_plain(stroke)}")
        parts.append(f"glow={_plain(glow)}")
    elif kind == "prim":
        shape = 3 if shape is None else _count(shape, "shape", 0, 6)
        parts.append(f"shape={shape}")
        if speed is not None:
            parts.append(f"speed={_plain(_effect_amount(speed, 'speed', -1_000_000, 1_000_000))}")
        if phase is not None:
            parts.append(f"phase={_plain(_effect_amount(phase, 'phase', -1_000_000, 1_000_000))}")
    return ";".join(parts)


def effect_layer(
    layer_id: int,
    kind: str,
    token: str,
    *,
    x: int,
    y: int,
    width: int,
    height: int,
    color: str | None = None,
    opacity: float | None = None,
    z: int | None = None,
    add: bool | None = None,
    count: int | None = None,
    size: float | None = None,
    life: float | None = None,
    rise: float | None = None,
    sway: float | None = None,
    seed: int | None = None,
    stroke: float | None = None,
    glow: float | None = None,
    shape: int | None = None,
    speed: float | None = None,
    phase: float | None = None,
    lift: float | None = None,
    breathe: float | None = None,
    flicker: float | None = None,
    stand: str | None = None,
    foot: str | None = None,
    burst: float | None = None,
    pin: str | None = None,
) -> bytes:
    """One layer op. The record matches ``layer_record`` plus the reply token."""
    _check_token(token)
    record = layer_record(
        layer_id,
        kind,
        x=x,
        y=y,
        width=width,
        height=height,
        color=color,
        opacity=opacity,
        z=z,
        add=add,
        count=count,
        size=size,
        life=life,
        rise=rise,
        sway=sway,
        seed=seed,
        stroke=stroke,
        glow=glow,
        shape=shape,
        speed=speed,
        phase=phase,
        lift=lift,
        breathe=breathe,
        flicker=flicker,
        stand=stand,
        foot=foot,
        burst=burst,
        pin=pin,
    )
    return apc(f"{record};r={token}")


_GROUP_PIECE = re.compile(
    r"^(?P<kind>glow|particles|ring|line|prim|solid)"
    r"@(?P<x>\d{1,5}),(?P<y>\d{1,5}),(?P<w>\d{1,5}),(?P<h>\d{1,5})"
    r"(?:#(?P<color>[0-9A-Fa-f]{6}(?:[0-9A-Fa-f]{2})?))?$"
)


def parse_group_pieces(text: str) -> list[dict]:
    """``kind@x,y,width,height[#RRGGBB]``, one to eight, semicolon-separated."""
    raw = (text or "").strip()
    if not raw:
        raise ValueError("pieces required")
    if "at=" in raw or "k=picture" in raw or "k=part" in raw:
        raise ValueError("group pieces use px, not at, and not a picture")
    parts = [part.strip() for part in raw.split(";") if part.strip()]
    if not 1 <= len(parts) <= GROUP_CAP:
        raise ValueError("pieces must be 1 to 8")
    parsed: list[dict] = []
    for part in parts:
        match = _GROUP_PIECE.fullmatch(part)
        if match is None:
            raise ValueError("piece must be kind@x,y,width,height[#RRGGBB]")
        item = {
            "kind": match.group("kind"),
            "x": int(match.group("x")),
            "y": int(match.group("y")),
            "width": int(match.group("w")),
            "height": int(match.group("h")),
        }
        if match.group("color"):
            item["color"] = match.group("color")
        parsed.append(item)
    return parsed


def group_records(pieces: list[dict], *, first: int = GROUP_LAYER_BASE) -> list[str]:
    if not pieces or len(pieces) > GROUP_CAP:
        raise ValueError("pieces must be 1 to 8")
    last = first + len(pieces) - 1
    _check_id(first)
    _check_id(last)
    if first <= EFFECT_ID <= last:
        raise ValueError("group layers must not use the overlay id")
    records = []
    for index, piece in enumerate(pieces):
        records.append(
            layer_record(
                first + index,
                piece["kind"],
                x=piece["x"],
                y=piece["y"],
                width=piece["width"],
                height=piece["height"],
                color=piece.get("color"),
            )
        )
    return records


def group_frame(records: list[str], token: str, group_id: int = GROUP_ID) -> bytes:
    """Replace a whole set. Inner records have no reply token; the group op does."""
    _check_id(group_id)
    if group_id < 1:
        raise ValueError("group id must be at least 1")
    _check_token(token)
    if not records or len(records) > 65536:
        raise ValueError("group needs 1 to 65536 layer records")
    for record in records:
        if not record.startswith("layer;") or "\n" in record or "\r" in record:
            raise ValueError("group record must be one layer line")
        if not record.isascii() or "\x1b" in record or "\x07" in record:
            raise ValueError("group record must be ascii")
    payload = "\n".join(records)
    encoded = base64.b64encode(payload.encode("ascii")).decode("ascii")
    return apc(f"group;g={group_id};n={len(records)};r={token};{encoded}")


def remove_group(group_id: int, token: str | None = None) -> bytes:
    _check_id(group_id)
    if group_id < 1:
        raise ValueError("group id must be at least 1")
    body = f"remove;g={group_id}"
    if token is not None:
        _check_token(token)
        body += f";r={token}"
    return apc(body)


def remove_span(start: int, end: int, token: str | None = None) -> bytes:
    _check_id(start)
    _check_id(end)
    if end < start:
        raise ValueError("span end is before start")
    if start == end:
        return remove(start, token)
    body = f"remove;id={start}-{end}"
    if token is not None:
        _check_token(token)
        body += f";r={token}"
    return apc(body)


def _effect_color(text: str | None) -> str:
    chosen = "8844cc" if text is None or str(text).strip() == "" else str(text)
    red, green, blue, alpha = parse_color(chosen)
    parts = [int(round(channel * 255)) for channel in (red, green, blue, alpha)]
    body = "".join(f"{part:02x}" for part in parts[:3])
    if parts[3] != 255:
        body += f"{parts[3]:02x}"
    return body


def _effect_amount(value, name: str, low: float, high: float) -> float:
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        raise ValueError(f"{name} must be a number")
    number = float(value)
    if number != number or number in (float("inf"), float("-inf")) or number < low or number > high:
        raise ValueError(f"{name} must be from {low} to {high}")
    return number


def _plain(number: float) -> str:
    text = f"{float(number):.4f}".rstrip("0").rstrip(".")
    return "0" if text in ("", "-0") else text


def _as_number(value, name: str):
    if isinstance(value, str):
        text = value.strip()
        if not re.fullmatch(r"-?\d+(?:\.\d+)?", text):
            raise ValueError(f"{name} must be a number")
        return float(text)
    return value


def events_frame(token: str, enabled: bool = True) -> bytes:
    """Opt into or out of showcase events. This does not open a panel."""
    _check_token(token)
    flag = "1" if enabled else "0"
    return apc(f"showcase;events={flag};r={token}")


def parse_events(buf: bytes) -> list[dict]:
    """Showcase event frames actually present in buf. A reply is not an event."""
    if not buf:
        return []
    found = []
    for body in _glass_bodies(buf):
        parsed = _event_body(body)
        if parsed:
            found.append(parsed)
    return found


def _glass_bodies(buf: bytes) -> list[str]:
    text = buf.decode("latin1")
    bodies = []
    start = 0
    marker = "_glass;"
    while True:
        at = text.find(marker, start)
        if at < 0:
            break
        body_at = at + len(marker)
        end = text.find("\x1b\\", body_at)
        if end < 0:
            break
        bodies.append(text[body_at:end])
        start = end + 2
    return bodies


def _event_body(body: str) -> dict | None:
    prefix = "event;showcase"
    if not body.startswith(prefix):
        return None
    rest = body[len(prefix):]
    if rest.startswith(";"):
        rest = rest[1:]
    elif rest:
        return None
    if not rest:
        return None
    out = {}
    for part in rest.split(";"):
        if not part or "=" not in part:
            return None
        key, value = part.split("=", 1)
        if key in out or key == "r":
            return None
        parsed = _event_value(key, value)
        if parsed is None:
            return None
        out[key] = parsed
    return out or None


def _event_value(key: str, value: str):
    if key == "seek":
        try:
            number = float(value)
        except ValueError:
            return None
        if number != number or number < 0 or number > 1:
            return None
        return number
    if key == "close":
        if value not in ("0", "1"):
            return None
        return int(value)
    if key == "steps":
        return _event_int(value, signed=True)
    if key in ("copies", "dismissals", "clicks"):
        return _event_int(value, signed=False)
    return None


def _event_int(value: str, signed: bool):
    text = value
    sign = 1
    if signed and text.startswith("-"):
        sign = -1
        text = text[1:]
    if not text.isdigit():
        return None
    number = sign * int(text)
    if number < -2_000_000_000 or number > 2_000_000_000:
        return None
    return number
