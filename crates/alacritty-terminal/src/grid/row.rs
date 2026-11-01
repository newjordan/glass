// Changed for glass from alacritty_terminal 0.26.0; CHANGES.md lists every change.
// - `Row::new` fills the row safely, with no minimum width (upstream's fix,
//   alacritty/alacritty@d692748d).

//! Defines the Row type which makes up lines in the grid.

use std::cmp::{max, min};
use std::ops::{Index, IndexMut, Range, RangeFrom, RangeFull, RangeTo, RangeToInclusive};
use std::{iter, slice};


use crate::grid::GridCell;
use crate::index::Column;
use crate::term::cell::ResetDiscriminant;

/// A row in the grid.
#[derive(Default, Clone, Debug)]
pub struct Row<T> {
    inner: Vec<T>,

    /// Maximum number of occupied entries.
    ///
    /// This is the upper bound on the number of elements in the row, which have been modified
    /// since the last reset. All cells after this point are guaranteed to be equal.
    pub(crate) occ: usize,

    /// Lazy recycle: when set, every cell at or past `occ` is *observably*
    /// `blank` even though `inner` still holds the row's previous contents.
    /// A scroll that recycles this row pays one `occ` store and one blank
    /// store instead of resetting ~cols cells into the coldest row of the
    /// ring; the next line's output then overwrites those bytes hot. Reads
    /// past `occ` borrow the blank; the first write past `occ` materializes
    /// cells one at a time, so a row rewritten left-to-right (the flood)
    /// never stores a blank it is about to overwrite.
    pub(crate) blank: Option<T>,
}

// Changed for glass: serde for Row is derived from the *observable* row.
// The lazy blank never persists: a row reaching a serialize boundary has
// had its tail materialized (every mutating path materializes on write,
// and `reset`/`materialize_all` do it explicitly), so `blank` is None
// wherever serde ever sees the row. The derive therefore round-trips the
// observable bytes; no T: Default is needed because blank is skipped.
#[cfg(feature = "serde")]
impl<T: serde::Serialize> serde::Serialize for Row<T> {
    fn serialize<S: serde::Serializer>(&self, serializer: S) -> Result<S::Ok, S::Error> {
        use serde::ser::SerializeStruct;
        let mut state = serializer.serialize_struct("Row", 2)?;
        // The observable cells: a lazily recycled tail must serialize as
        // the blanks it stands for, never the stale physical bytes.
        let observable: Vec<&T> = (0..self.inner.len()).map(|i| self.virtual_cell(i)).collect();
        state.serialize_field("inner", &observable)?;
        state.serialize_field("occ", &self.occ)?;
        state.end()
    }
}

#[cfg(feature = "serde")]
impl<'de, T: serde::Deserialize<'de>> serde::Deserialize<'de> for Row<T> {
    fn deserialize<D: serde::Deserializer<'de>>(deserializer: D) -> Result<Self, D::Error> {
        #[derive(serde::Deserialize)]
        #[serde(field_identifier, rename_all = "lowercase", crate = "serde")]
        enum Field { Inner, Occ }
        struct RowVisitor<T>(std::marker::PhantomData<T>);
        impl<'de, T: serde::Deserialize<'de>> serde::de::Visitor<'de> for RowVisitor<T> {
            type Value = Row<T>;
            fn expecting(&self, formatter: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
                formatter.write_str("a Row struct")
            }
            fn visit_seq<V: serde::de::SeqAccess<'de>>(
                self,
                mut seq: V,
            ) -> Result<Self::Value, V::Error> {
                let inner: Vec<T> = seq
                    .next_element()?
                    .ok_or_else(|| serde::de::Error::missing_field("inner"))?;
                let occ: usize = seq
                    .next_element()?
                    .ok_or_else(|| serde::de::Error::missing_field("occ"))?;
                Ok(Row { inner, occ, blank: None })
            }
            fn visit_map<V: serde::de::MapAccess<'de>>(
                self,
                mut map: V,
            ) -> Result<Self::Value, V::Error> {
                let mut inner: Option<Vec<T>> = None;
                let mut occ: Option<usize> = None;
                while let Some(key) = map.next_key::<Field>()? {
                    match key {
                        Field::Inner => {
                            if inner.is_some() {
                                return Err(serde::de::Error::duplicate_field("inner"));
                            }
                            inner = Some(map.next_value()?);
                        }
                        Field::Occ => {
                            if occ.is_some() {
                                return Err(serde::de::Error::duplicate_field("occ"));
                            }
                            occ = Some(map.next_value()?);
                        }
                    }
                }
                let inner = inner.ok_or_else(|| serde::de::Error::missing_field("inner"))?;
                let occ = occ.ok_or_else(|| serde::de::Error::missing_field("occ"))?;
                Ok(Row { inner, occ, blank: None })
            }
        }
        deserializer.deserialize_struct(
            "Row",
            &["inner", "occ"],
            RowVisitor(std::marker::PhantomData),
        )
    }
}

