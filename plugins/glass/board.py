"""Show, update, and clear one session's chart, image, page, or named 3D scene.

``rendered`` is true only after Glass answers OK for the placement.
A spin is ``moved`` only after a later tween OK. A missing terminal, a
foreign session, a DA1-only answer, or a missing OK do not claim a frame.
"""

from __future__ import annotations

import os
import secrets
import stat
from pathlib import Path

try:
    from . import image as image_mod
    from .chart import marks, parse_series, parse_title, render
    from .claims import ClaimError, Claims, runtime_claims_path
    from .dialect import (
        EFFECT_ID,
        tween_size,
        GROUP_ID,
        GROUP_LAYER_BASE,
        HUD,
        LAYER_OFFSET,
        PLATE_LAYER,
        PLATE_PICTURE,
        WRAP_PICTURE,
        CARD_LAYER,
        CARD_PICTURE,
        chart as chart_frame,
        close_showcase,
        da1_before_glass,
        effect_layer,
        group_frame,
        group_records,
        parse_group_pieces,
        remove_group,
        remove_span,
        layer_picture,
        layer_plate,
        layer_card,
        page as page_frame,
        parse_color,
        parse_src,
        picture,
        picture_file,
        remove,
        scene as scene_frame,
        scene_payload,
        flat_payload,
        lens_payload,
        parse_clear,
        parse_near,
        parse_far,
        parse_up,
        parse_ortho,
        parse_opacity,
        parse_scene_z,
        parse_cells,
        wrap_payload,
        mark_payload,
        mark_counts,
        die_payload,
        face_rgb,
        parse_face_colors,
        plate_card,
        showcase,
        COURT_PIECES,
        parse_pieces,
        stage_payload,
        tween_camera,
        tween_node,
        tween_shift,
        tween_turn,
        tween_veil,
        tween_look,
        tween_curve,
        parse_curve,
        tween_named,
        parse_named_ease,
        tween_glide,
        tween_float,
        tween_stop,
        parse_eyes,
        parse_shift,
        parse_turn,
        parse_veil,
        parse_look,
        parse_glide,
        parse_float,
        yaw_rot,
        asset as asset_frame,
        asset_summary,
        gltf_payload,
        play as play_frame,
        progress_frame,
        video_file,
        video_frame,
        video_showcase,
        view_model,
        events_frame,
        remove_all,
    )
    from .model import prepare_model
    from . import transport as transport_mod
    from .transport import TtyPort, exchange, probe
except ImportError:  # unit tests and cli, plugin dir on sys.path
    import image as image_mod
    from chart import marks, parse_series, parse_title, render
    from claims import ClaimError, Claims, runtime_claims_path
    from dialect import (
        EFFECT_ID,
        tween_size,
        GROUP_ID,
        GROUP_LAYER_BASE,
        HUD,
        LAYER_OFFSET,
        PLATE_LAYER,
        PLATE_PICTURE,
        WRAP_PICTURE,
        CARD_LAYER,
        CARD_PICTURE,
        chart as chart_frame,
        close_showcase,
        da1_before_glass,
        effect_layer,
        group_frame,
        group_records,
        parse_group_pieces,
        remove_group,
        remove_span,
        layer_picture,
        layer_plate,
        layer_card,
        page as page_frame,
        parse_color,
        parse_src,
        picture,
        picture_file,
        remove,
        scene as scene_frame,
        scene_payload,
        flat_payload,
        lens_payload,
        parse_clear,
        parse_near,
        parse_far,
        parse_up,
        parse_ortho,
        parse_opacity,
        parse_scene_z,
        parse_cells,
        wrap_payload,
        mark_payload,
        mark_counts,
        die_payload,
        face_rgb,
        parse_face_colors,
        plate_card,
        showcase,
        COURT_PIECES,
        parse_pieces,
        stage_payload,
        tween_camera,
        tween_node,
        tween_shift,
        tween_turn,
        tween_veil,
        tween_look,
        tween_curve,
        parse_curve,
        tween_named,
        parse_named_ease,
        tween_glide,
        tween_float,
        tween_stop,
        parse_eyes,
        parse_shift,
        parse_turn,
        parse_veil,
        parse_look,
        parse_glide,
        parse_float,
        yaw_rot,
        asset as asset_frame,
        asset_summary,
        gltf_payload,
        play as play_frame,
        progress_frame,
        video_file,
        video_frame,
        video_showcase,
        view_model,
        events_frame,
        remove_all,
    )
    from model import prepare_model
    import transport as transport_mod
    from transport import TtyPort, exchange, probe


def _keep_live_events(path, events) -> None:
    if not path or not events:
        return
    try:
        Claims(runtime_claims_path()).append_events_for_path(path, events)
    except Exception:
        return


transport_mod.set_event_keeper(_keep_live_events)


def show(
    *,
    session: str | None,
    title,
    series,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
) -> dict:
    try:
        chart = render(parse_title(title), parse_series(series))
    except ValueError as exc:
        return _result(False, reason=str(exc))
    artifact = _chart_file(claims, session, chart)

    def finish(result: dict) -> dict:
        return _attach_file(result, artifact)

    if not session:
        return finish(_result(False, reason="session required", text=chart.text, title=chart.title))
    path = tty_path or claims.path_for(session)
    key = tty_key
    if path and key is None:
        try:
            key = device_key(path)
        except OSError as exc:
            return finish(_result(
                False,
                session=session,
                title=chart.title,
                text=chart.text,
                reason=str(exc),
                fallback="text",
            ))
    if port is None and not path:
        return finish(_result(
            True,
            session=session,
            title=chart.title,
            text=chart.text,
            reason="no terminal bound. Tool output is not a display.",
            fallback="text",
        ))
    if key is None:
        return finish(_result(False, session=session, title=chart.title, text=chart.text, reason="terminal key required"))
    try:
        claims.acquire(session, key, path or key)
    except ClaimError as exc:
        return finish(_result(
            False,
            session=session,
            title=chart.title,
            text=chart.text,
            reason=exc.reason,
            fallback="text",
        ))
    opened = port
    close = False
    if opened is None:
        try:
            opened = TtyPort(path)
            close = True
        except OSError as exc:
            claims.release(session)
            return finish(_result(
                True,
                session=session,
                title=chart.title,
                text=chart.text,
                reason=f"terminal could not be opened: {exc}",
                fallback="text",
            ))
    try:
        try:
            return finish(_show_open(session, chart, claims, opened, timeout))
        except ClaimError as exc:
            return finish(_result(
                False,
                session=session,
                title=chart.title,
                text=chart.text,
                reason=exc.reason,
                fallback="text",
            ))
    finally:
        if close:
            opened.close()


def show_image(
    *,
    session: str | None,
    path,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 1.0,
) -> dict:
    """Show one image file. Glass decodes it. A local copy is not a frame."""
    try:
        loaded = image_mod.load_image(path)
    except image_mod.ImageError as exc:
        return _result(False, reason=str(exc), artifact="image")
    if not session:
        return _result(False, reason="session required", artifact="image")
    try:
        copied = image_mod.copy_image(claims.path, session, loaded)
    except OSError:
        copied = loaded.path
    artifact = str(copied)

    def finish(result: dict) -> dict:
        result["artifact"] = "image"
        result["artifact_path"] = artifact
        result["artifact_role"] = "copy" if result.get("rendered") else "fallback"
        if not result.get("rendered") and result.get("fallback") in (None, "text"):
            result["fallback"] = "file"
        return result

    tty = tty_path or claims.path_for(session)
    key = tty_key
    if tty and key is None:
        try:
            key = device_key(tty)
        except OSError as exc:
            return finish(_result(False, session=session, reason=str(exc), artifact="image"))
    if port is None and not tty:
        return finish(_result(
            True,
            session=session,
            reason="no terminal bound. The file is not on screen.",
            artifact="image",
        ))
    if key is None:
        return finish(_result(False, session=session, reason="terminal key required", artifact="image"))
    try:
        claims.acquire(session, key, tty or key)
    except ClaimError as exc:
        return finish(_result(False, session=session, reason=exc.reason, artifact="image"))
    opened = port
    close = False
    if opened is None:
        try:
            opened = TtyPort(tty)
            close = True
        except OSError as exc:
            claims.release(session)
            return finish(_result(
                True,
                session=session,
                reason=f"terminal could not be opened: {exc}",
                artifact="image",
            ))
    try:
        try:
            return finish(_show_image_open(session, loaded, claims, opened, timeout))
        except ClaimError as exc:
            return finish(_result(False, session=session, reason=exc.reason, artifact="image"))
    finally:
        if close:
            opened.close()


def _show_image_open(session: str, loaded: image_mod.LoadedImage, claims: Claims, port, timeout: float) -> dict:
    reply, buf = probe(port, _token(), timeout)
    if da1_before_glass(buf) or reply is None or not reply.ok:
        _release_if_unused(claims, session)
        reason = "terminal is not glass" if da1_before_glass(buf) else "terminal did not answer glass hello"
        if reply is not None and not reply.ok and not da1_before_glass(buf):
            reason = f"glass hello refused: {reply.code}"
        return _result(True, session=session, reason=reason, artifact="image", ops=() if reply is None else reply.ops)
    if "picture" not in reply.ops:
        _release_if_unused(claims, session)
        return _result(
            True,
            session=session,
            reason="glass has no picture op",
            ops=reply.ops,
            version=reply.version,
            artifact="image",
        )
    if _image_placement(loaded, 0x16000000, reply.ops, "aaaaaa") is None:
        _release_if_unused(claims, session)
        return _result(
            True,
            session=session,
            reason="glass cannot place an image",
            ops=reply.ops,
            version=reply.version,
            artifact="image",
        )
    picture_id = claims.allocate(session)
    token = _token()
    accepted, _ = exchange(port, picture_file(picture_id, loaded.data, token), token, timeout)
    if accepted is None or not accepted.ok:
        _remove_quiet(port, picture_id, None, timeout)
        _release_if_unused(claims, session)
        code = "no reply" if accepted is None else accepted.code
        return _result(
            True,
            session=session,
            reason=f"picture was not accepted: {code}",
            ops=reply.ops,
            artifact="image",
        )
    place_token = _token()
    placed = _image_placement(loaded, picture_id, reply.ops, place_token)
    frame, placement, layer_id = placed
    confirmed, _ = exchange(port, frame, place_token, timeout)
    if confirmed is None or not confirmed.ok:
        _remove_quiet(port, picture_id, layer_id, timeout)
        _release_if_unused(claims, session)
        return _result(
            True,
            session=session,
            reason="glass did not confirm the frame",
            ops=reply.ops,
            artifact="image",
        )
    kind = "showcase" if placement == "showcase" else "image"
    previous, previous_layer = claims.note_shown(session, picture_id, layer_id, kind=kind)
    if previous and previous != picture_id:
        _remove_quiet(port, previous, previous_layer, timeout)
    return _result(
        True,
        session=session,
        rendered=True,
        confirmed=True,
        placement=placement,
        picture=picture_id,
        reason="glass confirmed the frame",
        ops=reply.ops,
        version=reply.version,
        artifact="image",
    )


def bind_session(
    *,
    session: str | None,
    tty_path: str | None,
    claims: Claims,
    port=None,
    timeout: float = 0.35,
) -> dict:
    if not session:
        return _result(False, reason="session required")
    if not tty_path:
        return _result(False, session=session, reason="tty required. This plugin does not guess a terminal.")
    try:
        key = device_key(tty_path)
    except OSError as exc:
        return _result(False, session=session, reason=str(exc))
    try:
        claims.acquire(session, key, tty_path)
    except ClaimError as exc:
        return _result(False, session=session, reason=exc.reason)
    opened = port
    close = False
    if opened is None:
        try:
            opened = TtyPort(tty_path)
            close = True
        except OSError as exc:
            claims.release(session)
            return _result(False, session=session, reason=f"terminal could not be opened: {exc}")
    try:
        reply, buf = probe(opened, _token(), timeout)
        if da1_before_glass(buf):
            claims.release(session)
            return _result(True, session=session, reason="terminal is not glass", ops=())
        if reply is None or not reply.ok:
            claims.release(session)
            reason = "terminal did not answer glass hello" if reply is None else f"glass hello refused: {reply.code}"
            return _result(True, session=session, reason=reason, ops=())
        if "page" not in reply.ops and (
            "picture" not in reply.ops or not any(op in reply.ops for op in ("chart", "showcase", "layer"))
        ):
            claims.release(session)
            return _result(
                True,
                session=session,
                reason="glass hello did not list a placement op",
                ops=reply.ops,
                version=reply.version,
            )
        return _result(
            True,
            session=session,
            reason="glass answered hello",
            ops=reply.ops,
            version=reply.version,
            bound=True,
        )
    finally:
        if close:
            opened.close()


def probe_bound(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    timeout: float = 0.35,
) -> dict:
    """Ask a terminal this session already owns. Does not draw or release a shown chart."""
    if not session:
        return _result(False, reason="session required")
    path = claims.path_for(session)
    if not path:
        return _result(True, session=session, reason="no terminal bound. Tool output is not a display.")
    opened = port
    close = False
    if opened is None:
        try:
            opened = TtyPort(path)
            close = True
        except OSError as exc:
            return _result(True, session=session, reason=f"terminal could not be opened: {exc}", bound=True)
    try:
        reply, buf = probe(opened, _token(), timeout)
    finally:
        if close:
            opened.close()
    if da1_before_glass(buf):
        return _result(True, session=session, reason="terminal is not glass", bound=True)
    if reply is None or not reply.ok:
        reason = "terminal did not answer glass hello" if reply is None else f"glass hello refused: {reply.code}"
        return _result(True, session=session, reason=reason, bound=True)
    return _result(
        True,
        session=session,
        reason="glass answered hello",
        ops=reply.ops,
        version=reply.version,
        bound=True,
    )


def show_scene(
    *,
    session: str | None,
    mesh: str | None = None,
    pieces: str | None = None,
    stage: str | None = None,
    color: str | None = None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    width: int = 320,
    height: int = 240,
    x: int = 48,
    y: int = 48,
    spin: bool = False,
    ease: str = "spring",
    chrome=None,
    liquid=None,
    segments=None,
    radius=None,
    seed=None,
    steps=None,
    posts=None,
    finish: str = "plain",
) -> dict:
    """Show one mesh, or a parented stage. ``moved`` is true only if a later tween is accepted."""
    names = None
    stage_label = None
    try:
        rgba = parse_color(color)
        width_px = _as_int(width, "width", 1, 2048)
        height_px = _as_int(height, "height", 1, 2048)
        origin_x = _as_int(x, "x", 0, 8192)
        origin_y = _as_int(y, "y", 0, 8192)
        if not isinstance(spin, bool):
            raise ValueError("spin must be true or false")
        if spin:
            tween_node(1, "a", yaw_rot(180), ease=ease)
        stage_name = str(stage or "").strip().lower()
        piece_text = str(pieces or "").strip()
        if stage_name and piece_text:
            raise ValueError("pass stage or pieces, not both")
        if stage_name:
            if stage_name != "court":
                raise ValueError("stage must be court")
            piece_text = COURT_PIECES
            stage_label = "court"
        elif piece_text:
            stage_label = "pieces"
        if piece_text:
            finish_name, chrome_amount, liquid_amount = _stage_finish(finish, chrome, liquid)
            payload = stage_payload(
                piece_text,
                chrome=chrome_amount,
                liquid=liquid_amount,
                segments=segments,
                radius=radius,
                seed=seed,
                steps=steps,
                posts=posts,
                auto_segments=finish_name == "mercury" and segments is None,
            )
            names = [item["mesh"] for item in parse_pieces(piece_text)]
            mesh_name = "stage"
            text = _stage_text(names, width_px, height_px, chrome_amount, liquid_amount)
        else:
            mesh_name = _mesh(mesh or "cube")
            chrome_amount, liquid_amount, shape_segments = _finish(
                finish,
                mesh_name,
                chrome,
                liquid,
                segments,
            )
            payload = scene_payload(
                mesh_name,
                rgba,
                chrome=chrome_amount,
                liquid=liquid_amount,
                segments=shape_segments,
                radius=radius,
                seed=seed,
                steps=steps,
                posts=posts,
            )
            text = _scene_text(mesh_name, rgba, width_px, height_px, chrome_amount, liquid_amount)
    except ValueError as exc:
        return _stamp(_result(False, reason=str(exc), artifact="scene"), mesh=None, moved=False)
    if not session:
        return _note_stage(
            _stamp(
                _result(False, reason="session required", text=text, artifact="scene"),
                mesh=mesh_name,
                moved=False,
            ),
            names,
            stage_label,
        )
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=text,
        artifact="scene",
        mesh=mesh_name,
    )
    if error is not None:
        return _note_stage(error, names, stage_label)
    try:
        try:
            return _note_stage(
                _show_scene_open(
                    session,
                    claims,
                    opened,
                    timeout,
                    mesh=mesh_name,
                    rgba=rgba,
                    text=text,
                    payload=payload,
                    width=width_px,
                    height=height_px,
                    x=origin_x,
                    y=origin_y,
                    spin=spin,
                    ease=ease,
                ),
                names,
                stage_label,
            )
        except ClaimError as exc:
            return _note_stage(
                _stamp(
                    _result(
                        False,
                        session=session,
                        text=text,
                        reason=exc.reason,
                        fallback="text",
                        artifact="scene",
                    ),
                    mesh=mesh_name,
                    moved=False,
                ),
                names,
                stage_label,
            )
        except OSError as exc:
            _release_if_unused(claims, session)
            return _note_stage(
                _stamp(
                    _result(
                        True,
                        session=session,
                        text=text,
                        reason=f"terminal closed during the scene: {exc}",
                        fallback="text",
                        artifact="scene",
                    ),
                    mesh=mesh_name,
                    moved=False,
                ),
                names,
                stage_label,
            )
    finally:
        if close and opened is not None:
            opened.close()



def _flat_note(result: dict, *, height) -> dict:
    accepted = bool(result.get("rendered") and result.get("confirmed"))
    result["flat"] = accepted
    result["ortho"] = height if accepted else None
    result["channels"] = ["ortho"] if accepted else []
    result["perspective"] = False if accepted else None
    return result


def show_flat(
    *,
    session: str | None,
    mesh: str | None = None,
    color: str | None = None,
    ortho,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    width: int = 320,
    height: int = 240,
    x: int = 48,
    y: int = 48,
    spin: bool = False,
    ease: str = "spring",
) -> dict:
    """Place one scene with an orthographic camera.

    ``flat`` is true only after the scene OK. ``ortho`` is the half-height
    this call built when that frame was accepted, not a measurement Glass
    reported. The orange cube envelope still sends ``fov`` and does not
    send ``ortho``.
    """
    mesh_name = str(mesh or "cube").strip().lower()
    height_world = None
    text = "flat"
    try:
        rgba = parse_color(color)
        width_px = _as_int(width, "width", 1, 2048)
        height_px = _as_int(height, "height", 1, 2048)
        origin_x = _as_int(x, "x", 0, 8192)
        origin_y = _as_int(y, "y", 0, 8192)
        if not isinstance(spin, bool):
            raise ValueError("spin must be true or false")
        if ortho is None or (isinstance(ortho, str) and not ortho.strip()):
            raise ValueError("ortho must be a number greater than 0 and at most 64")
        height_world = parse_ortho(ortho)
        payload = flat_payload(mesh_name, rgba, height_world)
        if spin:
            tween_node(1, "a", yaw_rot(180), ease=ease)
        text = f"orthographic {mesh_name} {width_px}x{height_px}"
    except ValueError as exc:
        return _flat_note(
            _stamp(
                _result(False, reason=str(exc), artifact="scene"),
                mesh=None,
                moved=False,
            ),
            height=None,
        )
    if not session:
        return _flat_note(
            _stamp(
                _result(False, reason="session required", text=text, artifact="scene"),
                mesh=mesh_name,
                moved=False,
            ),
            height=None,
        )
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=text,
        artifact="scene",
        mesh=mesh_name,
    )
    if error is not None:
        return _flat_note(error, height=None)
    try:
        try:
            shown = _show_scene_open(
                session,
                claims,
                opened,
                timeout,
                mesh=mesh_name,
                rgba=rgba,
                text=text,
                payload=payload,
                width=width_px,
                height=height_px,
                x=origin_x,
                y=origin_y,
                spin=spin,
                ease=ease,
            )
        except ClaimError as exc:
            shown = _stamp(
                _result(
                    False,
                    session=session,
                    text=text,
                    reason=exc.reason,
                    fallback="text",
                    artifact="scene",
                ),
                mesh=mesh_name,
                moved=False,
            )
        except OSError as exc:
            _release_if_unused(claims, session)
            shown = _stamp(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=f"terminal closed during the scene: {exc}",
                    fallback="text",
                    artifact="scene",
                ),
                mesh=mesh_name,
                moved=False,
            )
        return _flat_note(shown, height=height_world)
    finally:
        if close and opened is not None:
            opened.close()


def _mist_note(result: dict, *, opacity, depth, perspective) -> dict:
    accepted = bool(result.get("rendered") and result.get("confirmed"))
    result["misted"] = accepted
    result["faded"] = accepted
    result["depth"] = accepted and depth is not None
    result["opacity"] = opacity if accepted else None
    result["z"] = depth if accepted and depth is not None else None
    channels = []
    if accepted:
        channels.append("o")
        if depth is not None:
            channels.append("z")
    result["channels"] = channels
    result["perspective"] = True if accepted and perspective else (False if accepted else None)
    return result


