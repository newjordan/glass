"""Dialect bytes, session claims, and the show/refuse paths."""

from __future__ import annotations

import base64
import json
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

import board
import model
import chart
import claims as claims_mod
import dialect
import transport
from transport import GlassScript


class Dialect(unittest.TestCase):
    def test_hello_matches_the_published_framing(self):
        self.assertEqual(dialect.hello("1"), b"\x1b_glass;hello;r=1\x1b\\")

    def test_picture_payload_is_the_raw_rgb(self):
        raw = bytes([0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00])
        frame = dialect.picture(1, raw, 2, 1, "9")
        self.assertTrue(frame.startswith(b"\x1b_glass;picture;id=1;f=24;s=2;v=1;r=9;"))
        payload = frame.split(b"r=9;", 1)[1].removesuffix(b"\x1b\\")
        self.assertEqual(base64.b64decode(payload), raw)
        self.assertEqual(base64.b64encode(raw), b"/wAAAP8A")

    def test_da1_before_hello_is_not_glass(self):
        self.assertTrue(dialect.da1_before_glass(b"\x1b[?6c"))
        hello = dialect.hello("1") + b"\x1b[?6c"
        self.assertFalse(dialect.da1_before_glass(hello))

    def test_ok_reply_lists_ops(self):
        raw = b"\x1b_glass;r=1;OK;v=3,ops=hello,picture,showcase\x1b\\"
        reply = dialect.find_reply(raw, "1")
        self.assertIsNotNone(reply)
        assert reply is not None
        self.assertTrue(reply.ok)
        self.assertEqual(reply.version, 3)
        self.assertIn("showcase", reply.ops)

    def test_echo_of_hello_is_not_an_ok(self):
        reply = dialect.find_reply(dialect.hello("abc"), "abc")
        self.assertIsNotNone(reply)
        assert reply is not None
        self.assertFalse(reply.ok)


    def test_chart_payload_is_mark_records(self):
        frame = dialect.chart(1, ["mark;x=0;y=0;w=1;h=1;t=glass"], "9")
        self.assertTrue(frame.startswith(b"\x1b_glass;chart;p=1;n=1;fit=contain;r=9;"))
        payload = frame.split(b"r=9;", 1)[1].removesuffix(b"\x1b\\")
        self.assertEqual(base64.b64decode(payload), b"mark;x=0;y=0;w=1;h=1;t=glass")

    def test_page_matches_the_published_example(self):
        frame = dialect.page("a page of text", 24, 4, None)
        self.assertEqual(
            frame,
            b"\x1b_glass;page;cols=24;rows=4;" + base64.b64encode(b"a page of text") + b"\x1b\\",
        )

    def test_remove_all_sends_no_id(self):
        frame = dialect.remove_all("ab")
        self.assertEqual(frame, b"\x1b_glass;remove;all=1;r=ab\x1b\\")
        self.assertNotIn(b"id=", frame)
        self.assertNotIn(b"asset=", frame)
        one = dialect.remove(32, "ab")
        self.assertIn(b"remove;id=32", one)
        self.assertNotIn(b"all=1", one)


