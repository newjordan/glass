"""Medians over rounds of run-tput.sh's results, per terminal.

    python3 -I bench/summarize.py [DIR]      (DIR: bench/results/local)

Reads DIR/tput-<terminal>-<round>.json. For each terminal and workload it
prints the median MB/s over the rounds, the median full-screen TUI frames a
second, and the median over rounds of the terminal's CPU time summed over
the six workloads: the figures the README and docs/PERFORMANCE.md publish.
"""
import glob, json, os, re, statistics, sys

here = os.path.dirname(os.path.abspath(__file__))
folder = sys.argv[1] if len(sys.argv) > 1 else os.path.join(here, "results", "local")
runs = {}
for path in sorted(glob.glob(os.path.join(folder, "tput-*.json"))):
    match = re.fullmatch(r"tput-(.+)-([^-]+)\.json", os.path.basename(path))
    if not match:
        continue
    terminal, round_label = match.groups()
    with open(path) as f:
        runs.setdefault(terminal, []).append((round_label, json.load(f)))
if not runs:
    sys.exit(f"no tput-*.json in {folder}")

workloads = ["ascii", "unicode", "truecolor", "cursor_motion", "scroll_region", "tui_frames"]
for terminal, rounds in sorted(runs.items()):
    grids = sorted({f"{d['cols']}x{d['rows']}" for _, d in rounds})
    print(f"{terminal}: {len(rounds)} rounds ({', '.join(r for r, _ in rounds)}), grid {', '.join(grids)}")
    for name in workloads:
        values = [d["results"][name]["mb_s"] for _, d in rounds if name in d["results"]]
        if values:
            print(f"  {name:14} {statistics.median(values):8.1f} MB/s   runs {values}")
    fps = [d["results"]["tui_frames"]["fps"] for _, d in rounds if "tui_frames" in d["results"]]
    if fps:
        print(f"  {'tui fps':14} {statistics.median(fps):8.1f}        runs {fps}")
    cpu = [round(sum(v["term_cpu_s"] for v in d["results"].values()), 2) for _, d in rounds]
    print(f"  {'cpu s, all six':14} {statistics.median(cpu):8.2f}        runs {cpu}")