def show_mist(
    *,
    session: str | None,
    mesh: str | None = None,
    color: str | None = None,
    opacity,
    z=None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    width: int = 320,
    height: int = 240,
    x: int = 48,
    y: int = 48,
    spin: bool = False,
    ease: str = "spring",
) -> dict:
    """Place one scene with opacity, and optional z-order, on the scene op.

    glass_scene and glass_flat omit o= and z=. This call always sends o=.
    z= is sent only when asked. The camera still sends fov. Placement is px=.
    """
    amount = None
    depth = None
    mesh_name = str(mesh or "cube").strip().lower()
    text = "mist"
    try:
        rgba = parse_color(color)
        width_px = _as_int(width, "width", 1, 2048)
        height_px = _as_int(height, "height", 1, 2048)
        origin_x = _as_int(x, "x", 0, 8192)
        origin_y = _as_int(y, "y", 0, 8192)
        if not isinstance(spin, bool):
            raise ValueError("spin must be true or false")
        if opacity is None or (isinstance(opacity, str) and not opacity.strip()):
            raise ValueError("opacity must be a number from 0 to 1")
        amount = parse_opacity(opacity)
        if z is not None and not (isinstance(z, str) and not z.strip()):
            depth = parse_scene_z(z)
        payload = scene_payload(mesh_name, rgba)
        if spin:
            tween_node(1, "a", yaw_rot(180), ease=ease)
        text = f"mist {mesh_name} {width_px}x{height_px}"
    except ValueError as exc:
        return _mist_note(
            _stamp(
                _result(False, reason=str(exc), artifact="scene"),
                mesh=None,
                moved=False,
            ),
            opacity=None,
            depth=None,
            perspective=False,
        )
    if not session:
        return _mist_note(
            _stamp(
                _result(False, reason="session required", text=text, artifact="scene"),
                mesh=mesh_name,
                moved=False,
            ),
            opacity=None,
            depth=None,
            perspective=False,
        )
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=text,
        artifact="scene",
        mesh=mesh_name,
    )
    if error is not None:
        return _mist_note(error, opacity=None, depth=None, perspective=False)
    try:
        try:
            shown = _show_scene_open(
                session,
                claims,
                opened,
                timeout,
                mesh=mesh_name,
                rgba=rgba,
                text=text,
                payload=payload,
                width=width_px,
                height=height_px,
                x=origin_x,
                y=origin_y,
                spin=spin,
                ease=ease,
                opacity=amount,
                depth=depth,
            )
        except ClaimError as exc:
            shown = _stamp(
                _result(
                    False,
                    session=session,
                    text=text,
                    reason=exc.reason,
                    fallback="text",
                    artifact="scene",
                ),
                mesh=mesh_name,
                moved=False,
            )
        except OSError as exc:
            _release_if_unused(claims, session)
            shown = _stamp(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=f"terminal closed during the scene: {exc}",
                    fallback="text",
                    artifact="scene",
                ),
                mesh=mesh_name,
                moved=False,
            )
        return _mist_note(shown, opacity=amount, depth=depth, perspective=True)
    finally:
        if close and opened is not None:
            opened.close()


def _dock_note(result: dict, *, cells, pinned: bool) -> dict:
    accepted = bool(result.get("rendered") and result.get("confirmed"))
    result["docked"] = accepted
    result["pinned"] = accepted and pinned
    result["cells"] = list(cells) if accepted and cells is not None else None
    result["channels"] = ["at", "anchor"] if accepted and pinned else ([] if not accepted else ["at"])
    result["perspective"] = True if accepted else None
    return result


def show_dock(
    *,
    session: str | None,
    mesh: str | None = None,
    color: str | None = None,
    at,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    width: int = 320,
    height: int = 240,
    spin: bool = False,
    ease: str = "spring",
) -> dict:
    """Place one scene with at= and anchor=window. Does not send px=, o=, or z=.

    The cell box is what this call built. An OK does not prove the scene is pinned on screen.
    """
    cells = None
    mesh_name = str(mesh or "cube").strip().lower()
    text = "dock"
    try:
        rgba = parse_color(color)
        width_px = _as_int(width, "width", 1, 2048)
        height_px = _as_int(height, "height", 1, 2048)
        if not isinstance(spin, bool):
            raise ValueError("spin must be true or false")
        if at is None or (isinstance(at, str) and not at.strip()):
            raise ValueError("at must be four numbers x,y,w,h")
        cells = parse_cells(at)
        payload = scene_payload(mesh_name, rgba)
        if spin:
            tween_node(1, "a", yaw_rot(180), ease=ease)
        text = f"dock {mesh_name} {width_px}x{height_px}"
    except ValueError as exc:
        return _dock_note(
            _stamp(_result(False, reason=str(exc), artifact="scene"), mesh=None, moved=False),
            cells=None,
            pinned=False,
        )
    if not session:
        return _dock_note(
            _stamp(
                _result(False, reason="session required", text=text, artifact="scene"),
                mesh=mesh_name,
                moved=False,
            ),
            cells=None,
            pinned=False,
        )
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=text,
        artifact="scene",
        mesh=mesh_name,
    )
    if error is not None:
        return _dock_note(error, cells=None, pinned=False)
    try:
        try:
            shown = _show_scene_open(
                session,
                claims,
                opened,
                timeout,
                mesh=mesh_name,
                rgba=rgba,
                text=text,
                payload=payload,
                width=width_px,
                height=height_px,
                x=0,
                y=0,
                spin=spin,
                ease=ease,
                cells=cells,
            )
        except ClaimError as exc:
            shown = _stamp(
                _result(
                    False,
                    session=session,
                    text=text,
                    reason=exc.reason,
                    fallback="text",
                    artifact="scene",
                ),
                mesh=mesh_name,
                moved=False,
            )
        except OSError as exc:
            _release_if_unused(claims, session)
            shown = _stamp(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=f"terminal closed during the scene: {exc}",
                    fallback="text",
                    artifact="scene",
                ),
                mesh=mesh_name,
                moved=False,
            )
        return _dock_note(shown, cells=cells, pinned=True)
    finally:
        if close and opened is not None:
            opened.close()


def _ride_note(result: dict, *, cells, anchor: str | None) -> dict:
    accepted = bool(result.get("rendered") and result.get("confirmed"))
    result["rode"] = accepted
    result["omitted"] = accepted and anchor == "omit"
    result["labeled"] = accepted and anchor == "text"
    result["pinned"] = False
    result["cells"] = list(cells) if accepted and cells is not None else None
    if not accepted or anchor not in ("omit", "text"):
        result["channels"] = None
    elif anchor == "text":
        result["channels"] = ["at", "anchor"]
    else:
        result["channels"] = ["at"]
    result["perspective"] = True if accepted else None
    return result


def show_ride(
    *,
    session: str | None,
    mesh: str | None = None,
    color: str | None = None,
    at,
    anchor: str = "omit",
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    width: int = 320,
    height: int = 240,
    spin: bool = False,
    ease: str = "spring",
) -> dict:
    """Place one scene with at= and no window pin. Does not send px=, o=, or z=.

    omit leaves anchor off the frame. text sends anchor=text. window is glass_dock.
    An OK does not prove the scene rides the text on screen.
    """
    cells = None
    mode = None
    mesh_name = str(mesh or "cube").strip().lower()
    text = "ride"
    try:
        rgba = parse_color(color)
        width_px = _as_int(width, "width", 1, 2048)
        height_px = _as_int(height, "height", 1, 2048)
        if not isinstance(spin, bool):
            raise ValueError("spin must be true or false")
        if anchor == "window":
            raise ValueError("window pin is glass_dock")
        if anchor not in ("omit", "text"):
            raise ValueError("anchor must be omit or text")
        mode = anchor
        if at is None or (isinstance(at, str) and not at.strip()):
            raise ValueError("at must be four numbers x,y,w,h")
        cells = parse_cells(at)
        payload = scene_payload(mesh_name, rgba)
        if spin:
            tween_node(1, "a", yaw_rot(180), ease=ease)
        scene_frame(
            1,
            payload,
            "a",
            width=width_px,
            height=height_px,
            x=0,
            y=0,
            cells=cells,
            anchor=mode,
        )
        text = f"ride {mesh_name} {width_px}x{height_px}"
    except ValueError as exc:
        return _ride_note(
            _stamp(_result(False, reason=str(exc), artifact="scene"), mesh=None, moved=False),
            cells=None,
            anchor=None,
        )
    if not session:
        return _ride_note(
            _stamp(
                _result(False, reason="session required", text=text, artifact="scene"),
                mesh=mesh_name,
                moved=False,
            ),
            cells=None,
            anchor=None,
        )
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=text,
        artifact="scene",
        mesh=mesh_name,
    )
    if error is not None:
        return _ride_note(error, cells=None, anchor=None)
    try:
        try:
            shown = _show_scene_open(
                session,
                claims,
                opened,
                timeout,
                mesh=mesh_name,
                rgba=rgba,
                text=text,
                payload=payload,
                width=width_px,
                height=height_px,
                x=0,
                y=0,
                spin=spin,
                ease=ease,
                cells=cells,
                anchor=mode,
            )
        except ClaimError as exc:
            shown = _stamp(
                _result(
                    False,
                    session=session,
                    text=text,
                    reason=exc.reason,
                    fallback="text",
                    artifact="scene",
                ),
                mesh=mesh_name,
                moved=False,
            )
        except OSError as exc:
            _release_if_unused(claims, session)
            shown = _stamp(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=f"terminal closed during the scene: {exc}",
                    fallback="text",
                    artifact="scene",
                ),
                mesh=mesh_name,
                moved=False,
            )
        return _ride_note(shown, cells=cells, anchor=mode)
    finally:
        if close and opened is not None:
            opened.close()



def _lens_note(result: dict, *, clear, near, far, up) -> dict:
    accepted = bool(result.get("rendered") and result.get("confirmed"))
    result["lensed"] = accepted
    result["backed"] = accepted and clear is not None
    result["clipped"] = accepted and (near is not None or far is not None)
    result["tilted"] = accepted and up is not None
    result["clear"] = list(clear) if accepted and clear is not None else None
    result["near"] = near if accepted else None
    result["far"] = far if accepted else None
    result["up"] = list(up) if accepted and up is not None else None
    if not accepted or clear is None:
        result["channels"] = None
    else:
        channels = ["clear"]
        if near is not None:
            channels.append("near")
        if far is not None:
            channels.append("far")
        if up is not None:
            channels.append("up")
        result["channels"] = channels
    result["perspective"] = True if accepted else None
    return result


def show_lens(
    *,
    session: str | None,
    mesh: str | None = None,
    color: str | None = None,
    clear,
    near=None,
    far=None,
    up=None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    width: int = 320,
    height: int = 240,
    x: int = 48,
    y: int = 48,
    spin: bool = False,
    ease: str = "spring",
) -> dict:
    """Place one scene whose camera sends a backdrop.

    clear is always sent. near, far, and up are sent only when asked.
    Placement is px=. The frame does not send ortho, o=, z=, or at=.
    An OK does not prove the backdrop is visible.
    """
    mesh_name = str(mesh or "cube").strip().lower()
    text = "lens"
    backdrop = None
    clip_near = None
    clip_far = None
    tilt = None
    try:
        rgba = parse_color(color)
        width_px = _as_int(width, "width", 1, 2048)
        height_px = _as_int(height, "height", 1, 2048)
        origin_x = _as_int(x, "x", 0, 8192)
        origin_y = _as_int(y, "y", 0, 8192)
        if not isinstance(spin, bool):
            raise ValueError("spin must be true or false")
        if clear is None or (isinstance(clear, str) and not str(clear).strip()):
            raise ValueError("clear must be a color")
        backdrop = parse_clear(clear)
        if near is not None and not (isinstance(near, str) and not str(near).strip()):
            clip_near = parse_near(near)
        if far is not None and not (isinstance(far, str) and not str(far).strip()):
            clip_far = parse_far(far, clip_near)
        if up is not None and not (isinstance(up, str) and not str(up).strip()):
            tilt = parse_up(up)
        payload = lens_payload(
            mesh_name,
            rgba,
            backdrop,
            near=clip_near,
            far=clip_far,
            up=tilt,
        )
        if spin:
            tween_node(1, "a", yaw_rot(180), ease=ease)
        scene_frame(
            1,
            payload,
            "a",
            width=width_px,
            height=height_px,
            x=origin_x,
            y=origin_y,
        )
        text = f"lens {mesh_name} {width_px}x{height_px}"
    except ValueError as exc:
        return _lens_note(
            _stamp(_result(False, reason=str(exc), artifact="scene"), mesh=None, moved=False),
            clear=None,
            near=None,
            far=None,
            up=None,
        )
    if not session:
        return _lens_note(
            _stamp(
                _result(False, reason="session required", text=text, artifact="scene"),
                mesh=mesh_name,
                moved=False,
            ),
            clear=None,
            near=None,
            far=None,
            up=None,
        )
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=text,
        artifact="scene",
        mesh=mesh_name,
    )
    if error is not None:
        return _lens_note(error, clear=None, near=None, far=None, up=None)
    try:
        try:
            shown = _show_scene_open(
                session,
                claims,
                opened,
                timeout,
                mesh=mesh_name,
                rgba=rgba,
                text=text,
                payload=payload,
                width=width_px,
                height=height_px,
                x=origin_x,
                y=origin_y,
                spin=spin,
                ease=ease,
            )
        except ClaimError as exc:
            shown = _stamp(
                _result(
                    False,
                    session=session,
                    text=text,
                    reason=exc.reason,
                    fallback="text",
                    artifact="scene",
                ),
                mesh=mesh_name,
                moved=False,
            )
        except OSError as exc:
            _release_if_unused(claims, session)
            shown = _stamp(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=f"terminal closed during the scene: {exc}",
                    fallback="text",
                    artifact="scene",
                ),
                mesh=mesh_name,
                moved=False,
            )
        return _lens_note(shown, clear=backdrop, near=clip_near, far=clip_far, up=tilt)
    finally:
        if close and opened is not None:
            opened.close()


def show_mark(
    *,
    session: str | None,
    claims: Claims,
    shape: str = "chevron",
    color: str | None = None,
    emissive: float = 0.4,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    width: int = 320,
    height: int = 240,
    x: int = 48,
    y: int = 48,
    spin: bool = False,
    ease: str = "spring",
) -> dict:
    """Show one inline triangle mesh. inline is true only after the scene OK."""
    name = str(shape or "").strip().lower()
    try:
        rgba = parse_color(color) if color else None
        width_px = _as_int(width, "width", 1, 2048)
        height_px = _as_int(height, "height", 1, 2048)
        origin_x = _as_int(x, "x", 0, 8192)
        origin_y = _as_int(y, "y", 0, 8192)
        if not isinstance(spin, bool):
            raise ValueError("spin must be true or false")
        if spin:
            tween_node(1, "a", yaw_rot(180), ease=ease)
        if rgba is None:
            tint = (1.0, 1.0, 1.0, 1.0) if name == "chevron" else (1.0, 0.72, 0.22, 1.0)
        else:
            tint = rgba
        payload = mark_payload(name, tint, emissive)
        vertices, triangles = mark_counts(payload)
    except ValueError as exc:
        return _mark_stamp(
            _stamp(_result(False, reason=str(exc), artifact="scene"), mesh=None, moved=False),
            shape=name,
            vertices=0,
            triangles=0,
        )
    text = _scene_text(name, tint, width_px, height_px)
    if not session:
        return _mark_stamp(
            _stamp(
                _result(False, reason="session required", text=text, artifact="scene"),
                mesh=None,
                moved=False,
            ),
            shape=name,
            vertices=vertices,
            triangles=triangles,
        )
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=text,
        artifact="scene",
        mesh="inline",
    )
    if error is not None:
        return _mark_stamp(error, shape=name, vertices=vertices, triangles=triangles)
    try:
        try:
            shown = _show_scene_open(
                session,
                claims,
                opened,
                timeout,
                mesh="inline",
                rgba=tint,
                text=text,
                payload=payload,
                width=width_px,
                height=height_px,
                x=origin_x,
                y=origin_y,
                spin=spin,
                ease=ease,
            )
        except ClaimError as exc:
            shown = _stamp(
                _result(
                    False,
                    session=session,
                    text=text,
                    reason=exc.reason,
                    fallback="text",
                    artifact="scene",
                ),
                mesh=None,
                moved=False,
            )
        except OSError as exc:
            _release_if_unused(claims, session)
            shown = _stamp(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=f"terminal closed during the scene: {exc}",
                    fallback="text",
                    artifact="scene",
                ),
                mesh=None,
                moved=False,
            )
        return _mark_stamp(shown, shape=name, vertices=vertices, triangles=triangles)
    finally:
        if close and opened is not None:
            opened.close()


def show_die(
    *,
    session: str | None,
    claims: Claims,
    faces: str | None = None,
    mesh: str = "roundcube",
    edge: str | None = "f0c040",
    edge_width: int | None = None,
    glow: float | None = 0.85,
    radius: float | None = None,
    segments: int | None = None,
    spin: bool = False,
    ease: str = "sine",
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    width: int = 320,
    height: int = 240,
    x: int = 48,
    y: int = 48,
) -> dict:
    """Upload 1x1 face pictures, then a cube that cites only the ids Glass accepted."""
    text = "faces"
    mesh_name = "roundcube"
    try:
        colors = parse_face_colors(faces)
        mesh_name = str(mesh or "roundcube").strip().lower()
        if mesh_name not in ("cube", "roundcube"):
            raise ValueError("faces mesh must be cube or roundcube")
        glow_amount = 0.85 if glow is None else glow
        if isinstance(glow_amount, bool) or not isinstance(glow_amount, (int, float)):
            raise ValueError("glow must be a number")
        if glow_amount < 0 or glow_amount > 1:
            raise ValueError("glow must be 0 to 1")
        if edge_width not in (None, 0):
            raise ValueError("this glass edge has color and glow, not width")
        radius_value = None if mesh_name == "cube" else (0.18 if radius is None else radius)
        segments_value = None if mesh_name == "cube" else (8 if segments is None else segments)
        if mesh_name == "roundcube":
            if isinstance(radius_value, bool) or not isinstance(radius_value, (int, float)):
                raise ValueError("radius must be a number")
            if not 0.02 <= float(radius_value) <= 0.45:
                raise ValueError("radius must be 0.02 to 0.45")
            segments_value = _as_int(segments_value, "segments", 1, 16)
        _as_int(width, "width", 1, 4096)
        _as_int(height, "height", 1, 4096)
        _as_int(x, "x", 0, 8192)
        _as_int(y, "y", 0, 8192)
        text = _faces_text(colors, mesh_name, width, height, glow_amount)
    except ValueError as exc:
        return _face_stamp(
            _stamp(
                _result(False, session=session, text=text, reason=str(exc), artifact="scene"),
                mesh=mesh,
                moved=False,
            )
        )
    if not session:
        return _face_stamp(
            _stamp(_result(False, reason="session required", text=text, artifact="scene"), mesh=mesh_name, moved=False)
        )
    opened, close, error = _claim_port(
        session, claims, port, tty_key, tty_path, text=text, artifact="scene", mesh=mesh_name
    )
    if error is not None:
        return _face_stamp(error)
    accepted_ids: list[int] = []
    noted = False
    try:
        reply, buf = probe(opened, _token(), timeout)
        missing = _faces_probe_reason(reply, buf)
        if missing:
            _release_if_unused(claims, session)
            return _face_stamp(
                _stamp(
                    _result(
                        True,
                        session=session,
                        text=text,
                        reason=missing,
                        fallback="text",
                        artifact="scene",
                        ops=() if reply is None else reply.ops,
                        version=None if reply is None else reply.version,
                    ),
                    mesh=mesh_name,
                    moved=False,
                )
            )
        wanted = [index for index, color in enumerate(colors) if color is not None]
        slots = claims.allocate_faces(session, len(wanted))
        face_ids: list[int | None] = [None] * 6
        for slot, index in zip(slots, wanted):
            token = _token()
            frame = picture(slot, face_rgb(colors[index]), 1, 1, token)
            accepted, _spent = exchange(opened, frame, token, timeout)
            if accepted is None or not accepted.ok:
                _remove_ids(opened, accepted_ids, timeout)
                accepted_ids.clear()
                code = "no reply" if accepted is None else accepted.code
                return _face_stamp(
                    _stamp(
                        _result(
                            True,
                            session=session,
                            text=text,
                            reason=f"face picture was not accepted: {code}",
                            fallback="text",
                            artifact="scene",
                            ops=reply.ops,
                            version=reply.version,
                        ),
                        mesh=mesh_name,
                        moved=False,
                    )
                )
            face_ids[index] = slot
            accepted_ids.append(slot)
        payload = die_payload(
            mesh_name,
            colors,
            face_ids,
            radius=radius_value,
            segments=segments_value,
            edge_color=edge,
            edge_width=None,
            edge_glow=glow_amount,
        )
        scene_id = claims.allocate(session)
        token = _token()
        frame = scene_frame(scene_id, payload, token, width=width, height=height, x=x, y=y)
        accepted, _spent = exchange(opened, frame, token, timeout)
        if accepted is None or not accepted.ok:
            _remove_quiet(opened, scene_id, None, timeout)
            _remove_ids(opened, accepted_ids, timeout)
            accepted_ids.clear()
            code = "no reply" if accepted is None else accepted.code
            return _face_stamp(
                _stamp(
                    _result(
                        True,
                        session=session,
                        text=text,
                        reason=f"scene was not accepted: {code}",
                        fallback="text",
                        artifact="scene",
                        ops=reply.ops,
                        version=reply.version,
                    ),
                    mesh=mesh_name,
                    moved=False,
                )
            )
        previous_kind = claims.kind(session)
        previous, previous_layer = claims.note_shown(session, scene_id, None, kind="scene")
        if previous and previous != scene_id:
            _remove_quiet(opened, previous, previous_layer, timeout)
        if previous_kind in ("page", "chart", "image", "showcase", "video"):
            close_token = _token()
            exchange(opened, close_showcase(close_token), close_token, timeout)
        stale = [item for item in claims.faces(session) if item not in accepted_ids]
        kept = list(accepted_ids)
        if stale and not _remove_ids(opened, stale, timeout):
            kept.extend(stale)
        claims.note_faces(session, kept)
        noted = True
        moved = False
        reason = "glass accepted the faced scene"
        if spin:
            if "tween" not in reply.ops:
                reason = "glass accepted the faced scene; hello did not list tween"
            else:
                moved, spin_reason = _send_spin(opened, scene_id, timeout, ease=ease)
                reason = spin_reason
        return _face_stamp(
            _stamp(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=reason,
                    rendered=True,
                    confirmed=True,
                    placement="scene",
                    picture=scene_id,
                    ops=reply.ops,
                    version=reply.version,
                    artifact="scene",
                ),
                mesh=mesh_name,
                moved=moved,
            ),
            pictures=len(accepted_ids),
            faces=len(accepted_ids),
            edge=glow_amount not in (0, 0.0),
        )
    except (OSError, ClaimError, ValueError) as exc:
        if accepted_ids and not noted:
            try:
                _remove_ids(opened, accepted_ids, timeout)
            except OSError:
                pass
        reason = exc.reason if isinstance(exc, ClaimError) else str(exc)
        return _face_stamp(
            _stamp(
                _result(False, session=session, text=text, reason=reason, fallback="text", artifact="scene"),
                mesh=mesh_name,
                moved=False,
            )
        )
    finally:
        if close and opened is not None:
            opened.close()


