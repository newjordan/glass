"""One Glass pty belongs to one live Hermes session.

A claim file is the cross-process record. A dead pid is stale and may
be taken. A live other session is refused before any byte is written.
"""

from __future__ import annotations

import json
import os
from pathlib import Path

import fcntl

try:
    from .dialect import PICTURE_BASE
except ImportError:
    from dialect import PICTURE_BASE


class ClaimError(Exception):
    def __init__(self, reason: str) -> None:
        super().__init__(reason)
        self.reason = reason


def _extend_event_log(owner: dict, events: list) -> None:
    log = owner.get("event_log")
    if not isinstance(log, list):
        log = []
    for item in events:
        if isinstance(item, dict):
            log.append(dict(item))
    owner["event_log"] = log[-16:]


def pid_alive(pid: int) -> bool:
    if not isinstance(pid, int) or pid <= 0:
        return False
    try:
        os.kill(pid, 0)
    except OSError:
        return False
    return True


def runtime_claims_path() -> Path:
    """Claim file shared by the plugin and the CLI.

    GLASS_RUNTIME wins. Otherwise the file lives under XDG_RUNTIME_DIR, or
    /tmp/hermes-glass-<uid> when that is unset. A throwaway directory drops
    the bound tty and the fallback image before the next command.
    """
    override = os.environ.get("GLASS_RUNTIME")
    if override:
        return Path(override) / "claims.json"
    xdg = os.environ.get("XDG_RUNTIME_DIR")
    base = Path(xdg) if xdg else Path(f"/tmp/hermes-glass-{os.getuid()}")
    return base / "hermes-glass" / "claims.json"


