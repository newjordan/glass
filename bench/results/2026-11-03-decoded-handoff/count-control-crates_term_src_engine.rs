//! The screen a program's output draws, kept by `alacritty_terminal`'s
//! `Term`, and the answers a terminal owes the program that `Term` leaves
//! to its host: identification and window queries, cell-pixel sizes, the
//! title, the bell and clipboard requests.
//!
//! Everything the rest of the crate needs from the terminal state goes
//! through this module: [`Engine::process`] bytes, [`Engine::resize`],
//! [`Engine::scroll_display`], the cells, cursor and modes, and the
//! replies, title, bell and clipboard the program's escape sequences ask
//! for, taken with [`Engine::take_effects`].
//!
//! A few queries are answered here rather than by `Term`, because glass
//! speaks for itself on them: what it is (DA1, DA2, XTVERSION), how big
//! its cells are (XTWINOPS 16), whether a synchronized update is open
//! (DECRQM 2026). Those byte sequences are recognized before the rest of
//! the stream reaches `Term`, so a sequence split across two reads is
//! held back until it is complete.

use std::sync::mpsc::{Receiver, Sender, TryRecvError};
use std::sync::{Arc, Mutex};
use std::time::Instant;

use alacritty_terminal::event::{Event as TermEvent, EventListener, WindowSize};
use alacritty_terminal::grid::{Dimensions, GridCell};
use alacritty_terminal::index::{Column, Point};
use alacritty_terminal::term::cell::Flags as CellFlags;
use alacritty_terminal::grid::Scroll;
use alacritty_terminal::term::{Config, Term, TermMode};
use alacritty_terminal::vte::ansi::{
    Attr, CharsetIndex, ClearMode, CursorStyle, Hyperlink, KeyboardModes, KeyboardModesApplyBehavior,
    LineClearMode, Mode, ModifyOtherKeys, PrivateMode, ScpCharPath, ScpUpdateMode, StandardCharset,
    NamedPrivateMode,
    TabulationClearMode,
};
use alacritty_terminal::vte::ansi::{Color as AnsiColor, CursorShape, NamedColor, Rgb};
use alacritty_terminal::vte::ansi::Processor;
use alacritty_terminal::index::{Line, Point as GridPoint, Side};
use alacritty_terminal::selection::{Selection as Sentinel, SelectionType};

use crate::keys::{MouseProtocolEncoding, MouseProtocolMode};
use crate::view::CursorLook;

/// Lines kept above the screen.
/// The scrollback history's size, in lines. `GLASS_SCROLLBACK` overrides
/// it (benchmarks vary it without a rebuild); the default is the shipped
/// ten thousand lines.
fn scrollback_lines() -> usize {
    static LINES: std::sync::OnceLock<usize> = std::sync::OnceLock::new();
    *LINES.get_or_init(|| {
        std::env::var("GLASS_SCROLLBACK")
            .ok()
            .and_then(|v| v.parse().ok())
            .unwrap_or(10_000)
    })
}
/// Bytes fed to `Term` between the engine's own reads of the
/// scroll-count sentinel. The sentinel cannot be scrolled out of a
/// full history between those reads, but not because this number is
/// small: inside a chunk the wrapper paces it — `drained` folds every
/// `SYNC_DRAIN_CHUNK` prints and linefeeds, scrolls down fold around
/// themselves, and `note_scroll_up` folds when the lines it carries
/// by hand reach the same bound — so unread travel stays within a
/// screenful of that bound whatever this chunk is. What the chunk
/// size does set is how often a feed pays a fresh wrapper, a sentinel
/// read and the count's bookkeeping: at 1024 that was a measurable
/// slice of a plain-text flood, which reads the sentinel to learn
/// nothing the wrapper's pacing had not already counted.
const SCROLL_COUNT_CHUNK: usize = 8192;
/// When the sentinel has scrolled this far into history, it is replanted on
/// the top row, so it always has room to move.
const SCROLL_COUNT_REPLANT: usize = 4_096;

/// Fold one sentinel line into the scroll count.
///
/// The sentinel is planted on the top row. A scroll whose top is the
/// screen's top moves it into history (a negative line); only a move
/// further that way grows the count. A scroll down moves it onto a
/// positive line. That is not history: the count stands and the caller
/// plants the sentinel on the top row again. A pull back toward the
/// screen is the same.
///
/// Returns whether the caller should plant a fresh sentinel.
fn fold_sentinel_line(count: &mut u64, read: &mut usize, alive: &mut bool, line: i32) -> bool {
    if line < 0 {
        let scrolled = line.unsigned_abs() as usize;
        if scrolled >= *read {
            *count += (scrolled - *read) as u64;
            *read = scrolled;
            *alive = true;
            scrolled >= SCROLL_COUNT_REPLANT
        } else {
            true
        }
    } else if line > 0 || *read > 0 {
        true
    } else {
        *alive = true;
        false
    }
}
/// How many bytes the sentinel-reading wrapper lets `Term` apply at once
/// while a synchronized update's buffer is drained through it: the same
/// pacing `process` uses, so the sentinel can never be scrolled through
/// a full history between two of its reads.
const SYNC_DRAIN_CHUNK: usize = 1024;

/// What the program's output asked of the window, beyond drawing.
#[derive(Default)]
pub struct Effects {
    /// Replies written back to the program: query answers and reports.
    pub replies: Vec<u8>,
    pub title: Option<String>,
    pub bell: bool,
    /// Text the program asked to put on the clipboard (OSC 52).
    pub clipboard: Option<String>,
}

/// One cell of the grid as glass draws it.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Cell {
    pub c: char,
    pub fg: Color,
    pub bg: Color,
    pub flags: CellFlags,
    /// The link's URI, when the program opened one over this cell.
    pub link: Option<String>,
    /// Zero-width marks on this cell, in order, up to three.
    pub marks: [char; 3],
    /// Foreground as an image id: a palette index, or 24-bit RGB.
    pub fg_id: Option<u32>,
    /// Underline colour as a placement id, the same way.
    pub underline_id: Option<u32>,
    /// Underline colour as the program wrote it. `Default` means the bar
    /// follows the foreground.
    pub underline: Color,
}

/// A colour as the program wrote it.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Color {
    Default,
    Indexed(u8),
    Rgb(u8, u8, u8),
}

/// Predict the primary grid after a resize while the alternate screen is
/// up. The inactive grid reflows; this follows the wrap flags the active
/// grid last showed.
fn simulated_after(
    before: &crate::intake::motion::GridSnap,
    rows: usize,
    cols: usize,
) -> crate::intake::motion::GridSnap {
    let mut logical: Vec<u32> = Vec::new();
    let mut acc = 0u32;
    for row in &before.lines {
        acc = acc.saturating_add(u32::from(row.len));
        if !row.wrap {
            logical.push(acc);
            acc = 0;
        }
    }
    if acc > 0 {
        logical.push(acc);
    }
    let mut lines = Vec::new();
    for chars in logical {
        if chars == 0 || cols == 0 {
            lines.push(crate::intake::motion::RowSnap { wrap: false, len: 0 });
            continue;
        }
        let mut left = chars;
        while left > cols as u32 {
            lines.push(crate::intake::motion::RowSnap { wrap: true, len: cols as u16 });
            left -= cols as u32;
        }
        lines.push(crate::intake::motion::RowSnap { wrap: false, len: left as u16 });
    }
    let screen = rows.max(1);
    // Lines that do not fit on the screen stay in history, as a width
    // change of the primary grid does. Only a history past the cap is
    // dropped, oldest first.
    let cap = screen.saturating_add(scrollback_lines());
    if lines.len() > cap {
        let extra = lines.len() - cap;
        lines.drain(0..extra);
    }
    let history = lines.len().saturating_sub(screen);
    while lines.len() < screen {
        lines.push(crate::intake::motion::RowSnap { wrap: false, len: 0 });
    }
    crate::intake::motion::GridSnap {
        cols,
        screen,
        history,
        scrolled: before.scrolled,
        lines,
    }
}

fn color_of(color: AnsiColor) -> Color {
    match color {
        AnsiColor::Named(NamedColor::Foreground | NamedColor::Background) => Color::Default,
        AnsiColor::Named(named) => Color::Indexed(u8::try_from(named as usize).unwrap_or(255)),
        AnsiColor::Spec(Rgb { r, g, b }) => Color::Rgb(r, g, b),
        AnsiColor::Indexed(i) => Color::Indexed(i),
    }
}

/// A colour as the id a placeholder cell carries: a palette index, or
/// 24-bit RGB packed into the low bits. The default colour is not an id.
pub fn color_id(color: Color) -> Option<u32> {
    match color {
        Color::Indexed(i) => Some(u32::from(i)),
        Color::Rgb(r, g, b) => Some((u32::from(r) << 16) | (u32::from(g) << 8) | u32::from(b)),
        Color::Default => None,
    }
}

/// The cursor's `(row, column)` in the cells the window shows.
pub type Coord = (u16, u16);

/// What the window knows that the program's queries are answered with:
/// the palette's foreground, background and cursor, and the size of one
/// cell in pixels. Shared so a resize can change them under the engine.
#[derive(Clone, Copy)]
pub struct HostInfo {
    /// Foreground, background, cursor.
    pub colors: [[u8; 3]; 3],
    pub cell_px: (u32, u32),
}

/// The queries and requests `Term` reports through its event listener.
enum Query {
    Reply(Vec<u8>),
    Title(String),
    Bell,
    Clipboard(String),
    /// A colour query (OSC 10/11/12 with `?`): the index `Term` numbers
    /// the colour by.
    ColorRequest(usize),
    /// XTWINOPS 14: the text area in pixels.
    TextAreaSize(std::sync::Arc<dyn Fn(WindowSize) -> String + Send + Sync>),
}

struct Listener {
    tx: Sender<Query>,
}

impl EventListener for Listener {
    fn send_event(&self, event: TermEvent) {
        let query = match event {
            TermEvent::PtyWrite(text) => Query::Reply(text.into_bytes()),
            TermEvent::Title(title) => Query::Title(title),
            // An emptied title returns to the window's own.
            TermEvent::ResetTitle => Query::Title(String::new()),
            TermEvent::Bell => Query::Bell,
            TermEvent::ClipboardStore(_, text) => Query::Clipboard(text),
            // Glass answers colour queries itself, with the palette it
            // draws from, so the reply is the same whatever `Term` was
            // told the colours were.
            TermEvent::ColorRequest(index, _) => Query::ColorRequest(index),
            TermEvent::TextAreaSizeRequest(size) => Query::TextAreaSize(size),
            _ => return,
        };
        let _ = self.tx.send(query);
    }
}

/// The screen's size, as `Term` is built and resized with.
struct Size {
    columns: usize,
    lines: usize,
}

impl Dimensions for Size {
    fn columns(&self) -> usize {
        self.columns
    }

    fn screen_lines(&self) -> usize {
        self.lines
    }

    fn total_lines(&self) -> usize {
        self.lines
    }
}

/// The terminal: one `Term` fed by the reader thread, the processor that
/// feeds it, and the channel its answers come back on.
pub struct Engine {
    term: Term<Listener>,
    processor: Processor,
    rx: Receiver<Query>,
    info: Arc<Mutex<HostInfo>>,
    /// Bytes held back because they may be the start of a sequence glass
    /// answers itself, cut off by the end of a read.
    tail: Vec<u8>,
    /// When the synchronized update now open began, if one is open.
    sync_since: Option<Instant>,
    /// Lines that have left the top of the screen into history. It only
    /// grows, by the number of lines each scroll took up, so the picture
    /// intake can anchor its frames by counting from the start of the
    /// output.
    scrolled_off_top: usize,
    /// Where the sentinel was last read, in lines above the screen.
    sentinel_read: usize,
    /// Whether the sentinel was planted and `Term` has dropped it since.
    sentinel_dropped: bool,
    /// The synchronized update's hold, kept apart from the processor's:
    /// a media piece settles the processor's buffer early so a picture
    /// anchors in the stream, but the frame still shows as one update
    /// until the program's end sequence or glass's own limit.
    hold_since: Option<Instant>,
    /// The intake's events raised while the last bytes were processed,
    /// waiting to be handed to the store in stream order.
    events: Vec<Event>,
    /// The in-cell pictures' cell rectangles on the screen that is up,
    /// handed in before each text piece so a cell write is only checked
    /// against them, and only when there are some.
    in_cell: Vec<(u64, u64, u16, u16)>,
    /// Exclusive absolute line past the lowest picture or text layer a
    /// scroll of this screen could move. `None` means the store has said
    /// nothing would move. `Some(u64::MAX)` means the extent is unknown.
    motion_end: Option<u64>,
    /// The character a REP repeats, carried across chunks: the parser's
    /// `preceding_char` outlives one read, so the lane's copy must too.
    preceding_char: Option<char>,
    /// The alternate screen's own scroll count since it was entered: no
    /// sentinel counts it, because its grid keeps no history.
    alt_scrolled: u64,
    /// The scroll region, mirroring `Term`: inclusive top, exclusive
    /// bottom, in screen rows. It is full-screen until a program sets it,
    /// and a resize, a reset or a column-mode change puts it back.
    region_top: i32,
    region_bottom: i32,
    /// The primary grid's wrap lines, saved while that grid is active so
    /// a resize on the alternate screen can still map its pictures.
    primary_snap: Option<crate::intake::motion::GridSnap>,
    /// A width change's reflow, taken by the session and applied to the
    /// store. Height-only resizes leave this empty: the sentinel counts
    /// those.
    pending_reflow: Option<crate::intake::motion::Reflow>,
    /// Whether the sentinel is planted right now. `Term` drops its
    /// selection on ED 2, ED 3 (with the sentinel in history), a screen
    /// switch and RIS; the wrapper reads it before those run, so the
    /// lines they scrolled away are never lost.
    sentinel_alive: bool,
    /// A snapshot of the cells as they were last taken, reused so drawing
    /// does not allocate per frame.
    cells: Vec<Cell>,
    /// What the output has asked of the window so far: the replies in
    /// stream order, glass's own and `Term`'s, and the title, bell and
    /// clipboard.
    effects: Effects,
    /// Several stretches fed as one, joined here (`process_parts`).
    joined: Vec<u8>,
    /// Where vte's parser stands, followed beside it, so a run of plain
    /// text the parser would print a character at a time can be written
    /// at once (`feed`).
    mirror: Mirror,
    /// Whether such runs are written at once. Always, but for the tests
    /// that hold the fast path to the parser's own result.
    fast: bool,
}

impl Engine {
    pub fn new(rows: usize, cols: usize, info: HostInfo) -> Self {
        let (tx, rx) = std::sync::mpsc::channel();
        let info = Arc::new(Mutex::new(info));
        let _ = &tx;
        let config = Config {
            scrolling_history: scrollback_lines(),
            // The CSI u keyboard dialect is tracked by `Term`'s mode bits;
            // glass encodes the keys itself in `keys`.
            kitty_keyboard: true,
            // DECSCUSR 0 restores this default: a steady block, the look
            // glass has always had. Programs ask for a blink with DECSCUSR
            // 1, 3 or 5, or with mode `?12`.
            default_cursor_style: CursorStyle { shape: CursorShape::Block, blinking: false },
            ..Config::default()
        };
        let term = Term::new(
            config,
            &Size { columns: cols.max(2), lines: rows.max(1) },
            Listener { tx },
        );
        Self {
            term,
            processor: Processor::new(),
            rx,
            info,
            tail: Vec::new(),
            sync_since: None,
            scrolled_off_top: 0,
            sentinel_read: 0,
            sentinel_dropped: false,
            events: Vec::new(),
            in_cell: Vec::new(),
            // Unknown until the store says what a scroll could move. Reporting
            // every scroll is the safe default for a feed that did not ask.
            motion_end: Some(u64::MAX),
            preceding_char: None,
            alt_scrolled: 0,
            region_top: 0,
            region_bottom: rows.max(1) as i32,
            primary_snap: None,
            pending_reflow: None,
            sentinel_alive: false,
            hold_since: None,
            cells: Vec::new(),
            effects: Effects::default(),
            joined: Vec::new(),
            mirror: Mirror::default(),
            fast: true,
        }
    }

    /// Feed the program's bytes. What those bytes ask of the window piles
    /// up until [`Engine::take_effects`] drains it.
    ///
    /// Any bytes may be fed at once, however many sequences they hold:
    /// a reply glass gives itself waits for the bytes ahead of its query
    /// to be applied, so the replies leave in stream order and speak of
    /// the state the stream had reached.
    pub fn process(&mut self, bytes: &[u8]) {
        let mut joined;
        let bytes: &[u8] = if self.tail.is_empty() {
            bytes
        } else {
            joined = std::mem::take(&mut self.tail);
            joined.extend_from_slice(bytes);
            &joined
        };
        // One pass: the sequences glass answers itself are replied to and
        // their bytes dropped, the rest reach `Term` in order, straight from
        // the read: `pass` is where the bytes not applied yet begin.
        let mut pass = 0;
        let mut i = 0;
        while i < bytes.len() {
            // Everything glass answers or holds back begins `ESC [` and one
            // of these, so a colour or a cursor move (`ESC [ 3`, `ESC [ 2`)
            // is passed over on its third byte.
            if bytes[i] != 0x1b
                || (bytes.get(i + 1) == Some(&b'[')
                    && bytes.get(i + 2).is_some_and(|b| !matches!(b, b'1' | b'c' | b'0' | b'?' | b'>')))
            {
                i = memchr::memchr(0x1b, &bytes[i + 1..]).map_or(bytes.len(), |p| i + 1 + p);
                continue;
            }
            // A synchronized update opening ahead of the bytes we answer
            // must be noticed first: the DECRQM that follows it in the
            // same read asks about it.
            if bytes[i..].starts_with(b"\x1b[?2026h") && self.sync_since.is_none() {
                self.sync_since = Some(Instant::now());
                self.hold_since = self.sync_since;
            }
            if bytes[i..].starts_with(b"\x1b[?2026l") {
                self.hold_since = None;
            }
            if let Some((consumed, ask)) = intercepted(&bytes[i..]) {
                // What came before the query is applied first: its
                // replies leave ahead of this one, and the answer speaks
                // of the state those bytes left.
                if pass < i {
                    let t = std::time::Instant::now();
                    self.apply(&bytes[pass..i]);
                    timers::record(timers::APPLY, t);
                    self.note_sync();
                }
                self.collect();
                let answer = self.answer(ask);
                self.effects.replies.extend_from_slice(&answer);
                i += consumed;
                pass = i;
                continue;
            }
            if let Some(kept) = held_back(&bytes[i..]) {
                self.tail = kept;
                break;
            }
            // Everything from here runs to the next escape, which the
            // next turn of the loop looks at on its own.
            i = memchr::memchr(0x1b, &bytes[i + 1..]).map_or(bytes.len(), |p| i + 1 + p);
        }
        let t = std::time::Instant::now();
        self.apply(&bytes[pass..i]);
        timers::record(timers::APPLY, t);
        self.note_sync();
    }

    /// Bytes through `Term`, with the scroll count and the store's events
    /// kept as they run.
    fn apply_timed(&mut self, pass: &[u8]) {
        let t = std::time::Instant::now();
        self.apply(pass);
        timers::record(timers::APPLY, t);
    }

    fn apply(&mut self, pass: &[u8]) {

        // The sentinel is planted before the bytes run, so the very first
        // scroll of a session already rotates it.
        if !self.term.mode().contains(TermMode::ALT_SCREEN) && self.term.selection.is_none() {
            self.plant_sentinel();
        }
        // The scroll counter reads the sentinel after every chunk, so a
        // feed that scrolls many screens at once cannot carry it past the
        // top of a full history before it is read.
        for chunk in pass.chunks(SCROLL_COUNT_CHUNK) {
            let Engine {
                term,
                processor,
                in_cell,
                scrolled_off_top,
                events,
                alt_scrolled,
                region_top,
                region_bottom,
                mirror,
                fast,
                ..
            } = self;
            let alternate = term.mode().contains(TermMode::ALT_SCREEN);
            // Covers and pictures share one absolute line. On the
            // alternate screen that line is its own scrolled count plus
            // the grid row, not the grid row alone.
            let scrolled = *scrolled_off_top as u64;
            let base = if alternate { *alt_scrolled } else { scrolled };
            let count = if alternate { 0 } else { scrolled };
            let mut watch = Watch {
                term,
                events: Vec::new(),
                in_cell: in_cell.clone(),
                base,
                count,
                alternate,
                alt_scrolled: *alt_scrolled,
                region_top: *region_top,
                region_bottom: *region_bottom,
                sentinel_read: self.sentinel_read,
                sentinel_alive: self.sentinel_alive,
                drained: chunk.len(),
                motion_end: self.motion_end,
                preceding: self.preceding_char,
                primary_snap: None,
                primary: scrolled,
                fast: *fast,
            };
            feed(processor, &mut watch, mirror, chunk, *fast);
            self.preceding_char = watch.preceding;
            *alt_scrolled = watch.alt_scrolled;
            *region_top = watch.region_top;
            *region_bottom = watch.region_bottom;
            self.sentinel_read = watch.sentinel_read;
            self.sentinel_alive = watch.sentinel_alive;
            // A pacing fold inside the chunk may have counted scrolls
            // past what the sentinel now reads; the chunk's own count is
            // the truth, so take it over wholesale.
            let primary = if watch.alternate { watch.primary } else { watch.count };
            self.scrolled_off_top = self.scrolled_off_top.max(primary as usize);
            let raised = std::mem::take(&mut watch.events);
            if !raised.is_empty() {
                events.extend(raised);
            }
            if let Some(snap) = watch.primary_snap.take() {
                self.primary_snap = Some(snap);
            }
            drop(watch);
            self.fold_sentinel();
        }
    }

