use std::cmp::max;
use std::mem;
use std::ops::{Index, IndexMut};

#[cfg(feature = "serde")]
use serde::{Deserialize, Serialize};

use super::Row;
use crate::index::Line;

/// Maximum number of buffered lines outside of the grid for performance optimization.
const MAX_CACHE_SIZE: usize = 1_000;

/// A ring buffer for optimizing indexing and rotation.
///
/// The [`Storage::rotate`] and [`Storage::rotate_down`] functions are fast modular additions on
/// the internal [`zero`] field. As compared with [`slice::rotate_left`] which must rearrange items
/// in memory.
///
/// As a consequence, both [`Index`] and [`IndexMut`] are reimplemented for this type to account
/// for the zeroth element not always being at the start of the allocation.
///
/// Because certain [`Vec`] operations are no longer valid on this type, no [`Deref`]
/// implementation is provided. Anything from [`Vec`] that should be exposed must be done so
/// manually.
///
/// [`slice::rotate_left`]: https://doc.rust-lang.org/std/primitive.slice.html#method.rotate_left
/// [`Deref`]: std::ops::Deref
/// [`zero`]: #structfield.zero
#[derive(Clone, Debug)]
#[cfg_attr(feature = "serde", derive(Serialize, Deserialize))]
pub struct Storage<T> {
    inner: Vec<Row<T>>,

    /// Starting point for the storage of rows.
    ///
    /// This value represents the starting line offset within the ring buffer. The value of this
    /// offset may be larger than the `len` itself, and will wrap around to the start to form the
    /// ring buffer. It represents the bottommost line of the terminal.
    zero: usize,

    /// Number of visible lines.
    visible_lines: usize,

    /// Total number of lines currently active in the terminal (scrollback + visible)
    ///
    /// Shrinking this length allows reducing the number of lines in the scrollback buffer without
    /// having to truncate the raw `inner` buffer.
    /// As long as `len` is bigger than `inner`, it is also possible to grow the scrollback buffer
    /// without any additional insertions.
    len: usize,
}

impl<T: PartialEq> PartialEq for Storage<T> {
    fn eq(&self, other: &Self) -> bool {
        // Both storage buffers need to be truncated and zeroed.
        assert_eq!(self.zero, 0);
        assert_eq!(other.zero, 0);

        self.inner == other.inner && self.len == other.len
    }
}

impl<T> Storage<T> {
    #[inline]
    pub fn with_capacity(visible_lines: usize, columns: usize) -> Storage<T>
    where
        T: Default + crate::grid::GridCell,
    {
        // Initialize visible lines; the scrollback buffer is initialized dynamically.
        let mut inner = Vec::with_capacity(visible_lines);
        inner.resize_with(visible_lines, || Row::new(columns));

        Storage { inner, zero: 0, visible_lines, len: visible_lines }
    }

    /// Increase the number of lines in the buffer.
    #[inline]
    pub fn grow_visible_lines(&mut self, next: usize)
    where
        T: Default + crate::grid::GridCell,
    {
        // Number of lines the buffer needs to grow.
        let additional_lines = next - self.visible_lines;

        let columns = self[Line(0)].len();
        self.initialize(additional_lines, columns);

        // Update visible lines.
        self.visible_lines = next;
    }

    /// Decrease the number of lines in the buffer.
    #[inline]
    pub fn shrink_visible_lines(&mut self, next: usize) {
        // Shrink the size without removing any lines.
        let shrinkage = self.visible_lines - next;
        self.shrink_lines(shrinkage);

        // Update visible lines.
        self.visible_lines = next;
    }

    /// Shrink the number of lines in the buffer.
    #[inline]
    pub fn shrink_lines(&mut self, shrinkage: usize) {
        self.len -= shrinkage;

        // Free memory.
        if self.inner.len() > self.len + MAX_CACHE_SIZE {
            self.truncate();
        }
    }

    /// Truncate the invisible elements from the raw buffer.
    #[inline]
    pub fn truncate(&mut self) {
        self.rezero();

        self.inner.truncate(self.len);
    }