def tween_scene(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    yaw: float = 180,
    eye: str | None = None,
    ease: str = "spring",
    forever: bool = True,
) -> dict:
    """Move the scene already showing. Does not place a new one, and does not clear it if refused."""
    try:
        if not isinstance(forever, bool):
            raise ValueError("forever must be true or false")
        repeat = "forever" if forever else "once"
        camera = eye not in (None, "")
        rot = None if camera else yaw_rot(180 if yaw is None else yaw)
        if camera:
            tween_camera(1, "a", str(eye), ease=ease, repeat=repeat, yoyo=True)
        else:
            tween_node(1, "a", rot, ease=ease, repeat=repeat, yoyo=True)
    except ValueError as exc:
        return _stamp(_result(False, reason=str(exc), artifact="scene"), mesh=None, moved=False)
    if not session:
        return _stamp(_result(False, reason="session required", artifact="scene"), mesh=None, moved=False)
    if claims.kind(session) != "scene":
        return _stamp(
            _result(
                True,
                session=session,
                reason="no scene is showing. A tween was not sent.",
                artifact="scene",
            ),
            mesh=None,
            moved=False,
        )
    scene_id, _layer = claims.shown(session)
    if scene_id is None:
        return _stamp(
            _result(
                True,
                session=session,
                reason="no scene id is stored. A tween was not sent.",
                artifact="scene",
            ),
            mesh=None,
            moved=False,
        )
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=None,
        artifact="scene",
        mesh=None,
    )
    if error is not None:
        return error
    try:
        reply, buf = probe(opened, _token(), timeout)
        if reply is None or da1_before_glass(buf):
            reason = "terminal did not answer glass hello" if reply is None else "terminal is not glass"
            return _stamp(
                _result(True, session=session, reason=reason, artifact="scene", picture=scene_id),
                mesh=None,
                moved=False,
            )
        if not reply.ok or "tween" not in reply.ops:
            reason = (
                f"glass hello refused: {reply.code}"
                if not reply.ok
                else "glass hello did not list tween. A tween was not sent."
            )
            return _stamp(
                _result(
                    True,
                    session=session,
                    reason=reason,
                    artifact="scene",
                    picture=scene_id,
                    ops=reply.ops,
                    version=reply.version,
                ),
                mesh=None,
                moved=False,
            )
        token = _token()
        if camera:
            frame = tween_camera(scene_id, token, str(eye), ease=ease, repeat=repeat, yoyo=True)
        else:
            frame = tween_node(scene_id, token, rot, ease=ease, repeat=repeat, yoyo=True)
        accepted, _spent = exchange(opened, frame, token, timeout)
        if accepted is None or not accepted.ok:
            code = "no reply" if accepted is None else accepted.code
            return _stamp(
                _result(
                    True,
                    session=session,
                    reason=f"tween was not accepted: {code}",
                    artifact="scene",
                    picture=scene_id,
                    ops=reply.ops,
                    version=reply.version,
                ),
                mesh=None,
                moved=False,
            )
        return _stamp(
            _result(
                True,
                session=session,
                reason="glass accepted the tween",
                confirmed=True,
                placement="tween",
                picture=scene_id,
                ops=reply.ops,
                version=reply.version,
                artifact="scene",
            ),
            mesh=None,
            moved=True,
        )
    finally:
        if close and opened is not None:
            opened.close()


def chain_scene(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    eyes: str = "",
    ease: str = "sine",
    dur: float = 0.6,
    stop: bool = False,
    tid: int | None = None,
) -> dict:
    """Send a named camera chain, or stop one named tween. A refused step is the last write."""

    def quiet(reason: str) -> dict:
        result = _stamp(
            _result(False, session=session, reason=reason, artifact="scene"),
            mesh=None,
            moved=False,
        )
        result["chained"] = False
        result["stopped"] = False
        result["steps"] = 0
        return result

    try:
        if not isinstance(stop, bool):
            raise ValueError("stop must be true or false")
        if stop and str(eyes or "").strip():
            raise ValueError("stop does not take a new eye")
        if stop:
            if tid is None:
                raise ValueError("stop needs a tween id")
            if isinstance(tid, bool) or not isinstance(tid, int) or tid < 1 or tid > 64:
                raise ValueError("tween id must be 1 to 64")
            named = tid
            steps: list[str] = []
        else:
            steps = parse_eyes(eyes)
            named = None
            if ease not in {"linear", "spring", "sine", "cubic", "bounce"}:
                raise ValueError("ease must be linear, spring, sine, cubic, or bounce")
            if isinstance(dur, bool) or not isinstance(dur, (int, float)):
                raise ValueError("duration must be a number")
            if float(dur) != float(dur) or float(dur) < 0.05 or float(dur) > 8:
                raise ValueError("duration must be 0.05 to 8")
    except (TypeError, ValueError) as exc:
        return quiet(str(exc))
    if not session:
        return quiet("session required")
    if claims.kind(session) != "scene":
        return quiet("no scene is showing. A chain was not sent.")
    scene_id, _layer = claims.shown(session)
    if scene_id is None:
        return quiet("no scene id is stored. A chain was not sent.")
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=None,
        artifact="scene",
        mesh=None,
    )
    if error is not None:
        error["chained"] = False
        error["stopped"] = False
        error["steps"] = 0
        return error
    try:
        reply, buf = probe(opened, _token(), timeout)
        if reply is None or da1_before_glass(buf):
            reason = "terminal did not answer glass hello" if reply is None else "terminal is not glass"
            return quiet(reason)
        if not reply.ok or "tween" not in reply.ops:
            reason = (
                f"glass hello refused: {reply.code}"
                if not reply.ok
                else "glass hello did not list tween. A chain was not sent."
            )
            result = quiet(reason)
            result["ops"] = list(reply.ops)
            result["version"] = reply.version
            result["picture"] = scene_id
            return result
        if stop:
            token = _token()
            accepted, _spent = exchange(opened, tween_stop(token, named), token, timeout)
            stopped = accepted is not None and accepted.ok
            code = "no reply" if accepted is None else accepted.code
            result = _stamp(
                _result(
                    stopped,
                    session=session,
                    reason="glass accepted the stop" if stopped else f"tween was not accepted: {code}",
                    confirmed=stopped,
                    placement="tween" if stopped else "",
                    picture=scene_id,
                    ops=reply.ops,
                    version=reply.version,
                    artifact="scene",
                ),
                mesh=None,
                moved=False,
            )
            result["chained"] = False
            result["stopped"] = stopped
            result["steps"] = 0
            result["tid"] = named
            return result
        accepted_count = 0
        reason = "tween was not accepted: no reply"
        for index, eye in enumerate(steps, start=1):
            token = _token()
            frame = tween_camera(
                scene_id,
                token,
                eye,
                ease=ease,
                repeat=None,
                yoyo=False,
                tid=index,
                after=None if index == 1 else index - 1,
                dur=float(dur),
            )
            accepted, _spent = exchange(opened, frame, token, timeout)
            if accepted is None or not accepted.ok:
                code = "no reply" if accepted is None else accepted.code
                reason = f"tween was not accepted: {code}"
                break
            accepted_count += 1
        chained = accepted_count == len(steps)
        result = _stamp(
            _result(
                chained,
                session=session,
                reason="glass accepted the chain" if chained else reason,
                confirmed=chained,
                placement="tween" if chained else "",
                picture=scene_id,
                ops=reply.ops,
                version=reply.version,
                artifact="scene",
            ),
            mesh=None,
            moved=chained,
        )
        result["chained"] = chained
        result["stopped"] = False
        result["steps"] = accepted_count
        result["tids"] = list(range(1, accepted_count + 1))
        return result
    finally:
        if close and opened is not None:
            opened.close()


def shift_scene(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    at: str = "",
    scale: str = "",
    color: str = "",
    node: int = 1,
    ease: str = "sine",
    dur: float = 0.6,
    tid: int | None = None,
) -> dict:
    """Move one node already showing. at, scale, and color are one once-only tween.

    shifted, moved, and confirmed are true only after that tween OK. A missing
    tween op is not written. A refused tween is not claimed. This does not send
    rot, camera, repeat, or yoyo, so the spin frame is unchanged. channels is
    what this call built, not a count Glass reported. An OK does not prove the
    node has arrived.
    """

    def quiet(reason: str, *, channels: list[str] | None = None, node_id: int | None = None) -> dict:
        result = _stamp(
            _result(False, session=session, reason=reason, artifact="scene"),
            mesh=None,
            moved=False,
        )
        result["shifted"] = False
        result["stopped"] = False
        result["channels"] = channels or []
        result["node"] = node_id
        return result

    try:
        fields = parse_shift(at, scale, color)
        if isinstance(node, bool) or not isinstance(node, int) or node < 1 or node > 64:
            raise ValueError("node must be 1 to 64")
        node_id = node
        named = None
        if tid not in (None, ""):
            if isinstance(tid, bool) or not isinstance(tid, int) or tid < 1 or tid > 64:
                raise ValueError("tween id must be 1 to 64")
            named = tid
        if ease not in {"linear", "spring", "sine", "cubic", "bounce"}:
            raise ValueError("ease must be linear, spring, sine, cubic, or bounce")
        if isinstance(dur, bool) or not isinstance(dur, (int, float)):
            raise ValueError("duration must be a number")
        seconds = float(dur)
        if seconds != seconds or seconds < 0.05 or seconds > 8:
            raise ValueError("duration must be 0.05 to 8")
    except (TypeError, ValueError) as exc:
        return quiet(str(exc))
    channels = [key for key in ("at", "scale", "color") if key in fields]
    if not session:
        return quiet("session required", channels=channels, node_id=node_id)
    if claims.kind(session) != "scene":
        return quiet("no scene is showing. A shift was not sent.", channels=channels, node_id=node_id)
    scene_id, _layer = claims.shown(session)
    if scene_id is None:
        return quiet("no scene id is stored. A shift was not sent.", channels=channels, node_id=node_id)
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=None,
        artifact="scene",
        mesh=None,
    )
    if error is not None:
        error["shifted"] = False
        error["stopped"] = False
        error["channels"] = channels
        error["node"] = node_id
        return error
    try:
        reply, buf = probe(opened, _token(), timeout)
        if reply is None or da1_before_glass(buf):
            reason = "terminal did not answer glass hello" if reply is None else "terminal is not glass"
            return quiet(reason, channels=channels, node_id=node_id)
        if not reply.ok or "tween" not in reply.ops:
            reason = (
                f"glass hello refused: {reply.code}"
                if not reply.ok
                else "glass hello did not list tween. A shift was not sent."
            )
            result = quiet(reason, channels=channels, node_id=node_id)
            result["ops"] = list(reply.ops)
            result["version"] = reply.version
            result["picture"] = scene_id
            return result
        token = _token()
        try:
            frame = tween_shift(
                scene_id,
                token,
                node=node_id,
                at=fields.get("at"),
                scale=fields.get("scale"),
                color=fields.get("color"),
                ease=ease,
                dur=seconds,
                tid=named,
            )
        except ValueError as exc:
            return quiet(str(exc), channels=channels, node_id=node_id)
        accepted, _spent = exchange(opened, frame, token, timeout)
        shifted = accepted is not None and accepted.ok
        code = "no reply" if accepted is None else accepted.code
        result = _stamp(
            _result(
                shifted,
                session=session,
                reason="glass accepted the shift" if shifted else f"tween was not accepted: {code}",
                confirmed=shifted,
                placement="tween" if shifted else "",
                picture=scene_id,
                ops=reply.ops,
                version=reply.version,
                artifact="scene",
            ),
            mesh=None,
            moved=shifted,
        )
        result["shifted"] = shifted
        result["stopped"] = False
        result["channels"] = channels
        result["node"] = node_id
        return result
    finally:
        if close and opened is not None:
            opened.close()


def turn_scene(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    yaw=None,
    rot=None,
    node: int = 1,
    ease: str = "spring",
    dur: float | None = None,
    tid: int | None = None,
) -> dict:
    """Turn one node already showing. Once only. This is not the forever spin.

    turned, moved, and confirmed are true only after that tween OK. A missing
    tween op is not written. A refused tween is not claimed. This sends rot and
    does not send at, scale, color, camera, repeat, or yoyo. channels is what
    this call built, not a count Glass reported. An OK does not prove the node
    has arrived. dur is omitted unless asked, so a spring turn can match the
    published quarter-turn frame.
    """

    def quiet(reason: str, *, channels: list[str] | None = None, node_id: int | None = None) -> dict:
        result = _stamp(
            _result(False, session=session, reason=reason, artifact="scene"),
            mesh=None,
            moved=False,
        )
        result["turned"] = False
        result["stopped"] = False
        result["rendered"] = False
        result["channels"] = channels or []
        result["node"] = node_id
        return result

    try:
        if yaw in (None, "") and rot in (None, ""):
            yaw = 90
        parse_turn(yaw, rot)
        if isinstance(node, bool) or not isinstance(node, int) or node < 1 or node > 64:
            raise ValueError("node must be 1 to 64")
        node_id = node
        named = None
        if tid not in (None, ""):
            if isinstance(tid, bool) or not isinstance(tid, int) or tid < 1 or tid > 64:
                raise ValueError("tween id must be 1 to 64")
            named = tid
        if ease not in {"linear", "spring", "sine", "cubic", "bounce"}:
            raise ValueError("ease must be linear, spring, sine, cubic, or bounce")
        seconds = None
        if dur not in (None, ""):
            if isinstance(dur, bool) or not isinstance(dur, (int, float)):
                raise ValueError("duration must be a number")
            seconds = float(dur)
            if seconds != seconds or seconds < 0.05 or seconds > 8:
                raise ValueError("duration must be 0.05 to 8")
        elif ease != "spring":
            seconds = 0.6
    except (TypeError, ValueError) as exc:
        return quiet(str(exc))
    channels = ["rot"]
    if not session:
        return quiet("session required", channels=channels, node_id=node_id)
    if claims.kind(session) != "scene":
        return quiet("no scene is showing. A turn was not sent.", channels=channels, node_id=node_id)
    scene_id, _layer = claims.shown(session)
    if scene_id is None:
        return quiet("no scene id is stored. A turn was not sent.", channels=channels, node_id=node_id)
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=None,
        artifact="scene",
        mesh=None,
    )
    if error is not None:
        error["turned"] = False
        error["stopped"] = False
        error["rendered"] = False
        error["channels"] = channels
        error["node"] = node_id
        return error
    try:
        reply, buf = probe(opened, _token(), timeout)
        if reply is None or da1_before_glass(buf):
            reason = "terminal did not answer glass hello" if reply is None else "terminal is not glass"
            return quiet(reason, channels=channels, node_id=node_id)
        if not reply.ok or "tween" not in reply.ops:
            reason = (
                f"glass hello refused: {reply.code}"
                if not reply.ok
                else "glass hello did not list tween. A turn was not sent."
            )
            result = quiet(reason, channels=channels, node_id=node_id)
            result["ops"] = list(reply.ops)
            result["version"] = reply.version
            result["picture"] = scene_id
            return result
        token = _token()
        try:
            frame = tween_turn(
                scene_id,
                token,
                node=node_id,
                yaw=yaw,
                rot=rot,
                ease=ease,
                dur=seconds,
                tid=named,
            )
        except ValueError as exc:
            return quiet(str(exc), channels=channels, node_id=node_id)
        accepted, _spent = exchange(opened, frame, token, timeout)
        turned = accepted is not None and accepted.ok
        code = "no reply" if accepted is None else accepted.code
        result = _stamp(
            _result(
                turned,
                session=session,
                reason="glass accepted the turn" if turned else f"tween was not accepted: {code}",
                confirmed=turned,
                placement="tween" if turned else "",
                picture=scene_id,
                ops=reply.ops,
                version=reply.version,
                artifact="scene",
            ),
            mesh=None,
            moved=turned,
        )
        result["turned"] = turned
        result["stopped"] = False
        result["rendered"] = False
        result["channels"] = channels
        result["node"] = node_id
        return result
    finally:
        if close and opened is not None:
            opened.close()


def veil_scene(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    emissive=None,
    visible=None,
    node: int = 1,
    ease: str = "sine",
    dur: float | None = None,
    tid: int | None = None,
) -> dict:
    """Change shine or visibility of one node already showing. Once only.

    veiled, moved, and confirmed are true only after that tween OK. A missing
    tween op is not written. A refused tween is not claimed. This sends emissive
    and visible only when asked. It does not send rot, at, scale, color, camera,
    repeat, or yoyo. channels is what this call built, not a count Glass reported.
    An OK does not prove the node has arrived. visible changes at the end of the
    tween; this OK does not prove that. dur is omitted unless asked when ease is
    spring, otherwise a missing duration is 0.6.
    """

    def quiet(reason: str, *, channels: list[str] | None = None, node_id: int | None = None) -> dict:
        result = _stamp(
            _result(False, session=session, reason=reason, artifact="scene"),
            mesh=None,
            moved=False,
        )
        result["veiled"] = False
        result["rendered"] = False
        result["channels"] = channels or []
        result["node"] = node_id
        return result

    try:
        fields = parse_veil(emissive, visible)
        if isinstance(node, bool) or not isinstance(node, int) or node < 1 or node > 64:
            raise ValueError("node must be 1 to 64")
        node_id = node
        named = None
        if tid not in (None, ""):
            if isinstance(tid, bool) or not isinstance(tid, int) or tid < 1 or tid > 64:
                raise ValueError("tween id must be 1 to 64")
            named = tid
        if ease not in {"linear", "spring", "sine", "cubic", "bounce"}:
            raise ValueError("ease must be linear, spring, sine, cubic, or bounce")
        seconds = None
        if dur not in (None, ""):
            if isinstance(dur, bool) or not isinstance(dur, (int, float)):
                raise ValueError("duration must be a number")
            seconds = float(dur)
            if seconds != seconds or seconds < 0.05 or seconds > 8:
                raise ValueError("duration must be 0.05 to 8")
        elif ease != "spring":
            seconds = 0.6
    except (TypeError, ValueError) as exc:
        return quiet(str(exc))
    channels = [key for key in ("emissive", "visible") if key in fields]
    if not session:
        return quiet("session required", channels=channels, node_id=node_id)
    if claims.kind(session) != "scene":
        return quiet("no scene is showing. A veil was not sent.", channels=channels, node_id=node_id)
    scene_id, _layer = claims.shown(session)
    if scene_id is None:
        return quiet("no scene id is stored. A veil was not sent.", channels=channels, node_id=node_id)
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=None,
        artifact="scene",
        mesh=None,
    )
    if error is not None:
        error["veiled"] = False
        error["rendered"] = False
        error["channels"] = channels
        error["node"] = node_id
        return error
    try:
        reply, buf = probe(opened, _token(), timeout)
        if reply is None or da1_before_glass(buf):
            reason = "terminal did not answer glass hello" if reply is None else "terminal is not glass"
            return quiet(reason, channels=channels, node_id=node_id)
        if not reply.ok or "tween" not in reply.ops:
            reason = (
                f"glass hello refused: {reply.code}"
                if not reply.ok
                else "glass hello did not list tween. A veil was not sent."
            )
            result = quiet(reason, channels=channels, node_id=node_id)
            result["ops"] = list(reply.ops)
            result["version"] = reply.version
            result["picture"] = scene_id
            return result
        token = _token()
        try:
            frame = tween_veil(
                scene_id,
                token,
                node=node_id,
                emissive=emissive,
                visible=visible,
                ease=ease,
                dur=seconds,
                tid=named,
            )
        except ValueError as exc:
            return quiet(str(exc), channels=channels, node_id=node_id)
        accepted, _spent = exchange(opened, frame, token, timeout)
        veiled = accepted is not None and accepted.ok
        code = "no reply" if accepted is None else accepted.code
        result = _stamp(
            _result(
                veiled,
                session=session,
                reason="glass accepted the veil" if veiled else f"tween was not accepted: {code}",
                confirmed=veiled,
                placement="tween" if veiled else "",
                picture=scene_id,
                ops=reply.ops,
                version=reply.version,
                artifact="scene",
            ),
            mesh=None,
            moved=veiled,
        )
        result["veiled"] = veiled
        result["rendered"] = False
        result["channels"] = channels
        result["node"] = node_id
        return result
    finally:
        if close and opened is not None:
            opened.close()


def look_scene(
    session: str,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    target: str | None = None,
    fov=None,
    ease: str = "sine",
    dur: float | None = 0.6,
    tid: int | None = None,
    timeout: float = 1.0,
) -> dict:
    """Aim the camera of the scene this session is already showing, once.

    target and fov are sent only when asked. eye, node channels, repeat, and
    yoyo are not sent. looked, moved, and confirmed are true only after the
    tween OK. rendered stays false. An OK does not prove the camera has arrived.
    """
    scene_id = None

    def quiet(reason: str, *, channels: list[str] | None = None) -> dict:
        result = _stamp(
            _result(False, session=session, reason=reason, artifact="scene"),
            mesh=None,
            moved=False,
        )
        result["looked"] = False
        result["rendered"] = False
        result["channels"] = channels or []
        result["picture"] = scene_id
        return result

    try:
        fields = parse_look(target, fov)
        named = None
        if tid not in (None, ""):
            if isinstance(tid, bool) or not isinstance(tid, int) or tid < 1 or tid > 64:
                raise ValueError("tween id must be 1 to 64")
            named = tid
        if ease not in {"linear", "spring", "sine", "cubic", "bounce"}:
            raise ValueError("ease must be linear, spring, sine, cubic, or bounce")
        seconds = None
        if dur not in (None, ""):
            if isinstance(dur, bool) or not isinstance(dur, (int, float)):
                raise ValueError("duration must be a number")
            seconds = float(dur)
            if seconds != seconds or seconds < 0.05 or seconds > 8:
                raise ValueError("duration must be 0.05 to 8")
        elif ease != "spring":
            seconds = 0.6
    except (TypeError, ValueError) as exc:
        return quiet(str(exc))
    channels = [key for key in ("target", "fov") if key in fields]
    if not session:
        return quiet("session required", channels=channels)
    if claims.kind(session) != "scene":
        return quiet("no scene is showing. A look was not sent.", channels=channels)
    scene_id, _layer = claims.shown(session)
    if scene_id is None:
        return quiet("no scene id is stored. A look was not sent.", channels=channels)
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=None,
        artifact="scene",
        mesh=None,
    )
    if error is not None:
        error["looked"] = False
        error["rendered"] = False
        error["channels"] = channels
        error["picture"] = scene_id
        return error
    try:
        reply, buf = probe(opened, _token(), timeout)
        if reply is None or da1_before_glass(buf):
            reason = "terminal did not answer glass hello" if reply is None else "terminal is not glass"
            return quiet(reason, channels=channels)
        if not reply.ok or "tween" not in reply.ops:
            reason = (
                f"glass hello refused: {reply.code}"
                if not reply.ok
                else "glass hello did not list tween. A look was not sent."
            )
            result = quiet(reason, channels=channels)
            result["ops"] = list(reply.ops)
            result["version"] = reply.version
            return result
        token = _token()
        try:
            frame = tween_look(
                scene_id,
                token,
                target,
                fov,
                ease=ease,
                dur=seconds,
                tid=named,
            )
        except (TypeError, ValueError) as exc:
            return quiet(str(exc), channels=channels)
        accepted, _spent = exchange(opened, frame, token, timeout)
        looked = accepted is not None and accepted.ok
        code = "no reply" if accepted is None else accepted.code
        result = _stamp(
            _result(
                looked,
                session=session,
                reason="glass accepted the look" if looked else f"tween was not accepted: {code}",
                confirmed=looked,
                placement="tween" if looked else "",
                picture=scene_id,
                ops=reply.ops,
                version=reply.version,
                artifact="scene",
            ),
            mesh=None,
            moved=looked,
        )
        result["looked"] = looked
        result["rendered"] = False
        result["channels"] = channels
        return result
    finally:
        if close and opened is not None:
            opened.close()