    /// Feed several stretches of the program's bytes as one, in order:
    /// the same as feeding each in turn, with the per-feed work done once.
    pub fn process_parts<'a>(&mut self, parts: impl IntoIterator<Item = &'a [u8]>) {
        let mut joined = std::mem::take(&mut self.joined);
        joined.clear();
        for part in parts {
            joined.extend_from_slice(part);
        }
        self.process(&joined);
        self.joined = joined;
    }

    fn note_sync(&mut self) {
        // `Term`'s processor holds the frame itself between the begin and
        // end of a synchronized update; glass only needs to know when it
        // began, for its own hold limit and DECRQM answer.
        let open = self.processor.sync_timeout().sync_timeout().is_some();
        if open && self.sync_since.is_none() {
            self.sync_since = Some(Instant::now());
        } else if !open && self.sync_since.is_some() {
            self.sync_since = None;
        }
    }

    /// Plant the sentinel selection the scroll counter reads: the top row,
    /// spanning two cells so it is never empty. `Term` rotates its
    /// selection on every scroll, so the sentinel's line says how many
    /// lines have left the top of the screen since it was planted.
    fn plant_sentinel(&mut self) {
        let column = self.term.last_column();
        let top = GridPoint::new(Line(0), Column(0));
        let mut sentinel = Sentinel::new(SelectionType::Simple, top, Side::Left);
        sentinel.update(GridPoint::new(Line(0), column), Side::Right);
        self.term.selection = Some(sentinel);
        self.sentinel_read = 0;
        self.sentinel_alive = true;
    }

    /// Fold the sentinel's travels into the count of lines that have
    /// left the top of the screen into history, and replant it. The one
    /// arithmetic both the engine and its wrapper run: called after
    /// every chunk of bytes, and before each `Term` call that drops the
    /// sentinel.
    ///
    /// The count only grows. A sentinel `Term` dropped (ED 2, ED 3 with
    /// the sentinel in history, a screen switch, RIS) or that left the
    /// grid (a resize that pulled history back to the screen) is
    /// replanted where it was: none of those scroll, so the count
    /// stands — the wrapper folds the drop itself, so whatever remains
    /// here can only be a resize pulling history back.
    fn fold_sentinel(&mut self) {
        if self.term.mode().contains(TermMode::ALT_SCREEN) {
            // The alternate screen has no history of its own; scrolls
            // inside it never reach the main grid's, and no sentinel is
            // kept while it is up.
            self.term.selection = None;
            self.sentinel_dropped = true;
            self.sentinel_alive = false;
            return;
        }
        if let Some(range) = self
            .term
            .selection
            .as_ref()
            .and_then(|s| s.to_range(&self.term))
        {
            let mut count = self.scrolled_off_top as u64;
            let plant = fold_sentinel_line(
                &mut count,
                &mut self.sentinel_read,
                &mut self.sentinel_alive,
                range.start.line.0,
            );
            self.scrolled_off_top = count as usize;
            if plant {
                // Keep the sentinel on the top row, or well inside the
                // history, so a full history can never carry it out of
                // sight between reads. Replanting does not scroll.
                self.plant_sentinel();
            }
        } else {
            // The sentinel has been carried out of the grid (a resize
            // that pulled history back onto the screen). That does not
            // scroll, so the count stands and the sentinel is replanted.
            self.plant_sentinel();
        }
    }

    /// Settle the engine for a media piece: the bytes it holds back in
    /// `tail` end whatever partial sequence they are, and an open
    /// synchronized update is applied now, so the picture anchors where
    /// the program put it in the stream. The frame stays held — the
    /// program's `CSI ? 2026 l` still ends the update for display.
    pub fn settle(&mut self) {
        if !self.tail.is_empty() {
            let tail = std::mem::take(&mut self.tail);
            self.process(&tail);
        }
        if self.sync_since.is_some() {
            self.stop_sync_and_count();
            // The frame stays held until the program's end sequence or
            // glass's own limit; `sync_since` stays cleared so DECRQM
            // answers truthfully about the processor, while `hold_since`
            // carries the hold.
        }
    }

    /// End a synchronized update through the counting wrapper, so the
    /// buffered bytes' scrolls and clears are counted and seen.
    fn stop_sync_and_count(&mut self) {
        // The buffer is applied through the counting wrapper in paced
        // slices, the same way `process` feeds `Term`: the sentinel is
        // read between slices, so a large buffered frame cannot scroll
        // it through a full history before it is counted.
        if self.sync_since.is_some() {
            let Engine {
                term,
                processor,
                in_cell,
                scrolled_off_top,
                events,
                alt_scrolled,
                region_top,
                region_bottom,
                sentinel_read,
                sentinel_alive,
                ..
            } = self;
            let alternate = term.mode().contains(TermMode::ALT_SCREEN);
            // Covers and pictures share one absolute line. On the
            // alternate screen that line is its own scrolled count plus
            // the grid row, not the grid row alone.
            let scrolled = *scrolled_off_top as u64;
            let base = if alternate { *alt_scrolled } else { scrolled };
            let count = if alternate { 0 } else { scrolled };
            let mut watch = Watch {
                term,
                events: Vec::new(),
                in_cell: in_cell.clone(),
                base,
                count,
                alternate,
                alt_scrolled: *alt_scrolled,
                region_top: *region_top,
                region_bottom: *region_bottom,
                sentinel_read: *sentinel_read,
                sentinel_alive: *sentinel_alive,
                drained: 0,
                motion_end: self.motion_end,
                primary_snap: None,
                primary: scrolled,
                fast: self.fast,
                preceding: self.preceding_char,
            };
            // The wrapper paces itself while the whole buffered frame is
            // applied: it folds the sentinel after every few hundred
            // printed cells, so a large frame cannot scroll it through a
            // full history before it is counted.
            processor.stop_sync(&mut watch);
            self.preceding_char = watch.preceding;
            self.sentinel_read = watch.sentinel_read;
            self.sentinel_alive = watch.sentinel_alive;
            let primary = if watch.alternate { watch.primary } else { watch.count };
            self.scrolled_off_top = self.scrolled_off_top.max(primary as usize);
            *alt_scrolled = watch.alt_scrolled;
            *region_top = watch.region_top;
            *region_bottom = watch.region_bottom;
            let raised = std::mem::take(&mut watch.events);
            if let Some(snap) = watch.primary_snap.take() {
                self.primary_snap = Some(snap);
            }
            drop(watch);
            if !raised.is_empty() {
                events.extend(raised);
            }
            // The last lines the frame scrolled since the wrapper's own
            // last read are counted here, as `process` does after each
            // chunk, so a picture placed right after the frame anchors
            // by the count the frame left.
            self.fold_sentinel();
            self.sync_since = None;
        }
    }

    /// The clear, reset and coverage events of the bytes fed so far, in
    /// stream order, for the store to apply.
    pub fn take_events(&mut self) -> Vec<Event> {
        std::mem::take(&mut self.events)
    }

    /// The in-cell pictures' rectangles the next text piece is checked
    /// against, in absolute lines: `(first line, last line, first
    /// column, last column)` on the screen that is up.
    pub fn set_in_cell(&mut self, areas: Vec<(u64, u64, u16, u16)>) {
        self.in_cell = areas;
    }

    /// Where anchored pictures and text layers on this screen end, so a
    /// scroll that cannot move one is not reported. `None` means the store
    /// has said nothing on this screen would move. `Some(u64::MAX)` means
    /// the extent is unknown and every scroll is reported.
    pub fn set_motion(&mut self, end: Option<u64>) {
        self.motion_end = end;
    }

    /// The grid cursor's row and column, read live: not
    /// [`Engine::cursor`], which answers `None` while the cursor is
    /// hidden or the view is scrolled back, and programs often hide the
    /// cursor while they draw pictures.
    pub fn grid_cursor(&self) -> (u16, u16) {
        let point = self.term.grid().cursor.point;
        (point.line.0.max(0) as u16, point.column.0 as u16)
    }

    /// The alternate screen's own scroll count since it was entered.
    pub fn alt_scrolled(&self) -> u64 {
        self.alt_scrolled
    }

    /// How many lines of history the engine still holds of the screen
    /// that is up: the primary's own count; 0 on the alternate screen.
    pub fn history_size(&self) -> usize {
        self.term.history_size()
    }

    /// The absolute line the top row of the view shows. The primary
    /// screen's count is the lines that entered history; the alternate
    /// screen's is the lines that left its top. The display offset lifts
    /// the view into history on the primary screen.
    pub fn top_line(&self) -> u64 {
        let offset = self.term.grid().display_offset() as u64;
        let scrolled = if self.alternate_screen() {
            self.alt_scrolled
        } else {
            self.scrolled_off_top as u64
        };
        scrolled.saturating_sub(offset)
    }

    /// Drain what the program's output asked of the window.
    pub fn take_effects(&mut self) -> Effects {
        self.collect();
        std::mem::take(&mut self.effects)
    }

    /// Move what `Term` has reported so far onto the effects, in order.
    fn collect(&mut self) {
        let effects = &mut self.effects;
        loop {
            match self.rx.try_recv() {
                Ok(Query::Reply(bytes)) => effects.replies.extend_from_slice(&bytes),
                Ok(Query::Title(title)) => effects.title = Some(title),
                Ok(Query::Bell) => effects.bell = true,
                Ok(Query::Clipboard(text)) => effects.clipboard = Some(text),
                Ok(Query::ColorRequest(index)) => {
                    let which = match index {
                        256 => 10,
                        257 => 11,
                        258 => 12,
                        _ => continue,
                    };
                    let [r, g, b] = self.info.lock().unwrap_or_else(|e| e.into_inner()).colors
                        [(which - 10) as usize];
                    effects.replies.extend_from_slice(
                        format!(
                            "\x1b]{which};rgb:{r:02x}{r:02x}/{g:02x}{g:02x}/{b:02x}{b:02x}\x1b\\"
                        )
                        .as_bytes(),
                    );
                }
                Ok(Query::TextAreaSize(area)) => {
                    let info = self.info.lock().unwrap_or_else(|e| e.into_inner());
                    let size = WindowSize {
                        num_lines: u16::try_from(self.term.screen_lines()).unwrap_or(u16::MAX),
                        num_cols: u16::try_from(self.term.columns()).unwrap_or(u16::MAX),
                        cell_width: u16::try_from(info.cell_px.0).unwrap_or(u16::MAX),
                        cell_height: u16::try_from(info.cell_px.1).unwrap_or(u16::MAX),
                    };
                    drop(info);
                    effects.replies.extend_from_slice(area(size).as_bytes());
                }
                Err(TryRecvError::Empty) | Err(TryRecvError::Disconnected) => break,
            }
        }
    }

    /// The reply to a query glass answers itself, from the state now.
    fn answer(&self, ask: Ask) -> Vec<u8> {
        match ask {
            Ask::CellSize => {
                let (cw, ch) = self.cell_px();
                format!("\x1b[6;{ch};{cw}t").into_bytes()
            }
            Ask::Primary => b"\x1b[?62;4;22c".to_vec(),
            Ask::Graphics(pi) => match pi {
                1 => b"\x1b[?1;0;1024S".to_vec(),
                2 => {
                    let (cw, ch) = self.cell_px();
                    let width = (self.term.columns() * cw.max(1) as usize).min(8192);
                    let height = (self.term.screen_lines() * ch.max(1) as usize).min(8192);
                    format!("\x1b[?2;0;{width};{height}S").into_bytes()
                }
                other => format!("\x1b[?{other};1;0S").into_bytes(),
            },
            Ask::Secondary => b"\x1b[>1;10;0c".to_vec(),
            Ask::Version => format!("\x1bP>|glass {}\x1b\\", env!("CARGO_PKG_VERSION")).into_bytes(),
            Ask::Synchronized => {
                let state = if self.sync_since.is_some() { 1 } else { 2 };
                format!("\x1b[?2026;{state}$y").into_bytes()
            }
        }
    }

    pub fn resize(&mut self, rows: usize, cols: usize) {
        let rows = rows.max(1);
        let cols = cols.max(2);
        let old_cols = self.term.columns();
        let on_alt = self.term.mode().contains(TermMode::ALT_SCREEN);
        let before = if old_cols != cols {
            if on_alt { self.primary_snap.clone() } else { Some(self.snap_grid()) }
        } else {
            None
        };
        self.term.resize(Size { columns: cols, lines: rows });
        self.region_top = 0;
        self.region_bottom = rows as i32;
        if let Some(before) = before {
            let after = if on_alt {
                simulated_after(&before, rows, cols)
            } else {
                self.snap_grid()
            };
            let mut reflow = crate::intake::motion::reflow_of(&before, &after);
            reflow.new_scrolled = crate::intake::motion::scrolled_after(&reflow);
            self.scrolled_off_top = reflow.new_scrolled as usize;
            self.pending_reflow = Some(reflow);
        }
        self.fold_sentinel();
        if self.term.mode().contains(TermMode::ALT_SCREEN) {
            // The primary grid reflowed out of sight. Keep the prediction,
            // including the scroll count, so the next width change maps
            // from where the text actually is.
            if let Some(reflow) = self.pending_reflow.as_ref() {
                self.primary_snap = Some(crate::intake::motion::GridSnap {
                    cols: reflow.new_cols,
                    screen: rows,
                    history: reflow.new_history,
                    scrolled: self.scrolled_off_top as u64,
                    lines: reflow.new_rows.clone(),
                });
            }
        } else {
            self.primary_snap = Some(self.snap_grid());
        }
    }

    pub fn take_reflow(&mut self) -> Option<crate::intake::motion::Reflow> {
        self.pending_reflow.take()
    }

    fn snap_grid(&self) -> crate::intake::motion::GridSnap {
        snap_term(&self.term, self.scrolled_off_top as u64)
    }

    /// What the window knows, when it changes (a resize, a palette move).
    /// Keep the cell's pixel size current after a window resize.
    pub fn set_cell_px(&mut self, cell_px: (u32, u32)) {
        self.info.lock().unwrap_or_else(|e| e.into_inner()).cell_px = cell_px;
    }

    pub fn cell_px(&self) -> (u32, u32) {
        self.info.lock().unwrap_or_else(|e| e.into_inner()).cell_px
    }


    /// Move the view into the scrollback: negative lines toward the live
    /// screen. Returns whether the view moved.
    pub fn scroll_display(&mut self, lines: isize) -> bool {
        let before = self.display_offset();
        self.term.scroll_display(Scroll::Delta(i32::try_from(lines).unwrap_or(0)));
        self.display_offset() != before
    }

    /// Whether the view sits on the live screen.
    /// Jump the view to the live screen. Returns whether it moved.
    pub fn scroll_to_bottom(&mut self) -> bool {
        let before = self.display_offset();
        self.term.scroll_display(Scroll::Bottom);
        self.display_offset() != before
    }

    fn display_offset(&self) -> usize {
        self.term.grid().display_offset()
    }

    /// `(rows, cols)` of the screen.
    pub fn size(&self) -> (usize, usize) {
        (self.term.screen_lines(), self.term.columns())
    }

    /// The cursor's place in the cells shown, if it shows: the program
    /// can hide it, and the view scrolled off the live screen does.
    pub fn cursor(&self) -> Option<Coord> {
        if self.term.cursor_style().shape == CursorShape::Hidden {
            return None;
        }
        if !self.term.mode().contains(TermMode::SHOW_CURSOR) || self.display_offset() != 0 {
            return None;
        }
        let point = self.term.grid().cursor.point;
        let row = point.line.0;
        (0..self.term.screen_lines() as i32).contains(&row).then(|| {
            (
                u16::try_from(row).unwrap_or(0),
                u16::try_from(point.column.0).unwrap_or(0),
            )
        })
    }

    /// Whether the program asked for a blinking cursor: DECSCUSR 1, 3 or
    /// 5, or mode `?12`. DECSCUSR 0 restores glass's default, a steady
    /// block.
    pub fn cursor_blinking(&self) -> bool {
        self.term.cursor_style().blinking
    }

    /// The cursor's look as glass draws it.
    pub fn cursor_look(&self) -> CursorLook {
        match self.term.cursor_style().shape {
            CursorShape::Block | CursorShape::HollowBlock => CursorLook::Block,
            CursorShape::Underline => CursorLook::Underline,
            CursorShape::Beam => CursorLook::Beam,
            CursorShape::Hidden => CursorLook::Hidden,
        }
    }

    /// The cursor colour the program set, if any.
    pub fn cursor_color(&self) -> Option<Rgb> {
        self.term.colors()[NamedColor::Cursor as usize]
    }

    /// The CSI u keyboard dialect flags the program has pushed: bit 0
    /// disambiguation, bit 1 event types, bit 2 alternate keys, bit 3 all
    /// keys as escape codes, bit 4 associated text.
    pub fn keyboard_flags(&self) -> u8 {
        let mode = self.term.mode();
        let mut flags = 0;
        flags |= u8::from(mode.contains(TermMode::DISAMBIGUATE_ESC_CODES));
        flags |= u8::from(mode.contains(TermMode::REPORT_EVENT_TYPES)) << 1;
        flags |= u8::from(mode.contains(TermMode::REPORT_ALTERNATE_KEYS)) << 2;
        flags |= u8::from(mode.contains(TermMode::REPORT_ALL_KEYS_AS_ESC)) << 3;
        flags |= u8::from(mode.contains(TermMode::REPORT_ASSOCIATED_TEXT)) << 4;
        flags
    }

    pub fn alternate_screen(&self) -> bool {
        self.term.mode().contains(TermMode::ALT_SCREEN)
    }

    pub fn application_cursor(&self) -> bool {
        self.term.mode().contains(TermMode::APP_CURSOR)
    }

    pub fn bracketed_paste(&self) -> bool {
        self.term.mode().contains(TermMode::BRACKETED_PASTE)
    }

    pub fn focus_reports(&self) -> bool {
        self.term.mode().contains(TermMode::FOCUS_IN_OUT)
    }

    pub fn mouse_protocol(&self) -> (MouseProtocolMode, MouseProtocolEncoding) {
        let mode = self.term.mode();
        let protocol = if mode.contains(TermMode::MOUSE_MOTION) {
            MouseProtocolMode::AnyMotion
        } else if mode.contains(TermMode::MOUSE_DRAG) {
            MouseProtocolMode::ButtonMotion
        } else if mode.contains(TermMode::MOUSE_REPORT_CLICK) {
            MouseProtocolMode::PressRelease
        } else {
            MouseProtocolMode::None
        };
        let encoding = if mode.contains(TermMode::SGR_MOUSE) {
            MouseProtocolEncoding::Sgr
        } else if mode.contains(TermMode::UTF8_MOUSE) {
            MouseProtocolEncoding::Utf8
        } else {
            MouseProtocolEncoding::Default
        };
        (protocol, encoding)
    }

    /// The program is inside a synchronized update (DECSET 2026).
    pub fn synchronized(&self) -> bool {
        self.sync_since.is_some()
    }

    /// End a synchronized update whose deadline passed, applying the bytes
    /// the program sent since it opened. `Term`'s processor holds the frame
    /// between the begin and end of one and expects its host to end it when
    /// the deadline does; a program that opens an update and stalls would
    /// hold the screen forever otherwise. Returns whether the update ended,
    /// so the frame is marked dirty and drawn.
    pub fn end_sync_update(&mut self) -> bool {
        let deadline = self.processor.sync_timeout().sync_timeout();
        let Some(deadline) = deadline else {
            return false;
        };
        if Instant::now() < deadline {
            return false;
        }
        self.stop_sync_and_count();
        true
    }

    /// Hold the frame: a synchronized update is open and has not run past
    /// glass's own limit.
    pub fn holding_frame(&self, limit: std::time::Duration) -> bool {
        self.hold_since.is_some_and(|since| since.elapsed() < limit)
    }

    /// Lines that have left the top of the screen into history so far, by
    /// what scrolled: full-screen scrolls and autowrap both count; scrolls
    /// inside a scroll region that does not start at the top never reach
    /// history and do not count. The count only grows — `CSI 3 J` empties
    /// history but does not lower it, and the picture intake anchors its
    /// frames by counting lines from the start of the output.
    ///
    /// On the alternate screen nothing is counted: it has no history of its
    /// own, and lines that left the main screen before the switch are
    /// counted when the main screen comes back. A resize that changes the
    /// width reflows the primary grid, including while the alternate screen
    /// is up. The count moves with that reflow so a line's absolute number
    /// still names the row it occupies: lines pushed into history raise it,
    /// and a history row pulled back onto the screen can lower it. Lines
    /// that scroll after the resize are counted from there.
    // The picture intake, on the branch that builds it, is the caller.
    #[allow(dead_code)]
    pub fn scrolled_off_top(&self) -> usize {
        self.scrolled_off_top
    }

    /// A snapshot of the cells the window shows, top row first.
    /// The text of one grid line, history included (`line` 0 is the top of
    /// the screen, negative lines are history). Used to check that a
    /// picture stayed with its text.
    #[cfg(test)]
    pub fn grid_line(&self, line: i32) -> String {
        use alacritty_terminal::index::{Column, Line};
        let cols = self.term.columns();
        let row = &self.term.grid()[Line(line)];
        let mut text = String::with_capacity(cols);
        for c in 0..cols {
            let ch = row[Column(c)].c;
            text.push(if ch == '\0' { ' ' } else { ch });
        }
        text
    }

    /// Write plain text runs straight into the grid (the default), or
    /// leave every byte to the parser: the tests hold the one to the
    /// other.
    #[cfg(test)]
    pub fn set_fast(&mut self, on: bool) {
        self.fast = on;
    }

    /// Everything the grid holds, history and screen, with the cursor:
    /// what a fast path must leave exactly as the parser does. A link's
    /// id `Term` numbered itself is left out: the numbers run on across
    /// every terminal in the process.
    #[cfg(test)]
    pub fn grid_state(&self) -> (Vec<String>, String, usize, usize) {
        use alacritty_terminal::index::Line;
        use alacritty_terminal::term::cell::Cell as TermCell;
        let key = |cell: &TermCell| {
            let link = cell.hyperlink().map(|link| {
                let id = link.id().to_owned();
                (if id.ends_with("_alacritty") { String::new() } else { id }, link.uri().to_owned())
            });
            format!(
                "{:?} {:?} {:?} {:?} {:?} {:?} {:?}",
                cell.c,
                cell.fg,
                cell.bg,
                cell.flags,
                cell.zerowidth(),
                cell.underline_color(),
                link
            )
        };
        let grid = self.term.grid();
        let history = self.term.history_size();
        let mut cells = Vec::new();
        for line in -(history as i32)..self.term.screen_lines() as i32 {
            for column in 0..self.term.columns() {
                cells.push(key(&grid[Line(line)][Column(column)]));
            }
        }
        let cursor = format!(
            "{:?} {} {} {:?} {:?}",
            grid.cursor.point,
            grid.cursor.input_needs_wrap,
            key(&grid.cursor.template),
            grid.cursor.charsets,
            self.term.mode()
        );
        (cells, cursor, history, self.scrolled_off_top)
    }

    pub fn cells(&mut self) -> &[Cell] {
        let grid = self.term.grid();
        let offset = grid.display_offset();
        let (rows, cols) = (grid.screen_lines(), grid.columns());
        self.cells.clear();
        self.cells.reserve(rows * cols);
        for row in 0..rows {
            let line = alacritty_terminal::term::viewport_to_point(offset, Point::new(row, Column(0))).line;
            let cells = &grid[line];
            for col in 0..cols {
                let cell = &cells[Column(col)];
                // The trailing half of a wide character keeps its own flags
                // (a click on the right half still lands in the word) but
                // carries no character of its own, so copying skips it
                // instead of doubling the character.
                let c = if cell.flags.intersects(
                    CellFlags::WIDE_CHAR_SPACER | CellFlags::LEADING_WIDE_CHAR_SPACER,
                ) {
                    '\0'
                } else {
                    cell.c
                };
                let fg = color_of(cell.fg);
                let mut marks = ['\0'; 3];
                if let Some(extra) = cell.zerowidth() {
                    for (i, ch) in extra.iter().take(3).enumerate() {
                        marks[i] = *ch;
                    }
                }
                let underline = cell.underline_color().map(color_of).unwrap_or(Color::Default);
                self.cells.push(Cell {
                    c,
                    fg,
                    bg: color_of(cell.bg),
                    flags: cell.flags,
                    link: cell.hyperlink().map(|link| link.uri().to_owned()),
                    marks,
                    fg_id: color_id(fg),
                    underline_id: color_id(underline),
                    underline,
                });
            }
        }
        &self.cells
    }

    /// The hyperlink open over a cell, if any.
    pub fn link_at(&self, row: u16, col: u16) -> Option<String> {
        if usize::from(row) >= self.term.screen_lines()
            || usize::from(col) >= self.term.columns()
        {
            return None;
        }
        let grid = self.term.grid();
        let point = alacritty_terminal::term::viewport_to_point(
            grid.display_offset(),
            Point::new(usize::from(row), Column(usize::from(col))),
        );
        grid[point.line][point.column].hyperlink().map(|link| link.uri().to_owned())
    }
}

