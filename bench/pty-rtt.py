#!/usr/bin/env python3
"""Quiet real-PTY DA1 round trips, not key-to-screen latency.

Run inside a terminal: pty-rtt.py OUTPUT [SAMPLES]. The terminal must reply to
DA1. Each sample starts after a quiet interval; CPU/compositor/input-injection
latency is outside this measure. No throughput score is emitted.
"""
import json
import os
from pathlib import Path
import select
import statistics
import sys
import termios
import time
import tty


def main():
    out = Path(sys.argv[1])
    n = int(sys.argv[2]) if len(sys.argv) > 2 else 300
    if n <= 0:
        raise ValueError("positive sample count required")
    fd = sys.stdin.fileno()
    saved = termios.tcgetattr(fd)
    samples = []
    reply = None
    try:
        tty.setraw(fd)
        for i in range(n + 20):
            time.sleep(0.003)
            start = time.perf_counter_ns()
            os.write(sys.stdout.fileno(), b"\x1b[c")
            answer = b""
            while not answer.endswith(b"c"):
                left = 2 - (time.perf_counter_ns() - start) / 1e9
                if left <= 0 or not select.select([fd], [], [], left)[0]:
                    raise TimeoutError("DA1 reply timed out")
                part = os.read(fd, 64)
                if not part:
                    raise EOFError("terminal closed before DA1 reply")
                answer += part
                if len(answer) > 256:
                    raise ValueError("oversized DA1 reply")
            elapsed = (time.perf_counter_ns() - start) / 1e6
            if not answer.startswith(b"\x1b[?"):
                raise ValueError(f"unexpected DA1 reply {answer!r}")
            if reply is not None and answer != reply:
                raise ValueError("DA1 reply changed")
            reply = answer
            if i >= 20:
                samples.append(elapsed)
    finally:
        termios.tcsetattr(fd, termios.TCSANOW, saved)
    ordered = sorted(samples)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps({"schema": "glass.pty-rtt/v1", "samples_ms": samples,
        "reply_hex": reply.hex(), "n": n, "quiet_ms": 3,
        "median_ms": statistics.median(samples), "p90_ms": ordered[int(n * .9)],
        "p99_ms": ordered[int(n * .99)], "min_ms": min(samples),
        "max_ms": max(samples)}, indent=2) + "\n")


if __name__ == "__main__":
    main()