impl<T> Row<T> {
    /// The cell a read at `index` must observe: the lazy blank when this
    /// row is recycled and `index` is past `occ`, the physical cell
    /// otherwise.
    #[inline(always)]
    pub(crate) fn virtual_cell(&self, index: usize) -> &T {
        if let Some(blank) = self.blank.as_ref() {
            if index >= self.occ {
                return blank;
            }
        }
        &self.inner[index]
    }

    /// Make the physical cells valid from `occ` up to `end`, paying one
    /// clone per materialized cell. Rows that are not recycled, or whose
    /// tail is already physical past `end`, pay nothing.
    #[inline(always)]
    pub(crate) fn materialize_to(&mut self, end: usize)
    where
        T: Clone,
    {
        if let Some(blank) = self.blank.as_ref() {
            let start = self.occ.min(self.inner.len());
            let stop = end.min(self.inner.len());
            if fill_census::on() {
                fill_census::note_site(5, stop > start);
            }
            let stop = end.min(self.inner.len());
            if stop > start {
                let blank = blank.clone();
                for cell in &mut self.inner[start..stop] {
                    *cell = blank.clone();
                }
            }
            if stop < self.inner.len() {
                return;
            }
            // The whole tail is physical: the blank retires for good.
            self.blank = None;
        }
    }

    /// Materialize the entire tail, for the paths that need the raw slice
    /// (insert/delete shifts, reflow on resize, the ceiling probes) and for
    /// `reset`, whose discriminant check reads the last physical cell.
    pub(crate) fn materialize_all(&mut self)
    where
        T: Clone,
    {
        self.materialize_to(self.inner.len());
    }

    /// The number of leading cells whose physical bytes are valid. Cells
    /// past this are observably the lazy blank when one is set.
    #[inline(always)]
    pub(crate) fn physical_len(&self) -> usize {
        if self.blank.is_some() {
            self.occ.min(self.inner.len())
        } else {
            self.inner.len()
        }
    }

    /// The physical prefix of the row, for scanners that must not read
    /// stale bytes from a lazily recycled tail.
    #[inline]
    pub(crate) fn physical_cells(&self) -> &[T] {
        &self.inner[..self.physical_len()]
    }

    /// Every observable cell of the row, left to right: the physical
    /// prefix, then the lazy blank repeated for the virtual tail. What a
    /// reader sees; never the stale bytes `into_iter`/`iter` would hand
    /// out for a recycled row.
    pub fn observable(&self) -> impl Iterator<Item = &T> {
        let physical = self.physical_len();
        let tail = self
            .blank
            .as_ref()
            .map(|blank| std::iter::repeat(blank).take(self.inner.len() - physical));
        self.inner[..physical].iter().chain(tail.into_iter().flatten())
    }

    /// Recycle this row for a scroll: observably blank from column zero,
    /// physically untouched. The recycled cells are paid for by whoever
    /// reads or writes them, never by the scroll itself.
    ///
    /// The blank is the canonical cell `reset` would have stored — for
    /// `Cell` that is `bg` from the template with every other field
    /// default — *not* the template itself, whose pen flags and foreground
    /// must not leak into empty cells.
    #[inline]
    pub(crate) fn recycle(&mut self, template: &T)
    where
        T: GridCell + Default,
    {
        let mut blank = T::default();
        blank.reset(template);
        self.occ = 0;
        self.blank = Some(blank);
    }
}

