"""Terminal throughput, vtebench-style: write a workload, then wait for the
terminal's DA1 answer so the clock stops only when every byte was parsed.

Run inside the terminal under test: `python3 -I tput.py out.json`. Each of
the six workloads is written three times; the fastest of the three is kept,
with the terminal's own CPU time over it. The terminal's pid is
BENCH_TERM_PID when set, else KITTY_PID (which kitty sets to its own pid),
else this process's parent."""
import json, os, random, sys, termios, time, tty

out = sys.argv[1]
fd_in, fd_out = sys.stdin.fileno(), sys.stdout.fileno()
cols, rows = os.get_terminal_size()
tpid = int(os.environ.get("BENCH_TERM_PID") or os.environ.get("KITTY_PID") or os.getppid())

def cpu(pid):
    f = open(f"/proc/{pid}/stat").read().rsplit(")", 1)[1].split()
    return (int(f[11]) + int(f[12])) / os.sysconf("SC_CLK_TCK")

def write_all(b):
    v = memoryview(b)
    while v:
        n = os.write(fd_out, v[:1 << 16])
        v = v[n:]

def sync():
    write_all(b"\x1b[c")
    buf = b""
    while not buf.endswith(b"c"):
        buf += os.read(fd_in, 64)

rng = random.Random(7)
PRINT = [chr(c) for c in range(0x21, 0x7f)]
def line_ascii():
    return "".join(rng.choice(PRINT) for _ in range(cols - 1)) + "\r\n"
def build(target, gen):
    parts, n = [], 0
    while n < target:
        s = gen().encode()
        parts.append(s); n += len(s)
    return b"".join(parts)

W = {}
base = [line_ascii() for _ in range(400)]
W["ascii"] = build(24 << 20, lambda: rng.choice(base))
uni = ["漢字", "テスト", "🙂", "é", "ñ", "Ж", "αβγ", "á", "→", "█", "─"]
ulines = ["".join(rng.choice(uni + PRINT[:20]) for _ in range(cols // 3)) + "\r\n" for _ in range(400)]
W["unicode"] = build(16 << 20, lambda: rng.choice(ulines))
def sgr_line():
    return "".join(f"\x1b[38;2;{rng.randrange(256)};{rng.randrange(256)};{rng.randrange(256)}m{rng.choice(PRINT)}" for _ in range(cols - 1)) + "\x1b[0m\r\n"
slines = [sgr_line() for _ in range(200)]
W["truecolor"] = build(24 << 20, lambda: rng.choice(slines))
def cup():
    return "".join(f"\x1b[{rng.randrange(1, rows + 1)};{rng.randrange(1, cols - 8)}H\x1b[3{rng.randrange(8)}m{rng.choice(PRINT) * 6}" for _ in range(50))
cups = [cup() for _ in range(400)]
W["cursor_motion"] = build(16 << 20, lambda: rng.choice(cups))
W["scroll_region"] = f"\x1b[2;{rows - 2}r".encode() + build(16 << 20, lambda: rng.choice(base)) + b"\x1b[r"
# Full-screen TUI frames on the alternate screen: home, then every cell coloured.
def frame():
    body = "".join(f"\x1b[{r + 1};1H" + "".join(f"\x1b[48;5;{(r * 7 + c) % 256}m{PRINT[(r + c) % 94]}" for c in range(cols)) for r in range(rows))
    return body
frames = [frame().encode() for _ in range(4)]
NF = 300
W["tui_frames"] = b"\x1b[?1049h" + b"".join(frames[i % 4] for i in range(NF)) + b"\x1b[?1049l"

old = termios.tcgetattr(fd_in)
tty.setraw(fd_in)
res = {"rows": rows, "cols": cols, "results": {}}
try:
    sync()
    for name, data in W.items():
        runs = []
        for _ in range(3):
            write_all(b"\x1b[0m\x1b[H\x1b[2J")
            sync()
            c0, t0 = cpu(tpid), time.perf_counter()
            write_all(data)
            sync()
            t1, c1 = time.perf_counter(), cpu(tpid)
            runs.append((t1 - t0, c1 - c0))
        best = min(runs)
        r = {"bytes": len(data), "secs": [round(x[0], 3) for x in runs],
             "mb_s": round(len(data) / best[0] / 1e6, 1), "term_cpu_s": round(best[1], 2)}
        if name == "tui_frames":
            r["fps"] = round(NF / best[0], 1)
        res["results"][name] = r
finally:
    termios.tcsetattr(fd_in, termios.TCSADRAIN, old)
    write_all(b"\x1b[0m\x1b[r\x1b[H\x1b[2J")
json.dump(res, open(out, "w"), indent=1)
