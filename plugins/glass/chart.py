"""A small bar chart as RGB and as text.

The text form is the honest fallback. The RGB form is what Glass is
asked to show. Neither one claims the panel is on screen.
"""

from __future__ import annotations

import math
import re
from dataclasses import dataclass

WIDTH = 480
HEIGHT = 270
PLOT_X = 16
PLOT_Y = 48
PLOT_W = WIDTH - 32
PLOT_H = 168
LABEL_Y = PLOT_Y + PLOT_H + 8
MAX_BARS = 6
_NAME = re.compile(r"^[A-Za-z0-9][A-Za-z0-9 -]{0,9}$")
_TITLE = re.compile(r"^[A-Za-z0-9][A-Za-z0-9 -]{0,27}$")

BG = (0x12, 0x14, 0x1C)
PLOT = (0x1A, 0x20, 0x30)
AXIS = (0x3D, 0x46, 0x5C)
TEXT = (0xE8, 0xE6, 0xE3)
MUTED = (0x8B, 0x93, 0xA7)
PALETTE = (
    (0xE8, 0x5D, 0x4C),
    (0xF0, 0xA2, 0x02),
    (0x3D, 0xB8, 0x7A),
    (0x4C, 0x8D, 0xF6),
    (0xB0, 0x7C, 0xE8),
    (0xE8, 0x6B, 0xA0),
)

# 5x7 glyphs, bit 4 is the left pixel. Digits, A-Z, and the marks labels use.
_GLYPHS = {
    " ": (0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00),
    "-": (0x00, 0x00, 0x00, 0x1F, 0x00, 0x00, 0x00),
    ".": (0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x0C),
    "0": (0x0E, 0x11, 0x13, 0x15, 0x19, 0x11, 0x0E),
    "1": (0x04, 0x0C, 0x04, 0x04, 0x04, 0x04, 0x0E),
    "2": (0x0E, 0x11, 0x01, 0x02, 0x04, 0x08, 0x1F),
    "3": (0x0E, 0x11, 0x01, 0x06, 0x01, 0x11, 0x0E),
    "4": (0x02, 0x06, 0x0A, 0x12, 0x1F, 0x02, 0x02),
    "5": (0x1F, 0x10, 0x1E, 0x01, 0x01, 0x11, 0x0E),
    "6": (0x06, 0x08, 0x10, 0x1E, 0x11, 0x11, 0x0E),
    "7": (0x1F, 0x01, 0x02, 0x04, 0x08, 0x08, 0x08),
    "8": (0x0E, 0x11, 0x11, 0x0E, 0x11, 0x11, 0x0E),
    "9": (0x0E, 0x11, 0x11, 0x0F, 0x01, 0x02, 0x0C),
    "A": (0x0E, 0x11, 0x11, 0x1F, 0x11, 0x11, 0x11),
    "B": (0x1E, 0x11, 0x11, 0x1E, 0x11, 0x11, 0x1E),
    "C": (0x0E, 0x11, 0x10, 0x10, 0x10, 0x11, 0x0E),
    "D": (0x1E, 0x11, 0x11, 0x11, 0x11, 0x11, 0x1E),
    "E": (0x1F, 0x10, 0x10, 0x1E, 0x10, 0x10, 0x1F),
    "F": (0x1F, 0x10, 0x10, 0x1E, 0x10, 0x10, 0x10),
    "G": (0x0E, 0x11, 0x10, 0x17, 0x11, 0x11, 0x0E),
    "H": (0x11, 0x11, 0x11, 0x1F, 0x11, 0x11, 0x11),
    "I": (0x0E, 0x04, 0x04, 0x04, 0x04, 0x04, 0x0E),
    "J": (0x07, 0x02, 0x02, 0x02, 0x02, 0x12, 0x0C),
    "K": (0x11, 0x12, 0x14, 0x18, 0x14, 0x12, 0x11),
    "L": (0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x1F),
    "M": (0x11, 0x1B, 0x15, 0x15, 0x11, 0x11, 0x11),
    "N": (0x11, 0x19, 0x15, 0x13, 0x11, 0x11, 0x11),
    "O": (0x0E, 0x11, 0x11, 0x11, 0x11, 0x11, 0x0E),
    "P": (0x1E, 0x11, 0x11, 0x1E, 0x10, 0x10, 0x10),
    "Q": (0x0E, 0x11, 0x11, 0x11, 0x15, 0x12, 0x0D),
    "R": (0x1E, 0x11, 0x11, 0x1E, 0x14, 0x12, 0x11),
    "S": (0x0E, 0x11, 0x10, 0x0E, 0x01, 0x11, 0x0E),
    "T": (0x1F, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04),
    "U": (0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x0E),
    "V": (0x11, 0x11, 0x11, 0x11, 0x0A, 0x04, 0x04),
    "W": (0x11, 0x11, 0x11, 0x15, 0x15, 0x1B, 0x11),
    "X": (0x11, 0x11, 0x0A, 0x04, 0x0A, 0x11, 0x11),
    "Y": (0x11, 0x11, 0x0A, 0x04, 0x04, 0x04, 0x04),
    "Z": (0x1F, 0x01, 0x02, 0x04, 0x08, 0x10, 0x1F),
}


