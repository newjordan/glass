// Changed for glass from alacritty_terminal 0.26.0; CHANGES.md lists every change.
// - a cell keeps at most 9 zerowidth characters (upstream's fix, alacritty/alacritty@ede2ac14).
// - single-mark extras share one bounded per-thread cache; mutations remain copy-on-write.

use std::cell::RefCell;
use std::sync::Arc;
use std::sync::atomic::{AtomicU32, Ordering};

use arrayvec::ArrayVec;
use bitflags::bitflags;
#[cfg(feature = "serde")]
use serde::{Deserialize, Serialize};

use crate::grid::{self, GridCell};
use crate::index::Column;
use crate::vte::ansi::{Color, Hyperlink as VteHyperlink, NamedColor};

/// Maximum number of zerowidth characters to retain per grid cell.
///
/// This enforces an upper bound on memory usage per cell, to ensure
/// malicous applications cannot use this as a DoS vector.
const MAX_ZEROWIDTH_CHARS: usize = 9;

bitflags! {
    #[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
    #[cfg_attr(feature = "serde", derive(Serialize, Deserialize))]
    pub struct Flags: u16 {
        const INVERSE                   = 0b0000_0000_0000_0001;
        const BOLD                      = 0b0000_0000_0000_0010;
        const ITALIC                    = 0b0000_0000_0000_0100;
        const BOLD_ITALIC               = 0b0000_0000_0000_0110;
        const UNDERLINE                 = 0b0000_0000_0000_1000;
        const WRAPLINE                  = 0b0000_0000_0001_0000;
        const WIDE_CHAR                 = 0b0000_0000_0010_0000;
        const WIDE_CHAR_SPACER          = 0b0000_0000_0100_0000;
        const DIM                       = 0b0000_0000_1000_0000;
        const DIM_BOLD                  = 0b0000_0000_1000_0010;
        const HIDDEN                    = 0b0000_0001_0000_0000;
        const STRIKEOUT                 = 0b0000_0010_0000_0000;
        const LEADING_WIDE_CHAR_SPACER  = 0b0000_0100_0000_0000;
        const DOUBLE_UNDERLINE          = 0b0000_1000_0000_0000;
        const UNDERCURL                 = 0b0001_0000_0000_0000;
        const DOTTED_UNDERLINE          = 0b0010_0000_0000_0000;
        const DASHED_UNDERLINE          = 0b0100_0000_0000_0000;
        const ALL_UNDERLINES            = Self::UNDERLINE.bits() | Self::DOUBLE_UNDERLINE.bits()
                                        | Self::UNDERCURL.bits() | Self::DOTTED_UNDERLINE.bits()
                                        | Self::DASHED_UNDERLINE.bits();
    }
}

/// Counter for hyperlinks without explicit ID.
static HYPERLINK_ID_SUFFIX: AtomicU32 = AtomicU32::new(0);

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
#[cfg_attr(feature = "serde", derive(Serialize, Deserialize))]
pub struct Hyperlink {
    inner: Arc<HyperlinkInner>,
}

impl Hyperlink {
    pub fn new<T: ToString>(id: Option<T>, uri: String) -> Self {
        let inner = Arc::new(HyperlinkInner::new(id, uri));
        Self { inner }
    }

    pub fn id(&self) -> &str {
        &self.inner.id
    }

    pub fn uri(&self) -> &str {
        &self.inner.uri
    }
}

impl From<VteHyperlink> for Hyperlink {
    fn from(value: VteHyperlink) -> Self {
        Self::new(value.id, value.uri)
    }
}

impl From<Hyperlink> for VteHyperlink {
    fn from(val: Hyperlink) -> Self {
        VteHyperlink { id: Some(val.id().to_owned()), uri: val.uri().to_owned() }
    }
}

#[derive(Debug, PartialEq, Eq, Hash)]
#[cfg_attr(feature = "serde", derive(Serialize, Deserialize))]
struct HyperlinkInner {
    /// Identifier for the given hyperlink.
    id: String,

    /// Resource identifier of the hyperlink.
    uri: String,
}

impl HyperlinkInner {
    pub fn new<T: ToString>(id: Option<T>, uri: String) -> Self {
        let id = match id {
            Some(id) => id.to_string(),
            None => {
                let mut id = HYPERLINK_ID_SUFFIX.fetch_add(1, Ordering::Relaxed).to_string();
                id.push_str("_alacritty");
                id
            },
        };

        Self { id, uri }
    }
}

/// Trait for determining if a reset should be performed.
pub trait ResetDiscriminant<T> {
    /// Value based on which equality for the reset will be determined.
    fn discriminant(&self) -> T;
}

impl<T: Copy> ResetDiscriminant<T> for T {
    fn discriminant(&self) -> T {
        *self
    }
}

