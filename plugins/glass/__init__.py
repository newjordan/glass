"""Hermes plugin for session-scoped Glass visual terminal displays.

``rendered`` and ``confirmed`` are true only after Glass answers OK for the
placement op. When no Glass terminal is available, tools return plain text or a
local fallback artifact without claiming an on-screen frame.
"""

from __future__ import annotations

import json
import os
from pathlib import Path

try:
    from . import board
    from . import claims as claims_mod
except ImportError:  # unit tests and cli, plugin dir on sys.path
    import board
    import claims as claims_mod


_LIVE: set[str] = set()

_MESH_ENUM = [
    "quad",
    "cube",
    "plane",
    "gem",
    "wedge",
    "gable",
    "hip",
    "pyramid",
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
]


def register(ctx) -> None:
    show_desc = (
        "Show or update this session's bar chart in its bound Glass terminal. "
        "rendered and confirmed are true only when Glass answers OK; otherwise returns text and a fallback PPM at artifact_path."
    )
    ctx.register_tool(
        name="glass_show",
        toolset="glass",
        schema=_schema(
            "glass_show",
            show_desc,
            {
                "title": {"type": "string", "description": "Chart title (1 to 28 letters, digits, or spaces)."},
                "series": {
                    "type": "string",
                    "description": "Comma-separated name=value pairs (1 to 6 bars), e.g. 'alpha=3, beta=8'.",
                },
                "tty": {"type": "string", "description": "Optional Glass pty path if not already bound."},
            },
            ["title", "series"],
        ),
        handler=_show,
        description=show_desc,
    )

    image_desc = (
        "Show an image file (PNG, JPEG, GIF, WebP, BMP, or PPM up to 750 KB) in this session's Glass terminal. "
        "rendered and confirmed are true only when Glass answers OK."
    )
    ctx.register_tool(
        name="glass_image",
        toolset="glass",
        schema=_schema(
            "glass_image",
            image_desc,
            {
                "path": {"type": "string", "description": "Path to the image file."},
                "tty": {"type": "string", "description": "Optional Glass pty path if not already bound."},
            },
            ["path"],
        ),
        handler=_image,
        description=image_desc,
    )

    page_desc = (
        "Display a text page in this session's Glass showcase. "
        "rendered and confirmed are true only when Glass accepts the page op."
    )
    ctx.register_tool(
        name="glass_page",
        toolset="glass",
        schema=_schema(
            "glass_page",
            page_desc,
            {
                "text": {"type": "string", "description": "Page text (up to 256 lines of 256 columns)."},
                "tty": {"type": "string", "description": "Optional Glass pty path if not already bound."},
            },
            ["text"],
        ),
        handler=_page,
        description=page_desc,
    )

    scene_desc = (
        "Render a 3D mesh or multi-piece stage in the bound Glass terminal. "
        "rendered and confirmed are true only after Glass answers OK for the scene; moved is true only if spin tween is also accepted."
    )
    ctx.register_tool(
        name="glass_scene",
        toolset="glass",
        schema=_schema(
            "glass_scene",
            scene_desc,
            {
                "mesh": {"type": "string", "enum": _MESH_ENUM, "description": "Mesh kind (default 'cube'). Ignored when stage or pieces is set."},
                "stage": {"type": "string", "enum": ["court"], "description": "Preset stage ('court' = ground, gem, and sphere)."},
                "pieces": {"type": "string", "description": "2 to 6 semicolon-separated pieces as mesh[@x,y,z][*sx,sy,sz][#RRGGBB]."},
                "color": {"type": "string", "description": "Hex color RRGGBB (default ff6633)."},
                "finish": {"type": "string", "enum": ["plain", "chrome", "mercury"], "description": "Material finish (default 'plain')."},
                "spin": {"type": "boolean", "description": "Yoyo-spin the root node after scene OK."},
                "width": {"type": "integer", "description": "Render width in pixels (default 320)."},
                "height": {"type": "integer", "description": "Render height in pixels (default 240)."},
                "x": {"type": "integer", "description": "Window x in pixels (default 48)."},
                "y": {"type": "integer", "description": "Window y in pixels (default 48)."},
                "tty": {"type": "string", "description": "Optional Glass pty path if not already bound."},
            },
            [],
        ),
        handler=_scene,
        description=scene_desc,
    )

    model_desc = (
        "Upload and render a .glb or embedded .gltf 3D model in the bound Glass terminal. "
        "uploaded, rendered, confirmed, and played are true only after their respective Glass OK replies."
    )
    ctx.register_tool(
        name="glass_model",
        toolset="glass",
        schema=_schema(
            "glass_model",
            model_desc,
            {
                "path": {"type": "string", "description": "Path to a .glb or embedded .gltf file."},
                "play": {"type": "boolean", "description": "Play animation clip 0 after scene OK."},
                "clip": {"type": "string", "description": "Animation clip index or 'all' (implies play)."},
                "speed": {"type": "number", "description": "Playback speed (-16 to 16)."},
                "loop": {"type": "boolean", "description": "Loop the animation clip."},
                "spin": {"type": "boolean", "description": "Yoyo-spin the root node after scene OK."},
                "color": {"type": "string", "description": "Optional RRGGBB tint."},
                "finish": {"type": "string", "enum": ["plain", "chrome", "mercury"], "description": "Material finish."},
                "width": {"type": "integer", "description": "Panel width in pixels (default 320)."},
                "height": {"type": "integer", "description": "Panel height in pixels (default 240)."},
                "x": {"type": "integer", "description": "Window x in pixels (default 48)."},
                "y": {"type": "integer", "description": "Window y in pixels (default 48)."},
                "tty": {"type": "string", "description": "Optional Glass pty path if not already bound."},
            },
            ["path"],
        ),
        handler=_model,
        description=model_desc,
    )

    tween_desc = (
        "Animate the active 3D scene root rotation or camera eye position. "
        "moved and confirmed are true only after Glass answers OK for the tween."
    )
    ctx.register_tool(
        name="glass_tween",
        toolset="glass",
        schema=_schema(
            "glass_tween",
            tween_desc,
            {
                "yaw": {"type": "number", "description": "Target yaw angle in degrees (default 180). Ignored when eye is set."},
                "eye": {"type": "string", "description": "Camera eye x,y,z target (e.g. '2.4,1.6,3.2')."},
                "ease": {"type": "string", "enum": ["spring", "sine", "linear", "cubic", "bounce"], "description": "Easing curve (default 'spring')."},
                "forever": {"type": "boolean", "description": "Yoyo repeat forever (default true)."},
                "tty": {"type": "string", "description": "Optional Glass pty path if not already bound."},
            },
            [],
        ),
        handler=_tween,
        description=tween_desc,
    )

    frame_desc = (
        "Open a video panel in the bound Glass terminal and push a frame (image file or test color bars). "
        "opened, rendered, and confirmed are true only after Glass answers OK."
    )
    ctx.register_tool(
        name="glass_frame",
        toolset="glass",
        schema=_schema(
            "glass_frame",
            frame_desc,
            {
                "path": {"type": "string", "description": "Optional image path for the frame; omit for test color bars."},
                "width": {"type": "integer", "description": "Panel width in pixels (default 320)."},
                "height": {"type": "integer", "description": "Panel height in pixels (default 180)."},
                "t": {"type": "number", "description": "Optional progress playhead (0 to 1)."},
                "pause": {"type": "boolean", "description": "Optional pause state."},
                "tty": {"type": "string", "description": "Optional Glass pty path if not already bound."},
            },
            [],
        ),
        handler=_frame,
        description=frame_desc,
    )

    layer_desc = (
        "Place a live visual overlay (glow, particles, ring, line, prim, or solid) on the bound Glass terminal without removing active panels. "
        "rendered and confirmed are true only after Glass answers OK."
    )
    ctx.register_tool(
        name="glass_layer",
        toolset="glass",
        schema=_schema(
            "glass_layer",
            layer_desc,
            {
                "kind": {"type": "string", "enum": ["glow", "particles", "ring", "line", "prim", "solid"], "description": "Overlay effect kind (default 'glow')."},
                "color": {"type": "string", "description": "Hex color RRGGBB or RRGGBBAA (default 8844cc)."},
                "x": {"type": "integer", "description": "Window x in pixels (default 48)."},
                "y": {"type": "integer", "description": "Window y in pixels (default 48)."},
                "width": {"type": "integer", "description": "Width in pixels (default 320)."},
                "height": {"type": "integer", "description": "Height in pixels (default 180)."},
                "opacity": {"type": "number", "description": "Opacity 0 to 1."},
                "z": {"type": "integer", "description": "Depth order (-32768 to 32767; negative sits under text)."},
                "count": {"type": "integer", "description": "Particle count (particles only)."},
                "stroke": {"type": "number", "description": "Stroke width in pixels (ring/line only)."},
                "shape": {"type": "integer", "description": "Primitive shape 0 to 6 (prim only)."},
                "tty": {"type": "string", "description": "Optional Glass pty path if not already bound."},
            },
            [],
        ),
        handler=_layer,
        description=layer_desc,
    )

    events_desc = (
        "Arm or disarm Glass showcase event reporting and read operator events (clicks, seek, steps, dismissals, close) that arrived."
    )
    ctx.register_tool(
        name="glass_events",
        toolset="glass",
        schema=_schema(
            "glass_events",
            events_desc,
            {
                "arm": {"type": "boolean", "description": "True sends events=1; false sends events=0 (default true)."},
                "wait": {"type": "number", "description": "Seconds to listen for incoming events (0 to 8, default 0)."},
                "tty": {"type": "string", "description": "Optional Glass pty path if not already bound."},
            },
            [],
        ),
        handler=_events,
        description=events_desc,
    )

    bind_desc = (
        "Bind this Hermes session to a Glass pty after verifying a Glass hello handshake. Does not draw."
    )
    ctx.register_tool(
        name="glass_bind",
        toolset="glass",
        schema=_schema(
            "glass_bind",
            bind_desc,
            {"tty": {"type": "string", "description": "Character device path of the Glass pty (e.g. /dev/pts/1)."}},
            ["tty"],
        ),
        handler=_bind,
        description=bind_desc,
    )

    probe_desc = (
        "Probe whether a terminal pty speaks the Glass protocol and list its supported ops without drawing."
    )
    ctx.register_tool(
        name="glass_probe",
        toolset="glass",
        schema=_schema(
            "glass_probe",
            probe_desc,
            {"tty": {"type": "string", "description": "Optional pty path to probe if this session has not bound one."}},
            [],
        ),
        handler=_probe,
        description=probe_desc,
    )

    clear_desc = (
        "Remove this session's active Glass visuals and release its terminal claim. "
        "Pass all=true to wipe all visuals in one remove;all=1 frame. Confirmed only when Glass answers OK."
    )
    ctx.register_tool(
        name="glass_clear",
        toolset="glass",
        schema=_schema(
            "glass_clear",
            clear_desc,
            {
                "all": {"type": "boolean", "description": "If true, send remove;all=1 to wipe all session visuals in one op."},
            },
            [],
        ),
        handler=_clear,
        description=clear_desc,
    )

    ctx.register_command(
        "glass",
        _slash,
        "Show a chart in this session's Glass terminal, or print the text fallback",
        "<title> | <name=value, name=value>",
    )
    skill = Path(__file__).resolve().parent / "skills" / "glass-display" / "SKILL.md"
    if skill.is_file() and hasattr(ctx, "register_skill"):
        ctx.register_skill("display", skill, "Render verified charts, images, 3D scenes, models, and overlays in Glass.")
    if hasattr(ctx, "register_hook"):
        ctx.register_hook("on_session_start", _on_start)
        ctx.register_hook("on_session_end", _on_end)
        ctx.register_hook("on_session_finalize", _on_finalize)
        ctx.register_hook("on_session_reset", _on_finalize)