@dataclass(frozen=True)
class Bar:
    name: str
    value: float


@dataclass(frozen=True)
class Chart:
    title: str
    bars: tuple[Bar, ...]
    width: int
    height: int
    rgb: bytes
    text: str


def parse_series(value) -> list[Bar]:
    if isinstance(value, str):
        text = value.strip()
        if text.startswith("["):
            import json

            value = json.loads(text)
        else:
            value = [_pair(part) for part in text.split(",") if part.strip()]
    if not isinstance(value, list):
        raise ValueError("series must be a list or 'name=value' pairs")
    bars = [_bar(item) for item in value]
    if not 1 <= len(bars) <= MAX_BARS:
        raise ValueError(f"series must be 1 to {MAX_BARS} bars")
    return bars


def parse_title(value) -> str:
    title = " ".join(str(value or "").split())
    if not _TITLE.fullmatch(title):
        raise ValueError("title must be 1 to 28 letters, digits, or spaces")
    return title


def render(title: str, bars: list[Bar]) -> Chart:
    rgb = bytearray(WIDTH * HEIGHT * 3)
    _fill(rgb, 0, 0, WIDTH, HEIGHT, BG)
    _fill(rgb, PLOT_X, PLOT_Y, PLOT_W, PLOT_H, PLOT)
    for fraction in (0.25, 0.5, 0.75):
        line = PLOT_Y + PLOT_H - round(PLOT_H * fraction)
        _fill(rgb, PLOT_X, line, PLOT_W, 1, AXIS)
    _fill(rgb, PLOT_X, PLOT_Y + PLOT_H - 1, PLOT_W, 1, AXIS)
    _text(rgb, title.upper(), 16, 16, TEXT, 2)
    _text(rgb, f"{len(bars)} BAR" if len(bars) == 1 else f"{len(bars)} BARS", 16, 34, MUTED, 1)
    rects = layout(len(bars))
    peak = max(bar.value for bar in bars) or 1.0
    for index, (bar, rect) in enumerate(zip(bars, rects)):
        height = 2 if bar.value <= 0 else max(2, round(PLOT_H * bar.value / peak))
        color = PALETTE[index % len(PALETTE)]
        x, bar_w = rect
        y = PLOT_Y + PLOT_H - height
        _fill(rgb, x, y, bar_w, height, color)
        cap = min(3, height)
        _fill(rgb, x, y, bar_w, cap, _lift(color))
        label = bar.name.upper()
        _text(rgb, label, x, LABEL_Y, MUTED, 1)
        _text(rgb, format_value(bar.value), x, max(PLOT_Y, y - 10), TEXT, 1)
    return Chart(
        title=title,
        bars=tuple(bars),
        width=WIDTH,
        height=HEIGHT,
        rgb=bytes(rgb),
        text=render_text(title, bars),
    )