impl ResetDiscriminant<Color> for Cell {
    fn discriminant(&self) -> Color {
        self.bg
    }
}

/// Dynamically allocated cell content.
///
/// This storage is reserved for cell attributes which are rarely set. This allows reducing the
/// allocation required ahead of time for every cell, with some additional overhead when the extra
/// storage is actually required.
#[derive(Default, Debug, Clone, Eq, PartialEq)]
#[cfg_attr(feature = "serde", derive(Serialize, Deserialize))]
pub struct CellExtra {
    zerowidth: ArrayVec<char, MAX_ZEROWIDTH_CHARS>,
    underline_color: Option<Color>,
    hyperlink: Option<Hyperlink>,
}

impl CellExtra {
    fn with_mark(character: char) -> Self {
        let mut extra = Self::default();
        extra.zerowidth.push(character);
        extra
    }

    /// A common accent needs one allocation per thread, not per cell. Only
    /// extras with exactly this mark and no other attributes are cached.
    /// Retain just the last mark, so arbitrary text cannot grow the cache.
    fn single_mark(character: char) -> Arc<Self> {
        thread_local! {
            static LAST: RefCell<Option<(char, Arc<CellExtra>)>> = const { RefCell::new(None) };
        }
        LAST.try_with(|last| {
            let mut last = last.borrow_mut();
            if let Some((key, extra)) = last.as_ref()
                && *key == character
            {
                return Arc::clone(extra);
            }
            let extra = Arc::new(Self::with_mark(character));
            *last = Some((character, Arc::clone(&extra)));
            extra
        })
        // Cells may also be used from another thread-local's destructor.
        .unwrap_or_else(|_| Arc::new(Self::with_mark(character)))
    }
}

/// Content and attributes of a single cell in the terminal grid.
#[derive(Clone, Debug, Eq, PartialEq)]
#[cfg_attr(feature = "serde", derive(Serialize, Deserialize))]
pub struct Cell {
    pub c: char,
    pub fg: Color,
    pub bg: Color,
    pub flags: Flags,
    pub extra: Option<Arc<CellExtra>>,
}

impl Default for Cell {
    #[inline]
    fn default() -> Cell {
        Cell {
            c: ' ',
            bg: Color::Named(NamedColor::Background),
            fg: Color::Named(NamedColor::Foreground),
            flags: Flags::empty(),
            extra: None,
        }
    }
}

impl Cell {
    /// Zerowidth characters stored in this cell.
    #[inline]
    pub fn zerowidth(&self) -> Option<&[char]> {
        self.extra.as_ref().map(|extra| extra.zerowidth.as_slice())
    }

    /// Write a new zerowidth character to this cell.
    #[inline]
    pub fn push_zerowidth(&mut self, character: char) {
        if self.extra.is_none() {
            self.extra = Some(CellExtra::single_mark(character));
            return;
        }
        let extra = self.extra.as_mut().unwrap();
        let _ = Arc::make_mut(extra).zerowidth.try_push(character);
    }

    /// Remove all wide char data from a cell.
    #[inline(never)]
    pub fn clear_wide(&mut self) {
        self.flags.remove(Flags::WIDE_CHAR);
        if let Some(extra) = self.extra.as_mut() {
            Arc::make_mut(extra).zerowidth = ArrayVec::new();
        }
        self.c = ' ';
    }

    /// Set underline color on the cell.
    pub fn set_underline_color(&mut self, color: Option<Color>) {
        // If we reset color and we don't have zerowidth we should drop extra storage.
        if color.is_none()
            && self
                .extra
                .as_ref()
                .is_none_or(|extra| extra.zerowidth.is_empty() && extra.hyperlink.is_none())
        {
            self.extra = None;
        } else {
            let extra = self.extra.get_or_insert(Default::default());
            Arc::make_mut(extra).underline_color = color;
        }
    }

    /// Underline color stored in this cell.
    #[inline]
    pub fn underline_color(&self) -> Option<Color> {
        self.extra.as_ref()?.underline_color
    }

    /// Set hyperlink.
    pub fn set_hyperlink(&mut self, hyperlink: Option<Hyperlink>) {
        let should_drop = hyperlink.is_none()
            && self
                .extra
                .as_ref()
                .is_none_or(|extra| extra.zerowidth.is_empty() && extra.underline_color.is_none());

        if should_drop {
            self.extra = None;
        } else {
            let extra = self.extra.get_or_insert(Default::default());
            Arc::make_mut(extra).hyperlink = hyperlink;
        }
    }

    /// Hyperlink stored in this cell.
    #[inline]
    pub fn hyperlink(&self) -> Option<Hyperlink> {
        self.extra.as_ref()?.hyperlink.clone()
    }
}

