#!/usr/bin/env python3
"""Turn one run-visible.sh session directory into per-run numbers.

Reads, from the session directory DIR:
  frames.vis       viscap's per-frame log (monotonic ns; header has the offset
                   to wall-clock)
  events.log       Hyprland openwindow events, "wallclock_ns class"
  runs.txt         one line per launch: "run term t0_wallclock_ns"
  start-RUN-TERM   when the program inside started ($EPOCHREALTIME, seconds)
  trace-RUN-glass  glass's GLASS_STARTUP_TRACE marks (wall-clock ns)
  cal-*.txt        calclient output (calibration)
  gpu.csv          nvidia-smi samples taken during the session
  clock-end        "real_minus_mono_ns" measured at the end (drift check)
Writes JSON on stdout.
"""
import json, os, statistics, sys

D = sys.argv[1]
HZ = float(sys.argv[2]) if len(sys.argv) > 2 else 240.0
PERIOD = 1e9 / HZ


def med(v):
    return round(statistics.median(v), 1) if v else None


lines = open(os.path.join(D, "frames.vis")).read().splitlines()
off = int(lines[0].split()[3])
fmt = next((l for l in lines if l.startswith("# format")), "")
frames = [tuple(map(int, l.split())) for l in lines if l and not l.startswith("#")]
# seq ready_mono recv_mono r g b nmag npix
T = [f[1] + off for f in frames]  # frame times, wall-clock ns
end_off = int(open(os.path.join(D, "clock-end")).read().split()[0])

# Intervals between captured frames; the pauses for capture-off launches
# (seconds long) are left out.
dts = [(b - a) / 1e6 for a, b in zip(T, T[1:]) if b - a < 1e9]
cadence = {
    "frames": len(frames),
    "median_interval_ms": round(statistics.median(dts), 3),
    "share_of_intervals_over_1.5_periods": round(sum(d > 1.5 * PERIOD / 1e6 for d in dts) / len(dts), 4),
    "max_interval_ms": round(max(dts), 2),
    "recv_minus_ready_median_ms": round(statistics.median([(f[2] - f[1]) / 1e6 for f in frames]), 3),
}


def is_marker(f):
    return f[6] * 2 > f[7]  # most of the region is the marker colour


def is_cal_grey(f):
    return all(abs(c - 40) <= 3 for c in f[3:6])  # calclient's grey (40,40,40)


def first_index_after(t):
    lo, hi = 0, len(T)
    while lo < hi:
        m = (lo + hi) // 2
        if T[m] < t:
            lo = m + 1
        else:
            hi = m
    return lo


events = []  # (time, class, workspace) of each openwindow
for l in open(os.path.join(D, "events.log")):
    p = l.split()
    if len(p) >= 4 and p[1] == "openwindow":
        events.append((int(p[0]), p[2], p[3]))

runs = []
for l in open(os.path.join(D, "runs.txt")):
    i, term, mode, t0, ws = l.split()
    i, t0 = int(i), int(t0)
    r = {"run": i, "term": term, "capture": mode == "cap", "workspace": ws}
    k0 = first_index_after(t0)
    base = frames[k0 - 1][3:6] if k0 > 0 else None
    r["baseline_rgb"] = list(base) if base else None
    # (a) the program inside is running
    sf = os.path.join(D, "start-%d-%s-%s" % (i, term, mode))
    if os.path.exists(sf) and os.path.getsize(sf):
        r["a_program_ms"] = round((int(round(float(open(sf).read().strip()) * 1e6)) * 1000 - t0) / 1e6, 2)
    # (b) Hyprland's openwindow event
    ev = next(((t, w) for t, c, w in events if c == "bench-vis." + term and t >= t0), None)
    if ev:
        r["b_openwindow_ms"] = round((ev[0] - t0) / 1e6, 2)
        if ev[1] != ws:
            r["misplaced"] = "opened on workspace %s, expected %s" % (ev[1], ws)
    tf = os.path.join(D, "trace-%d-%s-%s" % (i, term, mode))
    if term.startswith("glass") and os.path.exists(tf):
        marks = {}
        for l2 in open(tf):
            p = l2.split()
            if l2.startswith("glass-startup") and len(p) >= 5:
                marks.setdefault(" ".join(p[4:]), round((int(p[3]) - t0) / 1e6, 2))
        r["glass_trace_ms"] = marks
    runs.append(r)
    if mode != "cap":
        del r["baseline_rgb"]
        continue
    # the window first shows at all: the region stops being the empty workspace
    lim = t0 + 6e9
    kw = next((k for k in range(k0, len(T)) if T[k] < lim and base and max(abs(a - b) for a, b in zip(frames[k][3:6], base)) > 3), None)
    if kw is not None:
        r["w_window_visible_ms"] = round((T[kw] - t0) / 1e6, 2)
        r["w_rgb"] = list(frames[kw][3:6])
    # (c) the program's output first shows: the marker colour fills the region
    kc = next((k for k in range(k0, len(T)) if T[k] < lim and is_marker(frames[k])), None)
    if kc is not None:
        r["c_output_visible_ms"] = round((T[kc] - t0) / 1e6, 2)
        r["c_rgb"] = list(frames[kc][3:6])
        r["c_frame_gap_ms"] = round((T[kc] - T[kc - 1]) / 1e6, 2)  # time since the previous captured frame
        r["c_full_frame"] = frames[kc][6] == frames[kc][7]
        # what the region showed in the frame just before
        r["c_prev_rgb"] = list(frames[kc - 1][3:6])

