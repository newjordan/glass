// Changed for glass from alacritty_terminal 0.26.0; CHANGES.md lists every change.
// - a cell keeps at most 9 zerowidth characters (upstream's fix, alacritty/alacritty@ede2ac14).
// - single-mark extras share one bounded per-thread cache; mutations remain copy-on-write.
// - no-op mark updates preserve shared extras instead of triggering copy-on-write.

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
#[derive(Clone)]
pub struct Cell {
    pub c: char,
    pub fg: Color,
    pub bg: Color,
    pub flags: Flags,
    extra: Option<Arc<CellExtra>>,
    inline_mark: u16,
}

impl PartialEq for Cell {
    fn eq(&self, other: &Self) -> bool {
        self.c == other.c && self.fg == other.fg && self.bg == other.bg
            && self.flags == other.flags && self.extra_content() == other.extra_content()
    }
}
impl Eq for Cell {}
impl std::fmt::Debug for Cell {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("Cell").field("c", &self.c).field("fg", &self.fg)
            .field("bg", &self.bg).field("flags", &self.flags)
            .field("extra", &self.extra_content()).finish()
    }
}

#[cfg(feature = "serde")]
impl Serialize for Cell {
    fn serialize<S: serde::Serializer>(&self, serializer: S) -> Result<S::Ok, S::Error> {
        use serde::ser::SerializeStruct;
        let mut state = serializer.serialize_struct("Cell", 5)?;
        state.serialize_field("c", &self.c)?;
        state.serialize_field("fg", &self.fg)?;
        state.serialize_field("bg", &self.bg)?;
        state.serialize_field("flags", &self.flags)?;
        state.serialize_field("extra", &self.extra_content())?;
        state.end()
    }
}
#[cfg(feature = "serde")]
impl<'de> Deserialize<'de> for Cell {
    fn deserialize<D: serde::Deserializer<'de>>(deserializer: D) -> Result<Self, D::Error> {
        #[derive(Deserialize)]
        #[serde(rename = "Cell")]
        struct Wire { c: char, fg: Color, bg: Color, flags: Flags, extra: Option<Arc<CellExtra>> }
        let w = Wire::deserialize(deserializer)?;
        let mut cell = Self { c: w.c, fg: w.fg, bg: w.bg, flags: w.flags, extra: w.extra, inline_mark: 0 };
        if let Some(extra) = cell.extra.as_ref() {
            if extra.zerowidth.len() == 1 && extra.underline_color.is_none() && extra.hyperlink.is_none() {
                if let Some(id) = Self::mark_id(extra.zerowidth[0]) {
                    cell.inline_mark = id;
                    cell.extra = None;
                }
            }
        }
        Ok(cell)
    }
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
            inline_mark: 0,
        }
    }
}

impl Cell {
    /// Construct a cell without additional attributes or marks.
    pub fn plain(c: char, fg: Color, bg: Color, flags: Flags) -> Self {
        Self { c, fg, bg, flags, extra: None, inline_mark: 0 }
    }

    /// Copy the complete logical style and extra content of a cursor template.
    pub fn from_template(c: char, template: &Self) -> Self {
        let mut cell = template.clone();
        cell.c = c;
        cell
    }

    #[inline]
    pub fn has_extra(&self) -> bool { self.inline_mark != 0 || self.extra.is_some() }

    #[inline]
    pub fn clear_extra(&mut self) { self.extra = None; self.inline_mark = 0; }

    /// Zerowidth characters stored in this cell.
    fn mark_id(c: char) -> Option<u16> {
        let offset = (c as u32).checked_sub(0x300)?;
        (offset < 112).then_some(offset as u16 + 1)
    }