    /// Dynamically grow the storage buffer at runtime.
    #[inline]
    pub fn initialize(&mut self, additional_rows: usize, columns: usize)
    where
        T: Default + crate::grid::GridCell,
    {
        if self.len + additional_rows > self.inner.len() {
            self.rezero();

            let realloc_size = self.inner.len() + max(additional_rows, MAX_CACHE_SIZE);
            self.inner.resize_with(realloc_size, || Row::new(columns));
        }

        self.len += additional_rows;
    }

    #[inline]
    pub fn len(&self) -> usize {
        self.len
    }

    /// Swap implementation for Row<T>.
    ///
    /// Exploits the known size of Row<T> to produce a slightly more efficient
    /// swap than going through slice::swap.
    ///
    /// The default implementation from swap generates 8 movups and 4 movaps
    /// instructions. This implementation achieves the swap in only 8 movups
    /// instructions.
    pub fn swap(&mut self, a: Line, b: Line) {
        // Changed for glass: Row<T> carries the lazy-recycle blank inline
        // (inner Vec + occ + blank), so the old 4-qword trick copied only
        // part of each row. mem::swap moves both rows whole, still O(1).
        let a = self.compute_index(a);
        let b = self.compute_index(b);
        if a != b {
            self.inner.swap(a, b);
        }
    }

    /// Rotate the grid, moving all lines up/down in history.
    #[inline]
    pub fn rotate(&mut self, count: isize) {
        debug_assert!(count.unsigned_abs() <= self.inner.len());

        let len = self.inner.len();
        self.zero = (self.zero as isize + count + len as isize) as usize % len;
    }

    /// Rotate all existing lines down in history.
    ///
    /// This is a faster, specialized version of [`rotate_left`].
    ///
    /// [`rotate_left`]: https://doc.rust-lang.org/std/vec/struct.Vec.html#method.rotate_left
    #[inline]
    pub fn rotate_down(&mut self, count: usize) {
        self.zero = (self.zero + count) % self.inner.len();
    }

    /// Rotate the physical rows behind one screen region, without touching
    /// history above it or the fixed lines below it.
    ///
    /// Changed for glass: a region scroll used to walk the region with
    /// pairwise `swap`s — one pass of `region.end - region.start - positions`
    /// swaps per scroll, each moving two whole `Row<T>`s (inner Vec plus the
    /// lazy-recycle `occ`/`blank` state). A ring rotation moves each row
    /// exactly once for any `positions`, as `rotate` does for the whole
    /// buffer. The rows are moved whole, so `occ` and `blank` stay with the
    /// text they belong to, exactly as a swap chain leaves them.
    ///
    /// Only the visible sub-slice turns: the caller's lines are relative to
    /// the visible top, while the ring may start anywhere in `inner`.
    pub(crate) fn rotate_region(&mut self, start: i32, end: i32, positions: usize) {
        let len = self.inner.len();
        if len == 0 || positions == 0 || end <= start {
            return;
        }
        // Same mapping as `compute_index`: visible line `l` sits at
        // `zero + visible_lines - 1 - l`, so higher lines sit at lower
        // offsets. The region's rows therefore occupy the physical run
        // from `at(end - 1)` (lowest slot) up to `at(start)` (highest),
        // and scrolling up by `positions` moves each row down that run
        // by exactly `positions` slots: one `rotate_right` of the run.
        // Rows move whole, so the lazy-recycle `occ`/`blank` state stays
        // with its text, exactly as the swap chain left it.
        let visible = self.visible_lines as i32;
        let at = |l: i32| (self.zero as i32 + visible - 1 - l).rem_euclid(len as i32) as usize;
        let a = at(end - 1);
        let b = at(start);
        if a == b {
            return;
        }
        if a < b {
            self.inner[a..=b].rotate_right(positions % (b - a + 1));
        } else {
            // The run straddles the ring's seam ([a, len) plus [0, =b]):
            // possible whenever `zero` has moved, which any full-screen
            // scroll does. Rare (the region is small against the
            // history), so take it rather than split the ring — in
            // logical line order, where a scroll up is a left rotation,
            // done as three reversals of swaps.
            //
            // Changed for glass: the swap chain this replaces
            // (`swap(at(i), at(i + positions))` upward) is a rotation
            // only for `positions == 1`; a `CSI S` of several lines
            // at the seam needs the real rotation.
            let height = (end - start) as usize;
            let positions = positions % height;
            if positions == 0 {
                return;
            }
            let idx: Vec<usize> = (start..end).map(at).collect();
            let reverse = |inner: &mut Vec<Row<T>>, mut lo: usize, mut hi: usize| {
                while lo < hi {
                    hi -= 1;
                    if lo < hi {
                        inner.swap(idx[lo], idx[hi]);
                        lo += 1;
                    }
                }
            };
            reverse(&mut self.inner, 0, positions);
            reverse(&mut self.inner, positions, height);
            reverse(&mut self.inner, 0, height);
        }
    }