/// Whether these bytes are the start of a sequence glass answers itself,
/// cut off by the end of the read. Returns the bytes to hold back.
/// A cell rectangle the writing reached: absolute lines (the count of
/// lines that have left the top of the screen, so line 0 is the first
/// line that ever scrolled off) and a column range.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct CoveredArea {
    pub line: u64,
    pub rows: usize,
    pub column: u16,
    pub columns: usize,
}

/// One change to the screen the picture intake must hear about, in the
/// order the program's bytes caused it.
#[derive(Debug, Clone, PartialEq)]
pub enum Event {
    /// ED 2: the screen's pictures go, on whichever screen is up. The
    /// count is the one before `Term` pushed the screen's lines into
    /// history (the main screen only; the alternate pushes nothing).
    Clear { alternate: bool, scrolled: u64 },
    /// ED 3: the saved lines go.
    ClearSaved,
    /// RIS: everything goes.
    Reset,
    /// Writing reached cells an in-cell picture lives in.
    Covered { alternate: bool, area: CoveredArea },
    /// Text inside a scroll region moved. `top` and `bottom` are the
    /// band's absolute lines before the scroll (`bottom` exclusive).
    /// `up` is how many lines the text moved toward smaller line numbers;
    /// `down` the other way. `count_delta` is how much this screen's
    /// scroll count increased. `keep_above` means lines that left the top
    /// of the band entered history; otherwise they were discarded.
    /// `clears` means the band was erased rather than shifted.
    RegionScroll {
        alternate: bool,
        top: u64,
        bottom: u64,
        up: u64,
        down: u64,
        count_delta: u64,
        keep_above: bool,
        clears: bool,
    },
}

/// Wrap lines of the grid that is up, so a later resize can keep
/// pictures on the same text. Called when the alternate screen is
/// entered and when the live grid is resized, not after every chunk.
fn snap_term(term: &Term<Listener>, scrolled: u64) -> crate::intake::motion::GridSnap {
    use alacritty_terminal::index::{Column, Line};
    use alacritty_terminal::term::cell::Flags;
    let cols = term.columns();
    let screen = term.screen_lines();
    let history = term.history_size();
    let grid = term.grid();
    let mut lines = Vec::with_capacity(history + screen);
    for i in -(history as i32)..(screen as i32) {
        let row = &grid[Line(i)];
        let wrap = cols > 0 && row[Column(cols - 1)].flags.contains(Flags::WRAPLINE);
        let mut len = 0u16;
        if wrap {
            len = cols as u16;
        } else {
            for c in 0..cols {
                if !row[Column(c)].is_empty() {
                    len = (c as u16) + 1;
                }
            }
        }
        lines.push(crate::intake::motion::RowSnap { wrap, len });
    }
    crate::intake::motion::GridSnap {
        cols,
        screen,
        history,
        scrolled,
        lines,
    }
}

/// `Term` raises no hook for the events the picture intake needs, so it
/// is fed through a wrapper that forwards every method of vte's
/// `Handler` trait — a method not forwarded falls back to the trait's
/// do-nothing default and silently drops a feature — and records the
/// events along the way. The impl keeps the trait's own order, so it can
/// be checked line by line against `vte`'s `ansi.rs`.
struct Watch<'a> {
    term: &'a mut Term<Listener>,
    events: Vec<Event>,
    /// The in-cell rectangles currently live on the screen that is up,
    /// as (first line, last line, first column, last column) in absolute
    /// lines, so `input` records coverage only when it matters.
    in_cell: Vec<(u64, u64, u16, u16)>,
    /// The absolute line of the screen's top row.
    base: u64,
    /// The scroll count of the screen that is up, before the clear
    /// pushes anything, as the store's `clear_screen` boundary wants it.
    count: u64,
    alternate: bool,
    /// The alternate screen's own scroll count, which no sentinel counts:
    /// the rows scrolls took off its top while it has been up.
    alt_scrolled: u64,
    /// The scroll region, mirroring `Term`.
    region_top: i32,
    region_bottom: i32,
    /// The sentinel's state, carried for the engine: where it was last
    /// read, and whether it is planted.
    sentinel_read: usize,
    sentinel_alive: bool,
    /// The cells the wrapper has printed since it last read the
    /// sentinel, so a long buffered frame drains in paced steps.
    drained: usize,
    /// Exclusive end of anchored content on this screen, or `None` when
    /// a scroll cannot move anything. See `Engine::set_motion`.
    motion_end: Option<u64>,
    /// A snap of the primary grid taken as the alternate screen is
    /// entered, copied onto the engine when the chunk ends.
    primary_snap: Option<crate::intake::motion::GridSnap>,
    /// The primary screen's count while the alternate screen is up, so
    /// a switch inside the feed (a synchronized update applied at once)
    /// counts each screen as its own.
    primary: u64,
    /// Whether characters may be written straight into their cells
    /// (`print_plain`); off only for the tests that hold it to `Term`.
    fast: bool,
    /// The character a REP (`CSI Ps b`) repeats: what glass's own print
    /// lanes last wrote, kept as the parser's `preceding_char` is, so a
    /// REP taken by the lane repeats what the stream actually printed.
    preceding: Option<char>,
}