impl<T: PartialEq> PartialEq for Row<T> {
    fn eq(&self, other: &Self) -> bool {
        // Observable equality: a lazily recycled row must compare equal to
        // the row an eager reset would have produced.
        self.inner.len() == other.inner.len()
            && (0..self.inner.len()).all(|i| self.virtual_cell(i) == other.virtual_cell(i))
    }
}

impl<T: Default> Row<T> {
    /// Create a new terminal row.
    pub fn new(columns: usize) -> Row<T> {
        let inner = iter::repeat_with(T::default).take(columns).collect();
        Row { inner, occ: 0, blank: None }
    }

    /// Increase the number of columns in the row.
    #[inline]
    pub fn grow(&mut self, columns: usize) {
        if self.inner.len() >= columns {
            return;
        }

        self.inner.resize_with(columns, T::default);
    }

    /// Reduce the number of columns in the row.
    ///
    /// This will return all non-empty cells that were removed.
    pub fn shrink(&mut self, columns: usize) -> Option<Vec<T>>
    where
        T: GridCell,
    {
        if self.inner.len() <= columns {
            return None;
        }

        // Split off cells for a new row.
        let mut new_row = self.inner.split_off(columns);
        let index = new_row.iter().rposition(|c| !c.is_empty()).map_or(0, |i| i + 1);
        new_row.truncate(index);

        self.occ = min(self.occ, columns);

        if new_row.is_empty() { None } else { Some(new_row) }
    }

    /// Reset all cells in the row to the `template` cell.
    #[inline]
    pub fn reset<D>(&mut self, template: &T)
    where
        T: ResetDiscriminant<D> + GridCell + Clone,
        D: PartialEq,
    {
        debug_assert!(!self.inner.is_empty());

        // A lazily recycled row's tail is virtual; the discriminant check
        // below reads the last physical cell, so make it real first.
        self.materialize_all();

        // Mark all cells as dirty if template cell changed.
        let len = self.inner.len();
        if self.inner[len - 1].discriminant() != template.discriminant() {
            self.occ = len;
        }

        // Reset every dirty cell in the row.
        for item in &mut self.inner[0..self.occ] {
            item.reset(template);
        }

        self.occ = 0;
    }
}

#[allow(clippy::len_without_is_empty)]
impl<T> Row<T> {
    #[inline]
    pub fn from_vec(vec: Vec<T>, occ: usize) -> Row<T> {
        Row { inner: vec, occ, blank: None }
    }

    #[inline]
    pub fn len(&self) -> usize {
        self.inner.len()
    }

    #[inline]
    pub fn last(&self) -> Option<&T> {
        self.inner.last()
    }

    #[inline]
    pub fn last_mut(&mut self) -> Option<&mut T> {
        self.occ = self.inner.len();
        self.inner.last_mut()
    }

    #[inline]
    pub fn append(&mut self, vec: &mut Vec<T>)
    where
        T: GridCell,
    {
        self.occ += vec.len();
        self.inner.append(vec);
    }

    #[inline]
    pub fn append_front(&mut self, mut vec: Vec<T>) {
        self.occ += vec.len();

        vec.append(&mut self.inner);
        self.inner = vec;
    }

    /// Check if all cells in the row are empty.
    #[inline]
    pub fn is_clear(&self) -> bool
    where
        T: GridCell,
    {
        if let Some(blank) = self.blank.as_ref() {
            if !blank.is_empty() {
                return false;
            }
        }
        // For a lazily recycled row the tail is observably `blank`, so
        // only the physical prefix can hold content.
        let physical = if self.blank.is_some() {
            self.occ.min(self.inner.len())
        } else {
            self.inner.len()
        };
        self.inner[..physical].iter().all(GridCell::is_empty)
    }

    #[inline]
    pub fn front_split_off(&mut self, at: usize) -> Vec<T> {
        self.occ = self.occ.saturating_sub(at);

        let mut split = self.inner.split_off(at);
        std::mem::swap(&mut split, &mut self.inner);
        split
    }
}