def _show(title: str = "", series: str = "", tty: str = "", **kwargs) -> str:
    session = _session(kwargs)
    return _dumps(
        board.show(
            session=session,
            title=title,
            series=series,
            claims=_claims(),
            tty_path=_tty(tty, session),
            timeout=_timeout(),
        )
    )


def _image(path: str = "", tty: str = "", **kwargs) -> str:
    session = _session(kwargs)
    return _dumps(
        board.show_image(
            session=session,
            path=path,
            claims=_claims(),
            tty_path=_tty(tty, session),
            timeout=_timeout(),
        )
    )


def _page(text: str = "", tty: str = "", **kwargs) -> str:
    session = _session(kwargs)
    return _dumps(
        board.show_page(
            session=session,
            text=text,
            claims=_claims(),
            tty_path=_tty(tty, session),
            timeout=_timeout(),
        )
    )


def _scene(
    mesh: str = "",
    stage: str = "",
    pieces: str = "",
    color: str = "",
    spin: bool = False,
    width: int = 320,
    height: int = 240,
    x: int = 48,
    y: int = 48,
    tty: str = "",
    chrome=None,
    liquid=None,
    segments=None,
    radius=None,
    seed=None,
    steps=None,
    posts=None,
    finish: str = "plain",
    **kwargs,
) -> str:
    session = _session(kwargs)
    try:
        spinning = _flag(spin, False)
    except ValueError as exc:
        return _dumps({"ok": False, "rendered": False, "confirmed": False, "moved": False, "reason": str(exc)})
    return _dumps(
        board.show_scene(
            session=session,
            mesh=mesh or None,
            pieces=pieces or None,
            stage=stage or None,
            color=color or None,
            claims=_claims(),
            tty_path=_tty(tty, session),
            width=width,
            height=height,
            x=x,
            y=y,
            spin=spinning,
            timeout=_timeout(),
            chrome=chrome,
            liquid=liquid,
            segments=segments,
            radius=radius,
            seed=seed,
            steps=steps,
            posts=posts,
            finish=finish,
        )
    )