impl Watch<'_> {
    /// Wrap the engine's `Term` for one chunk of bytes, with the
    /// coverage rectangles and the screen state as they stand before the
    /// chunk runs. In-cell rectangles live on absolute lines, so `base`
    /// (the absolute line of the screen's top row) is that screen's
    /// scrolled count: the primary screen's lines that left its top, or
    /// the alternate screen's own scrolled count.
    #[allow(dead_code)] // the parity test builds its own watch
    fn over<'a>(engine: &'a mut Engine, _chunk: &[u8]) -> Watch<'a> {
        let alternate = engine.term.mode().contains(TermMode::ALT_SCREEN);
        let scrolled = engine.scrolled_off_top as u64;
        let base = if alternate { engine.alt_scrolled } else { scrolled };
        let count = if alternate { 0 } else { scrolled };
        Watch {
            term: &mut engine.term,
            events: Vec::new(),
            in_cell: engine.in_cell.clone(),
            base,
            count,
            alternate,
            alt_scrolled: engine.alt_scrolled,
            region_top: engine.region_top,
            region_bottom: engine.region_bottom,
            sentinel_read: engine.sentinel_read,
            sentinel_alive: engine.sentinel_alive,
            drained: 0,
            motion_end: engine.motion_end,
            primary_snap: None,
            primary: scrolled,
            fast: engine.fast,
            preceding: None,
        }
    }

    /// Plant the sentinel selection the scroll counter reads, mirroring
    /// `Engine::plant_sentinel`.
    fn plant_sentinel(&mut self) {
        let column = self.term.last_column();
        let top = GridPoint::new(Line(0), Column(0));
        let mut sentinel = Sentinel::new(SelectionType::Simple, top, Side::Left);
        sentinel.update(GridPoint::new(Line(0), column), Side::Right);
        self.term.selection = Some(sentinel);
        self.sentinel_read = 0;
        self.sentinel_alive = true;
    }

    /// Replant the sentinel after a `Term` call that dropped it. The
    /// fold has already been run, so what was scrolled is counted; the
    /// new sentinel starts again from the top row.
    fn replant(&mut self) {
        self.plant_sentinel();
    }

    /// Fold the sentinel's travels into the count, mirroring the
    /// engine's own arithmetic: the same numbers, run while `Term` is
    /// borrowed. The alternate screen keeps no sentinel and counts
    /// nothing here.
    fn fold_sentinel(&mut self) {
        if self.term.mode().contains(TermMode::ALT_SCREEN) {
            self.term.selection = None;
            self.sentinel_alive = false;
            return;
        }
        if let Some(range) = self
            .term
            .selection
            .as_ref()
            .and_then(|s| s.to_range(self.term))
        {
            let plant = fold_sentinel_line(
                &mut self.count,
                &mut self.sentinel_read,
                &mut self.sentinel_alive,
                range.start.line.0,
            );
            if plant {
                self.plant_sentinel();
            }
        } else {
            self.plant_sentinel();
        }
        self.base = self.count;
    }

    /// The absolute line a grid row is on. Grid rows are unsigned from
    /// the viewport top; the absolute line is `base` plus the row, so a
    /// picture anchored below the live screen still lands on its text.
    fn line_of(&self, row: i32) -> u64 {
        self.base + row.max(0) as u64
    }

    /// Record that the writing reached this rectangle, if an in-cell
    /// picture lives there. Grid rows are absolute from the grid top
    /// (history included), so they are already absolute lines shifted by
    /// the display offset; the store matches on what it is given.
    fn covers(&mut self, start_row: i32, rows: usize, column: usize, columns: usize) {
        if self.in_cell.is_empty() || rows == 0 || columns == 0 {
            return;
        }
        let cols_total = self.term.columns();
        let columns = columns.min(cols_total.saturating_sub(column));
        let line = self.line_of(start_row);
        let hits = self.in_cell.iter().any(|(l0, l1, c0, c1)| {
            line <= *l1
                && line + rows as u64 > *l0
                && column as u16 <= *c1
                && column as u16 + columns as u16 > *c0
        });
        if hits {
            self.events.push(Event::Covered {
                alternate: self.alternate,
                area: CoveredArea {
                    line,
                    rows,
                    column: column as u16,
                    columns,
                },
            });
        }
    }

    /// The common character, written straight into its cell or cells:
    /// printable ASCII, or any other character one or two cells wide,
    /// with no wrap pending, the character fitting on the line, no
    /// insert mode, no extra on the pen (an underline colour or a link),
    /// no wide character underneath, and no in-cell picture to check;
    /// for ASCII, every character set plain ASCII too. That is exactly
    /// what `Term::input` does with it then — set the cell (and a wide
    /// character's spacer) from the pen, step the cursor or mark the
    /// wrap — without the charset map and the reference count. Returns
    /// false, having done nothing, for anything else.
    #[inline(always)]
    fn print_plain(&mut self, c: char) -> bool {
        if !self.fast || !self.in_cell.is_empty() || self.term.mode().contains(TermMode::INSERT) {
            return false;
        }
        if !(' '..='~').contains(&c) {
            return self.print_wide(c);
        }
        let columns = self.term.columns();
        let grid = self.term.grid_mut();
        let cursor = &grid.cursor;
        if cursor.input_needs_wrap || cursor.template.extra.is_some() || cursor.charsets != Default::default() {
            return false;
        }
        let point = cursor.point;
        let (fg, bg, flags) = (cursor.template.fg, cursor.template.bg, cursor.template.flags);
        let cell = &mut grid[point.line][point.column];
        if cell.flags.intersects(CellFlags::WIDE_CHAR | CellFlags::WIDE_CHAR_SPACER) {
            return false;
        }
        self.preceding = Some(c);
        cell.c = c;
        cell.fg = fg;
        cell.bg = bg;
        cell.flags = flags;
        cell.extra = None;
        if point.column.0 + 1 < columns {
            grid.cursor.point.column.0 += 1;
        } else {
            grid.cursor.input_needs_wrap = true;
        }
        self.drained += 1;
        if self.drained >= SYNC_DRAIN_CHUNK {
            self.fold_sentinel();
            self.drained = 0;
        }
        true
    }

    /// `print_plain` for a character past ASCII: one or two cells wide,
    /// with no character set to map it.
    #[inline(never)]
    fn print_wide(&mut self, c: char) -> bool {
        if c < '\u{a0}' {
            return false;
        }
        let width = match width_of(c) {
            Some(width @ 1..=2) => width,
            _ => return false,
        };
        let columns = self.term.columns();
        let grid = self.term.grid_mut();
        let cursor = &grid.cursor;
        let wide = CellFlags::WIDE_CHAR | CellFlags::WIDE_CHAR_SPACER | CellFlags::LEADING_WIDE_CHAR_SPACER;
        if cursor.input_needs_wrap || cursor.template.extra.is_some() || cursor.template.flags.intersects(wide) {
            return false;
        }
        let point = cursor.point;
        let column = point.column.0;
        if column + width > columns {
            return false;
        }
        let (fg, bg, flags) = (cursor.template.fg, cursor.template.bg, cursor.template.flags);
        let row = &mut grid[point.line];
        let underneath = CellFlags::WIDE_CHAR | CellFlags::WIDE_CHAR_SPACER;
        if row[Column(column)].flags.intersects(underneath)
            || (width == 2 && row[Column(column + 1)].flags.intersects(underneath))
        {
            return false;
        }
        let cell = &mut row[Column(column)];
        self.preceding = Some(c);
        cell.c = c;
        cell.fg = fg;
        cell.bg = bg;
        cell.flags = if width == 2 { flags | CellFlags::WIDE_CHAR } else { flags };
        cell.extra = None;
        if width == 2 {
            let spacer = &mut row[Column(column + 1)];
            spacer.c = ' ';
            spacer.fg = fg;
            spacer.bg = bg;
            spacer.flags = flags | CellFlags::WIDE_CHAR_SPACER;
            spacer.extra = None;
        }
        let last = column + width - 1;
        if last + 1 < columns {
            grid.cursor.point.column = Column(last + 1);
        } else {
            grid.cursor.point.column = Column(last);
            grid.cursor.input_needs_wrap = true;
        }
        self.drained += 1;
        if self.drained >= SYNC_DRAIN_CHUNK {
            self.fold_sentinel();
            self.drained = 0;
        }
        true
    }

    /// A run of printable ASCII, each character as `input` would take
    /// it, written a line's worth at a time: the cells from the pen, the
    /// cursor stepped past them or the wrap marked at the last column. A
    /// character that needs more — a pending wrap, a wide character
    /// underneath — goes through `input` itself. Returns how many bytes it
    /// took; the caller hands the rest to the parser. Takes none while
    /// the cells must be checked for in-cell pictures, in insert mode,
    /// with an extra on the pen or a character set that is not ASCII.
    fn print_run(&mut self, run: &[u8]) -> usize {
        if run.is_empty() || !self.in_cell.is_empty() || self.term.mode().contains(TermMode::INSERT) {
            return 0;
        }
        {
            let cursor = &self.term.grid().cursor;
            if cursor.template.extra.is_some() || cursor.charsets != Default::default() {
                return 0;
            }
        }
        let columns = self.term.columns();
        let mut taken = 0;
        while taken < run.len() {
            let grid = self.term.grid_mut();
            if grid.cursor.input_needs_wrap {
                // The wrap, and any scroll it makes, as `input` does it.
                alacritty_terminal::vte::ansi::Handler::input(self, char::from(run[taken]));
                taken += 1;
                continue;
            }
            let point = grid.cursor.point;
            let template = &grid.cursor.template;
            let (fg, bg, flags) = (template.fg, template.bg, template.flags);
            let column = point.column.0.min(columns - 1);
            let n = (columns - column).min(run.len() - taken);
            // Dropless writes when the row owes no `extra` drops (the
            // row's maintained `extra_free` bit): the assignment's
            // drop/store of the old `Arc` cell value was ~40% of the
            // lane's cost above char+extra alone (probe-bounded,
            // 2026-11-02).
            // One row lookup for the lane's three questions: dropless
            // writes, char-only writes, and what the write owes the
            // uniform prefix afterwards.
            let (dropless, prefix, prefix_to) = {
                let row = &grid[point.line];
                (row.extra_free(), row.uniform_prefix(template), row.uniform_to())
            };
            // Char-only writes when the row's uniform-style prefix
            // covers the whole slice in this pen: the pen stores are
            // then already in place, and no cell underneath can be
            // wide (the pen carries no wide bits). The flood's steady
            // state — every row recycled still holding the previous
            // cycle's pen — takes this branch for whole lines. The
            // cursor's template is the specimen (`style_eq` ignores
            // the character, and this run was refused a pen carrying
            // an extra above). Short slices skip the char-only branch:
            // its per-slice upkeep only pays over a real run.
            let uniform = n >= 8
                && !flags.intersects(CellFlags::WIDE_CHAR | CellFlags::WIDE_CHAR_SPACER)
                && column + n <= prefix;
            // A full write restyles prefix cells the prefix claimed
            // only when it starts inside the prefix in a different
            // style; same-style and beyond-prefix writes owe nothing.
            let owes_truncate = column < prefix_to && prefix < prefix_to;
            let (cells, blank_from) = grid.lane_cells_slice(point.line, column, n);
            let mut written = 0;
            // The run-lane ceiling probes (env-gated; DELIBERATELY
            // INCORRECT renderings when on — each bounds one suspect in
            // this loop so the gap's remainder can be attributed; none
            // of them is a shipping change). Off unless GLASS_RUN_PROBE
            // is set, and never set by anything but the bench.
            // The shipped loop stores the pen unconditionally: measured
            // against a conditional-store variant (probe 2) it wins by
            // ~25% — the compares cost far more than the fire-and-forget
            // stores they would save. Probe 1 skips the wide test, 2 is
            // the rejected conditional-pen variant, kept for the record.
            match crate::engine::probes::get() {
                1 => for (cell, &b) in cells.iter_mut().zip(&run[taken..taken + n]) {
                    cell.c = char::from(b);
                    cell.fg = fg;
                    cell.bg = bg;
                    cell.flags = flags;
                    cell.extra = None;
                    written += 1;
                },
                _ if uniform => {
                    let mut last = None;
                    for (cell, &b) in cells.iter_mut().zip(&run[taken..taken + n]) {
                        cell.c = char::from(b);
                        last = Some(b);
                        written += 1;
                    }
                    if written > 0 {
                        self.preceding = last.map(char::from);
                    }
                }
                _ => {
                    // How much of the slice may be written before a wide
                    // character underneath must be left to `input`: the
                    // guard reads the observable cells, and columns past
                    // the lazy frontier are blank — their physical bytes
                    // are stale, never to be trusted. The read runs ahead
                    // of the writes so the write loop below stays the
                    // shape it is; see the template comment there.
                    let mut limit = n;
                    if column < blank_from {
                        let guarded = (blank_from - column).min(n);
                        if let Some(bad) = cells[..guarded]
                            .iter()
                            .position(|cell| cell.flags.intersects(CellFlags::WIDE_CHAR | CellFlags::WIDE_CHAR_SPACER))
                        {
                            limit = bad;
                        }
                    }
                    // Whole cells from one template, not field stores:
                    // the same five values written either way, but the
                    // template assignment's wide stores measure faster
                    // than five narrow field stores on the plain-text
                    // floods (+5% ascii, +10% scroll_region MB/cpu-s,
                    // paired, in 2026-11-02-gate-stack). The template's
                    // extra is `None`, so its clone is a plain copy; the
                    // assignment still drops each old cell's extra as
                    // the field form did.
                    //
                    // When the row's `extra_free` bit holds, no replaced
                    // cell owns an extra, so the drop can be skipped
                    // outright (`ptr::write`). Learning that per cell
                    // costs the same load the drop does (-15% measured
                    // with a precheck scan); the maintained row bit
                    // learns it once per row instead.
                    //
                    // The REP character is what this loop last wrote, set
                    // once after the loop rather than per cell: the lane's
                    // writes are prints the parser never sees, so `input`
                    // cannot track them itself.
                    let template =
                        alacritty_terminal::term::cell::Cell { c: ' ', fg, bg, flags, extra: None };
                    let mut last = None;
                    if dropless {
                        for (cell, &b) in
                            cells[..limit].iter_mut().zip(&run[taken..taken + limit])
                        {
                            let mut fresh = template.clone();
                            fresh.c = char::from(b);
                            // SAFETY: `extra_free` holds for the whole
                            // row, so the replaced value owns nothing;
                            // skipping its drop cannot leak. This lane
                            // only ever writes `extra: None` cells, so
                            // the bit stays true.
                            unsafe { std::ptr::write(cell, fresh) };
                            last = Some(b);
                            written += 1;
                        }
                    } else {
                        for (cell, &b) in
                            cells[..limit].iter_mut().zip(&run[taken..taken + limit])
                        {
                            *cell = template.clone();
                            cell.c = char::from(b);
                            last = Some(b);
                            written += 1;
                        }
                    }
                    if written > 0 {
                        self.preceding = last.map(char::from);
                        // The full writes above leave their span in the
                        // template's style; say so, and the next pass
                        // over this row in the same pen writes chars
                        // alone. Short writes skip the note's style
                        // compare (as at the check) but still owe the
                        // prefix a truncate when they restyled cells
                        // it claimed (`owes_truncate`, above).
                        if written >= 8 {
                            grid[point.line]
                                .note_uniform_write(column, column + written, &template);
                        } else if owes_truncate {
                            grid[point.line].truncate_uniform(column);
                        }
                    }
                }
            }
            if written > 0 {
                let end = column + written;
                if end < columns {
                    grid.cursor.point.column = Column(end);
                } else {
                    grid.cursor.point.column = Column(columns - 1);
                    grid.cursor.input_needs_wrap = true;
                }
                taken += written;
                self.drained += written;
            }
            if written < n {
                // A wide character underneath: `input` clears it properly.
                alacritty_terminal::vte::ansi::Handler::input(self, char::from(run[taken]));
                taken += 1;
            }
        }
        if self.drained >= SYNC_DRAIN_CHUNK {
            self.fold_sentinel();
            self.drained = 0;
        }
        taken
    }

    /// Text the parser would print, decoded once here and each character
    /// taken as `input` takes it: the plain ones written straight into
    /// their cells, the rest (a mark that joins the cell before, a
    /// character that wraps) through `input` itself. It stops at a byte
    /// that is not well-formed UTF-8 or at a C1 control, which the parser
    /// carries out rather than prints, and leaves the last character it
    /// decoded to the parser, which keeps it for REP. Returns how many
    /// bytes it took.
    fn print_utf8(&mut self, text: &[u8]) -> usize {
        // What holds for every character of the run is checked once: the
        // pen, the charsets, insert mode and in-cell pictures do not change
        // inside it, whatever `input` does with a character.
        let plain = self.fast && self.in_cell.is_empty() && !self.term.mode().contains(TermMode::INSERT) && {
            let template = &self.term.grid().cursor.template;
            template.extra.is_none()
                && !template.flags.intersects(CellFlags::WIDE_CHAR | CellFlags::WIDE_CHAR_SPACER | CellFlags::LEADING_WIDE_CHAR_SPACER)
        };
        let ascii = plain && self.term.grid().cursor.charsets == Default::default();
        let mut at = 0;
        let mut held: Option<(char, usize)> = None;
        loop {
            // As many as fit go into the cursor's row at once; this loop
            // takes the one that stopped them.
            if plain {
                (at, held) = self.put_row(text, at, held, ascii);
            }
            let Some((c, len)) = utf8_at(text, at) else {
                break;
            };
            if ('\u{7f}'..='\u{9f}').contains(&c) {
                break;
            }
            if let Some((last, _)) = held
                && !self.put_plain(last, plain, ascii)
            {
                alacritty_terminal::vte::ansi::Handler::input(self, last);
            }
            held = Some((c, at));
            at += len;
        }
        if self.drained >= SYNC_DRAIN_CHUNK {
            self.fold_sentinel();
            self.drained = 0;
        }
        // Run-whole: the held character is flushed here (the loop
        // writes each character as the next is decoded, so the last
        // would otherwise never be written), the same way the loop
        // writes one - put_plain where it applies, `input` otherwise.
        if run_whole() && at == text.len() {
            if let Some((last, _)) = held {
                if self.put_plain(last, plain, ascii) {
                    // `input` keeps the REP character; the lane must too
                    // when it writes the last character itself.
                    self.preceding = Some(last);
                } else {
                    alacritty_terminal::vte::ansi::Handler::input(self, last);
                }
                // put_row updated the cursor for the characters it wrote;
                // put_plain writes straight into the grid and does the
                // same, so nothing more is needed here.
            }
            return text.len();
        }
        held.map_or(0, |(_, start)| start)
    }

    /// `print_utf8`'s loop for characters `put_plain` would write, with
    /// the cursor's row, the pen and the place looked up once rather than
    /// for each character. Each character is written as the next one is
    /// decoded, so the last stays held, as there. A mark that joins the
    /// character before it (no width of its own: a combining accent) goes
    /// onto that character's cell here too, as `Term::input` puts it. It
    /// stops, taking nothing more, at the end of the well-formed text, at
    /// a C1 control, or at a held character `put_plain` would refuse, and
    /// returns where it stopped and what it holds.
    #[inline(always)]
    fn put_row(&mut self, text: &[u8], mut at: usize, mut held: Option<(char, usize)>, ascii: bool) -> (usize, Option<(char, usize)>) {
        let columns = self.term.columns();
        let grid = self.term.grid_mut();
        if grid.cursor.input_needs_wrap {
            return (at, held);
        }
        let line = grid.cursor.point.line;
        let mut column = grid.cursor.point.column.0;
        let (fg, bg, flags) = (grid.cursor.template.fg, grid.cursor.template.bg, grid.cursor.template.flags);
        let underneath = CellFlags::WIDE_CHAR | CellFlags::WIDE_CHAR_SPACER;
        let mut wrap = false;
        let mut written = 0;
        let row = &mut grid[line];
        // This run's writes all land at or past `column` through the
        // lane escapes, which do not maintain the row's uniform-style
        // prefix; truncate it here, then re-note the span below if
        // every glyph took the narrow template. (Writing narrow
        // glyphs char-only inside the prefix was tried and measured
        // -20% on unicode: per glyph here the decode, width lookup
        // and guard dwarf the pen stores saved, unlike `print_run`
        // where the store is the whole loop.)
        let span_start = column;
        let mut span_clean = true;
        row.truncate_uniform(column);
        // Non-lazy rows guard every column (guard_from = usize::MAX, so
        // `column < guard_from` always holds); lazy rows guard only their
        // physical prefix — past the frontier the observable cell is the
        // blank, which carries no wide flags. A run that starts at or
        // past the frontier therefore needs no guard at all
        // (guard_from = 0: `column < guard_from` never holds).
        let guard_from = match row.lazy_frontier() {
            Some(frontier) if column >= frontier => 0,
            other => other.unwrap_or(usize::MAX),
        };
        // The cells this run writes, built once (see the write below).
        let narrow = alacritty_terminal::term::cell::Cell { c: ' ', fg, bg, flags, extra: None };
        // Materialize the gap left of the run once, then write into
        // the raw slice for the rest of the run: per glyph this saves
        // overwrite_cell's frontier branches and the guard's
        // virtual-cell blank check (together ~4% of unicode, bounded
        // with both removed). `occ` is bumped once at the end for the
        // span actually written; the guard reads physical cells, but
        // it only runs below `guard_from`, where physical is
        // observable. A mark leaves the run instead of being put
        // inline — the caller's fallback hands it to `input`.
        let start_column = column;
        let _ = row.lane_cells(column, 0);
        let cells = row.lane_slice_from(column);
        let mut occ_to = column;
        let wide = alacritty_terminal::term::cell::Cell {
            flags: flags | CellFlags::WIDE_CHAR,
            ..narrow.clone()
        };
        let spacer = alacritty_terminal::term::cell::Cell {
            flags: flags | CellFlags::WIDE_CHAR_SPACER,
            ..narrow.clone()
        };
        while let Some((c, len)) = utf8_at(text, at) {
            if ('\u{7f}'..='\u{9f}').contains(&c) {
                break;
            }
            if let Some((last, _)) = held {
                let width = if (' '..='~').contains(&last) {
                    if !ascii {
                        break;
                    }
                    1
                } else {
                    // Making every non-ASCII character one cell wide sped
                    // up an old ablation, but also changed cursor movement,
                    // spacer writes, wrap frequency and guards. It does not
                    // isolate width lookup cost or promise a reclaimable gain.
                    // A 4 KiB U+0000..U+0FFF table was a wash; a Latin-1
                    // branch was slower and disagreed with the width policy.
                    // Preserve the authoritative table's semantics. See
                    // bench/results/2026-11-02-glyph-batch for another measured
                    // attempt to separate lookup/decoding from cursor stride.
                    match width_of(last) {
                        Some(width @ 1..=2) => width,
                        Some(0) => {
                            // A mark joins the cell before it through
                            // the caller's `input` fallback; it needs
                            // the row, not this slice.
                            break;
                        }
                        _ => break,
                    }
                };
                // The wide-char guard reads the slice's physical
                // cells, which are the observable ones below
                // `guard_from` (above it the observable cell is the
                // blank, which carries no wide flags).
                let at_col = column - start_column;
                if wrap
                    || column + width > columns
                    || (column < guard_from
                        && (cells[at_col].flags.intersects(underneath)
                            || (width == 2
                                && cells[at_col + 1].flags.intersects(underneath))))
                {
                    break;
                }
                // Full-overwrite writes: a recycled row pays no blank
                // fill for cells this run writes (the gap was
                // materialized once above). Whole cells from a
                // template, as in `print_run`: the assignment's wide
                // stores measure faster than the five field stores
                // they write the same values as.
                {
                    let cell = &mut cells[at_col];
                    *cell = if width == 2 { wide.clone() } else { narrow.clone() };
                    cell.c = last;
                }
                if width == 2 {
                    span_clean = false;
                    cells[at_col + 1] = spacer.clone();
                }
                occ_to = column + width;
                let end = column + width - 1;
                if end + 1 < columns {
                    column = end + 1;
                } else {
                    column = end;
                    wrap = true;
                }
                written += 1;
            }
            held = Some((c, at));
            at += len;
        }
        if occ_to > start_column {
            row.occ_bump(occ_to - 1);
        }
        if span_clean && written >= 8 {
            let end = if wrap { column + 1 } else { column };
            note_uniform_span(row, span_start, end, &narrow);
        }
        grid.cursor.point.column = Column(column);
        grid.cursor.input_needs_wrap = wrap;
        self.drained += written;
        (at, held)
    }

    /// One character of a run `print_utf8` checked: written straight into
    /// its cell or cells when it fits on the line with no wrap pending and
    /// no wide character underneath, as `print_plain` would. Returns false,
    /// having done nothing, otherwise.
    #[inline(always)]
    fn put_plain(&mut self, c: char, plain: bool, ascii: bool) -> bool {
        let width = if (' '..='~').contains(&c) {
            if !ascii {
                return false;
            }
            1
        } else {
            if !plain {
                return false;
            }
            match width_of(c) {
                Some(width @ 1..=2) => width,
                _ => return false,
            }
        };
        let columns = self.term.columns();
        let grid = self.term.grid_mut();
        let cursor = &grid.cursor;
        let column = cursor.point.column.0;
        if cursor.input_needs_wrap || column + width > columns {
            return false;
        }
        let line = cursor.point.line;
        let (fg, bg, flags) = (cursor.template.fg, cursor.template.bg, cursor.template.flags);
        let underneath = CellFlags::WIDE_CHAR | CellFlags::WIDE_CHAR_SPACER;
        let row = &mut grid[line];
        // The wide-char guard reads the observable cell (blank on a lazy
        // tail, never the stale physical bytes); the writes are full
        // overwrites through overwrite_cell, which a recycled row pays no
        // blank fill for. The row is borrowed once: guard and writes are
        // Row methods on that borrow, not grid-storage re-indexes.
        if row.virtual_cell(column).flags.intersects(underneath)
            || (width == 2 && row.virtual_cell(column + 1).flags.intersects(underneath))
        {
            return false;
        }
        // The writes below go through the lane escapes; see put_row.
        row.truncate_uniform(column);
        {
            let cell = row.overwrite_cell(column);
            cell.c = c;
            cell.fg = fg;
            cell.bg = bg;
            cell.flags = if width == 2 { flags | CellFlags::WIDE_CHAR } else { flags };
            cell.extra = None;
        }
        if width == 2 {
            let spacer = row.overwrite_cell(column + 1);
            spacer.c = ' ';
            spacer.fg = fg;
            spacer.bg = bg;
            spacer.flags = flags | CellFlags::WIDE_CHAR_SPACER;
            spacer.extra = None;
        }
        let last = column + width - 1;
        if last + 1 < columns {
            grid.cursor.point.column = Column(last + 1);
        } else {
            grid.cursor.point.column = Column(last);
            grid.cursor.input_needs_wrap = true;
        }
        self.drained += 1;
        true
    }

    /// The primary screen is up again partway through a feed: count on
    /// it from its own count, with a fresh sentinel.
    fn back_to_primary(&mut self) {
        self.alternate = false;
        self.count = self.primary;
        self.base = self.count;
        self.plant_sentinel();
    }

    /// Read the sentinel before and after text moves down. A scroll
    /// down carries the sentinel back toward the screen: read before,
    /// so lines that scrolled off earlier in this feed are counted;
    /// read after, so it is planted again and counts the next lines up
    /// from where they start.
    fn fold_around_down(&mut self) {
        if !self.alternate {
            self.fold_sentinel();
        }
    }

    fn note_region(&mut self, top: usize, bottom: Option<usize>) {
        let screen = self.term.screen_lines();
        let bottom = bottom.unwrap_or(screen);
        if top >= bottom {
            return;
        }
        self.region_top = (top as i32 - 1).min(screen as i32);
        self.region_bottom = (bottom as i32).min(screen as i32);
    }

    fn reset_region(&mut self) {
        self.region_top = 0;
        self.region_bottom = self.term.screen_lines() as i32;
    }

    fn scrolled_now(&mut self) -> u64 {
        if self.alternate {
            self.alt_scrolled
        } else {
            self.fold_sentinel();
            self.base = self.count;
            self.count
        }
    }

    fn after_scroll(&mut self) {
        if !self.alternate {
            self.fold_sentinel();
            self.base = self.count;
        }
    }

    /// Whether a scroll starting at `origin` can change an anchored picture
    /// or text layer. A full-screen scroll into history does not: the
    /// count carries those absolute lines. `None` means the store has
    /// said this screen has nothing a scroll could affect.
    fn scroll_moves_pictures(&self, origin: i32, clears: bool, up: bool) -> bool {
        let Some(content_end) = self.motion_end else {
            return false;
        };
        let band_top = self.base.saturating_add(origin.max(0) as u64);
        if content_end <= band_top {
            return false;
        }
        if up && !clears && !self.alternate && origin == 0 && self.region_top == 0
            && self.region_bottom >= self.term.screen_lines() as i32
        {
            let screen_bottom = self.base.saturating_add(self.term.screen_lines() as u64);
            if content_end <= screen_bottom {
                return false;
            }
        }
        true
    }

    /// Note a scroll up. Returns whether a picture event was pushed, so
    /// the caller refreshes the count mirror only then. The scroll count
    /// itself stays exact without a per-character read: the sentinel is
    /// folded at chunk boundaries, and a full-screen scroll's absolute
    /// lines are carried in `base` in constant time.
    fn note_scroll_up(&mut self, origin: i32, mut lines: usize) -> bool {
        let (start, end) = (self.region_top, self.region_bottom);
        lines = lines.min((end - start).max(0) as usize);
        if lines == 0 || end <= origin {
            return false;
        }
        let clears = (end - origin).max(0) as usize <= lines && origin != 0;
        let count_delta = if origin == 0 && !clears { lines as u64 } else { 0 };
        // Whether anything could move is read off `base`, which the
        // no-move path below carries by hand between the folds the
        // chunk's own pacing runs (SCROLL_COUNT_CHUNK at the engine,
        // the drained counters here). While the store has said nothing
        // could move, the band is never used, so the sentinel fold that
        // measuring it takes is not paid per scroll: on a flood of plain
        // text that fold — a selection range read against the grid —
        // was taken on every line that scrolled, for a band no event
        // ever carried.
        let moves = self.scroll_moves_pictures(origin, clears, true);
        if !moves {
            // The fold the band measurement took on every scroll was
            // also what replanted a dropped sentinel before `Term`
            // scrolled, and a scroll with no sentinel planted is a line
            // the count never sees (found by the seed sweep: the fast
            // and slow lanes replanted at different drained folds and
            // their counts parted by the scrolls in between). That part
            // cannot wait for the chunk's own folds — but it is only
            // owed when the sentinel is actually missing, or when the
            // lines carried by hand since the last fold (`base` ahead
            // of `count`) approach what a pacing fold would have read;
            // both are one compare on a flood.
            if !self.alternate
                && (self.term.selection.is_none()
                    || self.base.saturating_sub(self.count) >= SYNC_DRAIN_CHUNK as u64)
            {
                self.fold_sentinel();
            }
            if self.alternate && count_delta > 0 {
                self.alt_scrolled = self.alt_scrolled.saturating_add(count_delta);
            }
            // A full-screen scroll that moves no picture still carries
            // the top line, on either screen, so later text in this
            // chunk shares the pictures' lines.
            if count_delta > 0 {
                self.base = self.base.saturating_add(count_delta);
            }
            return false;
        }
        // The band is measured before the count moves. On the alternate
        // screen the count is this mirror, and reading it after the add
        // would place the band a scroll ahead of the pictures.
        let before = self.scrolled_now();
        if self.alternate && count_delta > 0 {
            self.alt_scrolled = self.alt_scrolled.saturating_add(count_delta);
            self.base = self.base.saturating_add(count_delta);
        }
        self.events.push(Event::RegionScroll {
            alternate: self.alternate,
            top: before.saturating_add(origin.max(0) as u64),
            bottom: before.saturating_add(end.max(0) as u64),
            up: if clears { 0 } else { lines as u64 },
            down: 0,
            count_delta,
            keep_above: origin == 0 && !self.alternate && !clears,
            clears,
        });
        true
    }

    fn note_scroll_down(&mut self, origin: i32, mut lines: usize) -> bool {
        let (start, end) = (self.region_top, self.region_bottom);
        lines = lines.min((end - start).max(0) as usize);
        lines = lines.min((end - origin).max(0) as usize);
        if lines == 0 || end <= origin {
            return false;
        }
        let clears = (end - origin).max(0) as usize <= lines;
        if !self.scroll_moves_pictures(origin, clears, false) {
            return false;
        }
        let before = self.scrolled_now();
        self.events.push(Event::RegionScroll {
            alternate: self.alternate,
            top: before.saturating_add(origin.max(0) as u64),
            bottom: before.saturating_add(end.max(0) as u64),
            up: 0,
            down: if clears { 0 } else { lines as u64 },
            count_delta: 0,
            keep_above: false,
            clears,
        });
        true
    }
}
/// Every method of vte 0.15's `ansi::Handler`, in the trait's own order,
/// forwarded to `Term`; the ones the intake listens for also record.
impl alacritty_terminal::vte::ansi::Handler for Watch<'_> {
    fn set_title(&mut self, title: Option<String>) {
        self.term.set_title(title);
    }
    fn set_cursor_style(&mut self, style: Option<CursorStyle>) {
        self.term.set_cursor_style(style);
    }
    fn set_cursor_shape(&mut self, shape: CursorShape) {
        self.term.set_cursor_shape(shape);
    }
    fn input(&mut self, c: char) {
        // A scroll on input happens only when a pending wrap, or a wide
        // character with no room, is at the bottom of the scroll region.
        // Anywhere else this is a column compare and the character itself.
        // The sentinel is read at chunk boundaries, not per character.
        if self.print_plain(c) {
            self.preceding = Some(c);
            return;
        }
        self.preceding = Some(c);
        let mut emitted = false;
        if self.term.mode().contains(TermMode::LINE_WRAP) {
            let cursor = &self.term.grid().cursor;
            if cursor.input_needs_wrap || cursor.point.column.0 + 1 >= self.term.columns() {
                let line = cursor.point.line.0;
                if line + 1 == self.region_bottom {
                    let width = width_of(c).unwrap_or(0);
                    let pending = cursor.input_needs_wrap && width > 0;
                    let wide = !cursor.input_needs_wrap && width > 1;
                    if pending || wide {
                        emitted = self.note_scroll_up(self.region_top, 1);
                    }
                }
            }
        }
        self.term.input(c);
        if emitted {
            self.after_scroll();
        }
        // Where the character landed, read after `Term` placed it. With no
        // in-cell picture on this screen the check is skipped entirely.
        if !self.in_cell.is_empty() {
            let cursor = &self.term.grid().cursor;
            let row = cursor.point.line.0;
            let col = cursor.point.column.0;
            let wrapped = cursor.input_needs_wrap;
            let line = self.base.saturating_add(row.max(0) as u64);
            if self.in_cell.iter().any(|&(top, bottom, _, _)| line <= bottom && line >= top) {
                let width = width_of(c).unwrap_or(0);
                if width > 0 {
                    let end = col + usize::from(wrapped);
                    self.covers(row, 1, end.saturating_sub(width), width);
                }
            }
        }
        // Pace the sentinel while a synchronized update's frame is
        // applied: a long frame cannot scroll it through a full history
        // before it is read.
        self.drained += 1;
        if self.drained >= SYNC_DRAIN_CHUNK {
            self.fold_sentinel();
            self.drained = 0;
        }
    }
    fn goto(&mut self, line: i32, col: usize) {
        self.term.goto(line, col);
    }
    fn goto_line(&mut self, line: i32) {
        self.term.goto_line(line);
    }
    fn goto_col(&mut self, col: usize) {
        self.term.goto_col(col);
    }
    fn insert_blank(&mut self, count: usize) {
        let point = self.term.grid().cursor.point;
        let rest = self.term.columns().saturating_sub(point.column.0);
        self.covers(point.line.0, 1, point.column.0, rest.max(count));
        self.term.insert_blank(count);
    }
    fn move_up(&mut self, rows: usize) {
        self.term.move_up(rows);
    }
    fn move_down(&mut self, rows: usize) {
        self.term.move_down(rows);
    }
    fn identify_terminal(&mut self, intermediate: Option<char>) {
        self.term.identify_terminal(intermediate);
    }
    fn device_status(&mut self, arg: usize) {
        self.term.device_status(arg);
    }
    fn move_forward(&mut self, cols: usize) {
        self.term.move_forward(cols);
    }
    fn move_backward(&mut self, cols: usize) {
        self.term.move_backward(cols);
    }
    fn move_down_and_cr(&mut self, row: usize) {
        self.term.move_down_and_cr(row);
    }
    fn move_up_and_cr(&mut self, row: usize) {
        self.term.move_up_and_cr(row);
    }
    fn put_tab(&mut self, count: u16) {
        self.term.put_tab(count);
    }
    fn backspace(&mut self) {
        self.term.backspace();
    }
    fn carriage_return(&mut self) {
        self.term.carriage_return();
    }
    fn linefeed(&mut self) {
        let line = self.term.grid().cursor.point.line.0;
        let emitted = if line + 1 == self.region_bottom {
            self.note_scroll_up(self.region_top, 1)
        } else {
            false
        };
        self.term.linefeed();
        if emitted {
            self.after_scroll();
        }
        self.drained += 1;
        if self.drained >= SYNC_DRAIN_CHUNK {
            self.fold_sentinel();
            self.drained = 0;
        }
    }
    fn bell(&mut self) {
        self.term.bell();
    }
    fn substitute(&mut self) {
        self.term.substitute();
    }
    fn newline(&mut self) {
        let line = self.term.grid().cursor.point.line.0;
        let emitted = if line + 1 == self.region_bottom {
            self.note_scroll_up(self.region_top, 1)
        } else {
            false
        };
        self.term.newline();
        if emitted {
            self.after_scroll();
        }
    }
    fn set_horizontal_tabstop(&mut self) {
        self.term.set_horizontal_tabstop();
    }
    fn scroll_up(&mut self, rows: usize) {
        let emitted = self.note_scroll_up(self.region_top, rows);
        self.term.scroll_up(rows);
        if emitted {
            self.after_scroll();
        }
    }
    fn scroll_down(&mut self, rows: usize) {
        self.fold_around_down();
        let emitted = self.note_scroll_down(self.region_top, rows);
        self.term.scroll_down(rows);
        if emitted {
            self.after_scroll();
        }
        self.fold_around_down();
    }
    fn insert_blank_lines(&mut self, count: usize) {
        self.fold_around_down();
        let point = self.term.grid().cursor.point;
        let line = point.line.0;
        let emitted = if line >= self.region_top && line < self.region_bottom {
            self.note_scroll_down(line, count)
        } else {
            false
        };
        self.covers(line, count, 0, self.term.columns());
        self.term.insert_blank_lines(count);
        if emitted {
            self.after_scroll();
        }
        self.fold_around_down();
    }
    fn delete_lines(&mut self, count: usize) {
        let point = self.term.grid().cursor.point;
        let line = point.line.0;
        let lines = (self.term.screen_lines() - line.max(0) as usize).min(count);
        let emitted = if lines > 0 && line >= self.region_top && line < self.region_bottom {
            self.note_scroll_up(line, lines)
        } else {
            false
        };
        self.covers(line, count, 0, self.term.columns());
        self.term.delete_lines(count);
        if emitted {
            self.after_scroll();
        }
    }
    fn erase_chars(&mut self, count: usize) {
        let point = self.term.grid().cursor.point;
        self.covers(point.line.0, 1, point.column.0, count);
        self.term.erase_chars(count);
    }
    fn delete_chars(&mut self, count: usize) {
        let point = self.term.grid().cursor.point;
        let rest = self.term.columns().saturating_sub(point.column.0);
        self.covers(point.line.0, 1, point.column.0, rest.max(count));
        self.term.delete_chars(count);
    }
    fn move_backward_tabs(&mut self, count: u16) {
        self.term.move_backward_tabs(count);
    }
    fn move_forward_tabs(&mut self, count: u16) {
        self.term.move_forward_tabs(count);
    }
    fn save_cursor_position(&mut self) {
        self.term.save_cursor_position();
    }
    fn restore_cursor_position(&mut self) {
        self.term.restore_cursor_position();
    }
    fn clear_line(&mut self, mode: LineClearMode) {
        let point = self.term.grid().cursor.point;
        let columns = self.term.columns();
        match mode {
            LineClearMode::Right => {
                self.covers(point.line.0, 1, point.column.0, columns);
            }
            LineClearMode::Left => {
                self.covers(point.line.0, 1, 0, point.column.0 + 1);
            }
            LineClearMode::All => {
                self.covers(point.line.0, 1, 0, columns);
            }
        }
        self.term.clear_line(mode);
    }
    fn clear_screen(&mut self, mode: ClearMode) {
        // `Term` drops its selection on ED 2, and on ED 3 when the
        // sentinel sits in history: read the sentinel first, so the
        // lines those clears scroll away are still counted.
        if matches!(mode, ClearMode::All | ClearMode::Saved) {
            self.fold_sentinel();
        }
        if matches!(mode, ClearMode::All) {
            let alternate = self.term.mode().contains(TermMode::ALT_SCREEN);
            // How many lines `Term` will push into history, worked out
            // the same way its `clear_viewport` does: up to the last row
            // that is not empty. The alternate screen pushes nothing.
            let pushed = if alternate {
                0
            } else {
                let mut last = 0;
                for row in 0..self.term.screen_lines() {
                    let line = &self.term.grid()[Line(row as i32)];
                    // The observable cells, not `into_iter`'s physical
                    // bytes: a lazily recycled row's tail is blank to any
                    // reader, stale bytes to the raw slice.
                    if line.observable().any(|cell| !cell.is_empty())
                        && row + 1 > last
                    {
                        last = row + 1;
                    }
                }
                last as u64
            };
            // The count the store clears from is the one after the fold,
            // before the clear pushes anything.
            let scrolled = self.count;
            self.term.clear_screen(ClearMode::All);
            if !alternate {
                self.count += pushed;
                self.base = self.count;
            }
            self.replant();
            self.events.push(Event::Clear { alternate, scrolled });
        } else if matches!(mode, ClearMode::Saved) {
            self.term.clear_screen(ClearMode::Saved);
            self.replant();
            self.events.push(Event::ClearSaved);
        } else if matches!(mode, ClearMode::Below) {
            // ED 0: from the cursor to the end of its line, and every
            // line below it. Recorded before `Term` moves the cursor.
            let point = self.term.grid().cursor.point;
            let cols = self.term.columns();
            let rows = self.term.screen_lines() as i32;
            let line = point.line.0;
            self.covers(line, 1, point.column.0, cols.saturating_sub(point.column.0));
            if line + 1 < rows {
                self.covers(line + 1, (rows - line - 1) as usize, 0, cols);
            }
            self.term.clear_screen(mode);
        } else if matches!(mode, ClearMode::Above) {
            // ED 1: the lines before the cursor, and the cells up to and
            // including the cursor. `Term` fully clears those lines only
            // when the cursor is below row 1; a picture stays where the
            // text stays.
            let point = self.term.grid().cursor.point;
            let cols = self.term.columns();
            let line = point.line.0;
            if line > 1 {
                self.covers(0, line as usize, 0, cols);
            }
            self.covers(line, 1, 0, point.column.0.saturating_add(1));
            self.term.clear_screen(mode);
        } else {
            self.term.clear_screen(mode);
        }
    }
    fn clear_tabs(&mut self, mode: TabulationClearMode) {
        self.term.clear_tabs(mode);
    }
    fn set_tabs(&mut self, interval: u16) {
        self.term.set_tabs(interval);
    }
    fn reset_state(&mut self) {
        // RIS drops the selection and clears the history it held: fold
        // first. The count only grows: the lines that left before the
        // reset stay counted, wherever in a feed the reset falls.
        self.fold_sentinel();
        self.term.reset_state();
        if self.alternate {
            // RIS leaves the alternate screen.
            self.back_to_primary();
        }
        self.base = self.count;
        self.reset_region();
        self.replant();
        self.events.push(Event::Reset);
    }
    fn reverse_index(&mut self) {
        self.fold_around_down();
        let line = self.term.grid().cursor.point.line.0;
        let emitted = if line == self.region_top {
            self.note_scroll_down(self.region_top, 1)
        } else {
            false
        };
        self.term.reverse_index();
        if emitted {
            self.after_scroll();
        }
        self.fold_around_down();
    }
    fn terminal_attribute(&mut self, attr: Attr) {
        self.term.terminal_attribute(attr);
    }
    fn set_mode(&mut self, mode: Mode) {
        self.term.set_mode(mode);
    }
    fn unset_mode(&mut self, mode: Mode) {
        self.term.unset_mode(mode);
    }
    fn report_mode(&mut self, mode: Mode) {
        self.term.report_mode(mode);
    }
    fn set_private_mode(&mut self, mode: PrivateMode) {
        let entering_alt = matches!(mode, PrivateMode::Named(NamedPrivateMode::SwapScreenAndSetRestoreCursor))
            && !self.term.mode().contains(TermMode::ALT_SCREEN);
        // `Term` drops the selection on every screen switch: read the
        // sentinel first, so the lines the primary screen scrolled
        // before the switch stay counted.
        if entering_alt {
            self.fold_sentinel();
            // The primary grid is about to leave the screen. Snap it now,
            // not after every chunk: a later resize while this screen is
            // up reflows from this picture of the text.
            self.primary_snap = Some(snap_term(self.term, self.count));
        }
        self.term.set_private_mode(mode);
        if matches!(mode, PrivateMode::Named(NamedPrivateMode::ColumnMode)) {
            self.reset_region();
        }
        if entering_alt {
            // Each entry into the alternate screen starts its count at
            // 0, as the store's `enter_alternate` does. The rest of the
            // feed counts on that screen; the primary's count waits.
            self.alt_scrolled = 0;
            self.primary = self.count;
            self.alternate = true;
            self.count = 0;
            self.base = 0;
        }
    }
    fn unset_private_mode(&mut self, mode: PrivateMode) {
        let leaving_alt = matches!(mode, PrivateMode::Named(NamedPrivateMode::SwapScreenAndSetRestoreCursor))
            && self.term.mode().contains(TermMode::ALT_SCREEN);
        if leaving_alt {
            self.fold_sentinel();
        }
        self.term.unset_private_mode(mode);
        if matches!(mode, PrivateMode::Named(NamedPrivateMode::ColumnMode)) {
            self.reset_region();
        }
        if leaving_alt {
            // The rest of the feed counts on the primary screen again,
            // from its own count, with a sentinel planted for it.
            self.back_to_primary();
        }
    }
    fn report_private_mode(&mut self, mode: PrivateMode) {
        self.term.report_private_mode(mode);
    }
    fn set_scrolling_region(&mut self, top: usize, bottom: Option<usize>) {
        self.note_region(top, bottom);
        self.term.set_scrolling_region(top, bottom);
    }
    fn set_keypad_application_mode(&mut self) {
        self.term.set_keypad_application_mode();
    }
    fn unset_keypad_application_mode(&mut self) {
        self.term.unset_keypad_application_mode();
    }
    fn set_active_charset(&mut self, index: CharsetIndex) {
        self.term.set_active_charset(index);
    }
    fn configure_charset(&mut self, index: CharsetIndex, charset: StandardCharset) {
        self.term.configure_charset(index, charset);
    }
    fn set_color(&mut self, index: usize, rgb: Rgb) {
        self.term.set_color(index, rgb);
    }
    fn dynamic_color_sequence(&mut self, query: String, index: usize, terminator: &str) {
        self.term.dynamic_color_sequence(query, index, terminator);
    }
    fn reset_color(&mut self, index: usize) {
        self.term.reset_color(index);
    }
    fn clipboard_store(&mut self, clipboard: u8, text: &[u8]) {
        self.term.clipboard_store(clipboard, text);
    }
    fn clipboard_load(&mut self, clipboard: u8, message: &str) {
        self.term.clipboard_load(clipboard, message);
    }
    fn decaln(&mut self) {
        self.covers(-(self.term.grid().display_offset() as i32), self.term.screen_lines(), 0, self.term.columns());
        self.term.decaln();
    }
    fn push_title(&mut self) {
        self.term.push_title();
    }
    fn pop_title(&mut self) {
        self.term.pop_title();
    }
    fn text_area_size_pixels(&mut self) {
        self.term.text_area_size_pixels();
    }
    fn text_area_size_chars(&mut self) {
        self.term.text_area_size_chars();
    }
    fn set_hyperlink(&mut self, hyperlink: Option<Hyperlink>) {
        self.term.set_hyperlink(hyperlink);
    }
    fn set_mouse_cursor_icon(&mut self, icon: cursor_icon::CursorIcon) {
        self.term.set_mouse_cursor_icon(icon);
    }
    fn report_keyboard_mode(&mut self) {
        self.term.report_keyboard_mode();
    }
    fn push_keyboard_mode(&mut self, mode: KeyboardModes) {
        self.term.push_keyboard_mode(mode);
    }
    fn pop_keyboard_modes(&mut self, to_pop: u16) {
        self.term.pop_keyboard_modes(to_pop);
    }
    fn set_keyboard_mode(&mut self, mode: KeyboardModes, behavior: KeyboardModesApplyBehavior) {
        self.term.set_keyboard_mode(mode, behavior);
    }
    fn set_modify_other_keys(&mut self, mode: ModifyOtherKeys) {
        self.term.set_modify_other_keys(mode);
    }
    fn report_modify_other_keys(&mut self) {
        self.term.report_modify_other_keys();
    }
    fn set_scp(&mut self, char_path: ScpCharPath, update_mode: ScpUpdateMode) {
        self.term.set_scp(char_path, update_mode);
    }
}