impl<T> Row<T> {
    /// The observable cell at `col` by value, for `Copy` cell types: the
    /// lazy blank when the row is recycled past `occ`, the physical cell
    /// otherwise. Readers that need the value (not a reference) use this.
    #[inline]
    pub(crate) fn virtual_read(&self, col: usize) -> &T {
        self.virtual_cell(col)
    }

    /// Clear flag bits on the observable cell at `col`, materializing the
    /// lazy tail only if that column is past the frontier.
    #[inline]
    pub(crate) fn flags_remove(&mut self, col: usize, f: crate::term::cell::Flags)
    where
        T: GridCell,
    {
        self.materialize_to(col + 1);
        self.inner[col].flags_mut().remove(f);
    }

    /// Record that the cell at `col` was written, advancing the observable
    /// frontier past it without materializing anything.
    #[inline]
    pub(crate) fn occ_bump(&mut self, col: usize) {
        self.occ = max(self.occ, col + 1);
    }

    /// Raw slice accessor for the print-run lane, bypassing the materializing
    /// IndexMut impls: the caller has already arranged observability.
    #[inline]
    pub(crate) fn lane_slice(&mut self, column: usize, end: usize) -> &mut [T] {
        &mut self.inner[column..end]
    }

    /// Full-overwrite single-cell accessor for the UTF-8 print paths
    /// (`put_row`, `put_plain`): the caller replaces every field of the
    /// cell, so the stale physical byte never becomes observable and no
    /// blank fill is paid for a cell the write itself makes valid. Only
    /// the gap between the physical frontier and `col` — empty for a
    /// left-to-right writer — is materialized. `occ` moves past the
    /// write, keeping every reader's blank frontier honest.
    #[inline(always)]
    pub(crate) fn overwrite_cell(&mut self, col: usize) -> &mut T
    where
        T: Clone,
    {
        self.materialize_to(col);
        self.occ = max(self.occ, col + 1);
        &mut self.inner[col]
    }

    /// Full-overwrite single-cell write. The caller replaces every field
    /// of the cell, so the stale physical byte never becomes observable:
    /// only the gap between the physical frontier and `col` needs blanks,
    /// and for a left-to-right writer that gap is always empty. This is
    /// the flood's fast path — one store per cell, no blank fill.
    ///
    /// Returns the observable flags the write replaced, so the caller's
    /// wide-char handling needs no second access. Flags is Copy.
    #[inline(always)]
    pub(crate) fn write_cell(&mut self, col: usize, cell: T) -> crate::term::cell::Flags
    where
        T: GridCell,
    {
        // Fast path first: a row that was never recycled, or whose
        // frontier is already past the write, is a plain store. Flags is
        // Copy, so the under-flags leave the borrow before the store.
        let physical_write = match self.blank.as_ref() {
            None => true,
            Some(_) => col < self.occ,
        };
        let under = if physical_write {
            self.inner[col].flags()
        } else {
            self.virtual_cell(col).flags()
        };
        let under = *under;
        if !physical_write {
            self.materialize_to(col);
        }
        self.inner[col] = cell;
        if col + 1 > self.occ {
            self.occ = col + 1;
        }
        under
    }

    /// The print-run write lane. The caller overwrites *every* cell of
    /// `column..column+n` in full, so only the gap between the physical
    /// frontier and the write's left edge is materialized; the write range
    /// itself pays nothing, and a recycled row rewritten left-to-right
    /// stores no blank it is about to overwrite.
    ///
    /// Returns the raw slice plus `virtual_from`: the column from which
    /// the observable cells are blank while their physical bytes are
    /// stale. A caller that reads flags underneath its write must treat
    /// cells at or past that column as blank, never as stale bytes.
    #[inline]
    pub(crate) fn lane_cells(&mut self, column: usize, n: usize) -> (&mut [T], usize)
    where
        T: Clone,
    {
        let virtual_from = match self.blank.as_ref() {
            Some(_) => self.occ,
            None => usize::MAX,
        };
        self.materialize_to(column);
        let end = (column + n).min(self.inner.len());
        self.occ = max(self.occ, end);
        (&mut self.inner[column..end], virtual_from)
    }
}

