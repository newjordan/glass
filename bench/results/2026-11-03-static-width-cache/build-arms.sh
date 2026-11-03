#!/bin/bash
set -euo pipefail
D=bench/results/2026-11-03-static-width-cache
# Always restore tracked source; retained candidates are never promoted here.
trap 'cp "$D/control-engine.rs" crates/term/src/engine.rs' EXIT
cargo test --release -p glass-term --locked --no-run --message-format=json > "$D/build-control.jsonl" 2> "$D/build-control.log"
python3 - "$D/build-control.jsonl" /tmp/glass-i22-control-test <<'PY'
import json,sys,shutil
rows=[json.loads(s) for s in open(sys.argv[1])]
p=[r['executable'] for r in rows if r.get('reason')=='compiler-artifact' and r.get('executable') and r['target']['name']=='glass' and r['profile']['test']]
assert len(p)==1,p
shutil.copy2(p[0],sys.argv[2])
PY
python3 - <<'PY'
from pathlib import Path
D=Path('bench/results/2026-11-03-static-width-cache');p=Path('crates/term/src/engine.rs');s=p.read_text()
a=s.index('    use std::sync::atomic::{AtomicI8, Ordering};',s.index('fn width_of(c: char)'))
b=s.index('\n}\n',a)
s=s[:a]+'''    use std::sync::atomic::{AtomicU8, Ordering};
    // Const-zero storage lives in BSS. Only queried codepoints are filled;
    // there is no heap allocation or whole-codespace first-use initialization.
    // 0 = unasked, 1..=4 = width + 1, 255 = None. All racing fills agree.
    static CACHE: [AtomicU8; 0x110000] = [const { AtomicU8::new(0) }; 0x110000];
    let slot = &CACHE[c as usize];
    let value = slot.load(Ordering::Relaxed);
    match value {
        0 => {
            let width = unicode_width::UnicodeWidthChar::width(c);
            slot.store(width.map_or(255, |width| width as u8 + 1), Ordering::Relaxed);
            width
        }
        255 => None,
        value => Some((value - 1) as usize),
    }'''+s[b:]
p.write_text(s);(D/'diagnostic-candidate-engine.rs').write_text(s)
PY
cargo test --release -p glass-term --locked --no-run --message-format=json > "$D/build-candidate.jsonl" 2> "$D/build-candidate.log"
python3 - "$D/build-candidate.jsonl" /tmp/glass-i22-candidate-test <<'PY'
import json,sys,shutil
rows=[json.loads(s) for s in open(sys.argv[1])]
p=[r['executable'] for r in rows if r.get('reason')=='compiler-artifact' and r.get('executable') and r['target']['name']=='glass' and r['profile']['test']]
assert len(p)==1,p
shutil.copy2(p[0],sys.argv[2])
PY