    fn pooled(id: u16) -> &'static CellExtra {
        static MARKS: std::sync::OnceLock<[CellExtra; 112]> = std::sync::OnceLock::new();
        &MARKS.get_or_init(|| std::array::from_fn(|i| CellExtra::with_mark(char::from_u32(0x300 + i as u32).unwrap())))[usize::from(id) - 1]
    }

    /// Logical content, independent of its immutable or owned storage.
    fn extra_content(&self) -> Option<&CellExtra> {
        if self.inline_mark != 0 { Some(Self::pooled(self.inline_mark)) }
        else { self.extra.as_deref() }
    }

    fn materialize_extra(&mut self) {
        if self.inline_mark != 0 {
            let owned = Arc::new(Self::pooled(self.inline_mark).clone());
            self.extra = Some(owned);
            self.inline_mark = 0;
        }
    }

    #[inline]
    pub fn zerowidth(&self) -> Option<&[char]> {
        self.extra_content().map(|extra| extra.zerowidth.as_slice())
    }

    /// Write a new zerowidth character to this cell.
    #[inline]
    pub fn push_zerowidth(&mut self, character: char) {
        if !self.has_extra() {
            if let Some(id) = Self::mark_id(character) { self.inline_mark = id; }
            else { self.extra = Some(CellExtra::single_mark(character)); }
            return;
        }
        self.materialize_extra();
        let extra = self.extra.as_mut().unwrap();
        // A full buffer ignores this mark. Check before `make_mut`: cloning
        // shared attributes (or dissociating Weak owners) cannot change it.
        if extra.zerowidth.is_full() {
            return;
        }
        let _ = Arc::make_mut(extra).zerowidth.try_push(character);
    }

    /// Remove all wide char data from a cell.
    #[inline(never)]
    pub fn clear_wide(&mut self) {
        self.flags.remove(Flags::WIDE_CHAR);
        self.materialize_extra();
        if let Some(extra) = self.extra.as_mut().filter(|extra| !extra.zerowidth.is_empty()) {
            Arc::make_mut(extra).zerowidth = ArrayVec::new();
        }
        self.c = ' ';
    }

    /// Set underline color on the cell.
    pub fn set_underline_color(&mut self, color: Option<Color>) {
        // If we reset color and we don't have zerowidth we should drop extra storage.
        if color.is_none()
            && self
                .extra_content()
                .is_none_or(|extra| extra.zerowidth.is_empty() && extra.hyperlink.is_none())
        {
            self.clear_extra();
        } else {
            self.materialize_extra();
            let extra = self.extra.get_or_insert(Default::default());
            Arc::make_mut(extra).underline_color = color;
        }
    }

    /// Underline color stored in this cell.
    #[inline]
    pub fn underline_color(&self) -> Option<Color> {
        self.extra_content()?.underline_color
    }

    /// Set hyperlink.
    pub fn set_hyperlink(&mut self, hyperlink: Option<Hyperlink>) {
        let should_drop = hyperlink.is_none()
            && self
                .extra_content()
                .is_none_or(|extra| extra.zerowidth.is_empty() && extra.underline_color.is_none());

        if should_drop {
            self.clear_extra();
        } else {
            self.materialize_extra();
            let extra = self.extra.get_or_insert(Default::default());
            Arc::make_mut(extra).hyperlink = hyperlink;
        }
    }

    /// Hyperlink stored in this cell.
    #[inline]
    pub fn hyperlink(&self) -> Option<Hyperlink> {
        self.extra_content()?.hyperlink.clone()
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
            && self.extra_content().map(|extra| extra.zerowidth.is_empty()) != Some(false)
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
        self.clear_extra();
    }

    #[inline]
    fn has_extra(&self) -> bool {
        Cell::has_extra(self)
    }

    #[inline]
    fn style_eq(&self, other: &Self) -> bool {
        self.fg == other.fg && self.bg == other.bg && self.flags == other.flags && self.extra_content() == other.extra_content()
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
                || cell.extra_content().map(|extra| extra.zerowidth.is_empty()) == Some(false)
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
        assert_eq!(first.zerowidth(), second.zerowidth());
        if let (Some(a), Some(b)) = (first.extra.as_ref(), second.extra.as_ref()) { assert!(Arc::ptr_eq(a, b)); }

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
        assert_eq!(fresh.zerowidth(), different.zerowidth());
        if let (Some(a), Some(b)) = (fresh.extra.as_ref(), different.extra.as_ref()) { assert!(Arc::ptr_eq(a, b)); }
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
        let mut failures = 0;
        for owners in [0, 1, 2] {
            for occupied in [0, MAX_ZEROWIDTH_CHARS] {
                let mut cell = Cell::default();
                cell.set_underline_color(Some(Color::Indexed(5)));
                cell.set_hyperlink(Some(Hyperlink::new(Some("noop"), "https://example.org".into())));
                for _ in 0..occupied {
                    cell.push_zerowidth('\u{301}');
                }
                cell.c = '漢';
                cell.flags.insert(Flags::WIDE_CHAR);
                let sibling = (owners == 2).then(|| cell.clone());
                let weak = (owners != 0).then(|| Arc::downgrade(cell.extra.as_ref().unwrap()));
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
                let retained = Arc::as_ptr(cell.extra.as_ref().unwrap()) == before;
                let strong_retained = Arc::strong_count(cell.extra.as_ref().unwrap()) == strong;
                let weak_retained = weak.as_ref().is_none_or(|w| w.as_ptr() == before && w.upgrade().is_some());
                eprintln!("extra-noop owners={owners} occupied={occupied} retained={retained} strong={strong_retained} weak={weak_retained}");
                failures += usize::from(!(retained && strong_retained && weak_retained));
                assert_eq!(cell.underline_color(), Some(Color::Indexed(5)));
                assert_eq!(cell.hyperlink().unwrap().id(), "noop");
                if let Some(sibling) = sibling {
                    assert_eq!(sibling.c, '漢');
                    assert!(sibling.flags.contains(Flags::WIDE_CHAR));
                    assert_eq!(sibling.zerowidth().unwrap().len(), occupied);
                }
            }
        }
        assert_eq!(failures, 0, "no-op updates changed ownership");
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
    fn logical_single_marks_layout_wire_and_lifetimes() {
        fn traits<T: Send + Sync>() {}
        traits::<Cell>();
        assert_eq!(std::mem::size_of::<Cell>(), 24);
        eprintln!("inline-layout bytes={} align={}", std::mem::size_of::<Cell>(), std::mem::align_of::<Cell>());
        let chars: Vec<char> = (0x300..=0x36f).map(|v| char::from_u32(v).unwrap())
            .chain(['\u{2ff}', '\u{370}', '\u{1ab0}', '\0']).collect();
        for mark in chars {
            let mut cell = Cell::default();
            cell.push_zerowidth(mark);
            assert!(cell.has_extra());
            assert!(!cell.is_empty());
            assert_eq!(cell.zerowidth(), Some(&[mark][..]));
            let owner = Cell { extra: Some(Arc::new(CellExtra::with_mark(mark))), ..Cell::default() };
            assert_eq!(cell, owner);
            assert_eq!(format!("{cell:?}"), format!("{owner:?}"));
            #[cfg(feature = "serde")]
            {
                let wire = serde_json::to_string(&cell).unwrap();
                assert_eq!(wire, serde_json::to_string(&owner).unwrap());
                assert!(!wire.contains("inline"));
                assert_eq!(serde_json::from_str::<Cell>(&wire).unwrap(), cell);
            }
            let mut row = Row::new(4);
            row[Column(2)] = cell.clone();
            assert_eq!(row.line_length(), Column(3));
            for operation in 0..7 {
                let mut copy = cell.clone();
                match operation {
                    0 => copy.push_zerowidth('\u{308}'),
                    1 => copy.set_underline_color(Some(Color::Indexed(7))),
                    2 => copy.set_hyperlink(Some(Hyperlink::new(Some("i"), "https://example.net".into()))),
                    3 => copy.clear_wide(),
                    4 => copy.clear_extra(),
                    5 => copy.set_underline_color(None),
                    _ => copy.set_hyperlink(None),
                }
                assert_eq!(cell.zerowidth(), Some(&[mark][..]));
                match operation {
                    0 => assert_eq!(copy.zerowidth(), Some(&[mark, '\u{308}'][..])),
                    1 => { assert_eq!(copy.underline_color(), Some(Color::Indexed(7))); assert_eq!(copy.zerowidth(), Some(&[mark][..])); },
                    2 => { assert_eq!(copy.hyperlink().unwrap().id(), "i"); assert_eq!(copy.zerowidth(), Some(&[mark][..])); },
                    3 => assert_eq!(copy.zerowidth(), Some(&[][..])),
                    4 => assert!(!copy.has_extra()),
                    _ => assert_eq!(copy.zerowidth(), Some(&[mark][..])),
                }
            }
            let copied = Cell::from_template('x', &cell);
            assert_eq!(copied.zerowidth(), Some(&[mark][..]));
            let joined = std::thread::spawn(move || {
                let mut changed = copied.clone();
                changed.push_zerowidth('\u{308}');
                assert_eq!(copied.zerowidth(), Some(&[mark][..]));
                changed
            }).join().unwrap();
            assert_eq!(joined.zerowidth(), Some(&[mark, '\u{308}'][..]));
        }
        let empty = Cell { extra: Some(Arc::new(CellExtra::default())), ..Cell::default() };
        assert_ne!(empty, Cell::default());
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