    /// Update the raw storage buffer.
    #[inline]
    pub fn replace_inner(&mut self, vec: Vec<Row<T>>) {
        self.len = vec.len();
        self.inner = vec;
        self.zero = 0;
    }

    /// Remove all rows from storage.
    #[inline]
    pub fn take_all(&mut self) -> Vec<Row<T>> {
        self.truncate();

        let mut buffer = Vec::new();

        mem::swap(&mut buffer, &mut self.inner);
        self.len = 0;

        buffer
    }

    /// Compute actual index in underlying storage given the requested index.
    #[inline]
    fn compute_index(&self, requested: Line) -> usize {
        debug_assert!(requested.0 < self.visible_lines as i32);

        let positive = -(requested - self.visible_lines).0 as usize - 1;

        debug_assert!(positive < self.len);

        let zeroed = self.zero + positive;

        // Use if/else instead of remainder here to improve performance.
        //
        // Requires `zeroed` to be smaller than `self.inner.len() * 2`,
        // but both `self.zero` and `requested` are always smaller than `self.inner.len()`.
        if zeroed >= self.inner.len() { zeroed - self.inner.len() } else { zeroed }
    }

    /// Rotate the ringbuffer to reset `self.zero` back to index `0`.
    #[inline]
    fn rezero(&mut self) {
        if self.zero == 0 {
            return;
        }

        self.inner.rotate_left(self.zero);
        self.zero = 0;
    }
}

impl<T> Index<Line> for Storage<T> {
    type Output = Row<T>;

    #[inline]
    fn index(&self, index: Line) -> &Self::Output {
        let index = self.compute_index(index);
        &self.inner[index]
    }
}

impl<T> IndexMut<Line> for Storage<T> {
    #[inline]
    fn index_mut(&mut self, index: Line) -> &mut Self::Output {
        let index = self.compute_index(index);
        &mut self.inner[index]
    }
}

#[cfg(test)]
mod tests {
    use crate::grid::GridCell;
    use crate::grid::row::Row;
    use crate::grid::storage::{MAX_CACHE_SIZE, Storage};
    use crate::index::{Column, Line};
    use crate::term::cell::Flags;

    impl GridCell for char {
        fn is_empty(&self) -> bool {
            *self == ' ' || *self == '\t'
        }

        fn reset(&mut self, template: &Self) {
            *self = *template;
        }

        fn flags(&self) -> &Flags {
            unimplemented!();
        }

        fn flags_mut(&mut self) -> &mut Flags {
            unimplemented!();
        }
    }

    #[test]
    fn with_capacity() {
        let storage = Storage::<char>::with_capacity(3, 1);

        assert_eq!(storage.inner.len(), 3);
        assert_eq!(storage.len, 3);
        assert_eq!(storage.zero, 0);
        assert_eq!(storage.visible_lines, 3);
    }

    #[test]
    fn indexing() {
        let mut storage = Storage::<char>::with_capacity(3, 1);

        storage[Line(0)] = filled_row('0');
        storage[Line(1)] = filled_row('1');
        storage[Line(2)] = filled_row('2');

        storage.zero += 1;

        assert_eq!(storage[Line(0)], filled_row('2'));
        assert_eq!(storage[Line(1)], filled_row('0'));
        assert_eq!(storage[Line(2)], filled_row('1'));
    }