/// Fill census for the lazy recycled-row mechanism (GLASS_FILL_CENSUS=1).
///
/// Iteration 12's post-landing census counted fills but could not name the
/// caller: 2.75M fills on unicode were "all IndexMut", with the site among
/// input/wrapline/put_plain unmeasured. This census buckets every fill by
/// width (`end - occ` at fill time) and counts separately the writes that
/// needed NO fill — the answer falls out arithmetically:
///
/// * width 0 notes are materializations that found nothing to do (already
///   physical) — the caller paid the call, not a fill.
/// * the width histogram says which IndexMut arm: a `Column` access past the
///   frontier fills a short gap; `Range`/`RangeFull` arms fill to `end`.
///
/// Counters are process-wide atomics gated on a OnceLock env read, so the
/// production parse path pays one relaxed load when off.
pub mod fill_census {
    use std::sync::atomic::{AtomicBool, AtomicU64, Ordering};

    pub static ON: AtomicBool = AtomicBool::new(false);
    pub static NOTES: AtomicU64 = AtomicU64::new(0);
    pub static CELLS: AtomicU64 = AtomicU64::new(0);
    /// Fills by width: 0 (already physical), 1, 2, 3-4, 5-8, 9-16, 17+.
    pub static W: [AtomicU64; 7] = [const { AtomicU64::new(0) }; 7];
    /// Call-site census: 0=write_cell, 1=IndexMut<Column>, 2=IndexMut<Range*>,
    /// 3=flags_remove, 4=lane, 5=other (serde/into_iter/explicit).
    pub static SITE: [AtomicU64; 6] = [const { AtomicU64::new(0) }; 6];
    pub static SITE_NOTES: [AtomicU64; 6] = [const { AtomicU64::new(0) }; 6];

    pub fn init() {
        ON.store(
            std::env::var_os("GLASS_FILL_CENSUS").is_some_and(|v| v == "1"),
            Ordering::Relaxed,
        );
    }
    #[inline(always)]
    pub fn on() -> bool {
        ON.load(Ordering::Relaxed)
    }
    #[inline]
    pub fn note(width: usize) {
        NOTES.fetch_add(1, Ordering::Relaxed);
        if width > 0 {
            CELLS.fetch_add(width as u64, Ordering::Relaxed);
        }
        let b = match width {
            0 => 0,
            1 => 1,
            2 => 2,
            3 | 4 => 3,
            5..=8 => 4,
            9..=16 => 5,
            _ => 6,
        };
        W[b].fetch_add(1, Ordering::Relaxed);
    }
    /// Attribute a materialize_to caller: `site` indexes SITE, `filled`
    /// is whether this call actually paid cells.
    #[inline]
    pub fn note_site(site: usize, filled: bool) {
        if filled {
            SITE_NOTES[site].fetch_add(1, Ordering::Relaxed);
        } else {
            SITE[site].fetch_add(1, Ordering::Relaxed);
        }
    }
    pub fn report() {
        if !ON.load(Ordering::Relaxed) {
            return;
        }
        let w: Vec<u64> = W.iter().map(|c| c.load(Ordering::Relaxed)).collect();
        eprintln!(
            "fill-census: notes={} cells={} widths w0(already-physical)={} w1={} w2={} w3-4={} w5-8={} w9-16={} w17+=({} {} {})",
            NOTES.load(Ordering::Relaxed),
            CELLS.load(Ordering::Relaxed),
            w[0], w[1], w[2], w[3], w[4], w[5], w[6],
            w.iter().sum::<u64>(),
            w[1] + w[3] + w[4] + w[5] + w[6] // every width > 0
        );
        let sites: Vec<u64> = SITE.iter().map(|c| c.load(Ordering::Relaxed)).collect();
        let notes: Vec<u64> = SITE_NOTES.iter().map(|c| c.load(Ordering::Relaxed)).collect();
        eprintln!(
            "fill-sites: write_cell {}|{}  idx_col {}|{}  idx_range {}|{}  flags_remove {}|{}  lane {}|{}  other {}|{}  (no-fill|filled)",
            sites[0], notes[0], sites[1], notes[1], sites[2], notes[2], sites[3], notes[3], sites[4], notes[4], sites[5], notes[5]
        );
    }
}