impl GridCell for Cell {
    #[inline]
    fn is_empty(&self) -> bool {
        (self.c == ' ' || self.c == '\t')
            && self.bg == Color::Named(NamedColor::Background)
            && self.fg == Color::Named(NamedColor::Foreground)
            && !self.flags.intersects(
                Flags::INVERSE
                    | Flags::ALL_UNDERLINES
                    | Flags::STRIKEOUT
                    | Flags::WRAPLINE
                    | Flags::WIDE_CHAR_SPACER
                    | Flags::LEADING_WIDE_CHAR_SPACER,
            )
            && self.extra.as_ref().map(|extra| extra.zerowidth.is_empty()) != Some(false)
    }

    #[inline]
    fn flags(&self) -> &Flags {
        &self.flags
    }

    #[inline]
    fn flags_mut(&mut self) -> &mut Flags {
        &mut self.flags
    }

    #[inline]
    fn strip_stale(&mut self) {
        self.extra = None;
    }

    #[inline]
    fn has_extra(&self) -> bool {
        self.extra.is_some()
    }

    #[inline]
    fn style_eq(&self, other: &Self) -> bool {
        self.fg == other.fg && self.bg == other.bg && self.flags == other.flags && self.extra == other.extra
    }

    fn reset(&mut self, template: &Self) {
        *self = Cell { bg: template.bg, ..Cell::default() };
    }
}

impl From<Color> for Cell {
    #[inline]
    fn from(color: Color) -> Self {
        Self { bg: color, ..Cell::default() }
    }
}

/// Get the length of occupied cells in a line.
pub trait LineLength {
    /// Calculate the occupied line length.
    fn line_length(&self) -> Column;
}

