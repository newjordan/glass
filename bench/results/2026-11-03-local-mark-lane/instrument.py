#!/usr/bin/env python3
"""Prepare a separate counted source after fixed timing; never edit measured ELFs."""
from pathlib import Path
import hashlib
import json
D = Path(__file__).resolve().parent
ROOT = D.parents[2]

def replace(text, old, new):
    assert text.count(old) == 1, old
    return text.replace(old, new)

def main():
    # Explicit equality disallows instrumenting another revision by accident.
    p = ROOT / 'crates/term/src/engine.rs'
    text = p.read_text()
    assert text == (D / 'candidate-crates_term_src_engine.rs').read_text()
    text = replace(text, '    fn input(&mut self, c: char) {\n', '''    fn input(&mut self, c: char) {
        if width_of(c) == Some(0) {
            local_mark_census::FALLBACK.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        }
''')
    text = replace(text, '                            cells[base].push_zerowidth(last);', '''                            local_mark_census::LOCAL.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
                            cells[base].push_zerowidth(last);''')
    text += '''
#[cfg(test)]
pub(crate) mod local_mark_census {
    use std::sync::atomic::AtomicUsize;
    pub static LOCAL: AtomicUsize = AtomicUsize::new(0);
    pub static FALLBACK: AtomicUsize = AtomicUsize::new(0);
    pub fn is_zero(c: char) -> bool { super::width_of(c) == Some(0) }
}
'''
    q = ROOT / 'crates/term/src/speed.rs'
    test = q.read_text()
    assert test == (D / 'candidate-crates_term_src_speed.rs').read_text()
    test += '''
/// Opportunity census only: the instrumented binary is not a timing arm.
#[test]
#[ignore]
fn local_mark_lane_census() {
    use std::sync::atomic::Ordering;
    let streams = workloads(2.0, ROWS, COLS);
    let (_, stream) = streams.iter().find(|(name, _)| *name == "unicode").unwrap();
    let expected = std::str::from_utf8(stream).unwrap().chars()
        .filter(|&c| crate::engine::local_mark_census::is_zero(c)).count();
    let (mut e, mut i, mut s) = (engine(ROWS, COLS), Intake::new(glass_window::LAYER_PICTURES), Splitter::default());
    feed(&mut e, &mut i, &mut s, b"\\x1b[0m\\x1b[H\\x1b[2J", 4095);
    crate::engine::local_mark_census::LOCAL.store(0, Ordering::Relaxed);
    crate::engine::local_mark_census::FALLBACK.store(0, Ordering::Relaxed);
    feed(&mut e, &mut i, &mut s, stream, 4095);
    let local = crate::engine::local_mark_census::LOCAL.load(Ordering::Relaxed);
    let fallback = crate::engine::local_mark_census::FALLBACK.load(Ordering::Relaxed);
    eprintln!("LOCAL_MARK_CENSUS bytes={} read=4095 expected={} local={} fallback={}", stream.len(), expected, local, fallback);
    assert!(local > 0);
    assert!(fallback > 0, "boundary marks must remain eligible for fallback");
    assert_eq!(local + fallback, expected);
}
'''
    # Check the authoritative width export before writing any live input.
    # The builder performs its own exact-source hashes and fresh recompilation.
    p.write_text(text)
    q.write_text(test)
    for path in [p, q]:
        (D / ('instrumented-' + str(path.relative_to(ROOT)).replace('/', '_'))).write_bytes(path.read_bytes())
    (D / 'instrumented-source-sha256.json').write_text(json.dumps({str(path.relative_to(ROOT)): hashlib.sha256(path.read_bytes()).hexdigest() for path in [p, q]}, indent=2) + '\n')

if __name__ == '__main__':
    main()
