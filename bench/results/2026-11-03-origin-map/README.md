# Origin-map experiment: rejected, runtime restored

Authoritative reproduction commands:

```sh
python3 -B bench/results/2026-11-03-origin-map/verify.py
python3 -B bench/results/2026-11-03-origin-map/test-verify.py
python3 -B bench/replay-evidence-index.py --root . bench/results/2026-11-03-origin-map/final-frozen-index.json
```

**Erratum:** the sealed iteration-38 report and append-only bench notes incorrectly
show `--index`. This script takes a positional index. The v2 replay receipt is
an argparse error and is not a passing replay. The v3 receipt uses the actual
CLI and matches 975 file references / 968 unique source versions. Earlier sealed
bytes remain unchanged. This file supplements, and corrects that command in,
the original report. The v2 checkpoint and Python receipts pass; the name v2
there does not imply that the v2 replay passed.

Decision: no runtime promotion, no speed claim. Guarded shadow origins pass
124,416 Unicode, 56,160 height-only, and 20,736 mixed ASCII nonblank observations;
blank logical-slot regression still fails. Shipping source/executable unchanged.
Final restored suite: 392 passed, 14 ignored; differential sweep: 12,800 streams.
Seven Python tests reject 27 evidence corruptions and 7 invalid configurations.
The first manifest setup and initial ignored/nonexistent-test runs are retained,
not counted as passes. See the explicit full report and sealed raw artifacts.
