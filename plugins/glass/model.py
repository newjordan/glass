"""Read a glTF the user named, and build a tiny fixture for tests.

The plugin sends the bytes when the file is small. A larger regular .glb is
named with ``t=f`` so Glass reads it. A symlink, a path under ``/proc``,
``/sys``, or ``/dev``, an external buffer, or a file over the dialect cap
is refused before any write.
"""

from __future__ import annotations

import json
import struct
from pathlib import Path

INLINE_ASSET = 256 * 1024
FILE_ASSET = 64 << 20
_FORBIDDEN = ("/proc", "/sys", "/dev")


class PreparedModel:
    def __init__(self, path: str, size: int, medium: str, data: bytes | None) -> None:
        self.path = path
        self.size = size
        self.medium = medium
        self.data = data


def prepare_model(path: str) -> PreparedModel:
    if not isinstance(path, str) or not path.strip():
        raise ValueError("model path required")
    src = Path(path).expanduser()
    if src.is_symlink():
        raise ValueError("model path is a symlink")
    try:
        resolved = src.resolve(strict=True)
    except OSError as exc:
        raise ValueError("model path could not be read") from exc
    if resolved.is_symlink() or not resolved.is_file():
        raise ValueError("model path must be a regular file")
    text = str(resolved)
    for prefix in _FORBIDDEN:
        if text == prefix or text.startswith(prefix + "/"):
            raise ValueError("model path is not a file glass can read")
    try:
        size = resolved.stat().st_size
    except OSError as exc:
        raise ValueError("model path could not be read") from exc
    if size <= 0 or size > FILE_ASSET:
        raise ValueError(f"model file must be 1..{FILE_ASSET} bytes")
    if len(text.encode("utf-8")) > 4096:
        raise ValueError("model path is too long for an asset frame")
    suffix = resolved.suffix.lower()
    if suffix not in (".glb", ".gltf"):
        raise ValueError("model must be a .glb or embedded .gltf")
    if suffix == ".gltf" and size > INLINE_ASSET:
        raise ValueError(f"embedded .gltf must be 1..{INLINE_ASSET} bytes")
    if size <= INLINE_ASSET:
        try:
            data = resolved.read_bytes()
        except OSError as exc:
            raise ValueError("model path could not be read") from exc
        _check_model_bytes(data, suffix)
        return PreparedModel(text, size, "d", data)
    try:
        with resolved.open("rb") as handle:
            head = handle.read(12)
    except OSError as exc:
        raise ValueError("model path could not be read") from exc
    if not head.startswith(b"glTF") or len(head) < 12 or int.from_bytes(head[4:8], "little") != 2:
        raise ValueError("model is not a version 2 glb")
    return PreparedModel(text, size, "f", None)


def _check_model_bytes(data: bytes, suffix: str) -> None:
    if suffix == ".glb":
        if len(data) < 20 or not data.startswith(b"glTF"):
            raise ValueError("model is not a glb")
        if int.from_bytes(data[4:8], "little") != 2:
            raise ValueError("model glb must be version 2")
        return
    try:
        parsed = json.loads(data.decode("utf-8"))
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise ValueError("model gltf is not JSON") from exc
    asset = parsed.get("asset") if isinstance(parsed, dict) else None
    version = asset.get("version") if isinstance(asset, dict) else None
    if version != "2.0":
        raise ValueError("model gltf must be version 2.0")
    buffers = parsed.get("buffers") or []
    if not isinstance(buffers, list):
        raise ValueError("model gltf buffers are not a list")
    for buf in buffers:
        if not isinstance(buf, dict):
            raise ValueError("model gltf buffer is not an object")
        uri = buf.get("uri")
        if uri is not None and not str(uri).startswith("data:"):
            raise ValueError("external gltf buffers are not sent")


def triangle_glb(*, animated: bool = False) -> bytes:
    """One triangle. ``animated`` adds a two-second translation clip."""
    positions = struct.pack("<9f", 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0)
    indices = struct.pack("<3H", 0, 1, 2) + b"\x00\x00"
    blob = positions + indices
    views = [
        {"buffer": 0, "byteOffset": 0, "byteLength": 36, "target": 34962},
        {"buffer": 0, "byteOffset": 36, "byteLength": 6, "target": 34963},
    ]
    accessors = [
        {
            "bufferView": 0,
            "componentType": 5126,
            "count": 3,
            "type": "VEC3",
            "min": [0.0, 0.0, 0.0],
            "max": [1.0, 1.0, 0.0],
        },
        {"bufferView": 1, "componentType": 5123, "count": 3, "type": "SCALAR"},
    ]
    gltf = {
        "asset": {"version": "2.0"},
        "scene": 0,
        "scenes": [{"nodes": [0]}],
        "nodes": [{"mesh": 0}],
        "meshes": [{"primitives": [{"attributes": {"POSITION": 0}, "indices": 1}]}],
        "buffers": [{"byteLength": len(blob)}],
        "bufferViews": views,
        "accessors": accessors,
    }
    if animated:
        times = struct.pack("<2f", 0.0, 2.0)
        values = struct.pack("<6f", 0.0, 0.0, 0.0, 1.0, 0.0, 0.0)
        offset = len(blob)
        blob = blob + times + values
        views.append({"buffer": 0, "byteOffset": offset, "byteLength": 8})
        views.append({"buffer": 0, "byteOffset": offset + 8, "byteLength": 24})
        accessors.append(
            {
                "bufferView": 2,
                "componentType": 5126,
                "count": 2,
                "type": "SCALAR",
                "min": [0.0],
                "max": [2.0],
            }
        )
        accessors.append(
            {
                "bufferView": 3,
                "componentType": 5126,
                "count": 2,
                "type": "VEC3",
                "min": [0.0, 0.0, 0.0],
                "max": [1.0, 0.0, 0.0],
            }
        )
        gltf["animations"] = [
            {
                "channels": [{"sampler": 0, "target": {"node": 0, "path": "translation"}}],
                "samplers": [{"input": 2, "output": 3}],
            }
        ]
        gltf["buffers"] = [{"byteLength": len(blob)}]
    return pack_glb(gltf, blob)


def pack_glb(gltf: dict, blob: bytes) -> bytes:
    encoded = json.dumps(gltf, separators=(",", ":")).encode("utf-8")
    encoded += b" " * ((4 - len(encoded) % 4) % 4)
    padded = bytes(blob) + b"\x00" * ((4 - len(blob) % 4) % 4)
    body = struct.pack("<I", len(encoded)) + b"JSON" + encoded
    body += struct.pack("<I", len(padded)) + b"BIN\x00" + padded
    return b"glTF" + struct.pack("<II", 2, 12 + len(body)) + body
