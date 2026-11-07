"""Image files Glass can decode, and the local PPM copy of a chart.

A file on disk is not a frame. The caller says whether Glass confirmed
the placement. This module only reads, checks, and writes bytes.
"""

from __future__ import annotations

import re
from pathlib import Path

MAX_BYTES = 750_000
_SESSION = re.compile(r"[^A-Za-z0-9_-]")


class ImageError(ValueError):
    pass


def save_ppm(path: Path, rgb: bytes, width: int, height: int) -> None:
    if width <= 0 or height <= 0 or len(rgb) != width * height * 3:
        raise ImageError("ppm size does not match the pixels")
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(f"P6\n{width} {height}\n255\n".encode("ascii") + rgb)


def save_chart(claims_path: Path, session: str, rgb: bytes, width: int, height: int) -> Path:
    safe = _SESSION.sub("", session)[:40] or "session"
    dest = Path(claims_path).parent / "artifacts" / f"{safe}.ppm"
    save_ppm(dest, rgb, width, height)
    return dest


def copy_image(claims_path: Path, session: str, loaded: "LoadedImage") -> Path:
    safe = _SESSION.sub("", session)[:40] or "session"
    suffix = loaded.path.suffix.lower()
    if suffix not in {".png", ".jpg", ".jpeg", ".gif", ".webp", ".bmp", ".ppm"}:
        suffix = ".img"
    dest = Path(claims_path).parent / "artifacts" / f"{safe}{suffix}"
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_bytes(loaded.data)
    return dest


class LoadedImage:
    def __init__(self, path: Path, data: bytes, kind: str, width: int | None, height: int | None) -> None:
        self.path = path
        self.data = data
        self.kind = kind
        self.width = width
        self.height = height


def load_image(path: str | Path) -> LoadedImage:
    src = Path(path)
    if src.is_symlink():
        src = src.resolve()
    try:
        if not src.is_file():
            raise ImageError("image path must be a regular file")
        size = src.stat().st_size
    except OSError as exc:
        raise ImageError("image path could not be read") from exc
    if size <= 0 or size > MAX_BYTES:
        raise ImageError(f"image file must be 1..{MAX_BYTES} bytes")
    data = src.read_bytes()
    kind, width, height = _identify(data)
    if kind is None:
        raise ImageError("image must be PNG, JPEG, GIF, WebP, BMP, or PPM")
    return LoadedImage(src, data, kind, width, height)


def _identify(data: bytes) -> tuple[str | None, int | None, int | None]:
    if data.startswith(b"\x89PNG\r\n\x1a\n") and len(data) >= 24 and data[12:16] == b"IHDR":
        width = int.from_bytes(data[16:20], "big")
        height = int.from_bytes(data[20:24], "big")
        return "png", _side(width), _side(height)
    if data.startswith(b"\xff\xd8\xff"):
        return "jpeg", *_jpeg_size(data)
    if data.startswith((b"GIF87a", b"GIF89a")) and len(data) >= 10:
        return "gif", _side(int.from_bytes(data[6:8], "little")), _side(int.from_bytes(data[8:10], "little"))
    if data.startswith(b"BM") and len(data) >= 26:
        return "bmp", _side(int.from_bytes(data[18:22], "little")), _side(int.from_bytes(data[22:26], "little"))
    if data.startswith(b"RIFF") and data[8:12] == b"WEBP":
        return "webp", None, None
    if data.startswith(b"P6"):
        return "ppm", *_pnm_size(data)
    return None, None, None


def _side(value: int) -> int | None:
    if 1 <= value <= 8192:
        return value
    return None


def _pnm_size(data: bytes) -> tuple[int | None, int | None]:
    tokens: list[bytes] = []
    index = 0
    head = data[:256]
    while index < len(head) and len(tokens) < 4:
        byte = head[index : index + 1]
        if byte == b"#":
            newline = head.find(b"\n", index)
            if newline < 0:
                break
            index = newline + 1
            continue
        if byte in (b" ", b"\t", b"\r", b"\n"):
            index += 1
            continue
        end = index
        while end < len(head) and head[end : end + 1] not in (b" ", b"\t", b"\r", b"\n", b"#"):
            end += 1
        tokens.append(head[index:end])
        index = end
    if len(tokens) < 3 or tokens[0] != b"P6":
        return None, None
    try:
        return _side(int(tokens[1])), _side(int(tokens[2]))
    except ValueError:
        return None, None


def _jpeg_size(data: bytes) -> tuple[int | None, int | None]:
    index = 2
    while index + 9 < len(data):
        if data[index] != 0xFF:
            index += 1
            continue
        marker = data[index + 1]
        if marker in (0xC0, 0xC1, 0xC2):
            height = int.from_bytes(data[index + 5 : index + 7], "big")
            width = int.from_bytes(data[index + 7 : index + 9], "big")
            return _side(width), _side(height)
        if marker == 0xD8 or marker == 0xD9:
            index += 2
            continue
        if index + 4 > len(data):
            break
        length = int.from_bytes(data[index + 2 : index + 4], "big")
        if length < 2:
            break
        index += 2 + length
    return None, None