impl<'a, T> IntoIterator for &'a Row<T> {
    type IntoIter = slice::Iter<'a, T>;
    type Item = &'a T;

    #[inline]
    fn into_iter(self) -> slice::Iter<'a, T> {
        self.inner.iter()
    }
}

impl<'a, T> IntoIterator for &'a mut Row<T> {
    type IntoIter = slice::IterMut<'a, T>;
    type Item = &'a mut T;

    #[inline]
    fn into_iter(self) -> slice::IterMut<'a, T> {
        self.occ = self.len();
        self.inner.iter_mut()
    }
}

impl<T> Index<Column> for Row<T> {
    type Output = T;

    #[inline]
    fn index(&self, index: Column) -> &T {
        self.virtual_cell(index.0)
    }
}

impl<T: Clone> IndexMut<Column> for Row<T> {
    #[inline]
    fn index_mut(&mut self, index: Column) -> &mut T {
        if fill_census::on() {
            fill_census::SITE[1].fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        }
        self.materialize_to(*index + 1);
        self.occ = max(self.occ, *index + 1);
        &mut self.inner[index.0]
    }
}

impl<T> Index<Range<Column>> for Row<T> {
    type Output = [T];

    #[inline]
    fn index(&self, index: Range<Column>) -> &[T] {
        &self.inner[(index.start.0)..(index.end.0)]
    }
}

impl<T: Clone> IndexMut<Range<Column>> for Row<T> {
    #[inline]
    fn index_mut(&mut self, index: Range<Column>) -> &mut [T] {
        if fill_census::on() {
            fill_census::SITE[2].fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        }
        self.materialize_to(*index.end);
        self.occ = max(self.occ, *index.end);
        &mut self.inner[(index.start.0)..(index.end.0)]
    }
}

impl<T> Index<RangeTo<Column>> for Row<T> {
    type Output = [T];

    #[inline]
    fn index(&self, index: RangeTo<Column>) -> &[T] {
        &self.inner[..(index.end.0)]
    }
}

impl<T: Clone> IndexMut<RangeTo<Column>> for Row<T> {
    #[inline]
    fn index_mut(&mut self, index: RangeTo<Column>) -> &mut [T] {
        self.materialize_to(*index.end);
        self.occ = max(self.occ, *index.end);
        &mut self.inner[..(index.end.0)]
    }
}

impl<T> Index<RangeFrom<Column>> for Row<T> {
    type Output = [T];

    #[inline]
    fn index(&self, index: RangeFrom<Column>) -> &[T] {
        &self.inner[(index.start.0)..]
    }
}

impl<T: Clone> IndexMut<RangeFrom<Column>> for Row<T> {
    #[inline]
    fn index_mut(&mut self, index: RangeFrom<Column>) -> &mut [T] {
        self.materialize_all();
        self.occ = self.len();
        &mut self.inner[(index.start.0)..]
    }
}

impl<T> Index<RangeFull> for Row<T> {
    type Output = [T];

    #[inline]
    fn index(&self, _: RangeFull) -> &[T] {
        &self.inner[..]
    }
}

impl<T: Clone> IndexMut<RangeFull> for Row<T> {
    #[inline]
    fn index_mut(&mut self, _: RangeFull) -> &mut [T] {
        self.materialize_all();
        self.occ = self.len();
        &mut self.inner[..]
    }
}

impl<T> Index<RangeToInclusive<Column>> for Row<T> {
    type Output = [T];

    #[inline]
    fn index(&self, index: RangeToInclusive<Column>) -> &[T] {
        &self.inner[..=(index.end.0)]
    }
}

impl<T: Clone> IndexMut<RangeToInclusive<Column>> for Row<T> {
    #[inline]
    fn index_mut(&mut self, index: RangeToInclusive<Column>) -> &mut [T] {
        self.materialize_to(*index.end + 1);
        self.occ = max(self.occ, *index.end + 1);
        &mut self.inner[..=(index.end.0)]
    }
}