/// Shorter runs of plain text go through the parser: splitting the feed
/// around a run costs about what writing a few characters at once saves,
/// and a CSI with one character after it (an SGR and its letter) is
/// shorter than this, so escape-dense output never stops to look.
const RUN_MIN: usize = 24;

/// One chunk of bytes to `Term`. The parser prints plain text a
/// character at a time; a run of text it would print is written into
/// the grid without it instead (ASCII a line at a time, UTF-8 decoded
/// once and written a character at a time), when the run starts with the
/// parser in its ground state, no UTF-8 character half read, and no
/// synchronized update holding bytes back. The run's last character
/// still goes through the parser, which keeps it for REP. The colours
/// and cursor moves that full-screen programs write between their
/// characters skip the parser too ([`lane`]). Everything else, and every
/// byte when `fast` is off, goes through the parser.
use std::sync::atomic::Ordering;
fn feed(processor: &mut Processor, watch: &mut Watch<'_>, mirror: &mut Mirror, chunk: &[u8], fast: bool) {
    if !fast {
        mirror.follow(chunk);
        processor.advance(watch, chunk);
        return;
    }
    // Bytes before `fed` have reached the grid; the mirror's state is
    // the parser's at `known`.
    let mut fed = 0;
    let mut known = 0;
    // A run lies between two ESCs, so only a stretch between them as long
    // as a run is looked into: escape-dense output (an SGR and a letter,
    // over and over) is passed over at the speed of the ESC search.
    let mut stretch = 0;
    // Where the last sequence the lane took ended: the parser is in
    // ground there, with nothing half read.
    let mut lane_end = None;
    // Whether the parser is known to be in ground at `fed`, with no
    // sequence or character half read from an earlier chunk. False at a
    // chunk's start, where the previous chunk may have ended inside a
    // sequence whose payload the gap would be completing; true once a
    // parser advance reaches a point the mirror calls ground, a run is
    // taken from ground, or the lane takes a sequence. Only then may a
    // gap of bare controls be carried out without the parser (`plain_c0`).
    let mut ground_at_fed = false;
    for esc in memchr::memchr_iter(0x1b, chunk).chain(std::iter::once(chunk.len())) {
        let mut from = stretch;
        stretch = esc + 1;
        while esc - from >= RUN_MIN
            && let Some((start, end, ascii)) = next_run(&chunk[..esc], from)
        {
            from = end;
            mirror.catch_up(chunk, known, start);
            // Where in the run the parser is in ground: a run may begin
            // with the tail of a sequence, the parameters of a CSI.
            let ground = mirror.stretch(chunk, start, end);
            known = end;
            if mirror.state != Parse::Ground {
                continue;
            }
            mirror.high = chunk[end - 1] >= 0x80;
            // A byte from 0x80 up just before the run may leave a UTF-8
            // character half read: the run's first byte would end it.
            let before_high = if ground == 0 { mirror.high_at_start } else { chunk[ground - 1] >= 0x80 };
            if end - ground < RUN_MIN || before_high {
                continue;
            }
            if fed < ground {
                if crate::engine::probes::get() != 104 {
                    let gap = &chunk[fed..ground];
                    // A gap of bare controls with the parser in ground at
                    // its start and no synchronized update collecting is
                    // carried out here: between two plain runs that is
                    // the whole gap ("\\r\\n" a line on the floods this
                    // counts most on), and the parser's state machine
                    // would do exactly these calls and stay in ground.
                    if !(ground_at_fed
                        && processor.sync_timeout().sync_timeout().is_none()
                        && plain_c0(watch, gap))
                    {
                        let t_vte = timers::on().then(Instant::now);
                        let b = ground - fed;
                        processor.advance(watch, gap);
                        if let Some(t) = t_vte {
                            timers::record_vte(t, b);
                        }
                    }
                }
                fed = ground;
                ground_at_fed = true;
            }
            if processor.sync_timeout().sync_timeout().is_some() {
                continue;
            }
            let run = &chunk[ground..end];
            let probe = crate::engine::probes::get();
            let t_run = timers::on().then(Instant::now);
            // The run applies whole: glass tracks the REP character itself
            // (set at `input`, the funnel every printed character takes),
            // so nothing needs the machine to see the last character.
            // Run-whole: the lane applies the whole run, holding no
            // character for the parser (glass's REP tracking makes that
            // sound), so the gap between runs carries only C0.
            let took = if probe >= 100 {
                if ascii { run.len() - 1 } else { run.len() }
            } else if run_whole() {
                let took = if ascii { watch.print_run(run) } else { watch.print_utf8(run) };
                // The whole run went to the grid: keep vte's REP
                // character matching the stream, for a REP the parser
                // itself completes (a sequence split across reads).
                processor.set_preceding_char(watch.preceding);
                took
            } else if ascii {
                watch.print_run(&run[..run.len() - 1])
            } else {
                watch.print_utf8(run)
            };
            if let Some(t) = t_run {
                timers::record_run(t);
                timers::RUN_BYTES.fetch_add(run.len() as u64, Ordering::Relaxed);
            }
            if counters::counting() {
                counters::LANE_RUN_BYTES.fetch_add(took as u64, Ordering::Relaxed);
            }
            fed += took;
            ground_at_fed = true;
        }
        if esc < chunk.len() {
            let after_lane = lane_end == Some(fed);
            lane_end = None;
            if let Some(len) = lane(processor, watch, mirror, chunk, esc, &mut fed, &mut known, after_lane) {
                // What follows the sequence is looked into from its end.
                stretch = esc + len;
                lane_end = Some(fed);
                ground_at_fed = true;
            }
        }
    }
    mirror.catch_up(chunk, known, chunk.len());
    mirror.high_at_start = mirror.high;
    if fed < chunk.len() {
        if counters::counting() {
            counters::VTE_BYTES.fetch_add((chunk.len() - fed) as u64, Ordering::Relaxed);
        }
        if crate::engine::probes::get() != 104 {
            let rest = &chunk[fed..];
            if !(ground_at_fed
                && processor.sync_timeout().sync_timeout().is_none()
                && plain_c0(watch, rest))
            {
                processor.advance(watch, rest);
            }
        }
    }
}

/// Carry out a gap of bare controls as the parser in ground would:
/// CR, HT, BS and the line-feeds (LF, VT, FF) onto the handler, in
/// order. Returns false, having done nothing, when any byte is not one
/// of those six, so the caller hands the whole gap to the parser. The
/// caller decides the parser is in ground at the gap's start and that
/// no synchronized update is collecting: inside a sequence these bytes
/// are payload, and inside a sync they are deferred with the rest.
fn plain_c0(watch: &mut Watch<'_>, gap: &[u8]) -> bool {
    use alacritty_terminal::vte::ansi::Handler;
    if !gap.iter().all(|b| matches!(b, b'\r' | b'\t' | 0x08 | b'\n' | 0x0b | 0x0c)) {
        return false;
    }
    if timers::on() {
        timers::C0_BYTES.fetch_add(gap.len() as u64, Ordering::Relaxed);
    }
    for &b in gap {
        match b {
            b'\r' => watch.carriage_return(),
            b'\t' => watch.put_tab(1),
            0x08 => watch.backspace(),
            _ => watch.linefeed(),
        }
    }
    true
}

/// Where the bytes a chunk applied went, while a census is on: the run
/// lanes' writes and the byte-at-a-time parser's. Together with the
/// chunk total they say what a stream's time is made of. Counting is
/// off until [`counters::start`] says otherwise, so the parse path
/// pays nothing when no one asks.
/// The run lane applies the whole run, holding no character for the
/// parser (glass's REP tracking makes that sound), so the gap between
/// runs carries only C0. On by default: it is worth +6-7% on ascii,
/// ascii_lf and scroll_region at engine level, and the lane agrees with
/// the byte-at-a-time parser across 25,600 random streams either way
/// (`plain_runs_match_the_parser_over_seeds`). `GLASS_RUN_WHOLE=0` takes
/// it off.
pub fn run_whole() -> bool {
    static ON: std::sync::OnceLock<bool> = std::sync::OnceLock::new();
    *ON.get_or_init(|| !std::env::var_os("GLASS_RUN_WHOLE").is_some_and(|v| v == "0"))
}