impl LineLength for grid::Row<Cell> {
    fn line_length(&self) -> Column {
        let mut length = Column(0);

        if self[Column(self.len() - 1)].flags.contains(Flags::WRAPLINE) {
            return Column(self.len());
        }

        // The lazy blank's cells are stale bytes past `occ`; the virtual
        // cell is blank, so it can only end the scan, never break it.
        let physical = self.physical_len();
        for (index, cell) in self.physical_cells().iter().rev().enumerate() {
            if cell.c != ' '
                || cell.extra.as_ref().map(|extra| extra.zerowidth.is_empty()) == Some(false)
            {
                length = Column(physical - index);
                break;
            }
        }

        length
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    use std::mem;

    use crate::grid::Row;
    use crate::index::Column;

    #[test]
    fn cell_size_is_below_cap() {
        // Expected cell size on 64-bit architectures.
        const EXPECTED_CELL_SIZE: usize = 24;

        // Ensure that cell size isn't growing by accident.
        assert!(mem::size_of::<Cell>() <= EXPECTED_CELL_SIZE);
    }

    #[test]
    fn shared_marks_are_isolated_from_cell_mutations_and_cache_replacement() {
        let mut first = Cell::default();
        let mut second = Cell::default();
        first.push_zerowidth('\u{301}');
        second.push_zerowidth('\u{301}');
        assert!(Arc::ptr_eq(first.extra.as_ref().unwrap(), second.extra.as_ref().unwrap()));

        first.push_zerowidth('\u{308}');
        first.set_underline_color(Some(Color::Indexed(3)));
        first.set_hyperlink(Some(Hyperlink::new(Some("id"), "https://example.org".into())));
        assert_eq!(second.zerowidth(), Some(&['\u{301}'][..]));
        assert_eq!(second.underline_color(), None);
        assert_eq!(second.hyperlink(), None);
        for _ in 0..20 {
            first.push_zerowidth('\u{302}');
        }
        assert_eq!(first.zerowidth().unwrap().len(), MAX_ZEROWIDTH_CHARS);
        assert_eq!(&first.zerowidth().unwrap()[..2], &['\u{301}', '\u{308}']);
        assert_eq!(first.underline_color(), Some(Color::Indexed(3)));
        assert_eq!(first.hyperlink().unwrap().uri(), "https://example.org");

        let mut different = Cell::default();
        different.push_zerowidth('\u{300}');
        second.clear_wide();
        let mut fresh = Cell::default();
        fresh.push_zerowidth('\u{300}');
        assert_eq!(fresh.zerowidth(), Some(&['\u{300}'][..]));
        assert!(Arc::ptr_eq(fresh.extra.as_ref().unwrap(), different.extra.as_ref().unwrap()));
        assert_eq!(second.zerowidth(), Some(&[][..]));
    }

    #[test]
    fn marks_preserve_existing_extra_attributes() {
        let mut cell = Cell::default();
        cell.set_underline_color(Some(Color::Indexed(5)));
        cell.set_hyperlink(Some(Hyperlink::new(Some("other"), "https://example.com".into())));
        cell.push_zerowidth('\u{301}');
        assert_eq!(cell.zerowidth(), Some(&['\u{301}'][..]));
        assert_eq!(cell.underline_color(), Some(Color::Indexed(5)));
        assert_eq!(cell.hyperlink().unwrap().id(), "other");
    }

    #[test]
    fn noop_extra_updates_preserve_shared_and_weak_owners() {
        for weak_only in [false, true] {
            for occupied in [0, MAX_ZEROWIDTH_CHARS] {
                let mut cell = Cell::default();
                cell.set_underline_color(Some(Color::Indexed(5)));
                cell.set_hyperlink(Some(Hyperlink::new(Some("noop"), "https://example.org".into())));
                for _ in 0..occupied {
                    cell.push_zerowidth('\u{301}');
                }
                cell.c = '漢';
                cell.flags.insert(Flags::WIDE_CHAR);
                let sibling = (!weak_only).then(|| cell.clone());
                let weak = Arc::downgrade(cell.extra.as_ref().unwrap());
                let before = Arc::as_ptr(cell.extra.as_ref().unwrap());
                let strong = Arc::strong_count(cell.extra.as_ref().unwrap());
                if occupied == MAX_ZEROWIDTH_CHARS {
                    for _ in 0..32 {
                        cell.push_zerowidth('\u{308}');
                    }
                    assert_eq!(cell.zerowidth(), Some(&['\u{301}'; MAX_ZEROWIDTH_CHARS][..]));
                } else {
                    for _ in 0..32 {
                        cell.clear_wide();
                    }
                    assert_eq!(cell.c, ' ');
                    assert!(!cell.flags.contains(Flags::WIDE_CHAR));
                    assert_eq!(cell.zerowidth(), Some(&[][..]));
                }
                assert_eq!(Arc::as_ptr(cell.extra.as_ref().unwrap()), before, "weak_only={weak_only} occupied={occupied}");
                assert_eq!(Arc::strong_count(cell.extra.as_ref().unwrap()), strong);
                assert_eq!(weak.as_ptr(), before);
                assert!(weak.upgrade().is_some());
                assert_eq!(cell.underline_color(), Some(Color::Indexed(5)));
                assert_eq!(cell.hyperlink().unwrap().id(), "noop");
                if let Some(sibling) = sibling {
                    assert_eq!(sibling.c, '漢');
                    assert!(sibling.flags.contains(Flags::WIDE_CHAR));
                    assert_eq!(sibling.zerowidth().unwrap().len(), occupied);
                }
            }
        }
    }

    #[test]
    fn real_extra_updates_still_isolate_shared_and_weak_owners() {
        for weak_only in [false, true] {
            for clear in [false, true] {
                let mut cell = Cell::default();
                cell.set_underline_color(Some(Color::Indexed(3)));
                cell.set_hyperlink(Some(Hyperlink::new(Some("real"), "https://example.com".into())));
                cell.push_zerowidth('\u{301}');
                cell.c = '漢';
                cell.flags.insert(Flags::WIDE_CHAR);
                let sibling = (!weak_only).then(|| cell.clone());
                let weak = Arc::downgrade(cell.extra.as_ref().unwrap());
                let before = Arc::as_ptr(cell.extra.as_ref().unwrap());
                if clear {
                    cell.clear_wide();
                    assert_eq!(cell.zerowidth(), Some(&[][..]));
                } else {
                    cell.push_zerowidth('\u{308}');
                    assert_eq!(cell.zerowidth(), Some(&['\u{301}', '\u{308}'][..]));
                }
                assert_ne!(Arc::as_ptr(cell.extra.as_ref().unwrap()), before);
                assert_eq!(cell.underline_color(), Some(Color::Indexed(3)));
                assert_eq!(cell.hyperlink().unwrap().id(), "real");
                if let Some(sibling) = sibling {
                    assert_eq!(sibling.zerowidth(), Some(&['\u{301}'][..]));
                    assert!(weak.upgrade().is_some());
                } else {
                    assert!(weak.upgrade().is_none());
                }
            }
        }
    }

    #[cfg(feature = "serde")]
    #[test]
    fn shared_mark_serializes_like_an_owned_extra() {
        let mut shared = Cell::default();
        shared.push_zerowidth('\u{301}');
        let owned = Cell { extra: Some(Arc::new(CellExtra::with_mark('\u{301}'))), ..Cell::default() };
        let json = serde_json::to_string(&shared).unwrap();
        assert_eq!(json, serde_json::to_string(&owned).unwrap());
        assert_eq!(serde_json::from_str::<Cell>(&json).unwrap(), owned);
    }

    #[test]
    fn line_length_works() {
        let mut row = Row::<Cell>::new(10);
        row[Column(5)].c = 'a';

        assert_eq!(row.line_length(), Column(6));
    }

    #[test]
    fn line_length_works_with_wrapline() {
        let mut row = Row::<Cell>::new(10);
        row[Column(9)].flags.insert(super::Flags::WRAPLINE);

        assert_eq!(row.line_length(), Column(10));
    }
}