def curve_scene(
    session: str,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    at: str | None = None,
    curve: str | None = None,
    node: int = 1,
    dur: float | None = None,
    tid: int | None = None,
    timeout: float = 1.0,
) -> dict:
    """Move one showing node once, with a cubic-bezier ease.

    The frame sends at and ease=cubic-bezier(...). It does not send repeat,
    yoyo, camera, rot, scale, or color. curved, moved, and confirmed are true
    only after the tween OK. rendered stays false. bezier is true only then.
    overshot is true only when that accepted frame had a y outside 0 to 1.
    An OK does not prove the node has arrived.
    """
    scene_id = None
    parsed: dict[str, object] | None = None
    place = None
    channels = ["at"]

    def quiet(reason: str) -> dict:
        result = _stamp(
            _result(False, session=session, reason=reason, artifact="scene"),
            mesh=None,
            moved=False,
        )
        result["curved"] = False
        result["rendered"] = False
        result["bezier"] = False
        result["overshot"] = False
        result["written"] = False
        result["channels"] = channels if place is not None else []
        result["curve"] = None
        result["controls"] = None
        result["at"] = place
        result["node"] = None
        result["picture"] = scene_id
        return result

    try:
        if at in (None, ""):
            raise ValueError("at is required")
        if curve in (None, ""):
            raise ValueError("curve is required")
        if isinstance(node, bool) or not isinstance(node, int) or node < 1 or node > 64:
            raise ValueError("node out of range")
        named = None
        if tid not in (None, ""):
            if isinstance(tid, bool) or not isinstance(tid, int) or tid < 1 or tid > 64:
                raise ValueError("tween id must be 1 to 64")
            named = tid
        seconds = 1.0 if dur in (None, "") else dur
        if isinstance(seconds, bool) or not isinstance(seconds, (int, float)):
            raise ValueError("duration must be a number")
        seconds = float(seconds)
        if seconds != seconds or seconds < 0.05 or seconds > 8:
            raise ValueError("duration must be 0.05 to 8")
        fields = parse_shift(at, None, None)
        place = fields["at"]
        parsed = parse_curve(str(curve))
    except (TypeError, ValueError) as exc:
        return quiet(str(exc))
    if not session:
        return quiet("session required")
    if claims.kind(session) != "scene":
        return quiet("no scene is showing. A curve was not sent.")
    scene_id, _layer = claims.shown(session)
    if scene_id is None:
        return quiet("no scene id is stored. A curve was not sent.")
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=None,
        artifact="scene",
        mesh=None,
    )
    if error is not None:
        error["curved"] = False
        error["rendered"] = False
        error["bezier"] = False
        error["overshot"] = False
        error["written"] = False
        error["channels"] = channels
        error["curve"] = None
        error["controls"] = None
        error["at"] = place
        error["node"] = node
        error["picture"] = scene_id
        return error
    try:
        reply, buf = probe(opened, _token(), timeout)
        if reply is None or da1_before_glass(buf):
            reason = "terminal did not answer glass hello" if reply is None else "terminal is not glass"
            return quiet(reason)
        if not reply.ok or "tween" not in reply.ops:
            reason = (
                f"glass hello refused: {reply.code}"
                if not reply.ok
                else "glass hello did not list tween. A curve was not sent."
            )
            result = quiet(reason)
            result["ops"] = list(reply.ops)
            result["version"] = reply.version
            return result
        token = _token()
        try:
            frame = tween_curve(
                scene_id,
                token,
                place,
                str(parsed["ease"]),
                node=node,
                dur=seconds,
                tid=named,
            )
        except (TypeError, ValueError) as exc:
            return quiet(str(exc))
        accepted, _spent = exchange(opened, frame, token, timeout)
        curved = accepted is not None and accepted.ok
        code = "no reply" if accepted is None else accepted.code
        result = _stamp(
            _result(
                curved,
                session=session,
                reason="glass accepted the curve" if curved else f"tween was not accepted: {code}",
                confirmed=curved,
                placement="tween" if curved else "",
                picture=scene_id,
                ops=reply.ops,
                version=reply.version,
                artifact="scene",
            ),
            mesh=None,
            moved=curved,
        )
        result["curved"] = curved
        result["rendered"] = False
        result["bezier"] = curved
        result["overshot"] = bool(curved and parsed["overshot"])
        result["written"] = True
        result["channels"] = channels
        result["curve"] = parsed["ease"]
        result["controls"] = parsed["controls"]
        result["at"] = place
        result["node"] = node
        return result
    finally:
        if close and opened is not None:
            opened.close()


def ease_scene(
    session: str,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    at: str | None = None,
    ease: str | None = None,
    node: int = 1,
    dur: float | None = None,
    tid: int | None = None,
    timeout: float = 1.0,
) -> dict:
    """Move one showing node once, with a named back or elastic ease.

    The frame sends at, ease=back-* or ease=elastic-*, and dur. It does not
    send cubic-bezier, spring, repeat, yoyo, camera, rot, scale, or color.
    Older tween frames still refuse these names. eased, moved, and confirmed
    are true only after the tween OK. rendered stays false. named is true only
    then. recoil is true only when that accepted frame was a back ease. wobble
    is true only when it was an elastic ease. An OK does not prove the node
    has arrived, and it does not prove the motion recoiled or wobbled on screen.
    """
    scene_id = None
    parsed: dict[str, object] | None = None
    place = None
    channels = ["at"]

    def quiet(reason: str) -> dict:
        result = _stamp(
            _result(False, session=session, reason=reason, artifact="scene"),
            mesh=None,
            moved=False,
        )
        result["eased"] = False
        result["rendered"] = False
        result["named"] = False
        result["recoil"] = False
        result["wobble"] = False
        result["written"] = False
        result["channels"] = channels if place is not None else []
        result["ease"] = None
        result["family"] = None
        result["at"] = place
        result["node"] = None
        result["picture"] = scene_id
        return result

    try:
        if at in (None, ""):
            raise ValueError("at is required")
        if ease in (None, ""):
            raise ValueError("ease is required")
        if isinstance(node, bool) or not isinstance(node, int) or node < 1 or node > 64:
            raise ValueError("node out of range")
        named = None
        if tid not in (None, ""):
            if isinstance(tid, bool) or not isinstance(tid, int) or tid < 1 or tid > 64:
                raise ValueError("tween id must be 1 to 64")
            named = tid
        seconds = 0.8 if dur in (None, "") else dur
        if isinstance(seconds, bool) or not isinstance(seconds, (int, float)):
            raise ValueError("duration must be a number")
        seconds = float(seconds)
        if seconds != seconds or seconds < 0.05 or seconds > 8:
            raise ValueError("duration must be 0.05 to 8")
        fields = parse_shift(at, None, None)
        place = fields["at"]
        parsed = parse_named_ease(str(ease))
    except (TypeError, ValueError) as exc:
        return quiet(str(exc))
    if not session:
        return quiet("session required")
    if claims.kind(session) != "scene":
        return quiet("no scene is showing. An ease was not sent.")
    scene_id, _layer = claims.shown(session)
    if scene_id is None:
        return quiet("no scene id is stored. An ease was not sent.")
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=None,
        artifact="scene",
        mesh=None,
    )
    if error is not None:
        error["eased"] = False
        error["rendered"] = False
        error["named"] = False
        error["recoil"] = False
        error["wobble"] = False
        error["written"] = False
        error["channels"] = channels
        error["ease"] = None
        error["family"] = None
        error["at"] = place
        error["node"] = node
        error["picture"] = scene_id
        return error
    try:
        reply, buf = probe(opened, _token(), timeout)
        if reply is None or da1_before_glass(buf):
            reason = "terminal did not answer glass hello" if reply is None else "terminal is not glass"
            return quiet(reason)
        if not reply.ok or "tween" not in reply.ops:
            reason = (
                f"glass hello refused: {reply.code}"
                if not reply.ok
                else "glass hello did not list tween. An ease was not sent."
            )
            result = quiet(reason)
            result["ops"] = list(reply.ops)
            result["version"] = reply.version
            return result
        token = _token()
        try:
            frame = tween_named(
                scene_id,
                token,
                place,
                str(parsed["ease"]),
                node=node,
                dur=seconds,
                tid=named,
            )
        except (TypeError, ValueError) as exc:
            return quiet(str(exc))
        accepted, _spent = exchange(opened, frame, token, timeout)
        eased = accepted is not None and accepted.ok
        code = "no reply" if accepted is None else accepted.code
        result = _stamp(
            _result(
                eased,
                session=session,
                reason="glass accepted the ease" if eased else f"tween was not accepted: {code}",
                confirmed=eased,
                placement="tween" if eased else "",
                picture=scene_id,
                ops=reply.ops,
                version=reply.version,
                artifact="scene",
            ),
            mesh=None,
            moved=eased,
        )
        result["eased"] = eased
        result["rendered"] = False
        result["named"] = eased
        result["recoil"] = bool(eased and parsed["recoil"])
        result["wobble"] = bool(eased and parsed["wobble"])
        result["written"] = True
        result["channels"] = channels
        result["ease"] = parsed["ease"]
        result["family"] = parsed["family"]
        result["at"] = place
        result["node"] = node
        return result
    finally:
        if close and opened is not None:
            opened.close()


def _noted_layer(claims: Claims, session: str, layer) -> int:
    """The single overlay this session placed, or a named layer in the noted group."""
    effect_id = claims.effect(session)
    grouped = claims.group(session)
    if layer in (None, ""):
        if effect_id is None:
            raise ValueError("no overlay is showing. A glide was not sent.")
        return effect_id
    if isinstance(layer, bool) or not isinstance(layer, int) or layer < 1 or layer >= 2**30:
        raise ValueError("layer must be 1 to 1073741823")
    if effect_id == layer:
        return layer
    if grouped is not None:
        _group_id, first, count = grouped
        if first <= layer < first + count:
            return layer
    raise ValueError("that layer is not noted. A glide was not sent.")


def glide_layer(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    px: str = "",
    opacity=None,
    color: str = "",
    angle=None,
    layer: int | None = None,
    ease: str = "sine",
    dur: float = 0.6,
    tid: int | None = None,
) -> dict:
    """Move one overlay this session already placed.

    px, opacity, color, and angle are one once-only tween. A channel that was
    not asked is not sent. This does not send at, id, node, rot, camera, repeat,
    or yoyo. A layer placed with px= cannot take at=. glided, moved, and
    confirmed are true only after that tween OK. channels is what this call
    built, not a count Glass reported. An OK does not prove the overlay has
    arrived.
    """

    def quiet(reason: str, *, channels: list[str] | None = None, layer_id: int | None = None) -> dict:
        result = _stamp(
            _result(False, session=session, reason=reason, artifact="layer"),
            mesh=None,
            moved=False,
        )
        result["glided"] = False
        result["rendered"] = False
        result["channels"] = channels or []
        result["layer"] = layer_id
        return result

    try:
        fields = parse_glide(px, opacity, color, angle)
        layer_id = _noted_layer(claims, session, layer) if session else None
        named = None
        if tid not in (None, ""):
            if isinstance(tid, bool) or not isinstance(tid, int) or tid < 1 or tid > 64:
                raise ValueError("tween id must be 1 to 64")
            named = tid
        if ease not in {"linear", "spring", "sine", "cubic", "bounce"}:
            raise ValueError("ease must be linear, spring, sine, cubic, or bounce")
        if isinstance(dur, bool) or not isinstance(dur, (int, float)):
            raise ValueError("duration must be a number")
        seconds = float(dur)
        if seconds != seconds or seconds < 0.05 or seconds > 8:
            raise ValueError("duration must be 0.05 to 8")
    except (TypeError, ValueError) as exc:
        return quiet(str(exc))
    channels = [key for key in ("px", "o", "c", "a") if key in fields]
    if not session:
        return quiet("session required", channels=channels)
    if layer_id is None:
        return quiet("no overlay is showing. A glide was not sent.", channels=channels)
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=None,
        artifact="layer",
        mesh=None,
    )
    if error is not None:
        error["glided"] = False
        error["rendered"] = False
        error["channels"] = channels
        error["layer"] = layer_id
        return error
    try:
        reply, buf = probe(opened, _token(), timeout)
        if reply is None or da1_before_glass(buf):
            reason = "terminal did not answer glass hello" if reply is None else "terminal is not glass"
            return quiet(reason, channels=channels, layer_id=layer_id)
        if not reply.ok or "tween" not in reply.ops:
            reason = (
                f"glass hello refused: {reply.code}"
                if not reply.ok
                else "glass hello did not list tween. A glide was not sent."
            )
            result = quiet(reason, channels=channels, layer_id=layer_id)
            result["ops"] = list(reply.ops)
            result["version"] = reply.version
            result["picture"] = layer_id
            return result
        token = _token()
        try:
            frame = tween_glide(
                layer_id,
                token,
                px=fields.get("px"),
                opacity=fields.get("o"),
                color=fields.get("c"),
                angle=fields.get("a"),
                ease=ease,
                dur=seconds,
                tid=named,
            )
        except ValueError as exc:
            return quiet(str(exc), channels=channels, layer_id=layer_id)
        accepted, _spent = exchange(opened, frame, token, timeout)
        glided = accepted is not None and accepted.ok
        code = "no reply" if accepted is None else accepted.code
        result = _stamp(
            _result(
                glided,
                session=session,
                reason="glass accepted the glide" if glided else f"tween was not accepted: {code}",
                confirmed=glided,
                placement="tween" if glided else "",
                picture=layer_id,
                ops=reply.ops,
                version=reply.version,
                artifact="layer",
            ),
            mesh=None,
            moved=glided,
        )
        result["glided"] = glided
        result["rendered"] = False
        result["channels"] = channels
        result["layer"] = layer_id
        return result
    finally:
        if close and opened is not None:
            opened.close()



def _show_scene_open(
    session,
    claims,
    port,
    timeout,
    *,
    mesh,
    rgba,
    text,
    payload,
    width,
    height,
    x,
    y,
    spin,
    ease,
    opacity=None,
    depth=None,
    cells=None,
    anchor=None,
) -> dict:
    reply, buf = probe(port, _token(), timeout)
    if reply is None or da1_before_glass(buf):
        _release_if_unused(claims, session)
        reason = "terminal did not answer glass hello" if reply is None else "terminal is not glass"
        return _stamp(
            _result(True, session=session, text=text, reason=reason, fallback="text", artifact="scene"),
            mesh=mesh,
            moved=False,
        )
    if not reply.ok or "scene" not in reply.ops:
        _release_if_unused(claims, session)
        reason = (
            f"glass hello refused: {reply.code}"
            if not reply.ok
            else "glass hello did not list scene; not a display"
        )
        return _stamp(
            _result(
                True,
                session=session,
                text=text,
                reason=reason,
                fallback="text",
                artifact="scene",
                ops=() if not reply.ok else reply.ops,
                version=None if not reply.ok else reply.version,
            ),
            mesh=mesh,
            moved=False,
        )
    scene_id = claims.allocate(session)
    token = _token()
    frame = scene_frame(
        scene_id,
        payload,
        token,
        width=width,
        height=height,
        x=x,
        y=y,
        opacity=opacity,
        z=depth,
        cells=cells,
        anchor=anchor,
    )
    accepted, _spent = exchange(port, frame, token, timeout)
    if accepted is None or not accepted.ok:
        _remove_quiet(port, scene_id, None, timeout)
        _release_if_unused(claims, session)
        code = "no reply" if accepted is None else accepted.code
        return _stamp(
            _result(
                True,
                session=session,
                text=text,
                reason=f"scene was not accepted: {code}",
                fallback="text",
                artifact="scene",
                ops=reply.ops,
                version=reply.version,
            ),
            mesh=mesh,
            moved=False,
        )
    previous_kind = claims.kind(session)
    previous, previous_layer = claims.note_shown(session, scene_id, None, kind="scene")
    if previous and previous != scene_id:
        _remove_quiet(port, previous, previous_layer, timeout)
    if previous_kind in ("page", "chart", "image", "showcase", "video"):
        close_token = _token()
        exchange(port, close_showcase(close_token), close_token, timeout)
    _drop_faces(port, claims, session, timeout)
    _drop_wrap(port, claims, session, timeout)
    moved = False
    reason = "glass accepted the scene"
    if spin:
        if "tween" not in reply.ops:
            reason = "glass accepted the scene; hello did not list tween"
        else:
            moved, reason = _send_spin(port, scene_id, timeout, ease=ease)
    return _stamp(
        _result(
            True,
            session=session,
            text=text,
            reason=reason,
            rendered=True,
            confirmed=True,
            placement="scene",
            picture=scene_id,
            ops=reply.ops,
            version=reply.version,
            artifact="scene",
        ),
        mesh=mesh,
        moved=moved,
    )


def _send_spin(port, scene_id: int, timeout: float, *, ease: str, yaw: float = 180) -> tuple[bool, str]:
    token = _token()
    frame = tween_node(scene_id, token, yaw_rot(yaw), ease=ease, repeat="forever", yoyo=True)
    reply, _spent = exchange(port, frame, token, timeout)
    if reply is not None and reply.ok:
        return True, "glass accepted the scene and the spin"
    code = "no reply" if reply is None else reply.code
    return False, f"glass accepted the scene; tween was refused: {code}"


def show_model(
    *,
    session: str | None,
    path: str,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    width: int = 320,
    height: int = 240,
    x: int = 48,
    y: int = 48,
    spin: bool = False,
    ease: str = "spring",
    color: str | None = None,
    finish: str = "plain",
    chrome=None,
    liquid=None,
    play: bool = False,
    clip=None,
    speed=None,
    loop=None,
) -> dict:
    """Upload a glTF, hang it, and play only when asked and Glass accepts."""
    try:
        prepared = prepare_model(path)
        rgba = parse_color(color) if color else None
        width_px = _as_int(width, "width", 1, 2048)
        height_px = _as_int(height, "height", 1, 2048)
        origin_x = _as_int(x, "x", 0, 8192)
        origin_y = _as_int(y, "y", 0, 8192)
        if not isinstance(spin, bool) or not isinstance(play, bool):
            raise ValueError("spin and play must be true or false")
        if spin:
            tween_node(1, "a", yaw_rot(180), ease=ease)
        finish_name, chrome_amount, liquid_amount = _stage_finish(finish, chrome, liquid)
        clip_value = None if clip in (None, "") else _clip_value(clip)
        if play and clip_value is None:
            clip_value = 0
        speed_value = None if speed in (None, "") else float(speed)
        if speed_value is not None and (speed_value < -16 or speed_value > 16):
            raise ValueError("speed must be -16 to 16")
        loop_value = None if loop in (None, "") else _bool_flag(loop, "loop")
        clear = (0.0, 0.0, 0.0, 1.0) if finish_name == "mercury" else None
        text = _model_text(prepared)
    except ValueError as exc:
        return _model_fields(
            _result(False, reason=str(exc), artifact="model"),
            uploaded=False,
            played=False,
        )
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=text,
        artifact="model",
        mesh="gltf",
    )
    if error:
        return _model_fields(error, uploaded=False, played=False)
    try:
        return _show_model_open(
            opened,
            session=session,
            claims=claims,
            prepared=prepared,
            timeout=timeout,
            text=text,
            width_px=width_px,
            height_px=height_px,
            origin_x=origin_x,
            origin_y=origin_y,
            spin=spin,
            ease=ease,
            rgba=rgba,
            chrome_amount=chrome_amount,
            liquid_amount=liquid_amount,
            clear=clear,
            clip_value=clip_value,
            speed_value=speed_value,
            loop_value=loop_value,
            want_play=play or clip_value is not None,
        )
    finally:
        if close:
            opened.close()


def play_scene(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    clip=None,
    speed=None,
    loop=None,
    pause=None,
    stop: bool = False,
    node=None,
    at=None,
) -> dict:
    """Play, pause, or stop the scene this session is already showing."""
    if not session:
        return _model_fields(_result(False, reason="session required", artifact="model"), played=False)
    if claims.kind(session) != "scene":
        return _model_fields(
            _result(
                True,
                session=session,
                reason="no scene is showing. glass_model or glass_scene must be accepted first.",
                fallback="text",
                artifact="model",
            ),
            played=False,
        )
    picture, _layer = claims.shown(session)
    if not picture:
        return _model_fields(
            _result(True, session=session, reason="no scene is showing", fallback="text", artifact="model"),
            played=False,
        )
    try:
        request = _play_request(clip, speed, loop, pause, stop, node, at)
    except ValueError as exc:
        return _model_fields(_result(False, reason=str(exc), artifact="model"), played=False)
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text="play",
        artifact="model",
        mesh="scene",
    )
    if error:
        return _model_fields(error, played=False)
    try:
        reply, _buf = probe(opened, _token(), timeout)
        if reply is None or not reply.ok:
            reason = "terminal is not glass" if reply is None else f"terminal did not answer glass hello: {reply.code}"
            return _model_fields(
                _result(True, session=session, reason=reason, fallback="text", artifact="model"),
                played=False,
            )
        if "play" not in reply.ops:
            return _model_fields(
                _result(
                    True,
                    session=session,
                    reason="glass hello did not list play; not a display",
                    fallback="text",
                    ops=reply.ops,
                    version=reply.version,
                    artifact="model",
                ),
                played=False,
            )
        accepted, code = _send_play(opened, picture, timeout, request)
        played = accepted and request["clip"] is not None and not request["stop"] and request["pause"] is not True
        if accepted and request["stop"]:
            reason = "glass accepted stop"
        elif accepted and request["pause"]:
            reason = "glass accepted pause"
        elif played:
            reason = "glass accepted the clip"
        else:
            reason = f"play was refused: {code}"
        return _model_fields(
            _result(
                True,
                session=session,
                reason=reason,
                rendered=False,
                confirmed=False,
                picture=picture,
                ops=reply.ops,
                version=reply.version,
                artifact="model",
            ),
            played=played,
            paused=accepted and bool(request["pause"]),
            stopped=accepted and bool(request["stop"]),
        )
    finally:
        if close:
            opened.close()


