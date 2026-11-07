#!/usr/bin/env python3
"""Show a chart in Glass, or print the honest text fallback.

Live commands share the plugin claim file. A later show, image, or clear
can see the tty an earlier command bound. `demo` stays isolated.

    python3 cli.py demo
    python3 cli.py show --title Queue --series 'alpha=3,beta=8' --tty /dev/pts/N
"""

from __future__ import annotations

import argparse
import base64
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import board
import model as model_mod
import claims as claims_mod
import dialect
from transport import GlassScript


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Session-scoped Glass chart")
    sub = parser.add_subparsers(dest="op", required=True)

    show = sub.add_parser("show", help="Show or replace this session's chart")
    show.add_argument("--title", required=True)
    show.add_argument("--series", required=True)
    show.add_argument("--session", default="local")
    show.add_argument("--tty", default="")
    show.add_argument("--timeout", type=float, default=1.0)

    bind = sub.add_parser("bind", help="Probe a pty and bind it to this session")
    bind.add_argument("--tty", required=True)
    bind.add_argument("--session", default="local")
    bind.add_argument("--timeout", type=float, default=1.0)

    clear = sub.add_parser("clear", help="Close this session's chart")
    clear.add_argument("--session", default="local")
    clear.add_argument("--timeout", type=float, default=1.0)

    image = sub.add_parser("image", help="Show one image file in this session's Glass terminal")
    image.add_argument("--path", required=True)
    image.add_argument("--session", default="local")
    image.add_argument("--tty", default="")
    image.add_argument("--timeout", type=float, default=1.0)

    scene = sub.add_parser("scene", help="Show one mesh or a parented stage in this session's Glass terminal")
    scene.add_argument("--mesh", default="")
    scene.add_argument("--stage", default="")
    scene.add_argument("--pieces", default="")
    scene.add_argument("--color", default="")
    scene.add_argument("--finish", default="plain")
    scene.add_argument("--chrome", type=float, default=None)
    scene.add_argument("--liquid", type=float, default=None)
    scene.add_argument("--segments", type=int, default=None)
    scene.add_argument("--radius", type=float, default=None)
    scene.add_argument("--seed", type=int, default=None)
    scene.add_argument("--steps", type=int, default=None)
    scene.add_argument("--posts", type=int, default=None)
    scene.add_argument("--spin", action="store_true")
    scene.add_argument("--width", type=int, default=320)
    scene.add_argument("--height", type=int, default=240)
    scene.add_argument("--x", type=int, default=48)
    scene.add_argument("--y", type=int, default=48)
    scene.add_argument("--session", default="local")
    scene.add_argument("--tty", default="")
    scene.add_argument("--timeout", type=float, default=1.0)

    faces = sub.add_parser("faces", help="Show a cube or roundcube with uploaded face pictures and an optional glowing edge")
    faces.add_argument("--faces", default="")
    faces.add_argument("--mesh", default="roundcube")
    faces.add_argument("--edge", default="f0c040")
    faces.add_argument("--glow", type=float, default=0.85)
    faces.add_argument("--radius", type=float, default=None)
    faces.add_argument("--segments", type=int, default=None)
    faces.add_argument("--spin", action="store_true")
    faces.add_argument("--width", type=int, default=320)
    faces.add_argument("--height", type=int, default=240)
    faces.add_argument("--x", type=int, default=48)
    faces.add_argument("--y", type=int, default=48)
    faces.add_argument("--session", default="local")
    faces.add_argument("--tty", default="")
    faces.add_argument("--timeout", type=float, default=1.0)

    mark = sub.add_parser("mark", help="Show one inline triangle mark. chevron or tetra")
    mark.add_argument("--shape", default="chevron")
    mark.add_argument("--color", default="")
    mark.add_argument("--emissive", type=float, default=0.4)
    mark.add_argument("--spin", action="store_true")
    mark.add_argument("--width", type=int, default=320)
    mark.add_argument("--height", type=int, default=240)
    mark.add_argument("--x", type=int, default=48)
    mark.add_argument("--y", type=int, default=48)
    mark.add_argument("--session", default="local")
    mark.add_argument("--tty", default="")
    mark.add_argument("--timeout", type=float, default=1.0)

    view = sub.add_parser("view", help="Open the showcase on scene nodes. This is the model op, not a glTF upload")
    view.add_argument("--mesh", default="")
    view.add_argument("--stage", default="")
    view.add_argument("--pieces", default="")
    view.add_argument("--color", default="")
    view.add_argument("--finish", default="plain")
    view.add_argument("--chrome", type=float, default=None)
    view.add_argument("--liquid", type=float, default=None)
    view.add_argument("--segments", type=int, default=None)
    view.add_argument("--radius", type=float, default=None)
    view.add_argument("--seed", type=int, default=None)
    view.add_argument("--steps", type=int, default=None)
    view.add_argument("--posts", type=int, default=None)
    view.add_argument("--width", type=int, default=320)
    view.add_argument("--height", type=int, default=240)
    view.add_argument("--fit", default="contain")
    view.add_argument("--session", default="local")
    view.add_argument("--tty", default="")
    view.add_argument("--timeout", type=float, default=1.0)

    model = sub.add_parser("model", help="Upload a glTF and hang it in this session's Glass terminal")
    model.add_argument("--path", required=True)
    model.add_argument("--play", action="store_true")
    model.add_argument("--clip", default="")
    model.add_argument("--speed", type=float, default=None)
    model.add_argument("--loop", action="store_true")
    model.add_argument("--spin", action="store_true")
    model.add_argument("--color", default="")
    model.add_argument("--finish", default="plain")
    model.add_argument("--width", type=int, default=320)
    model.add_argument("--height", type=int, default=240)
    model.add_argument("--x", type=int, default=48)
    model.add_argument("--y", type=int, default=48)
    model.add_argument("--session", default="local")
    model.add_argument("--tty", default="")
    model.add_argument("--timeout", type=float, default=1.0)

    frame = sub.add_parser("frame", help="Open a video panel and push one frame")
    frame.add_argument("--width", type=int, default=320)
    frame.add_argument("--height", type=int, default=180)
    frame.add_argument("--t", type=float, default=None)
    frame.add_argument("--pause", action="store_true")
    frame.add_argument("--path", default="")
    frame.add_argument("--session", default="local")
    frame.add_argument("--tty", default="")
    frame.add_argument("--timeout", type=float, default=1.0)

    layer = sub.add_parser("layer", help="Place one overlay without removing the current picture")
    layer.add_argument("--kind", default="glow")
    layer.add_argument("--color", default="")
    layer.add_argument("--x", type=int, default=48)
    layer.add_argument("--y", type=int, default=48)
    layer.add_argument("--width", type=int, default=320)
    layer.add_argument("--height", type=int, default=180)
    layer.add_argument("--opacity", type=float, default=None)
    layer.add_argument("--z", type=int, default=None)
    layer.add_argument("--add", action="store_true")
    layer.add_argument("--matte", action="store_true")
    layer.add_argument("--count", type=int, default=None)
    layer.add_argument("--size", type=float, default=None)
    layer.add_argument("--life", type=float, default=None)
    layer.add_argument("--rise", type=float, default=None)
    layer.add_argument("--sway", type=float, default=None)
    layer.add_argument("--seed", type=int, default=None)
    layer.add_argument("--stroke", type=float, default=None)
    layer.add_argument("--glow", type=float, default=None)
    layer.add_argument("--shape", type=int, default=None)
    layer.add_argument("--speed", type=float, default=None)
    layer.add_argument("--phase", type=float, default=None)
    layer.add_argument("--session", default="local")
    layer.add_argument("--tty", default="")
    layer.add_argument("--timeout", type=float, default=1.0)

    group = sub.add_parser("group", help="Replace a set of overlays in one group op")
    group.add_argument("--pieces", default="")
    group.add_argument("--stage", default="")
    group.add_argument("--session", default="local")
    group.add_argument("--tty", default="")
    group.add_argument("--timeout", type=float, default=1.0)

    events = sub.add_parser("events", help="Arm showcase events and read the ones that arrived")
    events.add_argument("--off", action="store_true", help="Send events=0 instead of events=1")
    events.add_argument("--wait", type=float, default=0)
    events.add_argument("--session", default="local")
    events.add_argument("--tty", default="")
    events.add_argument("--timeout", type=float, default=1.0)

    play = sub.add_parser("play", help="Play, pause, or stop the scene this session is showing")
    play.add_argument("--clip", default="")
    play.add_argument("--speed", type=float, default=None)
    play.add_argument("--loop", action="store_true")
    play.add_argument("--pause", action="store_true")
    play.add_argument("--stop", action="store_true")
    play.add_argument("--node", type=int, default=None)
    play.add_argument("--at", type=float, default=None)
    play.add_argument("--session", default="local")
    play.add_argument("--tty", default="")
    play.add_argument("--timeout", type=float, default=1.0)

    tween = sub.add_parser("tween", help="Move the scene this session is already showing")
    tween.add_argument("--yaw", type=float, default=180)
    tween.add_argument("--eye", default="")
    tween.add_argument("--ease", default="spring")
    tween.add_argument("--once", action="store_true")
    tween.add_argument("--session", default="local")
    tween.add_argument("--tty", default="")
    tween.add_argument("--timeout", type=float, default=1.0)

    chain = sub.add_parser("chain", help="Move the camera through two or three named eyes, or stop one")
    chain.add_argument("--eyes", default="")
    chain.add_argument("--ease", default="sine")
    chain.add_argument("--dur", type=float, default=0.6)
    chain.add_argument("--stop", action="store_true")
    chain.add_argument("--tid", type=int, default=None)
    chain.add_argument("--session", default="local")
    chain.add_argument("--tty", default="")
    chain.add_argument("--timeout", type=float, default=1.0)

    shift = sub.add_parser("shift", help="Move a node already showing by position, scale, or color")
    shift.add_argument("--at", default="")
    shift.add_argument("--scale", default="")
    shift.add_argument("--color", default="")
    shift.add_argument("--node", type=int, default=1)
    shift.add_argument("--ease", default="sine")
    shift.add_argument("--dur", type=float, default=0.6)
    shift.add_argument("--tid", type=int, default=None)
    shift.add_argument("--session", default="local")
    shift.add_argument("--tty", default="")
    shift.add_argument("--timeout", type=float, default=1.0)

    turn = sub.add_parser("turn", help="Turn a node already showing once, not the forever spin")
    turn.add_argument("--yaw", default="")
    turn.add_argument("--rot", default="")
    turn.add_argument("--node", type=int, default=1)
    turn.add_argument("--ease", default="spring")
    turn.add_argument("--dur", type=float, default=None)
    turn.add_argument("--tid", type=int, default=None)
    turn.add_argument("--session", default="local")
    turn.add_argument("--tty", default="")
    turn.add_argument("--timeout", type=float, default=1.0)

    veil = sub.add_parser("veil", help="Change shine or visibility of a node already showing")
    veil.add_argument("--emissive", default="")
    veil.add_argument("--visible", default="")
    veil.add_argument("--node", type=int, default=1)
    veil.add_argument("--ease", default="sine")
    veil.add_argument("--dur", type=float, default=None)
    veil.add_argument("--tid", type=int, default=None)
    veil.add_argument("--session", default="local")
    veil.add_argument("--tty", default="")
    veil.add_argument("--timeout", type=float, default=1.0)

    look = sub.add_parser("look", help="Aim the camera of a scene already showing, once")
    look.add_argument("--target", default="")
    look.add_argument("--fov", type=float, default=None)
    look.add_argument("--ease", default="sine")
    look.add_argument("--dur", type=float, default=None)
    look.add_argument("--tid", type=int, default=None)
    look.add_argument("--session", default="local")
    look.add_argument("--tty", default="")
    look.add_argument("--timeout", type=float, default=1.0)

    glide = sub.add_parser("glide", help="Move an overlay already showing by px, opacity, color, or angle")
    glide.add_argument("--px", default="")
    glide.add_argument("--opacity", type=float, default=None)
    glide.add_argument("--color", default="")
    glide.add_argument("--angle", type=float, default=None)
    glide.add_argument("--layer", type=int, default=None)
    glide.add_argument("--ease", default="sine")
    glide.add_argument("--dur", type=float, default=0.6)
    glide.add_argument("--tid", type=int, default=None)
    glide.add_argument("--session", default="local")
    glide.add_argument("--tty", default="")
    glide.add_argument("--timeout", type=float, default=1.0)

    sub.add_parser("demo", help="Scripted confirm and refusal, no window")

    args = parser.parse_args(argv)
    if args.op == "demo":
        return _demo()
    store = claims_mod.Claims(claims_mod.runtime_claims_path())
    if args.op == "show":
        result = board.show(
            session=args.session,
            title=args.title,
            series=args.series,
            claims=store,
            tty_path=args.tty or None,
            timeout=args.timeout,
        )
    elif args.op == "image":
        result = board.show_image(
            session=args.session,
            path=args.path,
            claims=store,
            tty_path=args.tty or None,
            timeout=args.timeout,
        )
    elif args.op == "scene":
        result = board.show_scene(
            session=args.session,
            mesh=args.mesh or None,
            pieces=args.pieces or None,
            stage=args.stage or None,
            color=args.color or None,
            claims=store,
            tty_path=args.tty or None,
            timeout=args.timeout,
            width=args.width,
            height=args.height,
            x=args.x,
            y=args.y,
            spin=args.spin,
            chrome=args.chrome,
            liquid=args.liquid,
            segments=args.segments,
            radius=args.radius,
            seed=args.seed,
            steps=args.steps,
            posts=args.posts,
            finish=args.finish,
        )
    elif args.op == "faces":
        result = board.show_die(
            session=args.session,
            claims=store,
            faces=args.faces or None,
            mesh=args.mesh,
            edge=args.edge or None,
            glow=args.glow,
            radius=args.radius,
            segments=args.segments,
            spin=args.spin,
            tty_path=args.tty or None,
            timeout=args.timeout,
            width=args.width,
            height=args.height,
            x=args.x,
            y=args.y,
        )
    elif args.op == "mark":
        result = board.show_mark(
            session=args.session,
            claims=store,
            shape=args.shape,
            color=args.color or None,
            emissive=args.emissive,
            spin=args.spin,
            tty_path=args.tty or None,
            timeout=args.timeout,
            width=args.width,
            height=args.height,
            x=args.x,
            y=args.y,
        )
    elif args.op == "view":
        result = board.show_view(
            session=args.session,
            mesh=args.mesh or None,
            pieces=args.pieces or None,
            stage=args.stage or None,
            color=args.color or None,
            claims=store,
            tty_path=args.tty or None,
            timeout=args.timeout,
            width=args.width,
            height=args.height,
            fit=args.fit,
            chrome=args.chrome,
            liquid=args.liquid,
            segments=args.segments,
            radius=args.radius,
            seed=args.seed,
            steps=args.steps,
            posts=args.posts,
            finish=args.finish,
        )
    elif args.op == "model":
        result = board.show_model(
            session=args.session,
            path=args.path,
            claims=store,
            tty_path=args.tty or None,
            timeout=args.timeout,
            width=args.width,
            height=args.height,
            x=args.x,
            y=args.y,
            spin=args.spin,
            color=args.color or None,
            finish=args.finish,
            play=args.play,
            clip=args.clip or None,
            speed=args.speed,
            loop=True if args.loop else None,
        )
    elif args.op == "frame":
        result = board.show_frame(
            session=args.session,
            claims=store,
            tty_path=args.tty or None,
            timeout=args.timeout,
            width=args.width,
            height=args.height,
            t=args.t,
            pause=True if args.pause else None,
            path=args.path or None,
        )
    elif args.op == "layer":
        if args.add and args.matte:
            print("pass either --add or --matte, not both", file=sys.stderr)
            return 2
        additive = True if args.add else False if args.matte else None
        result = board.show_layer(
            session=args.session,
            claims=store,
            tty_path=args.tty or None,
            timeout=args.timeout,
            kind=args.kind,
            color=args.color or None,
            x=args.x,
            y=args.y,
            width=args.width,
            height=args.height,
            opacity=args.opacity,
            z=args.z,
            add=additive,
            count=args.count,
            size=args.size,
            life=args.life,
            rise=args.rise,
            sway=args.sway,
            seed=args.seed,
            stroke=args.stroke,
            glow=args.glow,
            shape=args.shape,
            speed=args.speed,
            phase=args.phase,
        )
    elif args.op == "group":
        result = board.show_group(
            session=args.session,
            claims=store,
            pieces=args.pieces or None,
            stage=args.stage or None,
            tty_path=args.tty or None,
            timeout=args.timeout,
        )
    elif args.op == "chain":
        result = board.chain_scene(
            session=args.session,
            claims=store,
            tty_path=args.tty or None,
            eyes=args.eyes,
            ease=args.ease,
            dur=args.dur,
            stop=args.stop,
            tid=args.tid,
            timeout=args.timeout,
        )
    elif args.op == "shift":
        result = board.shift_scene(
            session=args.session,
            claims=store,
            tty_path=args.tty or None,
            at=args.at,
            scale=args.scale,
            color=args.color,
            node=args.node,
            ease=args.ease,
            dur=args.dur,
            tid=args.tid,
            timeout=args.timeout,
        )
    elif args.op == "turn":
        result = board.turn_scene(
            session=args.session,
            claims=store,
            tty_path=args.tty or None,
            yaw=args.yaw or None,
            rot=args.rot or None,
            node=args.node,
            ease=args.ease,
            dur=args.dur,
            tid=args.tid,
            timeout=args.timeout,
        )
    elif args.op == "veil":
        result = board.veil_scene(
            session=args.session,
            claims=store,
            tty_path=args.tty or None,
            emissive=args.emissive or None,
            visible=args.visible or None,
            node=args.node,
            ease=args.ease,
            dur=args.dur,
            tid=args.tid,
            timeout=args.timeout,
        )
    elif args.op == "look":
        result = board.look_scene(
            session=args.session,
            claims=store,
            tty_path=args.tty or None,
            target=args.target or None,
            fov=args.fov,
            ease=args.ease,
            dur=args.dur,
            tid=args.tid,
            timeout=args.timeout,
        )
    elif args.op == "glide":
        result = board.glide_layer(
            session=args.session,
            claims=store,
            tty_path=args.tty or None,
            px=args.px,
            opacity=args.opacity,
            color=args.color,
            angle=args.angle,
            layer=args.layer,
            ease=args.ease,
            dur=args.dur,
            tid=args.tid,
            timeout=args.timeout,
        )
    elif args.op == "events":
        result = board.watch_events(
            session=args.session,
            claims=store,
            tty_path=args.tty or None,
            timeout=args.timeout,
            arm=not args.off,
            wait=args.wait,
        )
    elif args.op == "play":
        result = board.play_scene(
            session=args.session,
            claims=store,
            tty_path=args.tty or None,
            timeout=args.timeout,
            clip=args.clip or None,
            speed=args.speed,
            loop=True if args.loop else None,
            pause=True if args.pause else None,
            stop=args.stop,
            node=args.node,
            at=args.at,
        )
    elif args.op == "tween":
        result = board.tween_scene(
            session=args.session,
            claims=store,
            tty_path=args.tty or None,
            timeout=args.timeout,
            yaw=args.yaw,
            eye=args.eye or None,
            ease=args.ease,
            forever=not args.once,
        )
    elif args.op == "bind":
        result = board.bind_session(
            session=args.session,
            tty_path=args.tty,
            claims=store,
            timeout=args.timeout,
        )
    else:
        result = board.clear(session=args.session, claims=store, timeout=args.timeout)
    json.dump(result, sys.stdout, ensure_ascii=False)
    sys.stdout.write("\n")
    return 0 if result.get("ok") else 1


