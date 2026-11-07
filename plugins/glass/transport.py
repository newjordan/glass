"""Write Glass frames to a session pty and read the reply.

Tool output is not a display. The only write path is an open terminal
the caller already bound. A scripted port is for tests; it never touches
a real tty.
"""

from __future__ import annotations

import errno
import os
import select
import termios
import time

try:
    from .dialect import find_reply, parse_events, probe_query
except ImportError:
    from dialect import find_reply, parse_events, probe_query


class GlassScript:
    """Answers like Glass, using the token the caller just wrote.

    ``mode`` is ``ok``, ``da1``, ``silent``, ``reject-picture``,
    ``reject-place``, ``reject-frame``, ``reject-progress``, ``reject-model``,
    or ``reject-tween``.
    Reads return immediately.
    """

    scripted = True

    def __init__(self, mode: str = "ok", ops: str | None = None) -> None:
        self.mode = mode
        self.ops = ops or "hello,picture,layer,group,remove,showcase"
        self.asset_extra = ""
        self.play_extra = ""
        self.writes: list[bytes] = []
        self._pending = b""
        self.inbox = b""
        self.later = b""
        self.picture_limit = None
        self.picture_oks = 0

    def write(self, data: bytes) -> None:
        self.writes.append(data)
        self._pending = data

    def read(self, timeout: float) -> bytes:
        del timeout
        data = self._pending
        self._pending = b""
        if not data or self.mode in {"silent", "timeout"}:
            if data and self.mode in {"silent", "timeout"}:
                return b""
            later = self.later
            self.later = b""
            return later
        if self.mode == "da1" and b"hello;" in data:
            return b"\x1b[?6c"
        token = _written_token(data)
        if token is None:
            return b""
        if b"picture;" in data and (
            self.mode == "reject-picture"
            or self.mode == "reject-wrap-picture"
            or (self.picture_limit is not None and self.picture_oks >= self.picture_limit)
        ):
            return _reply(token, "EINVAL:refused")
        if b"picture;" in data:
            self.picture_oks += 1
        if self.mode == "reject-place" and (
            b"showcase;" in data or b"layer;" in data or b"group;" in data
        ):
            return _reply(token, "EINVAL:refused")
        if self.mode == "reject-frame" and b"frame;" in data:
            return _reply(token, "EINVAL:refused")
        if self.mode == "reject-progress" and b"progress;" in data:
            return _reply(token, "EINVAL:refused")
        if self.mode == "reject-asset" and b"asset;" in data:
            return _reply(token, "EINVAL:refused")
        if self.mode == "reject-scene" and b"scene;" in data:
            return _reply(token, "EINVAL:refused")
        if self.mode == "reject-wrap-scene" and b"scene;" in data:
            return _reply(token, "EINVAL:refused")
        if self.mode == "reject-play" and b"play;" in data:
            return _reply(token, "EINVAL:refused")
        if self.mode == "reject-model" and b"model;" in data:
            return _reply(token, "EINVAL:refused")
        if self.mode == "reject-tween" and b"tween;" in data:
            return _reply(token, "EINVAL:refused")
        if self.mode == "reject-remove" and b"remove;" in data:
            return _reply(token, "EINVAL:refused")
        if b"hello;" in data:
            return _reply(token, f"OK;v=3,ops={self.ops}")
        if b"asset;" in data and self.asset_extra:
            return _reply(token, f"OK;{self.asset_extra}")
        if b"play;" in data and self.play_extra:
            return _reply(token, f"OK;{self.play_extra}")
        extra = self.inbox
        self.inbox = b""
        return extra + _reply(token, "OK")

    def close(self) -> None:
        return None


def _written_token(data: bytes) -> str | None:
    import re

    match = re.search(rb"(?:^|;)r=([A-Za-z0-9]{1,16})(?:;|\x1b|$)", data)
    if not match:
        return None
    return match.group(1).decode("ascii")


def _reply(token: str, status: str) -> bytes:
    return b"\x1b_glass;r=" + token.encode("ascii") + b";" + status.encode("ascii") + b"\x1b\\"