def _show_model_open(
    port,
    *,
    session,
    claims,
    prepared,
    timeout,
    text,
    width_px,
    height_px,
    origin_x,
    origin_y,
    spin,
    ease,
    rgba,
    chrome_amount,
    liquid_amount,
    clear,
    clip_value,
    speed_value,
    loop_value,
    want_play,
) -> dict:
    reply, _buf = probe(port, _token(), timeout)
    if reply is None or not reply.ok:
        reason = "terminal is not glass" if reply is None else f"terminal did not answer glass hello: {reply.code}"
        return _model_fields(
            _result(True, session=session, text=text, reason=reason, fallback="text", artifact="model"),
            uploaded=False,
            played=False,
            model_path=prepared.path,
            size=prepared.size,
        )
    if "asset" not in reply.ops or "scene" not in reply.ops:
        missing = "asset" if "asset" not in reply.ops else "scene"
        return _model_fields(
            _result(
                True,
                session=session,
                text=text,
                reason=f"glass hello did not list {missing}; not a display",
                fallback="text",
                ops=reply.ops,
                version=reply.version,
                artifact="model",
            ),
            uploaded=False,
            played=False,
            model_path=prepared.path,
            size=prepared.size,
        )
    asset_id = claims.model_asset(session)
    asset_token = _token()
    if prepared.medium == "d":
        uploaded_frame = asset_frame(asset_id, asset_token, data=prepared.data)
    else:
        uploaded_frame = asset_frame(asset_id, asset_token, path=prepared.path)
    asset_reply, _spent = exchange(port, uploaded_frame, asset_token, timeout)
    if asset_reply is None or not asset_reply.ok:
        code = "no reply" if asset_reply is None else asset_reply.code
        return _model_fields(
            _result(
                True,
                session=session,
                text=text,
                reason=f"asset was not accepted: {code}",
                fallback="text",
                ops=reply.ops,
                version=reply.version,
                artifact="model",
            ),
            uploaded=False,
            played=False,
            asset_id=asset_id,
            model_path=prepared.path,
            size=prepared.size,
            medium=prepared.medium,
        )
    summary = asset_summary(asset_reply.extra)
    payload = gltf_payload(
        asset_id,
        rgba,
        chrome=chrome_amount,
        liquid=liquid_amount,
        clear=clear,
    )
    scene_id = claims.allocate(session)
    scene_token = _token()
    placed, _buf = exchange(
        port,
        scene_frame(scene_id, payload, scene_token, width=width_px, height=height_px, x=origin_x, y=origin_y),
        scene_token,
        timeout,
    )
    if placed is None or not placed.ok:
        code = "no reply" if placed is None else placed.code
        remove_token = _token()
        exchange(port, remove(scene_id, remove_token), remove_token, timeout)
        return _model_fields(
            _result(
                True,
                session=session,
                text=text,
                reason=f"asset was accepted; scene was not accepted: {code}",
                fallback="text",
                ops=reply.ops,
                version=reply.version,
                artifact="model",
            ),
            uploaded=True,
            played=False,
            asset_id=asset_id,
            summary=summary,
            model_path=prepared.path,
            size=prepared.size,
            medium=prepared.medium,
        )
    try:
        previous, previous_layer = claims.note_shown(session, scene_id, None, kind="scene")
    except ClaimError:
        remove_token = _token()
        exchange(port, remove(scene_id, remove_token), remove_token, timeout)
        raise
    if previous and previous != scene_id and "remove" in reply.ops:
        remove_token = _token()
        exchange(port, remove(previous, remove_token), remove_token, timeout)
    if previous_layer and "remove" in reply.ops:
        remove_token = _token()
        exchange(port, remove(previous_layer, remove_token), remove_token, timeout)
    moved = False
    played = False
    parts = ["glass accepted the model"]
    if spin:
        if "tween" not in reply.ops:
            parts.append("hello did not list tween")
        else:
            moved, spin_reason = _send_spin(port, scene_id, timeout, ease=ease)
            parts.append("the spin" if moved else spin_reason.split("; ", 1)[-1])
    if want_play:
        if "play" not in reply.ops:
            parts.append("hello did not list play")
        elif summary.get("clips") == 0:
            parts.append("the model has no clips")
        else:
            request = {
                "clip": clip_value if clip_value is not None else 0,
                "speed": speed_value,
                "loop": loop_value,
                "pause": None,
                "stop": False,
                "node": None,
                "at": None,
            }
            played, code = _send_play(port, scene_id, timeout, request)
            parts.append("the clip" if played else f"play was refused: {code}")
    return _model_fields(
        _result(
            True,
            session=session,
            text=text,
            reason="; ".join(parts),
            rendered=True,
            confirmed=True,
            placement="scene",
            picture=scene_id,
            ops=reply.ops,
            version=reply.version,
            artifact="model",
        ),
        uploaded=True,
        played=played,
        asset_id=asset_id,
        summary=summary,
        model_path=prepared.path,
        size=prepared.size,
        medium=prepared.medium,
        mesh="gltf",
        moved=moved,
    )


def _send_play(port, scene_id: int, timeout: float, request: dict) -> tuple[bool, str]:
    token = _token()
    frame = play_frame(
        scene_id,
        token,
        clip=request["clip"],
        speed=request["speed"],
        loop=request["loop"],
        pause=request["pause"],
        stop=request["stop"],
        node=request["node"],
        at=request["at"],
    )
    reply, _spent = exchange(port, frame, token, timeout)
    if reply is not None and reply.ok:
        return True, "OK"
    code = "no reply" if reply is None else reply.code
    return False, code


def _play_request(clip, speed, loop, pause, stop, node, at) -> dict:
    stopping = _bool_flag(stop, "stop") if stop not in (None, "") else False
    pausing = None if pause in (None, "") else _bool_flag(pause, "pause")
    clip_value = None if clip in (None, "") else _clip_value(clip)
    if clip_value is None and pausing is None and not stopping:
        raise ValueError("play needs a clip, pause, or stop")
    speed_value = None if speed in (None, "") else float(speed)
    if speed_value is not None and (speed_value < -16 or speed_value > 16):
        raise ValueError("speed must be -16 to 16")
    at_value = None if at in (None, "") else float(at)
    if at_value is not None and (at_value < 0 or at_value > 3600):
        raise ValueError("t must be 0 to 3600")
    node_value = None if node in (None, "") else int(node)
    if node_value is not None and (node_value < 1 or node_value > 64):
        raise ValueError("node out of range")
    return {
        "clip": clip_value,
        "speed": speed_value,
        "loop": None if loop in (None, "") else _bool_flag(loop, "loop"),
        "pause": pausing,
        "stop": stopping,
        "node": node_value,
        "at": at_value,
    }


def _clip_value(clip):
    if clip == "all":
        return "all"
    if isinstance(clip, bool):
        raise ValueError("clip must be an index or all")
    index = int(clip)
    if index < 0 or index > 64:
        raise ValueError("clip must be 0..64 or all")
    return index


def _bool_flag(value, name: str) -> bool:
    if isinstance(value, bool):
        return value
    text = str(value).strip().lower()
    if text in {"1", "true", "yes", "on"}:
        return True
    if text in {"0", "false", "no", "off"}:
        return False
    raise ValueError(f"{name} must be true or false")


def _model_text(prepared) -> str:
    return f"model {prepared.path} {prepared.size} bytes"


def _model_fields(
    result: dict,
    *,
    uploaded: bool = False,
    played: bool = False,
    paused: bool = False,
    stopped: bool = False,
    asset_id: int | None = None,
    summary: dict | None = None,
    model_path: str | None = None,
    size: int | None = None,
    medium: str | None = None,
    mesh: str | None = None,
    moved: bool | None = None,
) -> dict:
    result["uploaded"] = uploaded
    result["played"] = played
    result["paused"] = paused
    result["stopped"] = stopped
    result["asset"] = asset_id
    result["moved"] = False if moved is None else moved
    if mesh:
        result["mesh"] = mesh
    if model_path:
        result["model_path"] = model_path
    if size is not None:
        result["bytes"] = size
    if medium:
        result["medium"] = medium
    if summary:
        for key in ("nodes", "meshes", "clips"):
            if key in summary:
                result[key] = summary[key]
        if "seconds" in summary:
            result["seconds"] = summary["seconds"]
    return result


def _claim_port(session, claims, port, tty_key, tty_path, *, text, artifact, mesh):
    path = tty_path or claims.path_for(session)
    key = tty_key
    if path and key is None:
        try:
            key = device_key(path)
        except OSError as exc:
            return None, False, _stamp(
                _result(False, session=session, text=text, reason=str(exc), fallback="text", artifact=artifact),
                mesh=mesh,
                moved=False,
            )
    if port is None and not path:
        return None, False, _stamp(
            _result(
                True,
                session=session,
                text=text,
                reason="no terminal bound. Tool output is not a display.",
                fallback="text",
                artifact=artifact,
            ),
            mesh=mesh,
            moved=False,
        )
    if key is None:
        return None, False, _stamp(
            _result(False, session=session, text=text, reason="terminal key required", artifact=artifact),
            mesh=mesh,
            moved=False,
        )
    try:
        claims.acquire(session, key, path or key)
    except ClaimError as exc:
        return None, False, _stamp(
            _result(False, session=session, text=text, reason=exc.reason, fallback="text", artifact=artifact),
            mesh=mesh,
            moved=False,
        )
    if port is not None:
        return port, False, None
    try:
        return TtyPort(path), True, None
    except OSError as exc:
        _release_if_unused(claims, session)
        return None, False, _stamp(
            _result(
                True,
                session=session,
                text=text,
                reason=f"terminal could not be opened: {exc}",
                fallback="text",
                artifact=artifact,
            ),
            mesh=mesh,
            moved=False,
        )


def _stage_finish(finish, chrome, liquid):
    name = str(finish or "plain").strip().lower()
    presets = {"plain": (0, 0), "chrome": (1, 0), "mercury": (1, 0.6)}
    if name not in presets:
        raise ValueError("finish must be plain, chrome, or mercury")
    chrome_amount = presets[name][0] if chrome is None else chrome
    liquid_amount = presets[name][1] if liquid is None else liquid
    return name, chrome_amount, liquid_amount


def _stage_text(names, width: int, height: int, chrome=0, liquid=0) -> str:
    lines = [f"stage {len(names)} {width}x{height}", " ".join(names)]
    if chrome:
        lines.append(f"chrome {chrome}")
    if liquid:
        lines.append(f"liquid {liquid}")
    return "\n".join(lines)


def _note_stage(result: dict, names, stage_label) -> dict:
    if names:
        result["pieces"] = list(names)
        result["nodes"] = len(names)
        result["stage"] = stage_label or "pieces"
    return result


def _mesh(mesh: str) -> str:
    name = str(mesh).strip().lower()
    scene_payload(name, (1.0, 0.4, 0.2, 1.0))
    return name


def _finish(finish, mesh_name: str, chrome, liquid, segments):
    name = str(finish or "plain").strip().lower()
    presets = {"plain": (0, 0), "chrome": (1, 0), "mercury": (1, 0.6)}
    if name not in presets:
        raise ValueError("finish must be plain, chrome, or mercury")
    chrome_amount = presets[name][0] if chrome is None else chrome
    liquid_amount = presets[name][1] if liquid is None else liquid
    if segments is None and name == "mercury":
        if mesh_name in ("sphere", "cone", "cylinder", "frustum", "arch"):
            segments = 48
        elif mesh_name == "roundcube":
            segments = 8
    return chrome_amount, liquid_amount, segments


def _as_int(value, name: str, lo: int, hi: int) -> int:
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        raise ValueError(f"{name} must be an integer")
    if isinstance(value, float) and not value.is_integer():
        raise ValueError(f"{name} must be an integer")
    number = int(value)
    if number < lo or number > hi:
        raise ValueError(f"{name} must be {lo} to {hi}")
    return number


def _scene_text(mesh: str, color: tuple[float, float, float, float], width: int, height: int, chrome=0, liquid=0) -> str:
    hex_color = "".join(f"{int(round(part * 255)):02x}" for part in color[:3])
    lines = [f"scene {mesh} {width}x{height}", f"color {hex_color}"]
    if chrome:
        lines.append(f"chrome {chrome}")
    if liquid:
        lines.append(f"liquid {liquid}")
    return "\n".join(lines)


def _stamp(result: dict, *, mesh, moved: bool) -> dict:
    result["mesh"] = mesh
    result["moved"] = moved
    return result


def _mark_stamp(result: dict, *, shape: str, vertices: int, triangles: int) -> dict:
    result["shape"] = shape
    result["vertices"] = vertices
    result["triangles"] = triangles
    result["inline"] = bool(result.get("confirmed"))
    if result["inline"]:
        result["mesh"] = "inline"
    elif result.get("mesh") == "inline":
        result["mesh"] = None
    return result