def _demo() -> int:
    with tempfile.TemporaryDirectory() as tmp:
        store = claims_mod.Claims(Path(tmp) / "claims.json")
        glass = GlassScript(ops="hello,picture,chart,layer,group,remove,showcase,page")
        shown = board.show(
            session="demo",
            title="Queue",
            series="alpha=3,beta=8",
            claims=store,
            tty_key="script:1",
            port=glass,
        )
        other = GlassScript()
        refused = board.show(
            session="other",
            title="Queue",
            series="alpha=1",
            claims=store,
            tty_key="script:1",
            port=other,
        )
        plain = GlassScript(mode="da1")
        store.release("demo")
        fallback = board.show(
            session="demo",
            title="Queue",
            series="alpha=3,beta=8",
            claims=store,
            tty_key="script:2",
            port=plain,
        )
    print("confirmed", json.dumps({k: shown[k] for k in ("ok", "rendered", "confirmed", "placement")}))
    print("other-session", json.dumps({k: refused[k] for k in ("ok", "rendered", "reason")}))
    print("not-glass", json.dumps({k: fallback[k] for k in ("ok", "rendered", "reason", "fallback")}))
    print(fallback["text"])
    if not (shown["rendered"] and shown["confirmed"] and shown["placement"] == "chart" and not refused["ok"] and not fallback["rendered"]):
        return 1
    if other.writes:
        print("other session wrote to the terminal", file=sys.stderr)
        return 1
    scene_port = GlassScript(ops="hello,scene,tween,remove,showcase")
    scene = board.show_scene(
        session="scene-demo",
        mesh="gem",
        claims=store,
        tty_key="script:3",
        port=scene_port,
        spin=True,
    )
    print("scene", json.dumps({k: scene[k] for k in ("ok", "rendered", "confirmed", "moved", "placement", "mesh")}))
    if not (scene["rendered"] and scene["confirmed"] and scene["moved"] and scene["placement"] == "scene"):
        return 1
    joined = b"".join(scene_port.writes)
    if b"scene;" not in joined or b"yoyo=1" not in joined or b"repeat=ping" in joined:
        print("scene frame was not the published tween", file=sys.stderr)
        return 1
    mercury_port = GlassScript(ops="hello,scene,tween,remove,showcase")
    mercury = board.show_scene(
        session="mercury-demo",
        mesh="sphere",
        claims=store,
        tty_key="script:4",
        port=mercury_port,
        finish="mercury",
        spin=True,
    )
    print(
        "mercury",
        json.dumps({k: mercury[k] for k in ("ok", "rendered", "confirmed", "moved", "placement", "mesh")}),
    )
    mercury_bytes = b"".join(mercury_port.writes)
    if not (mercury["rendered"] and mercury["confirmed"] and mercury["moved"]):
        return 1
    try:
        mercury_body = dialect.scene_body(mercury_bytes)
    except ValueError:
        print("mercury frame was not a scene", file=sys.stderr)
        return 1
    if b'"kind":"sphere"' not in mercury_body or b'"mesh":"sphere"' in mercury_body:
        print("mercury frame used a string mesh", file=sys.stderr)
        return 1
    if b'"chrome":1.0' not in mercury_body or b'"liquid":0.6' not in mercury_body:
        print("mercury frame omitted the material", file=sys.stderr)
        return 1
    stage_port = GlassScript(ops="hello,scene,tween,remove,showcase")
    stage = board.show_scene(
        session="stage-demo",
        stage="court",
        claims=store,
        tty_key="script:5",
        port=stage_port,
        finish="mercury",
        spin=True,
    )
    print(
        "stage",
        json.dumps({k: stage[k] for k in ("ok", "rendered", "confirmed", "moved", "placement", "mesh", "nodes", "stage")}),
    )
    if not (stage["rendered"] and stage["confirmed"] and stage["moved"] and stage.get("nodes") == 3):
        return 1
    try:
        stage_body = json.loads(dialect.scene_body(b"".join(stage_port.writes)))
    except ValueError:
        print("stage frame was not a scene", file=sys.stderr)
        return 1
    nodes = stage_body["scene"]["nodes"]
    if len(nodes) != 3 or "parent" in nodes[0] or nodes[1].get("parent") != 1:
        print("stage was not parented to the first piece", file=sys.stderr)
        return 1
    if nodes[2]["mesh"].get("kind") != "sphere" or "chrome" in nodes[0]:
        print("stage dressed the ground or used a string sphere", file=sys.stderr)
        return 1
    model_port = GlassScript(ops="hello,asset,scene,tween,play,remove,showcase")
    model_port.asset_extra = "nodes=1,meshes=1,clips=1,seconds=2"
    model_path = Path(tmp) / "triangle.glb"
    model_path.write_bytes(model_mod.triangle_glb(animated=True))
    shown_model = board.show_model(
        session="model-demo",
        path=str(model_path),
        claims=store,
        tty_key="script:6",
        port=model_port,
        play=True,
        clip="0",
        spin=True,
    )
    print(
        "model",
        json.dumps(
            {
                k: shown_model[k]
                for k in ("ok", "uploaded", "rendered", "confirmed", "played", "moved", "placement", "clips")
            }
        ),
    )
    if not (
        shown_model["uploaded"]
        and shown_model["rendered"]
        and shown_model["confirmed"]
        and shown_model["played"]
        and shown_model["moved"]
        and shown_model.get("clips") == 1
    ):
        return 1
    joined_model = b"".join(model_port.writes)
    if b"asset;" not in joined_model or b"t=d;" not in joined_model or b"play;" not in joined_model:
        print("model frame was not an asset plus play", file=sys.stderr)
        return 1
    try:
        model_body = json.loads(dialect.scene_body(joined_model))
    except ValueError:
        print("model frame was not a scene", file=sys.stderr)
        return 1
    mesh = model_body["scene"]["nodes"][0]["mesh"]
    if not isinstance(mesh, dict) or mesh.get("kind") != "gltf" or mesh.get("asset", 0) >= 0x16000000:
        print("model frame was not a kind gltf under 0x16000000", file=sys.stderr)
        return 1

    frame_port = GlassScript(ops="hello,showcase,frame,progress,remove")
    shown_frame = board.show_frame(
        session="frame-demo",
        claims=store,
        port=frame_port,
        tty_key="script",
        width=8,
        height=4,
        t=0.5,
    )
    print(
        json.dumps(
            {
                "op": "frame",
                **{
                    k: shown_frame[k]
                    for k in ("ok", "rendered", "confirmed", "opened", "seeked", "placement", "pixels", "reason")
                },
            }
        )
    )
    if not (
        shown_frame["opened"]
        and shown_frame["rendered"]
        and shown_frame["confirmed"]
        and shown_frame["seeked"]
        and shown_frame["placement"] == "video"
    ):
        return 1
    joined_frame = b"".join(frame_port.writes)
    showcase_body = joined_frame.split(b"showcase;", 1)[1].split(b"\x1b", 1)[0]
    if b"s=8;v=4;" not in showcase_body or b"id=" in showcase_body:
        print("video showcase was not a sized panel", file=sys.stderr)
        return 1
    if b"frame;f=32;s=8;v=4;" not in joined_frame or b"progress;t=0.5;" not in joined_frame:
        print("frame was not a sized video frame plus progress", file=sys.stderr)
        return 1
    payload = joined_frame.split(b"frame;f=32;s=8;v=4;r=", 1)[1].split(b";", 1)[1].split(b"\x1b", 1)[0]
    rgba = base64.b64decode(payload)
    if len(rgba) != 8 * 4 * 4 or rgba[4 * 4:4 * 4 + 4] != b"\xff\xff\xff\xff":
        print("frame pixels were not the 0.5 stripe", file=sys.stderr)
        return 1
    refused = GlassScript(mode="reject-place", ops="hello,showcase,frame,progress")
    missed = board.show_frame(session="frame-miss", claims=store, port=refused, tty_key="script", width=8, height=4)
    if missed["rendered"] or missed["opened"] or any(b"frame;" in item for item in refused.writes):
        print("a refused panel still sent a frame", file=sys.stderr)
        return 1

    layer_port = GlassScript(ops="hello,layer,remove,scene,showcase")
    shown_layer = board.show_layer(
        session="layer-demo",
        claims=store,
        port=layer_port,
        tty_key="script:layer",
        kind="glow",
    )
    print(
        json.dumps(
            {
                "op": "layer",
                **{
                    k: shown_layer[k]
                    for k in ("ok", "rendered", "confirmed", "placement", "kind", "program_id", "reason")
                },
            }
        )
    )
    if not (
        shown_layer["rendered"]
        and shown_layer["confirmed"]
        and shown_layer["placement"] == "layer"
        and shown_layer["kind"] == "glow"
        and shown_layer["program_id"] == 32
    ):
        return 1
    joined_layer = b"".join(layer_port.writes)
    if b"layer;id=32;k=glow;px=48,48,320,180;c=8844cc;add=1;" not in joined_layer:
        print("layer frame was not a window glow", file=sys.stderr)
        return 1
    if b"at=" in joined_layer or b";x=" in joined_layer or b"k=picture" in joined_layer:
        print("layer frame used a text anchor or a picture kind", file=sys.stderr)
        return 1
    refused_layer = GlassScript(mode="reject-place", ops="hello,layer,remove")
    missed_layer = board.show_layer(session="layer-miss", claims=store, port=refused_layer, tty_key="script:layer-miss")
    if missed_layer["rendered"] or missed_layer["confirmed"] or store.effect("layer-miss") is not None:
        print("a refused layer was claimed", file=sys.stderr)
        return 1

    view_port = GlassScript(ops="hello,model,showcase,remove,scene")
    shown_view = board.show_view(
        session="view-demo",
        mesh="gem",
        claims=store,
        port=view_port,
        tty_key="script:view",
        width=160,
        height=120,
        fit="contain",
    )
    print(
        "view",
        json.dumps(
            {
                "op": "model",
                **{k: shown_view[k] for k in ("ok", "rendered", "confirmed", "opened", "placement", "mesh", "nodes", "fit")},
            }
        ),
    )
    if not (
        shown_view["opened"]
        and shown_view["rendered"]
        and shown_view["confirmed"]
        and shown_view["placement"] == "view"
        and shown_view["nodes"] == 1
    ):
        return 1
    joined_view = b"".join(view_port.writes)
    head = joined_view.split(b"model;", 1)[1].split(b";r=", 1)[0]
    if not head.startswith(b"s=160;v=120;fit=contain") or b"id=" in head or b"px=" in head:
        print("model panel was not a sized showcase", file=sys.stderr)
        return 1
    body = dialect.view_body(joined_view)
    if b'"mesh":"gem"' not in body or b'"id":1' not in body:
        print("model panel payload was not the gem envelope", file=sys.stderr)
        return 1
    court_port = GlassScript(ops="hello,model,showcase,remove")
    court = board.show_view(session="view-court", stage="court", finish="mercury", claims=store, port=court_port, tty_key="script:view-court")
    court_body = dialect.view_body(b"".join(court_port.writes))
    ground = court_body.split(b'"id":1', 1)[1].split(b'"id":2', 1)[0]
    if (
        not court["confirmed"]
        or court["nodes"] != 3
        or court_body.count(b'"parent":1') != 2
        or b'"chrome":1' not in court_body
        or b'"chrome"' in ground
    ):
        print("model panel court was not a parented mercury stage", file=sys.stderr)
        return 1
    missing = GlassScript(ops="hello,scene,showcase")
    missed = board.show_view(session="view-miss", claims=store, port=missing, tty_key="script:view-miss")
    if missed["opened"] or missed["rendered"] or any(b"model;" in item for item in missing.writes):
        print("a missing model op was written", file=sys.stderr)
        return 1
    refused = GlassScript(mode="reject-model", ops="hello,model,showcase")
    blocked = board.show_view(session="view-block", claims=store, port=refused, tty_key="script:view-block")
    if blocked["rendered"] or blocked["confirmed"] or store.kind("view-block") == "view":
        print("a refused model panel was claimed", file=sys.stderr)
        return 1
    closed = board.clear(session="view-demo", claims=store, port=view_port)
    if not closed["cleared"] or closed["reason"] != "model panel closed":
        print("clear did not close the model panel", closed, file=sys.stderr)
        return 1

    group_port = GlassScript(ops="hello,group,layer,remove")
    shown_group = board.show_group(
        session="group-demo",
        claims=store,
        stage="hud",
        port=group_port,
        tty_key="script:group",
    )
    print(
        "group",
        json.dumps(
            {k: shown_group[k] for k in ("ok", "rendered", "confirmed", "placement", "count", "stage", "group_id")}
        ),
    )
    if not (
        shown_group["rendered"]
        and shown_group["confirmed"]
        and shown_group["placement"] == "group"
        and shown_group["count"] == 3
        and shown_group["stage"] == "hud"
        and shown_group["group_id"] == 1
    ):
        return 1
    joined_group = b"".join(group_port.writes)
    if b"group;g=1;n=3;" not in joined_group:
        print("group frame was not one group op", file=sys.stderr)
        return 1
    encoded = joined_group.split(b"group;g=1;n=3;r=", 1)[1].split(b";", 1)[1].split(b"\x1b", 1)[0]
    payload = base64.b64decode(encoded).decode("ascii")
    lines = payload.split("\n")
    if (
        len(lines) != 3
        or not lines[0].startswith("layer;id=40;k=glow;px=")
        or "r=" in payload
        or "at=" in payload
        or "k=picture" in payload
    ):
        print("group payload was not three px layer records", file=sys.stderr)
        return 1
    replaced = board.show_group(
        session="group-demo",
        claims=store,
        pieces="glow@48,48,120,40#ff8800",
        port=group_port,
        tty_key="script:group",
    )
    if not replaced["rendered"] or replaced["count"] != 1 or store.group("group-demo") != (1, 40, 1):
        print("a second group did not replace the set", replaced, file=sys.stderr)
        return 1
    closed_group = board.clear(session="group-demo", claims=store, port=group_port)
    if not closed_group["cleared"] or closed_group["reason"] != "group removed":
        print("clear did not remove the group", closed_group, file=sys.stderr)
        return 1

    face_port = GlassScript(ops="hello,picture,scene,tween,remove,showcase")
    shown_faces = board.show_die(
        session="faces-demo",
        claims=store,
        faces="ff3355;33cc66;3388ff;ffcc33;cc66ff;f2f2f2",
        port=face_port,
        tty_key="script:faces",
    )
    if not shown_faces["rendered"] or shown_faces["faces"] != 6 or not shown_faces["edge"]:
        print("demo faces were not accepted", shown_faces, file=sys.stderr)
        return 1
    face_scene = next(item for item in face_port.writes if b"scene;" in item)
    face_node = json.loads(dialect.scene_body(face_scene))["scene"]["nodes"][0]
    if face_node["mesh"].get("kind") != "roundcube" or '"mesh":"roundcube"' in face_scene.decode("ascii"):
        print("demo faces sent a string roundcube", file=sys.stderr)
        return 1
    closed_faces = board.clear(session="faces-demo", claims=store, port=face_port)
    if not closed_faces["cleared"] or "faces removed" not in closed_faces["reason"]:
        print("clear did not remove the face pictures", closed_faces, file=sys.stderr)
        return 1

    mark_port = GlassScript(mode="ok", ops="hello,scene,tween,remove,showcase")
    shown_mark = board.show_mark(
        session="mark-demo",
        claims=store,
        shape="chevron",
        spin=True,
        port=mark_port,
        tty_key="script:mark",
    )
    if not shown_mark["rendered"] or not shown_mark["inline"] or shown_mark["triangles"] != 4:
        print("demo mark was not accepted", shown_mark, file=sys.stderr)
        return 1
    mark_scene = next(item for item in mark_port.writes if b"scene;" in item)
    mark_node = json.loads(dialect.scene_body(mark_scene))["scene"]["nodes"][0]
    if mark_node["mesh"].get("kind") != "inline" or b'"mesh":"inline"' in mark_scene:
        print("demo mark sent a string inline", file=sys.stderr)
        return 1
    if "colors" not in mark_node["mesh"]:
        print("demo chevron omitted vertex colors", file=sys.stderr)
        return 1
    closed_mark = board.clear(session="mark-demo", claims=store, port=mark_port)
    if not closed_mark["cleared"]:
        print("clear did not remove the mark", closed_mark, file=sys.stderr)
        return 1

    shift_port = GlassScript(ops="hello,scene,tween,remove,showcase")
    shown_shift = board.show_scene(
        session="shift-demo",
        mesh="cube",
        claims=store,
        tty_key="script:shift",
        port=shift_port,
        spin=False,
    )
    if not shown_shift["confirmed"]:
        print("demo shift scene was not accepted", shown_shift, file=sys.stderr)
        return 1
    shifted = board.shift_scene(
        session="shift-demo",
        claims=store,
        port=shift_port,
        tty_key="script:shift",
        at="0.4,0.2,0",
        scale="1.6,1.6,1.6",
        color="0.2,0.45,0.9,1",
    )
    if not shifted["shifted"] or not shifted["moved"] or not shifted["confirmed"]:
        print("demo shift was not accepted", shifted, file=sys.stderr)
        return 1
    shift_frame = next(item for item in shift_port.writes if b";at=" in item)
    shift_text = shift_frame.decode("ascii")
    if "rot=" in shift_text or "yoyo" in shift_text or "repeat=" in shift_text or "camera=" in shift_text:
        print("demo shift changed the spin frame", file=sys.stderr)
        return 1
    if "scale=1.6,1.6,1.6" not in shift_text or "color=0.2,0.45,0.9,1" not in shift_text:
        print("demo shift omitted a channel", file=sys.stderr)
        return 1

    turn_port = GlassScript(ops="hello,scene,tween,remove,showcase")
    shown_turn = board.show_scene(
        session="turn-demo",
        mesh="cube",
        claims=store,
        tty_key="script:turn",
        port=turn_port,
        spin=False,
    )
    if not shown_turn["confirmed"]:
        print("demo turn scene was not accepted", shown_turn, file=sys.stderr)
        return 1
    turned = board.turn_scene(
        session="turn-demo",
        claims=store,
        port=turn_port,
        tty_key="script:turn",
        yaw=90,
    )
    if not turned["turned"] or not turned["moved"] or not turned["confirmed"]:
        print("demo turn was not accepted", turned, file=sys.stderr)
        return 1
    if turned["rendered"]:
        print("demo turn claimed a render", file=sys.stderr)
        return 1
    turn_frame = next(item for item in turn_port.writes if b"rot=0,0.7071,0,0.7071" in item)
    turn_text = turn_frame.decode("ascii")
    if "yoyo" in turn_text or "repeat=" in turn_text or ";at=" in turn_text or "camera=" in turn_text or "dur=" in turn_text:
        print("demo turn was not a once-only quarter turn", turn_text, file=sys.stderr)
        return 1
    if "ease=spring(170,12)" not in turn_text:
        print("demo turn omitted the spring", turn_text, file=sys.stderr)
        return 1
    spin_frame = dialect.tween_node(1, "abc", dialect.yaw_rot(180))
    if b"repeat=forever;yoyo=1" not in spin_frame or b"rot=0,1.0000,0,0.0000" not in spin_frame:
        print("demo turn changed the spin frame", file=sys.stderr)
        return 1

    glide_port = GlassScript(ops="hello,layer,tween,remove")
    shown_layer = board.show_layer(
        session="glide-demo",
        claims=store,
        port=glide_port,
        tty_key="script:glide",
        kind="glow",
    )
    if not shown_layer["confirmed"]:
        print("demo glide layer was not accepted", shown_layer, file=sys.stderr)
        return 1
    glided = board.glide_layer(
        session="glide-demo",
        claims=store,
        port=glide_port,
        tty_key="script:glide",
        px="80,40,280,160",
        opacity=0.35,
        color="ffcc44",
        angle=0.4,
    )
    if not glided["glided"] or not glided["moved"] or not glided["confirmed"]:
        print("demo glide was not accepted", glided, file=sys.stderr)
        return 1
    glide_frame = next(item for item in glide_port.writes if b"tween;layer=" in item)
    glide_text = glide_frame.decode("ascii")
    if "at=" in glide_text or "node=" in glide_text or ";id=" in glide_text or "yoyo" in glide_text or "repeat=" in glide_text:
        print("demo glide sent a node key", file=sys.stderr)
        return 1
    if "px=80,40,280,160" not in glide_text or "o=0.35" not in glide_text or "c=ffcc44" not in glide_text or "a=0.4" not in glide_text:
        print("demo glide omitted a channel", glide_text, file=sys.stderr)
        return 1

    veil_port = GlassScript(ops="hello,scene,tween,remove,showcase")
    shown_veil = board.show_scene(
        session="veil-demo",
        mesh="cube",
        claims=store,
        tty_key="script:veil",
        port=veil_port,
        spin=False,
    )
    if not shown_veil["confirmed"]:
        print("demo veil scene was not accepted", shown_veil, file=sys.stderr)
        return 1
    veiled = board.veil_scene(
        session="veil-demo",
        claims=store,
        tty_key="script:veil",
        port=veil_port,
        emissive=1,
        visible=0,
        ease="sine",
        dur=0.4,
    )
    if not veiled["veiled"] or not veiled["confirmed"] or veiled["rendered"]:
        print("demo veil was not accepted", veiled, file=sys.stderr)
        return 1
    if veiled["channels"] != ["emissive", "visible"]:
        print("demo veil channels", veiled, file=sys.stderr)
        return 1
    veil_text = b"".join(veil_port.writes).decode()
    if "emissive=1;visible=0;ease=sine-in-out;dur=0.4" not in veil_text:
        print("demo veil frame", veil_text, file=sys.stderr)
        return 1
    veil_frame = veil_text.split("emissive=1", 1)[-1]
    for banned in ("rot=", "at=", "scale=", "color=", "camera=", "yoyo", "repeat="):
        if banned in veil_frame:
            print("demo veil sent a motion key", banned, file=sys.stderr)
            return 1
    cube = json.loads(dialect.scene_payload("cube", dialect.parse_color(None)))
    node = cube["scene"]["nodes"][0]
    if "emissive" in node or node["mesh"] != "cube":
        print("demo veil changed the cube envelope", cube, file=sys.stderr)
        return 1

    look_port = GlassScript(ops="hello,scene,tween,remove,showcase")
    shown_look = board.show_scene(
        session="look-demo",
        mesh="cube",
        claims=store,
        tty_key="script:look",
        port=look_port,
        spin=False,
    )
    if not shown_look["confirmed"]:
        print("demo look scene was not accepted", shown_look, file=sys.stderr)
        return 1
    looked = board.look_scene(
        session="look-demo",
        claims=store,
        tty_key="script:look",
        port=look_port,
        target="0,1,0",
        fov=0.5,
        ease="sine",
        dur=0.6,
    )
    if not looked["looked"] or not looked["confirmed"] or looked["rendered"]:
        print("demo look was not accepted", looked, file=sys.stderr)
        return 1
    if looked["channels"] != ["target", "fov"]:
        print("demo look channels", looked, file=sys.stderr)
        return 1
    look_text = b"".join(look_port.writes).decode()
    if "camera=1;target=0,1,0;fov=0.5;ease=sine-in-out;dur=0.6" not in look_text:
        print("demo look frame", look_text, file=sys.stderr)
        return 1
    look_frame = look_text.split("camera=1;target=0,1,0", 1)[-1]
    for banned in ("eye=", "node=", "rot=", "at=", "yoyo", "repeat="):
        if banned in look_frame:
            print("demo look sent a motion key", banned, file=sys.stderr)
            return 1
    rock = dialect.tween_camera(7, "bbb", "1.8,1.2,2.4", repeat="forever", yoyo=True)
    if b"eye=" not in rock or b"target=" in rock or b"fov=" in rock:
        print("demo look changed the camera rock", rock, file=sys.stderr)
        return 1

    with tempfile.TemporaryDirectory() as flat_tmp:
        flat_port = GlassScript(ops="hello,scene,tween,remove")
        flat = board.show_flat(
            session="demo",
            mesh="cube",
            ortho=2.4,
            claims=claims_mod.Claims(Path(flat_tmp) / "flat-claims.json"),
            port=flat_port,
            tty_key="script:flat",
            spin=False,
        )
        if not flat["flat"] or not flat["confirmed"] or flat["perspective"] is not False:
            print("demo flat was not accepted", flat, file=sys.stderr)
            return 1
        if flat["ortho"] != 2.4 or flat["channels"] != ["ortho"] or flat["moved"]:
            print("demo flat channels", flat, file=sys.stderr)
            return 1
        scene = next(item for item in flat_port.writes if b"scene;" in item)
        camera = json.loads(dialect.scene_body(scene))["scene"]["camera"]
        if camera.get("ortho") != 2.4 or "fov" in camera or b"px=" not in scene:
            print("demo flat frame", camera, file=sys.stderr)
            return 1
    cube = dialect.scene_payload("cube", (1.0, 0.4, 0.2, 1.0))
    if b'"ortho"' in cube or b'"fov":0.9' not in cube:
        print("demo flat changed the orange cube", file=sys.stderr)
        return 1

    plain = dialect.scene(1, b"{}", "a", width=8, height=8, x=0, y=0)
    if b";o=" in plain or b";z=" in plain:
        print("demo mist changed the plain scene frame", file=sys.stderr)
        return 1

    with tempfile.TemporaryDirectory() as mist_tmp:
        mist_port = GlassScript(ops="hello,scene,tween,remove")
        mist = board.show_mist(
            session="demo",
            mesh="cube",
            opacity=0.35,
            claims=claims_mod.Claims(Path(mist_tmp) / "mist-claims.json"),
            port=mist_port,
            tty_key="script:mist",
            spin=False,
        )
        if not mist["misted"] or not mist["confirmed"] or not mist["faded"] or mist["depth"]:
            print("demo mist was not accepted", mist, file=sys.stderr)
            return 1
        if mist["opacity"] != 0.35 or mist["channels"] != ["o"] or mist["moved"] or not mist["perspective"]:
            print("demo mist channels", mist, file=sys.stderr)
            return 1
        scene = next(item for item in mist_port.writes if b"scene;" in item)
        if b";o=0.35;" not in scene or b";z=" in scene or b"at=" in scene:
            print("demo mist frame", scene, file=sys.stderr)
            return 1
        camera = json.loads(dialect.scene_body(scene))["scene"]["camera"]
        if camera.get("fov") != 0.9 or "ortho" in camera:
            print("demo mist camera", camera, file=sys.stderr)
            return 1

    plain_dock = dialect.scene(1, b"{}", "a", width=8, height=8, x=0, y=0)
    if b"px=" not in plain_dock or b"at=" in plain_dock or b"anchor=" in plain_dock:
        print("demo dock changed the plain scene frame", file=sys.stderr)
        return 1

    with tempfile.TemporaryDirectory() as dock_tmp:
        dock_port = GlassScript(ops="hello,scene,tween,remove")
        docked = board.show_dock(
            session="demo",
            mesh="cube",
            at="2,1,24,12",
            width=160,
            height=120,
            claims=claims_mod.Claims(Path(dock_tmp) / "dock-claims.json"),
            port=dock_port,
            tty_key="script:dock",
            spin=False,
        )
        if not docked["docked"] or not docked["confirmed"] or not docked["pinned"] or docked["moved"]:
            print("demo dock was not accepted", docked, file=sys.stderr)
            return 1
        if docked["cells"] != [2.0, 1.0, 24.0, 12.0] or docked["channels"] != ["at", "anchor"]:
            print("demo dock channels", docked, file=sys.stderr)
            return 1
        if not docked["perspective"]:
            print("demo dock perspective", docked, file=sys.stderr)
            return 1
        scene = next(item for item in dock_port.writes if b"scene;" in item)
        if b"at=2,1,24,12;anchor=window;" not in scene or b"px=" in scene or b";o=" in scene or b";z=" in scene:
            print("demo dock frame", scene, file=sys.stderr)
            return 1
        camera = json.loads(dialect.scene_body(scene))["scene"]["camera"]
        if camera.get("fov") != 0.9 or "ortho" in camera:
            print("demo dock camera", camera, file=sys.stderr)
            return 1
        with tempfile.TemporaryDirectory() as ride_tmp:
            ride_port = GlassScript(ops="hello,scene,tween,remove")
            rode = board.show_ride(
                session="demo-ride",
                at="2,1,24,12",
                width=160,
                height=120,
                claims=claims_mod.Claims(Path(ride_tmp) / "ride-claims.json"),
                port=ride_port,
                tty_key="script:ride",
            )
            if not rode["rode"] or not rode["confirmed"] or not rode["omitted"] or rode["labeled"] or rode["pinned"]:
                print("demo ride was not accepted", rode, file=sys.stderr)
                return 1
            if rode["cells"] != [2.0, 1.0, 24.0, 12.0] or rode["channels"] != ["at"]:
                print("demo ride channels", rode, file=sys.stderr)
                return 1
            omit_scene = next(item for item in ride_port.writes if b"scene;" in item)
            if b"at=2,1,24,12;" not in omit_scene or b"anchor=" in omit_scene.split(b";r=")[0] or b"px=" in omit_scene.split(b";r=")[0]:
                print("demo ride frame", omit_scene, file=sys.stderr)
                return 1
        with tempfile.TemporaryDirectory() as text_tmp:
            text_port = GlassScript(ops="hello,scene,tween,remove")
            labeled = board.show_ride(
                session="demo-ride-text",
                at="1.5,2.25,18,10",
                anchor="text",
                mesh="gem",
                width=96,
                height=72,
                claims=claims_mod.Claims(Path(text_tmp) / "ride-text-claims.json"),
                port=text_port,
                tty_key="script:ridetext",
            )
            if not labeled["rode"] or not labeled["labeled"] or labeled["omitted"] or labeled["pinned"]:
                print("demo ride label", labeled, file=sys.stderr)
                return 1
            text_scene = next(item for item in text_port.writes if b"scene;" in item)
            if b"anchor=window" in text_scene or b"at=1.5,2.25,18,10;anchor=text;" not in text_scene:
                print("demo ride text frame", text_scene, file=sys.stderr)
                return 1
        plain_lens = json.loads(dialect.scene_payload("cube", (1, 0.4, 0.2, 1)))
        if "clear" in plain_lens["scene"]["camera"] or plain_lens["scene"]["camera"].get("fov") != 0.9:
            print("demo lens changed the orange cube", plain_lens, file=sys.stderr)
            return 1
        with tempfile.TemporaryDirectory() as lens_tmp:
            lens_port = GlassScript(ops="hello,scene,tween,remove")
            lensed = board.show_lens(
                session="demo-lens",
                clear="0.05,0.08,0.16,1",
                width=160,
                height=120,
                x=48,
                y=36,
                claims=claims_mod.Claims(Path(lens_tmp) / "lens-claims.json"),
                port=lens_port,
                tty_key="script:lens",
            )
            if not lensed["lensed"] or not lensed["confirmed"] or not lensed["backed"] or lensed["clipped"] or lensed["moved"]:
                print("demo lens was not accepted", lensed, file=sys.stderr)
                return 1
            if lensed["channels"] != ["clear"] or lensed["clear"] != [0.05, 0.08, 0.16, 1.0]:
                print("demo lens channels", lensed, file=sys.stderr)
                return 1
            scene = next(item for item in lens_port.writes if b"scene;" in item)
            head = scene.split(b";r=")[0]
            if b"px=48,36,160,120" not in head or b"at=" in head or b";o=" in head or b";z=" in head:
                print("demo lens frame", scene, file=sys.stderr)
                return 1
            camera = json.loads(dialect.scene_body(scene))["scene"]["camera"]
            if camera.get("clear") != [0.05, 0.08, 0.16, 1.0] or camera.get("fov") != 0.9 or "ortho" in camera or "near" in camera:
                print("demo lens camera", camera, file=sys.stderr)
                return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