terms = []
for r in runs:
    k = r["term"] + ("" if r["capture"] else " (capture off)")
    r["group"] = k
    if k not in terms:
        terms.append(k)
summary = {}
for t in terms:
    rs = [r for r in runs if r["group"] == t and "misplaced" not in r]
    s = {}
    for key in ("a_program_ms", "b_openwindow_ms", "w_window_visible_ms", "c_output_visible_ms"):
        v = [r[key] for r in rs if key in r]
        s[key.replace("_ms", "")] = {"median_ms": med(v), "runs_ms": v, "n": len(v),
                                     "min_ms": min(v) if v else None, "max_ms": max(v) if v else None}
    cs = [r for r in rs if "c_output_visible_ms" in r]
    s["c_minus_a_median_ms"] = med([r["c_output_visible_ms"] - r["a_program_ms"] for r in cs if "a_program_ms" in r])
    s["c_runs_with_a_missed_frame_before"] = sum(r["c_frame_gap_ms"] > 1.5 * PERIOD / 1e6 for r in cs)
    s["missing_c"] = len(rs) - len(cs) if rs[0]["capture"] else None
    if t.startswith("glass"):
        ff = [r["glass_trace_ms"].get("[main] first frame") for r in rs if "glass_trace_ms" in r]
        ff = [x for x in ff if x is not None]
        s["glass_trace_first_frame_median_ms"] = med(ff)
        ps = [r["glass_trace_ms"].get("[app] program started", r["glass_trace_ms"].get("[cockpit] program started")) for r in rs if "glass_trace_ms" in r]
        s["glass_trace_program_started_median_ms"] = med([x for x in ps if x is not None])
        dv = [r["glass_trace_ms"].get("[gpu-open] device") for r in rs if "glass_trace_ms" in r]
        s["glass_trace_gpu_device_median_ms"] = med([x for x in dv if x is not None])
        # c relative to glass's own "first frame" mark (the GPU frame commit)
        s["c_minus_trace_first_frame_median_ms"] = med([r["c_output_visible_ms"] - r["glass_trace_ms"]["[main] first frame"]
                                                         for r in cs if "[main] first frame" in r.get("glass_trace_ms", {})])
    summary[t] = s


# calibration: a known client commit -> the first captured frame showing it
def calibration(path):
    commits, pres = {}, {}
    for l in open(path):
        p = l.split()
        if not p or p[0].startswith("#"):
            continue
        if p[0] == "commit":
            commits[int(p[1])] = (p[2] == "marker", int(p[3]))
        elif p[0] == "presented":
            pres[int(p[1])] = int(p[2])
    rows = []
    for i, (want, t) in sorted(commits.items()):
        tw = t + off
        k = next((k for k in range(first_index_after(tw), len(T)) if frames[k][2] > t and (is_marker(frames[k]) if want else is_cal_grey(frames[k]))), None)
        if k is None:
            continue
        rows.append({
            "commit_to_frame_ms": (T[k] - tw) / 1e6,
            "frame_minus_presented_ms": (frames[k][1] - pres[i]) / 1e6 if i in pres else None,
            "commit_to_presented_ms": (pres[i] - t) / 1e6 if i in pres else None,
            "gap_ms": (T[k] - T[k - 1]) / 1e6,
        })
    ok = [r for r in rows if r["gap_ms"] <= 1.5 * PERIOD / 1e6]
    c2f = [r["commit_to_frame_ms"] for r in rows]
    fmp = [r["frame_minus_presented_ms"] for r in ok if r["frame_minus_presented_ms"] is not None]
    c2p = [r["commit_to_presented_ms"] for r in rows if r["commit_to_presented_ms"] is not None]
    return {
        "switches": len(commits), "seen": len(rows),
        "commit_to_frame_ms": {"min": round(min(c2f), 2), "median": round(statistics.median(c2f), 2), "max": round(max(c2f), 2)},
        "commit_to_frame_ms_runs": [round(x, 2) for x in c2f],
        "commit_to_presented_ms": {"min": round(min(c2p), 2), "median": round(statistics.median(c2p), 2), "max": round(max(c2p), 2)} if c2p else None,
        "frame_minus_presented_ms_no_missed_frame": {"min": round(min(fmp), 2), "median": round(statistics.median(fmp), 2), "max": round(max(fmp), 2)} if fmp else None,
        "switches_seen_after_a_missed_frame": len(rows) - len(ok),
    }


cal = {}
for name in sorted(os.listdir(D)):
    if name.startswith("cal-") and name.endswith(".txt"):
        cal[name[4:-4]] = calibration(os.path.join(D, name))

gpu = []
gp = os.path.join(D, "gpu.csv")
if os.path.exists(gp):
    for l in open(gp):
        p = [x.strip() for x in l.split(",")]
        try:
            gpu.append((int(p[1].split()[0]), int(p[2].split()[0])))
        except (IndexError, ValueError):
            pass

out = {
    "refresh_hz": HZ,
    "frame_period_ms": round(PERIOD / 1e6, 3),
    "capture_format": fmt,
    "capture_cadence": cadence,
    "clock_drift_real_minus_mono_ms": round((end_off - off) / 1e6, 3),
    "calibration": cal,
    "gpu_during_runs": {
        "samples": len(gpu),
        "util_pct_median": med([g[0] for g in gpu]), "util_pct_max": max(g[0] for g in gpu) if gpu else None,
        "mem_used_mib_median": med([g[1] for g in gpu]),
    },
    "summary": summary,
    "runs": runs,
}
json.dump(out, sys.stdout, indent=1)
print()