def _model(
    path: str = "",
    play: bool = False,
    clip: str = "",
    speed: float | None = None,
    loop: bool | None = None,
    spin: bool = False,
    color: str = "",
    finish: str = "plain",
    width: int = 320,
    height: int = 240,
    x: int = 48,
    y: int = 48,
    tty: str = "",
    **kwargs,
) -> str:
    session = _session(kwargs)
    try:
        spinning = _flag(spin, False)
        playing = _flag(play, False)
    except ValueError as exc:
        return _dumps({"ok": False, "rendered": False, "confirmed": False, "uploaded": False, "played": False, "reason": str(exc)})
    return _dumps(
        board.show_model(
            session=session,
            path=path,
            claims=_claims(),
            tty_path=_tty(tty, session),
            timeout=_timeout(),
            width=width,
            height=height,
            x=x,
            y=y,
            spin=spinning,
            color=color or None,
            finish=finish or "plain",
            play=playing,
            clip=clip or None,
            speed=speed,
            loop=loop,
        )
    )


def _tween(yaw: float = 180, eye: str = "", ease: str = "spring", forever: bool = True, tty: str = "", **kwargs) -> str:
    session = _session(kwargs)
    try:
        repeating = _flag(forever, True)
    except ValueError as exc:
        return _dumps({"ok": False, "rendered": False, "confirmed": False, "moved": False, "reason": str(exc)})
    return _dumps(
        board.tween_scene(
            session=session,
            claims=_claims(),
            tty_path=_tty(tty, session),
            yaw=yaw,
            eye=eye or None,
            ease=ease,
            forever=repeating,
            timeout=_timeout(),
        )
    )