    #[test]
    #[should_panic]
    #[cfg(debug_assertions)]
    fn indexing_above_inner_len() {
        let storage = Storage::<char>::with_capacity(1, 1);
        let _ = &storage[Line(-1)];
    }

    #[test]
    fn rotate() {
        let mut storage = Storage::<char>::with_capacity(3, 1);
        storage.rotate(2);
        assert_eq!(storage.zero, 2);
        storage.shrink_lines(2);
        assert_eq!(storage.len, 1);
        assert_eq!(storage.inner.len(), 3);
        assert_eq!(storage.zero, 2);
    }

    /// Grow the buffer one line at the end of the buffer.
    ///
    /// Before:
    ///   0: 0 <- Zero
    ///   1: 1
    ///   2: -
    /// After:
    ///   0: 0 <- Zero
    ///   1: 1
    ///   2: -
    ///   3: \0
    ///   ...
    ///   MAX_CACHE_SIZE: \0
    #[test]
    fn grow_after_zero() {
        // Setup storage area.
        let mut storage: Storage<char> = Storage {
            inner: vec![filled_row('0'), filled_row('1'), filled_row('-')],
            zero: 0,
            visible_lines: 3,
            len: 3,
        };

        // Grow buffer.
        storage.grow_visible_lines(4);

        // Make sure the result is correct.
        let mut expected = Storage {
            inner: vec![filled_row('0'), filled_row('1'), filled_row('-')],
            zero: 0,
            visible_lines: 4,
            len: 4,
        };
        expected.inner.append(&mut vec![filled_row('\0'); MAX_CACHE_SIZE]);

        assert_eq!(storage.visible_lines, expected.visible_lines);
        assert_eq!(storage.inner, expected.inner);
        assert_eq!(storage.zero, expected.zero);
        assert_eq!(storage.len, expected.len);
    }

    /// Grow the buffer one line at the start of the buffer.
    ///
    /// Before:
    ///   0: -
    ///   1: 0 <- Zero
    ///   2: 1
    /// After:
    ///   0: 0 <- Zero
    ///   1: 1
    ///   2: -
    ///   3: \0
    ///   ...
    ///   MAX_CACHE_SIZE: \0
    #[test]
    fn grow_before_zero() {
        // Setup storage area.
        let mut storage: Storage<char> = Storage {
            inner: vec![filled_row('-'), filled_row('0'), filled_row('1')],
            zero: 1,
            visible_lines: 3,
            len: 3,
        };

        // Grow buffer.
        storage.grow_visible_lines(4);

        // Make sure the result is correct.
        let mut expected = Storage {
            inner: vec![filled_row('0'), filled_row('1'), filled_row('-')],
            zero: 0,
            visible_lines: 4,
            len: 4,
        };
        expected.inner.append(&mut vec![filled_row('\0'); MAX_CACHE_SIZE]);

        assert_eq!(storage.visible_lines, expected.visible_lines);
        assert_eq!(storage.inner, expected.inner);
        assert_eq!(storage.zero, expected.zero);
        assert_eq!(storage.len, expected.len);
    }

    /// Shrink the buffer one line at the start of the buffer.
    ///
    /// Before:
    ///   0: 2
    ///   1: 0 <- Zero
    ///   2: 1
    /// After:
    ///   0: 2 <- Hidden
    ///   0: 0 <- Zero
    ///   1: 1
    #[test]
    fn shrink_before_zero() {
        // Setup storage area.
        let mut storage: Storage<char> = Storage {
            inner: vec![filled_row('2'), filled_row('0'), filled_row('1')],
            zero: 1,
            visible_lines: 3,
            len: 3,
        };

        // Shrink buffer.
        storage.shrink_visible_lines(2);

        // Make sure the result is correct.
        let expected = Storage {
            inner: vec![filled_row('2'), filled_row('0'), filled_row('1')],
            zero: 1,
            visible_lines: 2,
            len: 2,
        };
        assert_eq!(storage.visible_lines, expected.visible_lines);
        assert_eq!(storage.inner, expected.inner);
        assert_eq!(storage.zero, expected.zero);
        assert_eq!(storage.len, expected.len);
    }