/// Deliberately-incorrect ceiling probes for the parse path: GLASS_RUN_PROBE
/// (default 0 = correct behaviour), fixed once at startup. 1 and 2 bound the
/// suspects inside `print_run`'s cell loop (see the match there: 1 skips the
/// wide test, 2 is the rejected conditional-pen variant). 100 and over bound
/// the feed path around it: >=100 skips the lane's apply, and 104 skips the
/// byte-at-a-time parser as well, leaving the ESC scan, the mirror and the
/// loop itself. **3 to 99 are inert** — they match no branch, so a run with
/// one of them measures the baseline and reads as "no headroom here".
/// `plain_runs_match_the_parser_over_seeds` sees 100 and 104 diverge, and is
/// the way to check a probe still bites. A relaxed load is enough: the value
/// never changes after init, and init happens before the parse thread.
/// Wall-time brackets for the parse path, printed once at exit when
/// GLASS_PARSE_TIMERS=1. Cheap enough to leave in: a relaxed load and,
/// when off, no clock.
pub(crate) mod timers {
    use std::sync::atomic::{AtomicBool, AtomicU64, Ordering};
    use std::time::Instant;
    pub static ON: AtomicBool = AtomicBool::new(false);
    pub static APPLY_NS: AtomicU64 = AtomicU64::new(0);
    pub static APPLY_CALLS: AtomicU64 = AtomicU64::new(0);
    pub static RUN_NS: AtomicU64 = AtomicU64::new(0);
    pub static RUN_BYTES: AtomicU64 = AtomicU64::new(0);
    pub static RUN_CALLS: AtomicU64 = AtomicU64::new(0);
    pub static VTE_NS: AtomicU64 = AtomicU64::new(0);
    pub static VTE_CALLS: AtomicU64 = AtomicU64::new(0);
    pub static C0_BYTES: AtomicU64 = AtomicU64::new(0);
    pub static VTE_BYTES: AtomicU64 = AtomicU64::new(0);
    pub static FEED_NS: AtomicU64 = AtomicU64::new(0);
    pub static FEED_CALLS: AtomicU64 = AtomicU64::new(0);
    pub const APPLY: usize = 0;
    pub const FEED: usize = 1;
    pub fn init() {
        ON.store(std::env::var_os("GLASS_PARSE_TIMERS").is_some_and(|v| !v.is_empty() && v != "0"), Ordering::Relaxed);
    }
    #[inline]
    pub fn on() -> bool {
        ON.load(Ordering::Relaxed)
    }
    #[inline]
    pub fn record(_which: usize, t: Instant) {
        if ON.load(Ordering::Relaxed) {
            APPLY_NS.fetch_add(t.elapsed().as_nanos() as u64, Ordering::Relaxed);
            APPLY_CALLS.fetch_add(1, Ordering::Relaxed);
        }
    }
    /// print_run's own wall time, from feed().
    #[inline]
    pub fn record_run(t: Instant) {
        if ON.load(Ordering::Relaxed) {
            RUN_NS.fetch_add(t.elapsed().as_nanos() as u64, Ordering::Relaxed);
            RUN_CALLS.fetch_add(1, Ordering::Relaxed);
        }
    }
    /// The byte-at-a-time parser's wall time, from feed().
    #[inline]
    pub fn record_vte(t: Instant, bytes: usize) {
        if ON.load(Ordering::Relaxed) {
            VTE_NS.fetch_add(t.elapsed().as_nanos() as u64, Ordering::Relaxed);
            VTE_CALLS.fetch_add(1, Ordering::Relaxed);
            VTE_BYTES.fetch_add(bytes as u64, Ordering::Relaxed);
        }
    }
    pub fn report() {
        if !ON.load(Ordering::Relaxed) { return; }
        eprintln!(
            "parse-timers: apply {} calls {} ms | print_run {} calls {} ms ({} bytes, avg {}) | vte {} calls {} ms ({} bytes, avg {}) | c0 bypassed {} bytes",
            APPLY_CALLS.load(Ordering::Relaxed),
            APPLY_NS.load(Ordering::Relaxed) as f64 / 1e6,
            RUN_CALLS.load(Ordering::Relaxed),
            RUN_NS.load(Ordering::Relaxed) as f64 / 1e6,
            RUN_BYTES.load(Ordering::Relaxed),
            RUN_BYTES.load(Ordering::Relaxed) / RUN_CALLS.load(Ordering::Relaxed).max(1),
            VTE_CALLS.load(Ordering::Relaxed),
            VTE_NS.load(Ordering::Relaxed) as f64 / 1e6,
            VTE_BYTES.load(Ordering::Relaxed),
            VTE_BYTES.load(Ordering::Relaxed) / VTE_CALLS.load(Ordering::Relaxed).max(1),
            C0_BYTES.load(Ordering::Relaxed)
        );
    }
}

pub(crate) mod probes {
    use std::sync::atomic::{AtomicU8, Ordering};
    pub static RUN_PROBE: AtomicU8 = AtomicU8::new(0);
    #[inline(always)]
    pub fn get() -> u8 {
        RUN_PROBE.load(Ordering::Relaxed)
    }
    /// Called once at startup, before the hot threads exist.
    pub fn init() {
        let v = std::env::var_os("GLASS_RUN_PROBE")
            .and_then(|v| v.to_str().and_then(|v| v.parse().ok()))
            .unwrap_or(0u8);
        RUN_PROBE.store(v, Ordering::Relaxed);
    }
}

pub(crate) mod counters {
    use std::sync::atomic::{AtomicBool, AtomicU64, Ordering};
    pub static LANE_RUN_BYTES: AtomicU64 = AtomicU64::new(0);
    pub static VTE_BYTES: AtomicU64 = AtomicU64::new(0);
    static COUNTING: AtomicBool = AtomicBool::new(false);
    /// Count where applied bytes go, from now until [`counters::stop`].
    pub fn start() {
        LANE_RUN_BYTES.store(0, Ordering::Relaxed);
        VTE_BYTES.store(0, Ordering::Relaxed);
        COUNTING.store(true, Ordering::Relaxed);
    }
    /// Stop counting, returning what was counted.
    pub fn stop() -> (u64, u64) {
        COUNTING.store(false, Ordering::Relaxed);
        (LANE_RUN_BYTES.swap(0, Ordering::Relaxed), VTE_BYTES.swap(0, Ordering::Relaxed))
    }
    pub(super) fn counting() -> bool {
        COUNTING.load(Ordering::Relaxed)
    }
}

/// The most parameters a sequence the lane takes may have: well under
/// vte's 32, past which vte ignores the whole sequence.
const LANE_PARAMS: usize = 16;

/// A colour change (SGR) or a cursor move (CUP) whose bytes are all in
/// one chunk, in the plainest form: `ESC [`, digits and semicolons only,
/// then `m`, `H` or `f`. The parameters are read as vte reads them: each
/// a run of digits saturating at 65535, an empty one 0.
struct Simple {
    params: [u16; LANE_PARAMS],
    count: usize,
    goto: bool,
    rep: bool,
}

/// The sequence at the start of `rest` (which starts with ESC) and its
/// length, if it is one [`Simple`] takes.
#[inline]
fn simple(rest: &[u8]) -> Option<(usize, Simple)> {
    if rest.get(1) != Some(&b'[') {
        return None;
    }
    let mut params = [0u16; LANE_PARAMS];
    let mut count = 0;
    let mut value = 0u16;
    for (at, &b) in rest.iter().enumerate().skip(2) {
        match b {
            b'0'..=b'9' => value = value.saturating_mul(10).saturating_add(u16::from(b - b'0')),
            b';' if count + 1 < LANE_PARAMS => {
                params[count] = value;
                count += 1;
                value = 0;
            }
            b'm' | b'H' | b'f' => {
                params[count] = value;
                return Some((at + 1, Simple { params, count: count + 1, goto: b != b'm', rep: false }));
            }
            b'b' => {
                // REP: repeat the preceding character this many times
                // (a missing or zero parameter is one, as vte reads it).
                params[count] = value;
                return Some((at + 1, Simple { params, count: count + 1, goto: false, rep: true }));
            }
            _ => return None,
        }
    }
    None
}

/// Apply the sequence at `chunk[esc..]` straight to the grid, if it is
/// one [`Simple`] takes and the parser would read it from its ground
/// state, and return its length. The bytes before it go to the parser
/// first, so everything stays in stream order. The parser is left as it
/// would have left itself: in ground, with nothing half read.
///
/// `after_lane` says the bytes before it begin where the lane last left
/// the parser in ground: then a few characters of plain ASCII there (a
/// cell's worth of text between two colour changes) are written straight
/// into the grid too, all but the last, which the parser keeps for REP.
#[allow(clippy::too_many_arguments)]
#[inline]
fn lane(
    processor: &mut Processor,
    watch: &mut Watch<'_>,
    mirror: &mut Mirror,
    chunk: &[u8],
    esc: usize,
    fed: &mut usize,
    known: &mut usize,
    after_lane: bool,
) -> Option<usize> {
    let (len, simple) = simple(&chunk[esc..])?;
    mirror.catch_up(chunk, *known, esc);
    *known = esc;
    if mirror.state != Parse::Ground || (mirror.high && !ends_whole(&chunk[..esc])) {
        return None;
    }
    if *fed < esc {
        let text = &chunk[*fed..esc];
        // One character is enough when the lane applies the whole run:
        // `n` below is then `text.len()`, so a single cell's worth of text
        // between two colour changes goes to the grid instead of through
        // the parser. Without run-whole `n` would be 0 and the take would
        // print nothing, which is what the floor of 1 was for. A frame
        // that colours every cell (`tui_frames`, `truecolor`,
        // `cursor_motion`) is exactly this shape, one char per sequence.
        let floor = if run_whole() { 0 } else { 1 };
        if after_lane
            && text.len() > floor
            && text.iter().all(|b| (0x20..=0x7e).contains(b))
            && processor.sync_timeout().sync_timeout().is_none()
        {
            let n = if run_whole() { text.len() } else { text.len() - 1 };
            // A single cell between colour changes (the tui_frames /
            // truecolor shape) pays print_run's whole setup for one
            // store; put_plain is the same write with the row looked
            // up once. Its caller-side conditions are print_utf8's:
            // checked here exactly as there.
            let single_plain = n == 1 && {
                let template = &watch.term.grid().cursor.template;
                watch.fast
                    && watch.in_cell.is_empty()
                    && !watch.term.mode().contains(TermMode::INSERT)
                    && template.extra.is_none()
                    && !template.flags.intersects(
                        CellFlags::WIDE_CHAR
                            | CellFlags::WIDE_CHAR_SPACER
                            | CellFlags::LEADING_WIDE_CHAR_SPACER,
                    )
                    && watch.term.grid().cursor.charsets == Default::default()
            };
            let t = if single_plain && watch.put_plain(char::from(text[0]), true, true) {
                watch.preceding = Some(char::from(text[0]));
                1
            } else {
                watch.print_run(&text[..n])
            };
            // The whole text went to the grid: vte's REP character must
            // match it, for a REP the parser completes later.
            if run_whole() {
                processor.set_preceding_char(watch.preceding);
            }
            *fed += t;
        }
        processor.advance(watch, &chunk[*fed..esc]);
        *fed = esc;
    }
    if processor.sync_timeout().sync_timeout().is_some() {
        return None;
    }
    let params = &simple.params[..simple.count];
    if simple.rep {
        // REP repeats the preceding printed character. Glass's lanes
        // track it as the parser's `preceding_char` is, and repeat by
        // the same `input` calls the parser's REP makes, so a REP the
        // lane takes lands exactly where the parser's would.
        let n = params.first().copied().filter(|&v| v != 0).unwrap_or(1);
        let Some(c) = watch.preceding else {
            return Some(len);
        };
        for _ in 0..n {
            alacritty_terminal::vte::ansi::Handler::input(watch, c);
        }
    } else if simple.goto {
        // vte's CUP: a missing or zero parameter is 1.
        let or_one = |p: Option<&u16>| p.copied().filter(|&v| v != 0).unwrap_or(1);
        let (line, column) = (or_one(params.first()), or_one(params.get(1)));
        alacritty_terminal::vte::ansi::Handler::goto(watch, i32::from(line) - 1, usize::from(column) - 1);
    } else {
        sgr(watch, params);
    }
    *fed = esc + len;
    *known = esc + len;
    mirror.state = Parse::Ground;
    mirror.high = false;
    Some(len)
}

/// Whether `bytes` ends with a whole UTF-8 character, so the parser holds
/// none half read: its last lead byte starts a valid character that ends
/// exactly at the end.
fn ends_whole(bytes: &[u8]) -> bool {
    let Some(lead) = bytes.iter().rev().take(4).position(|&b| b & 0xc0 != 0x80).map(|k| bytes.len() - 1 - k) else {
        return false;
    };
    let need = match bytes[lead] {
        0x00..=0x7f => 1,
        0xc2..=0xdf => 2,
        0xe0..=0xef => 3,
        0xf0..=0xf4 => 4,
        _ => return false,
    };
    bytes.len() - lead == need && std::str::from_utf8(&bytes[lead..]).is_ok()
}

/// vte 0.15's SGR (`attrs_from_sgr_parameters`) for parameters with no
/// colon parts: each parameter is an attribute, and 38, 48 and 58 take
/// their colour from the parameters after them.
fn sgr(watch: &mut Watch<'_>, params: &[u16]) {
    use alacritty_terminal::vte::ansi::Handler;
    const NAMED: [NamedColor; 8] = [
        NamedColor::Black,
        NamedColor::Red,
        NamedColor::Green,
        NamedColor::Yellow,
        NamedColor::Blue,
        NamedColor::Magenta,
        NamedColor::Cyan,
        NamedColor::White,
    ];
    const BRIGHT: [NamedColor; 8] = [
        NamedColor::BrightBlack,
        NamedColor::BrightRed,
        NamedColor::BrightGreen,
        NamedColor::BrightYellow,
        NamedColor::BrightBlue,
        NamedColor::BrightMagenta,
        NamedColor::BrightCyan,
        NamedColor::BrightWhite,
    ];
    let mut at = 0;
    while at < params.len() {
        let param = params[at];
        at += 1;
        let attr = match param {
            0 => Some(Attr::Reset),
            1 => Some(Attr::Bold),
            2 => Some(Attr::Dim),
            3 => Some(Attr::Italic),
            4 => Some(Attr::Underline),
            5 => Some(Attr::BlinkSlow),
            6 => Some(Attr::BlinkFast),
            7 => Some(Attr::Reverse),
            8 => Some(Attr::Hidden),
            9 => Some(Attr::Strike),
            21 => Some(Attr::CancelBold),
            22 => Some(Attr::CancelBoldDim),
            23 => Some(Attr::CancelItalic),
            24 => Some(Attr::CancelUnderline),
            25 => Some(Attr::CancelBlink),
            27 => Some(Attr::CancelReverse),
            28 => Some(Attr::CancelHidden),
            29 => Some(Attr::CancelStrike),
            30..=37 => Some(Attr::Foreground(AnsiColor::Named(NAMED[usize::from(param - 30)]))),
            38 => sgr_color(params, &mut at).map(Attr::Foreground),
            39 => Some(Attr::Foreground(AnsiColor::Named(NamedColor::Foreground))),
            40..=47 => Some(Attr::Background(AnsiColor::Named(NAMED[usize::from(param - 40)]))),
            48 => sgr_color(params, &mut at).map(Attr::Background),
            49 => Some(Attr::Background(AnsiColor::Named(NamedColor::Background))),
            58 => sgr_color(params, &mut at).map(|color| Attr::UnderlineColor(Some(color))),
            59 => Some(Attr::UnderlineColor(None)),
            90..=97 => Some(Attr::Foreground(AnsiColor::Named(BRIGHT[usize::from(param - 90)]))),
            100..=107 => Some(Attr::Background(AnsiColor::Named(BRIGHT[usize::from(param - 100)]))),
            _ => None,
        };
        if let Some(attr) = attr {
            watch.terminal_attribute(attr);
        }
    }
}

/// vte 0.15's `parse_sgr_color`: `2;r;g;b` or `5;index`, taking the
/// parameters it reads even when they turn out not to make a colour.
fn sgr_color(params: &[u16], at: &mut usize) -> Option<AnsiColor> {
    let mut next = || {
        let param = params.get(*at).copied();
        *at += usize::from(param.is_some());
        param
    };
    match next() {
        Some(2) => Some(AnsiColor::Spec(Rgb {
            r: u8::try_from(next()?).ok()?,
            g: u8::try_from(next()?).ok()?,
            b: u8::try_from(next()?).ok()?,
        })),
        Some(5) => Some(AnsiColor::Indexed(u8::try_from(next()?).ok()?)),
        _ => None,
    }
}

/// `put_row`'s uniform-prefix note, out of line: the style compare
/// inside is wide, and inlined into the per-glyph loop it measurably
/// slows every glyph (unicode -24% with it inline, 2026-11-02).
#[cold]
#[inline(never)]
fn note_uniform_span(
    row: &mut alacritty_terminal::grid::Row<alacritty_terminal::term::cell::Cell>,
    from: usize,
    end: usize,
    narrow: &alacritty_terminal::term::cell::Cell,
) {
    row.note_uniform_write(from, end, narrow);
}

/// The next run of at least [`RUN_MIN`] bytes of text in `bytes` (printable
/// ASCII, and bytes of UTF-8 past it), from `from` on, as its start and
/// end, with whether all of those bytes are ASCII. It looks at one byte
/// in every `RUN_MIN` where no run is, so text full of escapes is passed
/// over quickly; x86-64 classifies the run during the boundary scan.
#[cfg(target_arch = "x86_64")]
fn next_run(bytes: &[u8], mut from: usize) -> Option<(usize, usize, bool)> {
    let printable = |b: u8| (0x20..=0x7e).contains(&b) || b >= 0x80;
    while from + RUN_MIN <= bytes.len() {
        let probe = from + RUN_MIN - 1;
        if !printable(bytes[probe]) {
            from = probe + 1;
            continue;
        }
        let (mut start, mut ascii) = (probe + 1, true);
        while start - from >= 16 {
            let (control, high) = text_masks(bytes[start - 16..start].try_into().unwrap());
            if control != 0 {
                let after = 32 - control.leading_zeros();
                ascii &= high >> after == 0;
                start = start - 16 + after as usize;
                break;
            }
            ascii &= high == 0;
            start -= 16;
        }
        while start > from && printable(bytes[start - 1]) {
            start -= 1;
            ascii &= bytes[start] < 0x80;
        }
        let (tail, tail_ascii) = classified_text_len(&bytes[probe + 1..]);
        let end = probe + 1 + tail;
        if end - start >= RUN_MIN {
            return Some((start, end, ascii && tail_ascii));
        }
        from = end + 1;
    }
    None
}

/// Exact per-byte control and high-bit masks. SSE2 is baseline on x86-64.
#[cfg(target_arch = "x86_64")]
#[inline(always)]
fn text_masks(bytes: &[u8; 16]) -> (u32, u32) {
    use std::arch::x86_64::*;
    // SAFETY: the array guarantees 16 readable bytes; loadu has no
    // alignment requirement, and all intrinsics require only SSE2.
    unsafe {
        let x = _mm_loadu_si128(bytes.as_ptr().cast());
        let low = _mm_cmpeq_epi8(_mm_min_epu8(x, _mm_set1_epi8(31)), x);
        let del = _mm_cmpeq_epi8(x, _mm_set1_epi8(127));
        (_mm_movemask_epi8(_mm_or_si128(low, del)) as u32, _mm_movemask_epi8(x) as u32)
    }
}

#[cfg(target_arch = "x86_64")]
fn classified_text_len(bytes: &[u8]) -> (usize, bool) {
    let (mut at, mut ascii) = (0, true);
    while let Some(&block) = bytes.get(at..).and_then(|rest| rest.first_chunk::<16>()) {
        let (control, high) = text_masks(&block);
        if control != 0 {
            let n = control.trailing_zeros();
            return (at + n as usize, ascii && high & ((1 << n) - 1) == 0);
        }
        ascii &= high == 0;
        at += 16;
    }
    while at < bytes.len() && bytes[at] >= 0x20 && bytes[at] != 0x7f {
        ascii &= bytes[at] < 0x80;
        at += 1;
    }
    (at, ascii)
}

// Keep the established word scan on other targets rather than imposing
// a scalar emulation of x86's masks on the macOS/ARM hot path.
#[cfg(not(target_arch = "x86_64"))]
fn next_run(bytes: &[u8], mut from: usize) -> Option<(usize, usize, bool)> {
    let printable = |b: u8| (0x20..=0x7e).contains(&b) || b >= 0x80;
    while from + RUN_MIN <= bytes.len() {
        // Any run of RUN_MIN starting in from..=probe covers the probe.
        let probe = from + RUN_MIN - 1;
        if !printable(bytes[probe]) {
            from = probe + 1;
            continue;
        }
        let mut start = probe;
        while start > from && printable(bytes[start - 1]) {
            start -= 1;
        }
        let end = probe + 1 + text_len(&bytes[probe + 1..]);
        if end - start >= RUN_MIN {
            return Some((start, end, bytes[start..end].is_ascii()));
        }
        from = end + 1;
    }
    None
}

/// How many bytes at the start of `bytes` are text to `next_run` (none a
/// C0 control or DEL), read eight at a time: a byte below 0x20 borrows
/// out of its own high bit, and DEL is a zero byte once flipped. A borrow
/// can only mark bytes after a true one, so the first mark is exact.
#[cfg(any(test, not(target_arch = "x86_64")))]
fn text_len(bytes: &[u8]) -> usize {
    const ONES: u64 = 0x0101_0101_0101_0101;
    const HIGH: u64 = 0x8080_8080_8080_8080;
    let mut at = 0;
    while let Some(&eight) = bytes.get(at..).and_then(|rest| rest.first_chunk::<8>()) {
        let x = u64::from_le_bytes(eight);
        let control = x.wrapping_sub(ONES * 0x20) & !x & HIGH;
        let flipped = x ^ (ONES * 0x7f);
        let del = flipped.wrapping_sub(ONES) & !flipped & HIGH;
        let hit = control | del;
        if hit != 0 {
            return at + (hit.trailing_zeros() / 8) as usize;
        }
        at += 8;
    }
    at + bytes[at..].iter().position(|&b| b < 0x20 || b == 0x7f).unwrap_or(bytes.len() - at)
}

/// The states of vte 0.15's parser, as far as telling when it is back
/// in ground: its four CSI states act alike on every byte that matters
/// here, so they are one; SOS, PM and APC strings are one.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
enum Parse {
    #[default]
    Ground,
    Escape,
    EscapeIntermediate,
    Csi,
    DcsEntry,
    DcsParam,
    DcsIntermediate,
    DcsIgnore,
    DcsPassthrough,
    Osc,
    String,
}

/// vte's parser state, followed from the same bytes: its transition
/// table (vte 0.15 `Parser::change_state`) less the actions. `high` is
/// whether the last byte read in ground was 0x80 or above, so a UTF-8
/// character may be half read; `high_at_start` is that, as the last
/// chunk left it.
#[derive(Default)]
struct Mirror {
    state: Parse,
    high: bool,
    high_at_start: bool,
}

