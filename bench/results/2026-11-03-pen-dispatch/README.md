# Pen attribute dispatch experiment (iteration 32)

Prospective local diagnostic, not a competitive win or championship acceptance.

`protocol.json` was frozen before compilation or timing. Only the Term attribute
handler is changed at runtime: foreground/background stores stay hot; the old
match (including all reset and underline behavior) is split into an out-of-line
helper. The original trace record remains once per attribute. No parser changes.

Both release arms contain the identical new explicit pen-template oracle. This
supplements the shared-handler fast/plain differential oracle; it does not claim
complete terminal compatibility. All failures, correctness logs and paired timing
sessions remain here. No timing is allowed before both arms pass correctness.

## Final result

**REJECTED**: truecolor median paired CPU-rate ratio 1.001550, 8/12 wins,
Holm p=1.0. 24/24 prescribed sessions retained. No runtime promotion.

Each final arm passed 384 terminal tests, 1,659 explicit template cases and
12,800 differential streams. An untimed FG/BG-swapped common-handler mutant
passes all 12,800 differential streams but fails the new explicit oracle.
Only this test addition remains in production source; runtime handler restored.

Full protocol, limitations, failures, preservation and next requirements:
`../../../reports/research-1eecf9876bb302e9da10ff629e71e6d8-32.txt`.

```sh
python3 -B bench/results/2026-11-03-pen-dispatch/verify.py
python3 -B bench/results/2026-11-03-pen-dispatch/mutation-check.py
python3 -B bench/replay-evidence-index.py \
  bench/results/2026-11-03-pen-dispatch/final-frozen-index.json
```

No fallback rebuild: exact temporary executables are replay dependencies, not
permission to attach old scores to a newly built arm. `repair-log.txt` lists
retained setup/build/test failures; none is a deleted timing observation.