def _bars(width: int, height: int, mark: int | None) -> bytes:
    colors = (
        (232, 84, 58),
        (244, 164, 66),
        (242, 208, 96),
        (62, 168, 118),
        (46, 124, 196),
        (122, 92, 196),
    )
    row_h = max(1, height // len(colors))
    out = bytearray(width * height * 4)
    for y in range(height):
        rgb = colors[min(y // row_h, len(colors) - 1)]
        for x in range(width):
            i = (y * width + x) * 4
            if mark is not None and x == mark:
                out[i:i + 4] = b"\xff\xff\xff\xff"
            else:
                out[i:i + 3] = bytes(rgb)
                out[i + 3] = 255
    return bytes(out)


def _rgb_of(rgba: bytes) -> bytes:
    rgb = bytearray((len(rgba) // 4) * 3)
    for i in range(len(rgba) // 4):
        rgb[i * 3:i * 3 + 3] = rgba[i * 4:i * 4 + 3]
    return bytes(rgb)


def _frame_fields(result: dict, *, opened: bool = False, seeked: bool = False, pixels: str = "") -> dict:
    result["opened"] = opened
    result["seeked"] = seeked
    result["pixels"] = pixels
    return result


def _progress_t(value) -> float:
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        raise ValueError("t must be a number from 0 to 1")
    number = float(value)
    if number < 0 or number > 1:
        raise ValueError("t must be a number from 0 to 1")
    return number


def _frame_source(path, width: int, height: int, mark: int | None):
    if path:
        src = Path(path)
        if src.is_symlink():
            raise ValueError("frame path must not be a symlink")
        text = str(src)
        if text.startswith("/proc") or text.startswith("/sys") or text.startswith("/dev"):
            raise ValueError("frame path is not a media file")
        loaded = image_mod.load_image(src)
        encoded = 4 * ((len(loaded.data) + 2) // 3)
        if encoded > 1 << 20:
            raise ValueError("frame is over 1 MiB")
        return loaded.data, None, f"{loaded.width}x{loaded.height}", loaded
    pixels = _bars(width, height, mark)
    encoded = 4 * ((len(pixels) + 2) // 3)
    if encoded > 1 << 20:
        raise ValueError("frame is over 1 MiB")
    return None, pixels, f"{width}x{height}", None


def show_frame(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    width: int = 320,
    height: int = 180,
    t=None,
    pause=None,
    path: str | None = None,
) -> dict:
    """Open a sized video panel and push one frame. Progress is sent only when asked."""
    try:
        width = _as_int(width, "width", 1, 2048)
        height = _as_int(height, "height", 1, 2048)
        asked = t is not None or pause is not None
        progress_t = None if t is None else _progress_t(t)
        progress_pause = None if pause is None else _bool_flag(pause, "pause")
        mark = None
        if progress_t is not None and path is None:
            mark = min(width - 1, max(0, int(round(progress_t * (width - 1)))))
        file_bytes, pixels, pixel_text, loaded = _frame_source(path, width, height, mark)
    except ValueError as exc:
        return _frame_fields(
            _result(False, session=session, reason=str(exc), rendered=False, confirmed=False, artifact="frame"),
            opened=False,
            seeked=False,
        )
    label = Path(path).name if path else f"{width}x{height}"
    text = f"frame {label}"
    artifact = None
    try:
        if loaded is not None:
            artifact = image_mod.copy_image(claims.path, session, loaded)
        elif pixels is not None:
            artifact = image_mod.save_chart(claims.path, session, _rgb_of(pixels), width, height)
    except OSError:
        artifact = None

    def finish(result, *, opened=False, seeked=False, role="fallback"):
        if artifact is not None:
            result["artifact_path"] = str(artifact)
            result["artifact_role"] = role
        return _frame_fields(result, opened=opened, seeked=seeked, pixels=pixel_text)

    port, close, failed = _claim_port(
        session, claims, port, tty_key, tty_path, text=text, artifact="frame", mesh="",
    )
    if failed is not None:
        return finish(failed)
    try:
        reply, _buf = probe(port, _token(), timeout)
        if reply is None or not reply.ok:
            reason = "terminal is not glass" if reply is None else f"terminal did not answer glass hello: {reply.code}"
            _release_if_unused(claims, session)
            return finish(_result(True, session=session, text=text, reason=reason, fallback="text", artifact="frame"))
        if "showcase" not in reply.ops or "frame" not in reply.ops:
            missing = "showcase" if "showcase" not in reply.ops else "frame"
            _release_if_unused(claims, session)
            return finish(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=f"glass hello did not list {missing}; not a display",
                    fallback="text",
                    ops=reply.ops,
                    version=reply.version,
                    artifact="frame",
                )
            )
        open_token = _token()
        opened_reply, _spent = exchange(port, video_showcase(width, height, open_token), open_token, timeout)
        if opened_reply is None or not opened_reply.ok:
            _release_if_unused(claims, session)
            code = "no reply" if opened_reply is None else opened_reply.code
            return finish(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=f"video panel was not accepted: {code}",
                    fallback="text",
                    ops=reply.ops,
                    version=reply.version,
                    artifact="frame",
                )
            )
        frame_token = _token()
        frame = video_file(file_bytes, frame_token) if file_bytes is not None else video_frame(width, height, pixels, frame_token)
        accepted, _spent = exchange(port, frame, frame_token, timeout)
        if accepted is None or not accepted.ok:
            close_token = _token()
            exchange(port, close_showcase(close_token), close_token, timeout)
            _release_if_unused(claims, session)
            code = "no reply" if accepted is None else accepted.code
            return finish(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=f"frame was not accepted: {code}",
                    fallback="text",
                    ops=reply.ops,
                    version=reply.version,
                    artifact="frame",
                ),
                opened=True,
            )
        seeked = False
        reason = "glass accepted the frame"
        if asked:
            if "progress" not in reply.ops:
                reason = "glass accepted the frame; hello did not list progress"
            else:
                progress_token = _token()
                progress, _spent = exchange(
                    port,
                    progress_frame(progress_token, progress_t, progress_pause),
                    progress_token,
                    timeout,
                )
                seeked = progress is not None and progress.ok
                if not seeked:
                    code = "no reply" if progress is None else progress.code
                    reason = f"glass accepted the frame; progress was refused: {code}"
        previous, previous_layer = claims.note_video(session)
        if previous:
            _remove_quiet(port, previous, previous_layer, timeout)
        return finish(
            _result(
                True,
                session=session,
                text=text,
                reason=reason,
                rendered=True,
                confirmed=True,
                placement="video",
                ops=reply.ops,
                version=reply.version,
                artifact="frame",
            ),
            opened=True,
            seeked=seeked,
            role="copy",
        )
    finally:
        if close:
            port.close()


def _optional_number(value, name: str):
    """None when omitted. A string of digits is a number. False is not."""
    if value in (None, ""):
        return None
    if isinstance(value, bool):
        raise ValueError(f"{name} must be a number")
    if isinstance(value, str):
        text = value.strip()
        try:
            return float(text)
        except ValueError as exc:
            raise ValueError(f"{name} must be a number") from exc
    if not isinstance(value, (int, float)):
        raise ValueError(f"{name} must be a number")
    return float(value)


def float_layer(
    session: str,
    claims: Claims,
    port=None,
    *,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 1.0,
    kind: str = "glow",
    color: str | None = None,
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
    lift=None,
    breathe=None,
    to_lift=None,
    to_breathe=None,
    delay=None,
    ease: str = "sine",
    dur: float | None = None,
    tid: int | None = None,
) -> dict:
    """Place one overlay with lift and/or breathe, then optionally tween those channels.

    The layer frame uses h= and b=. The tween uses layer=, not id= or node=.
    delay is sent only when a tween was asked. A refused layer is not followed by a tween.
    """
    text = f"float {kind}"
    channels: list[str] = []
    tween_channels: list[str] = []

    def quiet(reason: str, **extra) -> dict:
        result = _result(
            False,
            session=session,
            text=text,
            reason=reason,
            artifact="layer",
            ops=extra.pop("ops", None),
            version=extra.pop("version", None),
            bound=extra.pop("bound", None),
            rendered=extra.pop("rendered", False),
            confirmed=extra.pop("confirmed", False),
            placement=extra.pop("placement", None),
            picture=extra.pop("picture", None),
        )
        result["floated"] = extra.pop("floated", False)
        result["moved"] = extra.pop("moved", False)
        result["delayed"] = extra.pop("delayed", False)
        result["channels"] = list(channels)
        result["tween_channels"] = list(tween_channels)
        result["kind"] = kind if isinstance(kind, str) else ""
        result["program_id"] = extra.pop("program_id", None)
        return result

    asked_lift = None
    asked_breathe = None
    asked_to_lift = None
    asked_to_breathe = None
    seconds = None
    named = None
    delay_value = None
    wants_tween = False
    layer_args: dict = {}
    try:
        asked_lift = _optional_number(lift, "lift")
        asked_breathe = _optional_number(breathe, "breathe")
        if asked_lift is None and asked_breathe is None:
            raise ValueError("name a lift or a breathe")
        if asked_lift is not None:
            channels.append("lift")
        if asked_breathe is not None:
            channels.append("breathe")
        layer_args = dict(
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
            lift=asked_lift,
            breathe=asked_breathe,
        )
        effect_layer(EFFECT_ID, kind, "a", **layer_args)
        wants_tween = to_lift not in (None, "") or to_breathe not in (None, "")
        if delay not in (None, "") and not wants_tween:
            raise ValueError("delay needs a lift or a breathe to tween")
        if wants_tween:
            asked_to_lift = _optional_number(to_lift, "lift")
            asked_to_breathe = _optional_number(to_breathe, "breathe")
            fields = parse_float(asked_to_lift, asked_to_breathe)
            if "h" in fields:
                tween_channels.append("lift")
            if "b" in fields:
                tween_channels.append("breathe")
            if ease not in {"linear", "spring", "sine", "cubic", "bounce"}:
                raise ValueError("ease must be linear, spring, sine, cubic, or bounce")
            if dur not in (None, ""):
                if isinstance(dur, bool) or not isinstance(dur, (int, float)):
                    raise ValueError("duration must be a number")
                seconds = float(dur)
                if seconds != seconds or seconds < 0.05 or seconds > 8:
                    raise ValueError("duration must be 0.05 to 8")
            elif ease != "spring":
                seconds = 0.6
            if delay not in (None, ""):
                delay_value = _optional_number(delay, "delay")
                if delay_value is None or delay_value < 0 or delay_value > 8:
                    raise ValueError("delay must be 0 to 8")
                tween_channels.append("delay")
            if tid not in (None, ""):
                if isinstance(tid, bool) or not isinstance(tid, int) or tid < 1 or tid > 64:
                    raise ValueError("tween id must be 1 to 64")
                named = tid
            tween_float(
                EFFECT_ID,
                "a",
                to_lift=asked_to_lift,
                to_breathe=asked_to_breathe,
                ease=ease,
                dur=seconds,
                delay=delay_value,
                tid=named,
            )
    except (TypeError, ValueError) as exc:
        return quiet(str(exc))

    port, close, failed = _claim_port(
        session, claims, port, tty_key, tty_path, text=text, artifact="layer", mesh="",
    )
    if failed is not None:
        failed["floated"] = False
        failed["moved"] = False
        failed["delayed"] = False
        failed["channels"] = list(channels)
        failed["tween_channels"] = list(tween_channels)
        failed["kind"] = kind if isinstance(kind, str) else ""
        failed["program_id"] = None
        return failed
    try:
        reply, buf = probe(port, _token(), timeout)
        if reply is None or not reply.ok or da1_before_glass(buf):
            _release_if_unused(claims, session)
            reason = "terminal is not glass" if reply is None or da1_before_glass(buf) else (
                f"terminal did not answer glass hello: {reply.code}"
            )
            return quiet(reason, bound=False)
        if "layer" not in reply.ops:
            _release_if_unused(claims, session)
            return quiet("terminal has no layer op", ops=reply.ops, version=reply.version, bound=True)
        if wants_tween and "tween" not in reply.ops:
            _release_if_unused(claims, session)
            return quiet("terminal has no tween op", ops=reply.ops, version=reply.version, bound=True)
        token = _token()
        frame = effect_layer(EFFECT_ID, kind, token, **layer_args)
        placed, _spent = exchange(port, frame, token, timeout)
        if placed is None or not placed.ok:
            _release_if_unused(claims, session)
            code = "no reply" if placed is None else placed.code
            return quiet(code, ops=reply.ops, version=reply.version, bound=True)
        claims.note_effect(session, EFFECT_ID)
        if not wants_tween:
            result = _result(
                True,
                session=session,
                text=text,
                reason="layer accepted",
                artifact="layer",
                rendered=True,
                confirmed=True,
                placement="layer",
                picture=EFFECT_ID,
                ops=reply.ops,
                version=reply.version,
                bound=True,
            )
            result["floated"] = True
            result["moved"] = False
            result["delayed"] = False
            result["channels"] = list(channels)
            result["tween_channels"] = []
            result["kind"] = kind
            result["program_id"] = EFFECT_ID
            return result
        tween_token = _token()
        tween = tween_float(
            EFFECT_ID,
            tween_token,
            to_lift=asked_to_lift,
            to_breathe=asked_to_breathe,
            ease=ease,
            dur=seconds,
            delay=delay_value,
            tid=named,
        )
        moved, _spent = exchange(port, tween, tween_token, timeout)
        accepted = moved is not None and bool(moved.ok)
        reason = "float and tween accepted" if accepted else (
            "no reply" if moved is None else (moved.code or "glass did not confirm the tween")
        )
        result = _result(
            accepted,
            session=session,
            text=text,
            reason=reason,
            artifact="layer",
            rendered=True,
            confirmed=True,
            placement="layer",
            picture=EFFECT_ID,
            ops=reply.ops,
            version=reply.version,
            bound=True,
        )
        result["floated"] = True
        result["moved"] = accepted
        result["delayed"] = accepted and delay_value is not None
        result["channels"] = list(channels)
        result["tween_channels"] = list(tween_channels)
        result["kind"] = kind
        result["program_id"] = EFFECT_ID
        return result
    finally:
        if close:
            port.close()


def spark_layer(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    kind: str = "particles",
    color: str | None = None,
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
    flicker: float | None = None,
    stand: str | None = None,
    up=None,
    to_size=None,
    delay: float | None = None,
    ease: str = "sine",
    dur: float | None = None,
    tid: int | None = None,
) -> dict:
    """Place one overlay that flickers or stands, then optionally tween mote size.

    flicker and stand are omitted from glass_layer and glass_float.
    A size tween is particles only, and it is sent only after the layer OK.
    sparked is true only after that layer OK. moved is true only after the
    tween OK. An OK does not prove the overlay has arrived or that the motes
    have grown.
    """
    if not session or not str(session).strip():
        raise ValueError("missing session id")
    close = False
    asked_flicker = None
    asked_stand = None
    channels: list[str] = []
    tween_channels: list[str] = []
    program_id = 0

    def quiet(reason: str) -> dict:
        result = _result(
            False,
            session=session,
            text=f"spark {kind if isinstance(kind, str) else ''}",
            reason=reason,
            artifact="layer",
            rendered=False,
            confirmed=False,
            placement=None,
            picture=None,
        )
        result["sparked"] = False
        result["moved"] = False
        result["delayed"] = False
        result["channels"] = list(channels)
        result["tween_channels"] = list(tween_channels)
        result["kind"] = kind if isinstance(kind, str) else ""
        result["stand"] = asked_stand
        result["flicker"] = asked_flicker
        result["program_id"] = program_id or None
        return result

    try:
        if isinstance(kind, str):
            kind = kind.strip().lower()
        if kind not in ("glow", "particles", "ring", "line", "prim", "solid"):
            raise ValueError("kind must be glow, particles, ring, line, prim, or solid")
        asked_flicker = _optional_number(flicker, "flicker")
        if stand not in (None, ""):
            if not isinstance(stand, str):
                raise ValueError("stand must be floor, up, or screen")
            asked_stand = stand.strip().lower()
        if asked_flicker is None and asked_stand is None:
            raise ValueError("name a flicker or a stand")
        wants_tween = to_size not in (None, "")
        if wants_tween and kind != "particles":
            raise ValueError("size tween is only for particles")
        if delay not in (None, "") and not wants_tween:
            raise ValueError("delay needs a mote size to tween")
        layer_args = {
            "x": x,
            "y": y,
            "width": width,
            "height": height,
            "color": color,
            "opacity": opacity,
            "z": z,
            "add": add,
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
            "flicker": asked_flicker,
            "stand": asked_stand,
            "foot": up,
        }
        effect_layer(EFFECT_ID, kind, "a", **layer_args)
        delay_value = _optional_number(delay, "delay") if wants_tween else None
        if wants_tween:
            tween_size(
                EFFECT_ID,
                "a",
                to_size=to_size,
                ease=ease or "sine",
                dur=None if ease == "spring" and dur in (None, "") else dur,
                delay=delay_value,
                tid=tid,
            )
        if asked_flicker is not None:
            channels.append("flicker")
        if asked_stand is not None:
            channels.append("stand")
        if up not in (None, ""):
            channels.append("foot")
        if wants_tween:
            tween_channels.append("size")
            if delay_value is not None:
                tween_channels.append("delay")
    except (TypeError, ValueError) as exc:
        return quiet(str(exc))
    text = f"spark {kind if isinstance(kind, str) else ''}"
    port, close, failed = _claim_port(
        session, claims, port, tty_key, tty_path, text=text, artifact="layer", mesh="",
    )
    if failed is not None:
        failed["sparked"] = False
        failed["moved"] = False
        failed["delayed"] = False
        failed["channels"] = list(channels)
        failed["tween_channels"] = list(tween_channels)
        failed["kind"] = kind if isinstance(kind, str) else ""
        failed["stand"] = asked_stand
        failed["flicker"] = asked_flicker
        failed["program_id"] = None
        return failed
    try:
        reply, buf = probe(port, _token(), timeout)
        if reply is None or not reply.ok or da1_before_glass(buf):
            _release_if_unused(claims, session)
            reason = "terminal is not glass" if reply is None or da1_before_glass(buf) else (
                f"terminal did not answer glass hello: {reply.code}"
            )
            return quiet(reason)
        if "layer" not in reply.ops:
            _release_if_unused(claims, session)
            return quiet("terminal has no layer op")
        if wants_tween and "tween" not in reply.ops:
            _release_if_unused(claims, session)
            return quiet("terminal has no tween op")
        layer_token = _token()
        frame = effect_layer(EFFECT_ID, kind, layer_token, **layer_args)
        placed, _spent = exchange(port, frame, layer_token, timeout)
        if placed is None or not placed.ok:
            _release_if_unused(claims, session)
            code = "no reply" if placed is None else placed.code
            return quiet(code)
        claims.note_effect(session, EFFECT_ID)
        program_id = EFFECT_ID
        if not wants_tween:
            result = _result(
                True,
                session=session,
                text=text,
                reason="layer accepted",
                artifact="layer",
                rendered=True,
                confirmed=True,
                placement="layer",
                picture=EFFECT_ID,
                ops=reply.ops,
                version=reply.version,
                bound=True,
            )
            result["sparked"] = True
            result["moved"] = False
            result["delayed"] = False
            result["channels"] = list(channels)
            result["tween_channels"] = []
            result["kind"] = kind
            result["stand"] = asked_stand
            result["flicker"] = asked_flicker
            result["program_id"] = program_id
            return result
        tween_token = _token()
        tween = tween_size(
            EFFECT_ID,
            tween_token,
            to_size=to_size,
            ease=ease or "sine",
            dur=None if ease == "spring" and dur in (None, "") else dur,
            delay=delay_value,
            tid=tid,
        )
        moved, _spent = exchange(port, tween, tween_token, timeout)
        accepted = moved is not None and bool(moved.ok)
        reason = "spark and size accepted" if accepted else (
            "no reply" if moved is None else (moved.code or "glass did not confirm the tween")
        )
        result = _result(
            accepted,
            session=session,
            text=text,
            reason=reason,
            artifact="layer",
            rendered=True,
            confirmed=True,
            placement="layer",
            picture=EFFECT_ID,
            ops=reply.ops,
            version=reply.version,
            bound=True,
        )
        result["sparked"] = True
        result["moved"] = accepted
        result["delayed"] = accepted and delay_value is not None
        result["channels"] = list(channels)
        result["tween_channels"] = list(tween_channels)
        result["kind"] = kind
        result["stand"] = asked_stand
        result["flicker"] = asked_flicker
        result["program_id"] = program_id
        return result
    finally:
        if close:
            port.close()


def burst_layer(
    *,
    session: str | None,
    claims: Claims,
    burst,
    pin: str | None = None,
    x: int = 48,
    y: int = 48,
    width: int = 320,
    height: int = 180,
    color: str | None = None,
    opacity: float | None = None,
    count: int | None = None,
    size: float | None = None,
    life: float | None = None,
    rise: float | None = None,
    sway: float | None = None,
    seed: int | None = None,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
) -> dict:
    """Place one particle overlay with a burst age, optionally pinned to the window.

    ``burst`` is how long ago the burst went off, 0 to 600. It is not a strength.
    ``pin=window`` sends ``at=`` and ``anchor=window``, not ``px=``. Without a pin
    the frame uses ``px=`` and does not send ``at=`` or ``anchor``. It does not
    send ``fl=``, ``stand=``, ``h=``, ``b=``, or a tween. ``bursted``, ``rendered``,
    and ``confirmed`` are true only after the layer OK. ``pinned`` is true only
    when that accepted frame included ``anchor=window``. An OK does not prove the
    motes are visible. Age outside 0..life draws none on this engine.
    """
    close = False
    asked_pin = None
    channels: list[str] = []
    program_id = 0
    life_sent = None
    burst_sent = None

    def quiet(reason: str) -> dict:
        result = _result(
            False,
            session=session,
            text="burst particles",
            reason=reason,
            artifact="layer",
            rendered=False,
            confirmed=False,
            placement=None,
            picture=None,
        )
        result["bursted"] = False
        result["pinned"] = False
        result["channels"] = list(channels)
        result["kind"] = "particles"
        result["burst"] = burst_sent
        result["life"] = life_sent
        result["pin"] = asked_pin
        result["program_id"] = program_id or None
        return result

    try:
        burst_sent = _optional_number(burst, "burst")
        if burst_sent is None:
            raise ValueError("name a burst")
        if pin not in (None, ""):
            if not isinstance(pin, str) or pin.strip().lower() != "window":
                raise ValueError("pin must be window")
            asked_pin = "window"
        layer_args = {
            "x": x,
            "y": y,
            "width": width,
            "height": height,
            "color": color,
            "opacity": opacity,
            "count": count,
            "size": size,
            "life": life,
            "rise": rise,
            "sway": sway,
            "seed": seed,
            "burst": burst_sent,
            "pin": asked_pin,
        }
        preview = effect_layer(EFFECT_ID, "particles", "a", **layer_args)
        channels.append("burst")
        if asked_pin == "window":
            channels.append("anchor")
        body = preview.split(b"glass;", 1)[1].split(b"\x1b\\", 1)[0]
        life_sent = None
        for part in body.split(b";"):
            if part.startswith(b"burst="):
                burst_sent = float(part.split(b"=", 1)[1])
            elif part.startswith(b"life="):
                life_sent = float(part.split(b"=", 1)[1])
    except (TypeError, ValueError) as exc:
        return quiet(str(exc))
    text = "burst particles"
    port, close, failed = _claim_port(
        session, claims, port, tty_key, tty_path, text=text, artifact="layer", mesh="",
    )
    if failed is not None:
        failed["bursted"] = False
        failed["pinned"] = False
        failed["channels"] = list(channels)
        failed["kind"] = "particles"
        failed["burst"] = burst_sent
        failed["life"] = life_sent
        failed["pin"] = asked_pin
        failed["program_id"] = None
        return failed
    try:
        reply, buf = probe(port, _token(), timeout)
        if reply is None or not reply.ok or da1_before_glass(buf):
            _release_if_unused(claims, session)
            reason = "terminal is not glass" if reply is None or da1_before_glass(buf) else (
                f"terminal did not answer glass hello: {reply.code}"
            )
            return quiet(reason)
        if "layer" not in reply.ops:
            _release_if_unused(claims, session)
            return quiet("terminal has no layer op")
        layer_token = _token()
        frame = effect_layer(EFFECT_ID, "particles", layer_token, **layer_args)
        placed, _spent = exchange(port, frame, layer_token, timeout)
        if placed is None or not placed.ok:
            _release_if_unused(claims, session)
            code = "no reply" if placed is None else placed.code
            return quiet(f"layer was not accepted: {code}")
        program_id = EFFECT_ID
        claims.note_effect(session, program_id)
        result = _result(
            True,
            session=session,
            text=text,
            artifact="layer",
            rendered=True,
            confirmed=True,
            placement="layer",
            picture=EFFECT_ID,
            ops=reply.ops,
            version=reply.version,
            bound=True,
        )
        result["bursted"] = True
        result["pinned"] = asked_pin == "window"
        result["channels"] = list(channels)
        result["kind"] = "particles"
        result["burst"] = burst_sent
        result["life"] = life_sent
        result["pin"] = asked_pin
        result["program_id"] = program_id
        return result
    finally:
        if close:
            port.close()


def wrap_scene(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    mesh: str = "plane",
    color: str | None = None,
    colors: str | None = None,
    sampling: str | None = None,
    spin: bool = False,
    ease: str = "sine",
    x: int = 48,
    y: int = 48,
    width: int = 320,
    height: int = 240,
    timeout: float = 0.35,
) -> dict:
    """Upload one card and cite it from a scene node.

    ``wrapped``, ``rendered``, and ``confirmed`` are true only after the scene
    OK. ``uploaded`` is true only after the picture OK and only when the scene
    was also accepted. ``nearest`` is true only when that accepted frame
    included ``sampling`` nearest. linear is omitted. An OK does not prove the
    pixels are visible. A refused picture is not followed by a scene. A refused
    scene removes a picture this call uploaded and is not claimed. A picture
    that was already the session wrap is left in place if the replacement
    scene is refused, because the scene still showing cites it.
    """
    text = "wrap"
    picture_id = WRAP_PICTURE

    def quiet(reason: str) -> dict:
        failed = _result(
            False,
            session=session,
            text=text,
            artifact="scene",
            rendered=False,
            confirmed=False,
            placement="none",
            picture=None,
            ops=[],
            version=None,
            bound=False,
        )
        failed["wrapped"] = False
        failed["uploaded"] = False
        failed["nearest"] = False
        failed["moved"] = False
        failed["sampling"] = None
        failed["mesh"] = None
        failed["texture"] = None
        failed["channels"] = []
        failed["reason"] = reason
        return failed

    sample = None if sampling in (None, "") else str(sampling).strip().lower()
    if sample not in (None, "linear", "nearest"):
        return quiet("sampling is linear or nearest")
    try:
        tint = parse_color("ffffff" if color in (None, "") else color)
        rgb, card_w, card_h = plate_card(colors)
        payload = wrap_payload(mesh, tint, picture_id, sampling=sample)
    except (ValueError, TypeError) as exc:
        return quiet(str(exc))

    port, close, failed = _claim_port(
        session, claims, port, tty_key, tty_path, text=text, artifact="scene", mesh=mesh
    )
    if failed is not None:
        failed["wrapped"] = False
        failed["uploaded"] = False
        failed["nearest"] = False
        failed["moved"] = False
        failed["sampling"] = None
        failed["mesh"] = mesh
        failed["texture"] = None
        failed["channels"] = []
        return failed
    try:
        reply, buf = probe(port, _token(), timeout)
        if reply is None or not reply.ok or da1_before_glass(buf):
            _release_if_unused(claims, session)
            reason = "terminal is not glass" if reply is None or da1_before_glass(buf) else (
                f"terminal did not answer glass hello: {reply.code}"
            )
            return quiet(reason)
        if "picture" not in reply.ops:
            _release_if_unused(claims, session)
            return quiet("terminal has no picture op")
        if "scene" not in reply.ops:
            _release_if_unused(claims, session)
            return quiet("terminal has no scene op")
        previous_wrap = claims.wrap(session)
        upload_token = _token()
        uploaded, _spent = exchange(
            port,
            picture(picture_id, rgb, card_w, card_h, upload_token),
            upload_token,
            timeout,
        )
        if uploaded is None or not uploaded.ok:
            _release_if_unused(claims, session)
            code = "no reply" if uploaded is None else uploaded.code
            return quiet(f"picture was not accepted: {code}")
        scene_id = claims.allocate(session)
        scene_token = _token()
        frame = scene_frame(scene_id, payload, scene_token, width=width, height=height, x=x, y=y)
        placed, _spent = exchange(port, frame, scene_token, timeout)
        if placed is None or not placed.ok:
            _remove_quiet(port, scene_id, None, timeout)
            if previous_wrap is None:
                _remove_quiet(port, picture_id, None, timeout)
            _release_if_unused(claims, session)
            code = "no reply" if placed is None else placed.code
            return quiet(f"scene was not accepted: {code}")
        previous_kind = claims.kind(session)
        previous, previous_layer = claims.note_shown(session, scene_id, None, kind="scene")
        if previous and previous != scene_id:
            _remove_quiet(port, previous, previous_layer, timeout)
        if previous_kind in ("page", "chart", "image", "showcase", "video"):
            close_token = _token()
            exchange(port, close_showcase(close_token), close_token, timeout)
        _drop_faces(port, claims, session, timeout)
        claims.note_wrap(session, picture_id)
        moved = False
        reason = "glass accepted the wrap"
        if spin:
            if "tween" not in reply.ops:
                reason = "glass accepted the wrap; hello did not list tween"
            else:
                moved, spin_reason = _send_spin(port, scene_id, timeout, ease=ease)
                reason = spin_reason.replace("the scene", "the wrap")
        result = _result(
            True,
            session=session,
            text=text,
            artifact="scene",
            rendered=True,
            confirmed=True,
            placement="scene",
            picture=scene_id,
            ops=reply.ops,
            version=reply.version,
            bound=True,
        )
        result["wrapped"] = True
        result["uploaded"] = True
        result["nearest"] = sample == "nearest"
        result["moved"] = moved
        result["sampling"] = "nearest" if sample == "nearest" else "linear"
        result["mesh"] = mesh
        result["texture"] = picture_id
        result["channels"] = ["picture", "sampling"] if sample == "nearest" else ["picture"]
        result["reason"] = reason
        return result
    finally:
        if close:
            port.close()


def plate_layer(
    *,
    session: str | None,
    claims: Claims,
    kind: str | None = "picture",
    src: str | None = None,
    colors: str | None = None,
    x: int = 48,
    y: int = 48,
    width: int = 160,
    height: int = 80,
    pin: str | None = None,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
) -> dict:
    """Upload one small picture, then hang it as a picture or part overlay.

    A refused picture is not followed by a layer. A refused layer removes
    the picture and is not claimed. The glow, spark, and burst frames are
    not this frame.
    """
    text = "plate"
    picture_id = PLATE_PICTURE
    layer_id = PLATE_LAYER

    def quiet(reason: str) -> dict:
        failed = _result(
            False,
            session=session,
            text=text,
            artifact="layer",
            rendered=False,
            confirmed=False,
            placement="none",
            picture=None,
            ops=[],
            version=None,
            bound=False,
        )
        failed["plated"] = False
        failed["uploaded"] = False
        failed["parted"] = False
        failed["pinned"] = False
        failed["channels"] = []
        failed["kind"] = None
        failed["layer"] = None
        failed["src"] = None
        failed["card_width"] = None
        failed["card_height"] = None
        failed["pin"] = None
        failed["program_id"] = None
        failed["reason"] = reason
        return failed

    try:
        rgb, card_w, card_h = plate_card(colors)
        asked_kind = "picture" if kind in (None, "") else str(kind).strip().lower()
        if asked_kind not in ("picture", "part"):
            raise ValueError("plate kind must be picture or part")
        asked_src = None
        if src not in (None, ""):
            if asked_kind != "part":
                raise ValueError("src is only for part")
            asked_src = parse_src(str(src), card_w, card_h)
        elif asked_kind == "part":
            raise ValueError("part needs src")
        asked_pin = None if pin in (None, "") else str(pin).strip().lower()
        place_x = int(x)
        place_y = int(y)
        place_w = int(width)
        place_h = int(height)
        layer_plate(
            layer_id,
            picture_id,
            "a",
            kind=asked_kind,
            x=place_x,
            y=place_y,
            width=place_w,
            height=place_h,
            src=asked_src,
            pin=asked_pin,
        )
    except (ClaimError, ValueError, TypeError) as exc:
        return quiet(str(exc))

    channels = ["picture"]
    if asked_kind == "part":
        channels.append("src")
    if asked_pin == "window":
        channels.append("anchor")
    src_text = None if asked_src is None else f"{asked_src[0]},{asked_src[1]},{asked_src[2]},{asked_src[3]}"

    port, close, failed = _claim_port(
        session, claims, port, tty_key, tty_path, text=text, artifact="layer", mesh=""
    )
    if failed is not None:
        failed["plated"] = False
        failed["uploaded"] = False
        failed["parted"] = False
        failed["pinned"] = False
        failed["channels"] = list(channels)
        failed["kind"] = asked_kind
        failed["layer"] = None
        failed["src"] = src_text
        failed["card_width"] = card_w
        failed["card_height"] = card_h
        failed["pin"] = asked_pin
        failed["program_id"] = None
        return failed
    try:
        reply, buf = probe(port, _token(), timeout)
        if reply is None or not reply.ok or da1_before_glass(buf):
            _release_if_unused(claims, session)
            reason = "terminal is not glass" if reply is None or da1_before_glass(buf) else (
                f"terminal did not answer glass hello: {reply.code}"
            )
            return quiet(reason)
        if "picture" not in reply.ops:
            _release_if_unused(claims, session)
            return quiet("terminal has no picture op")
        if "layer" not in reply.ops:
            _release_if_unused(claims, session)
            return quiet("terminal has no layer op")
        upload_token = _token()
        uploaded, _spent = exchange(
            port,
            picture(picture_id, rgb, card_w, card_h, upload_token),
            upload_token,
            timeout,
        )
        if uploaded is None or not uploaded.ok:
            _release_if_unused(claims, session)
            code = "no reply" if uploaded is None else uploaded.code
            return quiet(f"picture was not accepted: {code}")
        layer_token = _token()
        frame = layer_plate(
            layer_id,
            picture_id,
            layer_token,
            kind=asked_kind,
            x=place_x,
            y=place_y,
            width=place_w,
            height=place_h,
            src=asked_src,
            pin=asked_pin,
        )
        placed, _spent = exchange(port, frame, layer_token, timeout)
        if placed is None or not placed.ok:
            _remove_quiet(port, picture_id, layer_id, timeout)
            claims.clear_plate(session)
            _release_if_unused(claims, session)
            code = "no reply" if placed is None else placed.code
            return quiet(f"layer was not accepted: {code}")
        claims.note_plate(session, picture_id, layer_id)
        result = _result(
            True,
            session=session,
            text=text,
            artifact="layer",
            rendered=True,
            confirmed=True,
            placement="layer",
            picture=picture_id,
            ops=reply.ops,
            version=reply.version,
            bound=True,
        )
        result["plated"] = True
        result["uploaded"] = True
        result["parted"] = asked_kind == "part"
        result["pinned"] = asked_pin == "window"
        result["channels"] = list(channels)
        result["kind"] = asked_kind
        result["layer"] = layer_id
        result["src"] = src_text
        result["card_width"] = card_w
        result["card_height"] = card_h
        result["pin"] = asked_pin
        result["program_id"] = layer_id
        return result
    finally:
        if close:
            port.close()


def show_layer(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    kind: str = "glow",
    color: str | None = None,
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
) -> dict:
    """Place one overlay layer. It does not remove a chart, scene, or panel."""
    text = f"layer {kind}"

    def finish(result, *, shown_kind="", program_id=None):
        result["kind"] = shown_kind
        result["program_id"] = program_id
        return result

    try:
        effect_layer(
            EFFECT_ID,
            kind,
            "a",
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
        )
    except ValueError as exc:
        return finish(
            _result(False, session=session, text=text, reason=str(exc), artifact="layer"),
        )
    port, close, failed = _claim_port(
        session, claims, port, tty_key, tty_path, text=text, artifact="layer", mesh="",
    )
    if failed is not None:
        return finish(failed)
    try:
        reply, buf = probe(port, _token(), timeout)
        if da1_before_glass(buf) or reply is None or not reply.ok:
            _release_if_unused(claims, session)
            reason = "terminal is not glass" if reply is None or da1_before_glass(buf) else (
                f"terminal did not answer glass hello: {reply.code}"
            )
            return finish(
                _result(True, session=session, text=text, reason=reason, fallback="text", artifact="layer")
            )
        if "layer" not in reply.ops:
            _release_if_unused(claims, session)
            return finish(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason="glass hello did not list layer; not written",
                    fallback="text",
                    ops=reply.ops,
                    version=reply.version,
                    artifact="layer",
                )
            )
        token = _token()
        frame = effect_layer(
            EFFECT_ID,
            kind,
            token,
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
        )
        placed, _spent = exchange(port, frame, token, timeout)
        if placed is None or not placed.ok:
            _release_if_unused(claims, session)
            code = "no reply" if placed is None else placed.code
            return finish(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=f"glass refused the layer: {code}",
                    fallback="text",
                    ops=reply.ops,
                    version=reply.version,
                    artifact="layer",
                )
            )
        claims.note_effect(session, EFFECT_ID)
        return finish(
            _result(
                True,
                session=session,
                text=text,
                reason="glass confirmed the layer",
                rendered=True,
                confirmed=True,
                placement="layer",
                picture=EFFECT_ID,
                ops=reply.ops,
                version=reply.version,
                artifact="layer",
            ),
            shown_kind=str(kind).strip().lower(),
            program_id=EFFECT_ID,
        )
    finally:
        if close:
            port.close()


def show_view(
    *,
    session: str | None,
    mesh: str | None = None,
    pieces: str | None = None,
    stage: str | None = None,
    color: str | None = None,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
    width: int = 320,
    height: int = 240,
    fit: str = "contain",
    chrome=None,
    liquid=None,
    segments=None,
    radius=None,
    seed=None,
    steps=None,
    posts=None,
    finish: str = "plain",
) -> dict:
    """Open the showcase on scene nodes. This sends model, not a placed scene and not a glTF upload."""
    names = None
    stage_label = None
    try:
        rgba = parse_color(color)
        width_px = _as_int(width, "width", 1, 2048)
        height_px = _as_int(height, "height", 1, 2048)
        fit_name = str(fit or "contain").strip().lower()
        if fit_name not in ("contain", "width"):
            raise ValueError("fit must be contain or width")
        stage_name = str(stage or "").strip().lower()
        piece_text = str(pieces or "").strip()
        if stage_name and piece_text:
            raise ValueError("pass stage or pieces, not both")
        if stage_name:
            if stage_name != "court":
                raise ValueError("stage must be court")
            piece_text = COURT_PIECES
            stage_label = "court"
        elif piece_text:
            stage_label = "pieces"
        if piece_text:
            finish_name, chrome_amount, liquid_amount = _stage_finish(finish, chrome, liquid)
            payload = stage_payload(
                piece_text,
                chrome=chrome_amount,
                liquid=liquid_amount,
                segments=segments,
                radius=radius,
                seed=seed,
                steps=steps,
                posts=posts,
                auto_segments=finish_name == "mercury" and segments is None,
            )
            names = [item["mesh"] for item in parse_pieces(piece_text)]
            mesh_name = "stage"
            text = _stage_text(names, width_px, height_px, chrome_amount, liquid_amount)
        else:
            mesh_name = _mesh(mesh or "cube")
            chrome_amount, liquid_amount, shape_segments = _finish(
                finish,
                mesh_name,
                chrome,
                liquid,
                segments,
            )
            payload = scene_payload(
                mesh_name,
                rgba,
                chrome=chrome_amount,
                liquid=liquid_amount,
                segments=shape_segments,
                radius=radius,
                seed=seed,
                steps=steps,
                posts=posts,
            )
            text = _scene_text(mesh_name, rgba, width_px, height_px, chrome_amount, liquid_amount)
        node_count = len(names) if names else 1
    except ValueError as exc:
        return _view_stamp(
            _result(False, reason=str(exc), artifact="view"),
            mesh=None,
            nodes=0,
            fit=None,
            width=None,
            height=None,
            opened=False,
        )
    fields = dict(mesh=mesh_name, nodes=node_count, fit=fit_name, width=width_px, height=height_px)
    if not session:
        return _view_stamp(
            _result(False, reason="session required", text=text, artifact="view"),
            opened=False,
            **fields,
        )
    opened, close, error = _claim_port(
        session,
        claims,
        port,
        tty_key,
        tty_path,
        text=text,
        artifact="view",
        mesh=mesh_name,
    )
    if error is not None:
        return _view_stamp(error, opened=False, **fields)
    try:
        try:
            return _show_view_open(
                session,
                claims,
                opened,
                timeout,
                text=text,
                payload=payload,
                stage=stage_label,
                names=names,
                **fields,
            )
        except ClaimError as exc:
            return _view_stamp(
                _result(
                    False,
                    session=session,
                    text=text,
                    reason=exc.reason,
                    fallback="text",
                    artifact="view",
                ),
                opened=False,
                **fields,
            )
        except OSError as exc:
            _release_if_unused(claims, session)
            return _view_stamp(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=f"terminal closed during the model panel: {exc}",
                    fallback="text",
                    artifact="view",
                ),
                opened=False,
                **fields,
            )
    finally:
        if close and opened is not None:
            opened.close()


def _show_view_open(session, claims, port, timeout, *, text, payload, stage, names, mesh, nodes, fit, width, height):
    hello_token = _token()
    hello_reply, _ = probe(port, hello_token, timeout)
    if hello_reply is None or not hello_reply.ok:
        _release_if_unused(claims, session)
        return _view_stamp(
            _result(
                True,
                session=session,
                text=text,
                reason="glass did not answer hello",
                fallback="text",
                artifact="view",
            ),
            opened=False,
            mesh=mesh,
            nodes=nodes,
            fit=fit,
            width=width,
            height=height,
        )
    if "model" not in hello_reply.ops:
        _release_if_unused(claims, session)
        return _view_stamp(
            _result(
                True,
                session=session,
                text=text,
                reason="glass hello did not list model",
                fallback="text",
                artifact="view",
            ),
            opened=False,
            mesh=mesh,
            nodes=nodes,
            fit=fit,
            width=width,
            height=height,
        )
    token = _token()
    frame = view_model(payload, token, width=width, height=height, fit=fit)
    reply, _ = exchange(port, frame, token, timeout)
    if reply is None or not reply.ok:
        _release_if_unused(claims, session)
        reason = "glass refused the model panel" if reply is not None else "glass did not answer the model panel"
        return _view_stamp(
            _result(
                True,
                session=session,
                text=text,
                reason=reason,
                fallback="text",
                artifact="view",
            ),
            opened=False,
            mesh=mesh,
            nodes=nodes,
            fit=fit,
            width=width,
            height=height,
        )
    previous, previous_layer = claims.note_view(session)
    if previous:
        _remove_quiet(port, previous, previous_layer, timeout)
    return _note_stage(
        _view_stamp(
            _result(
                True,
                session=session,
                text=text,
                reason="glass accepted the model panel",
                rendered=True,
                confirmed=True,
                placement="view",
                artifact="view",
                ops=reply.ops,
                version=reply.version,
            ),
            opened=True,
            mesh=mesh,
            nodes=nodes,
            fit=fit,
            width=width,
            height=height,
        ),
        names,
        stage,
    )


def _view_stamp(result, *, mesh, nodes, fit, width, height, opened):
    stamped = _stamp(result, mesh=mesh, moved=False)
    stamped["nodes"] = nodes
    stamped["fit"] = fit
    stamped["width"] = width
    stamped["height"] = height
    stamped["opened"] = opened
    return stamped


def show_group(
    *,
    session: str | None,
    claims: Claims,
    pieces: str | None = None,
    stage: str | None = None,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
) -> dict:
    """Replace a whole overlay set. It does not remove a chart, scene, panel, or the single overlay."""
    text = "group"

    def finish(result, *, count=0, stage_name="", first=None, last=None, rendered=False):
        result["count"] = count
        result["group_id"] = GROUP_ID if rendered else None
        result["first"] = first
        result["last"] = last
        result["stage"] = stage_name or None
        return result

    asked_stage = (stage or "").strip()
    asked_pieces = (pieces or "").strip()
    if asked_stage and asked_pieces:
        return finish(
            _result(False, session=session, text=text, reason="pass stage or pieces, not both", artifact="group")
        )
    stage_name = ""
    if asked_stage:
        if asked_stage != "hud":
            return finish(_result(False, session=session, text=text, reason="stage must be hud", artifact="group"))
        asked_pieces = HUD
        stage_name = "hud"
    if not asked_pieces:
        return finish(_result(False, session=session, text=text, reason="pieces required", artifact="group"))
    try:
        parsed = parse_group_pieces(asked_pieces)
        records = group_records(parsed)
    except ValueError as exc:
        return finish(_result(False, session=session, text=text, reason=str(exc), artifact="group"))
    count = len(records)
    first = GROUP_LAYER_BASE
    last = first + count - 1
    opened, close, failed = _claim_port(
        session, claims, port, tty_key, tty_path, text=text, artifact="group", mesh="",
    )
    if failed is not None:
        return finish(failed)
    try:
        reply, buf = probe(opened, _token(), timeout)
        if da1_before_glass(buf) or reply is None or not reply.ok:
            _release_if_unused(claims, session)
            reason = "terminal is not glass" if reply is None or da1_before_glass(buf) else (
                f"terminal did not answer glass hello: {reply.code}"
            )
            return finish(
                _result(True, session=session, text=text, reason=reason, fallback="text", artifact="group")
            )
        if "group" not in reply.ops:
            _release_if_unused(claims, session)
            return finish(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason="glass hello did not list group; not written",
                    fallback="text",
                    ops=reply.ops,
                    version=reply.version,
                    artifact="group",
                )
            )
        token = _token()
        placed, _spent = exchange(opened, group_frame(records, token), token, timeout)
        if placed is None or not placed.ok:
            _release_if_unused(claims, session)
            code = "no reply" if placed is None else placed.code
            return finish(
                _result(
                    True,
                    session=session,
                    text=text,
                    reason=f"glass refused the group: {code}",
                    fallback="text",
                    ops=reply.ops,
                    version=reply.version,
                    artifact="group",
                )
            )
        claims.note_group(session, GROUP_ID, first, count)
        return finish(
            _result(
                True,
                session=session,
                text=text,
                reason="glass confirmed the group",
                rendered=True,
                confirmed=True,
                placement="group",
                ops=reply.ops,
                version=reply.version,
                fallback=None,
                artifact="group",
            ),
            count=count,
            stage_name=stage_name,
            first=first,
            last=last,
            rendered=True,
        )
    finally:
        if close:
            opened.close()


def watch_events(
    *,
    session: str | None,
    claims: Claims,
    tty_key: str | None = None,
    tty_path: str | None = None,
    port=None,
    timeout: float = 0.35,
    arm: bool = True,
    wait: float = 0,
) -> dict:
    """Opt into showcase events and return only frames Glass actually wrote."""
    if not session:
        return _events_result(False, reason="no hermes session")
    if arm is not True and arm is not False:
        return _events_result(False, session=session, reason="arm must be true or false")
    try:
        pause = _event_wait(wait)
    except ValueError as exc:
        return _events_result(False, session=session, reason=str(exc))
    opened, close, failed = _claim_port(
        session, claims, port, tty_key, tty_path, text="", artifact="events", mesh="",
    )
    if failed is not None:
        return _events_result(False, session=session, reason=failed.get("reason") or "no terminal")
    try:
        opened.skip_keeper = True
    except Exception:
        pass
    prior = claims.take_events(session)
    try:
        reply, buf = probe(opened, _token(), timeout)
        if da1_before_glass(buf) or reply is None or not reply.ok:
            _release_if_unused(claims, session)
            reason = "terminal is not glass" if reply is None or da1_before_glass(buf) else (
                f"terminal did not answer glass hello: {reply.code}"
            )
            return _events_result(
                False,
                session=session,
                reason=reason,
                events=_joined(prior, opened),
            )
        if "showcase" not in reply.ops:
            _release_if_unused(claims, session)
            return _events_result(
                False,
                session=session,
                reason="glass hello did not list showcase, so events were not armed",
                events=_joined(prior, opened),
                ops=reply.ops,
                version=reply.version,
            )
        token = _token()
        answer, _answer_buf = exchange(opened, events_frame(token, enabled=arm), token, timeout)
        if answer is None or not answer.ok:
            _release_if_unused(claims, session)
            reason = "glass refused showcase events" if answer is not None else "glass did not answer the events opt-in"
            return _events_result(
                False,
                session=session,
                reason=reason,
                events=_joined(prior, opened),
                ops=reply.ops,
                version=reply.version,
            )
        if pause:
            transport_mod.drain(opened, pause)
        claims.note_events(session, arm)
        return _events_result(
            True,
            session=session,
            reason="glass accepted showcase events" if arm else "glass accepted events off",
            armed=arm,
            disarmed=not arm,
            events=_joined(prior, opened),
            ops=reply.ops,
            version=reply.version,
        )
    except OSError as exc:
        return _events_result(
            False,
            session=session,
            reason=f"terminal closed: {exc}",
            events=_joined(prior, opened),
        )
    finally:
        if close:
            opened.close()


def _event_wait(value) -> float:
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        raise ValueError("wait must be a number")
    number = float(value)
    if number != number or number < 0 or number > 8:
        raise ValueError("wait must be from 0 to 8 seconds")
    return number


def _joined(prior: list, port) -> list:
    found = list(prior)
    found.extend(getattr(port, "kept_events", []) or [])
    return found


def _events_result(
    ok: bool,
    *,
    session: str | None = None,
    reason: str = "",
    events: list | None = None,
    armed: bool = False,
    disarmed: bool = False,
    ops=(),
    version=None,
) -> dict:
    found = [dict(item) for item in (events or []) if isinstance(item, dict)]
    saw = []
    for event in found:
        for key in event:
            if key not in saw:
                saw.append(key)
    result = {
        "ok": ok,
        "session": session,
        "reason": reason,
        "armed": armed,
        "disarmed": disarmed,
        "events": found,
        "count": len(found),
        "saw": saw,
        "rendered": False,
        "confirmed": False,
        "fallback": None,
    }
    if ops:
        result["ops"] = list(ops)
    if version:
        result["version"] = version
    clicks = [event["clicks"] for event in found if "clicks" in event]
    if clicks:
        result["clicks"] = clicks[-1]
    if any(event.get("close") == 1 for event in found):
        result["closed"] = True
    return result


def _named_card(path):
    """Load one image file. A symlink or a kernel path is refused first."""
    if path in (None, ""):
        raise ValueError("card needs a path")
    src = Path(path)
    text = str(src)
    if src.is_symlink() or text.startswith(("/proc", "/sys", "/dev")):
        raise ValueError("card path must be a regular image file")
    try:
        resolved = src.resolve(strict=True)
    except OSError as exc:
        raise ValueError("card path must be a regular image file") from exc
    resolved_text = str(resolved)
    if resolved.is_symlink() or resolved_text.startswith(("/proc", "/sys", "/dev")):
        raise ValueError("card path must be a regular image file")
    try:
        loaded = image_mod.load_image(resolved)
    except image_mod.ImageError as exc:
        raise ValueError(str(exc)) from exc
    if not loaded.data or len(loaded.data) > 750_000:
        raise ValueError("image file is empty or over 750000 bytes")
    return loaded


def _card_z(value):
    if value in (None, ""):
        return None
    if isinstance(value, bool):
        raise ValueError("z must be an integer")
    if isinstance(value, str):
        text = value.strip()
        if text == "":
            return None
        body = text[1:] if text[:1] in "+-" else text
        if not body.isdigit():
            raise ValueError("z must be an integer")
        value = int(text)
    return value


def card_layer(
    *,
    session: str | None,
    claims: Claims,
    path: str | None = None,
    z: int | None = None,
    x: int = 48,
    y: int = 48,
    width: int = 160,
    height: int = 80,
    pin: str | None = None,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
) -> dict:
    """Upload one named image, then hang it as a picture overlay.

    The upload is ``f=100``. ``z`` is sent only when it is not the default 0.
    A refused picture is not followed by a layer. A refused layer removes
    the picture and is not claimed. The plate and wrap frames are not this frame.
    """
    text = "card"
    picture_id = CARD_PICTURE
    layer_id = CARD_LAYER

    def quiet(reason: str, **extra) -> dict:
        failed = _result(
            False,
            session=session,
            text=text,
            artifact="layer",
            rendered=False,
            confirmed=False,
            placement="none",
            picture=None,
            ops=[],
            version=None,
            bound=False,
        )
        failed["carded"] = False
        failed["uploaded"] = False
        failed["named"] = False
        failed["depth"] = False
        failed["pinned"] = False
        failed["channels"] = []
        failed["layer"] = None
        failed["z"] = None
        failed["format"] = None
        failed["bytes"] = None
        failed["pin"] = None
        failed["path"] = None
        failed["width"] = None
        failed["height"] = None
        failed["program_id"] = None
        failed.update(extra)
        failed["carded"] = False
        failed["uploaded"] = False
        failed["named"] = False
        failed["rendered"] = False
        failed["confirmed"] = False
        failed["reason"] = reason
        return failed

    try:
        loaded = _named_card(path)
        asked_z = _card_z(z)
        asked_pin = None if pin in (None, "") else str(pin).strip().lower()
        place_x = int(x)
        place_y = int(y)
        place_w = int(width)
        place_h = int(height)
        layer_card(
            layer_id,
            picture_id,
            "a",
            x=place_x,
            y=place_y,
            width=place_w,
            height=place_h,
            z=asked_z,
            pin=asked_pin,
        )
        picture_file(picture_id, loaded.data, "a")
    except (ClaimError, ValueError, TypeError, OSError) as exc:
        return quiet(str(exc))

    sent_z = None if asked_z in (None, 0) else int(asked_z)
    channels = ["picture"]
    if asked_pin == "window":
        channels.append("anchor")
    if sent_z is not None:
        channels.append("z")
    prepared = {
        "format": loaded.kind,
        "bytes": len(loaded.data),
        "path": str(path),
        "width": loaded.width,
        "height": loaded.height,
        "pin": asked_pin,
        "z": sent_z,
        "channels": list(channels),
    }
    text = Path(path).name

    port, close, failed = _claim_port(
        session, claims, port, tty_key, tty_path, text=text, artifact="layer", mesh=""
    )
    if failed is not None:
        failed["carded"] = False
        failed["uploaded"] = False
        failed["named"] = False
        failed["depth"] = False
        failed["pinned"] = False
        failed["layer"] = None
        failed["program_id"] = None
        failed.update(prepared)
        return failed
    try:
        reply, buf = probe(port, _token(), timeout)
        if reply is None or not reply.ok or da1_before_glass(buf):
            _release_if_unused(claims, session)
            reason = "terminal is not glass" if reply is None or da1_before_glass(buf) else (
                f"terminal did not answer glass hello: {reply.code}"
            )
            return quiet(reason, **prepared)
        if "picture" not in reply.ops:
            _release_if_unused(claims, session)
            return quiet("terminal has no picture op", **prepared)
        if "layer" not in reply.ops:
            _release_if_unused(claims, session)
            return quiet("terminal has no layer op", **prepared)
        upload_token = _token()
        uploaded, _spent = exchange(
            port,
            picture_file(picture_id, loaded.data, upload_token),
            upload_token,
            timeout,
        )
        if uploaded is None or not uploaded.ok:
            _release_if_unused(claims, session)
            code = "no reply" if uploaded is None else uploaded.code
            return quiet(f"picture was not accepted: {code}", **prepared)
        layer_token = _token()
        frame = layer_card(
            layer_id,
            picture_id,
            layer_token,
            x=place_x,
            y=place_y,
            width=place_w,
            height=place_h,
            z=asked_z,
            pin=asked_pin,
        )
        placed, _spent = exchange(port, frame, layer_token, timeout)
        if placed is None or not placed.ok:
            _remove_quiet(port, picture_id, layer_id, timeout)
            claims.clear_card(session)
            _release_if_unused(claims, session)
            code = "no reply" if placed is None else placed.code
            return quiet(f"layer was not accepted: {code}", **prepared)
        claims.note_card(session, picture_id, layer_id)
        result = _result(
            True,
            session=session,
            text=text,
            artifact="layer",
            rendered=True,
            confirmed=True,
            placement="layer",
            picture=picture_id,
            ops=reply.ops,
            version=reply.version,
            bound=True,
        )
        result["carded"] = True
        result["uploaded"] = True
        result["named"] = True
        result["depth"] = sent_z is not None
        result["pinned"] = asked_pin == "window"
        result["channels"] = list(channels)
        result["layer"] = layer_id
        result["program_id"] = layer_id
        result.update(prepared)
        result["reason"] = "card accepted"
        return result
    finally:
        if close:
            port.close()


def clear(*, session: str | None, claims: Claims, port=None, timeout: float = 0.35) -> dict:
    if not session:
        return _result(False, reason="session required")
    path = claims.path_for(session)
    picture_id, layer_id = claims.shown(session)
    shown_kind = claims.kind(session)
    effect_id = claims.effect(session)
    group = claims.group(session)
    face_ids = claims.faces(session)
    plate = claims.plate(session)
    wrap_id = claims.wrap(session)
    card = claims.card(session)
    panels = ("page", "showcase", "video", "view")
    if (
        path is None
        and picture_id is None
        and effect_id is None
        and group is None
        and not face_ids
        and plate is None
        and wrap_id is None
        and card is None
        and shown_kind not in panels
    ):
        return _result(True, session=session, reason="nothing shown")
    opened = port
    close = False
    if opened is None and path:
        try:
            opened = TtyPort(path)
            close = True
        except OSError:
            opened = None
    confirmed = False
    try:
        if opened is not None and picture_id is not None:
            confirmed = _remove_shown(opened, picture_id, layer_id, timeout)
        if opened is not None and shown_kind in ("page", "showcase", "video", "view"):
            token = _token()
            reply, _ = exchange(opened, close_showcase(token), token, timeout)
            confirmed = confirmed or (reply is not None and reply.ok)
        if opened is not None and effect_id is not None:
            effect_ok = _remove_quiet(opened, effect_id, None, timeout)
            if picture_id is None and shown_kind not in ("page", "showcase", "video", "view"):
                confirmed = effect_ok
            else:
                confirmed = confirmed and effect_ok
        if opened is not None and group is not None:
            group_id, first, count = group
            group_ok = _remove_group_set(opened, group_id, first, count, timeout)
            if (
                picture_id is None
                and effect_id is None
                and shown_kind not in ("page", "showcase", "video", "view")
            ):
                confirmed = group_ok
            else:
                confirmed = confirmed and group_ok
        if opened is not None and face_ids:
            faces_ok = _remove_ids(opened, face_ids, timeout)
            if (
                picture_id is None
                and effect_id is None
                and group is None
                and shown_kind not in panels
            ):
                confirmed = faces_ok
            else:
                confirmed = confirmed and faces_ok
        if opened is not None and plate is not None:
            plate_ok = _remove_ids(opened, [plate[1], plate[0]], timeout)
            only_plate = (
                picture_id is None
                and effect_id is None
                and group is None
                and not face_ids
                and wrap_id is None
                and card is None
                and shown_kind not in panels
            )
            if only_plate:
                confirmed = plate_ok
            else:
                confirmed = confirmed and plate_ok
        if opened is not None and wrap_id is not None:
            wrap_ok = _remove_quiet(opened, wrap_id, None, timeout)
            only_wrap = (
                picture_id is None
                and effect_id is None
                and group is None
                and not face_ids
                and plate is None
                and card is None
                and shown_kind not in panels
            )
            if only_wrap:
                confirmed = wrap_ok
            else:
                confirmed = confirmed and wrap_ok
        if opened is not None and card is not None:
            card_ok = _remove_ids(opened, [card[1], card[0]], timeout)
            only_card = (
                picture_id is None
                and effect_id is None
                and group is None
                and not face_ids
                and plate is None
                and wrap_id is None
                and shown_kind not in panels
            )
            if only_card:
                confirmed = card_ok
            else:
                confirmed = confirmed and card_ok
    finally:
        if close and opened is not None:
            opened.close()
    claims.release(session)
    if (
        picture_id is None
        and effect_id is None
        and group is None
        and not face_ids
        and plate is None
        and wrap_id is None
        and card is None
        and shown_kind not in panels
    ):
        return _result(True, session=session, reason="nothing shown", bound=False)
    if confirmed:
        only_plate = (
            picture_id is None
            and effect_id is None
            and group is None
            and not face_ids
            and plate is not None
            and wrap_id is None
            and card is None
            and shown_kind not in panels
        )
        if only_plate:
            reason = "plate removed"
        elif (
            picture_id is None
            and effect_id is None
            and group is None
            and not face_ids
            and plate is None
            and wrap_id is not None
            and card is None
            and shown_kind not in panels
        ):
            reason = "wrap removed"
        elif (
            picture_id is None
            and effect_id is None
            and group is None
            and not face_ids
            and plate is None
            and wrap_id is None
            and card is not None
            and shown_kind not in panels
        ):
            reason = "card removed"
        else:
            reason = _clear_reason(picture_id, shown_kind, effect_id, group)
            if face_ids:
                reason = "scene and faces removed" if reason == "scene removed" else f"{reason} and faces removed"
            if plate is not None:
                if reason == "layer removed":
                    reason = "layer and plate removed"
                elif reason == "scene removed":
                    reason = "scene and plate removed"
                elif reason == "scene and layer removed":
                    reason = "scene, layer, and plate removed"
                else:
                    reason = f"{reason} and plate removed"
            if wrap_id is not None:
                if reason == "scene removed":
                    reason = "scene and wrap removed"
                else:
                    reason = f"{reason} and wrap removed"
            if card is not None:
                if reason == "layer removed":
                    reason = "layer and card removed"
                elif reason == "plate removed":
                    reason = "plate and card removed"
                else:
                    reason = f"{reason} and card removed"
        return _result(True, session=session, reason=reason, cleared=True)
    return _result(
        True,
        session=session,
        reason="local claim released; glass did not confirm the close",
        cleared=False,
    )


def _tracked(claims: Claims, session: str) -> bool:
    picture_id, layer_id = claims.shown(session)
    shown_kind = claims.kind(session)
    return any(
        (
            picture_id is not None,
            layer_id is not None,
            claims.effect(session) is not None,
            claims.group(session) is not None,
            bool(claims.faces(session)),
            claims.plate(session) is not None,
            claims.wrap(session) is not None,
            claims.card(session) is not None,
            claims.asset(session) is not None,
            shown_kind in ("page", "showcase", "video", "view", "scene"),
        )
    )


def wipe_session(
    *,
    session: str | None,
    claims: Claims,
    port=None,
    tty_path: str | None = None,
    timeout: float = 1.0,
) -> dict:
    """Send one remove;all=1. Do not send id, a span, a group, or an asset id.

    wiped and confirmed are true only after that OK. rendered stays false.
    An OK does not prove the pixels are gone. A missing remove op is not written.
    Nothing tracked is not written. A refused wipe does not release the claim.
    """

    def quiet(reason: str, **extra) -> dict:
        result = _result(False, session=session, reason=reason, artifact="remove", rendered=False, confirmed=False)
        result.update({"wiped": False, "written": False, "frame": None})
        result.update(extra)
        return result

    if not session:
        return quiet("session required. A wipe was not sent.")
    if not _tracked(claims, session):
        return quiet("nothing shown. A wipe was not sent.")
    path = tty_path or claims.path_for(session)
    opened = port
    close = False
    if opened is None:
        if not path:
            return quiet("no glass terminal for this session. A wipe was not sent.")
        try:
            opened = TtyPort(path)
            close = True
        except OSError as exc:
            return quiet(str(exc) + ". A wipe was not sent.", tty=path)
    try:
        reply, buf = probe(opened, _token(), timeout)
        if reply is None or da1_before_glass(buf):
            reason = "terminal did not answer glass hello" if reply is None else "terminal is not glass"
            return quiet(reason + ". A wipe was not sent.", tty=path)
        if not reply.ok or "remove" not in reply.ops:
            reason = (
                f"glass hello refused: {reply.code}. A wipe was not sent."
                if not reply.ok
                else "glass hello did not list remove. A wipe was not sent."
            )
            return quiet(reason, ops=list(reply.ops), version=reply.version, tty=path)
        token = _token()
        frame = remove_all(token)
        try:
            answer, _ = exchange(opened, frame, token, timeout)
        except OSError as exc:
            failed = quiet(str(exc), tty=path, ops=list(reply.ops), version=reply.version)
            failed["written"] = True
            failed["frame"] = "remove;all=1"
            return failed
    finally:
        if close and opened is not None:
            opened.close()
    ok = answer is not None and answer.ok
    if ok:
        claims.release(session)
    result = _result(
        ok,
        session=session,
        reason="all removed" if ok else (answer.code if answer is not None else "no reply"),
        artifact="remove",
        rendered=False,
        confirmed=ok,
        ops=list(reply.ops),
        version=reply.version,
    )
    result["wiped"] = ok
    result["written"] = True
    result["frame"] = "remove;all=1"
    result["code"] = answer.code if answer is not None else None
    result["tty"] = path
    return result


def show_page(
    *,
    session: str | None,
    text: str,
    claims: Claims,
    port=None,
    tty_key: str | None = None,
    tty_path: str | None = None,
    timeout: float = 0.35,
) -> dict:
    """Show text as a Glass page. Confirmed means Glass accepted the page, not that a font drew it."""
    if not session:
        return _result(False, reason="session required", text=text)
    path = tty_path or claims.path_for(session)
    key = tty_key
    if path and key is None:
        try:
            key = device_key(path)
        except OSError as exc:
            return _result(False, session=session, text=text, reason=str(exc), fallback="text")
    if port is None and not path:
        return _result(
            True,
            session=session,
            text=text,
            reason="no terminal bound. Tool output is not a display.",
            fallback="text",
        )
    if key is None:
        return _result(False, session=session, text=text, reason="terminal key required")
    try:
        claims.acquire(session, key, path or key)
    except ClaimError as exc:
        return _result(False, session=session, text=text, reason=exc.reason, fallback="text")
    opened = port
    close = False
    if opened is None:
        try:
            opened = TtyPort(path)
            close = True
        except OSError as exc:
            claims.release(session)
            return _result(False, session=session, text=text, reason=f"terminal could not be opened: {exc}", fallback="text")
    try:
        reply, buf = probe(opened, _token(), timeout)
        if da1_before_glass(buf) or reply is None or not reply.ok:
            _release_if_unused(claims, session)
            reason = "terminal is not glass" if da1_before_glass(buf) else "terminal did not answer glass hello"
            if reply is not None and not reply.ok and not da1_before_glass(buf):
                reason = f"glass hello refused: {reply.code}"
            return _result(True, session=session, text=text, reason=reason, fallback="text", ops=() if reply is None else reply.ops)
        if "page" not in reply.ops:
            _release_if_unused(claims, session)
            return _result(
                True,
                session=session,
                text=text,
                reason="glass hello did not list page",
                fallback="text",
                ops=reply.ops,
                version=reply.version,
            )
        return _place_page(session, text, claims, opened, timeout, reply)
    except ClaimError as exc:
        return _result(False, session=session, text=text, reason=exc.reason, fallback="text")
    finally:
        if close:
            opened.close()


def _image_placement(loaded, picture_id: int, ops, token: str):
    if "showcase" in ops:
        return showcase(picture_id, token), "showcase", None
    if "chart" in ops and loaded.width and loaded.height:
        tip = "".join(ch if ch.isalnum() or ch == " " else " " for ch in loaded.path.stem)
        tip = " ".join(tip.split())[:28] or "image"
        mark = f"mark;x=0;y=0;w={loaded.width};h={loaded.height};t={tip}"
        return chart_frame(picture_id, [mark], token), "chart", None
    if "layer" in ops and loaded.width and loaded.height:
        layer_id = picture_id + LAYER_OFFSET
        return (
            layer_picture(
                layer_id,
                picture_id,
                token,
                width=min(loaded.width, 960),
                height=min(loaded.height, 540),
            ),
            "layer",
            layer_id,
        )
    return None


def _chart_file(claims: Claims, session: str, chart):
    try:
        return image_mod.save_chart(claims.path, session, chart.rgb, chart.width, chart.height)
    except OSError:
        return None


def _attach_file(result: dict, artifact) -> dict:
    if artifact is None:
        return result
    result["artifact_path"] = str(artifact)
    result["artifact_role"] = "copy" if result.get("rendered") else "fallback"
    if not result.get("rendered") and result.get("fallback") in (None, "text"):
        result["fallback"] = "file"
    return result


def device_key(path: str) -> str:
    info = os.stat(path)
    if not stat.S_ISCHR(info.st_mode):
        raise OSError("not a terminal")
    return f"{info.st_dev}:{info.st_ino}"


def _has_placement(ops) -> bool:
    return "page" in ops or (
        "picture" in ops and any(op in ops for op in ("chart", "showcase", "layer"))
    )


def _page_shape(text: str) -> tuple[str, int, int]:
    if not isinstance(text, str) or not text.strip():
        raise ValueError("page text is required")
    if "\x00" in text:
        raise ValueError("page text must not contain NUL")
    lines = text.splitlines() or [text]
    if len(lines) > 256:
        raise ValueError("page is capped at 256 lines")
    if any(len(line) > 256 for line in lines):
        raise ValueError("page lines are capped at 256 columns")
    body = text if text.endswith("\n") else text + "\n"
    if len(body.encode("utf-8")) > 65536:
        raise ValueError("page is capped at 64 KiB")
    cols = max(1, max(len(line) for line in lines))
    rows = max(1, len(lines))
    return body, cols, rows


def _place_page(session, text, claims, port, timeout, reply, title=None) -> dict:
    try:
        body, cols, rows = _page_shape(text)
    except ValueError as exc:
        _release_if_unused(claims, session)
        return _result(False, session=session, title=title, text=text, reason=str(exc))
    token = _token()
    placed, _ = exchange(port, page_frame(body, cols, rows, token), token, timeout)
    if placed is None or not placed.ok:
        _release_if_unused(claims, session)
        code = "no reply" if placed is None else placed.code
        return _result(
            True,
            session=session,
            title=title,
            text=text,
            reason=f"glass did not confirm the page: {code}",
            fallback="text",
            ops=reply.ops,
        )
    previous, previous_layer = claims.note_page(session)
    if previous:
        _remove_quiet(port, previous, previous_layer, timeout)
    return _result(
        True,
        session=session,
        title=title,
        text=text,
        reason="glass accepted the page",
        rendered=True,
        confirmed=True,
        placement="page",
        ops=reply.ops,
        version=reply.version,
        fallback=None,
    )


def _show_open(session: str, chart, claims: Claims, port, timeout: float) -> dict:
    reply, buf = probe(port, _token(), timeout)
    if da1_before_glass(buf) or reply is None or not reply.ok:
        _release_if_unused(claims, session)
        reason = "terminal is not glass" if da1_before_glass(buf) else "terminal did not answer glass hello"
        if reply is not None and not reply.ok and not da1_before_glass(buf):
            reason = f"glass hello refused: {reply.code}"
        return _result(
            True,
            session=session,
            title=chart.title,
            text=chart.text,
            reason=reason,
            fallback="text",
            ops=() if reply is None else reply.ops,
        )
    if not _has_placement(reply.ops):
        _release_if_unused(claims, session)
        return _result(
            True,
            session=session,
            title=chart.title,
            text=chart.text,
            reason="glass hello did not list a placement op",
            fallback="text",
            ops=reply.ops,
            version=reply.version,
        )
    if "picture" not in reply.ops:
        return _place_page(session, chart.text, claims, port, timeout, reply, title=chart.title)
    picture_id = claims.allocate(session)
    token = _token()
    accepted, _ = exchange(
        port,
        picture(picture_id, chart.rgb, chart.width, chart.height, token),
        token,
        timeout,
    )
    if accepted is None or not accepted.ok:
        _remove_quiet(port, picture_id, None, timeout)
        _release_if_unused(claims, session)
        code = "no reply" if accepted is None else accepted.code
        return _result(
            True,
            session=session,
            title=chart.title,
            text=chart.text,
            reason=f"picture was not accepted: {code}",
            fallback="text",
            ops=reply.ops,
        )
    place_token = _token()
    layer_id = None
    if "chart" in reply.ops:
        placement = "chart"
        frame = chart_frame(picture_id, marks(chart), place_token)
    elif "showcase" in reply.ops:
        placement = "showcase"
        frame = showcase(picture_id, place_token)
    else:
        placement = "layer"
        layer_id = picture_id + LAYER_OFFSET
        frame = layer_picture(layer_id, picture_id, place_token, width=chart.width, height=chart.height)
    placed, _ = exchange(port, frame, place_token, timeout)
    if placed is None or not placed.ok:
        _remove_quiet(port, picture_id, layer_id, timeout)
        _release_if_unused(claims, session)
        return _result(
            True,
            session=session,
            title=chart.title,
            text=chart.text,
            reason="glass did not confirm the frame",
            fallback="text",
            ops=reply.ops,
        )
    previous, previous_layer = claims.note_shown(session, picture_id, layer_id)
    if previous and previous != picture_id:
        _remove_quiet(port, previous, previous_layer, timeout)
    return _result(
        True,
        session=session,
        title=chart.title,
        text=chart.text,
        reason="glass confirmed the frame",
        rendered=True,
        confirmed=True,
        placement=placement,
        picture=picture_id,
        ops=reply.ops,
        version=reply.version,
        fallback=None,
    )


def _remove_shown(port, picture_id: int, layer_id: int | None, timeout: float) -> bool:
    token = _token()
    reply, _ = exchange(port, close_showcase(token), token, timeout)
    closed = reply is not None and reply.ok
    removed = _remove_quiet(port, picture_id, layer_id, timeout)
    return closed or removed


def _faces_text(colors, mesh_name, width, height, glow) -> str:
    shown = [color for color in colors if color]
    edge = "edge" if glow else "matte"
    return f"{mesh_name} {width}x{height} {edge} faces={','.join(shown)}"


def _faces_probe_reason(reply, buf) -> str | None:
    if da1_before_glass(buf):
        return "terminal is not glass"
    if reply is None:
        return "terminal did not answer glass hello"
    if not reply.ok:
        return f"glass hello refused: {reply.code}"
    if "picture" not in reply.ops:
        return "glass hello did not list picture; not a display"
    if "scene" not in reply.ops:
        return "glass hello did not list scene; not a display"
    return None


def _face_stamp(result, *, pictures=0, faces=0, edge=False):
    result["pictures"] = pictures
    result["faces"] = faces
    result["edge"] = bool(edge)
    return result


def _remove_ids(port, ids, timeout) -> bool:
    if not ids:
        return True
    ok = True
    for program_id in ids:
        token = _token()
        try:
            reply, _ = exchange(port, remove(program_id, token), token, timeout)
        except OSError:
            return False
        ok = ok and reply is not None and reply.ok
    return ok


def _drop_wrap(port, claims, session, timeout) -> None:
    picture_id = claims.wrap(session)
    if picture_id is None:
        return
    _remove_quiet(port, picture_id, None, timeout)
    claims.clear_wrap(session)


def _drop_faces(port, claims, session, timeout) -> None:
    ids = claims.faces(session)
    if ids and _remove_ids(port, ids, timeout):
        claims.clear_faces(session)


def _remove_quiet(port, picture_id: int | None, layer_id: int | None, timeout: float) -> bool:
    ok = False
    for program_id in (layer_id, picture_id):
        if program_id is None:
            continue
        token = _token()
        try:
            reply, _ = exchange(port, remove(program_id, token), token, timeout)
        except OSError:
            return ok
        ok = ok or (reply is not None and reply.ok)
    return ok


def _remove_group_set(port, group_id: int, first: int, count: int, timeout: float) -> bool:
    token = _token()
    try:
        reply, _ = exchange(port, remove_group(group_id, token), token, timeout)
    except OSError:
        return False
    if reply is None or not reply.ok:
        return False
    token = _token()
    try:
        reply, _ = exchange(port, remove_span(first, first + count - 1, token), token, timeout)
    except OSError:
        return False
    return reply is not None and reply.ok


def _clear_reason(picture_id, shown_kind, effect_id, group) -> str:
    panels = ("page", "showcase", "video", "view")
    if group is not None and picture_id is None and effect_id is None and shown_kind not in panels:
        return "group removed"
    if effect_id is not None and picture_id is None and shown_kind not in panels:
        reason = "layer removed"
    elif effect_id is not None and shown_kind == "scene":
        reason = "scene and layer removed"
    elif shown_kind == "scene":
        reason = "scene removed"
    elif shown_kind == "video" and effect_id is not None:
        reason = "video panel closed and layer removed"
    elif shown_kind == "video":
        reason = "video panel closed"
    elif shown_kind == "view" and effect_id is not None:
        reason = "model panel closed and layer removed"
    elif shown_kind == "view":
        reason = "model panel closed"
    elif effect_id is not None:
        reason = "showcase closed and layer removed"
    else:
        reason = "showcase closed"
    if group is None:
        return reason
    if reason == "layer removed":
        return "layer and group removed"
    if reason == "scene removed":
        return "scene and group removed"
    if reason == "scene and layer removed":
        return "scene, layer, and group removed"
    return f"{reason} and group removed"


def _release_if_unused(claims: Claims, session: str) -> None:
    picture_id, _layer = claims.shown(session)
    if (
        picture_id is None
        and claims.kind(session) not in ("page", "video", "view")
        and claims.effect(session) is None
        and claims.group(session) is None
        and not claims.faces(session)
        and claims.plate(session) is None
        and claims.wrap(session) is None
        and claims.card(session) is None
        and not claims.events_armed(session)
    ):
        claims.release(session)


def _token() -> str:
    return secrets.token_hex(3)


def _result(
    ok: bool,
    *,
    session: str | None = None,
    title: str | None = None,
    text: str | None = None,
    reason: str | None = None,
    fallback: str | None = None,
    rendered: bool = False,
    confirmed: bool = False,
    placement: str | None = None,
    picture: int | None = None,
    ops: tuple[str, ...] | list[str] | None = None,
    version: int | None = None,
    bound: bool | None = None,
    cleared: bool | None = None,
    artifact: str | None = None,
) -> dict:
    return {
        "ok": ok,
        "rendered": rendered,
        "confirmed": confirmed,
        "session": session,
        "artifact": artifact if artifact is not None else ("chart" if title else None),
        "title": title,
        "reason": reason,
        "fallback": fallback,
        "text": text,
        "placement": placement,
        "picture": picture,
        "ops": list(ops or []),
        "version": version,
        "bound": bound,
        "cleared": cleared,
    }