class Claims:
    def __init__(self, path: Path, pid: int | None = None, alive=pid_alive) -> None:
        self.path = Path(path)
        self.pid = os.getpid() if pid is None else pid
        self.alive = alive

    def acquire(self, session: str, tty_key: str, path: str) -> None:
        def change(data: dict) -> None:
            ttys = data.setdefault("ttys", {})
            sessions = data.setdefault("sessions", {})
            self._drop_other_tty(ttys, sessions, session, tty_key)
            owner = ttys.get(tty_key)
            if (
                owner
                and owner.get("session") == session
                and owner.get("pid") != self.pid
                and self.alive(owner.get("pid", 0))
            ):
                raise ClaimError("this session is bound in another process")
            if owner and owner.get("session") != session and self.alive(owner.get("pid", 0)):
                raise ClaimError("glass terminal belongs to another hermes session")
            if owner and owner.get("session") != session:
                sessions.pop(owner.get("session"), None)
                owner = None
            kept = owner if owner and owner.get("session") == session else {}
            kept_owner = {
                "session": session,
                "pid": self.pid,
                "path": path,
                "picture": kept.get("picture"),
                "layer": kept.get("layer"),
                "kind": kept.get("kind"),
                "next": kept.get("next", PICTURE_BASE),
            }
            if kept.get("effect") is not None:
                kept_owner["effect"] = kept.get("effect")
            if kept.get("plate") is not None:
                kept_owner["plate"] = kept.get("plate")
            if kept.get("plate_layer") is not None:
                kept_owner["plate_layer"] = kept.get("plate_layer")
            if kept.get("wrap") is not None:
                kept_owner["wrap"] = kept.get("wrap")
            if kept.get("asset") is not None:
                kept_owner["asset"] = kept.get("asset")
            if kept.get("next_asset") is not None:
                kept_owner["next_asset"] = kept.get("next_asset")
            for key in ("group", "group_first", "group_count"):
                if key in kept:
                    kept_owner[key] = kept[key]
            if "events" in kept:
                kept_owner["events"] = bool(kept.get("events"))
            if isinstance(kept.get("event_log"), list):
                kept_owner["event_log"] = list(kept["event_log"])
            ttys[tty_key] = kept_owner
            sessions[session] = tty_key

        self._mutate(change)

    def release(self, session: str) -> None:
        def change(data: dict) -> None:
            sessions = data.setdefault("sessions", {})
            key = sessions.pop(session, None)
            if key is None:
                return
            owner = data.setdefault("ttys", {}).get(key)
            if owner and owner.get("session") == session:
                data["ttys"].pop(key, None)

        self._mutate(change)

    def owns(self, session: str, tty_key: str) -> bool:
        data = self._read()
        return data.get("sessions", {}).get(session) == tty_key

    def path_for(self, session: str) -> str | None:
        data = self._read()
        key = data.get("sessions", {}).get(session)
        if not key:
            return None
        owner = data.get("ttys", {}).get(key) or {}
        if owner.get("session") != session:
            return None
        return owner.get("path")

    def shown(self, session: str) -> tuple[int | None, int | None]:
        owner = self._owner(session)
        if not owner:
            return None, None
        return owner.get("picture"), owner.get("layer")

    def allocate(self, session: str) -> int:
        chosen: list[int] = []

        def change(data: dict) -> None:
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            nxt = int(owner.get("next", PICTURE_BASE))
            if nxt < PICTURE_BASE or nxt >= PICTURE_BASE + 0x10000:
                nxt = PICTURE_BASE
            owner["next"] = nxt + 1
            chosen.append(nxt)

        self._mutate(change)
        return chosen[0]

    def model_asset(self, session: str) -> int:
        """One asset id under 0x16000000, reused so a later model replaces it."""
        chosen: list[int] = []

        def change(data: dict) -> None:
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            current = owner.get("asset")
            if isinstance(current, int) and not isinstance(current, bool) and 1 <= current < PICTURE_BASE:
                chosen.append(current)
                return
            nxt = int(owner.get("next_asset", 1))
            if nxt < 1 or nxt >= PICTURE_BASE:
                nxt = 1
            owner["next_asset"] = nxt + 1
            owner["asset"] = nxt
            chosen.append(nxt)

        self._mutate(change)
        return chosen[0]

    def note_shown(
        self, session: str, picture: int, layer: int | None, kind: str = "chart"
    ) -> tuple[int | None, int | None]:
        previous: list[tuple[int | None, int | None]] = []

        def change(data: dict) -> None:
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            previous.append((owner.get("picture"), owner.get("layer")))
            owner["picture"] = picture
            owner["layer"] = layer
            owner["kind"] = kind if kind in ("chart", "image", "showcase", "scene", "video") else "chart"

        self._mutate(change)
        return previous[0]

    def note_effect(self, session: str, program_id: int) -> None:
        """Remember one overlay layer without dropping a chart, scene, or panel."""

        def change(data):
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            owner["effect"] = program_id

        self._mutate(change)

    def asset(self, session: str) -> int | None:
        owner = self._owner(session)
        if not owner:
            return None
        value = owner.get("asset")
        if isinstance(value, int) and not isinstance(value, bool):
            return value
        return None

    def effect(self, session: str) -> int | None:
        owner = self._owner(session)
        if not owner:
            return None
        value = owner.get("effect")
        if isinstance(value, int) and not isinstance(value, bool):
            return value
        return None

    def note_group(self, session: str, group_id: int, first: int, count: int) -> None:
        """Remember a replaced overlay set without dropping a picture or the single layer."""

        def change(data):
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            owner["group"] = group_id
            owner["group_first"] = first
            owner["group_count"] = count

        self._mutate(change)

    def group(self, session: str) -> tuple[int, int, int] | None:
        owner = self._owner(session)
        if not owner:
            return None
        group_id = owner.get("group")
        first = owner.get("group_first")
        count = owner.get("group_count")
        if (
            isinstance(group_id, int)
            and not isinstance(group_id, bool)
            and isinstance(first, int)
            and not isinstance(first, bool)
            and isinstance(count, int)
            and not isinstance(count, bool)
            and count >= 1
        ):
            return group_id, first, count
        return None

    def note_events(self, session: str, armed: bool) -> None:
        """Remember whether this session opted into showcase events."""

        def change(data):
            owner = self._owner_in(data, session)
            if owner is None:
                return
            owner["events"] = bool(armed)

        self._mutate(change)

    def events_armed(self, session: str) -> bool:
        owner = self._owner(session)
        return bool(owner and owner.get("events") is True)

    def append_events(self, session: str, events: list) -> None:
        def change(data):
            owner = self._owner_in(data, session)
            if owner is None:
                return
            _extend_event_log(owner, events)

        self._mutate(change)

    def append_events_for_path(self, path: str, events: list) -> None:
        def change(data):
            for owner in data.get("ttys", {}).values():
                if owner.get("path") == path:
                    _extend_event_log(owner, events)
                    return

        self._mutate(change)

    def take_events(self, session: str) -> list:
        found: list = []

        def change(data):
            owner = self._owner_in(data, session)
            if owner is None:
                return
            log = owner.get("event_log")
            if isinstance(log, list):
                found.extend(item for item in log if isinstance(item, dict))
            owner["event_log"] = []

        self._mutate(change)
        return found

    def clear_shown(self, session: str) -> tuple[int | None, int | None]:
        previous: list[tuple[int | None, int | None]] = []

        def change(data: dict) -> None:
            owner = self._owner_in(data, session)
            if owner is None:
                previous.append((None, None))
                return
            previous.append((owner.get("picture"), owner.get("layer")))
            owner["picture"] = None
            owner["layer"] = None
            owner["kind"] = None

        self._mutate(change)
        return previous[0]

    def kind(self, session: str) -> str | None:
        owner = self._owner(session)
        if not owner:
            return None
        return owner.get("kind")

    def allocate_faces(self, session: str, count: int = 6) -> list[int]:
        """Picture ids under 0x16000000 that a later attempt will not reuse."""
        if count < 1 or count > 6:
            raise ClaimError("faces need 1 to 6 picture ids")
        chosen: list[int] = []

        def change(data: dict) -> None:
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            noted = {
                item
                for item in owner.get("faces") or []
                if isinstance(item, int) and not isinstance(item, bool)
            }
            nxt = owner.get("next_face", 0x15000001)
            if not isinstance(nxt, int) or isinstance(nxt, bool) or nxt < 0x15000001:
                nxt = 0x15000001
            start = nxt
            while len(chosen) < count:
                if nxt >= 0x16000000:
                    nxt = 0x15000001
                if nxt not in noted and nxt not in chosen:
                    chosen.append(nxt)
                nxt += 1
                if nxt == start and len(chosen) < count:
                    raise ClaimError("no free face picture id")
            owner["next_face"] = nxt

        self._mutate(change)
        return chosen

    def note_faces(self, session: str, ids: list[int]) -> None:
        def change(data: dict) -> None:
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            owner["faces"] = list(ids)

        self._mutate(change)

    def faces(self, session: str) -> list[int]:
        owner = self._owner(session)
        if not owner:
            return []
        raw = owner.get("faces")
        if not isinstance(raw, list):
            return []
        return [item for item in raw if isinstance(item, int) and not isinstance(item, bool)]

    def note_wrap(self, session: str, picture_id: int) -> None:
        """Remember the picture a mesh cites. It is not the scene id."""

        def change(data):
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            owner["wrap"] = picture_id

        self._mutate(change)

    def wrap(self, session: str) -> int | None:
        owner = self._owner(session)
        if not owner:
            return None
        value = owner.get("wrap")
        return value if isinstance(value, int) and not isinstance(value, bool) else None

    def clear_wrap(self, session: str) -> None:
        def change(data):
            owner = self._owner_in(data, session)
            if owner is not None:
                owner.pop("wrap", None)

        self._mutate(change)

    def note_card(self, session: str, picture_id: int, layer_id: int) -> None:
        """Remember a named-image overlay. It is not the plate."""

        def change(data):
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            owner["card"] = picture_id
            owner["card_layer"] = layer_id

        self._mutate(change)

    def card(self, session: str) -> tuple[int, int] | None:
        owner = self._owner(session)
        if not owner:
            return None
        picture_id = owner.get("card")
        layer_id = owner.get("card_layer")
        if not isinstance(picture_id, int) or isinstance(picture_id, bool):
            return None
        if not isinstance(layer_id, int) or isinstance(layer_id, bool):
            return None
        return picture_id, layer_id

    def clear_card(self, session: str) -> None:
        def change(data):
            owner = self._owner_in(data, session)
            if owner is not None:
                owner.pop("card", None)
                owner.pop("card_layer", None)

        self._mutate(change)

    def note_plate(self, session: str, picture_id: int, layer_id: int) -> None:
        def change(data: dict) -> None:
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            owner["plate"] = picture_id
            owner["plate_layer"] = layer_id

        self._mutate(change)

    def plate(self, session: str) -> tuple[int, int] | None:
        owner = self._owner(session)
        if not owner:
            return None
        picture_id = owner.get("plate")
        layer_id = owner.get("plate_layer")
        if not isinstance(picture_id, int) or isinstance(picture_id, bool):
            return None
        if not isinstance(layer_id, int) or isinstance(layer_id, bool):
            return None
        return picture_id, layer_id

    def clear_plate(self, session: str) -> None:
        def change(data: dict) -> None:
            owner = self._owner_in(data, session)
            if owner is None:
                return
            owner.pop("plate", None)
            owner.pop("plate_layer", None)

        self._mutate(change)

    def clear_faces(self, session: str) -> list[int]:
        found: list[int] = []

        def change(data: dict) -> None:
            owner = self._owner_in(data, session)
            if owner is None:
                return
            raw = owner.get("faces")
            if isinstance(raw, list):
                found.extend(item for item in raw if isinstance(item, int) and not isinstance(item, bool))
            owner["faces"] = []

        self._mutate(change)
        return found

    def note_page(self, session: str) -> tuple[int | None, int | None]:
        previous: list[tuple[int | None, int | None]] = []

        def change(data: dict) -> None:
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            previous.append((owner.get("picture"), owner.get("layer")))
            owner["picture"] = None
            owner["layer"] = None
            owner["kind"] = "page"

        self._mutate(change)
        return previous[0]


    def note_view(self, session: str) -> tuple[int | None, int | None]:
        previous: list[tuple[int | None, int | None]] = []

        def change(data: dict) -> None:
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            previous.append((owner.get("picture"), owner.get("layer")))
            owner["picture"] = None
            owner["layer"] = None
            owner["kind"] = "view"

        self._mutate(change)
        return previous[0]

    def note_video(self, session: str) -> tuple[int | None, int | None]:
        previous: list[tuple[int | None, int | None]] = []

        def change(data: dict) -> None:
            owner = self._owner_in(data, session)
            if owner is None:
                raise ClaimError("session has no glass terminal")
            previous.append((owner.get("picture"), owner.get("layer")))
            owner["picture"] = None
            owner["layer"] = None
            owner["kind"] = "video"

        self._mutate(change)
        return previous[0]


    def _drop_other_tty(self, ttys: dict, sessions: dict, session: str, tty_key: str) -> None:
        current = sessions.get(session)
        if not current or current == tty_key:
            return
        owner = ttys.get(current) or {}
        if owner.get("session") != session:
            sessions.pop(session, None)
            return
        if owner.get("pid") != self.pid and self.alive(owner.get("pid", 0)):
            raise ClaimError("this session is bound in another process")
        ttys.pop(current, None)
        sessions.pop(session, None)

    def _owner(self, session: str) -> dict | None:
        return self._owner_in(self._read(), session)

    def _owner_in(self, data: dict, session: str) -> dict | None:
        key = data.get("sessions", {}).get(session)
        if not key:
            return None
        owner = data.get("ttys", {}).get(key)
        if not owner or owner.get("session") != session:
            return None
        return owner

    def _read(self) -> dict:
        if not self.path.is_file():
            return {"ttys": {}, "sessions": {}}
        try:
            return json.loads(self.path.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            return {"ttys": {}, "sessions": {}}

    def _mutate(self, change) -> None:
        self.path.parent.mkdir(parents=True, exist_ok=True)
        with self.path.open("a+", encoding="utf-8") as handle:
            fcntl.flock(handle, fcntl.LOCK_EX)
            try:
                handle.seek(0)
                raw = handle.read()
                data = json.loads(raw) if raw.strip() else {"ttys": {}, "sessions": {}}
                if not isinstance(data, dict):
                    data = {"ttys": {}, "sessions": {}}
                change(data)
                handle.seek(0)
                handle.truncate()
                handle.write(json.dumps(data, separators=(",", ":")))
                handle.flush()
            finally:
                fcntl.flock(handle, fcntl.LOCK_UN)
