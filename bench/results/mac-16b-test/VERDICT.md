# Cell 24B→16B side-table refactor: Mac verdict (2026-10-31)

Clean A/B, same quiet Mac mini (M4 Pro), same hour, 3 rounds each:
glass@HEAD (193b2c0, 24B Cell) vs working tree with Cell at 16B.

| workload        | glass@HEAD | glass 16B | Δ     | Ghostty 1.4.0 |
| --------------- | ---------- | --------- | ----- | ------------- |
| ascii           | 349.8 MB/s | 290.9     | −17%  | 342.7         |
| unicode         | 236.5      | 174.3     | −26%  | 317.2         |
| truecolor       | 247.6      | 241.6     | −2%   | 273.7         |
| cursor_motion   | 205.7      | 193.8     | −6%   | 208.6         |
| scroll_region   | 331.5      | 260.7     | −21%  | 351.1         |
| tui_frames      | 253.7      | 243.5     | −4%   | 284.0         |
| cpu (six)       | 0.85 s     | 0.96 s    | +13%  | 1.12          |

Raw: tput-*.json in this dir (dirty) and ../mac-head-baseline/ (HEAD).

VERDICT: the 16B cell is a throughput regression on Apple Silicon — every
workload slower, CPU up 13%. Per-write side-table traffic (extra_set(None)
in write_at_cursor, clear_cell_extra per cell in print_run) costs more
than the halved cell footprint returns. Recommendation: revert the layout.

Same session also: two real semantic bugs in the refactor found by the
fast/slow equivalence fuzzers (stale extra surviving overwrite;
missing extra-clear on plain-run writes) — fixed in the dirty tree; one
divergence remains (16-byte repro \xad\xd0\xc2\xe2\xcc\x81\x1bca\xf0\x9f\x99\x82\xe6\xcc\x81).