class ChartPixels(unittest.TestCase):
    def test_taller_bar_uses_its_own_colour(self):
        drawn = chart.render("Queue", [chart.Bar("alpha", 1), chart.Bar("beta", 2)])
        self.assertEqual(drawn.width, chart.WIDTH)
        gap = 12
        bar_w = (chart.PLOT_W - gap * 3) // 2
        tall_x = chart.PLOT_X + gap + (bar_w + gap) + bar_w // 2
        short_top = chart.PLOT_Y + chart.PLOT_H - (chart.PLOT_H // 2)
        tall_top = chart.PLOT_Y + chart.PLOT_H - chart.PLOT_H
        above_short = short_top - 4
        self.assertLess(tall_top, above_short)
        self.assertEqual(chart.pixel(drawn.rgb, tall_x, above_short), chart.PALETTE[1])
        self.assertEqual(chart.pixel(drawn.rgb, 0, 0), chart.BG)
        self.assertIn("alpha", drawn.text)
        self.assertIn("beta", drawn.text)


class Claims(unittest.TestCase):
    def test_live_other_session_is_refused(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json", pid=1, alive=lambda pid: pid == 1)
            store.acquire("a", "tty:1", "/dev/pts/1")
            other = claims_mod.Claims(Path(tmp) / "claims.json", pid=2, alive=lambda pid: pid in {1, 2})
            with self.assertRaises(claims_mod.ClaimError) as caught:
                other.acquire("b", "tty:1", "/dev/pts/1")
            self.assertIn("another hermes session", caught.exception.reason)

    def test_dead_pid_can_be_taken(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "claims.json"
            claims_mod.Claims(path, pid=9, alive=lambda pid: False).acquire("a", "tty:1", "/dev/pts/1")
            taken = claims_mod.Claims(path, pid=3, alive=lambda pid: pid == 3)
            taken.acquire("b", "tty:1", "/dev/pts/1")
            self.assertTrue(taken.owns("b", "tty:1"))
            self.assertFalse(taken.owns("a", "tty:1"))

    def test_same_session_other_live_process_is_refused(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "claims.json"
            claims_mod.Claims(path, pid=1, alive=lambda pid: True).acquire("a", "tty:1", "/dev/pts/1")
            rival = claims_mod.Claims(path, pid=2, alive=lambda pid: True)
            with self.assertRaises(claims_mod.ClaimError):
                rival.acquire("a", "tty:1", "/dev/pts/1")


class Show(unittest.TestCase):
    def _store(self, tmp: str) -> claims_mod.Claims:
        return claims_mod.Claims(Path(tmp) / "claims.json")

    def test_confirmed_showcase_is_the_only_rendered_path(self):
        with tempfile.TemporaryDirectory() as tmp:
            glass = GlassScript()
            result = board.show(
                session="s",
                title="Queue",
                series="alpha=3,beta=8",
                claims=self._store(tmp),
                tty_key="script:1",
                port=glass,
            )
        self.assertTrue(result["rendered"])
        self.assertTrue(result["confirmed"])
        self.assertEqual(result["placement"], "showcase")
        self.assertTrue(any(b"showcase;" in item for item in glass.writes))
        self.assertNotIn(b"\x1b_glass;", result["text"].encode())

    def test_da1_does_not_draw(self):
        with tempfile.TemporaryDirectory() as tmp:
            plain = GlassScript(mode="da1")
            result = board.show(
                session="s",
                title="Queue",
                series="alpha=1",
                claims=self._store(tmp),
                tty_key="script:1",
                port=plain,
            )
        self.assertFalse(result["rendered"])
        self.assertEqual(result["reason"], "terminal is not glass")
        self.assertEqual(len(plain.writes), 1)
        self.assertIn("alpha", result["text"])

    def test_timeout_does_not_claim_a_frame(self):
        with tempfile.TemporaryDirectory() as tmp:
            quiet = GlassScript(mode="timeout")
            result = board.show(
                session="s",
                title="Queue",
                series="alpha=1",
                claims=self._store(tmp),
                tty_key="script:1",
                port=quiet,
            )
        self.assertFalse(result["rendered"])
        self.assertFalse(result["confirmed"])
        self.assertEqual(result["reason"], "terminal did not answer glass hello")

    def test_other_session_does_not_write(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            first = GlassScript()
            board.show(session="a", title="Queue", series="alpha=1", claims=store, tty_key="script:1", port=first)
            second = GlassScript()
            refused = board.show(
                session="b",
                title="Queue",
                series="beta=2",
                claims=store,
                tty_key="script:1",
                port=second,
            )
        self.assertFalse(refused["ok"])
        self.assertFalse(refused["rendered"])
        self.assertEqual(second.writes, [])

    def test_unconfirmed_placement_is_not_rendered(self):
        with tempfile.TemporaryDirectory() as tmp:
            glass = GlassScript(mode="reject-place")
            result = board.show(
                session="s",
                title="Queue",
                series="alpha=1",
                claims=self._store(tmp),
                tty_key="script:1",
                port=glass,
            )
        self.assertFalse(result["rendered"])
        self.assertFalse(result["confirmed"])
        self.assertEqual(result["reason"], "glass did not confirm the frame")
        self.assertTrue(any(item.startswith(b"\x1b_glass;remove;") for item in glass.writes))

    def test_layer_when_showcase_is_absent(self):
        with tempfile.TemporaryDirectory() as tmp:
            glass = GlassScript(ops="hello,picture,layer,remove")
            result = board.show(
                session="s",
                title="Queue",
                series="alpha=4",
                claims=self._store(tmp),
                tty_key="script:1",
                port=glass,
            )
        self.assertTrue(result["confirmed"])
        self.assertEqual(result["placement"], "layer")
        layer = next(item for item in glass.writes if b"layer;" in item)
        self.assertIn(b"px=", layer)
        self.assertNotIn(b";x=", layer)
        self.assertNotIn(b";y=", layer)
        self.assertNotIn(b";w=", layer)

    def test_update_removes_the_previous_picture(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            glass = GlassScript()
            first = board.show(session="s", title="Queue", series="alpha=1", claims=store, tty_key="script:1", port=glass)
            second = board.show(session="s", title="Queue", series="alpha=2,beta=9", claims=store, tty_key="script:1", port=glass)
        self.assertTrue(second["confirmed"])
        self.assertNotEqual(first["picture"], second["picture"])
        removed = f"remove;id={first['picture']}".encode()
        self.assertTrue(any(removed in item for item in glass.writes))

    def test_clear_requires_confirmation(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            glass = GlassScript()
            board.show(session="s", title="Queue", series="alpha=1", claims=store, tty_key="script:1", port=glass)
            cleared = board.clear(session="s", claims=store, port=glass)
        self.assertTrue(cleared["cleared"])
        self.assertIsNone(store.shown("s")[0])

    def test_no_terminal_is_text_only(self):
        with tempfile.TemporaryDirectory() as tmp:
            result = board.show(
                session="s",
                title="Queue",
                series="alpha=1",
                claims=self._store(tmp),
            )
        self.assertTrue(result["ok"])
        self.assertFalse(result["rendered"])
        self.assertIn("not a display", result["reason"])


class Native(unittest.TestCase):
    def test_chart_op_is_used_when_glass_lists_it(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            glass = GlassScript(ops="hello,picture,chart,layer,remove,showcase")
            result = board.show(
                session="a",
                title="Queue",
                series="alpha=3,beta=8",
                claims=store,
                tty_key="tty:1",
                port=glass,
            )
        self.assertTrue(result["rendered"])
        self.assertEqual(result["placement"], "chart")
        chart_write = next(item for item in glass.writes if b"chart;" in item)
        payload = chart_write.split(b"r=", 1)[1].split(b";", 1)[1].removesuffix(b"\x1b\\")
        text = base64.b64decode(payload).decode("ascii")
        self.assertIn("mark;x=", text)
        self.assertIn("t=alpha|3", text)
        self.assertEqual(text.count("\n") + 1, 2)

    def test_page_is_confirmed_only_after_ok(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            glass = GlassScript(ops="hello,page,remove,showcase")
            result = board.show_page(session="a", text="a page of text", claims=store, tty_key="tty:1", port=glass)
        self.assertTrue(result["confirmed"])
        self.assertEqual(result["placement"], "page")
        self.assertTrue(any(item.startswith(b"\x1b_glass;page;cols=") for item in glass.writes))

    def test_page_is_not_sent_to_a_non_glass_terminal(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            glass = GlassScript(mode="da1")
            result = board.show_page(session="a", text="a page of text", claims=store, tty_key="tty:1", port=glass)
        self.assertFalse(result["rendered"])
        self.assertFalse(any(b"page;" in item for item in glass.writes))

    def test_page_refuses_another_session(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            store.acquire("a", "tty:1", "tty:1")
            other = GlassScript(ops="hello,page")
            result = board.show_page(session="b", text="notes", claims=store, tty_key="tty:1", port=other)
        self.assertFalse(result["ok"])
        self.assertEqual(other.writes, [])


class PluginSurface(unittest.TestCase):
    def test_schema_says_not_to_claim_an_unconfirmed_frame(self):
        import __init__ as glass_plugin

        class Ctx:
            def __init__(self):
                self.tools = {}
                self.hooks = {}
                self.skills = {}

            def register_tool(self, name, schema, handler, description="", toolset="glass"):
                self.tools[name] = schema
                self.toolsets[name] = toolset

            def register_command(self, *args, **kwargs):
                pass

            def register_skill(self, name, path, description=""):
                self.skills[name] = path

            def register_hook(self, name, fn):
                self.hooks[name] = fn

        ctx = Ctx()
        ctx.toolsets = {}
        glass_plugin.register(ctx)
        expected_tools = {
            "glass_show",
            "glass_image",
            "glass_page",
            "glass_scene",
            "glass_model",
            "glass_tween",
            "glass_frame",
            "glass_layer",
            "glass_events",
            "glass_bind",
            "glass_probe",
            "glass_clear",
        }
        self.assertEqual(set(ctx.tools.keys()), expected_tools)
        for name, tool_schema in ctx.tools.items():
            self.assertEqual(ctx.toolsets[name], "glass")
            self.assertIn("description", tool_schema)
            self.assertIn("parameters", tool_schema)
            self.assertNotIn("session", tool_schema["parameters"]["properties"])
        schema = ctx.tools["glass_show"]
        self.assertIn("confirmed", schema["description"])
        self.assertEqual(["title", "series"], schema["parameters"]["required"])
        self.assertEqual(["path"], ctx.tools["glass_image"]["parameters"]["required"])
        self.assertEqual(["text"], ctx.tools["glass_page"]["parameters"]["required"])
        self.assertEqual(["path"], ctx.tools["glass_model"]["parameters"]["required"])
        self.assertEqual(["tty"], ctx.tools["glass_bind"]["parameters"]["required"])
        self.assertIn("all=1", ctx.tools["glass_clear"]["description"])
        self.assertIn("on_session_finalize", ctx.hooks)
        self.assertTrue(ctx.skills["display"].is_file())
        with tempfile.TemporaryDirectory() as tmp:
            import os

            os.environ["GLASS_RUNTIME"] = tmp
            os.environ.pop("GLASS_TTY", None)
            glass_plugin._LIVE.clear()
            raw = json.loads(ctx.tools and glass_plugin._show(title="Queue", series="alpha=1", session_id="s"))
            self.assertTrue(Path(raw["artifact_path"]).is_file())
            self.assertEqual(raw["artifact_role"], "fallback")
        self.assertFalse(raw["rendered"])


class ImageAndFile(unittest.TestCase):
    def _store(self, tmp):
        return claims_mod.Claims(Path(tmp) / "claims.json")

    def test_missing_terminal_saves_a_ppm_without_claiming_a_frame(self):
        with tempfile.TemporaryDirectory() as tmp:
            result = board.show(
                session="s",
                title="Queue",
                series="alpha=2,beta=5",
                claims=self._store(tmp),
            )
            path = Path(result["artifact_path"])
            self.assertFalse(result["rendered"])
            self.assertEqual(result["artifact_role"], "fallback")
            self.assertTrue(path.is_file())
            self.assertTrue(path.read_bytes().startswith(b"P6\n"))

    def test_image_showcase_is_confirmed_and_the_file_is_only_a_copy(self):
        with tempfile.TemporaryDirectory() as tmp:
            source = Path(tmp) / "dot.ppm"
            source.write_bytes(b"P6\n1 1\n255\n\xff\x00\x00")
            glass = GlassScript(ops="hello,picture,showcase,remove")
            result = board.show_image(
                session="s",
                path=source,
                claims=self._store(tmp),
                tty_key="script:1",
                port=glass,
            )
        self.assertTrue(result["rendered"])
        self.assertTrue(result["confirmed"])
        self.assertEqual(result["placement"], "showcase")
        self.assertEqual(result["artifact_role"], "copy")
        self.assertTrue(any(b"f=100" in item for item in glass.writes))

    def test_text_file_is_not_an_image(self):
        with tempfile.TemporaryDirectory() as tmp:
            source = Path(tmp) / "note.txt"
            source.write_text("secret-not-shown")
            result = board.show_image(session="s", path=source, claims=self._store(tmp))
        self.assertFalse(result["ok"])
        self.assertFalse(result["rendered"])
        self.assertNotIn("secret-not-shown", result["reason"])

    def test_write_all_waits_when_the_buffer_is_full(self):
        import os
        import threading
        import time
        from transport import write_all

        read_fd, write_fd = os.pipe()
        os.set_blocking(write_fd, False)
        os.set_blocking(read_fd, False)
        chunk = b"x" * 65536
        try:
            while True:
                os.write(write_fd, chunk)
        except BlockingIOError:
            pass

        done = threading.Event()

        def drain():
            while not done.is_set():
                try:
                    os.read(read_fd, 1 << 20)
                except BlockingIOError:
                    time.sleep(0.01)
                except OSError:
                    return

        worker = threading.Thread(target=drain)
        worker.start()
        try:
            write_all(write_fd, b"glass-frame", wait=2.0)
        finally:
            done.set()
            worker.join(timeout=2.0)
            os.close(read_fd)
            os.close(write_fd)


class DurableCli(unittest.TestCase):
    def test_show_keeps_the_fallback_after_the_command_exits(self):
        import io
        import os
        from contextlib import redirect_stdout

        import cli

        with tempfile.TemporaryDirectory() as tmp:
            old = os.environ.get("GLASS_RUNTIME")
            os.environ["GLASS_RUNTIME"] = tmp
            try:
                buf = io.StringIO()
                with redirect_stdout(buf):
                    code = cli.main(
                        ["show", "--title", "Queue", "--series", "alpha=3,beta=8", "--session", "demo"]
                    )
                result = json.loads(buf.getvalue())
            finally:
                if old is None:
                    os.environ.pop("GLASS_RUNTIME", None)
                else:
                    os.environ["GLASS_RUNTIME"] = old
            self.assertEqual(code, 0)
            self.assertFalse(result["rendered"])
            path = Path(result["artifact_path"])
            self.assertTrue(path.is_file(), result["artifact_path"])
            self.assertTrue(str(path).startswith(tmp))
            self.assertTrue(path.read_bytes().startswith(b"P6\n"))
            self.assertTrue((Path(tmp) / "claims.json").is_file() or not result.get("bound"))

    def test_bind_writes_the_runtime_file_not_a_deleted_temp_dir(self):
        import io
        import os
        from contextlib import redirect_stdout

        import cli

        master, slave = os.openpty()
        try:
            slave_path = os.ttyname(slave)
            with tempfile.TemporaryDirectory() as tmp:
                old = os.environ.get("GLASS_RUNTIME")
                os.environ["GLASS_RUNTIME"] = tmp
                try:
                    buf = io.StringIO()
                    with redirect_stdout(buf):
                        code = cli.main(
                            ["bind", "--session", "demo", "--tty", slave_path, "--timeout", "0.05"]
                        )
                    result = json.loads(buf.getvalue())
                finally:
                    if old is None:
                        os.environ.pop("GLASS_RUNTIME", None)
                    else:
                        os.environ["GLASS_RUNTIME"] = old
                self.assertEqual(code, 0)
                self.assertFalse(result.get("bound"))
                self.assertTrue((Path(tmp) / "claims.json").is_file())
                later = claims_mod.Claims(Path(tmp) / "claims.json")
                self.assertIsNone(later.path_for("demo"))
        finally:
            os.close(master)
            os.close(slave)

    def test_a_later_process_shows_on_the_tty_the_first_bound(self):
        import os

        master, slave = os.openpty()
        try:
            slave_path = os.ttyname(slave)
            with tempfile.TemporaryDirectory() as tmp:
                path = Path(tmp) / "claims.json"
                first = claims_mod.Claims(path, pid=11, alive=lambda pid: pid == 11)
                bound = board.bind_session(
                    session="demo",
                    tty_path=slave_path,
                    claims=first,
                    port=GlassScript(ops="hello,picture,chart,layer,remove,showcase,page"),
                    timeout=0.05,
                )
                self.assertTrue(bound.get("bound"), bound)
                second = claims_mod.Claims(path, pid=22, alive=lambda pid: pid == 22)
                self.assertEqual(second.path_for("demo"), slave_path)
                shown = board.show(
                    session="demo",
                    title="Queue",
                    series="alpha=3,beta=8",
                    claims=second,
                    port=GlassScript(ops="hello,picture,chart,layer,remove,showcase,page"),
                    timeout=0.05,
                )
                self.assertTrue(shown["rendered"], shown)
                self.assertTrue(shown["confirmed"], shown)
                self.assertNotIn("another process", shown.get("reason") or "")
                self.assertTrue(Path(shown["artifact_path"]).is_file())
        finally:
            os.close(master)
            os.close(slave)


class Scene(unittest.TestCase):
    def test_frame_uses_pixels_and_named_mesh(self):
        payload = dialect.scene_payload("cube", (1.0, 0.4, 0.2, 1.0))
        body = json.loads(payload)
        self.assertEqual(1, body["v"])
        self.assertEqual("cube", body["scene"]["nodes"][0]["mesh"])
        self.assertEqual([1.0, 0.4, 0.2, 1.0], body["scene"]["nodes"][0]["color"])
        self.assertEqual(
            b'{"v":1,"scene":{"camera":{"eye":[1.8,1.2,2.4],"fov":0.9},"nodes":[{"id":1,"mesh":"cube","color":[1.0,0.4,0.2,1.0],"lit":true}]}}',
            payload,
        )
        frame = dialect.scene(1, payload, "a", width=160, height=120, x=40, y=40)
        text = frame.decode("ascii")
        self.assertIn("scene;id=1;px=40,40,160,120;s=160;v=120;", text)
        with self.assertRaises(ValueError):
            dialect.scene_payload("teapot", (1, 0, 0, 1))
        kind = json.loads(dialect.scene_payload("sphere", (1, 0, 0, 1)))
        self.assertEqual({"kind": "sphere"}, kind["scene"]["nodes"][0]["mesh"])
        self.assertNotIn("chrome", kind["scene"]["nodes"][0])
        mercury = dialect.scene_payload("sphere", (1, 1, 1, 1), chrome=1, liquid=0.6, segments=48)
        mercury_body = json.loads(mercury)
        self.assertEqual({"kind": "sphere", "segments": 48}, mercury_body["scene"]["nodes"][0]["mesh"])
        self.assertEqual(1.0, mercury_body["scene"]["nodes"][0]["chrome"])
        self.assertEqual(0.6, mercury_body["scene"]["nodes"][0]["liquid"])
        self.assertEqual([0.0, 0.0, 0.0, 1.0], mercury_body["scene"]["camera"]["clear"])
        self.assertNotIn(b'"mesh":"sphere"', mercury)
        with self.assertRaises(ValueError):
            dialect.scene_payload("sphere", (1, 0, 0, 1), posts=4)
        with self.assertRaises(ValueError):
            dialect.scene_payload("cube", (1, 0, 0, 1), segments=8)
        with self.assertRaises(ValueError):
            dialect.scene_payload("roundcube", (1, 0, 0, 1), segments=48)
        spin = dialect.tween_node(1, "b", dialect.yaw_rot(180))
        spin_text = spin.decode("ascii")
        self.assertIn("tween;id=1;node=1;rot=0,1.0000,0,0.0000;", spin_text)
        self.assertIn("ease=spring(170,12);repeat=forever;yoyo=1;", spin_text)
        self.assertNotIn("ping", spin_text)
        bare = b"_glass;r=scenepx1;OK;\x1b\\"
        found = dialect.find_reply(bare, "scenepx1")
        self.assertIsNotNone(found)
        self.assertTrue(found.ok)
        self.assertIsNone(dialect.find_reply(bare, "other"))
        self.assertIsNone(dialect.find_reply(b"_glass;r=scenepx1;OK;", "scenepx1"))

    def test_scene_confirms_only_after_ok(self):
        port = GlassScript(ops="hello,scene,tween,remove,showcase")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(
                session="s",
                mesh="Gem",
                claims=store,
                port=port,
                tty_key="script:1",
                spin=True,
            )
            self.assertTrue(shown["rendered"])
            self.assertTrue(shown["confirmed"])
            self.assertTrue(shown["moved"])
            self.assertEqual("scene", shown["placement"])
            self.assertEqual("gem", shown["mesh"])
            self.assertEqual("scene", store.kind("s"))
            joined = b"".join(port.writes)
            self.assertIn(b"scene;", joined)
            self.assertIn(b"yoyo=1", joined)
            self.assertNotIn(b"repeat=ping", joined)
            store.acquire("s", "script:1", "script:1")
            self.assertEqual("scene", store.kind("s"))
            cleared = board.clear(session="s", claims=store, port=port)
            self.assertTrue(cleared["cleared"])
            self.assertIn(f"remove;id={shown['picture']}".encode(), b"".join(port.writes))

    def test_missing_scene_op_does_not_write_a_scene(self):
        port = GlassScript(ops="hello,picture,chart,showcase")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(
                session="s",
                mesh="cube",
                claims=store,
                port=port,
                tty_key="script:1",
                spin=True,
            )
        self.assertTrue(shown["ok"])
        self.assertFalse(shown["rendered"])
        self.assertFalse(shown["moved"])
        self.assertNotIn(b"scene;", b"".join(port.writes))
        self.assertNotIn(b"tween;", b"".join(port.writes))

    def test_refused_tween_keeps_the_scene(self):
        port = GlassScript(mode="reject-tween", ops="hello,scene,tween,remove,showcase")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(
                session="s",
                mesh="cube",
                claims=store,
                port=port,
                tty_key="script:1",
                spin=True,
            )
            self.assertTrue(shown["rendered"])
            self.assertFalse(shown["moved"])
            self.assertEqual("scene", store.kind("s"))
            other = GlassScript(ops="hello,scene,tween")
            refused = board.show_scene(
                session="other",
                mesh="cube",
                claims=store,
                port=other,
                tty_key="script:1",
            )
            self.assertFalse(refused["ok"])
            self.assertEqual([], other.writes)
            idle = board.tween_scene(session="other", claims=store, port=other, tty_key="script:1", yaw=90)
            self.assertFalse(idle["moved"])
            self.assertEqual([], other.writes)

    def test_tween_without_a_scene_does_not_write(self):
        port = GlassScript(ops="hello,tween")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            moved = board.tween_scene(session="s", claims=store, port=port, tty_key="script:1")
        self.assertFalse(moved["moved"])
        self.assertEqual([], port.writes)

    def test_bad_mesh_does_not_bind(self):
        port = GlassScript(ops="hello,scene")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(session="s", mesh="teapot", claims=store, port=port, tty_key="script:1")
        self.assertFalse(shown["ok"])
        self.assertEqual([], port.writes)
        self.assertIsNone(store.path_for("s"))

    def test_mercury_kind_is_sent_and_a_bad_finish_is_not(self):
        port = GlassScript(ops="hello,scene,tween")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(
                session="s",
                mesh="sphere",
                claims=store,
                port=port,
                tty_key="script:1",
                finish="mercury",
                spin=True,
            )
            self.assertTrue(shown["rendered"], shown)
            self.assertTrue(shown["moved"], shown)
            self.assertEqual("sphere", shown["mesh"])
            joined = b"".join(port.writes)
            body = dialect.scene_body(joined)
            self.assertIn(b'"kind":"sphere"', body)
            self.assertIn(b'"segments":48', body)
            self.assertIn(b'"chrome":1.0', body)
            self.assertIn(b'"liquid":0.6', body)
            self.assertNotIn(b'"mesh":"sphere"', body)
            refused = board.show_scene(
                session="other",
                mesh="cube",
                claims=store,
                port=port,
                tty_key="script:2",
                finish="ping",
            )
        self.assertFalse(refused["ok"])
        self.assertIsNone(store.path_for("other"))

    def test_stage_parents_later_pieces_and_keeps_the_ground_matte(self):
        body = json.loads(dialect.stage_payload(dialect.COURT_PIECES, chrome=1, liquid=0.6, auto_segments=True))
        nodes = body["scene"]["nodes"]
        self.assertEqual(3, len(nodes))
        self.assertNotIn("parent", nodes[0])
        self.assertEqual("plane", nodes[0]["mesh"])
        self.assertEqual([3.0, 0.08, 3.0], nodes[0]["scale"])
        self.assertNotIn("chrome", nodes[0])
        self.assertNotIn("liquid", nodes[0])
        self.assertEqual(1, nodes[1]["parent"])
        self.assertEqual("gem", nodes[1]["mesh"])
        self.assertEqual(1, nodes[2]["parent"])
        self.assertEqual({"kind": "sphere", "segments": 48}, nodes[2]["mesh"])
        self.assertEqual(1.0, nodes[2]["chrome"])
        self.assertEqual(0.6, nodes[2]["liquid"])
        self.assertEqual([0.0, 0.4, 0.0], body["scene"]["camera"]["target"])
        self.assertEqual([0.0, 0.0, 0.0, 1.0], body["scene"]["camera"]["clear"])
        raw = dialect.stage_payload(dialect.COURT_PIECES, chrome=1, liquid=0.6, auto_segments=True)
        self.assertNotIn(b'"mesh":"sphere"', raw)
        cube = json.loads(dialect.scene_payload("cube", (1.0, 0.4, 0.2, 1.0)))
        self.assertNotIn("target", cube["scene"]["camera"])
        self.assertEqual(1, len(cube["scene"]["nodes"]))

    def test_stage_refuses_a_bad_piece_before_any_write(self):
        port = GlassScript(ops="hello,scene,tween")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            both = board.show_scene(
                session="s",
                stage="court",
                pieces="plane;cube",
                claims=store,
                port=port,
                tty_key="script:1",
            )
            far = board.show_scene(
                session="s",
                pieces="plane;cube@4,0,0",
                claims=store,
                port=port,
                tty_key="script:1",
            )
            posts = board.show_scene(
                session="s",
                stage="court",
                posts=4,
                claims=store,
                port=port,
                tty_key="script:1",
            )
        self.assertFalse(both["ok"])
        self.assertFalse(far["ok"])
        self.assertFalse(posts["ok"])
        self.assertEqual([], port.writes)
        with self.assertRaises(ValueError):
            dialect.parse_pieces("sphere")
        with self.assertRaises(ValueError):
            dialect.stage_payload("plane;cube", chrome=1)

    def test_stage_and_camera_tween_are_confirmed_only_after_ok(self):
        port = GlassScript(ops="hello,scene,tween,remove,showcase")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(
                session="s",
                stage="court",
                finish="mercury",
                claims=store,
                port=port,
                tty_key="script:1",
                spin=True,
            )
            self.assertTrue(shown["rendered"], shown)
            self.assertTrue(shown["moved"], shown)
            self.assertEqual(3, shown["nodes"])
            self.assertEqual("court", shown["stage"])
            self.assertEqual(["plane", "gem", "sphere"], shown["pieces"])
            body = json.loads(dialect.scene_body(b"".join(port.writes)))
            self.assertEqual(1, body["scene"]["nodes"][1]["parent"])
            self.assertNotIn("chrome", body["scene"]["nodes"][0])
            moved = board.tween_scene(
                session="s",
                claims=store,
                port=port,
                tty_key="script:1",
                eye="2.4,1.6,3.2",
                ease="sine",
            )
        self.assertTrue(moved["moved"], moved)
        joined = b"".join(port.writes)
        self.assertIn(b"camera=1;eye=2.4,1.6,3.2;", joined)
        self.assertNotIn(b"node=", joined.split(b"tween;")[-1])

    def test_chain_names_each_step_and_stops_sending_after_a_refusal(self):
        old = dialect.tween_camera(1, "abc", "2.4,1.6,3.2")
        old_text = old.decode("ascii")
        self.assertIn("repeat=forever;yoyo=1;r=abc", old_text)
        self.assertNotIn("tid=", old_text)
        self.assertNotIn(";dur=", old_text)
        self.assertNotIn("after=", old_text)
        first = dialect.tween_camera(
            7, "aaa", "2.4,1.6,3.2", ease="sine", repeat=None, yoyo=False, tid=1, dur=0.6
        )
        second = dialect.tween_camera(
            7, "bbb", "0.8,1.1,2.2", ease="sine", repeat=None, yoyo=False, tid=2, after=1, dur=0.6
        )
        self.assertIn(
            "tween;id=7;camera=1;eye=2.4,1.6,3.2;ease=sine-in-out;dur=0.6;tid=1;r=aaa",
            first.decode("ascii"),
        )
        self.assertNotIn(b"yoyo", first)
        self.assertNotIn(b"repeat", first)
        self.assertIn(";tid=2;after=1;r=bbb", second.decode("ascii"))
        self.assertIn("tween;tid=2;stop=1;r=ccc", dialect.tween_stop("ccc", 2).decode("ascii"))
        with self.assertRaises(ValueError):
            dialect.tween_camera(7, "aaa", "1,2,3", repeat=None, yoyo=False, tid=1, after=1)
        with self.assertRaises(ValueError):
            dialect.parse_eyes("1,2,3")

        eyes = "2.4,1.6,3.2;0.8,1.1,2.2"
        port = GlassScript(ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(
                session="s", mesh="cube", claims=store, port=port, tty_key="script:1", spin=False
            )
            self.assertTrue(shown["confirmed"])
            before = len(port.writes)
            chained = board.chain_scene(
                session="s", claims=store, port=port, tty_key="script:1", eyes=eyes, dur=0.6
            )
            self.assertTrue(chained["chained"], chained)
            self.assertTrue(chained["moved"])
            self.assertTrue(chained["confirmed"])
            self.assertEqual(2, chained["steps"])
            self.assertEqual([1, 2], chained["tids"])
            added = b"".join(port.writes[before:])
            self.assertIn(b";dur=0.6;tid=1;r=", added)
            self.assertIn(b";tid=2;after=1;r=", added)
            self.assertNotIn(b"yoyo=1", added)
            stopped = board.chain_scene(
                session="s", claims=store, port=port, tty_key="script:1", stop=True, tid=2
            )
            self.assertTrue(stopped["stopped"], stopped)
            self.assertFalse(stopped["moved"])
            self.assertIn(b"tween;tid=2;stop=1;", port.writes[-1])

            refused = GlassScript(ops="hello,scene,tween,remove", mode="reject-tween")
            before = len(refused.writes)
            missed = board.chain_scene(
                session="s", claims=store, port=refused, tty_key="script:1", eyes=eyes
            )
            self.assertFalse(missed["chained"])
            self.assertFalse(missed["moved"])
            self.assertEqual(0, missed["steps"])
            tween_writes = [item for item in refused.writes[before:] if b"tween;" in item]
            self.assertEqual(1, len(tween_writes))

            bare = GlassScript(ops="hello,scene,remove")
            quiet = board.chain_scene(
                session="s", claims=store, port=bare, tty_key="script:1", eyes=eyes
            )
            self.assertFalse(quiet["chained"])
            self.assertFalse(any(b"tween;" in item for item in bare.writes))

            early = board.chain_scene(
                session="s", claims=store, port=port, tty_key="script:1", eyes="1,2,3"
            )
            self.assertFalse(early["ok"])
            both = board.chain_scene(
                session="s", claims=store, port=port, tty_key="script:1", eyes=eyes, stop=True, tid=1
            )
            self.assertFalse(both["ok"])
            self.assertIn("stop does not take", both["reason"])


class Shift(unittest.TestCase):
    def test_node_shift_is_once_and_does_not_change_the_spin_frame(self):
        spin = dialect.tween_node(1, "abc", dialect.yaw_rot(180))
        spin_text = spin.decode("ascii")
        self.assertIn("repeat=forever;yoyo=1;r=abc", spin_text)
        self.assertIn("rot=", spin_text)
        self.assertNotIn(";at=", spin_text)
        self.assertNotIn(";scale=", spin_text)
        self.assertNotIn(";color=", spin_text)

        frame = dialect.tween_shift(
            7,
            "aaa",
            at="0.4,0.2,0",
            scale="1.6,1.6,1.6",
            color="0.2,0.45,0.9,1",
            ease="sine",
            dur=0.6,
        )
        text_frame = frame.decode("ascii")
        self.assertIn(
            "tween;id=7;node=1;at=0.4,0.2,0;scale=1.6,1.6,1.6;color=0.2,0.45,0.9,1;ease=sine-in-out;dur=0.6;r=aaa",
            text_frame,
        )
        self.assertNotIn("rot=", text_frame)
        self.assertNotIn("yoyo", text_frame)
        self.assertNotIn("repeat", text_frame)
        self.assertNotIn("camera=", text_frame)
        self.assertNotIn("tid=", text_frame)
        only = dialect.tween_shift(7, "bbb", at="1,0,0", node=2, tid=8)
        only_text = only.decode("ascii")
        self.assertIn("node=2;at=1,0,0;", only_text)
        self.assertNotIn("scale=", only_text)
        self.assertNotIn("color=", only_text)
        self.assertIn(";tid=8;r=bbb", only_text)
        with self.assertRaises(ValueError):
            dialect.tween_shift(7, "aaa")
        with self.assertRaises(ValueError):
            dialect.parse_shift(color="1,0,0")
        with self.assertRaises(ValueError):
            dialect.parse_shift(color="0,0,2,1")
        with self.assertRaises(ValueError):
            dialect.tween_shift(7, "aaa", at="1,2", node=1)
        with self.assertRaises(ValueError):
            dialect.tween_shift(7, "aaa", scale="9,1,1")

        port = GlassScript(ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(
                session="s", mesh="cube", claims=store, port=port, tty_key="script:1", spin=False
            )
            self.assertTrue(shown["confirmed"])
            before = len(port.writes)
            shifted = board.shift_scene(
                session="s",
                claims=store,
                port=port,
                tty_key="script:1",
                at="0.4,0.2,0",
                scale="1.6,1.6,1.6",
                color="0.2,0.45,0.9,1",
            )
            self.assertTrue(shifted["shifted"], shifted)
            self.assertTrue(shifted["moved"])
            self.assertTrue(shifted["confirmed"])
            self.assertFalse(shifted["rendered"])
            self.assertEqual(["at", "scale", "color"], shifted["channels"])
            self.assertEqual(1, shifted["node"])
            added = b"".join(port.writes[before:])
            self.assertIn(b";at=0.4,0.2,0;scale=1.6,1.6,1.6;color=0.2,0.45,0.9,1;", added)
            self.assertNotIn(b"rot=", added)
            self.assertNotIn(b"yoyo", added)

            refused = GlassScript(ops="hello,scene,tween,remove", mode="reject-tween")
            before = len(refused.writes)
            missed = board.shift_scene(
                session="s",
                claims=store,
                port=refused,
                tty_key="script:1",
                at="0.4,0.2,0",
            )
            self.assertFalse(missed["shifted"])
            self.assertFalse(missed["moved"])
            self.assertFalse(missed["confirmed"])
            tween_writes = [item for item in refused.writes[before:] if b"tween;" in item]
            self.assertEqual(1, len(tween_writes))

            bare = GlassScript(ops="hello,scene,remove")
            quiet = board.shift_scene(
                session="s", claims=store, port=bare, tty_key="script:1", scale="2,2,2"
            )
            self.assertFalse(quiet["shifted"])
            self.assertFalse(any(b"tween;" in item for item in bare.writes))

            early = board.shift_scene(session="s", claims=store, port=port, tty_key="script:1")
            self.assertFalse(early["ok"])
            self.assertIn("needs at", early["reason"])
            missing = board.shift_scene(
                session="absent", claims=store, port=port, tty_key="script:1", at="1,0,0"
            )
            self.assertFalse(missing["shifted"])
            self.assertIn("no scene", missing["reason"])


class Turn(unittest.TestCase):
    def test_node_turn_is_once_and_does_not_change_the_spin_frame(self):
        spin = dialect.tween_node(1, "abc", dialect.yaw_rot(180))
        spin_text = spin.decode("ascii")
        self.assertIn("repeat=forever;yoyo=1;r=abc", spin_text)
        self.assertIn("rot=0,1.0000,0,0.0000", spin_text)

        frame = dialect.tween_turn(7, "aaa", yaw=90)
        text_frame = frame.decode("ascii")
        self.assertIn(
            "tween;id=7;node=1;rot=0,0.7071,0,0.7071;ease=spring(170,12);r=aaa",
            text_frame,
        )
        self.assertNotIn("dur=", text_frame)
        self.assertNotIn("yoyo", text_frame)
        self.assertNotIn("repeat", text_frame)
        self.assertNotIn("at=", text_frame)
        self.assertNotIn("scale=", text_frame)
        self.assertNotIn("color=", text_frame)
        self.assertNotIn("camera=", text_frame)
        self.assertNotIn("tid=", text_frame)
        self.assertNotEqual(spin_text, text_frame)
        paced = dialect.tween_turn(7, "bbb", yaw=90, ease="sine")
        self.assertIn("ease=sine-in-out;r=bbb", paced.decode("ascii"))
        self.assertNotIn("dur=", paced.decode("ascii"))
        asked = dialect.tween_turn(7, "ccc", rot="0,0.7071,0,0.7071", dur=0.4, tid=4, node=2)
        asked_text = asked.decode("ascii")
        self.assertIn("node=2;rot=0,0.7071,0,0.7071;", asked_text)
        self.assertIn(";dur=0.4;tid=4;r=ccc", asked_text)
        with self.assertRaises(ValueError):
            dialect.parse_turn()
        with self.assertRaises(ValueError):
            dialect.parse_turn(yaw=90, rot="0,0,0,1")
        with self.assertRaises(ValueError):
            dialect.parse_turn(rot="1,1,1,1")
        with self.assertRaises(ValueError):
            dialect.tween_turn(7, "aaa", yaw=900)

        port = GlassScript(ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(
                session="s", mesh="cube", claims=store, port=port, tty_key="script:1", spin=False
            )
            self.assertTrue(shown["confirmed"])
            before = len(port.writes)
            turned = board.turn_scene(session="s", claims=store, port=port, tty_key="script:1", yaw=90)
            self.assertTrue(turned["turned"], turned)
            self.assertTrue(turned["moved"])
            self.assertTrue(turned["confirmed"])
            self.assertFalse(turned["rendered"])
            self.assertEqual(["rot"], turned["channels"])
            self.assertEqual(1, turned["node"])
            added = b"".join(port.writes[before:])
            self.assertIn(b"rot=0,0.7071,0,0.7071", added)
            self.assertNotIn(b"yoyo", added)
            self.assertNotIn(b"repeat", added)
            self.assertNotIn(b";at=", added)
            self.assertNotIn(b"dur=", added)
            sine_before = len(port.writes)
            sine = board.turn_scene(
                session="s", claims=store, port=port, tty_key="script:1", yaw=45, ease="sine"
            )
            self.assertTrue(sine["turned"], sine)
            sine_added = b"".join(port.writes[sine_before:])
            self.assertIn(b"ease=sine-in-out;dur=0.6", sine_added)
            self.assertNotIn(b"yoyo", sine_added)

            refused = GlassScript(ops="hello,scene,tween,remove", mode="reject-tween")
            before = len(refused.writes)
            missed = board.turn_scene(
                session="s", claims=store, port=refused, tty_key="script:1", yaw=90
            )
            self.assertFalse(missed["turned"])
            self.assertFalse(missed["moved"])
            self.assertFalse(missed["confirmed"])
            tween_writes = [item for item in refused.writes[before:] if b"tween;" in item]
            self.assertEqual(1, len(tween_writes))

            bare = GlassScript(ops="hello,scene,remove")
            quiet = board.turn_scene(session="s", claims=store, port=bare, tty_key="script:1", yaw=90)
            self.assertFalse(quiet["turned"])
            self.assertFalse(any(b"tween;" in item for item in bare.writes))

            missing = board.turn_scene(
                session="absent", claims=store, port=port, tty_key="script:1", yaw=90
            )
            self.assertFalse(missing["turned"])


class Veil(unittest.TestCase):
    def test_node_veil_sends_only_asked_channels(self):
        frame = dialect.tween_veil(7, "ccc", emissive=1, visible=0, dur=0.4)
        text = frame.decode("ascii")
        self.assertIn("tween;id=7;node=1;emissive=1;visible=0;ease=sine-in-out;dur=0.4;r=ccc", text)
        tail = text.split("emissive=1", 1)[-1]
        for banned in ("rot=", "at=", "scale=", "color=", "camera=", "yoyo", "repeat="):
            self.assertNotIn(banned, tail)
        shine = dialect.tween_veil(7, "ddd", emissive=0.25, ease="spring")
        shine_text = shine.decode("ascii")
        self.assertIn("emissive=0.25", shine_text)
        self.assertIn("spring(170,12)", shine_text)
        self.assertNotIn("dur=", shine_text)
        self.assertNotIn("visible=", shine_text)
        hidden = dialect.tween_veil(7, "eee", visible=False)
        self.assertIn(b"visible=0", hidden)
        self.assertNotIn(b"emissive=", hidden)
        spin = dialect.tween_node(7, "bbb", dialect.yaw_rot(180), repeat="forever", yoyo=True)
        self.assertIn(b"repeat=forever", spin)
        self.assertIn(b"yoyo=1", spin)
        cube = json.loads(dialect.scene_payload("cube", dialect.parse_color(None)))
        self.assertEqual("cube", cube["scene"]["nodes"][0]["mesh"])
        self.assertNotIn("emissive", cube["scene"]["nodes"][0])
        with self.assertRaises(ValueError):
            dialect.parse_veil()
        with self.assertRaises(ValueError):
            dialect.parse_veil(emissive=2)
        with self.assertRaises(ValueError):
            dialect.parse_veil(visible=2)
        with self.assertRaises(ValueError):
            dialect.tween_veil(7, "ccc", node=0, visible=1)

        port = GlassScript(ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(
                session="s", mesh="cube", claims=store, port=port, tty_key="script:1", spin=False
            )
            self.assertTrue(shown["confirmed"])
            before = len(port.writes)
            veiled = board.veil_scene(
                session="s",
                claims=store,
                port=port,
                tty_key="script:1",
                emissive=1,
                visible=0,
                dur=0.4,
            )
            self.assertTrue(veiled["veiled"], veiled)
            self.assertTrue(veiled["moved"])
            self.assertTrue(veiled["confirmed"])
            self.assertFalse(veiled["rendered"])
            self.assertEqual(["emissive", "visible"], veiled["channels"])
            self.assertEqual(1, veiled["node"])
            added = b"".join(port.writes[before:])
            self.assertIn(b"emissive=1;visible=0", added)
            self.assertNotIn(b"yoyo", added)
            self.assertNotIn(b"repeat", added)
            self.assertNotIn(b"rot=", added)

            refused = GlassScript(ops="hello,scene,tween,remove", mode="reject-tween")
            before = len(refused.writes)
            missed = board.veil_scene(
                session="s", claims=store, port=refused, tty_key="script:1", emissive=1
            )
            self.assertFalse(missed["veiled"])
            self.assertFalse(missed["confirmed"])
            tween_writes = [item for item in refused.writes[before:] if b"tween;" in item]
            self.assertEqual(1, len(tween_writes))

            bare = GlassScript(ops="hello,scene,remove")
            unlisted = board.veil_scene(
                session="s", claims=store, port=bare, tty_key="script:1", visible=0
            )
            self.assertFalse(unlisted["veiled"])
            self.assertIn("tween", unlisted["reason"])
            self.assertFalse(any(b"tween;" in item for item in bare.writes))

            missing = board.veil_scene(
                session="absent", claims=store, port=port, tty_key="script:1", visible=1
            )
            self.assertFalse(missing["veiled"])
            self.assertIn("no scene", missing["reason"])


class Look(unittest.TestCase):
    def test_camera_look_sends_target_and_fov_without_eye(self):
        frame = dialect.tween_look(7, "ccc", "0,1,0", 0.5, dur=0.6)
        text_frame = frame.decode("ascii")
        self.assertIn(
            "tween;id=7;camera=1;target=0,1,0;fov=0.5;ease=sine-in-out;dur=0.6;r=ccc",
            text_frame,
        )
        tail = text_frame.split("camera=1", 1)[-1]
        for banned in ("eye=", "node=", "rot=", "at=", "yoyo", "repeat="):
            self.assertNotIn(banned, tail)
        zoom = dialect.tween_look(7, "ddd", fov=0.8, ease="spring")
        zoom_text = zoom.decode("ascii")
        self.assertIn("camera=1;fov=0.8;ease=spring(170,12);r=ddd", zoom_text)
        self.assertNotIn("dur=", zoom_text)
        self.assertNotIn("target=", zoom_text)
        self.assertNotIn("eye=", zoom_text)
        aim = dialect.tween_look(7, "eee", target="0,1,0", tid=2)
        self.assertIn(b"target=0,1,0", aim)
        self.assertNotIn(b"fov=", aim)
        self.assertIn(b"tid=2", aim)
        rock = dialect.tween_camera(7, "bbb", "1.8,1.2,2.4", repeat="forever", yoyo=True)
        self.assertIn(b"eye=", rock)
        self.assertIn(b"repeat=forever", rock)
        self.assertIn(b"yoyo=1", rock)
        self.assertNotIn(b"target=", rock)
        self.assertNotIn(b"fov=", rock)
        with self.assertRaises(ValueError):
            dialect.parse_look(None, None)
        with self.assertRaises(ValueError):
            dialect.parse_look("0,1", None)
        with self.assertRaises(ValueError):
            dialect.parse_look(None, 0)
        with self.assertRaises(ValueError):
            dialect.parse_look(None, 3.15)

        port = GlassScript(ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(
                session="s", mesh="cube", claims=store, port=port, tty_key="script:1", spin=False
            )
            self.assertTrue(shown["confirmed"])
            before = len(port.writes)
            looked = board.look_scene(
                session="s",
                claims=store,
                port=port,
                tty_key="script:1",
                target="0,1,0",
                fov=0.5,
                dur=0.6,
            )
            self.assertTrue(looked["looked"], looked)
            self.assertTrue(looked["moved"])
            self.assertTrue(looked["confirmed"])
            self.assertFalse(looked["rendered"])
            self.assertEqual(["target", "fov"], looked["channels"])
            added = b"".join(port.writes[before:])
            self.assertIn(b"camera=1;target=0,1,0;fov=0.5", added)
            self.assertNotIn(b"eye=", added)
            self.assertNotIn(b"yoyo", added)
            self.assertNotIn(b"repeat", added)

            refused = GlassScript(ops="hello,scene,tween,remove", mode="reject-tween")
            before = len(refused.writes)
            missed = board.look_scene(
                session="s", claims=store, port=refused, tty_key="script:1", fov=0.5
            )
            self.assertFalse(missed["looked"])
            self.assertFalse(missed["confirmed"])
            tween_writes = [item for item in refused.writes[before:] if b"tween;" in item]
            self.assertEqual(1, len(tween_writes))

            bare = GlassScript(ops="hello,scene,remove")
            unlisted = board.look_scene(
                session="s", claims=store, port=bare, tty_key="script:1", target="0,1,0"
            )
            self.assertFalse(unlisted["looked"])
            self.assertIn("tween", unlisted["reason"])
            self.assertFalse(any(b"tween;" in item for item in bare.writes))

            missing = board.look_scene(
                session="absent", claims=store, port=port, tty_key="script:1", fov=0.8
            )
            self.assertFalse(missing["looked"])
            self.assertIn("no scene", missing["reason"])

            quiet = board.look_scene(
                session="s", claims=store, port=port, tty_key="script:1"
            )
            self.assertFalse(quiet["looked"])
            self.assertIn("look", quiet["reason"])


class Glide(unittest.TestCase):
    def test_layer_glide_is_once_and_does_not_send_node_keys(self):
        frame = dialect.tween_glide(
            32,
            "aaa",
            px="80,40,280,160",
            opacity=0.35,
            color="ffcc44",
            angle=0.4,
            ease="sine",
            dur=0.6,
        )
        text_frame = frame.decode("ascii")
        self.assertIn(
            "tween;layer=32;px=80,40,280,160;o=0.35;c=ffcc44;a=0.4;ease=sine-in-out;dur=0.6;r=aaa",
            text_frame,
        )
        self.assertNotIn("at=", text_frame)
        self.assertNotIn("node=", text_frame)
        self.assertNotIn(";id=", text_frame)
        self.assertNotIn("rot=", text_frame)
        self.assertNotIn("camera=", text_frame)
        self.assertNotIn("yoyo", text_frame)
        self.assertNotIn("repeat", text_frame)
        self.assertNotIn("tid=", text_frame)
        only = dialect.tween_glide(32, "bbb", opacity="0", tid=4)
        only_text = only.decode("ascii")
        self.assertIn("tween;layer=32;o=0;", only_text)
        self.assertNotIn("px=", only_text)
        self.assertNotIn("c=", only_text)
        self.assertNotIn("a=", only_text)
        self.assertIn(";tid=4;r=bbb", only_text)
        with self.assertRaises(ValueError):
            dialect.tween_glide(32, "aaa")
        with self.assertRaises(ValueError):
            dialect.parse_glide(px="80,40,0,160")
        with self.assertRaises(ValueError):
            dialect.parse_glide(color="0.2,0.45,0.9,1")
        with self.assertRaises(ValueError):
            dialect.parse_glide(opacity=2)
        with self.assertRaises(ValueError):
            dialect.tween_glide(0, "aaa", opacity=1)

        port = GlassScript(ops="hello,layer,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_layer(
                session="s", claims=store, port=port, tty_key="script:1", kind="glow"
            )
            self.assertTrue(shown["confirmed"])
            before = len(port.writes)
            glided = board.glide_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:1",
                px="80,40,280,160",
                opacity=0.35,
                color="ffcc44",
            )
            self.assertTrue(glided["glided"], glided)
            self.assertTrue(glided["moved"])
            self.assertTrue(glided["confirmed"])
            self.assertFalse(glided["rendered"])
            self.assertEqual(["px", "o", "c"], glided["channels"])
            self.assertEqual(32, glided["layer"])
            added = b"".join(port.writes[before:])
            self.assertIn(b"tween;layer=32;px=80,40,280,160;o=0.35;c=ffcc44;", added)
            self.assertNotIn(b"at=", added)
            self.assertNotIn(b"node=", added)
            self.assertNotIn(b";id=", added)
            self.assertNotIn(b"yoyo", added)

            store.note_group("s", 1, 40, 3)
            grouped = board.glide_layer(
                session="s", claims=store, port=port, tty_key="script:1", layer=40, opacity=0.2
            )
            self.assertTrue(grouped["glided"], grouped)
            self.assertEqual(40, grouped["layer"])
            self.assertIn(b"tween;layer=40;o=0.2;", port.writes[-1])
            defaulted = board.glide_layer(
                session="s", claims=store, port=port, tty_key="script:1", angle=0.2
            )
            self.assertEqual(32, defaulted["layer"])
            unknown = board.glide_layer(
                session="s", claims=store, port=port, tty_key="script:1", layer=99, opacity=1
            )
            self.assertFalse(unknown["glided"])
            self.assertIn("not noted", unknown["reason"])

            refused = GlassScript(ops="hello,layer,tween,remove", mode="reject-tween")
            before = len(refused.writes)
            missed = board.glide_layer(
                session="s", claims=store, port=refused, tty_key="script:1", opacity=0.2
            )
            self.assertFalse(missed["glided"])
            self.assertFalse(missed["moved"])
            self.assertFalse(missed["confirmed"])
            self.assertEqual(32, store.effect("s"))
            tween_writes = [item for item in refused.writes[before:] if b"tween;" in item]
            self.assertEqual(1, len(tween_writes))

            bare = GlassScript(ops="hello,layer,remove")
            quiet = board.glide_layer(
                session="s", claims=store, port=bare, tty_key="script:1", px="8,8,40,40"
            )
            self.assertFalse(quiet["glided"])
            self.assertFalse(any(b"tween;" in item for item in bare.writes))

            early = board.glide_layer(session="s", claims=store, port=port, tty_key="script:1")
            self.assertFalse(early["ok"])
            self.assertIn("needs px", early["reason"])
            missing = board.glide_layer(
                session="absent", claims=store, port=port, tty_key="script:1", opacity=1
            )
            self.assertFalse(missing["glided"])
            self.assertIn("no overlay", missing["reason"])


class Model(unittest.TestCase):
    def test_fixture_is_a_version_2_glb(self):
        blob = model.triangle_glb(animated=True)
        self.assertTrue(blob.startswith(b"glTF"))
        self.assertEqual(int.from_bytes(blob[4:8], "little"), 2)
        self.assertLess(len(blob), 256 * 1024)

    def test_asset_id_stays_under_picture_base(self):
        frame = dialect.asset(1, "abc", data=b"glTF")
        self.assertIn(b"asset;id=1;t=d;r=abc;", frame)
        with self.assertRaises(ValueError):
            dialect.asset(0x16000000, "abc", data=b"glTF")
        with self.assertRaises(ValueError):
            dialect.play(1, "abc")

    def test_gltf_mesh_is_a_kind_object(self):
        payload = json.loads(dialect.gltf_payload(7))
        mesh = payload["scene"]["nodes"][0]["mesh"]
        self.assertEqual(mesh, {"kind": "gltf", "asset": 7})
        self.assertNotIn("chrome", payload["scene"]["nodes"][0])
        mercury = json.loads(dialect.gltf_payload(7, chrome=1, liquid=0.6, clear=(0, 0, 0, 1)))
        node = mercury["scene"]["nodes"][0]
        self.assertEqual(node["chrome"], 1)
        self.assertEqual(node["liquid"], 0.6)
        self.assertEqual(node["mesh"]["kind"], "gltf")
        with self.assertRaises(ValueError):
            dialect.scene_payload("gltf", "#ff8000")

    def test_bad_path_writes_nothing(self):
        port = GlassScript(ops="hello,asset,scene,play")
        result = board.show_model(session="m", path="/no/such/model.glb", claims=claims_mod.Claims(Path("/tmp/unused")), port=port)
        self.assertFalse(result["ok"])
        self.assertFalse(result["uploaded"])
        self.assertFalse(result["played"])
        self.assertEqual(port.writes, [])

    def test_refused_asset_does_not_send_a_scene(self):
        port = GlassScript(mode="reject-asset", ops="hello,asset,scene,play,remove")
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "triangle.glb"
            path.write_bytes(model.triangle_glb())
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            result = board.show_model(session="m", path=str(path), claims=store, tty_key="script:7", port=port, play=True)
        self.assertTrue(result["ok"])
        self.assertFalse(result["uploaded"])
        self.assertFalse(result["rendered"])
        self.assertFalse(result["played"])
        joined = b"".join(port.writes)
        self.assertIn(b"asset;", joined)
        self.assertNotIn(b"scene;", joined)
        self.assertNotIn(b"play;", joined)

    def test_model_is_uploaded_placed_and_played_only_after_each_ok(self):
        port = GlassScript(ops="hello,asset,scene,tween,play,remove")
        port.asset_extra = "nodes=1,meshes=1,clips=1,seconds=2"
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "triangle.glb"
            path.write_bytes(model.triangle_glb(animated=True))
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            quiet_port = GlassScript(ops="hello,asset,scene,play,remove")
            quiet = board.show_model(session="m", path=str(path), claims=store, tty_key="script:8", port=quiet_port)
            shown = board.show_model(
                session="m",
                path=str(path),
                claims=store,
                tty_key="script:8",
                port=port,
                play=True,
                clip="0",
                spin=True,
            )
        self.assertTrue(quiet["rendered"])
        self.assertFalse(quiet["played"])
        self.assertNotIn(b"play;", b"".join(quiet_port.writes))
        self.assertTrue(shown["uploaded"])
        self.assertTrue(shown["rendered"])
        self.assertTrue(shown["confirmed"])
        self.assertTrue(shown["played"])
        self.assertTrue(shown["moved"])
        self.assertEqual(shown["placement"], "scene")
        self.assertEqual(shown["clips"], 1)
        self.assertEqual(shown["seconds"], [2.0])
        self.assertLess(shown["asset"], 0x16000000)
        joined = b"".join(port.writes)
        self.assertIn(b"t=d;", joined)
        body = json.loads(dialect.scene_body(joined))
        self.assertEqual(body["scene"]["nodes"][0]["mesh"]["kind"], "gltf")
        self.assertEqual(body["scene"]["nodes"][0]["mesh"]["asset"], shown["asset"])
        self.assertIn(b"play;id=", joined)
        self.assertIn(b"clip=0", joined)

    def test_second_model_reuses_the_asset_id(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "triangle.glb"
            path.write_bytes(model.triangle_glb())
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            first_port = GlassScript(ops="hello,asset,scene,remove")
            second_port = GlassScript(ops="hello,asset,scene,remove")
            board.show_model(session="m", path=str(path), claims=store, tty_key="script:9", port=first_port)
            board.show_model(session="m", path=str(path), claims=store, tty_key="script:9", port=second_port)
        first = b"".join(first_port.writes)
        second = b"".join(second_port.writes)
        self.assertIn(b"asset;id=1;", first)
        self.assertIn(b"asset;id=1;", second)

    def test_no_clips_does_not_send_play(self):
        port = GlassScript(ops="hello,asset,scene,play,remove")
        port.asset_extra = "nodes=1,meshes=1,clips=0"
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "triangle.glb"
            path.write_bytes(model.triangle_glb())
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            result = board.show_model(session="m", path=str(path), claims=store, tty_key="script:10", port=port, play=True)
        self.assertTrue(result["rendered"])
        self.assertFalse(result["played"])
        self.assertNotIn(b"play;", b"".join(port.writes))
        self.assertIn("no clips", result["reason"])

    def test_large_glb_is_a_path_not_inline_bytes(self):
        port = GlassScript(ops="hello,asset,scene,remove")
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "wide.glb"
            path.write_bytes(b"glTF" + (2).to_bytes(4, "little") + b"\x00" * (256 * 1024))
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            result = board.show_model(session="m", path=str(path), claims=store, tty_key="script:11", port=port)
        self.assertTrue(result["uploaded"])
        self.assertEqual(result["medium"], "f")
        joined = b"".join(port.writes)
        self.assertIn(b"t=f;", joined)
        self.assertNotIn(b"t=d;", joined)
        self.assertLess(len(joined), 20000)

    def test_external_gltf_and_symlink_are_refused_before_write(self):
        port = GlassScript(ops="hello,asset,scene")
        with tempfile.TemporaryDirectory() as tmp:
            gltf = Path(tmp) / "ext.gltf"
            gltf.write_text('{"asset":{"version":"2.0"},"buffers":[{"uri":"mesh.bin","byteLength":4}]}', encoding="utf-8")
            link = Path(tmp) / "link.glb"
            target = Path(tmp) / "triangle.glb"
            target.write_bytes(model.triangle_glb())
            link.symlink_to(target)
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            external = board.show_model(session="m", path=str(gltf), claims=store, port=port)
            linked = board.show_model(session="m", path=str(link), claims=store, port=port)
        self.assertFalse(external["ok"])
        self.assertIn("external", external["reason"])
        self.assertFalse(linked["ok"])
        self.assertIn("symlink", linked["reason"])
        self.assertEqual(port.writes, [])

    def test_play_needs_a_scene_and_does_not_claim_a_pause_as_played(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            missing_port = GlassScript()
            missing = board.play_scene(session="m", claims=store, port=missing_port, clip="0")
            self.assertFalse(missing["played"])
            self.assertEqual(missing_port.writes, [])
            scene_port = GlassScript(ops="hello,scene,remove,showcase,play")
            board.show_scene(session="m", mesh="cube", claims=store, tty_key="script:12", port=scene_port)
            play_port = GlassScript(ops="hello,play")
            paused = board.play_scene(session="m", claims=store, tty_key="script:12", port=play_port, pause=True)
            empty = board.play_scene(session="m", claims=store, tty_key="script:12", port=GlassScript(ops="hello,play"))
        self.assertIn("no scene", missing["reason"])
        self.assertTrue(paused["paused"])
        self.assertFalse(paused["played"])
        self.assertIn(b"pause=1", b"".join(play_port.writes))
        self.assertFalse(empty["ok"])
        self.assertIn("play needs", empty["reason"])




class VideoFrame(unittest.TestCase):
    def test_sized_panel_and_progress_are_confirmed_only_after_ok(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            port = GlassScript(ops="hello,showcase,frame,progress,remove")
            shown = board.show_frame(
                session="v", claims=store, port=port, tty_key="script:v", width=8, height=4, t=0.5
            )
            quiet_port = GlassScript(ops="hello,showcase,frame,progress")
            quiet = board.show_frame(
                session="quiet", claims=store, port=quiet_port, tty_key="script:q", width=8, height=4
            )
        self.assertTrue(shown["opened"] and shown["rendered"] and shown["confirmed"] and shown["seeked"])
        self.assertEqual(shown["placement"], "video")
        self.assertEqual(shown["pixels"], "8x4")
        joined = b"".join(port.writes)
        showcase = joined.split(b"showcase;", 1)[1].split(b"\x1b", 1)[0]
        self.assertIn(b"s=8;v=4;", showcase)
        self.assertNotIn(b"id=", showcase)
        self.assertIn(b"frame;f=32;s=8;v=4;", joined)
        self.assertIn(b"progress;t=0.5;", joined)
        payload = joined.split(b"frame;f=32;s=8;v=4;r=", 1)[1].split(b";", 1)[1].split(b"\x1b", 1)[0]
        rgba = base64.b64decode(payload)
        self.assertEqual(rgba[16:20], b"\xff\xff\xff\xff")
        self.assertTrue(quiet["rendered"])
        self.assertFalse(quiet["seeked"])
        self.assertNotIn(b"progress;", b"".join(quiet_port.writes))

    def test_refused_panel_and_refused_frame_do_not_claim_the_picture(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            panel = GlassScript(mode="reject-place", ops="hello,showcase,frame,progress")
            missed = board.show_frame(session="v", claims=store, port=panel, tty_key="script:v", width=8, height=4, t=0.25)
            frame = GlassScript(mode="reject-frame", ops="hello,showcase,frame,progress")
            refused = board.show_frame(session="v2", claims=store, port=frame, tty_key="script:v2", width=8, height=4, t=0.25)
            bare = GlassScript(ops="hello,picture")
            hidden = board.show_frame(session="v3", claims=store, port=bare, tty_key="script:v3", width=8, height=4)
            bad = board.show_frame(session="v4", claims=store, width=8, height=4, t=1.5)
            huge = board.show_frame(session="v5", claims=store, width=640, height=360)
        self.assertFalse(missed["opened"] or missed["rendered"] or missed["seeked"])
        self.assertFalse(any(b"frame;" in item for item in panel.writes))
        self.assertTrue(refused["opened"])
        self.assertFalse(refused["rendered"] or refused["seeked"])
        self.assertFalse(any(b"progress;" in item for item in frame.writes))
        self.assertTrue(any(b"showcase;close=1;" in item for item in frame.writes))
        self.assertFalse(hidden["rendered"])
        self.assertFalse(any(b"frame;" in item or b"showcase;" in item for item in bare.writes))
        self.assertFalse(bad["ok"])
        self.assertFalse(huge["ok"])
        self.assertIn("1 MiB", huge["reason"])

    def test_clear_closes_the_video_panel(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            port = GlassScript(ops="hello,showcase,frame,progress,remove")
            board.show_frame(session="v", claims=store, port=port, tty_key="script:v", width=4, height=2)
            closed = board.clear(session="v", claims=store, port=port)
            gone = board.clear(session="missing", claims=store, port=GlassScript())
        self.assertTrue(closed["cleared"])
        self.assertIn("video panel closed", closed["reason"])
        self.assertTrue(any(b"showcase;close=1;" in item for item in port.writes))
        self.assertTrue(gone["ok"])
        self.assertIn("nothing shown", gone["reason"])

    def test_progress_is_not_sent_when_hello_omits_it(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            port = GlassScript(ops="hello,showcase,frame")
            shown = board.show_frame(session="v", claims=store, port=port, tty_key="script:v", width=4, height=2, pause=True)
        self.assertTrue(shown["rendered"])
        self.assertFalse(shown["seeked"])
        self.assertNotIn(b"progress;", b"".join(port.writes))
        self.assertIn("did not list progress", shown["reason"])


class Layer(unittest.TestCase):
    def test_glow_uses_px_and_add(self):
        frame = dialect.effect_layer(32, "glow", "layer1", x=48, y=48, width=320, height=180)
        self.assertIn(b"layer;id=32;k=glow;px=48,48,320,180;c=8844cc;add=1;r=layer1", frame)
        self.assertNotIn(b"at=", frame)
        self.assertNotIn(b";x=", frame)
        self.assertNotIn(b"k=picture", frame)

    def test_particles_do_not_send_a_stroke(self):
        frame = dialect.effect_layer(32, "particles", "p1", x=8, y=8, width=64, height=32, seed=7)
        self.assertIn(b"k=particles;", frame)
        self.assertIn(b"n=64;size=6;life=2;rise=18;sway=6;seed=7;", frame)
        self.assertNotIn(b"lw=", frame)
        self.assertNotIn(b"add=1", frame)

    def test_ring_and_prim_send_only_their_fields(self):
        ring = dialect.effect_layer(32, "ring", "r1", x=1, y=2, width=3, height=4)
        prim = dialect.effect_layer(32, "prim", "p2", x=1, y=2, width=3, height=4, speed=1.5)
        self.assertIn(b"k=ring;px=1,2,3,4;c=8844cc;add=1;lw=2.5;glow=16;", ring)
        self.assertIn(b"k=prim;px=1,2,3,4;c=8844cc;shape=3;speed=1.5;", prim)
        self.assertNotIn(b"n=", prim)
        self.assertNotIn(b"lw=", prim)

    def test_unused_field_and_picture_kind_are_refused(self):
        with self.assertRaises(ValueError):
            dialect.effect_layer(32, "glow", "bad", x=1, y=1, width=2, height=2, count=4)
        with self.assertRaises(ValueError):
            dialect.effect_layer(32, "picture", "bad", x=1, y=1, width=2, height=2)
        with self.assertRaises(ValueError):
            dialect.effect_layer(32, "glow", "bad", x=1, y=1, width=2, height=2, opacity=2)

    def test_layer_confirms_only_after_ok(self):
        port = GlassScript(ops="hello,layer,remove,scene,showcase")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_layer(session="s", claims=store, port=port, tty_key="script:1")
            self.assertTrue(shown["rendered"])
            self.assertTrue(shown["confirmed"])
            self.assertEqual("layer", shown["placement"])
            self.assertEqual("glow", shown["kind"])
            self.assertEqual(32, shown["program_id"])
            self.assertEqual(32, store.effect("s"))
            self.assertIsNone(store.kind("s"))
            joined = b"".join(port.writes)
            self.assertIn(b"layer;id=32;k=glow;px=48,48,320,180;c=8844cc;add=1;", joined)
            self.assertNotIn(b"showcase;", joined)

    def test_missing_layer_op_is_not_written(self):
        port = GlassScript(ops="hello,picture,showcase")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_layer(session="s", claims=store, port=port, tty_key="script:2")
            self.assertFalse(shown["rendered"])
            self.assertFalse(shown["confirmed"])
            self.assertIsNone(store.effect("s"))
            self.assertFalse(any(b"layer;" in item for item in port.writes))

    def test_refused_layer_is_not_claimed(self):
        port = GlassScript(mode="reject-place", ops="hello,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_layer(session="s", claims=store, port=port, tty_key="script:3")
            self.assertFalse(shown["rendered"])
            self.assertFalse(shown["confirmed"])
            self.assertIsNone(store.effect("s"))
            self.assertTrue(any(b"layer;" in item for item in port.writes))

    def test_clear_removes_only_the_overlay(self):
        port = GlassScript(ops="hello,layer,remove,scene,showcase")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            board.show_layer(session="s", claims=store, port=port, tty_key="script:4")
            cleared = board.clear(session="s", claims=store, port=port)
            self.assertTrue(cleared["cleared"])
            self.assertEqual("layer removed", cleared["reason"])
            joined = b"".join(port.writes)
            self.assertIn(b"remove;id=32;", joined)
            self.assertNotIn(b"showcase;close=1", joined)

    def test_layer_stays_over_a_scene_until_clear(self):
        port = GlassScript(ops="hello,scene,tween,remove,showcase,layer")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            scene = board.show_scene(session="s", mesh="cube", claims=store, port=port, tty_key="script:5")
            self.assertTrue(scene["confirmed"])
            picture_id, _layer = store.shown("s")
            overlay = board.show_layer(session="s", kind="ring", claims=store, port=port, tty_key="script:5")
            self.assertTrue(overlay["confirmed"])
            self.assertEqual("ring", overlay["kind"])
            self.assertEqual(picture_id, store.shown("s")[0])
            self.assertEqual("scene", store.kind("s"))
            self.assertEqual(32, store.effect("s"))
            cleared = board.clear(session="s", claims=store, port=port)
            self.assertTrue(cleared["cleared"])
            self.assertEqual("scene and layer removed", cleared["reason"])
            joined = b"".join(port.writes)
            self.assertIn(b"k=ring;", joined)
            self.assertIn(b"remove;id=32;", joined)

class View(unittest.TestCase):
    def test_model_panel_uses_size_not_a_picture_id(self):
        payload = dialect.scene_payload("gem", (1, 0.6, 0.2, 1))
        frame = dialect.view_model(payload, "view1", width=160, height=120)
        text = frame.decode("ascii")
        head = text.split("model;", 1)[1].split(";r=", 1)[0]
        self.assertTrue(head.startswith("s=160;v=120;fit=contain"))
        self.assertNotIn("id=", head)
        self.assertNotIn("px=", head)
        self.assertEqual(payload, dialect.view_body(frame))

    def test_mercury_payload_is_a_kind_not_a_string(self):
        payload = dialect.scene_payload("sphere", (0.1, 0.1, 0.12, 1), chrome=1, liquid=0.6, segments=48)
        frame = dialect.view_model(payload, "view2", width=80, height=40, fit="width")
        body = dialect.view_body(frame)
        self.assertIn(b'"kind":"sphere"', body)
        self.assertNotIn(b'"mesh":"sphere"', body)
        self.assertIn(b"fit=width", frame)
        self.assertNotIn(b"id=", frame.split(b";r=")[0])

    def test_missing_model_op_is_not_written(self):
        port = GlassScript(ops="hello,scene,showcase")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_view(session="s", claims=store, port=port, tty_key="script:1")
        self.assertFalse(shown["opened"])
        self.assertFalse(shown["rendered"])
        self.assertFalse(shown["confirmed"])
        self.assertFalse(any(b"model;" in item for item in port.writes))

    def test_refused_model_is_not_claimed(self):
        port = GlassScript(mode="reject-model", ops="hello,model,showcase,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_view(session="s", mesh="cube", claims=store, port=port, tty_key="script:1")
            self.assertFalse(shown["opened"])
            self.assertFalse(shown["rendered"])
            self.assertFalse(shown["confirmed"])
            self.assertNotEqual("view", store.kind("s"))
            closed = board.clear(session="s", claims=store, port=port)
        self.assertFalse(closed["cleared"])

    def test_confirmed_only_after_ok_and_clear_closes_the_panel(self):
        port = GlassScript(ops="hello,model,showcase,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_view(
                session="s",
                mesh="gem",
                claims=store,
                port=port,
                tty_key="script:1",
                width=160,
                height=120,
            )
            self.assertTrue(shown["opened"])
            self.assertTrue(shown["rendered"])
            self.assertTrue(shown["confirmed"])
            self.assertEqual("view", shown["placement"])
            self.assertEqual("view", store.kind("s"))
            self.assertFalse(shown["moved"])
            closed = board.clear(session="s", claims=store, port=port)
        self.assertTrue(closed["cleared"])
        self.assertEqual("model panel closed", closed["reason"])
        self.assertTrue(any(b"showcase;close=1" in item for item in port.writes))

    def test_court_parents_later_nodes_and_keeps_the_ground_matte(self):
        port = GlassScript(ops="hello,model,showcase,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_view(
                session="s",
                stage="court",
                finish="mercury",
                claims=store,
                port=port,
                tty_key="script:1",
            )
        self.assertTrue(shown["confirmed"])
        self.assertEqual(3, shown["nodes"])
        self.assertEqual("court", shown["stage"])
        body = dialect.view_body(b"".join(port.writes))
        ground = body.split(b'"id":1', 1)[1].split(b'"id":2', 1)[0]
        self.assertEqual(2, body.count(b'"parent":1'))
        self.assertIn(b'"kind":"sphere"', body)
        self.assertNotIn(b'"chrome"', ground)
        head = b"".join(port.writes).split(b"model;", 1)[1].split(b";r=", 1)[0]
        self.assertNotIn(b"px=", head)
        self.assertNotIn(b"id=", head)

    def test_bad_fit_and_mixed_stage_are_refused_before_a_write(self):
        port = GlassScript(ops="hello,model,showcase")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            bad_fit = board.show_view(session="s", claims=store, port=port, tty_key="script:1", fit="cover")
            mixed = board.show_view(
                session="s",
                claims=store,
                port=port,
                tty_key="script:1",
                stage="court",
                pieces="cube;gem",
            )
        self.assertFalse(bad_fit["ok"])
        self.assertFalse(mixed["ok"])
        self.assertFalse(port.writes)

    def test_view_does_not_remove_an_overlay(self):
        port = GlassScript(ops="hello,model,layer,remove,showcase")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            board.show_layer(session="s", claims=store, port=port, tty_key="script:1")
            shown = board.show_view(session="s", claims=store, port=port, tty_key="script:1")
            self.assertTrue(shown["confirmed"])
            self.assertEqual(32, store.effect("s"))
            self.assertEqual("view", store.kind("s"))

    def test_group_hud_is_one_op_of_px_records(self):
        port = GlassScript(ops="hello,group,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_group(
                session="s",
                claims=store,
                stage="hud",
                port=port,
                tty_key="script:1",
            )
            self.assertTrue(shown["rendered"])
            self.assertTrue(shown["confirmed"])
            self.assertEqual("group", shown["placement"])
            self.assertEqual(3, shown["count"])
            self.assertEqual(1, shown["group_id"])
            self.assertEqual(40, shown["first"])
            self.assertEqual(42, shown["last"])
            self.assertEqual("hud", shown["stage"])
            self.assertEqual((1, 40, 3), store.group("s"))
            self.assertIsNone(store.effect("s"))
            joined = b"".join(port.writes)
            self.assertIn(b"group;g=1;n=3;", joined)
            self.assertNotIn(b"layer;", joined)
            encoded = joined.split(b"group;g=1;n=3;r=", 1)[1].split(b";", 1)[1].split(b"\x1b", 1)[0]
            payload = base64.b64decode(encoded).decode("ascii")
            lines = payload.split("\n")
            self.assertEqual(3, len(lines))
            self.assertTrue(lines[0].startswith("layer;id=40;k=glow;px=48,48,180,72;c=8844cc;add=1"))
            self.assertTrue(lines[1].startswith("layer;id=41;k=ring;px=248,40,84,84;c=40b0ff;add=1"))
            self.assertTrue(lines[2].startswith("layer;id=42;k=line;px=48,132,284,8;c=ff60c0;add=1"))
            self.assertNotIn("r=", payload)
            self.assertNotIn("at=", payload)
            self.assertNotIn("picture", payload)

            replaced = board.show_group(
                session="s",
                claims=store,
                pieces="glow@12,12,40,20#ff8800",
                port=port,
                tty_key="script:1",
            )
            self.assertTrue(replaced["rendered"])
            self.assertEqual(1, replaced["count"])
            self.assertEqual((1, 40, 1), store.group("s"))
            self.assertIn(b"group;g=1;n=1;", b"".join(port.writes))
            closed = board.clear(session="s", claims=store, port=port)
            self.assertTrue(closed["cleared"])
            self.assertEqual("group removed", closed["reason"])
            self.assertTrue(any(b"remove;g=1;" in item for item in port.writes))
            self.assertTrue(any(b"remove;id=40;" in item for item in port.writes))

    def test_group_is_not_written_without_the_op_or_after_a_refusal(self):
        missing = GlassScript(ops="hello,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_group(
                session="s",
                claims=store,
                stage="hud",
                port=missing,
                tty_key="script:1",
            )
            self.assertFalse(shown["rendered"])
            self.assertFalse(shown["confirmed"])
            self.assertIsNone(shown["group_id"])
            self.assertIsNone(store.group("s"))
            self.assertFalse(any(b"group;" in item for item in missing.writes))
        refused = GlassScript(mode="reject-place", ops="hello,group,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_group(
                session="s",
                claims=store,
                pieces="ring@8,8,32,32#40b0ff",
                port=refused,
                tty_key="script:1",
            )
            self.assertFalse(shown["rendered"])
            self.assertFalse(shown["confirmed"])
            self.assertIsNone(store.group("s"))
            self.assertTrue(any(b"group;" in item for item in refused.writes))
            closed = board.clear(session="s", claims=store, port=refused)
        self.assertFalse(closed["cleared"])

    def test_bad_group_pieces_are_not_written(self):
        port = GlassScript(ops="hello,group,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            both = board.show_group(
                session="s",
                claims=store,
                stage="hud",
                pieces="glow@1,1,2,2",
                port=port,
                tty_key="script:1",
            )
            nine = ";".join(f"glow@{i},1,2,2" for i in range(9))
            too_many = board.show_group(session="s", claims=store, pieces=nine, port=port, tty_key="script:1")
            picture = board.show_group(
                session="s", claims=store, pieces="picture@1,1,2,2", port=port, tty_key="script:1"
            )
            cells = board.show_group(
                session="s",
                claims=store,
                pieces="glow@1,1,2,2;at=1,1,2,2",
                port=port,
                tty_key="script:1",
            )
        self.assertFalse(both["rendered"])
        self.assertFalse(too_many["rendered"])
        self.assertFalse(picture["rendered"])
        self.assertFalse(cells["rendered"])
        self.assertFalse(port.writes)
        self.assertIn("not both", both["reason"])

    def test_group_keeps_the_single_overlay(self):
        port = GlassScript(ops="hello,group,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            board.show_layer(session="s", claims=store, port=port, tty_key="script:1")
            shown = board.show_group(
                session="s", claims=store, stage="hud", port=port, tty_key="script:1"
            )
            self.assertTrue(shown["confirmed"])
            self.assertEqual(32, store.effect("s"))
            self.assertEqual((1, 40, 3), store.group("s"))
            closed = board.clear(session="s", claims=store, port=port)
        self.assertTrue(closed["cleared"])
        self.assertEqual("layer and group removed", closed["reason"])
        self.assertTrue(any(b"remove;id=32;" in item for item in port.writes))
        self.assertTrue(any(b"remove;id=40-42;" in item for item in port.writes))


class Events(unittest.TestCase):
    def test_events_frame_opts_in_without_opening_a_panel(self):
        frame = dialect.events_frame("abc123", enabled=True)
        self.assertIn(b"showcase;events=1;r=abc123", frame)
        self.assertNotIn(b"id=", frame)
        self.assertNotIn(b"px=", frame)
        self.assertNotIn(b"picture", frame)
        off = dialect.events_frame("abc123", enabled=False)
        self.assertIn(b"showcase;events=0;r=abc123", off)

    def test_parse_events_keeps_only_real_frames(self):
        click = dialect.apc("event;showcase;clicks=3")
        seek = dialect.apc("event;showcase;seek=0.5")
        steps = dialect.apc("event;showcase;steps=-1")
        gone = dialect.apc("event;showcase;dismissals=2") + dialect.apc("event;showcase;close=1")
        reply = dialect.apc("r=abc;OK")
        arm = dialect.events_frame("abc", enabled=True)
        buf = click + seek + steps + gone + reply + arm + b"_glass;event;showcase;copies=4\x1b\\"
        self.assertEqual(
            dialect.parse_events(buf),
            [
                {"clicks": 3},
                {"seek": 0.5},
                {"steps": -1},
                {"dismissals": 2},
                {"close": 1},
                {"copies": 4},
            ],
        )
        self.assertEqual(dialect.parse_events(dialect.apc("event;showcase;clicks=no")), [])
        self.assertEqual(dialect.parse_events(dialect.apc("event;showcase;close=2")), [])
        self.assertEqual(dialect.parse_events(dialect.apc("event;showcase;seek=1.5")), [])
        self.assertEqual(dialect.parse_events(dialect.apc("event;showcase")), [])

    def test_watch_returns_a_click_only_when_glass_wrote_one(self):
        port = GlassScript()
        port.inbox = dialect.apc("event;showcase;clicks=1")
        port.later = dialect.apc("event;showcase;clicks=3")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.watch_events(
                session="s",
                claims=store,
                port=port,
                tty_key="script:1",
                wait=0.01,
            )
            self.assertTrue(shown["ok"])
            self.assertTrue(shown["armed"])
            self.assertFalse(shown["disarmed"])
            self.assertFalse(shown["rendered"])
            self.assertFalse(shown["confirmed"])
            self.assertEqual([{"clicks": 1}, {"clicks": 3}], shown["events"])
            self.assertEqual(3, shown["clicks"])
            self.assertNotIn("closed", shown)
            self.assertTrue(store.events_armed("s"))
            joined = b"".join(port.writes)
            self.assertIn(b"showcase;events=1;r=", joined)
            self.assertNotIn(b"id=", joined)
            self.assertNotIn(b"px=", joined)

    def test_missing_showcase_is_not_written(self):
        port = GlassScript(ops="hello,picture")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.watch_events(session="s", claims=store, port=port, tty_key="script:1")
            self.assertFalse(shown["ok"])
            self.assertFalse(shown["armed"])
            self.assertEqual([], shown["events"])
            self.assertNotIn("clicks", shown)
            self.assertNotIn(b"events=", b"".join(port.writes))

    def test_refused_opt_in_is_not_armed(self):
        port = GlassScript(mode="reject-place")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.watch_events(session="s", claims=store, port=port, tty_key="script:1")
            self.assertFalse(shown["ok"])
            self.assertFalse(shown["armed"])
            self.assertIn(b"events=1", b"".join(port.writes))
            self.assertFalse(store.events_armed("s"))

    def test_events_off_is_claimed_only_after_ok(self):
        port = GlassScript()
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.watch_events(
                session="s", claims=store, port=port, tty_key="script:1", arm=False,
            )
            self.assertTrue(shown["ok"])
            self.assertFalse(shown["armed"])
            self.assertTrue(shown["disarmed"])
            self.assertIn(b"showcase;events=0;r=", b"".join(port.writes))
            self.assertFalse(store.events_armed("s"))

    def test_bad_wait_is_not_written(self):
        port = GlassScript()
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.watch_events(
                session="s", claims=store, port=port, tty_key="script:1", wait=9,
            )
            self.assertFalse(shown["ok"])
            self.assertEqual([], port.writes)

    def test_stashed_click_is_returned_once_and_group_stays(self):
        port = GlassScript()
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            board.show_group(session="s", claims=store, stage="hud", port=port, tty_key="script:1")
            store.append_events("s", [{"clicks": 2}, {"close": 1}])
            shown = board.watch_events(session="s", claims=store, port=port, tty_key="script:1")
            self.assertEqual([{"clicks": 2}, {"close": 1}], shown["events"])
            self.assertTrue(shown["closed"])
            self.assertEqual(2, shown["clicks"])
            self.assertEqual((1, 40, 3), store.group("s"))
            again = board.watch_events(session="s", claims=store, port=port, tty_key="script:1")
            self.assertEqual([], again["events"])
            self.assertNotIn("clicks", again)
            self.assertNotIn("closed", again)
            self.assertEqual((1, 40, 3), store.group("s"))

    def test_capture_does_not_stash_scripted_events_in_the_live_claim(self):
        seen = []
        old = transport._KEEPER
        transport.set_event_keeper(lambda path, events: seen.append((path, events)))
        try:
            scripted = GlassScript()
            transport._capture(scripted, dialect.apc("event;showcase;clicks=4"))
            self.assertEqual([{"clicks": 4}], scripted.kept_events)
            self.assertEqual([], seen)
            live = type("P", (), {"scripted": False, "path": "/tmp/glass-events-test", "skip_keeper": False})()
            transport._capture(live, dialect.apc("event;showcase;clicks=5"))
            self.assertEqual([("/tmp/glass-events-test", [{"clicks": 5}])], seen)
            skipped = type("P", (), {"scripted": False, "path": "/tmp/glass-events-test", "skip_keeper": True})()
            transport._capture(skipped, dialect.apc("event;showcase;clicks=6"))
            self.assertEqual(1, len(seen))
        finally:
            transport.set_event_keeper(old)


class Faces(unittest.TestCase):
    def test_die_payload_is_a_kind_roundcube_with_faces_and_edge(self):
        colors = dialect.parse_face_colors("ff0000;00ff00;0000ff;ffff00;ff00ff;ffffff")
        raw = dialect.die_payload("roundcube", colors, [101, 102, 103, 104, 105, 106])
        body = json.loads(raw)
        node = body["scene"]["nodes"][0]
        self.assertEqual({"kind": "roundcube", "radius": 0.18, "segments": 8}, node["mesh"])
        self.assertEqual([101, 102, 103, 104, 105, 106], node["faces"])
        self.assertNotIn("width", node["edge"])
        self.assertEqual(0.85, node["edge"]["glow"])
        self.assertEqual([0.9412, 0.7529, 0.251, 1.0], node["edge"]["color"])
        self.assertNotIn(b'"mesh":"roundcube"', raw)
        self.assertNotIn(b'"mesh":"sphere"', raw)

    def test_edge_width_is_refused_before_any_write(self):
        raw = dialect.die_payload("roundcube", dialect.parse_face_colors("ff0000"), [9, None, None, None, None, None])
        self.assertNotIn(b'"width"', raw)
        with self.assertRaises(ValueError):
            dialect.die_payload(
                "roundcube",
                dialect.parse_face_colors("ff0000"),
                [9, None, None, None, None, None],
                edge_width=2,
            )
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            glass = GlassScript(ops="hello,picture,scene,remove")
            result = board.show_die(
                session="a",
                claims=store,
                tty_key="tty:1",
                port=glass,
                faces="ff0000",
                edge_width=2,
            )
        self.assertFalse(result["rendered"])
        self.assertEqual([], glass.writes)
        self.assertIn("width", result["reason"])

    def test_string_cube_envelope_does_not_gain_faces(self):
        raw = dialect.scene_payload("cube", (1.0, 0.4, 0.2, 1.0))
        node = json.loads(raw)["scene"]["nodes"][0]
        self.assertEqual("cube", node["mesh"])
        self.assertNotIn("faces", node)
        self.assertNotIn("edge", node)

    def test_null_face_is_not_a_picture_and_zero_glow_omits_the_edge(self):
        colors = dialect.parse_face_colors("ff0000;none")
        raw = dialect.die_payload(
            "cube",
            colors,
            [7, None, None, None, None, None],
            radius=None,
            segments=None,
            edge_glow=0,
        )
        node = json.loads(raw)["scene"]["nodes"][0]
        self.assertEqual("cube", node["mesh"])
        self.assertEqual([7, None, None, None, None, None], node["faces"])
        self.assertNotIn("edge", node)

    def test_faces_are_confirmed_only_after_the_scene_ok(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            glass = GlassScript(ops="hello,picture,scene,tween,remove,showcase")
            result = board.show_die(session="a", claims=store, tty_key="tty:1", port=glass, faces="ff0000;00ff00")
        self.assertTrue(result["rendered"])
        self.assertTrue(result["confirmed"])
        self.assertEqual(2, result["pictures"])
        self.assertEqual(2, result["faces"])
        self.assertTrue(result["edge"])
        self.assertEqual("roundcube", result["mesh"])
        pictures = [item for item in glass.writes if b"picture;" in item]
        scenes = [item for item in glass.writes if b"scene;" in item]
        self.assertEqual(2, len(pictures))
        self.assertEqual(1, len(scenes))
        self.assertLess(glass.writes.index(pictures[-1]), glass.writes.index(scenes[0]))
        body = json.loads(dialect.scene_body(scenes[0]))
        node = body["scene"]["nodes"][0]
        self.assertEqual("roundcube", node["mesh"]["kind"])
        self.assertEqual(0.18, node["mesh"]["radius"])
        self.assertIsNone(node["faces"][2])
        self.assertTrue(all(b"f=24;s=1;v=1" in item for item in pictures))
        self.assertNotIn(b'"mesh":"roundcube"', scenes[0])

    def test_a_refused_picture_is_not_followed_by_a_scene(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            glass = GlassScript(ops="hello,picture,scene,remove", mode="reject-picture")
            result = board.show_die(session="a", claims=store, tty_key="tty:1", port=glass, faces="ff0000")
        self.assertFalse(result["rendered"])
        self.assertFalse(result["confirmed"])
        self.assertEqual(0, result["pictures"])
        self.assertTrue(any(b"picture;" in item for item in glass.writes))
        self.assertFalse(any(b"scene;" in item for item in glass.writes))

    def test_a_later_picture_refusal_removes_the_accepted_one(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            glass = GlassScript(ops="hello,picture,scene,remove")
            glass.picture_limit = 1
            result = board.show_die(session="a", claims=store, tty_key="tty:1", port=glass, faces="ff0000;00ff00")
        self.assertFalse(result["rendered"])
        self.assertEqual(0, result["faces"])
        self.assertFalse(any(b"scene;" in item for item in glass.writes))
        self.assertTrue(any(b"remove;" in item for item in glass.writes))
        self.assertEqual([], store.faces("a"))

    def test_missing_picture_op_writes_nothing(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            glass = GlassScript(ops="hello,scene,tween")
            result = board.show_die(session="a", claims=store, tty_key="tty:1", port=glass)
        self.assertFalse(result["rendered"])
        self.assertFalse(any(b"picture;" in item or b"scene;" in item for item in glass.writes))

    def test_a_refused_scene_does_not_claim_faces(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            glass = GlassScript(ops="hello,picture,scene,remove", mode="reject-scene")
            result = board.show_die(session="a", claims=store, tty_key="tty:1", port=glass, faces="ff0000")
        self.assertFalse(result["rendered"])
        self.assertEqual(0, result["faces"])
        self.assertEqual([], store.faces("a"))
        self.assertTrue(any(b"scene;" in item for item in glass.writes))
        self.assertTrue(any(b"remove;" in item for item in glass.writes))

    def test_clear_removes_the_face_pictures(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            glass = GlassScript(ops="hello,picture,scene,tween,remove,showcase")
            shown = board.show_die(session="a", claims=store, tty_key="tty:1", port=glass, faces="ff0000;00ff00")
            self.assertTrue(shown["confirmed"])
            noted = store.faces("a")
            self.assertEqual(2, len(noted))
            glass.writes.clear()
            cleared = board.clear(session="a", claims=store, port=glass)
        self.assertTrue(cleared["cleared"])
        self.assertIn("faces removed", cleared["reason"])
        removes = [item for item in glass.writes if b"remove;" in item]
        self.assertGreaterEqual(len(removes), 3)
        for face in noted:
            self.assertTrue(any(f"remove;id={face}".encode() in item for item in removes))


class Mark(unittest.TestCase):
    def _store(self, tmp):
        return claims_mod.Claims(Path(tmp) / "claims.json")

    def test_chevron_is_a_kind_object_with_vertex_colors(self):
        raw = dialect.mark_payload("chevron")
        body = json.loads(raw)
        node = body["scene"]["nodes"][0]
        mesh = node["mesh"]
        self.assertEqual("inline", mesh["kind"])
        self.assertNotIn(b'"mesh":"inline"', raw)
        self.assertEqual(12, len(mesh["positions"]))
        self.assertEqual(12, len(mesh["indices"]))
        self.assertEqual(12, len(mesh["colors"]))
        self.assertEqual(0.4, node["emissive"])
        self.assertTrue(node["lit"])
        self.assertEqual([1.8, 1.2, 2.4], body["scene"]["camera"]["eye"])
        cube = dialect.scene_payload("cube", (1.0, 0.4, 0.2, 1.0))
        self.assertNotIn(b'"kind":"inline"', cube)
        self.assertNotIn(b'"emissive"', cube)

    def test_tetra_omits_colors_and_zero_emissive_is_absent(self):
        raw = dialect.mark_payload("tetra", emissive=0)
        node = json.loads(raw)["scene"]["nodes"][0]
        self.assertEqual("inline", node["mesh"]["kind"])
        self.assertNotIn("colors", node["mesh"])
        self.assertNotIn("emissive", node)
        self.assertEqual((12, 4), dialect.mark_counts(raw))
        with self.assertRaises(ValueError):
            dialect.mark_payload("wedge")
        with self.assertRaises(ValueError):
            dialect.mark_payload("chevron", emissive=1.2)

    def test_show_mark_confirms_only_after_the_scene_ok(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        missing_port = GlassScript(mode="ok", ops="hello,tween,remove")
        refuse_port = GlassScript(mode="reject-scene", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            shown = board.show_mark(
                session="mark",
                claims=store,
                shape="chevron",
                spin=True,
                port=port,
                tty_key="script:mark",
            )
            self.assertTrue(shown["rendered"])
            self.assertTrue(shown["confirmed"])
            self.assertTrue(shown["inline"])
            self.assertTrue(shown["moved"])
            self.assertEqual("inline", shown["mesh"])
            self.assertEqual("chevron", shown["shape"])
            self.assertEqual(12, shown["vertices"])
            self.assertEqual(4, shown["triangles"])
            self.assertEqual("scene", shown["placement"])
            scene = next(item for item in port.writes if b"scene;" in item)
            node = json.loads(dialect.scene_body(scene))["scene"]["nodes"][0]
            self.assertEqual("inline", node["mesh"]["kind"])
            self.assertNotIn(b'"mesh":"inline"', scene)
            self.assertEqual(len(node["mesh"]["positions"]), len(node["mesh"]["colors"]))
            self.assertFalse(any(b"picture;" in item for item in port.writes))
            missing = board.show_mark(
                session="mark",
                claims=store,
                shape="tetra",
                port=missing_port,
                tty_key="script:mark",
            )
            refused = board.show_mark(
                session="other",
                claims=store,
                shape="chevron",
                port=refuse_port,
                tty_key="script:other",
            )
        self.assertFalse(missing["rendered"])
        self.assertFalse(missing["inline"])
        self.assertEqual(12, missing["vertices"])
        self.assertFalse(any(b"scene;" in item for item in missing_port.writes))
        self.assertFalse(refused["rendered"])
        self.assertFalse(refused["confirmed"])
        self.assertFalse(refused["inline"])
        self.assertIsNone(refused["mesh"])
        self.assertIsNone(store.path_for("other"))

    def test_bad_shape_is_refused_before_a_write(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_mark(
                session="mark",
                claims=self._store(tmp),
                shape="wedge",
                port=port,
                tty_key="script:mark",
            )
        self.assertFalse(shown["ok"])
        self.assertFalse(shown["inline"])
        self.assertEqual(0, shown["vertices"])
        self.assertEqual([], port.writes)


class FloatTests(unittest.TestCase):
    def test_glow_frame_omits_lift_unless_asked(self):
        plain = dialect.effect_layer(32, "glow", "layer1", x=48, y=48, width=320, height=180)
        lifted = dialect.effect_layer(
            32, "glow", "layer1", x=48, y=48, width=320, height=180, lift=24, breathe=12
        )
        self.assertIn(b"layer;id=32;k=glow;px=48,48,320,180;c=8844cc;add=1;r=layer1", plain)
        self.assertNotIn(b";h=", plain)
        self.assertNotIn(b";b=", plain)
        self.assertIn(b";h=24;b=12;r=layer1", lifted)
        self.assertNotIn(b"at=", lifted)

    def test_float_tween_sends_delay_only_when_asked(self):
        delayed = dialect.tween_float(32, "t1", to_lift=80, to_breathe=4, ease="sine", dur=0.6, delay=0.4)
        plain = dialect.tween_float(32, "t1", to_breathe=2, ease="spring", dur=None)
        self.assertIn(b"tween;layer=32;h=80;b=4;ease=sine-in-out;dur=0.6;delay=0.4;r=t1", delayed)
        self.assertNotIn(b"repeat", delayed)
        self.assertNotIn(b"yoyo", delayed)
        self.assertNotIn(b"node=", delayed)
        self.assertNotIn(b"camera=", delayed)
        self.assertIn(b"tween;layer=32;b=2;ease=spring(170,12);r=t1", plain)
        self.assertNotIn(b"dur=", plain)
        self.assertNotIn(b"delay=", plain)
        with self.assertRaises(ValueError):
            dialect.tween_float(32, "t1", delay=0.4)

    def test_float_confirms_only_after_ok(self):
        port = GlassScript(ops="hello,layer,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.float_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:1",
                lift=24,
                breathe=12,
                to_lift=80,
                to_breathe=4,
                delay=0.4,
                ease="sine",
                dur=0.6,
            )
            self.assertEqual(32, store.effect("s"))
        self.assertTrue(shown["ok"])
        self.assertTrue(shown["floated"])
        self.assertTrue(shown["rendered"])
        self.assertTrue(shown["confirmed"])
        self.assertTrue(shown["moved"])
        self.assertTrue(shown["delayed"])
        self.assertEqual(["lift", "breathe"], shown["channels"])
        self.assertEqual(["lift", "breathe", "delay"], shown["tween_channels"])
        joined = b"".join(port.writes)
        self.assertIn(b"layer;id=32;k=glow;px=48,48,320,180;c=8844cc;add=1;h=24;b=12;", joined)
        self.assertIn(b"tween;layer=32;h=80;b=4;ease=sine-in-out;dur=0.6;delay=0.4;", joined)
        self.assertNotIn(b"repeat=", joined)
        self.assertNotIn(b"yoyo=", joined)

    def test_placement_only_does_not_tween(self):
        port = GlassScript(ops="hello,layer,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.float_layer(
                session="s", claims=store, port=port, tty_key="script:2", lift=24, breathe=12
            )
        self.assertTrue(shown["floated"])
        self.assertTrue(shown["confirmed"])
        self.assertFalse(shown["moved"])
        self.assertFalse(shown["delayed"])
        self.assertEqual([], shown["tween_channels"])
        self.assertFalse(any(b"tween;" in item for item in port.writes))

    def test_delay_without_a_tween_is_not_written(self):
        port = GlassScript(ops="hello,layer,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.float_layer(
                session="s", claims=store, port=port, tty_key="script:3", lift=24, delay=0.4
            )
        self.assertFalse(shown["ok"])
        self.assertFalse(shown["floated"])
        self.assertEqual(shown["reason"], "delay needs a lift or a breathe to tween")
        self.assertEqual(port.writes, [])
        self.assertIsNone(store.effect("s"))

    def test_refused_layer_is_not_followed_by_a_tween(self):
        port = GlassScript(mode="reject-place", ops="hello,layer,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.float_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:4",
                lift=24,
                breathe=12,
                to_lift=80,
                delay=0.4,
            )
        self.assertFalse(shown["floated"])
        self.assertFalse(shown["moved"])
        self.assertFalse(shown["rendered"])
        self.assertIsNone(store.effect("s"))
        self.assertTrue(any(b"layer;" in item for item in port.writes))
        self.assertFalse(any(b"tween;" in item for item in port.writes))

    def test_refused_tween_keeps_the_layer_and_does_not_claim_a_move(self):
        port = GlassScript(mode="reject-tween", ops="hello,layer,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.float_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:5",
                lift=24,
                to_breathe=2,
                ease="spring",
            )
            self.assertEqual(32, store.effect("s"))
        self.assertTrue(shown["floated"])
        self.assertTrue(shown["confirmed"])
        self.assertFalse(shown["ok"])
        self.assertFalse(shown["moved"])
        self.assertFalse(shown["delayed"])
        joined = b"".join(port.writes)
        self.assertIn(b"ease=spring(170,12)", joined)
        self.assertNotIn(b";dur=", joined)
        self.assertNotIn(b"delay=", joined)

    def test_missing_tween_op_writes_nothing(self):
        port = GlassScript(ops="hello,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.float_layer(
                session="s", claims=store, port=port, tty_key="script:6", breathe=8, to_lift=10
            )
        self.assertFalse(shown["floated"])
        self.assertEqual(shown["reason"], "terminal has no tween op")
        self.assertFalse(any(b"layer;" in item for item in port.writes))
        self.assertFalse(any(b"tween;" in item for item in port.writes))
        self.assertIsNone(store.effect("s"))


class Spark(unittest.TestCase):
    def test_glow_and_float_frames_omit_flicker_and_stand(self):
        glow = dialect.effect_layer(32, "glow", x=48, y=48, width=320, height=180, token="layer1")
        lifted = dialect.effect_layer(
            32, "glow", x=48, y=48, width=320, height=180, token="layer1", lift=24, breathe=12
        )
        self.assertEqual(
            b"layer;id=32;k=glow;px=48,48,320,180;c=8844cc;add=1;r=layer1",
            glow.split(b"glass;", 1)[1].split(b"\x1b")[0],
        )
        self.assertIn(b"h=24;b=12", lifted)
        self.assertNotIn(b"fl=", glow)
        self.assertNotIn(b"stand=", glow)
        self.assertNotIn(b"fl=", lifted)
        self.assertNotIn(b"stand=", lifted)

    def test_spark_frame_sends_flicker_stand_and_a_size_tween(self):
        frame = dialect.effect_layer(
            32,
            "particles",
            x=48,
            y=48,
            width=320,
            height=180,
            token="spark1",
            color="ff8844",
            flicker=0.65,
            stand="up",
            foot="24,80",
            size=4,
            count=48,
        )
        body = frame.split(b"glass;", 1)[1].split(b"\x1b")[0]
        self.assertIn(b"k=particles", body)
        self.assertIn(b"fl=0.65", body)
        self.assertIn(b"stand=up", body)
        self.assertIn(b"up=24,80", body)
        self.assertIn(b"size=4", body)
        self.assertNotIn(b"h=", body)
        self.assertNotIn(b"b=", body)
        self.assertNotIn(b"at=", body)
        tween = dialect.tween_size(32, "spark2", to_size=18, delay=0.4, dur=0.6)
        tween_body = tween.split(b"glass;", 1)[1].split(b"\x1b")[0]
        self.assertEqual(
            b"tween;layer=32;size=18;ease=sine-in-out;dur=0.6;delay=0.4;r=spark2",
            tween_body,
        )
        self.assertNotIn(b"node=", tween)
        self.assertNotIn(b"camera=", tween)
        self.assertNotIn(b"repeat=", tween)
        self.assertNotIn(b"yoyo=", tween)
        self.assertNotIn(b";h=", tween)
        self.assertNotIn(b";b=", tween)
        spring = dialect.tween_size(32, "spark3", to_size=6, ease="spring", dur=None)
        spring_body = spring.split(b"glass;", 1)[1].split(b"\x1b")[0]
        self.assertIn(b"ease=spring(170,12)", spring_body)
        self.assertNotIn(b"dur=", spring_body)
        self.assertNotIn(b"delay=", spring_body)

    def test_bad_spark_fields_are_refused_before_a_frame(self):
        with self.assertRaises(ValueError):
            dialect.effect_layer(32, "glow", x=1, y=1, width=8, height=8, token="a", flicker=1.2)
        with self.assertRaises(ValueError):
            dialect.effect_layer(32, "glow", x=1, y=1, width=8, height=8, token="a", stand="wall")
        with self.assertRaises(ValueError):
            dialect.effect_layer(
                32, "glow", x=1, y=1, width=8, height=8, token="a", stand="floor", foot="1,2"
            )
        with self.assertRaises(ValueError):
            dialect.tween_size(32, "a", to_size=0.4)

    def test_size_tween_on_a_glow_is_not_written(self):
        port = GlassScript(ops="hello,layer,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.spark_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:spark1",
                kind="glow",
                flicker=0.4,
                to_size=12,
            )
        self.assertFalse(shown["ok"])
        self.assertFalse(shown["sparked"])
        self.assertEqual(shown["reason"], "size tween is only for particles")
        self.assertEqual(port.writes, [])

    def test_spark_places_then_tweens_size_after_the_layer_ok(self):
        port = GlassScript(ops="hello,layer,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.spark_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:spark2",
                flicker=0.65,
                stand="up",
                up="24,80",
                size=4,
                count=48,
                to_size=18,
                delay=0.4,
                dur=0.6,
            )
            self.assertEqual(32, store.effect("s"))
        self.assertTrue(shown["sparked"])
        self.assertTrue(shown["rendered"])
        self.assertTrue(shown["confirmed"])
        self.assertTrue(shown["moved"])
        self.assertTrue(shown["delayed"])
        self.assertEqual(["flicker", "stand", "foot"], shown["channels"])
        self.assertEqual(["size", "delay"], shown["tween_channels"])
        self.assertEqual("up", shown["stand"])
        self.assertEqual(0.65, shown["flicker"])
        joined = b"".join(port.writes)
        self.assertIn(b"fl=0.65", joined)
        self.assertIn(b"stand=up", joined)
        self.assertIn(b"up=24,80", joined)
        self.assertIn(b"tween;layer=32;size=18", joined)
        self.assertNotIn(b"at=", joined)
        self.assertNotIn(b"h=", joined)
        self.assertNotIn(b"b=", joined)

    def test_placement_only_does_not_tween(self):
        port = GlassScript(ops="hello,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.spark_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:spark3",
                kind="glow",
                flicker=0.4,
                stand="floor",
            )
            self.assertEqual(32, store.effect("s"))
        self.assertTrue(shown["sparked"])
        self.assertTrue(shown["confirmed"])
        self.assertFalse(shown["moved"])
        self.assertFalse(shown["delayed"])
        self.assertEqual([], shown["tween_channels"])
        joined = b"".join(port.writes)
        self.assertIn(b"fl=0.4", joined)
        self.assertIn(b"stand=floor", joined)
        self.assertNotIn(b"up=", joined)
        self.assertFalse(any(b"tween;" in item for item in port.writes))

    def test_refused_layer_is_not_followed_by_a_size_tween(self):
        port = GlassScript(mode="reject-place", ops="hello,layer,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.spark_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:spark4",
                flicker=0.5,
                stand="screen",
                to_size=12,
                delay=0.2,
            )
        self.assertFalse(shown["sparked"])
        self.assertFalse(shown["moved"])
        self.assertFalse(shown["rendered"])
        self.assertIsNone(store.effect("s"))
        self.assertTrue(any(b"layer;" in item for item in port.writes))
        self.assertFalse(any(b"tween;" in item for item in port.writes))

    def test_missing_fields_and_missing_tween_op_write_nothing(self):
        port = GlassScript(ops="hello,layer,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.spark_layer(
                session="s", claims=store, port=port, tty_key="script:spark5"
            )
        self.assertFalse(shown["sparked"])
        self.assertEqual(shown["reason"], "name a flicker or a stand")
        self.assertEqual(port.writes, [])
        port = GlassScript(ops="hello,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.spark_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:spark6",
                flicker=0.2,
                to_size=8,
            )
        self.assertFalse(shown["sparked"])
        self.assertEqual(shown["reason"], "terminal has no tween op")
        self.assertFalse(any(b"layer;" in item for item in port.writes))
        self.assertFalse(any(b"tween;" in item for item in port.writes))
        self.assertIsNone(store.effect("s"))


class Burst(unittest.TestCase):
    def test_pixel_burst_omits_anchor_and_old_frames_stay(self):
        frame = dialect.effect_layer(
            32, "particles", "burst1", x=48, y=48, width=320, height=180, burst=0.05, life=2
        )
        body = frame.split(b"glass;", 1)[1]
        self.assertIn(b"k=particles", body)
        self.assertIn(b"px=48,48,320,180", body)
        self.assertIn(b"burst=0.05", body)
        self.assertIn(b"life=2", body)
        self.assertNotIn(b"at=", body)
        self.assertNotIn(b"anchor=", body)
        self.assertNotIn(b"fl=", body)
        self.assertNotIn(b"stand=", body)
        self.assertNotIn(b"h=", body)
        self.assertNotIn(b"b=", body)
        glow = dialect.effect_layer(32, "glow", "layer1", x=48, y=48, width=320, height=180)
        self.assertEqual(
            glow,
            b"\x1b_glass;layer;id=32;k=glow;px=48,48,320,180;c=8844cc;add=1;r=layer1\x1b\\",
        )
        self.assertNotIn(b"burst=", glow)
        old = dialect.effect_layer(
            32, "particles", "p", x=48, y=48, width=320, height=180, count=64, seed=7
        )
        self.assertNotIn(b"burst=", old)
        self.assertNotIn(b"anchor=", old)

    def test_window_pin_uses_at_and_anchor(self):
        frame = dialect.effect_layer(
            32, "particles", "burst2", burst=0.2, pin="window", x=2, y=1, width=24, height=8, life=2
        )
        body = frame.split(b"glass;", 1)[1]
        self.assertIn(b"at=2,1,24,8", body)
        self.assertIn(b"anchor=window", body)
        self.assertIn(b"burst=0.2", body)
        self.assertNotIn(b"px=", body)

    def test_burst_is_refused_off_particles_and_bad_pin(self):
        with self.assertRaises(ValueError):
            dialect.effect_layer(32, "glow", "no", x=48, y=48, width=320, height=180, burst=0.1)
        with self.assertRaises(ValueError):
            dialect.effect_layer(
                32, "particles", "no", x=48, y=48, width=320, height=180, burst=0.1, pin="text"
            )
        with self.assertRaises(ValueError):
            dialect.effect_layer(32, "particles", "no", x=48, y=48, width=320, height=180, burst=-0.1)
        with self.assertRaises(ValueError):
            dialect.effect_layer(32, "particles", "no", x=48, y=48, width=320, height=180, burst=601)

    def test_scripted_pixel_burst_is_not_pinned(self):
        port = GlassScript(ops="hello,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.burst_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:burst1",
                burst=0.05,
                life=2,
            )
            self.assertEqual(32, store.effect("s"))
        self.assertTrue(shown["bursted"])
        self.assertTrue(shown["rendered"])
        self.assertTrue(shown["confirmed"])
        self.assertFalse(shown["pinned"])
        self.assertEqual(["burst"], shown["channels"])
        self.assertEqual(0.05, shown["burst"])
        self.assertEqual(2, shown["life"])
        self.assertIsNone(shown["pin"])
        joined = b"".join(port.writes)
        self.assertIn(b"burst=0.05", joined)
        self.assertIn(b"px=", joined)
        self.assertNotIn(b"anchor=", joined)
        self.assertNotIn(b"at=", joined)
        self.assertFalse(any(b"tween;" in item for item in port.writes))

    def test_scripted_window_pin(self):
        port = GlassScript(ops="hello,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.burst_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:burst2",
                burst=0.2,
                pin="window",
                x=2,
                y=1,
                width=24,
                height=8,
                life=2,
            )
        self.assertTrue(shown["bursted"])
        self.assertTrue(shown["pinned"])
        self.assertEqual("window", shown["pin"])
        self.assertEqual(["burst", "anchor"], shown["channels"])
        joined = b"".join(port.writes)
        self.assertIn(b"at=2,1,24,8", joined)
        self.assertIn(b"anchor=window", joined)
        self.assertNotIn(b"px=", joined)

    def test_missing_burst_and_missing_layer_write_nothing(self):
        port = GlassScript(ops="hello,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.burst_layer(
                session="s", claims=store, port=port, tty_key="script:burst3", burst=None
            )
        self.assertFalse(shown["bursted"])
        self.assertEqual(shown["reason"], "name a burst")
        self.assertEqual(port.writes, [])
        port = GlassScript(ops="hello,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.burst_layer(
                session="s", claims=store, port=port, tty_key="script:burst4", burst=0.05
            )
        self.assertFalse(shown["bursted"])
        self.assertEqual(shown["reason"], "terminal has no layer op")
        self.assertFalse(any(b"layer;" in item for item in port.writes))

    def test_refused_layer_is_not_claimed(self):
        port = GlassScript(mode="reject-place", ops="hello,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.burst_layer(
                session="s", claims=store, port=port, tty_key="script:burst5", burst=0.05
            )
        self.assertFalse(shown["bursted"])
        self.assertFalse(shown["rendered"])
        self.assertFalse(shown["pinned"])
        self.assertIsNone(store.effect("s"))
        self.assertTrue(any(b"layer;" in item for item in port.writes))


class Plate(unittest.TestCase):
    def test_picture_frame_uses_px_and_old_frames_stay(self):
        frame = dialect.layer_plate(
            dialect.PLATE_LAYER,
            dialect.PLATE_PICTURE,
            "plate1",
            kind="picture",
            x=48,
            y=48,
            width=160,
            height=80,
        )
        body = frame.split(b"glass;", 1)[1]
        self.assertIn(b"k=picture", body)
        self.assertIn(b"p=" + str(dialect.PLATE_PICTURE).encode(), body)
        self.assertIn(b"id=33", body)
        self.assertIn(b"px=48,48,160,80", body)
        self.assertNotIn(b"src=", body)
        self.assertNotIn(b"at=", body)
        self.assertNotIn(b"anchor=", body)
        self.assertNotIn(b"fl=", body)
        self.assertNotIn(b"burst=", body)
        self.assertNotEqual(dialect.PLATE_LAYER, dialect.PLATE_PICTURE)
        glow = dialect.effect_layer(32, "glow", "layer1", x=48, y=48, width=320, height=180)
        self.assertEqual(
            glow,
            b"\x1b_glass;layer;id=32;k=glow;px=48,48,320,180;c=8844cc;add=1;r=layer1\x1b\\",
        )
        self.assertNotIn(b"k=picture", glow)
        fallback = dialect.layer_picture(2, 1, "tok")
        self.assertEqual(
            fallback,
            b"\x1b_glass;layer;id=2;k=picture;p=1;px=24,24,480,270;r=tok\x1b\\",
        )
        with self.assertRaises(ValueError):
            dialect.effect_layer(32, "picture", "no", x=48, y=48, width=160, height=80)
        with self.assertRaises(ValueError):
            dialect.effect_layer(32, "part", "no", x=48, y=48, width=160, height=80)

    def test_part_and_window_pin_are_distinct_frames(self):
        part = dialect.layer_plate(
            33, dialect.PLATE_PICTURE, "part1", kind="part", x=48, y=48, width=160, height=80, src=(0, 0, 2, 1)
        )
        body = part.split(b"glass;", 1)[1]
        self.assertIn(b"k=part", body)
        self.assertIn(b"src=0,0,2,1", body)
        self.assertIn(b"px=48,48,160,80", body)
        self.assertNotIn(b"anchor=", body)
        pinned = dialect.layer_plate(
            33, dialect.PLATE_PICTURE, "pin1", kind="picture", x=2, y=1, width=24, height=8, pin="window"
        )
        pinned_body = pinned.split(b"glass;", 1)[1]
        self.assertIn(b"at=2,1,24,8", pinned_body)
        self.assertIn(b"anchor=window", pinned_body)
        self.assertNotIn(b"px=", pinned_body)
        self.assertNotIn(b"src=", pinned_body)

    def test_bad_plate_is_refused_before_a_frame(self):
        with self.assertRaises(ValueError):
            dialect.layer_plate(33, dialect.PLATE_PICTURE, "no", kind="glow", x=1, y=1, width=1, height=1)
        with self.assertRaises(ValueError):
            dialect.layer_plate(33, dialect.PLATE_PICTURE, "no", kind="picture", x=1, y=1, width=1, height=1, src=(0, 0, 1, 1))
        with self.assertRaises(ValueError):
            dialect.layer_plate(33, dialect.PLATE_PICTURE, "no", kind="part", x=1, y=1, width=1, height=1)
        with self.assertRaises(ValueError):
            dialect.parse_src("0,0,5,1", 4, 2)
        with self.assertRaises(ValueError):
            dialect.plate_card("ff0000;" * 8 + "00ff00")
        rgb, width, height = dialect.plate_card(None)
        self.assertEqual((4, 2, 24), (width, height, len(rgb)))

    def test_scripted_picture_is_uploaded_then_hung(self):
        port = GlassScript(ops="hello,picture,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.plate_layer(
                session="s", claims=store, port=port, tty_key="script:plate1"
            )
            self.assertEqual((dialect.PLATE_PICTURE, 33), store.plate("s"))
            self.assertIsNone(store.effect("s"))
        self.assertTrue(shown["uploaded"])
        self.assertTrue(shown["plated"])
        self.assertTrue(shown["rendered"])
        self.assertTrue(shown["confirmed"])
        self.assertFalse(shown["parted"])
        self.assertFalse(shown["pinned"])
        self.assertEqual(["picture"], shown["channels"])
        self.assertEqual(dialect.PLATE_PICTURE, shown["picture"])
        self.assertEqual(33, shown["layer"])
        self.assertEqual(4, shown["card_width"])
        self.assertEqual(2, shown["card_height"])
        self.assertIsNone(shown["src"])
        joined = b"".join(port.writes)
        self.assertIn(b"picture;id=" + str(dialect.PLATE_PICTURE).encode(), joined)
        self.assertIn(b"k=picture", joined)
        self.assertIn(b"px=", joined)
        self.assertNotIn(b"k=part", joined)
        self.assertNotIn(b"anchor=", joined)
        self.assertFalse(any(b"tween;" in item for item in port.writes))
        self.assertLess(
            next(i for i, item in enumerate(port.writes) if b"picture;" in item),
            next(i for i, item in enumerate(port.writes) if b"layer;" in item),
        )

    def test_scripted_part_and_window_pin(self):
        port = GlassScript(ops="hello,picture,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.plate_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:plate2",
                kind="part",
                src="0,0,2,1",
            )
        self.assertTrue(shown["parted"])
        self.assertTrue(shown["plated"])
        self.assertEqual("0,0,2,1", shown["src"])
        self.assertEqual(["picture", "src"], shown["channels"])
        self.assertIn(b"src=0,0,2,1", b"".join(port.writes))
        port = GlassScript(ops="hello,picture,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            pinned = board.plate_layer(
                session="s",
                claims=store,
                port=port,
                tty_key="script:plate3",
                pin="window",
                x=2,
                y=1,
                width=24,
                height=8,
            )
        self.assertTrue(pinned["pinned"])
        self.assertFalse(pinned["parted"])
        self.assertEqual(["picture", "anchor"], pinned["channels"])
        body = b"".join(port.writes)
        self.assertIn(b"at=2,1,24,8", body)
        self.assertIn(b"anchor=window", body)
        self.assertNotIn(b"px=", body)

    def test_bad_args_and_missing_ops_write_nothing(self):
        port = GlassScript(ops="hello,picture,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.plate_layer(
                session="s", claims=store, port=port, tty_key="script:plate4", kind="part"
            )
        self.assertFalse(shown["plated"])
        self.assertEqual(shown["reason"], "part needs src")
        self.assertEqual(port.writes, [])
        port = GlassScript(ops="hello,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.plate_layer(session="s", claims=store, port=port, tty_key="script:plate5")
        self.assertEqual(shown["reason"], "terminal has no picture op")
        self.assertFalse(any(b"picture;" in item for item in port.writes))
        port = GlassScript(ops="hello,picture,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.plate_layer(session="s", claims=store, port=port, tty_key="script:plate6")
        self.assertEqual(shown["reason"], "terminal has no layer op")
        self.assertFalse(any(b"picture;" in item for item in port.writes))
        self.assertFalse(any(b"layer;" in item for item in port.writes))

    def test_refused_picture_is_not_followed_by_a_layer(self):
        port = GlassScript(mode="reject-picture", ops="hello,picture,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.plate_layer(session="s", claims=store, port=port, tty_key="script:plate7")
            self.assertIsNone(store.plate("s"))
        self.assertFalse(shown["uploaded"])
        self.assertFalse(shown["plated"])
        self.assertTrue(any(b"picture;" in item for item in port.writes))
        self.assertFalse(any(b"layer;" in item for item in port.writes))

    def test_refused_layer_removes_the_picture_and_is_not_claimed(self):
        port = GlassScript(mode="reject-place", ops="hello,picture,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.plate_layer(session="s", claims=store, port=port, tty_key="script:plate8")
            self.assertIsNone(store.plate("s"))
        self.assertFalse(shown["uploaded"])
        self.assertFalse(shown["plated"])
        self.assertFalse(shown["confirmed"])
        self.assertTrue(any(b"picture;" in item for item in port.writes))
        self.assertTrue(any(b"layer;" in item for item in port.writes))
        self.assertTrue(any(b"remove;" in item for item in port.writes))

    def test_clear_removes_the_plate_and_rebind_keeps_it(self):
        port = GlassScript(ops="hello,picture,layer,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.plate_layer(session="s", claims=store, port=port, tty_key="script:plate9")
            self.assertTrue(shown["plated"])
            store.acquire("s", "script:plate9", "script:plate9")
            self.assertEqual((dialect.PLATE_PICTURE, 33), store.plate("s"))
            cleared = board.clear(session="s", claims=store, port=port)
        self.assertTrue(cleared["cleared"])
        self.assertEqual("plate removed", cleared["reason"])
        joined = b"".join(port.writes)
        self.assertIn(b"remove;id=33", joined)
        self.assertIn(b"remove;id=" + str(dialect.PLATE_PICTURE).encode(), joined)


class Wrap(unittest.TestCase):
    def _store(self, tmp):
        return claims_mod.Claims(Path(tmp) / "claims.json")

    def test_wrap_payload_cites_the_picture_and_omits_linear(self):
        raw = dialect.wrap_payload("plane", (1, 1, 1, 1), dialect.WRAP_PICTURE)
        node = json.loads(raw)["scene"]["nodes"][0]
        self.assertEqual(dialect.WRAP_PICTURE, node["picture"])
        self.assertEqual("plane", node["mesh"])
        self.assertNotIn("sampling", node)
        self.assertNotEqual(dialect.PLATE_PICTURE, node["picture"])
        nearest = json.loads(dialect.wrap_payload("quad", (1, 1, 1, 1), dialect.WRAP_PICTURE, sampling="nearest"))
        self.assertEqual("nearest", nearest["scene"]["nodes"][0]["sampling"])
        orange = json.loads(dialect.scene_payload("cube", (1.0, 0.4, 0.2, 1.0)))["scene"]["nodes"][0]
        self.assertNotIn("picture", orange)

    def test_wrap_is_confirmed_only_after_the_scene_ok(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            port = GlassScript(ops="hello,picture,scene,tween,remove,showcase")
            shown = board.wrap_scene(session="s", claims=store, port=port, tty_key="script:wrap1")
        self.assertTrue(shown["wrapped"])
        self.assertTrue(shown["uploaded"])
        self.assertTrue(shown["rendered"])
        self.assertTrue(shown["confirmed"])
        self.assertFalse(shown["nearest"])
        self.assertFalse(shown["moved"])
        self.assertEqual("linear", shown["sampling"])
        self.assertEqual(dialect.WRAP_PICTURE, shown["texture"])
        self.assertEqual(["picture"], shown["channels"])
        joined = b"".join(port.writes)
        self.assertIn(b"picture;id=" + str(dialect.WRAP_PICTURE).encode(), joined)
        scene = next(item for item in port.writes if b"scene;" in item)
        node = json.loads(dialect.scene_body(scene))["scene"]["nodes"][0]
        self.assertEqual(dialect.WRAP_PICTURE, node["picture"])
        self.assertNotIn("sampling", node)

    def test_nearest_is_sent_only_when_asked(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            port = GlassScript(ops="hello,picture,scene,tween,remove,showcase")
            shown = board.wrap_scene(
                session="s",
                claims=store,
                port=port,
                tty_key="script:wrap2",
                sampling="nearest",
            )
        self.assertTrue(shown["nearest"])
        self.assertEqual(["picture", "sampling"], shown["channels"])
        joined = b"".join(port.writes)
        scene = next(item for item in port.writes if b"scene;" in item)
        node = json.loads(dialect.scene_body(scene))["scene"]["nodes"][0]
        self.assertEqual("nearest", node["sampling"])

    def test_a_refused_picture_is_not_followed_by_a_scene(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            port = GlassScript(mode="reject-wrap-picture", ops="hello,picture,scene,remove")
            shown = board.wrap_scene(session="s", claims=store, port=port, tty_key="script:wrap3")
        self.assertFalse(shown["wrapped"])
        self.assertFalse(shown["uploaded"])
        self.assertFalse(shown["confirmed"])
        joined = b"".join(port.writes)
        self.assertIn(b"picture;", joined)
        self.assertNotIn(b"scene;", joined)

    def test_a_refused_scene_removes_the_picture_and_is_not_claimed(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            port = GlassScript(mode="reject-wrap-scene", ops="hello,picture,scene,remove")
            shown = board.wrap_scene(session="s", claims=store, port=port, tty_key="script:wrap4")
            self.assertFalse(shown["wrapped"])
            self.assertFalse(shown["confirmed"])
            store.acquire("s", "script:wrap4", "script:wrap4")
            self.assertIsNone(store.shown("s")[0])
            self.assertIsNone(store.wrap("s"))
        joined = b"".join(port.writes)
        self.assertIn(b"scene;", joined)
        self.assertIn(b"remove;id=" + str(dialect.WRAP_PICTURE).encode(), joined)

    def test_clear_removes_only_the_wrap(self):
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            port = GlassScript(ops="hello,picture,scene,tween,remove,showcase")
            shown = board.wrap_scene(session="s", claims=store, port=port, tty_key="script:wrap5")
            self.assertTrue(shown["wrapped"])
            store.acquire("s", "script:wrap5", "script:wrap5")
            self.assertEqual(dialect.WRAP_PICTURE, store.wrap("s"))
            cleared = board.clear(session="s", claims=store, port=port)
        self.assertTrue(cleared["cleared"])
        self.assertEqual("scene and wrap removed", cleared["reason"])
        joined = b"".join(port.writes)
        self.assertIn(b"remove;id=" + str(dialect.WRAP_PICTURE).encode(), joined)


def _tiny_png(width: int = 2, height: int = 2) -> bytes:
    import struct
    import zlib

    def chunk(tag: bytes, data: bytes) -> bytes:
        return (
            struct.pack(">I", len(data))
            + tag
            + data
            + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF)
        )

    raw = b"".join(b"\x00" + b"\xff\x80\x20" * width for _ in range(height))
    ihdr = struct.pack(">IIBBBBB", width, height, 8, 2, 0, 0, 0)
    return b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", ihdr) + chunk(b"IDAT", zlib.compress(raw)) + chunk(b"IEND", b"")


class Card(unittest.TestCase):
    def _store(self, tmp):
        return claims_mod.Claims(Path(tmp) / "claims.json")

    def _png(self, tmp, name="card.png"):
        path = Path(tmp) / name
        path.write_bytes(_tiny_png())
        return path

    def test_named_file_frame_uses_f100_and_omits_z_and_src(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = self._png(tmp)
            port = GlassScript()
            store = self._store(tmp)
            shown = board.card_layer(
                session="s", path=str(path), claims=store, port=port, tty_key="script:card1"
            )
            self.assertEqual((dialect.CARD_PICTURE, dialect.CARD_LAYER), store.card("s"))
        self.assertTrue(shown["carded"])
        self.assertTrue(shown["uploaded"])
        self.assertTrue(shown["named"])
        self.assertTrue(shown["rendered"])
        self.assertTrue(shown["confirmed"])
        self.assertFalse(shown["depth"])
        self.assertFalse(shown["pinned"])
        self.assertIsNone(shown["z"])
        self.assertEqual("png", shown["format"])
        self.assertEqual(dialect.CARD_PICTURE, shown["picture"])
        self.assertEqual(dialect.CARD_LAYER, shown["layer"])
        self.assertEqual(["picture"], shown["channels"])
        joined = b"".join(port.writes)
        self.assertIn(b"picture;id=335544323;f=100;", joined)
        self.assertIn(b"layer;id=34;k=picture;p=335544323;px=48,48,160,80;", joined)
        self.assertNotIn(b"f=24", joined)
        self.assertNotIn(b"src=", joined)
        self.assertNotIn(b";z=", joined)
        self.assertNotIn(b"at=", joined)
        self.assertNotIn(b"anchor=", joined)
        self.assertNotEqual(dialect.CARD_PICTURE, dialect.PLATE_PICTURE)
        self.assertNotEqual(dialect.CARD_PICTURE, dialect.WRAP_PICTURE)
        self.assertNotEqual(dialect.CARD_LAYER, dialect.PLATE_LAYER)

    def test_z_is_sent_only_when_it_is_not_zero(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = self._png(tmp)
            port = GlassScript()
            store = self._store(tmp)
            shown = board.card_layer(
                session="s", path=str(path), z=-8, claims=store, port=port, tty_key="script:cardz"
            )
            flat_port = GlassScript()
            flat = board.card_layer(
                session="s", path=str(path), z=0, claims=store, port=flat_port, tty_key="script:cardz"
            )
        self.assertTrue(shown["depth"])
        self.assertEqual(-8, shown["z"])
        self.assertEqual(["picture", "z"], shown["channels"])
        self.assertIn(b"z=-8", b"".join(port.writes))
        self.assertFalse(flat["depth"])
        self.assertIsNone(flat["z"])
        self.assertNotIn(b";z=", b"".join(flat_port.writes))

    def test_zero_depth_frame_omits_z(self):
        frame = dialect.layer_card(
            dialect.CARD_LAYER,
            dialect.CARD_PICTURE,
            "a",
            x=48,
            y=48,
            width=160,
            height=80,
            z=0,
        )
        self.assertNotIn(b";z=", frame)
        raised = dialect.layer_card(
            dialect.CARD_LAYER,
            dialect.CARD_PICTURE,
            "a",
            x=2,
            y=1,
            width=24,
            height=8,
            z=4,
            pin="window",
        )
        self.assertIn(b"at=2,1,24,8", raised)
        self.assertIn(b"anchor=window", raised)
        self.assertIn(b"z=4", raised)
        self.assertNotIn(b"px=", raised)
        self.assertNotIn(b"src=", raised)

    def test_plate_frame_is_unchanged(self):
        frame = dialect.layer_plate(
            dialect.PLATE_LAYER,
            dialect.PLATE_PICTURE,
            "a",
            kind="picture",
            x=48,
            y=48,
            width=160,
            height=80,
        )
        self.assertIn(b"id=33", frame)
        self.assertIn(b"p=335544321", frame)
        self.assertNotIn(b";z=", frame)
        self.assertNotIn(b"f=100", frame)

    def test_pin_window_is_claimed_only_when_sent(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = self._png(tmp)
            port = GlassScript()
            store = self._store(tmp)
            shown = board.card_layer(
                session="s",
                path=str(path),
                pin="window",
                z=4,
                x=2,
                y=1,
                width=24,
                height=8,
                claims=store,
                port=port,
                tty_key="script:cardpin",
            )
        self.assertTrue(shown["pinned"])
        self.assertTrue(shown["depth"])
        self.assertEqual(["picture", "anchor", "z"], shown["channels"])
        joined = b"".join(port.writes)
        self.assertIn(b"at=2,1,24,8;anchor=window;z=4", joined)
        self.assertNotIn(b"px=", joined)

    def test_a_bad_path_is_refused_before_any_write(self):
        port = GlassScript()
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            missing = board.card_layer(session="s", path="", claims=store, port=port)
            self.assertFalse(missing["carded"])
            self.assertEqual([], port.writes)
            link = Path(tmp) / "link.png"
            link.symlink_to(self._png(tmp))
            linked = board.card_layer(session="s", path=str(link), claims=store, port=port)
            self.assertFalse(linked["carded"])
            self.assertEqual([], port.writes)
            hidden = board.card_layer(session="s", path="/proc/self/status", claims=store, port=port)
            self.assertFalse(hidden["carded"])
            self.assertEqual([], port.writes)
            wide = board.card_layer(session="s", path=str(self._png(tmp)), z=32768, claims=store, port=port)
            self.assertFalse(wide["carded"])
            self.assertEqual([], port.writes)
            self.assertIsNone(store.card("s"))

    def test_a_missing_picture_op_is_not_written(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = self._png(tmp)
            port = GlassScript(ops="hello,layer")
            store = self._store(tmp)
            shown = board.card_layer(
                session="s", path=str(path), claims=store, port=port, tty_key="script:cardmiss"
            )
        self.assertFalse(shown["carded"])
        self.assertFalse(shown["uploaded"])
        self.assertIn(b"hello;", b"".join(port.writes))
        self.assertNotIn(b"picture;", b"".join(port.writes))
        self.assertNotIn(b"layer;", b"".join(port.writes))

    def test_a_refused_picture_is_not_followed_by_a_layer(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = self._png(tmp)
            port = GlassScript(mode="reject-picture")
            store = self._store(tmp)
            shown = board.card_layer(
                session="s", path=str(path), claims=store, port=port, tty_key="script:cardpic"
            )
            self.assertIsNone(store.card("s"))
        self.assertFalse(shown["uploaded"])
        self.assertFalse(shown["named"])
        self.assertFalse(shown["carded"])
        joined = b"".join(port.writes)
        self.assertIn(b"picture;", joined)
        self.assertNotIn(b"layer;", joined)

    def test_a_refused_layer_removes_the_picture_and_is_not_claimed(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = self._png(tmp)
            port = GlassScript(mode="reject-place")
            store = self._store(tmp)
            shown = board.card_layer(
                session="s", path=str(path), claims=store, port=port, tty_key="script:cardlay"
            )
            self.assertIsNone(store.card("s"))
        self.assertFalse(shown["carded"])
        self.assertFalse(shown["uploaded"])
        joined = b"".join(port.writes)
        self.assertIn(b"picture;", joined)
        self.assertIn(b"layer;", joined)
        self.assertIn(b"remove;", joined)

    def test_clear_removes_only_the_card(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = self._png(tmp)
            port = GlassScript()
            store = self._store(tmp)
            shown = board.card_layer(
                session="s", path=str(path), claims=store, port=port, tty_key="script:cardclr"
            )
            self.assertTrue(shown["carded"])
            cleared = board.clear(session="s", claims=store, port=port)
        self.assertEqual("card removed", cleared["reason"])
        self.assertTrue(cleared["cleared"])
        self.assertIsNone(store.card("s"))
        joined = b"".join(port.writes)
        self.assertIn(b"remove;id=34;", joined)
        self.assertIn(b"remove;id=335544323;", joined)




class Flat(unittest.TestCase):
    def _store(self, tmp):
        return claims_mod.Claims(Path(tmp) / "claims.json")

    def test_flat_payload_sends_ortho_and_omits_fov(self):
        orange = (1.0, 0.4, 0.2, 1.0)
        cube = json.loads(dialect.scene_payload("cube", orange))
        self.assertEqual(0.9, cube["scene"]["camera"]["fov"])
        self.assertNotIn("ortho", cube["scene"]["camera"])
        raw = dialect.flat_payload("cube", orange, 2.4)
        camera = json.loads(raw)["scene"]["camera"]
        self.assertEqual(2.4, camera["ortho"])
        self.assertNotIn("fov", camera)
        self.assertEqual(cube["scene"]["nodes"], json.loads(raw)["scene"]["nodes"])
        kind = json.loads(dialect.flat_payload("sphere", orange, 1.2))
        self.assertEqual("sphere", kind["scene"]["nodes"][0]["mesh"]["kind"])
        self.assertNotIn(b'"mesh":"sphere"', dialect.flat_payload("sphere", orange, 1.2))
        for bad in (0, -1, 64.1, True, "nope", None):
            with self.assertRaises(ValueError):
                dialect.parse_ortho(bad)

    def test_show_flat_confirms_only_after_the_scene_ok(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_flat(
                session="flat",
                claims=self._store(tmp),
                ortho=2.4,
                spin=False,
                port=port,
                tty_key="script:flat",
            )
        self.assertTrue(shown["flat"])
        self.assertTrue(shown["rendered"])
        self.assertTrue(shown["confirmed"])
        self.assertFalse(shown["moved"])
        self.assertFalse(shown["perspective"])
        self.assertEqual(2.4, shown["ortho"])
        self.assertEqual(["ortho"], shown["channels"])
        self.assertEqual("scene", shown["placement"])
        scene = next(item for item in port.writes if b"scene;" in item)
        self.assertIn(b"px=", scene)
        self.assertNotIn(b"at=", scene)
        body = json.loads(dialect.scene_body(scene))
        self.assertEqual(2.4, body["scene"]["camera"]["ortho"])
        self.assertNotIn("fov", body["scene"]["camera"])
        self.assertNotIn(b'"ortho"', dialect.scene_payload("cube", (1.0, 0.4, 0.2, 1.0)))

    def test_spin_is_moved_only_after_the_tween_ok(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_flat(
                session="flat",
                claims=self._store(tmp),
                mesh="gem",
                ortho=1.2,
                spin=True,
                port=port,
                tty_key="script:flatspin",
            )
        self.assertTrue(shown["flat"])
        self.assertTrue(shown["moved"])
        scene = next(item for item in port.writes if b"scene;" in item)
        tween = next(item for item in port.writes if b"tween;" in item)
        self.assertLess(port.writes.index(scene), port.writes.index(tween))
        camera = json.loads(dialect.scene_body(scene))["scene"]["camera"]
        self.assertEqual(1.2, camera["ortho"])
        self.assertNotIn("fov", camera)
        self.assertIn(b"repeat=forever", tween)
        self.assertIn(b"yoyo=1", tween)

    def test_a_bad_ortho_is_refused_before_any_write(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_flat(
                session="flat",
                claims=self._store(tmp),
                ortho=0,
                port=port,
                tty_key="script:flatbad",
            )
        self.assertFalse(shown["flat"])
        self.assertFalse(shown["rendered"])
        self.assertIsNone(shown["ortho"])
        self.assertIsNone(shown["perspective"])
        self.assertEqual([], port.writes)

    def test_a_missing_scene_op_is_not_written(self):
        port = GlassScript(mode="ok", ops="hello,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_flat(
                session="flat",
                claims=self._store(tmp),
                ortho=2.4,
                port=port,
                tty_key="script:flatmiss",
            )
        self.assertFalse(shown["flat"])
        self.assertFalse(shown["confirmed"])
        self.assertFalse(any(b"scene;" in item for item in port.writes))

    def test_a_refused_scene_is_not_claimed(self):
        port = GlassScript(mode="reject-scene", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            shown = board.show_flat(
                session="flat",
                claims=store,
                ortho=2.4,
                port=port,
                tty_key="script:flatref",
            )
            self.assertFalse(shown["flat"])
            self.assertFalse(shown["confirmed"])
            self.assertIsNone(shown["ortho"])
            store.acquire("s", "script:flatref", "script:flatref")
            self.assertIsNone(store.shown("flat")[0])
        self.assertTrue(any(b"scene;" in item for item in port.writes))


class Mist(unittest.TestCase):
    def _store(self, tmp):
        return claims_mod.Claims(Path(tmp) / "claims.json")

    def test_scene_omits_opacity_and_depth_unless_asked(self):
        plain = dialect.scene(1, b"{}", "tok", width=160, height=120, x=40, y=40)
        self.assertIn(b"scene;id=1;px=40,40,160,120;s=160;v=120;r=tok;", plain)
        self.assertNotIn(b";o=", plain)
        self.assertNotIn(b";z=", plain)
        mist = dialect.scene(1, b"{}", "tok", width=160, height=120, x=40, y=40, opacity=0.35)
        self.assertIn(b";o=0.35;r=tok;", mist)
        self.assertNotIn(b";z=", mist)
        self.assertNotIn(b"at=", mist)
        deep = dialect.scene(1, b"{}", "tok", width=8, height=8, x=0, y=0, opacity=0.2, z=-4)
        self.assertIn(b";z=-4;o=0.2;r=tok;", deep)
        self.assertEqual(b"{}", dialect.scene_body(deep))
        one = dialect.scene(1, b"{}", "tok", width=8, height=8, x=0, y=0, opacity=1, z=1)
        self.assertIn(b";z=1;o=1;r=tok;", one)
        for bad in (-0.1, 1.1, True, "nope", None):
            with self.assertRaises(ValueError):
                dialect.parse_opacity(bad)
        for bad in (True, 1.5, "1.0", 2147483648, -2147483649):
            with self.assertRaises(ValueError):
                dialect.parse_scene_z(bad)
        self.assertEqual(-4, dialect.parse_scene_z(" -4 "))
        self.assertEqual(0, dialect.parse_scene_z(0))

    def test_show_mist_confirms_only_after_the_scene_ok(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_mist(
                session="mist",
                claims=self._store(tmp),
                opacity=0.35,
                spin=False,
                port=port,
                tty_key="script:mist",
            )
        self.assertTrue(shown["misted"])
        self.assertTrue(shown["rendered"])
        self.assertTrue(shown["confirmed"])
        self.assertTrue(shown["faded"])
        self.assertFalse(shown["depth"])
        self.assertFalse(shown["moved"])
        self.assertTrue(shown["perspective"])
        self.assertEqual(0.35, shown["opacity"])
        self.assertIsNone(shown["z"])
        self.assertEqual(["o"], shown["channels"])
        self.assertEqual("scene", shown["placement"])
        scene = next(item for item in port.writes if b"scene;" in item)
        self.assertIn(b";o=0.35;", scene)
        self.assertNotIn(b";z=", scene)
        self.assertIn(b"px=", scene)
        self.assertNotIn(b"at=", scene)
        body = json.loads(dialect.scene_body(scene))
        self.assertEqual(0.9, body["scene"]["camera"]["fov"])
        self.assertNotIn("ortho", body["scene"]["camera"])
        self.assertEqual("cube", body["scene"]["nodes"][0]["mesh"])
        orange = dialect.scene_payload("cube", (1.0, 0.4, 0.2, 1.0))
        self.assertIn(b'"fov":0.9', orange)
        self.assertNotIn(b'"ortho"', orange)

    def test_depth_and_spin_are_on_the_frame_only_when_asked(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_mist(
                session="mist",
                claims=self._store(tmp),
                mesh="gem",
                opacity=0.2,
                z=-4,
                spin=True,
                port=port,
                tty_key="script:mistdeep",
            )
        self.assertTrue(shown["misted"])
        self.assertTrue(shown["moved"])
        self.assertTrue(shown["depth"])
        self.assertEqual(-4, shown["z"])
        self.assertEqual(["o", "z"], shown["channels"])
        scene = next(item for item in port.writes if b"scene;" in item)
        tween = next(item for item in port.writes if b"tween;" in item)
        self.assertLess(port.writes.index(scene), port.writes.index(tween))
        self.assertIn(b";z=-4;o=0.2;", scene)
        kind = json.loads(dialect.scene_body(scene))["scene"]["nodes"][0]["mesh"]
        self.assertEqual("gem", kind)
        self.assertNotIn(b'"mesh":{"kind":"gem"}', scene)
        self.assertIn(b"repeat=forever", tween)
        self.assertIn(b"yoyo=1", tween)

    def test_a_bad_opacity_or_depth_is_refused_before_any_write(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_mist(
                session="mist",
                claims=self._store(tmp),
                opacity=1.1,
                port=port,
                tty_key="script:mistbad",
            )
            deep = board.show_mist(
                session="mist",
                claims=self._store(tmp),
                opacity=0.5,
                z=True,
                port=port,
                tty_key="script:mistz",
            )
        self.assertFalse(shown["misted"])
        self.assertFalse(shown["rendered"])
        self.assertIsNone(shown["opacity"])
        self.assertIsNone(shown["perspective"])
        self.assertFalse(deep["misted"])
        self.assertIsNone(deep["z"])
        self.assertEqual([], port.writes)

    def test_a_missing_scene_op_is_not_written(self):
        port = GlassScript(mode="ok", ops="hello,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_mist(
                session="mist",
                claims=self._store(tmp),
                opacity=0.35,
                port=port,
                tty_key="script:mistmiss",
            )
        self.assertFalse(shown["misted"])
        self.assertFalse(shown["confirmed"])
        self.assertFalse(any(b"scene;" in item for item in port.writes))

    def test_a_refused_scene_is_not_claimed(self):
        port = GlassScript(mode="reject-scene", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            shown = board.show_mist(
                session="mist",
                claims=store,
                opacity=0.35,
                z=8,
                port=port,
                tty_key="script:mistref",
            )
            self.assertFalse(shown["misted"])
            self.assertFalse(shown["confirmed"])
            self.assertFalse(shown["faded"])
            self.assertFalse(shown["depth"])
            self.assertIsNone(shown["opacity"])
            store.acquire("s", "script:mistref", "script:mistref")
            self.assertIsNone(store.shown("mist")[0])
        self.assertTrue(any(b"scene;" in item for item in port.writes))
        self.assertIn(b";z=8;o=0.35;", next(item for item in port.writes if b"scene;" in item))





class Dock(unittest.TestCase):
    def _store(self, tmp):
        return claims_mod.Claims(Path(tmp) / "claims.json")

    def test_cells_are_at_and_anchor_and_the_pixel_frame_is_unchanged(self):
        self.assertEqual((2.0, 1.0, 24.0, 12.0), dialect.parse_cells("2,1,24,12"))
        self.assertEqual((1.5, 2.25, 18.0, 10.0), dialect.parse_cells("1.5,2.25,18,10"))
        self.assertEqual((-1.25, 0.5, 8.0, 4.5), dialect.parse_cells([-1.25, 0.5, 8, 4.5]))
        for bad in ("2,1,24", "2,1,0,12", "2,1,-1,12", "nan,1,2,3", "1,1,inf,2", True, None, "2,1,24,12,1", 8193):
            with self.assertRaises(ValueError):
                dialect.parse_cells(bad)
        plain = dialect.scene(1, b"{}", "tok", width=160, height=120, x=40, y=40)
        self.assertIn(b"scene;id=1;px=40,40,160,120;s=160;v=120;r=tok;", plain)
        self.assertNotIn(b"at=", plain)
        self.assertNotIn(b"anchor=", plain)
        docked = dialect.scene(
            1,
            b"{}",
            "tok",
            width=160,
            height=120,
            x=40,
            y=40,
            cells=(2, 1, 24, 12),
        )
        self.assertIn(b"scene;id=1;at=2,1,24,12;anchor=window;s=160;v=120;r=tok;", docked)
        self.assertNotIn(b"px=", docked)
        self.assertNotIn(b";o=", docked)
        self.assertNotIn(b";z=", docked)
        self.assertEqual(b"{}", dialect.scene_body(docked))
        fractional = dialect.scene(
            2,
            b"{}",
            "tok",
            width=96,
            height=72,
            x=0,
            y=0,
            cells=(1.5, 2.25, 18, 10),
        )
        self.assertIn(b"at=1.5,2.25,18,10;anchor=window;s=96;v=72;", fractional)
        self.assertNotIn(b"px=", fractional)

    def test_show_dock_confirms_only_after_the_scene_ok(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_dock(
                session="dock",
                claims=self._store(tmp),
                at="2,1,24,12",
                spin=False,
                width=160,
                height=120,
                port=port,
                tty_key="script:dock",
            )
        self.assertTrue(shown["docked"])
        self.assertTrue(shown["rendered"])
        self.assertTrue(shown["confirmed"])
        self.assertTrue(shown["pinned"])
        self.assertFalse(shown["moved"])
        self.assertTrue(shown["perspective"])
        self.assertEqual([2.0, 1.0, 24.0, 12.0], shown["cells"])
        self.assertEqual(["at", "anchor"], shown["channels"])
        self.assertEqual("scene", shown["placement"])
        self.assertEqual("cube", shown["mesh"])
        scene = next(item for item in port.writes if b"scene;" in item)
        self.assertIn(b"at=2,1,24,12;anchor=window;s=160;v=120;", scene)
        self.assertNotIn(b"px=", scene)
        self.assertNotIn(b";o=", scene)
        self.assertNotIn(b";z=", scene)
        body = json.loads(dialect.scene_body(scene))
        self.assertEqual(0.9, body["scene"]["camera"]["fov"])
        self.assertNotIn("ortho", body["scene"]["camera"])
        self.assertEqual("cube", body["scene"]["nodes"][0]["mesh"])
        self.assertNotIn(b"at=", dialect.scene(1, b"{}", "a", width=8, height=8, x=0, y=0))

    def test_spin_is_moved_only_after_the_tween_ok(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_dock(
                session="dock",
                claims=self._store(tmp),
                mesh="gem",
                at="1.5,2.25,18,10",
                spin=True,
                width=96,
                height=72,
                port=port,
                tty_key="script:dockspin",
            )
        self.assertTrue(shown["docked"])
        self.assertTrue(shown["moved"])
        self.assertTrue(shown["pinned"])
        self.assertEqual([1.5, 2.25, 18.0, 10.0], shown["cells"])
        scene = next(item for item in port.writes if b"scene;" in item)
        tween = next(item for item in port.writes if b"tween;" in item)
        self.assertLess(port.writes.index(scene), port.writes.index(tween))
        self.assertIn(b"at=1.5,2.25,18,10;anchor=window;", scene)
        self.assertNotIn(b"px=", scene)
        self.assertIn(b"repeat=forever", tween)
        self.assertIn(b"yoyo=1", tween)
        kind = json.loads(dialect.scene_body(scene))["scene"]["nodes"][0]["mesh"]
        self.assertEqual("gem", kind)

    def test_a_bad_at_is_refused_before_any_write(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_dock(
                session="dock",
                claims=self._store(tmp),
                at="2,1,0,12",
                port=port,
                tty_key="script:dockbad",
            )
        self.assertFalse(shown["docked"])
        self.assertFalse(shown["pinned"])
        self.assertFalse(shown["confirmed"])
        self.assertIsNone(shown["cells"])
        self.assertEqual([], port.writes)

    def test_a_missing_scene_op_is_not_written(self):
        port = GlassScript(mode="ok", ops="hello,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_dock(
                session="dock",
                claims=self._store(tmp),
                at="2,1,24,12",
                port=port,
                tty_key="script:dockmiss",
            )
        self.assertFalse(shown["docked"])
        self.assertFalse(shown["confirmed"])
        self.assertFalse(shown["pinned"])
        self.assertFalse(any(b"scene;" in item for item in port.writes))

    def test_a_refused_scene_is_not_claimed(self):
        port = GlassScript(mode="reject-scene", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            shown = board.show_dock(
                session="dock",
                claims=store,
                at="2,1,24,12",
                port=port,
                tty_key="script:dockref",
            )
            self.assertFalse(shown["docked"])
            self.assertFalse(shown["confirmed"])
            self.assertFalse(shown["pinned"])
            self.assertIsNone(shown["cells"])
            store.acquire("s", "script:dockref", "script:dockref")
            self.assertIsNone(store.shown("dock")[0])
        self.assertTrue(any(b"scene;" in item for item in port.writes))
        scene = next(item for item in port.writes if b"scene;" in item)
        self.assertIn(b"anchor=window", scene)
        self.assertNotIn(b"px=", scene)


class Ride(unittest.TestCase):
    def _store(self, tmp):
        return claims_mod.Claims(Path(tmp) / "claims.json")

    def test_omit_and_text_frames_and_the_window_pin_is_unchanged(self):
        omit = dialect.scene(1, b"{}", "tok", width=160, height=120, x=40, y=40, cells=(2, 1, 24, 12), anchor="omit")
        labeled = dialect.scene(1, b"{}", "tok", width=160, height=120, x=40, y=40, cells=(2, 1, 24, 12), anchor="text")
        docked = dialect.scene(1, b"{}", "tok", width=160, height=120, x=40, y=40, cells=(2, 1, 24, 12))
        pixel = dialect.scene(1, b"{}", "tok", width=160, height=120, x=48, y=48)
        omit_head = omit.split(b";r=")[0]
        self.assertIn(b"scene;id=1;at=2,1,24,12;s=160;v=120", omit_head)
        self.assertNotIn(b"anchor=", omit_head)
        self.assertNotIn(b"px=", omit_head)
        self.assertNotIn(b";o=", omit_head)
        self.assertNotIn(b";z=", omit_head)
        self.assertEqual(b"{}", dialect.scene_body(omit))
        self.assertIn(b"scene;id=1;at=2,1,24,12;anchor=text;s=160;v=120;r=tok;", labeled)
        self.assertNotIn(b"anchor=window", labeled)
        self.assertIn(b"scene;id=1;at=2,1,24,12;anchor=window;s=160;v=120;r=tok;", docked)
        self.assertIn(b"px=48,48,160,120", pixel)
        self.assertNotIn(b"at=", pixel.split(b";r=")[0])
        with self.assertRaises(ValueError):
            dialect.scene(1, b"{}", "tok", width=160, height=120, x=40, y=40, anchor="omit")
        with self.assertRaises(ValueError):
            dialect.scene(1, b"{}", "tok", width=160, height=120, x=40, y=40, cells=(2, 1, 24, 12), anchor="page")

    def test_show_ride_confirms_only_after_the_scene_ok(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_ride(
                session="ride",
                claims=self._store(tmp),
                at="2,1,24,12",
                spin=False,
                width=160,
                height=120,
                port=port,
                tty_key="script:ride",
            )
        self.assertTrue(shown["rode"])
        self.assertTrue(shown["rendered"])
        self.assertTrue(shown["confirmed"])
        self.assertTrue(shown["omitted"])
        self.assertFalse(shown["labeled"])
        self.assertFalse(shown["pinned"])
        self.assertFalse(shown["moved"])
        self.assertTrue(shown["perspective"])
        self.assertEqual([2.0, 1.0, 24.0, 12.0], shown["cells"])
        self.assertEqual(["at"], shown["channels"])
        self.assertEqual("scene", shown["placement"])
        self.assertEqual("cube", shown["mesh"])
        scene = next(item for item in port.writes if b"scene;" in item)
        head = scene.split(b";r=")[0]
        self.assertIn(b"at=2,1,24,12;s=160;v=120", head)
        self.assertNotIn(b"anchor=", head)
        self.assertNotIn(b"px=", head)
        self.assertNotIn(b";o=", head)
        self.assertNotIn(b";z=", head)
        body = json.loads(dialect.scene_body(scene))
        self.assertEqual(0.9, body["scene"]["camera"]["fov"])
        self.assertNotIn("ortho", body["scene"]["camera"])
        self.assertEqual("cube", body["scene"]["nodes"][0]["mesh"])

    def test_labeled_text_sends_anchor_text(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_ride(
                session="ride",
                claims=self._store(tmp),
                at="1.5,2.25,18,10",
                anchor="text",
                mesh="gem",
                width=96,
                height=72,
                port=port,
                tty_key="script:ridetext",
            )
        self.assertTrue(shown["rode"])
        self.assertTrue(shown["labeled"])
        self.assertFalse(shown["omitted"])
        self.assertFalse(shown["pinned"])
        self.assertEqual(["at", "anchor"], shown["channels"])
        self.assertEqual([1.5, 2.25, 18.0, 10.0], shown["cells"])
        scene = next(item for item in port.writes if b"scene;" in item)
        self.assertIn(b"at=1.5,2.25,18,10;anchor=text;s=96;v=72;", scene)
        self.assertNotIn(b"anchor=window", scene)
        self.assertNotIn(b"px=", scene.split(b";r=")[0])
        kind = json.loads(dialect.scene_body(scene))["scene"]["nodes"][0]["mesh"]
        self.assertEqual("gem", kind)

    def test_spin_is_moved_only_after_the_tween_ok(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_ride(
                session="ride",
                claims=self._store(tmp),
                at="2,1,24,12",
                spin=True,
                port=port,
                tty_key="script:ridespin",
            )
        self.assertTrue(shown["rode"])
        self.assertTrue(shown["moved"])
        scene = next(item for item in port.writes if b"scene;" in item)
        tween = next(item for item in port.writes if b"tween;" in item)
        self.assertLess(port.writes.index(scene), port.writes.index(tween))
        self.assertNotIn(b"anchor=", scene.split(b";r=")[0])
        self.assertIn(b"repeat=forever", tween)
        self.assertIn(b"yoyo=1", tween)

    def test_a_bad_at_or_window_pin_is_refused_before_any_write(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            refused = board.show_ride(
                session="ride", claims=store, at="2,1,0,12", port=port, tty_key="script:ridebad"
            )
            window = board.show_ride(
                session="ride",
                claims=store,
                at="2,1,24,12",
                anchor="window",
                port=port,
                tty_key="script:ridewin",
            )
            page = board.show_ride(
                session="ride",
                claims=store,
                at="2,1,24,12",
                anchor="page",
                port=port,
                tty_key="script:ridepage",
            )
        self.assertFalse(refused["rode"])
        self.assertFalse(window["rode"])
        self.assertFalse(page["rode"])
        self.assertIsNone(refused["perspective"])
        self.assertIsNone(window["channels"])
        self.assertIn("glass_dock", window["reason"])
        self.assertEqual([], port.writes)

    def test_a_missing_scene_op_is_not_written(self):
        port = GlassScript(mode="ok", ops="hello,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_ride(
                session="ride",
                claims=self._store(tmp),
                at="2,1,24,12",
                port=port,
                tty_key="script:ridemiss",
            )
        self.assertFalse(shown["rode"])
        self.assertFalse(shown["confirmed"])
        self.assertFalse(shown["omitted"])
        self.assertFalse(any(b"scene;" in item for item in port.writes))

    def test_a_refused_scene_is_not_claimed(self):
        port = GlassScript(mode="reject-scene", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            shown = board.show_ride(
                session="ride",
                claims=store,
                at="2,1,24,12",
                port=port,
                tty_key="script:rideref",
            )
            self.assertFalse(shown["rode"])
            self.assertFalse(shown["confirmed"])
            self.assertFalse(shown["omitted"])
            self.assertIsNone(shown["cells"])
            store.acquire("s", "script:rideref", "script:rideref")
            self.assertIsNone(store.shown("ride")[0])
        self.assertTrue(any(b"scene;" in item for item in port.writes))
        scene = next(item for item in port.writes if b"scene;" in item)
        self.assertNotIn(b"anchor=", scene.split(b";r=")[0])
        self.assertNotIn(b"px=", scene.split(b";r=")[0])


class Lens(unittest.TestCase):
    def _store(self, tmp):
        return claims_mod.Claims(Path(tmp) / "claims.json")

    def test_clear_is_sent_and_the_orange_cube_omits_it(self):
        orange = json.loads(dialect.scene_payload("cube", (1, 0.4, 0.2, 1)))
        self.assertNotIn("clear", orange["scene"]["camera"])
        self.assertNotIn("near", orange["scene"]["camera"])
        self.assertNotIn("far", orange["scene"]["camera"])
        self.assertNotIn("up", orange["scene"]["camera"])
        self.assertEqual(0.9, orange["scene"]["camera"]["fov"])
        backed = json.loads(dialect.lens_payload("cube", (1, 0.4, 0.2, 1), "0.05,0.08,0.16,1"))
        camera = backed["scene"]["camera"]
        self.assertEqual([0.05, 0.08, 0.16, 1.0], camera["clear"])
        self.assertEqual(0.9, camera["fov"])
        self.assertNotIn("near", camera)
        self.assertNotIn("far", camera)
        self.assertNotIn("up", camera)
        self.assertNotIn("ortho", camera)
        clipped = json.loads(
            dialect.lens_payload(
                "gem",
                (1, 0.4, 0.2, 1),
                "1a0a08d9",
                near=0.2,
                far=12,
                up="0.2,1,0.05",
            )
        )
        camera = clipped["scene"]["camera"]
        self.assertEqual(camera["near"], 0.2)
        self.assertEqual(camera["far"], 12.0)
        self.assertEqual(camera["up"], [0.2, 1.0, 0.05])
        self.assertEqual(camera["clear"], list(dialect.parse_color("1a0a08d9")))
        self.assertIn("fov", camera)
        self.assertNotIn("ortho", camera)
        frame = dialect.scene(1, dialect.lens_payload("cube", (1, 0.4, 0.2, 1), "0d1428"), "tok", width=160, height=120, x=48, y=36)
        head = frame.split(b";r=")[0]
        self.assertIn(b"scene;id=1;px=48,36,160,120;s=160;v=120", head)
        self.assertNotIn(b"at=", head)
        self.assertNotIn(b"anchor=", head)
        self.assertNotIn(b";o=", head)
        self.assertNotIn(b";z=", head)
        body = json.loads(dialect.scene_body(frame))
        self.assertEqual(body["scene"]["camera"]["clear"][3], 1.0)
        self.assertNotIn("ortho", body["scene"]["camera"])

    def test_bad_backdrop_is_refused_before_a_write(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            missing = board.show_lens(session="lens", claims=store, clear="", port=port, tty_key="script:lensbad")
            wide = board.show_lens(session="lens", claims=store, clear="1,0,0,1", near=8, port=port, tty_key="script:lensnear")
            short = board.show_lens(session="lens", claims=store, clear="1,0,0,1", near=0.2, far=0.2, port=port, tty_key="script:lensfar")
            flat = board.show_lens(session="lens", claims=store, clear="1,0,0,1", up="-1.8,-1.2,-2.4", port=port, tty_key="script:lensup")
        for item in (missing, wide, short, flat):
            self.assertFalse(item["lensed"])
            self.assertFalse(item["backed"])
            self.assertFalse(item["confirmed"])
            self.assertIsNone(item["channels"])
        self.assertEqual([], port.writes)

    def test_show_lens_confirms_only_after_the_scene_ok(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_lens(
                session="lens",
                claims=self._store(tmp),
                clear="0.05,0.08,0.16,1",
                width=160,
                height=120,
                x=48,
                y=36,
                spin=False,
                port=port,
                tty_key="script:lens",
            )
        self.assertTrue(shown["lensed"])
        self.assertTrue(shown["rendered"])
        self.assertTrue(shown["confirmed"])
        self.assertTrue(shown["backed"])
        self.assertFalse(shown["clipped"])
        self.assertFalse(shown["tilted"])
        self.assertFalse(shown["moved"])
        self.assertEqual(shown["channels"], ["clear"])
        self.assertEqual(shown["clear"], [0.05, 0.08, 0.16, 1.0])
        self.assertTrue(shown["perspective"])
        scene = next(item for item in port.writes if b"scene;" in item)
        head = scene.split(b";r=")[0]
        self.assertIn(b"px=48,36,160,120", head)
        self.assertNotIn(b"at=", head)
        self.assertNotIn(b";o=", head)
        self.assertNotIn(b";z=", head)
        camera = json.loads(dialect.scene_body(scene))["scene"]["camera"]
        self.assertEqual(camera["clear"], [0.05, 0.08, 0.16, 1.0])
        self.assertEqual(camera["fov"], 0.9)
        self.assertNotIn("near", camera)
        self.assertNotIn("far", camera)
        self.assertNotIn("up", camera)
        self.assertNotIn("ortho", camera)

    def test_clip_and_up_are_sent_only_when_asked(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_lens(
                session="lens",
                claims=self._store(tmp),
                mesh="gem",
                clear="0.12,0.04,0.02,0.85",
                near=0.2,
                far=12,
                up="0.2,1,0.05",
                spin=True,
                width=96,
                height=72,
                port=port,
                tty_key="script:lensclip",
            )
        self.assertTrue(shown["lensed"])
        self.assertTrue(shown["backed"])
        self.assertTrue(shown["clipped"])
        self.assertTrue(shown["tilted"])
        self.assertTrue(shown["moved"])
        self.assertEqual(shown["channels"], ["clear", "near", "far", "up"])
        self.assertEqual(shown["near"], 0.2)
        self.assertEqual(shown["far"], 12.0)
        self.assertEqual(shown["up"], [0.2, 1.0, 0.05])
        scene = next(item for item in port.writes if b"scene;" in item)
        camera = json.loads(dialect.scene_body(scene))["scene"]["camera"]
        self.assertEqual(camera["near"], 0.2)
        self.assertEqual(camera["far"], 12.0)
        self.assertEqual(camera["up"], [0.2, 1.0, 0.05])
        self.assertIn("fov", camera)
        self.assertNotIn("ortho", camera)
        tween = next(item for item in port.writes if b"tween;" in item)
        self.assertIn(b"repeat=forever", tween)
        self.assertIn(b"yoyo=1", tween)

    def test_a_missing_scene_op_is_not_written(self):
        port = GlassScript(mode="ok", ops="hello,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            shown = board.show_lens(
                session="lens",
                claims=self._store(tmp),
                clear="0d1428",
                port=port,
                tty_key="script:lensmiss",
            )
        self.assertFalse(shown["lensed"])
        self.assertFalse(shown["confirmed"])
        self.assertFalse(shown["backed"])
        self.assertFalse(any(b"scene;" in item for item in port.writes))

    def test_a_refused_scene_is_not_claimed(self):
        port = GlassScript(mode="reject-scene", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = self._store(tmp)
            shown = board.show_lens(
                session="lens",
                claims=store,
                clear="0d1428",
                port=port,
                tty_key="script:lensref",
            )
            self.assertFalse(shown["lensed"])
            self.assertFalse(shown["confirmed"])
            self.assertFalse(shown["backed"])
            self.assertIsNone(shown["clear"])
            store.acquire("s", "script:lensref", "script:lensref")
            self.assertIsNone(store.shown("lens")[0])
        self.assertTrue(any(b"scene;" in item for item in port.writes))
        scene = next(item for item in port.writes if b"scene;" in item)
        self.assertIn(b"px=", scene.split(b";r=")[0])
        self.assertNotIn(b"at=", scene.split(b";r=")[0])




class Curve(unittest.TestCase):
    def test_cubic_bezier_is_a_once_only_node_move(self):
        parsed = dialect.parse_curve("0.68,-0.6,0.32,1.6")
        self.assertEqual("cubic-bezier(0.68,-0.6,0.32,1.6)", parsed["ease"])
        self.assertTrue(parsed["overshot"])
        wrapped = dialect.parse_curve("cubic-bezier(0.42,0,0.58,1)")
        self.assertEqual("cubic-bezier(0.42,0,0.58,1)", wrapped["ease"])
        self.assertFalse(wrapped["overshot"])
        frame = dialect.tween_curve(369098752, "tok", "0.55,0.15,0", "0.68,-0.6,0.32,1.6", dur=1)
        head = frame.split(b";r=")[0]
        self.assertIn(
            b"tween;id=369098752;node=1;at=0.55,0.15,0;ease=cubic-bezier(0.68,-0.6,0.32,1.6);dur=1.0",
            head,
        )
        self.assertNotIn(b"repeat", head)
        self.assertNotIn(b"yoyo", head)
        self.assertNotIn(b"camera", head)
        self.assertNotIn(b"rot=", head)
        self.assertNotIn(b"scale=", head)
        self.assertNotIn(b"color=", head)
        shift = dialect.tween_shift(7, "aaa", at="0.4,0.2,0")
        self.assertIn(b"ease=sine-in-out", shift)
        self.assertNotIn(b"cubic-bezier", shift)
        turn = dialect.tween_turn(7, "aaa", yaw=90)
        self.assertIn(b"ease=spring(170,12)", turn)
        self.assertNotIn(b";dur=", turn)
        self.assertNotIn(b"cubic-bezier", turn)
        with self.assertRaises(ValueError):
            dialect.tween_shift(7, "aaa", at="1,0,0", ease="cubic-bezier(0.68,-0.6,0.32,1.6)")
        with self.assertRaises(ValueError):
            dialect.parse_curve("0.68,-0.6,1.2,1.6")
        with self.assertRaises(ValueError):
            dialect.parse_curve("0,101,1,0")
        with self.assertRaises(ValueError):
            dialect.parse_curve("sine")
        with self.assertRaises(ValueError):
            dialect.tween_curve(7, "aaa", "1,0,0", "0.2,0,0.4")

    def test_a_bad_curve_is_refused_before_a_write(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            missing = board.curve_scene(session="s", claims=store, at="", curve="0.68,-0.6,0.32,1.6", port=port, tty_key="script:curve")
            wide = board.curve_scene(session="s", claims=store, at="0,0,0", curve="1.2,0,0,1", port=port, tty_key="script:curve")
            tall = board.curve_scene(session="s", claims=store, at="0,0,0", curve="0,101,1,0", port=port, tty_key="script:curve")
            named = board.curve_scene(session="s", claims=store, at="0,0,0", curve="sine", port=port, tty_key="script:curve")
        for item in (missing, wide, tall, named):
            self.assertFalse(item["curved"])
            self.assertFalse(item["bezier"])
            self.assertFalse(item["overshot"])
            self.assertFalse(item["written"])
            self.assertFalse(item["confirmed"])
        self.assertEqual([], port.writes)

    def test_no_scene_and_a_missing_tween_op_are_not_written(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            absent = board.curve_scene(
                session="s",
                claims=store,
                at="0.55,0.15,0",
                curve="0.68,-0.6,0.32,1.6",
                port=port,
                tty_key="script:curve",
            )
            self.assertFalse(absent["curved"])
            self.assertFalse(absent["written"])
            self.assertIn("no scene", absent["reason"])
            self.assertEqual([], port.writes)
            shown = board.show_scene(session="s", mesh="cube", claims=store, port=port, tty_key="script:curve", spin=False)
            self.assertTrue(shown["confirmed"])
        quiet = GlassScript(mode="ok", ops="hello,scene,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            board.show_scene(session="s", mesh="cube", claims=store, port=quiet, tty_key="script:notween", spin=False)
            before = len(quiet.writes)
            missed = board.curve_scene(
                session="s",
                claims=store,
                at="0.55,0.15,0",
                curve="0.68,-0.6,0.32,1.6",
                port=quiet,
                tty_key="script:notween",
            )
        self.assertFalse(missed["curved"])
        self.assertFalse(missed["written"])
        self.assertFalse(missed["bezier"])
        added = b"".join(quiet.writes[before:])
        self.assertNotIn(b"tween;", added)

    def test_curve_confirms_only_after_the_tween_ok(self):
        port = GlassScript(ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(session="s", mesh="cube", claims=store, port=port, tty_key="script:curve", spin=False)
            self.assertTrue(shown["confirmed"])
            before = len(port.writes)
            curved = board.curve_scene(
                session="s",
                claims=store,
                port=port,
                tty_key="script:curve",
                at="0.55,0.15,0",
                curve="0.68,-0.6,0.32,1.6",
            )
            self.assertTrue(curved["curved"], curved)
            self.assertTrue(curved["moved"])
            self.assertTrue(curved["confirmed"])
            self.assertTrue(curved["bezier"])
            self.assertTrue(curved["overshot"])
            self.assertTrue(curved["written"])
            self.assertFalse(curved["rendered"])
            self.assertEqual(["at"], curved["channels"])
            self.assertEqual("cubic-bezier(0.68,-0.6,0.32,1.6)", curved["curve"])
            self.assertEqual(1, curved["node"])
            added = b"".join(port.writes[before:])
            self.assertIn(b"ease=cubic-bezier(0.68,-0.6,0.32,1.6)", added)
            self.assertIn(b";at=0.55,0.15,0;", added)
            self.assertNotIn(b"repeat", added)
            self.assertNotIn(b"yoyo", added)
            self.assertNotIn(b"camera=", added)
            self.assertNotIn(b"scale=", added)
            self.assertNotIn(b"color=", added)
            held = board.curve_scene(
                session="s",
                claims=store,
                port=port,
                tty_key="script:curve",
                at="-0.2,0.05,0",
                curve="0.42,0,0.58,1",
                dur=0.6,
            )
            self.assertTrue(held["curved"], held)
            self.assertTrue(held["bezier"])
            self.assertFalse(held["overshot"])
            self.assertEqual("cubic-bezier(0.42,0,0.58,1)", held["curve"])
            refused = GlassScript(ops="hello,scene,tween,remove", mode="reject-tween")
            missed = board.curve_scene(
                session="s",
                claims=store,
                port=refused,
                tty_key="script:curve",
                at="0.1,0,0",
                curve="0.68,-0.6,0.32,1.6",
            )
            self.assertFalse(missed["curved"])
            self.assertFalse(missed["bezier"])
            self.assertFalse(missed["overshot"])
            self.assertFalse(missed["confirmed"])
            self.assertTrue(missed["written"])
            self.assertIn(b"cubic-bezier", b"".join(refused.writes))


class Ease(unittest.TestCase):
    def test_named_back_and_elastic_are_one_once_only_frame(self):
        parsed = dialect.parse_named_ease("back-out")
        self.assertEqual("back-out", parsed["ease"])
        self.assertEqual("back", parsed["family"])
        self.assertTrue(parsed["recoil"])
        self.assertFalse(parsed["wobble"])
        elastic = dialect.parse_named_ease("elastic-in-out")
        self.assertEqual("elastic", elastic["family"])
        self.assertFalse(elastic["recoil"])
        self.assertTrue(elastic["wobble"])
        frame = dialect.tween_named(369098752, "tok", "0.4,0.2,0", "back-out", dur=0.8)
        head = frame.split(b";r=")[0]
        self.assertIn(
            b"tween;id=369098752;node=1;at=0.4,0.2,0;ease=back-out;dur=0.8",
            head,
        )
        self.assertNotIn(b"repeat", head)
        self.assertNotIn(b"yoyo", head)
        self.assertNotIn(b"camera", head)
        self.assertNotIn(b"rot=", head)
        self.assertNotIn(b"scale=", head)
        self.assertNotIn(b"color=", head)
        self.assertNotIn(b"cubic-bezier", head)
        self.assertNotIn(b"spring", head)
        wobble = dialect.tween_named(369098752, "tok", "-0.2,0.05,0", "elastic-out", dur=0.5)
        self.assertIn(b"ease=elastic-out", wobble.split(b";r=")[0])
        self.assertIn(b";dur=0.5", wobble.split(b";r=")[0])
        shift = dialect.tween_shift(7, "aaa", at="0.4,0.2,0")
        self.assertIn(b"ease=sine-in-out", shift)
        self.assertNotIn(b"back-out", shift)
        self.assertNotIn(b"elastic", shift)
        with self.assertRaises(ValueError):
            dialect._ease("back-out")
        with self.assertRaises(ValueError):
            dialect._ease("elastic")
        with self.assertRaises(ValueError):
            dialect.tween_shift(7, "aaa", at="1,0,0", ease="back-out")
        with self.assertRaises(ValueError):
            dialect.parse_named_ease("back")
        with self.assertRaises(ValueError):
            dialect.parse_named_ease("elastic")
        with self.assertRaises(ValueError):
            dialect.parse_named_ease("sine")
        with self.assertRaises(ValueError):
            dialect.parse_named_ease("cubic-bezier(0.42,0,0.58,1)")

    def test_a_bad_ease_is_refused_before_a_write(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            missing = board.ease_scene(session="s", claims=store, at="", ease="back-out", port=port, tty_key="script:ease")
            short = board.ease_scene(session="s", claims=store, at="0,0,0", ease="back", port=port, tty_key="script:ease")
            sine = board.ease_scene(session="s", claims=store, at="0,0,0", ease="sine", port=port, tty_key="script:ease")
            bezier = board.ease_scene(
                session="s",
                claims=store,
                at="0,0,0",
                ease="cubic-bezier(0.42,0,0.58,1)",
                port=port,
                tty_key="script:ease",
            )
        for item in (missing, short, sine, bezier):
            self.assertFalse(item["eased"])
            self.assertFalse(item["named"])
            self.assertFalse(item["recoil"])
            self.assertFalse(item["wobble"])
            self.assertFalse(item["written"])
            self.assertFalse(item["confirmed"])
        self.assertEqual([], port.writes)

    def test_no_scene_and_a_missing_tween_op_are_not_written(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            absent = board.ease_scene(
                session="s",
                claims=store,
                at="0.4,0.2,0",
                ease="back-out",
                port=port,
                tty_key="script:ease",
            )
            self.assertFalse(absent["eased"])
            self.assertFalse(absent["written"])
            self.assertIn("no scene", absent["reason"])
            self.assertEqual([], port.writes)
            shown = board.show_scene(session="s", mesh="cube", claims=store, port=port, tty_key="script:ease", spin=False)
            self.assertTrue(shown["confirmed"])
        quiet = GlassScript(mode="ok", ops="hello,scene,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            board.show_scene(session="s", mesh="cube", claims=store, port=quiet, tty_key="script:noease", spin=False)
            before = len(quiet.writes)
            missed = board.ease_scene(
                session="s",
                claims=store,
                at="0.4,0.2,0",
                ease="elastic-out",
                port=quiet,
                tty_key="script:noease",
            )
        self.assertFalse(missed["eased"])
        self.assertFalse(missed["written"])
        self.assertFalse(missed["named"])
        added = b"".join(quiet.writes[before:])
        self.assertNotIn(b"tween;", added)

    def test_ease_confirms_only_after_the_tween_ok(self):
        port = GlassScript(ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(session="s", mesh="cube", claims=store, port=port, tty_key="script:ease", spin=False)
            self.assertTrue(shown["confirmed"])
            before = len(port.writes)
            eased = board.ease_scene(
                session="s",
                claims=store,
                port=port,
                tty_key="script:ease",
                at="0.4,0.2,0",
                ease="back-out",
            )
            self.assertTrue(eased["eased"], eased)
            self.assertTrue(eased["moved"])
            self.assertTrue(eased["confirmed"])
            self.assertTrue(eased["named"])
            self.assertTrue(eased["recoil"])
            self.assertFalse(eased["wobble"])
            self.assertTrue(eased["written"])
            self.assertFalse(eased["rendered"])
            self.assertEqual(["at"], eased["channels"])
            self.assertEqual("back-out", eased["ease"])
            self.assertEqual("back", eased["family"])
            self.assertEqual(1, eased["node"])
            added = b"".join(port.writes[before:])
            self.assertIn(b"ease=back-out", added)
            self.assertIn(b";at=0.4,0.2,0;", added)
            self.assertIn(b";dur=0.8", added)
            self.assertNotIn(b"repeat", added)
            self.assertNotIn(b"yoyo", added)
            self.assertNotIn(b"camera=", added)
            self.assertNotIn(b"scale=", added)
            self.assertNotIn(b"color=", added)
            self.assertNotIn(b"cubic-bezier", added)
            self.assertNotIn(b"spring", added)
            held = board.ease_scene(
                session="s",
                claims=store,
                port=port,
                tty_key="script:ease",
                at="-0.2,0.05,0",
                ease="elastic-in-out",
                dur=0.5,
            )
            self.assertTrue(held["eased"], held)
            self.assertTrue(held["wobble"])
            self.assertFalse(held["recoil"])
            self.assertEqual("elastic-in-out", held["ease"])
            refused = GlassScript(ops="hello,scene,tween,remove", mode="reject-tween")
            missed = board.ease_scene(
                session="s",
                claims=store,
                port=refused,
                tty_key="script:ease",
                at="0.1,0,0",
                ease="back-in",
            )
            self.assertFalse(missed["eased"])
            self.assertFalse(missed["named"])
            self.assertFalse(missed["recoil"])
            self.assertFalse(missed["wobble"])
            self.assertFalse(missed["confirmed"])
            self.assertTrue(missed["written"])
            self.assertIn(b"ease=back-in", b"".join(refused.writes))


class Wipe(unittest.TestCase):
    def test_all_remove_is_one_frame_and_releases_only_after_ok(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            idle = board.wipe_session(session="s", claims=store, port=port, tty_path="/dev/pts/9")
            self.assertFalse(idle["wiped"])
            self.assertFalse(idle["written"])
            self.assertEqual([], port.writes)
            shown = board.show_scene(
                session="s",
                mesh="cube",
                claims=store,
                port=port,
                tty_key="script:wipe",
                spin=False,
            )
            self.assertTrue(shown["confirmed"], shown)
            before = len(port.writes)
            wiped = board.wipe_session(session="s", claims=store, port=port)
            self.assertTrue(wiped["wiped"], wiped)
            self.assertTrue(wiped["confirmed"])
            self.assertTrue(wiped["written"])
            self.assertFalse(wiped["rendered"])
            self.assertEqual("remove;all=1", wiped["frame"])
            self.assertEqual("all removed", wiped["reason"])
            added = b"".join(port.writes[before:])
            self.assertEqual(1, added.count(b"remove;"))
            self.assertIn(b"remove;all=1;", added)
            self.assertNotIn(b"remove;id=", added)
            self.assertNotIn(b"remove;g=", added)
            self.assertNotIn(b"asset=", added)
            self.assertIsNone(store.path_for("s"))

    def test_a_missing_remove_op_and_a_refusal_are_not_a_wipe(self):
        quiet = GlassScript(mode="ok", ops="hello,scene,tween")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(
                session="s",
                mesh="cube",
                claims=store,
                port=quiet,
                tty_key="script:wipe",
                spin=False,
            )
            self.assertTrue(shown["confirmed"], shown)
            before = len(quiet.writes)
            missed = board.wipe_session(session="s", claims=store, port=quiet)
            self.assertFalse(missed["wiped"])
            self.assertFalse(missed["written"])
            self.assertFalse(missed["confirmed"])
            added = b"".join(quiet.writes[before:])
            self.assertNotIn(b"remove;", added)
            self.assertIsNotNone(store.path_for("s"))
        refused = GlassScript(mode="reject-remove", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            board.show_scene(
                session="s",
                mesh="cube",
                claims=store,
                port=refused,
                tty_key="script:wipe",
                spin=False,
            )
            before = len(refused.writes)
            denied = board.wipe_session(session="s", claims=store, port=refused)
            self.assertFalse(denied["wiped"], denied)
            self.assertTrue(denied["written"])
            self.assertFalse(denied["confirmed"])
            self.assertIn(b"remove;all=1;", b"".join(refused.writes[before:]))
            self.assertIsNotNone(store.path_for("s"))
            self.assertEqual("scene", store.kind("s"))

    def test_clear_still_removes_one_id(self):
        port = GlassScript(mode="ok", ops="hello,scene,tween,remove")
        with tempfile.TemporaryDirectory() as tmp:
            store = claims_mod.Claims(Path(tmp) / "claims.json")
            shown = board.show_scene(
                session="s",
                mesh="cube",
                claims=store,
                port=port,
                tty_key="script:clear",
                spin=False,
            )
            self.assertTrue(shown["confirmed"], shown)
            before = len(port.writes)
            cleared = board.clear(session="s", claims=store, port=port)
            self.assertTrue(cleared["cleared"], cleared)
            added = b"".join(port.writes[before:])
            self.assertIn(b"remove;id=", added)
            self.assertNotIn(b"all=1", added)


if __name__ == "__main__":
    unittest.main()
