// Changed for glass from alacritty_terminal 0.26.0; CHANGES.md lists every change.
// - a cell keeps at most 9 zerowidth characters (upstream's fix, alacritty/alacritty@ede2ac14).
// - single-mark extras share one bounded per-thread cache; mutations remain copy-on-write.

use std::cell::RefCell;
use std::ops::Deref;
use std::ptr::NonNull;
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

/// One owning reference to extra cell content. Common immutable single marks
/// use a bounded static pool; all other values retain Arc copy-on-write.
///
/// The low address bit tags static entries. Untagged pointers represent
/// exactly one strong reference produced by `Arc::into_raw`. Constructors are
/// private except `From<Arc<_>>`, which transfers an existing strong reference.
/// Content/serde semantics match Arc; this deliberately is not the Arc API.
#[repr(transparent)]
pub struct CellExtraRef(NonNull<CellExtra>);

const _: () = assert!(std::mem::align_of::<CellExtra>() >= 2);

impl CellExtraRef {
    const STATIC: usize = 1;

    fn pooled_mark(character: char) -> Option<Self> {
        const FIRST: u32 = 0x300;
        const COUNT: usize = 0x70;
        let index = (character as u32).checked_sub(FIRST)? as usize;
        if index >= COUNT {
            return None;
        }
        static POOL: std::sync::OnceLock<[CellExtra; COUNT]> = std::sync::OnceLock::new();
        let pool = POOL.get_or_init(|| std::array::from_fn(|i| {
            CellExtra::with_mark(char::from_u32(FIRST + i as u32).unwrap())
        }));
        // The final static pool location is initialized before taking an
        // address. map_addr preserves its provenance while setting the tag.
        Some(Self(NonNull::from(&pool[index]).map_addr(|addr| addr | Self::STATIC)))
    }

    #[inline]
    fn is_static(&self) -> bool {
        self.0.addr().get() & Self::STATIC != 0
    }

    #[inline]
    fn untagged(&self) -> NonNull<CellExtra> {
        self.0.map_addr(|addr| {
            std::num::NonZeroUsize::new(addr.get() & !Self::STATIC).unwrap()
        })
    }

    fn make_mut(&mut self) -> &mut CellExtra {
        if self.is_static() {
            // Allocation/cloning can unwind while the old static handle stays
            // valid. Only replace self after obtaining the complete new owner.
            let owned = Arc::new((**self).clone());
            *self = Self::from(owned);
        }

        // Temporarily reclaim our one counted reference. A write-back guard
        // restores the raw owner even if Arc::make_mut's clone unwinds or
        // dissociates Weak references and changes the allocation.
        struct WriteBack<'a> {
            slot: &'a mut NonNull<CellExtra>,
            owned: Option<Arc<CellExtra>>,
        }
        impl Drop for WriteBack<'_> {
            fn drop(&mut self) {
                let owned = self.owned.take().unwrap();
                *self.slot = NonNull::new(Arc::into_raw(owned).cast_mut()).unwrap();
            }
        }
        // SAFETY: nonstatic invariant provides exactly one live strong
        // reference. The guard holds exclusive access to the raw owner.
        let owned = unsafe { Arc::from_raw(self.0.as_ptr()) };
        let mut guard = WriteBack { slot: &mut self.0, owned: Some(owned) };
        let _ = Arc::make_mut(guard.owned.as_mut().unwrap());
        drop(guard);
        // SAFETY: Arc::make_mut ensured exclusive ownership; the raw owner is
        // now restored in self and cannot be cloned while this borrow lives.
        unsafe { self.0.as_mut() }
    }

    #[cfg(test)]
    fn ptr_eq(left: &Self, right: &Self) -> bool {
        left.untagged() == right.untagged()
    }
}

impl From<Arc<CellExtra>> for CellExtraRef {
    fn from(owned: Arc<CellExtra>) -> Self {
        Self(NonNull::new(Arc::into_raw(owned).cast_mut()).unwrap())
    }
}

impl Default for CellExtraRef {
    fn default() -> Self { Arc::new(CellExtra::default()).into() }
}

impl Deref for CellExtraRef {
    type Target = CellExtra;
    #[inline]
    fn deref(&self) -> &Self::Target {
        // SAFETY: both owner variants remain live; static entries are never
        // mutated, and mutable owned access goes through make_mut exclusively.
        unsafe { self.untagged().as_ref() }
    }
}

impl Clone for CellExtraRef {
    #[inline]
    fn clone(&self) -> Self {
        if !self.is_static() {
            // SAFETY: this handle keeps one strong reference alive throughout.
            unsafe { Arc::increment_strong_count(self.0.as_ptr()) };
        }
        Self(self.0)
    }
}

impl Drop for CellExtraRef {
    #[inline]
    fn drop(&mut self) {
        if !self.is_static() {
            // SAFETY: release exactly the one strong reference this owns.
            unsafe { Arc::decrement_strong_count(self.0.as_ptr()) };
        }
    }
}

impl PartialEq for CellExtraRef {
    fn eq(&self, other: &Self) -> bool { **self == **other }
}
impl Eq for CellExtraRef {}
impl std::fmt::Debug for CellExtraRef {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Debug::fmt(&**self, f)
    }
}

// SAFETY: CellExtra is Send + Sync (only chars, Colors and Arc-backed
// Hyperlink); pooled values are immutable, owned values obey Arc's COW rules.
unsafe impl Send for CellExtraRef {}
unsafe impl Sync for CellExtraRef {}