    /// Shrink the buffer one line at the end of the buffer.
    ///
    /// Before:
    ///   0: 0 <- Zero
    ///   1: 1
    ///   2: 2
    /// After:
    ///   0: 0 <- Zero
    ///   1: 1
    ///   2: 2 <- Hidden
    #[test]
    fn shrink_after_zero() {
        // Setup storage area.
        let mut storage: Storage<char> = Storage {
            inner: vec![filled_row('0'), filled_row('1'), filled_row('2')],
            zero: 0,
            visible_lines: 3,
            len: 3,
        };

        // Shrink buffer.
        storage.shrink_visible_lines(2);

        // Make sure the result is correct.
        let expected = Storage {
            inner: vec![filled_row('0'), filled_row('1'), filled_row('2')],
            zero: 0,
            visible_lines: 2,
            len: 2,
        };
        assert_eq!(storage.visible_lines, expected.visible_lines);
        assert_eq!(storage.inner, expected.inner);
        assert_eq!(storage.zero, expected.zero);
        assert_eq!(storage.len, expected.len);
    }

    /// Shrink the buffer at the start and end of the buffer.
    ///
    /// Before:
    ///   0: 4
    ///   1: 5
    ///   2: 0 <- Zero
    ///   3: 1
    ///   4: 2
    ///   5: 3
    /// After:
    ///   0: 4 <- Hidden
    ///   1: 5 <- Hidden
    ///   2: 0 <- Zero
    ///   3: 1
    ///   4: 2 <- Hidden
    ///   5: 3 <- Hidden
    #[test]
    fn shrink_before_and_after_zero() {
        // Setup storage area.
        let mut storage: Storage<char> = Storage {
            inner: vec![
                filled_row('4'),
                filled_row('5'),
                filled_row('0'),
                filled_row('1'),
                filled_row('2'),
                filled_row('3'),
            ],
            zero: 2,
            visible_lines: 6,
            len: 6,
        };

        // Shrink buffer.
        storage.shrink_visible_lines(2);

        // Make sure the result is correct.
        let expected = Storage {
            inner: vec![
                filled_row('4'),
                filled_row('5'),
                filled_row('0'),
                filled_row('1'),
                filled_row('2'),
                filled_row('3'),
            ],
            zero: 2,
            visible_lines: 2,
            len: 2,
        };
        assert_eq!(storage.visible_lines, expected.visible_lines);
        assert_eq!(storage.inner, expected.inner);
        assert_eq!(storage.zero, expected.zero);
        assert_eq!(storage.len, expected.len);
    }

    /// Check that when truncating all hidden lines are removed from the raw buffer.
    ///
    /// Before:
    ///   0: 4 <- Hidden
    ///   1: 5 <- Hidden
    ///   2: 0 <- Zero
    ///   3: 1
    ///   4: 2 <- Hidden
    ///   5: 3 <- Hidden
    /// After:
    ///   0: 0 <- Zero
    ///   1: 1
    #[test]
    fn truncate_invisible_lines() {
        // Setup storage area.
        let mut storage: Storage<char> = Storage {
            inner: vec![
                filled_row('4'),
                filled_row('5'),
                filled_row('0'),
                filled_row('1'),
                filled_row('2'),
                filled_row('3'),
            ],
            zero: 2,
            visible_lines: 1,
            len: 2,
        };

        // Truncate buffer.
        storage.truncate();

        // Make sure the result is correct.
        let expected = Storage {
            inner: vec![filled_row('0'), filled_row('1')],
            zero: 0,
            visible_lines: 1,
            len: 2,
        };
        assert_eq!(storage.visible_lines, expected.visible_lines);
        assert_eq!(storage.inner, expected.inner);
        assert_eq!(storage.zero, expected.zero);
        assert_eq!(storage.len, expected.len);
    }