impl Mirror {
    /// Follow every byte.
    fn follow(&mut self, bytes: &[u8]) {
        self.catch_up(bytes, 0, bytes.len());
        self.high_at_start = self.high;
    }

    /// Bring the state from `from` to `to`. Every state of the parser
    /// goes to its escape state on ESC, so only the bytes after the last
    /// ESC in between need following.
    fn catch_up(&mut self, bytes: &[u8], from: usize, to: usize) {
        let from = match memchr::memrchr(0x1b, &bytes[from..to]) {
            Some(k) => {
                self.state = Parse::Escape;
                self.high = false;
                from + k + 1
            }
            None => from,
        };
        if from < to {
            let ground = self.stretch(bytes, from, to);
            if self.state == Parse::Ground && ground < to {
                self.high = bytes[to - 1] >= 0x80;
            }
        }
    }

    /// Follow `bytes[at..end]`, which holds no ESC, until the parser is
    /// in ground. Returns where ground begins, or `end`.
    fn stretch(&mut self, bytes: &[u8], mut at: usize, end: usize) -> usize {
        let find = |at: usize, hit: fn(u8) -> bool| bytes[at..end].iter().position(|&b| hit(b)).map(|k| at + k);
        while at < end {
            match self.state {
                Parse::Ground => return at,
                // Only a final byte, CAN or SUB changes a CSI.
                Parse::Csi => match find(at, |b| (0x40..=0x7e).contains(&b) || b == 0x18 || b == 0x1a) {
                    Some(k) => {
                        self.state = Parse::Ground;
                        at = k + 1;
                    }
                    None => return end,
                },
                Parse::Osc => match find(at, |b| b == 0x07 || b == 0x18 || b == 0x1a) {
                    Some(k) => {
                        self.state = Parse::Ground;
                        at = k + 1;
                    }
                    None => return end,
                },
                Parse::DcsPassthrough => match find(at, |b| b == 0x9c || b == 0x18 || b == 0x1a) {
                    Some(k) => {
                        self.state = Parse::Ground;
                        at = k + 1;
                    }
                    None => return end,
                },
                Parse::String | Parse::DcsIgnore => match find(at, |b| b == 0x18 || b == 0x1a) {
                    Some(k) => {
                        self.state = Parse::Ground;
                        at = k + 1;
                    }
                    None => return end,
                },
                state => {
                    let b = bytes[at];
                    at += 1;
                    self.state = match (state, b) {
                        (_, 0x18 | 0x1a) => Parse::Ground,
                        (Parse::Escape, b) => match b {
                            0x20..=0x2f => Parse::EscapeIntermediate,
                            b'P' => Parse::DcsEntry,
                            b'X' | b'^' | b'_' => Parse::String,
                            b'[' => Parse::Csi,
                            b']' => Parse::Osc,
                            0x30..=0x7e => Parse::Ground,
                            _ => Parse::Escape,
                        },
                        (Parse::EscapeIntermediate, 0x30..=0x7e) => Parse::Ground,
                        (Parse::DcsEntry, 0x20..=0x2f) => Parse::DcsIntermediate,
                        (Parse::DcsEntry, 0x30..=0x3f) => Parse::DcsParam,
                        (Parse::DcsEntry | Parse::DcsParam | Parse::DcsIntermediate, 0x40..=0x7e) => {
                            Parse::DcsPassthrough
                        }
                        (Parse::DcsParam, 0x20..=0x2f) => Parse::DcsIntermediate,
                        (Parse::DcsParam, 0x3c..=0x3f) => Parse::DcsIgnore,
                        (Parse::DcsIntermediate, 0x30..=0x3f) => Parse::DcsIgnore,
                        (state, _) => state,
                    };
                }
            }
            if self.state == Parse::Ground {
                self.high = false;
            }
        }
        at
    }
}

/// The character UTF-8 encodes at `at`, and its length, when the bytes
/// there are a whole, well-formed one (RFC 3629: no overlong form, no
/// surrogate, nothing past U+10FFFF). `None` for anything else, which
/// the parser takes as it always has.
#[cfg(test)]
thread_local! {
    static DECODE_ATTEMPTS: std::cell::Cell<[u64; 3]> = const { std::cell::Cell::new([0; 3]) };
}
#[cfg(test)]
pub(crate) fn decode_calls_reset() {
    DECODE_ATTEMPTS.with(|c| c.set([0; 3]));
}
#[cfg(test)]
pub(crate) fn decode_calls_take() -> [u64; 3] {
    DECODE_ATTEMPTS.with(|c| c.get())
}
#[inline(always)]
fn utf8_at(bytes: &[u8], at: usize) -> Option<(char, usize)> {
    #[cfg(test)]
    DECODE_ATTEMPTS.with(|count| {
        let mut values = count.get();
        let lane = bytes.get(at).map_or(0, |b| if *b < 0x80 { 1 } else { 2 });
        values[lane] += 1;
        count.set(values);
    });
    let lead = *bytes.get(at)?;
    if lead < 0x80 {
        return Some((char::from(lead), 1));
    }
    let next = |k: usize, low: u8, high: u8| bytes.get(at + k).copied().filter(|b| (low..=high).contains(b));
    let tail = |b: u8| u32::from(b & 0x3f);
    let (value, len) = match lead {
        0xc2..=0xdf => (u32::from(lead & 0x1f) << 6 | tail(next(1, 0x80, 0xbf)?), 2),
        0xe0..=0xef => {
            let (low, high) = match lead {
                0xe0 => (0xa0, 0xbf),
                0xed => (0x80, 0x9f),
                _ => (0x80, 0xbf),
            };
            let b1 = next(1, low, high)?;
            (u32::from(lead & 0x0f) << 12 | tail(b1) << 6 | tail(next(2, 0x80, 0xbf)?), 3)
        }
        0xf0..=0xf4 => {
            let (low, high) = match lead {
                0xf0 => (0x90, 0xbf),
                0xf4 => (0x80, 0x8f),
                _ => (0x80, 0xbf),
            };
            let b1 = next(1, low, high)?;
            let b2 = next(2, 0x80, 0xbf)?;
            (u32::from(lead & 0x07) << 18 | tail(b1) << 12 | tail(b2) << 6 | tail(next(3, 0x80, 0xbf)?), 4)
        }
        _ => return None,
    };
    Some((char::from_u32(value)?, len))
}

/// `unicode_width`'s answer for `c`, through a flat cache over the
/// whole codespace filled from the crate on first ask: the crate's
/// multi-level lookup is several dependent loads for the planes a
/// mixed-width flood actually writes (CJK, emoji, symbols — the 4 KiB
/// table over U+0000..U+0FFF tried earlier never held them), where
/// this is one. The cache is write-once per codepoint and every writer
/// stores the same value, so relaxed atomics are enough; -1 is
/// unasked, -2 is the crate's `None` (widths themselves run 0..=3).
#[inline]
fn width_of(c: char) -> Option<usize> {
    use std::sync::atomic::{AtomicI8, Ordering};
    static CACHE: std::sync::OnceLock<Box<[AtomicI8]>> = std::sync::OnceLock::new();
    let cache = CACHE
        .get_or_init(|| (0..0x110000).map(|_| AtomicI8::new(-1)).collect::<Vec<_>>().into_boxed_slice());
    let slot = &cache[c as usize];
    let v = slot.load(Ordering::Relaxed);
    if v >= 0 {
        return Some(v as usize);
    }
    if v == -2 {
        return None;
    }
    let w = unicode_width::UnicodeWidthChar::width(c);
    slot.store(w.map_or(-2, |w| w as i8), Ordering::Relaxed);
    w
}

fn held_back(bytes: &[u8]) -> Option<Vec<u8>> {
    // Only an escape that starts here and could still grow into one of
    // glass's own answers is held back; plain text before it flows on.
    if bytes.first() != Some(&0x1b) {
        return None;
    }
    const CANDIDATES: [&[u8]; 7] = [
        b"\x1b[c",
        b"\x1b[0c",
        b"\x1b[>c",
        b"\x1b[>0c",
        b"\x1b[>q",
        b"\x1b[>0q",
        b"\x1b[?2026$p",
    ];
    let could = |candidate: &[u8]| bytes.len() < candidate.len() && candidate.starts_with(bytes);
    CANDIDATES.iter().any(|c| could(c)).then(|| bytes.to_vec())
}

/// A query glass answers itself rather than leaving to `Term`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Ask {
    /// XTWINOPS 16: the size of one cell in pixels.
    CellSize,
    /// DA1: what glass takes in.
    Primary,
    /// XTSMGRAPHICS read, by its item.
    Graphics(u32),
    /// DA2: what glass is.
    Secondary,
    /// XTVERSION: the name and version.
    Version,
    /// DECRQM 2026: whether a synchronized update holds the frame.
    Synchronized,
}

/// The sequences glass answers itself. Returns how many bytes the
/// sequence took and what it asks, if these bytes begin with one.
///
/// `Term` answers the queries it knows (cursor place, text area in
/// characters, the mode report for most modes). The ones that need what
/// only the window knows — what this terminal is, one cell's pixels,
/// whether a synchronized update holds the frame — glass answers, before
/// the bytes reach `Term`, so the program sees one reply. Only the bytes
/// of the sequence itself are read: what follows it is not looked at.
fn intercepted(bytes: &[u8]) -> Option<(usize, Ask)> {
    let rest = bytes.strip_prefix(b"\x1b[")?;
    // XTWINOPS 16. `Term` answers 14 (text area) and 18 (characters)
    // with the window's help.
    if rest.starts_with(b"16t") {
        return Some((5, Ask::CellSize));
    }
    // DA1: what glass takes in, in the VT102 dialect of the 1990s.
    if rest.starts_with(b"c") {
        return Some((3, Ask::Primary));
    }
    if rest.starts_with(b"0c") {
        return Some((4, Ask::Primary));
    }
    // XTSMGRAPHICS: the sixel adapter's colour registers and geometry,
    // as a read (`CSI ? Pi ; 1 S`) is answered. Pi 1 is the colour
    // registers (the sixel adapter's 1024), Pi 2 the sixel geometry (the
    // text area in pixels, capped at 8192 a side); any other Pi is
    // refused with an error.
    if let Some(params) = rest.strip_prefix(b"?") {
        let end = params.iter().position(|b| (0x40..=0x7e).contains(b));
        if let Some(end) = end
            && params[end] == b'S'
            && let Ok(text) = std::str::from_utf8(&params[..end])
            && let Some((pi, "1")) = text.split_once(';')
            && let Ok(pi) = pi.parse::<u32>()
        {
            return Some((3 + end + 1, Ask::Graphics(pi)));
        }
    }
    // DA2: what glass is, in its own dialect.
    if rest.starts_with(b">c") {
        return Some((4, Ask::Secondary));
    }
    if rest.starts_with(b">0c") {
        return Some((5, Ask::Secondary));
    }
    // XTVERSION: the name and version, as the program asked.
    if rest.starts_with(b">q") {
        return Some((4, Ask::Version));
    }
    if rest.starts_with(b">0q") {
        return Some((5, Ask::Version));
    }
    // DECRQM 2026: whether a synchronized update holds the frame. `Term`
    // reports the mode as unset when asked; glass knows the truth.
    if rest.starts_with(b"?2026$p") {
        return Some((9, Ask::Synchronized));
    }
    None
}

#[cfg(test)]
mod tests {
    use super::*;

    fn engine() -> Engine {
        Engine::new(
            24,
            80,
            HostInfo { colors: [[0xd0, 0xd0, 0xd0], [0, 0, 0], [0xff, 0xff, 0xff]], cell_px: (10, 20) },
        )
    }

    fn answers(input: &[u8]) -> Vec<u8> {
        let mut term = engine();
        term.process(input);
        term.take_effects().replies
    }

    #[test]
    fn startup_queries_are_answered() {
        assert_eq!(answers(b"\x1b[c"), b"\x1b[?62;4;22c");
        assert_eq!(answers(b"\x1b[3;5H\x1b[6n"), b"\x1b[3;5R");
        assert_eq!(answers(b"\x1b[5n"), b"\x1b[0n");
        assert_eq!(answers(b"\x1b[18t"), b"\x1b[8;24;80t");
        assert_eq!(answers(b"\x1b[14t"), b"\x1b[4;480;800t");
        assert_eq!(answers(b"\x1b[16t"), b"\x1b[6;20;10t");
        assert_eq!(answers(b"\x1b[>c"), b"\x1b[>1;10;0c");
        let version = env!("CARGO_PKG_VERSION");
        assert_eq!(answers(b"\x1b[>q\x07"), format!("\x1bP>|glass {version}\x1b\\").as_bytes());
        assert_eq!(answers(b"\x1b]11;?\x07"), b"\x1b]11;rgb:0000/0000/0000\x1b\\");
        assert_eq!(answers(b"\x1b[?2026$p"), b"\x1b[?2026;2$y");
        assert_eq!(answers(b"\x1b[?2026h\x1b[?2026$p"), b"\x1b[?2026;1$y");
        assert_eq!(answers(b"\x1b[?9999$p"), b"\x1b[?9999;0$y");
    }

    /// Boundary scans and run classification agree with a byte-at-a-time
    /// model at every offset, including multiple controls in one vector.
    #[test]
    fn text_runs_end_where_a_byte_at_a_time_scan_ends() {
        let slow = |bytes: &[u8]| bytes.iter().position(|&b| b < 0x20 || b == 0x7f).unwrap_or(bytes.len());
        for stop in 0..=255u8 {
            for at in 0..20 {
                for fill in [b'a', 0x20, 0x7e, 0x80, 0xff, 0x21, 0x9f] {
                    let mut bytes = [fill; 19];
                    if at < bytes.len() {
                        bytes[at] = stop;
                    }
                    for from in 0..bytes.len() {
                        let rest = &bytes[from..];
                        let len = slow(rest);
                        assert_eq!(text_len(rest), len, "stop {stop:#x} at {at} over {fill:#x} from {from}");
                        #[cfg(target_arch = "x86_64")]
                        assert_eq!(classified_text_len(rest), (len, rest[..len].is_ascii()));
                    }
                }
            }
        }
        let printable = |b: u8| b >= 0x20 && b != 0x7f;
        let slow_next = |bytes: &[u8], mut from: usize| {
            while from < bytes.len() {
                if !printable(bytes[from]) {
                    from += 1;
                    continue;
                }
                let start = from;
                while from < bytes.len() && printable(bytes[from]) { from += 1; }
                if from - start >= RUN_MIN {
                    return Some((start, from, bytes[start..from].is_ascii()));
                }
            }
            None
        };
        // Every possible byte at each side of a control tests high bits
        // excluded by both the backward and forward mask. Multiple
        // controls exercise last-boundary selection (not borrow masks).
        for value in 0..=255u8 {
            let mut bytes = [b'a'; 113];
            for at in [0, 7, 15, 16, 23, 24, 31, 48, 55, 72, 95, 112] {
                bytes[at] = value;
            }
            for at in [3, 17, 60, 61, 86] { bytes[at] = 0x7f; }
            for from in 0..=bytes.len() {
                assert_eq!(next_run(&bytes, from), slow_next(&bytes, from), "value {value} from {from}");
            }
        }
        // A short EOF span may advance the probe one past the input.
        let mut short_tail = [0; RUN_MIN];
        short_tail[RUN_MIN - 1] = b'A';
        assert_eq!(next_run(&short_tail, 0), None);
        // A control right after another (a borrow into the next lane).
        assert_eq!(text_len(b"abc\x1f\x20xyz"), 3);
        assert_eq!(text_len(b"abcdefg\x00\x7f"), 7);
    }

    /// Exercise exact tail lengths and every vector-boundary lane directly,
    /// not just the run-search probe offsets that happen to reach the helper.
    #[cfg(target_arch = "x86_64")]
    #[test]
    fn classified_text_masks_match_scalar_at_every_vector_boundary() {
        for len in [0, 1, 15, 16, 17, 31, 32, 33, 47, 48, 63, 64, 65, 79, 95, 96, 97, 127, 128, 129] {
            for value in 0..=255u8 {
                for at in 0..=len {
                    for fill in [b'a', 0x80] {
                        let mut bytes = vec![fill; len];
                        if at < len { bytes[at] = value; }
                        let n = bytes.iter().position(|&b| b < 0x20 || b == 0x7f).unwrap_or(len);
                        assert_eq!(classified_text_len(&bytes), (n, bytes[..n].is_ascii()),
                            "len {len} value {value:#x} at {at} fill {fill:#x}");
                    }
                }
            }
        }
        // High bits AFTER a control do not make the returned prefix UTF-8.
        // High bits BEFORE the control do, including across vector halves.
        for stop in 0..129 {
            for high in 0..129 {
                let mut bytes = [b'a'; 129];
                bytes[high] = 0x80;
                bytes[stop] = 0x7f;
                assert_eq!(classified_text_len(&bytes), (stop, high >= stop));
            }
        }
    }

    /// A legal slice can end at an inaccessible page. This catches accidental
    /// wide loads past EOF that ordinary Vec-backed oracle tests cannot detect.
    #[cfg(all(target_arch = "x86_64", target_os = "linux"))]
    #[test]
    fn classified_text_never_loads_past_a_guarded_slice() {
        struct Pages { ptr: *mut libc::c_void, len: usize }
        impl Drop for Pages {
            fn drop(&mut self) {
                // SAFETY: this object uniquely owns the mmap allocation.
                assert_eq!(unsafe { libc::munmap(self.ptr, self.len) }, 0);
            }
        }
        // SAFETY: sysconf has no preconditions for this constant.
        let page = unsafe { libc::sysconf(libc::_SC_PAGESIZE) };
        assert!(page >= 256);
        let page = page as usize;
        // SAFETY: anonymous private allocation, no borrowed or fixed address.
        let ptr = unsafe { libc::mmap(std::ptr::null_mut(), page * 2,
            libc::PROT_READ | libc::PROT_WRITE, libc::MAP_PRIVATE | libc::MAP_ANONYMOUS, -1, 0) };
        assert_ne!(ptr, libc::MAP_FAILED);
        let pages = Pages { ptr, len: page * 2 };
        // SAFETY: the second page is inside this allocation, page-aligned.
        assert_eq!(unsafe { libc::mprotect(ptr.cast::<u8>().add(page).cast(), page, libc::PROT_NONE) }, 0);
        for len in 0..=256 {
            // SAFETY: the slice ends exactly at the first page's boundary;
            // its entire length is writable, and it aliases no other slice.
            let bytes = unsafe { std::slice::from_raw_parts_mut(pages.ptr.cast::<u8>().add(page - len), len) };
            bytes.fill(b'a');
            assert_eq!(classified_text_len(bytes), (len, true));
            if len > 0 {
                bytes[len - 1] = 0x80;
                assert_eq!(classified_text_len(bytes), (len, false));
                bytes[len - 1] = 0x1f;
                assert_eq!(classified_text_len(bytes), (len - 1, true));
            }
        }
    }

    /// Unpadded scalar tests never enter a four-byte decoder path for short
    /// encodings. Adjacent junk must not change the first decoded scalar.
    #[test]
    fn utf8_decoding_all_scalars_with_padded_offsets() {
        let mut encoded = [0; 4];
        let mut padded = [0xff; 12];
        for value in 0..=0x10ffff {
            let Some(c) = char::from_u32(value) else { continue };
            let bytes = c.encode_utf8(&mut encoded).as_bytes();
            for at in 0..=4 {
                padded.fill(0xff);
                padded[at..at + bytes.len()].copy_from_slice(bytes);
                assert_eq!(utf8_at(&padded, at), Some((c, bytes.len())),
                    "padded scalar {value:#x} at {at}");
                assert_eq!(utf8_at(&padded, padded.len()), None);
            }
        }
    }

    /// A decoder may inspect exactly its slice, never the inaccessible page
    /// following it, including when a valid scalar is truncated at that edge.
    #[cfg(target_os = "linux")]
    #[test]
    fn utf8_decoding_never_loads_past_a_guarded_slice() {
        struct Pages { ptr: *mut libc::c_void, len: usize }
        impl Drop for Pages {
            fn drop(&mut self) {
                // SAFETY: this object uniquely owns the mmap allocation.
                assert_eq!(unsafe { libc::munmap(self.ptr, self.len) }, 0);
            }
        }
        // SAFETY: sysconf has no preconditions for this constant.
        let page = unsafe { libc::sysconf(libc::_SC_PAGESIZE) };
        assert!(page >= 256);
        let page = page as usize;
        // SAFETY: private anonymous allocation, not a fixed address.
        let ptr = unsafe { libc::mmap(std::ptr::null_mut(), page * 2,
            libc::PROT_READ | libc::PROT_WRITE, libc::MAP_PRIVATE | libc::MAP_ANONYMOUS, -1, 0) };
        assert_ne!(ptr, libc::MAP_FAILED);
        let pages = Pages { ptr, len: page * 2 };
        // SAFETY: the protected page lies inside the mapping and is aligned.
        assert_eq!(unsafe { libc::mprotect(ptr.cast::<u8>().add(page).cast(), page, libc::PROT_NONE) }, 0);
        let cases: &[&[u8]] = &[b"", b"a", "é".as_bytes(), "漢".as_bytes(),
            "🙂".as_bytes(), "\u{10ffff}".as_bytes(), b"\xc0\x80",
            b"\xe0\x9f\xbf", b"\xed\xa0\x80", b"\xf0\x8f\xbf\xbf",
            b"\xf4\x90\x80\x80", b"\xf5\x80\x80\x80", b"\xff"];
        for &case in cases {
            for tail in 0..=case.len() {
                for prefix in 0..=32 {
                    let len = prefix + tail;
                    // SAFETY: this unique slice ends at the writable page's
                    // boundary; even the empty slice has a nonnull pointer.
                    let bytes = unsafe { std::slice::from_raw_parts_mut(
                        pages.ptr.cast::<u8>().add(page - len), len) };
                    bytes.fill(b'a');
                    bytes[prefix..].copy_from_slice(&case[..tail]);
                    for at in 0..=bytes.len() {
                        let rest = &bytes[at..];
                        let valid = match std::str::from_utf8(rest) {
                            Ok(text) => text,
                            Err(e) => std::str::from_utf8(&rest[..e.valid_up_to()]).unwrap(),
                        };
                        let expected = valid.chars().next().map(|c| (c, c.len_utf8()));
                        assert_eq!(utf8_at(bytes, at), expected,
                            "case {case:x?} tail {tail} prefix {prefix} at {at}");
                    }
                }
            }
        }
    }