def _frame(
    width: int = 320,
    height: int = 180,
    t: float | None = None,
    pause: bool | None = None,
    path: str = "",
    tty: str = "",
    **kwargs,
) -> str:
    session = _session(kwargs)
    return _dumps(
        board.show_frame(
            session=session,
            claims=_claims(),
            tty_path=_tty(tty, session),
            timeout=_timeout(),
            width=width,
            height=height,
            t=t,
            pause=pause,
            path=path or None,
        )
    )


def _layer(
    kind: str = "glow",
    color: str = "",
    x: int = 48,
    y: int = 48,
    width: int = 320,
    height: int = 180,
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
    tty: str = "",
    **kwargs,
) -> str:
    session = _session(kwargs)
    return _dumps(
        board.show_layer(
            session=session,
            claims=_claims(),
            tty_path=_tty(tty, session),
            timeout=_timeout(),
            kind=kind or "glow",
            color=color or None,
            x=x,
            y=y,
            width=width,
            height=height,
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
        )
    )


def _events(arm: bool = True, wait: float = 0, tty: str = "", **kwargs) -> str:
    session = _session(kwargs)
    if arm is not True and arm is not False:
        return _dumps({"ok": False, "armed": False, "disarmed": False, "events": [], "count": 0, "reason": "arm must be true or false"})
    return _dumps(
        board.watch_events(
            session=session,
            claims=_claims(),
            tty_path=_tty(tty, session),
            timeout=_timeout(),
            arm=arm,
            wait=wait,
        )
    )


