#!/usr/bin/env python3
"""Apply exact crop-provenance candidate to the frozen shipping sources."""
from pathlib import Path
D = Path(__file__).resolve().parent
ROOT = D.parents[2]
def change(path, pairs):
    text = (D / ('original-' + path.replace('/', '_'))).read_text()
    for old, new in pairs:
        assert text.count(old) == 1, repr(old)
        text = text.replace(old, new)
    (ROOT / path).write_text(text)
change('crates/term/src/intake/motion.rs', [
('pub enum Fate {\n    Keep(Rect),', 'pub enum Fate<T = Rect> {\n    Keep(T),'),
('Split(Rect, Vec<Rect>),', 'Split(T, Vec<T>),'),
('/// Move or cut `rect` through one band scroll.', '''/// One surviving slice, with its first cell row in this call's input rectangle.
/// Screen displacement is not this offset: moving up can cut the top while
/// leaving the screen line unchanged, and moving down can cut only the bottom.
#[derive(Clone, Debug)]
pub struct ScrolledRect {
    pub rect: Rect,
    pub from: u16,
}

/// Move or cut `rect` through one band scroll.'''),
('pub fn scroll_rect(rect: Rect, band: &BandScroll, image: (u32, u32)) -> Fate {', '''pub fn scroll_rect(rect: Rect, band: &BandScroll, image: (u32, u32)) -> Fate {
    match scroll_rect_with_rows(rect, band, image) {
        Fate::Keep(piece) => Fate::Keep(piece.rect),
        Fate::Split(first, rest) => {
            Fate::Split(first.rect, rest.into_iter().map(|piece| piece.rect).collect())
        }
        Fate::Gone => Fate::Gone,
    }
}

/// The same geometry with exact input-row provenance for coverage transport.
/// Offsets saturate at the coverage domain's limit; no tracked row survives
/// a cut at or beyond u16::MAX.
pub fn scroll_rect_with_rows(rect: Rect, band: &BandScroll, image: (u32, u32)) -> Fate<ScrolledRect> {'''),
('if rect.height <= 0.0 || rect.width <= 0.0 {\n        return Fate::Keep(rect);', 'if rect.height <= 0.0 || rect.width <= 0.0 {\n        return Fate::Keep(ScrolledRect { rect, from: 0 });'),
('if bottom <= top {\n        return Fate::Keep(rect);', 'if bottom <= top {\n        return Fate::Keep(ScrolledRect { rect, from: 0 });'),
('let mut pieces = Vec::new();', 'let mut pieces: Vec<ScrolledRect> = Vec::new();'),
('&& adjacent(prev, &piece)', '&& adjacent(&prev.rect, &piece)'),
('merge(prev, &piece);', 'merge(&mut prev.rect, &piece);'),
('pieces.push(piece);', 'pieces.push(ScrolledRect { rect: piece, from: from as u16 });'),
])
change('crates/term/src/intake/mod.rs', [
('''fn apply_moved(put: &mut Put, rect: &motion::Rect) {
    let cut_top = if rect.height + 0.01 < put.height && rect.line >= put.line {
        (rect.line - put.line) as u16
    } else {
        0
    };
    if cut_top > 0 || rect.height + 0.01 < put.height {
        put.covered.crop_rows(cut_top, rect.height.ceil().max(0.0) as u16);
    }''', '''fn apply_moved(put: &mut Put, piece: &motion::ScrolledRect) {
    let rect = &piece.rect;
    let rows = rect.height.ceil().max(0.0) as u16;
    if piece.from > 0 || rows != put.height.ceil().max(0.0) as u16 {
        put.covered.crop_rows(piece.from, rows);
    }'''),
('match motion::scroll_rect(rect, band, image)', 'match motion::scroll_rect_with_rows(rect, band, image)'),
])