    /// Truncate buffer only at the beginning.
    ///
    /// Before:
    ///   0: 1
    ///   1: 2 <- Hidden
    ///   2: 0 <- Zero
    /// After:
    ///   0: 1
    ///   0: 0 <- Zero
    #[test]
    fn truncate_invisible_lines_beginning() {
        // Setup storage area.
        let mut storage: Storage<char> = Storage {
            inner: vec![filled_row('1'), filled_row('2'), filled_row('0')],
            zero: 2,
            visible_lines: 1,
            len: 2,
        };

        // Truncate buffer.
        storage.truncate();

        // Make sure the result is correct.
        let expected = Storage {
            inner: vec![filled_row('0'), filled_row('1')],
            zero: 0,
            visible_lines: 1,
            len: 2,
        };
        assert_eq!(storage.visible_lines, expected.visible_lines);
        assert_eq!(storage.inner, expected.inner);
        assert_eq!(storage.zero, expected.zero);
        assert_eq!(storage.len, expected.len);
    }

    /// First shrink the buffer and then grow it again.
    ///
    /// Before:
    ///   0: 4
    ///   1: 5
    ///   2: 0 <- Zero
    ///   3: 1
    ///   4: 2
    ///   5: 3
    /// After Shrinking:
    ///   0: 4 <- Hidden
    ///   1: 5 <- Hidden
    ///   2: 0 <- Zero
    ///   3: 1
    ///   4: 2
    ///   5: 3 <- Hidden
    /// After Growing:
    ///   0: 4
    ///   1: 5
    ///   2: -
    ///   3: 0 <- Zero
    ///   4: 1
    ///   5: 2
    ///   6: 3
    #[test]
    fn shrink_then_grow() {
        // Setup storage area.
        let mut storage: Storage<char> = Storage {
            inner: vec![
                filled_row('4'),
                filled_row('5'),
                filled_row('0'),
                filled_row('1'),
                filled_row('2'),
                filled_row('3'),
            ],
            zero: 2,
            visible_lines: 0,
            len: 6,
        };

        // Shrink buffer.
        storage.shrink_lines(3);

        // Make sure the result after shrinking is correct.
        let shrinking_expected = Storage {
            inner: vec![
                filled_row('4'),
                filled_row('5'),
                filled_row('0'),
                filled_row('1'),
                filled_row('2'),
                filled_row('3'),
            ],
            zero: 2,
            visible_lines: 0,
            len: 3,
        };
        assert_eq!(storage.inner, shrinking_expected.inner);
        assert_eq!(storage.zero, shrinking_expected.zero);
        assert_eq!(storage.len, shrinking_expected.len);

        // Grow buffer.
        storage.initialize(1, 1);

        // Make sure the previously freed elements are reused.
        let growing_expected = Storage {
            inner: vec![
                filled_row('4'),
                filled_row('5'),
                filled_row('0'),
                filled_row('1'),
                filled_row('2'),
                filled_row('3'),
            ],
            zero: 2,
            visible_lines: 0,
            len: 4,
        };

        assert_eq!(storage.inner, growing_expected.inner);
        assert_eq!(storage.zero, growing_expected.zero);
        assert_eq!(storage.len, growing_expected.len);
    }

    #[test]
    fn initialize() {
        // Setup storage area.
        let mut storage: Storage<char> = Storage {
            inner: vec![
                filled_row('4'),
                filled_row('5'),
                filled_row('0'),
                filled_row('1'),
                filled_row('2'),
                filled_row('3'),
            ],
            zero: 2,
            visible_lines: 0,
            len: 6,
        };

        // Initialize additional lines.
        let init_size = 3;
        storage.initialize(init_size, 1);

        // Generate expected grid.
        let mut expected_inner = vec![
            filled_row('0'),
            filled_row('1'),
            filled_row('2'),
            filled_row('3'),
            filled_row('4'),
            filled_row('5'),
        ];
        let expected_init_size = std::cmp::max(init_size, MAX_CACHE_SIZE);
        expected_inner.append(&mut vec![filled_row('\0'); expected_init_size]);
        let expected_storage = Storage { inner: expected_inner, zero: 0, visible_lines: 0, len: 9 };

        assert_eq!(storage.len, expected_storage.len);
        assert_eq!(storage.zero, expected_storage.zero);
        assert_eq!(storage.inner, expected_storage.inner);
    }