class ScriptedPort:
    """Queued reads. An empty queue ends the wait instead of sleeping."""

    scripted = True

    def __init__(self, replies: list[bytes] | None = None) -> None:
        self.replies = list(replies or [])
        self.writes: list[bytes] = []
        self.closed = False

    def write(self, data: bytes) -> None:
        self.writes.append(data)

    def read(self, timeout: float) -> bytes:
        del timeout
        if not self.replies:
            return b""
        return self.replies.pop(0)

    def close(self) -> None:
        self.closed = True


def write_all(fd: int, data: bytes, wait: float = 2.0) -> None:
    """Write every byte, waiting when the pty buffer is full.

    A chart frame is larger than a typical pty buffer. A non-blocking
    write then raises EAGAIN, and Glass never sees the picture.
    """
    view = memoryview(data)
    while view:
        try:
            wrote = os.write(fd, view)
        except BlockingIOError:
            _, writable, _ = select.select([], [fd], [], wait)
            if not writable:
                raise TimeoutError("terminal did not accept the frame")
            continue
        if wrote <= 0:
            raise OSError("terminal closed during write")
        view = view[wrote:]


class TtyPort:
    """Raw, non-blocking tty. Termios is restored on close."""

    scripted = False

    def __init__(self, path: str) -> None:
        self.path = path
        self.fd = os.open(path, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
        self.old = termios.tcgetattr(self.fd)
        updated = termios.tcgetattr(self.fd)
        updated[3] = updated[3] & ~(termios.ECHO | termios.ICANON | termios.ISIG)
        updated[6][termios.VMIN] = 0
        updated[6][termios.VTIME] = 0
        termios.tcsetattr(self.fd, termios.TCSANOW, updated)
        self._closed = False

    def write(self, data: bytes) -> None:
        write_all(self.fd, data)
        self._drain()

    def _drain(self) -> None:
        for _ in range(40):
            try:
                termios.tcdrain(self.fd)
                return
            except OSError as exc:
                if exc.errno != errno.EAGAIN:
                    raise
                _, writable, _ = select.select([], [self.fd], [], 0.05)

    def read(self, timeout: float) -> bytes:
        if timeout < 0:
            timeout = 0
        ready, _, _ = select.select([self.fd], [], [], timeout)
        if not ready:
            return b""
        try:
            return os.read(self.fd, 65536)
        except BlockingIOError:
            return b""

    def close(self) -> None:
        if self._closed:
            return
        self._closed = True
        try:
            termios.tcsetattr(self.fd, termios.TCSANOW, self.old)
        except OSError:
            pass
        finally:
            os.close(self.fd)


def read_for(port, timeout: float, stop) -> bytes:
    buf = b""
    deadline = time.monotonic() + timeout
    while not stop(buf):
        remaining = deadline - time.monotonic()
        if remaining <= 0:
            return buf
        chunk = port.read(remaining)
        if not chunk:
            return buf
        buf += chunk
    return buf


def exchange(port, payload: bytes, token: str, timeout: float):
    port.write(payload)
    buf = read_for(port, timeout, lambda data: find_reply(data, token) is not None)
    _capture(port, buf)
    return find_reply(buf, token), buf


def probe(port, token: str, timeout: float):
    try:
        from .dialect import da1_before_glass
    except ImportError:
        from dialect import da1_before_glass

    port.write(probe_query(token))
    buf = read_for(
        port,
        timeout,
        lambda data: find_reply(data, token) is not None or da1_before_glass(data),
    )
    _capture(port, buf)
    return find_reply(buf, token), buf


_KEEPER = None


def set_event_keeper(fn) -> None:
    global _KEEPER
    _KEEPER = fn


def drain(port, timeout: float) -> bytes:
    """Read until the wait ends. A scripted port returns what it already queued."""
    if timeout <= 0:
        return b""
    buf = read_for(port, timeout, lambda data: False)
    _capture(port, buf)
    return buf


def _capture(port, buf: bytes) -> None:
    events = parse_events(buf)
    if not events:
        return
    held = getattr(port, "kept_events", None)
    if held is None:
        try:
            port.kept_events = []
            held = port.kept_events
        except Exception:
            held = None
    if held is not None:
        held.extend(events)
    if getattr(port, "skip_keeper", False) or getattr(port, "scripted", False):
        return
    path = getattr(port, "path", None)
    keeper = getattr(port, "event_keeper", None)
    if keeper is None:
        keeper = _KEEPER
    if path and keeper:
        try:
            keeper(path, events)
        except Exception:
            return