def _bind(tty: str = "", **kwargs) -> str:
    return _dumps(
        board.bind_session(session=_session(kwargs), tty_path=tty or None, claims=_claims(), timeout=_timeout())
    )


def _probe(tty: str = "", **kwargs) -> str:
    session = _session(kwargs)
    path = tty or _tty("", session)
    owned = session and _claims().path_for(session)
    if path and owned and path == owned and not tty:
        return _dumps(board.probe_bound(session=session, claims=_claims(), timeout=_timeout()))
    if path and not owned:
        return _dumps(board.bind_session(session=session, tty_path=path, claims=_claims(), timeout=_timeout()))
    if tty:
        return _dumps(board.bind_session(session=session, tty_path=tty, claims=_claims(), timeout=_timeout()))
    return _dumps(board.probe_bound(session=session, claims=_claims(), timeout=_timeout()))


def _clear(all: bool = False, **kwargs) -> str:
    try:
        wipe_all = _flag(all, False)
    except ValueError as exc:
        return _dumps({"ok": False, "cleared": False, "wiped": False, "confirmed": False, "reason": str(exc)})
    if wipe_all:
        return _dumps(board.wipe_session(session=_session(kwargs), claims=_claims(), timeout=_timeout()))
    return _dumps(board.clear(session=_session(kwargs), claims=_claims(), timeout=_timeout()))


def _wipe(**kwargs) -> str:
    return _dumps(board.wipe_session(session=_session(kwargs), claims=_claims(), timeout=_timeout()))


def _slash(raw_args: str) -> str:
    title, _, series = (raw_args or "").partition("|")
    return _show(title=title.strip(), series=series.strip())


def _on_start(session_id=None, **_kwargs) -> None:
    if session_id:
        _LIVE.add(str(session_id))


def _on_end(session_id=None, **_kwargs):
    # Hermes 0.19 fires this after every turn; real close is finalize.
    return None


def _on_finalize(session_id=None, **_kwargs) -> None:
    if not session_id:
        return
    session = str(session_id)
    _LIVE.discard(session)
    board.clear(session=session, claims=_claims(), timeout=_timeout())


def _session(kwargs: dict) -> str | None:
    sid = kwargs.get("session_id")
    if sid:
        return str(sid)
    if len(_LIVE) == 1:
        return next(iter(_LIVE))
    return None


def _tty(explicit: str, session: str | None) -> str | None:
    if explicit:
        return explicit
    if session and _claims().path_for(session):
        return _claims().path_for(session)
    return os.environ.get("GLASS_TTY") or None


def _claims() -> claims_mod.Claims:
    return claims_mod.Claims(_claims_path())


def _claims_path() -> Path:
    return claims_mod.runtime_claims_path()


def _flag(value, default: bool) -> bool:
    if isinstance(value, bool):
        return value
    if value is None or value == "":
        return default
    if isinstance(value, str):
        lowered = value.strip().lower()
        if lowered in ("1", "true", "yes", "on"):
            return True
        if lowered in ("0", "false", "no", "off"):
            return False
    raise ValueError("flag must be true or false")


def _timeout() -> float:
    raw = os.environ.get("GLASS_PROBE_TIMEOUT", "")
    try:
        value = float(raw) if raw else 1.0
    except ValueError:
        return 1.0
    if value <= 0 or value > 2:
        return 1.0
    return value


def _schema(name: str, description: str, properties: dict, required: list[str]) -> dict:
    return {
        "name": name,
        "description": description,
        "parameters": {
            "type": "object",
            "properties": properties,
            "required": required,
            "additionalProperties": False,
        },
    }


def _dumps(payload: dict) -> str:
    return json.dumps(payload, ensure_ascii=False) + "\n"
