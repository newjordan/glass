//! Experimental resize-only provenance. No tags enter the live grid or Cell.
use super::{Cursor, Dimensions, Grid, GridCell, Row};
use crate::index::{Column, Line, Point};
use crate::term::cell::{Flags, ResetDiscriminant};

#[derive(Clone, Debug, Default)]
struct Tagged<T> {
    cell: T,
    origin: Option<Point>,
}

// Provenance must not affect any resize branch, including blank-row trimming.
impl<T: PartialEq> PartialEq for Tagged<T> {
    fn eq(&self, other: &Self) -> bool { self.cell == other.cell }
}
impl<T: GridCell> GridCell for Tagged<T> {
    fn is_empty(&self) -> bool { self.cell.is_empty() }
    fn reset(&mut self, template: &Self) {
        self.cell.reset(&template.cell);
        self.origin = None;
    }
    fn flags(&self) -> &Flags { self.cell.flags() }
    fn flags_mut(&mut self) -> &mut Flags { self.cell.flags_mut() }
    fn strip_stale(&mut self) { self.cell.strip_stale(); self.origin = None; }
    fn has_extra(&self) -> bool { self.cell.has_extra() }
    fn style_eq(&self, other: &Self) -> bool { self.cell.style_eq(&other.cell) }
}
impl<T: ResetDiscriminant<D>, D> ResetDiscriminant<D> for Tagged<T> {
    fn discriminant(&self) -> D { self.cell.discriminant() }
}

fn cursor<T: Clone>(old: &Cursor<T>) -> Cursor<Tagged<T>> {
    Cursor {
        point: old.point,
        template: Tagged { cell: old.template.clone(), origin: None },
        charsets: old.charsets,
        input_needs_wrap: old.input_needs_wrap,
    }
}

impl<T: GridCell + Default + PartialEq + std::fmt::Debug> Grid<T> {
    /// Replay primary-grid resize with origin tags ignored by cell semantics.
    /// Absent destination means the actual resize erased/trimmed that old cell.
    /// Research only: allocates O(retained cells) and does not meet a latency gate.
    pub fn resize_origins<D>(&self, lines: usize, columns: usize) -> Vec<Option<(i32, usize)>>
    where T: ResetDiscriminant<D>, D: PartialEq,
    {
        let mut shadow = Grid {
            raw: self.raw.map_rows(|row| Row::from_vec(
                row.observable().cloned().map(|cell| Tagged { cell, origin: None }).collect(),
                row.occ,
            )),
            columns: self.columns,
            lines: self.lines,
            display_offset: self.display_offset,
            max_scroll_limit: self.max_scroll_limit,
            cursor: cursor(&self.cursor),
            saved_cursor: cursor(&self.saved_cursor),
        };
        let history = self.history_size();
        for row in -(history as i32)..self.lines as i32 {
            let source = &self.raw[Line(row)];
            shadow.raw[Line(row)] = Row::from_vec(source.observable().cloned().enumerate().map(|(col, cell)| Tagged {
                cell, origin: Some(Point::new(Line(row), Column(col))),
            }).collect(), source.occ);
        }
        shadow.resize(true, lines, columns);
        // Active differential guard: tags must never alter the real cell result.
        let mut reference = self.clone();
        reference.resize(true, lines, columns);
        assert_eq!(reference.history_size(), shadow.history_size(), "shadow history diverged");
        assert_eq!(reference.display_offset, shadow.display_offset, "shadow display diverged");
        assert_eq!(reference.cursor.point, shadow.cursor.point, "shadow cursor diverged");
        assert_eq!(reference.cursor.input_needs_wrap, shadow.cursor.input_needs_wrap);
        assert_eq!(reference.saved_cursor.point, shadow.saved_cursor.point);
        let mut destinations = vec![None; (history + self.lines) * self.columns];
        for row in -(shadow.history_size() as i32)..lines as i32 {
            for (col, tagged) in shadow.raw[Line(row)].observable().enumerate() {
                assert_eq!(&tagged.cell, &reference.raw[Line(row)][Column(col)], "shadow cell diverged");
                if let Some(origin) = tagged.origin {
                    let index = (origin.line.0 + history as i32) as usize * self.columns + origin.column.0;
                    assert!(destinations[index].is_none(), "origin duplicated");
                    destinations[index] = Some((row, col));
                }
            }
        }
        destinations
    }
}