#[cfg(feature = "serde")]
impl Serialize for CellExtraRef {
    fn serialize<S: serde::Serializer>(&self, serializer: S) -> Result<S::Ok, S::Error> {
        (**self).serialize(serializer)
    }
}
#[cfg(feature = "serde")]
impl<'de> Deserialize<'de> for CellExtraRef {
    fn deserialize<D: serde::Deserializer<'de>>(deserializer: D) -> Result<Self, D::Error> {
        CellExtra::deserialize(deserializer).map(|extra| Arc::new(extra).into())
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
    pub extra: Option<CellExtraRef>,
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
            self.extra = Some(CellExtraRef::pooled_mark(character)
                .unwrap_or_else(|| CellExtra::single_mark(character).into()));
            return;
        }
        let extra = self.extra.as_mut().unwrap();
        let _ = extra.make_mut().zerowidth.try_push(character);
    }

    /// Remove all wide char data from a cell.
    #[inline(never)]
    pub fn clear_wide(&mut self) {
        self.flags.remove(Flags::WIDE_CHAR);
        if let Some(extra) = self.extra.as_mut() {
            extra.make_mut().zerowidth = ArrayVec::new();
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
            extra.make_mut().underline_color = color;
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
            extra.make_mut().hyperlink = hyperlink;
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
    fn extra_ref_pool_is_bounded_and_copy_on_write() {
        assert_eq!(mem::size_of::<CellExtraRef>(), mem::size_of::<usize>());
        assert_eq!(mem::size_of::<Option<CellExtraRef>>(), mem::size_of::<usize>());
        assert!(CellExtraRef::pooled_mark('\u{2ff}').is_none());
        assert!(CellExtraRef::pooled_mark('\u{370}').is_none());
        for codepoint in 0x300..0x370 {
            let character = char::from_u32(codepoint).unwrap();
            let mut first = CellExtraRef::pooled_mark(character).unwrap();
            let second = first.clone();
            assert!(first.is_static());
            assert!(CellExtraRef::ptr_eq(&first, &second));
            first.make_mut().zerowidth.push('\u{308}');
            assert!(!first.is_static());
            assert_eq!(first.zerowidth.as_slice(), &[character, '\u{308}']);
            assert_eq!(second.zerowidth.as_slice(), &[character]);
            assert!(CellExtraRef::ptr_eq(
                &second, &CellExtraRef::pooled_mark(character).unwrap()
            ));
        }
    }

    #[test]
    fn extra_ref_owned_counts_and_weak_dissociation() {
        let original = Arc::new(CellExtra::with_mark('\u{1ab0}'));
        let weak = Arc::downgrade(&original);
        let mut owned = CellExtraRef::from(Arc::clone(&original));
        let clone = owned.clone();
        assert_eq!(Arc::strong_count(&original), 3);
        owned.make_mut().underline_color = Some(Color::Indexed(7));
        assert_eq!(Arc::strong_count(&original), 2);
        assert_eq!(original.underline_color, None);
        assert_eq!(clone.underline_color, None);
        assert_eq!(owned.underline_color, Some(Color::Indexed(7)));
        drop(clone);
        drop(original);
        assert!(weak.upgrade().is_none());

        let original = Arc::new(CellExtra::with_mark('\u{1ab0}'));
        let weak = Arc::downgrade(&original);
        let mut owned = CellExtraRef::from(original);
        owned.make_mut().underline_color = Some(Color::Indexed(9));
        assert!(weak.upgrade().is_none());
        assert_eq!(owned.underline_color, Some(Color::Indexed(9)));
        let pointer = owned.untagged();
        owned.make_mut().underline_color = None;
        assert_eq!(owned.untagged(), pointer);
    }

    #[test]
    fn extra_ref_cross_thread_and_creator_teardown() {
        let (pooled, fallback) = std::thread::spawn(|| {
            let pooled = CellExtraRef::pooled_mark('\u{301}').unwrap();
            let fallback = CellExtraRef::from(CellExtra::single_mark('\u{1ab0}'));
            (pooled, fallback)
        }).join().unwrap();
        std::thread::scope(|scope| {
            for _ in 0..4 {
                scope.spawn(|| {
                    for _ in 0..32 {
                        let mut local = pooled.clone();
                        local.make_mut().underline_color = Some(Color::Indexed(4));
                        assert_eq!(fallback.clone().zerowidth.as_slice(), &['\u{1ab0}']);
                    }
                });
            }
        });
        assert_eq!(pooled.underline_color, None);
        assert_eq!(pooled.zerowidth.as_slice(), &['\u{301}']);
    }

    #[test]
    fn shared_marks_are_isolated_from_cell_mutations_and_cache_replacement() {
        let mut first = Cell::default();
        let mut second = Cell::default();
        first.push_zerowidth('\u{301}');
        second.push_zerowidth('\u{301}');
        assert!(CellExtraRef::ptr_eq(first.extra.as_ref().unwrap(), second.extra.as_ref().unwrap()));

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
        assert!(CellExtraRef::ptr_eq(fresh.extra.as_ref().unwrap(), different.extra.as_ref().unwrap()));
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

    #[cfg(feature = "serde")]
    #[test]
    fn shared_mark_serializes_like_an_owned_extra() {
        let mut shared = Cell::default();
        shared.push_zerowidth('\u{301}');
        let owned = Cell { extra: Some(Arc::new(CellExtra::with_mark('\u{301}')).into()), ..Cell::default() };
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
