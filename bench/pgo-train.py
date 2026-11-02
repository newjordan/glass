#!/usr/bin/env python3
"""Mixed-session PGO training, deliberately separate from tput.py's workload.

Run INSIDE an instrumented terminal: pgo-train.py RECEIPT [SEED]. No speed
score is emitted. The receipt records bytes, seed and geometry; DA1 barriers
ensure the terminal processed every phase before it exits. Use profiles only
with the exact source/compiler that generated them, never as correctness proof.
"""
import hashlib
import json
import os
from pathlib import Path
import random
import sys
import termios
import time
import tty


def main():
    out = Path(sys.argv[1])
    seed = int(sys.argv[2]) if len(sys.argv) > 2 else 318731
    rng = random.Random(seed)
    fd = sys.stdin.fileno()
    saved = termios.tcgetattr(fd)
    cols, rows = os.get_terminal_size()
    digest = hashlib.sha256()
    total = 0

    def send(data):
        nonlocal total
        digest.update(data)
        total += len(data)
        view = memoryview(data)
        while view:
            n = os.write(sys.stdout.fileno(), view[:32768])
            view = view[n:]

    def barrier():
        send(b"\x1b[c")
        received = b""
        while not received.endswith(b"c"):
            part = os.read(fd, 64)
            if not part:
                raise EOFError("terminal closed before DA1 barrier")
            received += part
            if len(received) > 4096:
                raise RuntimeError("unexpected DA1 reply")

    began = time.monotonic()
    try:
        tty.setraw(fd)
        # Logs, shell/compiler output and decomposed/wide multilingual text.
        glyphs = list("file:: 0123456789/._- =>") + ["漢", "界", "🙂", "é", "Ж", "α", "a\u0301", "o\u0308"]
        for phase in range(6):
            lines = []
            for i in range(1800):
                text = "".join(rng.choice(glyphs) for _ in range(rng.randrange(30, 260)))
                if phase % 2:
                    text = f"\x1b[38;2;{rng.randrange(256)};{rng.randrange(256)};{rng.randrange(256)}m{text}\x1b[0m"
                lines.append((text + ("\r\n" if i % 5 else "\n")).encode())
            send(b"".join(lines))
            barrier()
        # Vary subregion origin/size; intermingle inserts, deletes and tabs.
        for _ in range(24):
            top = rng.randrange(1, max(2, rows // 2))
            bottom = rng.randrange(max(top + 1, rows // 2), max(top + 2, rows))
            send(f"\x1b[{top};{bottom}r\x1b[{top};1H".encode())
            for _ in range(6):
                body = []
                for i in range(160):
                    body.append((f"{i:06d}\t" + "x " * rng.randrange(10, max(11, cols)) + "\r\n").encode())
                send(b"".join(body))
            send(b"\x1b[2L\x1b[3M\x1b[r")
            barrier()
        # Full-screen apps, synchronized redraws, truecolor and cursor edits.
        send(b"\x1b[?1049h")
        for frame in range(240):
            parts = [b"\x1b[?2026h", b"\x1b[H"]
            for y in range(1, max(2, rows)):
                x = rng.randrange(1, max(2, cols - 20))
                color = rng.randrange(256)
                parts.append(f"\x1b[{y};{x}H\x1b[38;5;{color}mframe {frame:04d}: 漢字 a\u0301\x1b[K".encode())
            parts.extend([b"\x1b[0m", b"\x1b[?2026l"])
            send(b"".join(parts))
            if frame % 12 == 0:
                barrier()
        send(b"\x1b[?1049l\x1b[r\x1b[0m")
        barrier()
    finally:
        termios.tcsetattr(fd, termios.TCSANOW, saved)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps({"schema": "glass.pgo-training/v1", "seed": seed,
        "cols": cols, "rows": rows, "bytes": total, "sha256": digest.hexdigest(),
        "wall_s": time.monotonic() - began}, indent=2) + "\n")


if __name__ == "__main__":
    main()
