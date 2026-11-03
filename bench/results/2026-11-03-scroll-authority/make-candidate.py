#!/usr/bin/env python3
"""Single frozen candidate, applied only to exact original runtime sources."""
from pathlib import Path
D=Path(__file__).resolve().parent
ROOT=D.parents[2]

def original(p):
    text=(D/('original-'+p.replace('/','_'))).read_text()
    assert (ROOT/p).read_text()==text, p
    return text

def sub(s,a,b):
    assert s.count(a)==1, (s.count(a),a[:100])
    return s.replace(a,b)

p='crates/alacritty-terminal/src/grid/mod.rs'; s=original(p)
s=sub(s,'pub fn clear_viewport<D>(&mut self)','pub fn clear_viewport<D>(&mut self) -> usize')
s=sub(s,'            self.raw[line].reset(&self.cursor.template);\n        }\n    }\n\n    /// Completely reset', '            self.raw[line].reset(&self.cursor.template);\n        }\n        positions\n    }\n\n    /// Completely reset')
(ROOT/p).write_text(s)
p='crates/alacritty-terminal/src/term/mod.rs'; s=original(p)
s=sub(s,'    pub selection: Option<Selection>,','    pub selection: Option<Selection>,\n\n    /// Primary-screen rows output pushed off row zero, independent of retained history.\n    /// Resize/reflow and alternate-screen output are excluded. RIS does not reset it.\n    output_scrolls: u64,')
s=sub(s,'            selection: Default::default(),','            selection: Default::default(),\n            output_scrolls: 0,')
s=sub(s,'impl<T> Term<T> {','impl<T> Term<T> {\n    #[inline]\n    pub fn output_scrolls(&self) -> u64 { self.output_scrolls }\n')
s=sub(s,'        self.grid.scroll_up(&region, lines);','        self.grid.scroll_up(&region, lines);\n        if origin == 0 && !self.mode.contains(TermMode::ALT_SCREEN) {\n            self.output_scrolls = self.output_scrolls.saturating_add(lines as u64);\n        }')
s=sub(s,'                    self.grid.clear_viewport();','                    let pushed = self.grid.clear_viewport();\n                    self.output_scrolls = self.output_scrolls.saturating_add(pushed as u64);')
(ROOT/p).write_text(s)
p='crates/term/src/engine.rs'; s=original(p)
s=sub(s,'use alacritty_terminal::index::{Line, Point as GridPoint, Side};\nuse alacritty_terminal::selection::{Selection as Sentinel, SelectionType};','use alacritty_terminal::index::Line;')
a=s.index('/// Bytes fed to `Term` between'); b=s.index('/// What the program\'s output asked',a)
s=s[:a]+'/// Preserve the existing per-apply batching while changing only scroll observation.\nconst SCROLL_COUNT_CHUNK: usize = 8192;\n\n'+s[b:]
s=s.replace('sentinel_read','scroll_read')
s=sub(s,'    /// Where the sentinel was last read, in lines above the screen.\n    scroll_read: usize,\n    /// Whether the sentinel was planted and `Term` has dropped it since.\n    sentinel_dropped: bool,','    /// Last consumed primary output-scroll counter.\n    scroll_read: u64,')
s=sub(s,'            sentinel_dropped: false,\n','')
a=s.index('    /// Whether the sentinel is planted right now.');b=s.index('    sentinel_alive: bool,',a)+len('    sentinel_alive: bool,\n')
s=s[:a]+s[b:]
s=s.replace('            sentinel_alive: false,\n','')
a=s.index('        // The sentinel is planted before the bytes run');b=s.index('        for chunk in pass.chunks',a)
s=s[:a]+s[b:]
s=s.replace('                sentinel_alive: self.sentinel_alive,\n','').replace('                drained: chunk.len(),\n','')
s=s.replace('            self.sentinel_alive = watch.sentinel_alive;\n','')
s=sub(s,'            feed(processor, &mut watch, mirror, chunk, *fast);','            feed(processor, &mut watch, mirror, chunk, *fast);\n            watch.fold_scrolls();')
s=s.replace('fold_sentinel()', 'fold_scrolls()')
a=s.index('    /// Plant the sentinel selection the scroll counter reads:');b=s.index('    /// Settle the engine for a media piece:',a)
s=s[:a]+'''    /// Consume actual primary output movement, not selection rotation.
    fn fold_scrolls(&mut self) {
        let now = self.term.output_scrolls();
        self.scrolled_off_top = self.scrolled_off_top.saturating_add(
            now.saturating_sub(self.scroll_read) as usize);
        self.scroll_read = now;
    }

'''+s[b:]
s=s.replace('                sentinel_alive,\n','').replace('                sentinel_alive: *sentinel_alive,\n','').replace('                drained: 0,\n','')
s=sub(s,'            processor.stop_sync(&mut watch);','            processor.stop_sync(&mut watch);\n            watch.fold_scrolls();')
a=s.index('    /// The sentinel\'s state, carried for the engine:');b=s.index('    /// Exclusive end of anchored content',a)
s=s[:a]+'''    /// Last consumed primary output counter, carried across wrappers.
    scroll_read: u64,
'''+s[b:]
s=s.replace('            sentinel_alive: engine.sentinel_alive,\n','').replace('            drained: 0,\n','')
a=s.index('    /// Plant the sentinel selection the scroll counter reads, mirroring');b=s.index('    /// The absolute line a grid row is on.',a)
s=s[:a]+'''    /// Consume primary output movement. Alternate output has its existing
    /// separate mirror; Term's counter never includes alternate scrolling.
    fn fold_scrolls(&mut self) {
        if self.alternate { return; }
        let now = self.term.output_scrolls();
        self.count = self.count.saturating_add(now.saturating_sub(self.scroll_read));
        self.scroll_read = now;
        self.base = self.count;
    }

'''+s[b:]
# Eliminate printed-cell pacing, not the scroll/event hooks themselves.
block='''        if self.drained >= SYNC_DRAIN_CHUNK {
            self.fold_scrolls();
            self.drained = 0;
        }
'''
assert s.count(block)==6, s.count(block)
s=s.replace(block,'')
import re
s,n=re.subn(r'^\s*self\.drained \+= (?:1|written);\n','\n',s,flags=re.M)
assert n==7,n
s=s.replace('        self.plant_sentinel();\n','')
a=s.index('            // The fold the band measurement took on every scroll was');b=s.index('            if self.alternate && count_delta > 0 {',a)
s=s[:a]+s[b:]
a=s.index('            // How many lines `Term` will push into history'); b=s.index('            // The count the store clears from',a)
s=s[:a]+s[b:]
s=sub(s,'''            if !alternate {
                self.count += pushed;
                self.base = self.count;
            }
            self.replant();''','''            self.fold_scrolls();''')
s=s.replace('            self.replant();\n','').replace('        self.replant();\n','')
# Remove stale sentinel-only explanatory comments; no semantics.
s=s.replace('        // Pace the sentinel while a synchronized update\'s frame is\n        // applied: a long frame cannot scroll it through a full history\n        // before it is read.\n','')
s=s.replace('            // A pacing fold inside the chunk may have counted scrolls\n            // past what the sentinel now reads; the chunk\'s own count is\n            // the truth, so take it over wholesale.\n','')
assert all(t not in s for t in ['self.drained','sentinel_alive','sentinel_dropped','plant_sentinel','SYNC_DRAIN_CHUNK','GridPoint','Side::'])
(ROOT/p).write_text(s)
print('Candidate applied to engine, Term, and Grid; test sources unchanged.')