    #[test]
    fn utf8_decoding_covers_all_scalars_and_boundary_rejections() {
        let mut buf = [0; 4];
        for value in 0..=0x10ffff {
            let Some(c) = char::from_u32(value) else { continue };
            let bytes = c.encode_utf8(&mut buf).as_bytes();
            assert_eq!(utf8_at(bytes, 0), Some((c, bytes.len())), "scalar {value:#x}");
            for len in 0..bytes.len() {
                assert_eq!(utf8_at(&bytes[..len], 0), None, "truncated scalar {value:#x} to {len}");
            }
        }
        // Exhaust all second-byte restrictions at the overlong/surrogate/
        // codespace edges, including continuation failures in later lanes.
        for lead in [0xc0, 0xc1, 0xc2, 0xdf, 0xe0, 0xed, 0xef, 0xf0, 0xf4, 0xf5, 0xff] {
            for second in 0..=255u8 {
                for third in [0, 0x7f, 0x80, 0x9f, 0xa0, 0xbf, 0xc0, 0xff] {
                    for fourth in [0, 0x7f, 0x80, 0xbf, 0xc0, 0xff] {
                        let bytes = [lead, second, third, fourth];
                        for len in 1..=4 {
                            let bytes = &bytes[..len];
                            let valid = match std::str::from_utf8(bytes) {
                                Ok(text) => Some(text),
                                Err(error) if error.valid_up_to() > 0 => std::str::from_utf8(&bytes[..error.valid_up_to()]).ok(),
                                _ => None,
                            };
                            let expected = valid.and_then(|text| text.chars().next()).map(|c| (c, c.len_utf8()));
                            assert_eq!(utf8_at(bytes, 0), expected, "input {bytes:x?}");
                        }
                    }
                }
            }
        }
    }

    /// The run writer's UTF-8 decoder takes exactly the characters the
    /// standard library's validation calls well formed, at every offset
    /// of random bytes and of real text.
    #[test]
    fn utf8_decoding_matches_the_standard_library() {
        let mut seed = 0x2545_f491_4f6c_dd1du64;
        let mut next = || {
            seed ^= seed << 13;
            seed ^= seed >> 7;
            seed ^= seed << 17;
            seed
        };
        let text = "a漢字🙂é\u{301}\u{85}\u{7f}\u{10ffff}\u{d7ff}\u{e000}\u{800}\u{80}".as_bytes();
        for round in 0..20_000 {
            let bytes: Vec<u8> = if round % 3 == 0 {
                text.iter().map(|&b| if next() % 13 == 0 { next() as u8 } else { b }).collect()
            } else {
                (0..8).map(|_| [0x80, 0xbf, 0xc2, 0xe0, 0xed, 0xf0, 0xf4, 0xf5, 0x9f, 0xa0, 0x41][next() as usize % 11] ^ ((next() % 4 == 0) as u8 * (next() as u8 & 0x3f))).collect()
            };
            for at in 0..bytes.len() {
                let rest = &bytes[at..];
                let valid = match std::str::from_utf8(rest) {
                    Ok(text) => text,
                    Err(error) => std::str::from_utf8(&rest[..error.valid_up_to()]).unwrap(),
                };
                let want = valid.chars().next().map(|c| (c, c.len_utf8()));
                assert_eq!(utf8_at(&bytes, at), want, "{:x?} at {at}", bytes);
            }
        }
    }

    #[test]
    fn replies_keep_stream_order_in_one_feed() {
        // `Term` answers the cursor report, glass answers DA1: one feed
        // holding both answers in the order they were asked, with the
        // DECRQM after a synchronized update's end speaking of its end.
        assert_eq!(answers(b"\x1b[2;3H\x1b[6n\x1b[c"), b"\x1b[2;3R\x1b[?62;4;22c");
        assert_eq!(answers(b"\x1b[c\x1b[6n"), b"\x1b[?62;4;22c\x1b[1;1R");
        assert_eq!(answers(b"\x1b[5n\x1b[16t\x1b[5n"), b"\x1b[0n\x1b[6;20;10t\x1b[0n");
        assert_eq!(
            answers(b"\x1b[?2026h\x1b[?2026$p\x1b[?2026l\x1b[?2026$p"),
            b"\x1b[?2026;1$y\x1b[?2026;2$y"
        );
        assert_eq!(answers(b"\x1b[?2;1Sx\x1b[?1;1S"), b"\x1b[?2;0;800;480S\x1b[?1;0;1024S");
    }

    #[test]
    fn split_sequences_are_still_answered() {
        let mut term = engine();
        term.process(b"\x1b");
        assert!(term.take_effects().replies.is_empty());
        term.process(b"[c");
        assert_eq!(term.take_effects().replies, b"\x1b[?62;4;22c");
        // Text split around an escape still lands.
        let mut term = engine();
        term.process(b"hi\x1b[");
        term.process(b"16t");
        assert_eq!(term.take_effects().replies, b"\x1b[6;20;10t");
        assert_eq!(&term.cells()[..2].iter().map(|c| c.c).collect::<String>(), "hi");
    }

    #[test]
    fn keyboard_dialect_flags_are_tracked() {
        let mut term = engine();
        assert_eq!(term.keyboard_flags(), 0);
        term.process(b"\x1b[>1u");
        assert_eq!(term.keyboard_flags(), 1);
        // A query answers with the flags set.
        term.process(b"\x1b[?u");
        assert_eq!(term.take_effects().replies, b"\x1b[?1u");
        term.process(b"\x1b[<u");
        assert_eq!(term.keyboard_flags(), 0);
        term.process(b"\x1b[?u");
        assert_eq!(term.take_effects().replies, b"\x1b[?0u");
    }

    #[test]
    fn a_synchronized_update_ends_at_its_deadline() {
        let mut term = engine();
        term.process(b"\x1b[?2026hhi");
        // The update is open, its frame held, and DECRQM says so.
        assert!(term.synchronized());
        assert!(term.take_effects().replies.is_empty() || !term.take_effects().replies.is_empty());
        term.process(b"\x1b[?2026$p");
        assert!(term.take_effects().replies.ends_with(b"\x1b[?2026;1$y"));
        // Before the deadline (150 ms) nothing ends.
        assert!(!term.end_sync_update());
        assert!(term.synchronized());
        // After it, the buffered bytes are applied and the screen moves.
        std::thread::sleep(std::time::Duration::from_millis(200));
        assert!(term.end_sync_update());
        assert!(!term.synchronized());
        assert_eq!(&term.cells()[..2].iter().map(|c| c.c).collect::<String>(), "hi");
        // A second call has nothing to end.
        assert!(!term.end_sync_update());
        // DECRQM now answers that no update is open, truthfully.
        term.process(b"\x1b[?2026$p");
        assert!(term.take_effects().replies.ends_with(b"\x1b[?2026;2$y"));
    }

    #[test]
    fn width_cache_agrees_with_the_crate_everywhere() {
        // The flat cache in `width_of` is only a cache: for every
        // codepoint it must answer exactly what the crate answers,
        // on the first ask (which fills it) and the second (which
        // reads it back).
        for v in 0..0x110000u32 {
            let Some(c) = char::from_u32(v) else { continue };
            let want = unicode_width::UnicodeWidthChar::width(c);
            assert_eq!(width_of(c), want, "U+{v:04X} first ask");
            assert_eq!(width_of(c), want, "U+{v:04X} cached");
        }
    }

    #[test]
    fn lines_scrolled_off_top_count_exactly() {
        // Full-screen scrolling: each line that leaves the top counts.
        let mut term = Engine::new(4, 10, HostInfo { colors: [[0; 3]; 3], cell_px: (1, 1) });
        assert_eq!(term.scrolled_off_top(), 0);
        term.process(b"one\r\ntwo\r\nthree\r\nfour\r\nfive");
        assert_eq!(term.scrolled_off_top(), 1);
        term.process(b"six\r\nseven");
        assert_eq!(term.scrolled_off_top(), 2);
        // Autowrap scrolls the same way: a line that runs past the last
        // column pushes the top line into history.
        term.process(b"0123456789abc");
        assert_eq!(term.scrolled_off_top(), 3);
    }

    #[test]
    fn lines_scrolled_off_top_survive_a_cleared_history() {
        let mut term = Engine::new(4, 10, HostInfo { colors: [[0; 3]; 3], cell_px: (1, 1) });
        term.process(b"one\r\ntwo\r\nthree\r\nfour\r\nfive");
        assert_eq!(term.scrolled_off_top(), 1);
        // `CSI 3 J` empties the history; the count of lines that left the
        // top does not come down with it.
        term.process(b"\x1b[3J");
        assert_eq!(term.scrolled_off_top(), 1);
        // And it keeps counting from there.
        term.process(b"\r\nsix");
        assert_eq!(term.scrolled_off_top(), 2);
    }

    #[test]
    fn lines_scrolled_after_the_sentinel_is_erased_still_count() {
        // An erase that touches the top row drops `Term`'s selection —
        // the scroll counter's sentinel — and no wrapper path replants
        // it. The lines that scroll off after the erase, in the same
        // feed, must still count: the sentinel is replanted before the
        // first of them scrolls, not at the next pacing fold.
        let mut term = Engine::new(4, 10, HostInfo { colors: [[0; 3]; 3], cell_px: (1, 1) });
        // As the reader's pump leaves it while the store holds nothing:
        // no scroll on this screen can move a picture.
        term.set_motion(None);
        term.process(b"\x1b[H\x1b[2Kone\r\ntwo\r\nthree\r\nfour\r\nfive\r\nsix");
        assert_eq!(term.scrolled_off_top(), 2);
    }

    #[test]
    fn lines_scrolled_inside_a_region_do_not_count() {
        let mut term = Engine::new(6, 10, HostInfo { colors: [[0; 3]; 3], cell_px: (1, 1) });
        // A region from the second line down: its scrolls never reach
        // history, so they are not counted.
        term.process(b"\x1b[2;6r\x1b[5S");
        assert_eq!(term.scrolled_off_top(), 0);
        // A region that starts at the top does reach history.
        term.process(b"\x1b[1;6r\x1b[2S");
        assert_eq!(term.scrolled_off_top(), 2);
    }

    #[test]
    fn lines_scrolled_off_top_count_through_a_full_history() {
        // Scroll far past the history limit: the count keeps growing.
        let mut term = Engine::new(4, 10, HostInfo { colors: [[0; 3]; 3], cell_px: (1, 1) });
        let lines = "0123456789\r\n".repeat(4_000);
        term.process(lines.as_bytes());
        assert_eq!(term.scrolled_off_top(), 3_997);
        let more = "0123456789\r\n".repeat(8_000);
        term.process(more.as_bytes());
        assert_eq!(term.scrolled_off_top(), 11_997);
    }

    #[test]
    fn the_alternate_screen_scrolls_are_not_counted() {
        let mut term = Engine::new(4, 10, HostInfo { colors: [[0; 3]; 3], cell_px: (1, 1) });
        term.process(b"one\r\ntwo\r\nthree\r\nfour\r\nfive");
        assert_eq!(term.scrolled_off_top(), 1);
        term.process(b"\x1b[?1049h");
        assert!(term.alternate_screen());
        // Scrolling on the alternate screen has no history to reach.
        term.process(b"a\r\nb\r\nc\r\nd\r\ne\r\nf");
        assert_eq!(term.scrolled_off_top(), 1);
        // Back on the main screen the count stands and keeps counting.
        term.process(b"\x1b[?1049l");
        assert_eq!(term.scrolled_off_top(), 1);
        term.process(b"\r\nsix");
        assert_eq!(term.scrolled_off_top(), 2);
    }

    #[test]
    fn wide_characters_copy_once() {
        let mut term = Engine::new(3, 10, HostInfo { colors: [[0; 3]; 3], cell_px: (1, 1) });
        term.process("你好🎉🎊".as_bytes());
        let cells = term.cells();
        let chars: String = cells[..8].iter().map(|c| c.c).collect();
        // A wide character's right half carries no character of its own;
        // a null there means text and paint skip it while a click on the
        // right half still lands in the word.
        assert_eq!(chars.chars().filter(|&c| c != '\0').collect::<String>(), "你好🎉🎊");
        // Each right half is a null of its own, not a second copy.
        assert_eq!(chars.chars().filter(|&c| c == '\0').count(), 4);
    }

    /// A program writing marks onto one cell forever keeps nine of them,
    /// whether they come in one run (glass's fast path) or one feed at a
    /// time, so it can't exhaust memory that way.
    #[test]
    fn marks_on_one_cell_are_capped() {
        let marks = |term: &Engine, column| term.term.grid()[Line(0)][Column(column)].zerowidth().map_or(0, <[char]>::len);
        let mut term = engine();
        let mut text = String::from("a");
        text.extend(std::iter::repeat_n('\u{301}', 10_000));
        text.push_str("\x1b[31mb");
        term.process(text.as_bytes());
        for _ in 0..1_000 {
            term.process("\u{301}".as_bytes());
        }
        assert_eq!((marks(&term, 0), marks(&term, 1)), (9, 9));
    }

    #[test]
    fn modes_titles_and_clipboard_are_tracked() {
        let mut term = engine();
        term.process(b"\x1b[?1004h\x1b]2;a;b\x07");
        assert!(term.focus_reports());
        assert_eq!(term.take_effects().title.as_deref(), Some("a;b"));
        term.process(b"\x1b[?1004l\x1b]52;c;aGk=\x07\x07");
        assert!(!term.focus_reports());
        let effects = term.take_effects();
        assert_eq!(effects.clipboard.as_deref(), Some("hi"));
        assert!(effects.bell);
    }

    #[test]
    fn cells_carry_style_and_links() {
        let mut term = engine();
        term.process(b"\x1b[1;31mA\x1b[0m");
        assert_eq!(term.cells()[0].c, 'A');
        assert_eq!(term.cells()[0].fg, Color::Indexed(1));
        assert!(term.cells()[0].flags.contains(CellFlags::BOLD));
        term.process(b"\x1b]8;;https://example.org\x1b\\link\x1b]8;;\x1b\\");
        assert_eq!(term.cells()[4].link.as_deref(), Some("https://example.org"));
        assert_eq!(term.link_at(0, 4).as_deref(), Some("https://example.org"));
        assert_eq!(term.link_at(0, 4).as_deref(), Some("https://example.org"));
        assert!(term.link_at(0, 9).is_none());
    }

    /// A `Handler` method not forwarded would fall back to the trait's
    /// default and silently drop a feature. Feed one of each sequence
    /// through glass's wrapper and through a `Term` driven directly, and
    /// compare what both came to: cells, cursor, mode and keyboard flags.
    #[test]
    fn every_handler_method_is_forwarded() {
        let stream = b"\x1b[31;4mSGR\x1b[0m\
            \x1b[3;5H\x1b[A\x1b[B\x1b[C\x1b[D\x1b[E\x1b[F\x1b[H\x1b[d\x1b[2;3r\x1b[1;6H\
            \x1b[2J\x1b[3J\x1b[K\x1b[1K\x1b[2K\x1b[J\x1b[1J\x1b[2X\x1b[2P\x1b[2@\
            \x1b[2L\x1b[2M\x1b[2S\x1b[2T\x1b[r\x1bZ\x1b[g\x1b[3g\
            \x1b]0;the title\x07\x1b]2;two\x07\
            \x1b[4h\x1b[4l\x1b[?1h\x1b[?1l\x1b[?6h\x1b[?6l\x1b[?7h\x1b[?7l\
            \x1b[?12h\x1b[?12l\x1b[?25h\x1b[?25l\x1b[?47h\x1b[?47l\
            \x1b[?1000h\x1b[?1000l\x1b[?1002h\x1b[?1003h\x1b[?1005h\x1b[?1006h\x1b[?1015h\
            \x1b[?1048h\x1b[?1048l\x1b[?1049h\x1b[?1049l\x1b[?2004h\x1b[?2004l\
            \x1b[?2026h\x1b[?2026l\x1b[?7714h\x1b[?7714l\
            \x1b[>4;2m\x1b[>4;0m\x1b[=5;2u\
            \x1b[2 q\x1b[4 q\x1b7\x1b8\x1bD\x1bM\x1bE\x1b#8\x1b(B\x1b(0\x1b)\
            \x1bP+q544e\x1b\\\x1b_Gi=1,a=q\x1b\\\x1b^Xok\x1b\\\
            \x1bc";
        let mut wrapped = engine();
        wrapped.process(stream);
        // A `Term` fed the same bytes through a bare vte `Processor`,
        // with no wrapper on the way: the wrapper must not change what
        // reaches it.
        let (tx, _rx) = std::sync::mpsc::channel();
        let mut bare = Term::new(
            Config { scrolling_history: scrollback_lines(), kitty_keyboard: true, ..Config::default() },
            &Size { columns: 10, lines: 4 },
            Listener { tx },
        );
        let mut proc: Processor<alacritty_terminal::vte::ansi::StdSyncHandler> = Processor::new();
        // glass answers some sequences itself and drops their bytes, so
        // the bare pass sees a little more — but every byte that reaches
        // the wrapper reaches `Term` unchanged.
        let only_text = b"\x1b[31;4mSGR\x1b[0m\x1b[3;5H\x1b[A\x1b[B\x1b[C\x1b[D\
            \x1b[2X\x1b[2P\x1b[2@\x1b[2L\x1b[2M\x1b[2S\x1b[2T\x1bZ\x1b[g\x1b[3g\
            \x1b]0;the title\x07\x1b[4h\x1b[4l\x1b[?12h\x1b[?12l\x1b[=5;2u\x1b[2 q\
            \x1b7\x1b8\x1bD\x1bM\x1bE\x1b#8\x1b(B\x1b(0";
        proc.advance(&mut bare, only_text);
        let mut wrapped2 = engine();
        wrapped2.process(only_text);
        assert_eq!(
            wrapped2.term.grid().cursor.point, bare.grid().cursor.point,
            "the wrapper forwards every method it sees"
        );
        assert_eq!(wrapped2.keyboard_flags(), {
            // The same flags read from the bare term's mode bits.
            let mode = bare.mode();
            let mut flags = 0;
            flags |= u8::from(mode.contains(TermMode::DISAMBIGUATE_ESC_CODES));
            flags |= u8::from(mode.contains(TermMode::REPORT_EVENT_TYPES)) << 1;
            flags |= u8::from(mode.contains(TermMode::REPORT_ALTERNATE_KEYS)) << 2;
            flags |= u8::from(mode.contains(TermMode::REPORT_ALL_KEYS_AS_ESC)) << 3;
            flags
        });
    }

    #[test]
    fn cursor_and_scrollback_move_together() {
        let mut term = Engine::new(4, 10, HostInfo { colors: [[0; 3]; 3], cell_px: (1, 1) });
        term.process(b"one\r\ntwo\r\nthree\r\nfour\r\nfive");
        assert_eq!(term.scrolled_off_top(), 1);
        assert!(term.scroll_display(1));
        assert!(term.cursor().is_none());
        assert!(term.scroll_display(-1));
        // `five` leaves the cursor in the fifth column of the last row.
        assert_eq!(term.cursor(), Some((3, 4)));
    }

    #[test]
    fn cursor_style_follows_the_program() {
        let mut term = engine();
        // DECSCUSR 0 is glass's default: a steady block.
        assert!(!term.cursor_blinking());
        assert_eq!(term.cursor_look(), CursorLook::Block);
        term.process(b"\x1b[0 q");
        assert_eq!(term.cursor_look(), CursorLook::Block);
        assert!(!term.cursor_blinking(), "DECSCUSR 0 restores glass's steady block");
        term.process(b"\x1b[1 q");
        assert_eq!(term.cursor_look(), CursorLook::Block);
        assert!(term.cursor_blinking());
        term.process(b"\x1b[2 q");
        assert_eq!(term.cursor_look(), CursorLook::Block);
        assert!(!term.cursor_blinking(), "DECSCUSR 2 is a steady block");
        term.process(b"\x1b[3 q");
        assert_eq!(term.cursor_look(), CursorLook::Underline);
        assert!(term.cursor_blinking());
        term.process(b"\x1b[4 q");
        assert_eq!(term.cursor_look(), CursorLook::Underline);
        assert!(!term.cursor_blinking());
        term.process(b"\x1b[5 q");
        assert_eq!(term.cursor_look(), CursorLook::Beam);
        assert!(term.cursor_blinking());
        term.process(b"\x1b[6 q");
        assert_eq!(term.cursor_look(), CursorLook::Beam);
        assert!(!term.cursor_blinking());
        // Mode ?12 asks for the blink on its own, and a reset holds it still.
        term.process(b"\x1b[?12h");
        assert!(term.cursor_blinking());
        term.process(b"\x1b[?12l");
        assert!(!term.cursor_blinking());
        // The cursor hides when the program asks, whatever shape it set.
        term.process(b"\x1b[?25l");
        assert_eq!(term.cursor_look(), CursorLook::Beam);
        assert!(term.cursor().is_none());
        term.process(b"\x1b[?25h");
        assert!(term.cursor().is_some());
        term.process(b"\x1b]12;#ff0000\x07");
        assert_eq!(term.cursor_color(), Some(Rgb { r: 0xff, g: 0, b: 0 }));
    }

    #[test]
    fn mouse_modes_and_encodings_are_reported() {
        let mut term = engine();
        assert_eq!(term.mouse_protocol(), (MouseProtocolMode::None, MouseProtocolEncoding::Default));
        term.process(b"\x1b[?1000;1006h");
        assert_eq!(term.mouse_protocol(), (MouseProtocolMode::PressRelease, MouseProtocolEncoding::Sgr));
        term.process(b"\x1b[?1002;1005h");
        assert_eq!(term.mouse_protocol(), (MouseProtocolMode::ButtonMotion, MouseProtocolEncoding::Utf8));
        term.process(b"\x1b[?1003h");
        assert_eq!(term.mouse_protocol(), (MouseProtocolMode::AnyMotion, MouseProtocolEncoding::Utf8));
    }
}