def marks(drawn: Chart) -> list[str]:
    """One Glass mark per bar, in content pixels. ``|`` splits the tip lines."""
    rects = layout(len(drawn.bars))
    peak = max(bar.value for bar in drawn.bars) or 1.0
    records = []
    for bar, (x, bar_w) in zip(drawn.bars, rects):
        height = 2 if bar.value <= 0 else max(2, round(PLOT_H * bar.value / peak))
        y = PLOT_Y + PLOT_H - height
        tip = f"{bar.name}|{format_value(bar.value)}"
        if ";" in tip or "\n" in tip:
            raise ValueError("mark tip cannot hold a field separator")
        records.append(f"mark;x={x};y={y};w={bar_w};h={height};t={tip}")
    return records


def render_text(title: str, bars: list[Bar]) -> str:
    peak = max(bar.value for bar in bars) or 1.0
    lines = [title]
    for bar in bars:
        blocks = 0 if bar.value <= 0 else max(1, round(12 * bar.value / peak))
        lines.append(f"{bar.name:<10} {'█' * blocks + '·' * (12 - blocks)} {format_value(bar.value)}")
    return "\n".join(lines)


def layout(count: int) -> tuple[tuple[int, int], ...]:
    gap = 12
    bar_w = (PLOT_W - gap * (count + 1)) // count
    return tuple((PLOT_X + gap + index * (bar_w + gap), bar_w) for index in range(count))


def format_value(value: float) -> str:
    if value >= 1_000_000:
        return _compact(value / 1_000_000, "M")
    if value >= 10_000:
        return _compact(value / 1_000, "K")
    if value == int(value):
        return str(int(value))
    return f"{value:.1f}"


def pixel(rgb: bytes, x: int, y: int) -> tuple[int, int, int]:
    index = (y * WIDTH + x) * 3
    return rgb[index], rgb[index + 1], rgb[index + 2]


def _compact(value: float, suffix: str) -> str:
    text = f"{value:.1f}"
    if text.endswith(".0"):
        text = text[:-2]
    return text + suffix


def _pair(part: str) -> dict:
    name, sep, raw = part.partition("=")
    if not sep:
        raise ValueError("series pair must be name=value")
    return {"name": name.strip(), "value": raw.strip()}


def _bar(item) -> Bar:
    if isinstance(item, Bar):
        name, raw = item.name, item.value
    elif isinstance(item, dict):
        name, raw = item.get("name", ""), item.get("value")
    else:
        raise ValueError("each bar needs a name and a value")
    name = " ".join(str(name).split())
    if not _NAME.fullmatch(name):
        raise ValueError("bar name must be 1 to 10 letters, digits, or spaces")
    try:
        value = float(raw)
    except (TypeError, ValueError) as exc:
        raise ValueError("bar value must be a finite number from 0 to 1e9") from exc
    if not math.isfinite(value) or value < 0 or value > 1_000_000_000:
        raise ValueError("bar value must be a finite number from 0 to 1e9")
    return Bar(name, value)


def _lift(color: tuple[int, int, int]) -> tuple[int, int, int]:
    return tuple(min(255, channel + 48) for channel in color)


def _fill(rgb: bytearray, x: int, y: int, width: int, height: int, color: tuple[int, int, int]) -> None:
    for row in range(max(0, y), min(HEIGHT, y + height)):
        for col in range(max(0, x), min(WIDTH, x + width)):
            index = (row * WIDTH + col) * 3
            rgb[index : index + 3] = color


def _text(rgb: bytearray, text: str, x: int, y: int, color: tuple[int, int, int], scale: int) -> None:
    cursor = x
    for char in text:
        glyph = _GLYPHS.get(char, _GLYPHS[" "])
        for row, bits in enumerate(glyph):
            for col in range(5):
                if bits & (1 << (4 - col)):
                    _fill(rgb, cursor + col * scale, y + row * scale, scale, scale, color)
        cursor += 6 * scale