    #[test]
    fn rotate_wrap_zero() {
        let mut storage: Storage<char> = Storage {
            inner: vec![filled_row('-'), filled_row('-'), filled_row('-')],
            zero: 2,
            visible_lines: 0,
            len: 3,
        };

        storage.rotate(2);

        assert!(storage.zero < storage.inner.len());
    }

    #[test]
    fn region_rotation_reads_as_rotation() {
        // Every ring offset, region and count: scrolling the region up
        // by `positions` reads, line by line, as a left rotation of
        // the region's rows — at the seam too, where a swap chain
        // once rotated correctly only for `positions == 1`.
        let visible = 6usize;
        for zero in 0..8 {
            for (start, end) in [(0, 6), (1, 5), (2, 6), (0, 3)] {
                for positions in 1..4usize {
                    let mut storage: Storage<char> = Storage {
                        inner: (0..8)
                            .map(|i| filled_row(char::from(b'a' + i as u8)))
                            .collect(),
                        zero,
                        visible_lines: visible,
                        len: 8,
                    };
                    let logical = |storage: &Storage<char>| -> Vec<char> {
                        (0..visible as i32).map(|l| storage[Line(l)][Column(0)]).collect()
                    };
                    let before = logical(&storage);
                    storage.rotate_region(start, end, positions);
                    let mut expect = before;
                    expect[start as usize..end as usize]
                        .rotate_left(positions % (end - start) as usize);
                    assert_eq!(
                        logical(&storage),
                        expect,
                        "zero={zero} region={start}..{end} positions={positions}"
                    );
                }
            }
        }
    }

    /// Compare logical cells, not just row equality: lazy rows keep stale
    /// physical cells which must travel with their virtual blank/frontier.
    #[test]
    fn rotate_region_preserves_lazy_rows_and_history() {
        use crate::term::cell::Cell;
        use vte::ansi::Color;

        let visible = 6;
        let total = 9;
        for zero in 0..total {
            for start in 0..=visible {
                for end in start..=visible {
                    for positions in 0..=2 * (end - start) {
                        let mut storage = Storage::<Cell>::with_capacity(visible, 4);
                        storage.initialize(total - visible, 4);
                        storage.inner.truncate(total);
                        storage.zero = zero;
                        for line in -(total as i32 - visible as i32)..visible as i32 {
                            let row = &mut storage[Line(line)];
                            // Distinct cells, styles, and shared extras must move
                            // with their row, including stale lazy-tail contents.
                            for col in 0..4 {
                                let mut cell = Cell {
                                    c: char::from_u32(
                                        0x100 + ((line + 3) as u32 * 4) + col as u32,
                                    )
                                    .unwrap(),
                                    bg: Color::Indexed((line + 3) as u8),
                                    ..Cell::default()
                                };
                                if line.rem_euclid(3) == 1 {
                                    cell.push_zerowidth('\u{301}');
                                }
                                row.write_cell(col, cell);
                            }
                            let specimen = row.virtual_cell(0).clone();
                            row.note_uniform_write(0, 4, &specimen);
                            if line.rem_euclid(2) == 0 {
                                row.recycle(&specimen);
                                row.write_cell(0, Cell { c: 'X', ..Cell::default() });
                            }
                        }
                        let snapshot = |storage: &Storage<Cell>| -> Vec<_> {
                            (-(total as i32 - visible as i32)..visible as i32)
                                .map(|line| {
                                    let row = &storage[Line(line)];
                                    (
                                        row.observable().cloned().collect::<Vec<_>>(),
                                        row.occ,
                                        row.lazy_frontier(),
                                        row.uniform_to(),
                                        row.extra_free(),
                                    )
                                })
                                .collect()
                        };
                        let mut expected = snapshot(&storage);
                        let history = total - visible;
                        if end > start {
                            expected[history + start..history + end]
                                .rotate_left(positions % (end - start));
                        }
                        storage.rotate_region(start as i32, end as i32, positions);
                        assert_eq!(
                            snapshot(&storage), expected,
                            "zero={zero} region={start}..{end} positions={positions}"
                        );
                    }
                }
            }
        }
    }

    fn filled_row(content: char) -> Row<char> {
        let mut row = Row::new(1);
        row[Column(0)] = content;
        row
    }
}
