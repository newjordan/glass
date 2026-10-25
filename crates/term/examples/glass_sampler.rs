//! A showcase of every graphic dialect glass expands.
//!
//! It sizes each picture from the window it probed: columns from `stty
//! size` or XTWINOPS 18, one cell's pixels from XTWINOPS 16 (10×20 if
//! that query is not answered). The main picture of a scene fills about
//! half the width and never passes the screen. One thread owns stdin;
//! the probe reads replies from that channel and never blocks past its
//! deadline.
//!
//! ```text
//! cargo run --example glass_sampler
//! cargo run --example glass_sampler -- --check
//! ```
//!
//! `--check` asks glass to answer every op (an `r=` token on each
//! `glass;` op, and no `q=2` on APC graphics) and prints one line to
//! stderr: ops sent, OK, and each error with its code.

use std::io::{self, Read, Write};
use std::process::{Command, Stdio};
use std::sync::atomic::{AtomicBool, AtomicU32, Ordering};
use std::sync::mpsc::{self, Receiver};
use std::sync::Mutex;
use std::thread;
use std::time::{Duration, Instant};

const HELLO: &[u8] = b"\x1b_hello\x1b\\";
const HOLD_TEXT: u64 = 2200;
const HOLD_CURSOR: u64 = 400;
const HOLD_SIXEL: u64 = 2600;
const HOLD_APC_UNDER: u64 = 1200;
const HOLD_APC_OVER: u64 = 1100;
const HOLD_APC_CROP: u64 = 1300;
const HOLD_PLACE: u64 = 1000;
const HOLD_SCROLL: u64 = 80;
const HOLD_SCROLL_REST: u64 = 500;
const HOLD_OSC: u64 = 2200;
const HOLD_ANIM: u64 = 4000;
const HOLD_GLOW: u64 = 800;
const HOLD_PARTICLES: u64 = 900;
const HOLD_PRIM: u64 = 700;
const HOLD_CUBE: u64 = 2000;
const HOLD_GROUP: u64 = 1300;
const HOLD_CHART: u64 = 2000;
const HOLD_FRAME: u64 = 67;
const HOLD_CLOSE: u64 = 900;
const HOLD_FINALE: u64 = 4000;
const SCROLL_LINES: u64 = 24;
const VIDEO_FRAMES: u64 = 20;
const ANIM_FRAMES: usize = 12;
const ANIM_GAP_MS: u32 = 80;
const FALLBACK_CELL_W: u32 = 10;
const FALLBACK_CELL_H: u32 = 20;
/// How long the probe waits for glass to answer. Checked on the channel,
/// never by blocking in a read.
const PROBE_MS: u64 = 600;

/// A frame payload is capped at 1 MiB (`glass_scene::SCENE_BYTES`), and
/// the check is on the bytes the op carries (base64 of raw RGBA) before
/// decode. 480×270 raw is 518_400 bytes; its base64 is 691_200, under
/// that cap. The showcase opens at this size and `fit` scales it up.
const FRAME_BYTES: u32 = 1 << 20;
/// Panel size shared by the showcase and every video frame.
const VIDEO_W: u32 = 480;
const VIDEO_H: u32 = 270;
const _: () = assert!(
    (VIDEO_W as usize) * (VIDEO_H as usize) * 4 <= FRAME_BYTES as usize
);

static CHECK: AtomicBool = AtomicBool::new(false);
static SHOWCASE_OPEN: AtomicBool = AtomicBool::new(false);
static NEXT_REPLY: AtomicU32 = AtomicU32::new(1);
static TALLY: Mutex<Tally> = Mutex::new(Tally::new());

struct Tally {
    sent: u32,
    ok: u32,
    errors: Vec<String>,
    pending: Vec<u8>,
}

impl Tally {
    const fn new() -> Self {
        Self {
            sent: 0,
            ok: 0,
            errors: Vec::new(),
            pending: Vec::new(),
        }
    }

    fn note_bytes(&mut self, chunk: &[u8]) {
        self.pending.extend_from_slice(chunk);
        self.drain_replies();
        if self.pending.len() > (1 << 20) {
            let drop = self.pending.len() - (1 << 16);
            self.pending.drain(..drop);
        }
    }

    fn drain_replies(&mut self) {
        let mut bodies = Vec::new();
        let mut consumed = 0;
        let mut i = 0;
        while i + 1 < self.pending.len() {
            if self.pending[i] == 0x1b && self.pending[i + 1] == b'_' {
                match find_st(&self.pending[i + 2..]) {
                    Some(rel) => {
                        let start = i + 2;
                        let end = start + rel;
                        if end + 1 < self.pending.len()
                            && self.pending[end] == 0x1b
                            && self.pending[end + 1] == b'\\'
                        {
                            bodies.push(self.pending[start..end].to_vec());
                            i = end + 2;
                            consumed = i;
                            continue;
                        }
                    }
                    None => break,
                }
            }
            i += 1;
        }
        if consumed > 0 {
            self.pending.drain(..consumed);
        }
        for body in bodies {
            self.classify(&body);
        }
    }

    fn classify(&mut self, body: &[u8]) {
        let text = String::from_utf8_lossy(body);
        if let Some(rest) = text.strip_prefix("glass;") {
            let mut parts = rest.splitn(3, ';');
            let _token = parts.next();
            let status = parts.next().unwrap_or("");
            self.note_status(status);
        } else if let Some(rest) = text.strip_prefix("Gi=")
            && let Some((_, status)) = rest.split_once(';')
        {
            self.note_status(status);
        }
    }

    fn note_status(&mut self, status: &str) {
        if status == "OK" || status.starts_with("OK;") {
            self.ok += 1;
        } else if !status.is_empty() {
            let code = status.split(':').next().unwrap_or(status);
            let message = status.split_once(':').map(|(_, m)| m).unwrap_or("");
            if message.is_empty() {
                self.errors.push(code.to_string());
            } else {
                self.errors.push(format!("{code}:{message}"));
            }
        }
    }

    fn summary(&self) -> String {
        let errors = if self.errors.is_empty() {
            "none".to_string()
        } else {
            self.errors.join(", ")
        };
        format!(
            "glass_sampler --check: ops sent {}, OK {}, errors {}",
            self.sent, self.ok, errors
        )
    }
}

fn find_st(buf: &[u8]) -> Option<usize> {
    let mut i = 0;
    while i + 1 < buf.len() {
        if buf[i] == 0x1b && buf[i + 1] == b'\\' {
            return Some(i);
        }
        i += 1;
    }
    None
}

fn checking() -> bool {
    CHECK.load(Ordering::Relaxed)
}

fn note_sent() {
    if let Ok(mut tally) = TALLY.lock() {
        tally.sent += 1;
    }
}

fn note_input(chunk: &[u8]) {
    if !checking() {
        return;
    }
    if let Ok(mut tally) = TALLY.lock() {
        tally.note_bytes(chunk);
    }
}

fn finish_check(rx: &Receiver<Vec<u8>>) {
    if !checking() {
        return;
    }
    let end = Instant::now() + Duration::from_millis(300);
    while Instant::now() < end {
        match rx.recv_timeout(Duration::from_millis(40)) {
            Ok(chunk) => note_input(&chunk),
            Err(mpsc::RecvTimeoutError::Timeout) => continue,
            Err(mpsc::RecvTimeoutError::Disconnected) => break,
        }
    }
    let line = TALLY
        .lock()
        .map(|tally| tally.summary())
        .unwrap_or_else(|_| "glass_sampler --check: ops sent 0, OK 0, errors tally poisoned".into());
    eprintln!("{line}");
}
/// Picture the chart panel shows. Uploaded with `picture`, opened with `chart;p=`.
const CHART_PICTURE: u32 = 11;

const CLOSING: &str = "every dialect, expanded into layers";

/// The window the probe measured. Pictures are sized from this, never
/// from a hardcoded thumbnail.
#[derive(Clone, Copy)]
struct Fit {
    rows: u16,
    cols: u16,
    cell_w: u32,
    cell_h: u32,
}

impl Fit {
    fn screen_w(self) -> u32 {
        u32::from(self.cols).saturating_mul(self.cell_w).max(1)
    }

    fn screen_h(self) -> u32 {
        u32::from(self.rows).saturating_mul(self.cell_h).max(1)
    }

    /// A main picture: `frac` of the screen width, held in 40–60%, never
    /// past the screen. `floor` applies only when it still fits.
    fn picture(self, frac: f32, aspect: f32, floor_w: u32, floor_h: u32) -> (u32, u32) {
        let sw = self.screen_w();
        let sh = self.screen_h();
        let frac = frac.clamp(0.40, 0.60);
        let mut w = (sw as f32 * frac).round() as u32;
        if floor_w > 0 && floor_w <= sw {
            w = w.max(floor_w);
        }
        w = w.min(sw).max(1);
        let mut h = (w as f32 * aspect).round() as u32;
        if floor_h > 0 && floor_h <= sh {
            h = h.max(floor_h);
        }
        h = h.min(sh).max(1);
        (w, h)
    }

    /// Cell box for a picture the terminal scales into cells. The width
    /// is `frac` of the columns, held in 40–60%, and it never passes the
    /// screen.
    fn cell_box(self, frac: f32, aspect: f32) -> (u32, u32) {
        let cols = u32::from(self.cols).max(1);
        let rows = u32::from(self.rows).max(1);
        let frac = frac.clamp(0.40, 0.60);
        let c = ((cols as f32) * frac).round() as u32;
        let c = c.clamp(1, cols);
        let mut r = ((c as f32) * aspect * self.cell_w.max(1) as f32 / self.cell_h.max(1) as f32)
            .round() as u32;
        r = r.clamp(1, rows);
        (c, r)
    }
}

struct Tty {
    saved: Option<std::process::Output>,
}

impl Tty {
    fn raw() -> Self {
        let saved = Command::new("stty")
            .arg("-g")
            .stdin(Stdio::inherit())
            .output()
            .ok();
        let _ = Command::new("stty")
            .args(["raw", "-echo"])
            .stdin(Stdio::inherit())
            .status();
        Self { saved }
    }
}

impl Drop for Tty {
    fn drop(&mut self) {
        clean_up();
        if let Some(saved) = self.saved.take() {
            let _ = Command::new("stty")
                .arg(String::from_utf8_lossy(&saved.stdout).trim())
                .stdin(Stdio::inherit())
                .status();
        }
    }
}

fn out(bytes: &[u8]) {
    let mut stdout = io::stdout().lock();
    let _ = stdout.write_all(bytes);
    let _ = stdout.flush();
}

fn emit(bytes: &[u8]) {
    let mut stdout = io::stdout().lock();
    let _ = stdout.write_all(bytes);
    let _ = stdout.flush();
}

fn clean_up() {
    out(b"\x1b[0m\x1b[?25h\x1b[?1049l");
    apc("a=d,d=A,q=2", &[]);
    for id in [1, 2, 3, 4, 5, 9] {
        apc(&format!("a=d,i={id},q=2"), &[]);
    }
    close_showcase_if_open();
    glass(&remove_all_op());
    out(b"\n");
}

fn main() {
    CHECK.store(
        std::env::args().any(|arg| arg == "--check"),
        Ordering::Relaxed,
    );
    let tty = Tty::raw();
    // Size the fallback before the reader owns stdin. After this, nothing
    // else reads stdin: the probe and the scenes take bytes from the channel.
    let (rows, cols) = stty_size();
    let (tx, rx) = mpsc::channel();
    thread::spawn(move || read_stdin(tx));
    emit(b"\x1b[?1049h\x1b[?25l");
    if let Some(fit) = probe(&rx, rows, cols) {
        if !show(&rx, fit) {
            hold(&rx, 400);
        }
    } else {
        out(b"glass_sampler: not running inside glass; nothing drawn.\r\n");
    }
    drop(tty);
    finish_check(&rx);
}

/// The only reader of stdin. Every byte is forwarded. A second read would
/// race this one and could swallow the probe's replies for good.
fn read_stdin(tx: mpsc::Sender<Vec<u8>>) {
    let mut stdin = io::stdin();
    let mut buf = [0u8; 256];
    loop {
        match stdin.read(&mut buf) {
            Ok(0) => break,
            Ok(n) => {
                if tx.send(buf[..n].to_vec()).is_err() {
                    break;
                }
            }
            Err(err) if err.kind() == io::ErrorKind::Interrupted => continue,
            Err(_) => break,
        }
    }
}

fn stty_size() -> (u16, u16) {
    let Ok(output) = Command::new("stty").arg("size").output() else {
        return (24, 80);
    };
    let Ok(text) = String::from_utf8(output.stdout) else {
        return (24, 80);
    };
    let mut parts = text.split_whitespace();
    let rows = parts.next().and_then(|s| s.parse().ok()).unwrap_or(24).max(1);
    let cols = parts.next().and_then(|s| s.parse().ok()).unwrap_or(80).max(1);
    (rows, cols)
}

/// DA1, XTWINOPS 18 (rows and columns) and XTWINOPS 16 (one cell in
/// pixels). A size report or `hello` means glass. Cell size falls back
/// to 10×20 when 16 is not answered. Replies come from the stdin channel
/// with `recv_timeout`, so the deadline is a real bound: a second reader
/// cannot swallow the burst, and this function never reads stdin. `q` or
/// Ctrl+C leaves before any picture. A late reply or a focus report does not.
fn probe(rx: &Receiver<Vec<u8>>, fallback_rows: u16, fallback_cols: u16) -> Option<Fit> {
    emit(b"\x1b[c\x1b[>c\x1b[18t\x1b[16t");
    let deadline = Instant::now() + Duration::from_millis(PROBE_MS);
    let mut seen = Vec::new();
    let mut glass_at: Option<Instant> = None;
    loop {
        let now = Instant::now();
        if now >= deadline {
            break;
        }
        let wait_until = match glass_at {
            Some(started) => deadline.min(started + Duration::from_millis(120)),
            None => deadline,
        };
        if now >= wait_until {
            break;
        }
        match rx.recv_timeout(wait_until.saturating_duration_since(now)) {
            Ok(chunk) => {
                if wants_quit(&chunk) {
                    return None;
                }
                seen.extend_from_slice(&chunk);
                if from_glass(&seen) {
                    let started = *glass_at.get_or_insert_with(Instant::now);
                    if cell_from(&seen).is_some() || started.elapsed() >= Duration::from_millis(120) {
                        return Some(fit_from(&seen, fallback_rows, fallback_cols));
                    }
                }
            }
            Err(mpsc::RecvTimeoutError::Timeout) | Err(mpsc::RecvTimeoutError::Disconnected) => break,
        }
    }
    if !from_glass(&seen) {
        return None;
    }
    Some(fit_from(&seen, fallback_rows, fallback_cols))
}

fn fit_from(seen: &[u8], fallback_rows: u16, fallback_cols: u16) -> Fit {
    let (rows, cols) = area_from(seen).unwrap_or((fallback_rows, fallback_cols));
    let (cell_w, cell_h) = cell_from(seen).unwrap_or((FALLBACK_CELL_W, FALLBACK_CELL_H));
    Fit {
        rows: rows.max(1),
        cols: cols.max(1),
        cell_w,
        cell_h,
    }
}

fn from_glass(seen: &[u8]) -> bool {
    seen.windows(HELLO.len()).any(|w| w == HELLO)
        || seen.windows(5).any(|w| w == b"hello")
        || area_from(seen).is_some()
}

fn find_seq(hay: &[u8], needle: &[u8]) -> Option<usize> {
    hay.windows(needle.len()).position(|w| w == needle)
}

fn area_from(seen: &[u8]) -> Option<(u16, u16)> {
    let start = find_seq(seen, b"\x1b[8;")?;
    let rest = &seen[start + 4..];
    let end = rest.iter().position(|b| *b == b't')?;
    let text = std::str::from_utf8(&rest[..end]).ok()?;
    let mut parts = text.split(';');
    let rows: u16 = parts.next()?.parse().ok()?;
    let cols: u16 = parts.next()?.parse().ok()?;
    if rows == 0 || cols == 0 {
        None
    } else {
        Some((rows, cols))
    }
}

/// XTWINOPS 16 answers `CSI 6 ; height ; width t`. A wild reply falls
/// back to 10×20 rather than sizing a picture off the screen.
fn cell_from(seen: &[u8]) -> Option<(u32, u32)> {
    let start = find_seq(seen, b"\x1b[6;")?;
    let rest = &seen[start + 4..];
    let end = rest.iter().position(|b| *b == b't')?;
    let text = std::str::from_utf8(&rest[..end]).ok()?;
    let mut parts = text.split(';');
    let h: u32 = parts.next()?.parse().ok()?;
    let w: u32 = parts.next()?.parse().ok()?;
    if (1..=64).contains(&w) && (1..=128).contains(&h) {
        Some((w, h))
    } else {
        None
    }
}

/// `q` or Ctrl+C, and only outside a control sequence. A late size reply,
/// a glass answer, or a focus report (`ESC [ I`, `ESC [ O`) is not a quit.
fn wants_quit(chunk: &[u8]) -> bool {
    let mut i = 0;
    while i < chunk.len() {
        match chunk[i] {
            3 => return true,
            0x1b => i = skip_control(chunk, i),
            b'q' => return true,
            _ => i += 1,
        }
    }
    false
}

fn skip_control(chunk: &[u8], start: usize) -> usize {
    let mut i = start + 1;
    if i >= chunk.len() {
        return i;
    }
    match chunk[i] {
        b'[' => {
            i += 1;
            while i < chunk.len() && !is_csi_final(chunk[i]) {
                if chunk[i] == 3 {
                    return i;
                }
                i += 1;
            }
            if i < chunk.len() {
                i += 1;
            }
            i
        }
        b']' => skip_until_st(chunk, i + 1, true),
        b'_' | b'P' | b'X' | b'^' => skip_until_st(chunk, i + 1, false),
        _ => i + 1,
    }
}

fn is_csi_final(byte: u8) -> bool {
    (0x40..=0x7e).contains(&byte)
}

fn skip_until_st(chunk: &[u8], mut i: usize, bel: bool) -> usize {
    while i < chunk.len() {
        if chunk[i] == 3 {
            return i;
        }
        if chunk[i] == 0x1b && chunk.get(i + 1) == Some(&b'\\') {
            return i + 2;
        }
        if bel && chunk[i] == 0x07 {
            return i + 1;
        }
        i += 1;
    }
    i
}

fn quit(rx: &Receiver<Vec<u8>>) -> bool {
    let mut stop = false;
    while let Ok(chunk) = rx.try_recv() {
        note_input(&chunk);
        if wants_quit(&chunk) {
            stop = true;
        }
    }
    stop
}

fn hold(rx: &Receiver<Vec<u8>>, ms: u64) -> bool {
    let end = Instant::now() + Duration::from_millis(ms);
    while Instant::now() < end {
        if quit(rx) {
            return true;
        }
        thread::sleep(Duration::from_millis(20));
    }
    quit(rx)
}

fn show(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    scene_text(rx, fit)
        || scene_sixel(rx, fit)
        || scene_apc(rx, fit)
        || scene_placeholders(rx, fit)
        || scene_osc1337(rx, fit)
        || scene_animation(rx, fit)
        || scene_glass(rx, fit)
}

fn retire() {
    // A showcase closes only when one is open, and only as its scene
    // ends — the next scene's retire is that moment. Closing when none
    // is open makes the following chart open onto a refused panel.
    close_showcase_if_open();
    glass(&remove_all_op());
    apc("a=d,d=A,q=2", &[]);
    clear_screen();
}

fn scene_text(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    retire();
    gradient_title(fit, "glass");
    cup(4, 2);
    styled(b"\x1b[2m");
    out(b"every dialect a program speaks, expanded into layers");
    styled(b"\x1b[0m");
    let styles: &[(&str, &str, &[u8])] = &[
        ("bold", "BOLD", b"\x1b[1m"),
        ("dim", "dim", b"\x1b[2m"),
        ("italic", "italic", b"\x1b[3m"),
        ("under", "under", b"\x1b[4m"),
        ("strike", "strike", b"\x1b[9m"),
        ("reverse", "reverse", b"\x1b[7m"),
        ("curly", "curly", b"\x1b[38;2;120;220;255m\x1b[4:3m"),
        ("colour", "colour", b"\x1b[4m\x1b[58;2;255;96;32m"),
    ];
    let n = styles.len() as u16;
    let col_w = (fit.cols / n.max(1)).max(8);
    for (i, (label, sample, seq)) in styles.iter().enumerate() {
        let x = 2 + i as u16 * col_w;
        if x + 6 >= fit.cols {
            break;
        }
        cup(7, x);
        styled(b"\x1b[2m");
        out(label.as_bytes());
        styled(b"\x1b[0m");
        cup(9, x);
        styled(seq);
        out(sample.as_bytes());
        styled(b"\x1b[0m");
    }
    caption(fit, "curly is SGR 4:3; the coloured underline is SGR 58");
    if hold(rx, HOLD_TEXT) {
        return true;
    }
    for (i, shape) in [2u8, 4, 6].into_iter().enumerate() {
        cup(12, 2 + i as u16 * 18);
        out(format!("\x1b[{shape} q").as_bytes());
        out(match shape {
            2 => b"block  " as &[u8],
            4 => b"under  ",
            _ => b"bar",
        });
        if hold(rx, HOLD_CURSOR) {
            return true;
        }
    }
    out(b"\x1b[2 q");
    false
}

fn gradient_title(fit: Fit, title: &str) {
    let cols = fit.cols.max(1);
    let start = cols.saturating_sub(title.len() as u16) / 2;
    for band in 1..=3u16 {
        cup(band, 1);
        for col in 1..=cols {
            let t = f32::from(col - 1) / f32::from(cols);
            let r = (28.0 + 200.0 * t) as u8;
            let g = (24.0 + 90.0 * (1.0 - (t - 0.5).abs() * 2.0)) as u8;
            let b = (150.0 - 110.0 * t) as u8;
            out(format!("\x1b[48;2;{r};{g};{b}m").as_bytes());
            if band == 2 && col > start && (col - start) as usize <= title.len() {
                let ch = title.as_bytes()[(col - start - 1) as usize];
                out(b"\x1b[1;38;2;255;248;236m");
                out(&[ch]);
            } else {
                out(b" ");
            }
        }
        out(b"\x1b[0m");
    }
}

fn scene_sixel(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    // Build the picture before retire, so the previous scene stays up
    // while the plasma is drawn and is not cleared early.
    let (w, h) = fit.picture(0.50, 0.50, 480, 240);
    let (w, h, _) = clamp_in_cell_pixels(fit, 5, w, h);
    let rgba = plasma(w, h);
    let sixel = encode_sixel(w, h, &rgba);
    retire();
    title("DCS sixel", "a full-colour plasma, 64 colours, ordered dither");
    cup(5, 2);
    out(&sixel);
    // The sixel is in-cell: a later write on its rows hides those cells.
    // The caption sits below the rectangle; the cursor moves with CUP only.
    caption_below(
        fit,
        5,
        h.div_ceil(fit.cell_h.max(1)),
        fit.rows.saturating_sub(1).max(1),
        "sized from the window, at least 480x240 when it fits",
    );
    hold(rx, HOLD_SIXEL)
}

fn scene_apc(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    let (c, r) = fit.cell_box(0.48, 0.70);
    let r = r.min(u32::from(fit.rows).saturating_sub(6)).max(4);
    let w = (c * fit.cell_w).clamp(1, 640);
    let h = (r * fit.cell_h).clamp(1, 400);
    let glow = glow(w, h);
    retire();
    title("APC graphics", "a round glow, once under the text and once over it");
    apc(&format!("a=t,i=1,f=32,q=2,s={w},v={h}"), &glow);
    let paragraph = [
        "Glass takes in every dialect a program speaks and expands",
        "it into layers. This paragraph is real text, not a caption",
        "parked under a thumbnail. The glow is a radial gradient",
        "whose alpha falls off to nothing at the round edge.",
    ];
    paint_paragraph(6, 4, &paragraph);
    cup(6, 4);
    apc(&format!("a=p,i=1,z=-1,c={c},r={r},q=2,C=1"), &[]);
    caption(fit, "z<0  the text reads on top of the glow");
    if hold(rx, HOLD_APC_UNDER) {
        return true;
    }
    title("APC graphics", "the same glow, now in front of the text");
    paint_paragraph(6, 4, &paragraph);
    cup(6, 4);
    apc(&format!("a=p,i=1,z=1,c={c},r={r},q=2,C=1"), &[]);
    caption(fit, "z>0  the glow veils the text");
    if hold(rx, HOLD_APC_OVER) {
        return true;
    }
    title("APC graphics", "source and crop, side by side");
    let each = (u32::from(fit.cols) * 3 / 10).max(6);
    let each_r = r.min(u32::from(fit.rows).saturating_sub(6)).max(4);
    cup(5, 2);
    apc(&format!("a=p,i=1,c={each},r={each_r},q=2,C=1"), &[]);
    let right = 2 + each as u16 + 2;
    cup(5, right);
    let crop_x = w / 5;
    let crop_y = h / 5;
    let crop_w = (w / 2).max(1);
    let crop_h = (h / 2).max(1);
    apc(
        &format!("a=p,i=1,c={each},r={each_r},x={crop_x},y={crop_y},w={crop_w},h={crop_h},q=2"),
        &[],
    );
    caption(fit, "left: the source    right: a crop, scaled into the same box");
    hold(rx, HOLD_APC_CROP)
}

fn paint_paragraph(row: u16, col: u16, lines: &[&str]) {
    for (i, line) in lines.iter().enumerate() {
        cup(row + i as u16, col);
        styled(b"\x1b[38;2;236;232;220m");
        out(line.as_bytes());
        styled(b"\x1b[0m");
    }
}

fn scene_placeholders(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    let cols = u32::from(fit.cols).max(1);
    let rows = u32::from(fit.rows).max(1);
    let marks = MARKS.len() as u32;
    let mut grid_c = ((cols as f32) * 0.48).round() as u32;
    grid_c = grid_c.clamp(16.min(cols).max(1), marks.min(cols));
    let mut grid_r = 8u32;
    grid_r = grid_r.min(marks).min(rows.saturating_sub(4).max(1));
    if grid_r < 6 && rows >= 6 {
        grid_r = 6.min(rows);
    }
    // Leave a caption row below the grid. The placeholder cells themselves
    // are the text the picture rides; nothing else is written on them.
    let top = rows.saturating_sub(grid_r).saturating_sub(2).max(4);
    let room = rows.saturating_sub(top).saturating_sub(1).max(1);
    grid_r = grid_r.min(room).max(1);
    let top = top as u16;
    let pw = grid_c.saturating_mul(fit.cell_w).clamp(1, 4096);
    let ph = grid_r.saturating_mul(fit.cell_h).clamp(1, 4096);
    let rgba = blocks(pw, ph);
    retire();
    title("Unicode placeholders", "a gradient with an outline, riding the text");
    cup(top, 2);
    apc(
        &format!("a=T,i=3,z=-1,f=32,q=2,s={pw},v={ph},c={grid_c},r={grid_r}"),
        &rgba,
    );
    for row in 0..grid_r {
        cup(top + row as u16, 2);
        for col in 0..grid_c {
            out(placeholder_cell(row as usize, col as usize).as_bytes());
        }
    }
    caption_below(
        fit,
        top,
        grid_r,
        fit.rows.saturating_sub(1).max(1),
        "the picture rides the text and scrolls up with the lines",
    );
    if hold(rx, HOLD_PLACE) {
        return true;
    }
    let steps = SCROLL_LINES.min(u64::from(rows.saturating_sub(2)));
    for _ in 0..steps {
        out(b"\n");
        if hold(rx, HOLD_SCROLL) {
            return true;
        }
    }
    hold(rx, HOLD_SCROLL_REST)
}

fn scene_osc1337(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    let (c, r) = fit.cell_box(0.50, 0.62);
    let (c, r, _) = in_cell_span(fit, 5, c, r);
    let w = (c * fit.cell_w).clamp(1, 720);
    let h = (r * fit.cell_h).clamp(1, 480);
    let rgba = sphere(w, h);
    let bmp = write_bmp(w, h, &rgba);
    let name = b64(b"sphere.bmp");
    let record = format!(
        "\x1b]1337;File=name={name};inline=1;width={c};height={r};preserveAspectRatio=1:{}\x07",
        b64(&bmp)
    );
    retire();
    title("OSC 1337", "a lit sphere, specular highlight, gradient sky");
    cup(5, 2);
    out(record.as_bytes());
    // Inline images are in-cell. The caption goes below the cell
    // rectangle; nothing else is written on those rows.
    caption_below(
        fit,
        5,
        r,
        fit.rows.saturating_sub(1).max(1),
        "inline BMP, sized from the window",
    );
    hold(rx, HOLD_OSC)
}

fn scene_animation(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    let (c, r) = fit.cell_box(0.42, 1.0);
    let r = r.min(u32::from(fit.rows).saturating_sub(6)).max(1);
    let size = (c * fit.cell_w)
        .min(r * fit.cell_h)
        .min(420)
        .max(200.min(fit.screen_w()))
        .min(fit.screen_w())
        .min(fit.screen_h())
        .max(1);
    let frames: Vec<Vec<u8>> = (0..ANIM_FRAMES).map(|i| sprite(i, ANIM_FRAMES, size)).collect();
    retire();
    title("Animation", "a bouncing ball, twelve frames, eighty milliseconds");
    // Frame 1 is transmit-and-place. `c` and `r` here are columns and
    // rows. Later `a=a` uses those keys as frame numbers, not a placement.
    cup(5, 2);
    apc(
        &apc_transmit_place(5, size, size, c, r, true),
        frames.first().map(Vec::as_slice).unwrap_or(&[]),
    );
    for frame in frames.iter().skip(1) {
        apc(&apc_anim_frame(5, size, size, ANIM_GAP_MS, true), frame);
    }
    apc(&apc_frame_gap(5, 1, ANIM_GAP_MS, true), &[]);
    // `v=5` shows the first frame five times: four full loops, then rest.
    // No `c` or `r`: those are frame numbers on `a=a`, not a placement.
    apc(&apc_anim_run(5, 5, true), &[]);
    caption_below(fit, 5, r, fit.rows.saturating_sub(1).max(1), "four loops, eighty milliseconds");
    hold(rx, HOLD_ANIM)
}

fn scene_glass(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    if scene_glow(rx, fit) || scene_particles(rx, fit) || scene_prim(rx, fit) {
        return true;
    }
    if turn_cube(rx, fit) || animate_group(rx, fit) || scene_chart(rx, fit) {
        return true;
    }
    if scene_video(rx, fit) {
        return true;
    }
    scene_close(rx, fit)
}

fn scene_glow(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    retire();
    title("glass dialect", "a soft glow");
    let (c, r) = fit.cell_box(0.40, 0.55);
    let x = (u32::from(fit.cols).saturating_sub(c) / 2).max(1);
    glass(&layer_glow(1, "ffb040", "0.85", &format!("{x},5,{c},{r}")));
    caption(fit, "k=glow");
    hold(rx, HOLD_GLOW)
}

fn scene_particles(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    retire();
    title("glass dialect", "bright particles");
    let (c, r) = fit.cell_box(0.55, 0.40);
    let x = (u32::from(fit.cols).saturating_sub(c) / 2).max(1);
    glass(&layer_particles(2, "ffb040", 280, 8, "2.6", 42, 22, &format!("{x},6,{c},{r}")));
    glass(&layer_particles(3, "ff6030", 180, 10, "2.2", 28, 16, &format!("{x},8,{c},{r}")));
    glass(&layer_particles(4, "fff2c0", 140, 6, "1.8", 50, 30, &format!("{x},7,{c},{r}")));
    caption(fit, "warm, larger, and more of them");
    hold(rx, HOLD_PARTICLES)
}

fn scene_prim(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    retire();
    title("glass dialect", "lit shapes");
    let w = (u32::from(fit.cols) as f32 * 0.16).round() as u32;
    let w = w.clamp(8, u32::from(fit.cols) / 3);
    let h = (w as f32 * 0.6).round() as u32;
    let h = h.clamp(4, u32::from(fit.rows).saturating_sub(8));
    glass(&layer_prim(5, 0, "ff8050", &format!("8,6,{w},{h}")));
    glass(&layer_prim(6, 1, "70c8ff", &format!("12,8,{w},{h}")));
    caption(fit, "rect and circle");
    hold(rx, HOLD_PRIM)
}

fn turn_cube(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    retire();
    title("glass dialect", "a lit cube, turning the whole time");
    let (c, r) = fit.cell_box(0.46, 0.75);
    let r = r.min(u32::from(fit.rows).saturating_sub(6)).max(6);
    let x = (u32::from(fit.cols).saturating_sub(c) / 2).max(1);
    let s = (c * fit.cell_w).clamp(160, 1024);
    let v = (r * fit.cell_h).clamp(120, 1024);
    let start = Instant::now();
    let mut frame = 0u32;
    while start.elapsed() < Duration::from_millis(HOLD_CUBE) {
        if quit(rx) {
            return true;
        }
        let half = frame as f32 * 0.12;
        glass(&scene_op(8, s, v, &format!("{x},5,{c},{r}"), &b64(&scene_bytes(half))));
        frame += 1;
        if hold(rx, 33) {
            return true;
        }
    }
    false
}

fn scene_bytes(half: f32) -> Vec<u8> {
    let (sy, sw) = half.sin_cos();
    format!(
        r#"{{"v":1,"scene":{{"camera":{{"eye":[2.2,1.6,2.6]}},"nodes":[{{"id":1,"mesh":"cube","color":[0.95,0.55,0.22,1],"lit":true,"rot":[0,{sy:.4},0,{sw:.4}]}}]}}}}"#
    )
    .into_bytes()
}

fn animate_group(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    retire();
    title("glass dialect", "coloured layers orbiting the caption");
    let colors = ["ff5a4a", "ffb020", "ffe070", "7dffb0", "60c8ff", "c080ff", "ff70c0"];
    let cx = f32::from(fit.cols) * 0.50;
    let cy = f32::from(fit.rows) * 0.46;
    let radius = (f32::from(fit.cols) * 0.18).max(8.0);
    cup(cy as u16, (cx as u16).saturating_sub(4));
    styled(b"\x1b[1;38;2;255;244;220m");
    out(b"orbit");
    styled(b"\x1b[0m");
    let start = Instant::now();
    let mut frame = 0u32;
    while start.elapsed() < Duration::from_millis(HOLD_GROUP) {
        if quit(rx) {
            return true;
        }
        let mut records = String::new();
        for (i, color) in colors.iter().enumerate() {
            let ang = frame as f32 * 0.22 + i as f32 * std::f32::consts::TAU / colors.len() as f32;
            let x = (cx + ang.cos() * radius - 3.0).max(1.0);
            let y = (cy + ang.sin() * radius * 0.40 - 1.0).max(4.0);
            if i > 0 {
                records.push('\n');
            }
            records.push_str(&layer_solid(
                20 + i as u32,
                color,
                &format!("{x:.1},{y:.1},6,2"),
            ));
        }
        glass(&group_op(1, colors.len() as u32, &b64(records.as_bytes())));
        frame += 1;
        if hold(rx, 40) {
            return true;
        }
    }
    false
}

fn scene_chart(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    let (w, h) = chart_panel(fit);
    let (rgba, marks) = bar_chart(w, h);
    let (picture, chart) = chart_upload(CHART_PICTURE, &rgba, w, h, &marks);
    retire();
    title("glass dialect", "a chart");
    glass(&picture);
    glass(&chart);
    mark_showcase_open();
    caption(fit, "picture uploaded, chart open");
    hold(rx, HOLD_CHART)
}

fn scene_video(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    let (panel_w, panel_h) = video_panel(fit);
    // First frame before retire, so the chart stays up while it is built
    // and the panel is not opened onto a cleared screen.
    let first = video_frame(0, VIDEO_FRAMES, panel_w, panel_h);
    retire();
    title("glass dialect", "a video showcase, plasma across the frame");
    // No id: with id, showcase shows a picture. A video panel is size only.
    // frame takes no id here — id would name an uploaded picture.
    open_showcase(&showcase_video(panel_w, panel_h));
    glass(&frame_op(32, panel_w, panel_h, &b64(&first)));
    glass(&progress_op(0.0));
    if hold(rx, HOLD_FRAME) {
        return true;
    }
    for i in 1..VIDEO_FRAMES {
        let frame = video_frame(i, VIDEO_FRAMES, panel_w, panel_h);
        glass(&frame_op(32, panel_w, panel_h, &b64(&frame)));
        let t = if VIDEO_FRAMES <= 1 {
            1.0
        } else {
            i as f32 / (VIDEO_FRAMES - 1) as f32
        };
        glass(&progress_op(t));
        if hold(rx, HOLD_FRAME) {
            return true;
        }
    }
    false
}

fn scene_close(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    close_showcase_if_open();
    glass(&remove_all_op());
    apc("a=d,d=A,q=2", &[]);
    clear_screen();
    title("Sampler", CLOSING);
    caption(fit, "showcase closed");
    if hold(rx, HOLD_CLOSE) {
        return true;
    }
    scene_finale(rx, fit)
}

fn scene_finale(rx: &Receiver<Vec<u8>>, fit: Fit) -> bool {
    let (c, r) = fit.cell_box(0.58, 0.55);
    let r = r.min(u32::from(fit.rows).saturating_sub(2)).max(4);
    let w = (c * fit.cell_w).clamp(1, 640);
    let h = (r * fit.cell_h).clamp(1, 360);
    let pic = plasma(w, h);
    clear_screen();
    cup(3, 2);
    apc(
        &format!("a=T,i=9,z=-1,f=32,q=2,s={w},v={h},c={c},r={r},C=1"),
        &pic,
    );
    let line = "glass";
    let x = fit.cols.saturating_sub(line.len() as u16) / 2;
    cup(4, x.max(1));
    styled(b"\x1b[1;38;2;255;248;236m");
    for ch in line.chars() {
        out(format!("{ch} ").as_bytes());
    }
    styled(b"\x1b[0m");
    let cube_c = (u32::from(fit.cols) as f32 * 0.28) as u32;
    let cube_c = cube_c.clamp(10, u32::from(fit.cols) / 2);
    let cube_r = (cube_c as f32 * 0.55) as u32;
    let cube_r = cube_r.clamp(6, u32::from(fit.rows).saturating_sub(6));
    let cube_x = u32::from(fit.cols).saturating_sub(cube_c).saturating_sub(2).max(1);
    let s = (cube_c * fit.cell_w).clamp(160, 800);
    let v = (cube_r * fit.cell_h).clamp(120, 640);
    glass(&layer_glow(
        30,
        "ffb050",
        "0.7",
        &format!(
            "4,3,{},{}",
            (u32::from(fit.cols) / 3).max(8),
            (u32::from(fit.rows) / 4).max(4)
        ),
    ));
    let (pc, pr) = fit.cell_box(0.50, 0.30);
    glass(&layer_particles(31, "ffc060", 240, 7, "2.4", 36, 20, &format!("2,8,{pc},{pr}")));
    glass(&layer_particles(32, "fff0c8", 120, 5, "1.6", 48, 26, &format!("4,10,{pc},{pr}")));
    let start = Instant::now();
    let mut frame = 0u32;
    while start.elapsed() < Duration::from_millis(HOLD_FINALE) {
        if quit(rx) {
            return true;
        }
        let half = frame as f32 * 0.10;
        glass(&scene_op(
            8,
            s,
            v,
            &format!("{cube_x},6,{cube_c},{cube_r}"),
            &b64(&scene_bytes(half)),
        ));
        frame += 1;
        if hold(rx, 33) {
            return true;
        }
    }
    false
}

fn title(head: &str, sub: &str) {
    cup(1, 2);
    styled(b"\x1b[1;38;2;255;244;220m");
    out(head.as_bytes());
    styled(b"\x1b[0m");
    cup(2, 2);
    styled(b"\x1b[2m");
    out(sub.as_bytes());
    styled(b"\x1b[0m");
}

fn caption(fit: Fit, line: &str) {
    cup(fit.rows.saturating_sub(1).max(1), 2);
    styled(b"\x1b[38;2;180;190;210m");
    out(line.as_bytes());
    styled(b"\x1b[0m");
}

fn styled(bytes: &[u8]) {
    out(bytes);
}

fn cup(row: u16, col: u16) {
    out(format!("\x1b[{};{}H", row.max(1), col.max(1)).as_bytes());
}

fn clear_screen() {
    out(b"\x1b[2J\x1b[H");
}

/// Keys a glass op may carry. Mirrors the intake's `allowed_keys`.
/// A glass op never carries `q` — that key belongs to APC graphics.
#[cfg(test)]
fn glass_allowed(op: &str) -> &'static [&'static str] {
    match op {
        "picture" => &["id", "f", "s", "v", "o", "m", "r"],
        "layer" => &[
            "id", "k", "z", "o", "a", "h", "b", "add", "fl", "stand", "up", "at", "px",
            "anchor", "c", "p", "src", "n", "size", "life", "rise", "sway", "seed", "burst",
            "shape", "speed", "phase", "r", "m",
        ],
        "group" => &["g", "n", "r", "m"],
        "remove" => &["id", "g", "all", "r", "m"],
        "showcase" => &["id", "close", "s", "v", "fit", "events", "r", "m"],
        "scene" => &["id", "at", "px", "anchor", "s", "v", "z", "o", "r"],
        "frame" => &["id", "f", "s", "v", "o", "m", "r"],
        "chart" => &["p", "n", "fit", "r"],
        "model" => &["s", "v", "fit", "r"],
        "page" => &["cols", "rows", "r"],
        "progress" => &["t", "pause", "r"],
        _ => &[],
    }
}

fn picture_op(id: u32, format: u32, s: u32, v: u32, payload: &str) -> String {
    format!("picture;id={id};f={format};s={s};v={v};{payload}")
}

fn layer_glow(id: u32, color: &str, alpha: &str, at: &str) -> String {
    format!("layer;id={id};k=glow;c={color};a={alpha};at={at}")
}

#[allow(clippy::too_many_arguments)]
fn layer_particles(
    id: u32,
    color: &str,
    n: u32,
    size: u32,
    life: &str,
    rise: u32,
    sway: u32,
    at: &str,
) -> String {
    format!("layer;id={id};k=particles;c={color};n={n};size={size};life={life};rise={rise};sway={sway};at={at}")
}

fn layer_prim(id: u32, shape: u32, color: &str, at: &str) -> String {
    format!("layer;id={id};k=prim;shape={shape};c={color};at={at}")
}

fn layer_solid(id: u32, color: &str, at: &str) -> String {
    format!("layer;id={id};k=solid;c={color};at={at}")
}

fn group_op(g: u32, n: u32, payload: &str) -> String {
    format!("group;g={g};n={n};{payload}")
}

fn remove_all_op() -> String {
    "remove;all=1".to_string()
}

fn showcase_video(s: u32, v: u32) -> String {
    // `fit=contain` scales a small panel up to the showcase well.
    format!("showcase;s={s};v={v};fit=contain")
}

fn showcase_close_op() -> String {
    "showcase;close=1".to_string()
}

fn scene_op(id: u32, s: u32, v: u32, at: &str, payload: &str) -> String {
    format!("scene;id={id};s={s};v={v};at={at};{payload}")
}

fn frame_op(format: u32, s: u32, v: u32, payload: &str) -> String {
    format!("frame;f={format};s={s};v={v};{payload}")
}

fn chart_op(p: u32, n: u32, payload: &str) -> String {
    format!("chart;p={p};n={n};{payload}")
}

fn progress_op(t: f32) -> String {
    format!("progress;t={t:.3}")
}

/// `--check` appends `r=` so glass answers. The token is a key, so it
/// sits before a payload: the dialect reads the last field as the
/// payload when that field cannot be a key.
fn glass_checked(record: &str, token: u32) -> String {
    if let Some((head, payload)) = split_glass_payload(record) {
        format!("{head};r={token};{payload}")
    } else {
        format!("{record};r={token}")
    }
}

fn split_glass_payload(record: &str) -> Option<(String, String)> {
    let (op, rest) = record.split_once(';')?;
    let takes = matches!(
        op,
        "picture" | "group" | "scene" | "frame" | "chart" | "model" | "page"
    );
    if !takes {
        return None;
    }
    let fields: Vec<&str> = rest.split(';').collect();
    if fields.len() < 2 {
        return None;
    }
    let last = *fields.last()?;
    if !last.contains('=') || last.ends_with('=') {
        let head = format!("{op};{}", fields[..fields.len() - 1].join(";"));
        Some((head, last.to_string()))
    } else {
        None
    }
}

fn apc_transmit_place(id: u32, s: u32, v: u32, cols: u32, rows: u32, quiet: bool) -> String {
    let q = if quiet { ",q=2" } else { "" };
    format!("a=T,i={id},f=32,s={s},v={v},c={cols},r={rows},C=1{q}")
}

fn apc_anim_frame(id: u32, s: u32, v: u32, gap: u32, quiet: bool) -> String {
    let q = if quiet { ",q=2" } else { "" };
    format!("a=f,i={id},f=32,s={s},v={v},z={gap}{q}")
}

fn apc_frame_gap(id: u32, frame: u32, gap: u32, quiet: bool) -> String {
    let q = if quiet { ",q=2" } else { "" };
    format!("a=a,i={id},r={frame},z={gap}{q}")
}

fn apc_anim_run(id: u32, loops: u32, quiet: bool) -> String {
    let q = if quiet { ",q=2" } else { "" };
    format!("a=a,i={id},s=3,v={loops}{q}")
}

fn drop_apc_quiet(keys: &str) -> String {
    keys.split(',')
        .filter(|field| !field.is_empty() && !field.starts_with("q="))
        .collect::<Vec<_>>()
        .join(",")
}

#[cfg(test)]
fn glass_key_pairs(record: &str) -> (String, Vec<(String, String)>) {
    let mut fields: Vec<&str> = record.split(';').collect();
    let op = fields.first().copied().unwrap_or("").to_string();
    if !fields.is_empty() {
        fields.remove(0);
    }
    let takes_payload = matches!(
        op.as_str(),
        "picture" | "group" | "scene" | "frame" | "chart" | "model" | "page"
    );
    if takes_payload && fields.len() >= 2 {
        if let Some(last) = fields.last().copied() {
            if !last.contains('=') || last.ends_with('=') {
                fields.pop();
            }
        }
    }
    let mut pairs = Vec::new();
    for field in fields {
        if let Some((key, value)) = field.split_once('=') {
            pairs.push((key.to_string(), value.to_string()));
        }
    }
    (op, pairs)
}

#[cfg(test)]
fn apc_key_map(keys: &str) -> std::collections::BTreeMap<String, String> {
    let mut map = std::collections::BTreeMap::new();
    for field in keys.split(',') {
        if let Some((key, value)) = field.split_once('=') {
            map.insert(key.to_string(), value.to_string());
        } else if !field.is_empty() {
            map.insert(field.to_string(), String::new());
        }
    }
    map
}

/// The video panel is a fixed size under the frame cap, not the window.
/// `fit` on the showcase scales that picture up.
fn video_panel(_fit: Fit) -> (u32, u32) {
    (VIDEO_W, VIDEO_H)
}

fn chart_panel(fit: Fit) -> (u32, u32) {
    let (c, _r) = fit.cell_box(0.46, 0.55);
    let w = (c * fit.cell_w).clamp(1, 640);
    let h = ((w as f32) * 0.55).round() as u32;
    (w, h.clamp(1, 360).min(fit.screen_h().max(1)))
}

/// Columns and rows an in-cell picture may occupy starting at `top`
/// (1-based), leaving a row below for a caption.
fn in_cell_span(fit: Fit, top: u16, want_cols: u32, want_rows: u32) -> (u32, u32, u16) {
    let cols = want_cols
        .min(u32::from(fit.cols.saturating_sub(1)))
        .max(1);
    let room = u32::from(fit.rows.saturating_sub(top))
        .saturating_sub(1)
        .max(1);
    let rows = want_rows.min(room).max(1);
    let caption = top.saturating_add(rows as u16).min(fit.rows).max(1);
    (cols, rows, caption)
}

/// Pixel size of an in-cell picture, clamped so its cell rows end
/// above a caption row.
fn clamp_in_cell_pixels(fit: Fit, top: u16, w: u32, h: u32) -> (u32, u32, u16) {
    let cell_w = fit.cell_w.max(1);
    let cell_h = fit.cell_h.max(1);
    let max_cols = u32::from(fit.cols.saturating_sub(1)).max(1);
    let max_rows = u32::from(fit.rows.saturating_sub(top))
        .saturating_sub(1)
        .max(1);
    let w = w.min(max_cols.saturating_mul(cell_w)).max(1);
    let h = h.min(max_rows.saturating_mul(cell_h)).max(1);
    let rows = h.div_ceil(cell_h).max(1).min(max_rows);
    let caption = top.saturating_add(rows as u16).min(fit.rows).max(1);
    (w, h, caption)
}

fn caption_at(row: u16, line: &str) {
    cup(row.max(1), 2);
    styled(b"\x1b[38;2;180;190;210m");
    out(line.as_bytes());
    styled(b"\x1b[0m");
}

/// Caption below an in-cell picture. If the usual bottom row is already
/// below the rectangle, it stays there so a scene that fitted keeps its
/// look. Otherwise the caption moves to the first row under the picture.
fn caption_below(fit: Fit, top: u16, rows: u32, preferred: u16, line: &str) {
    let end = top.saturating_add(rows as u16);
    let row = if preferred >= end {
        preferred.min(fit.rows)
    } else {
        end.min(fit.rows)
    };
    caption_at(row.max(1), line);
}

fn mark_showcase_open() {
    SHOWCASE_OPEN.store(true, Ordering::Relaxed);
}

fn open_showcase(record: &str) {
    glass(record);
    mark_showcase_open();
}

fn close_showcase_if_open() {
    if SHOWCASE_OPEN.swap(false, Ordering::Relaxed) {
        glass(&showcase_close_op());
    }
}

fn glass(record: &str) {
    let record = if checking() {
        let token = NEXT_REPLY.fetch_add(1, Ordering::Relaxed);
        note_sent();
        glass_checked(record, token)
    } else {
        record.to_string()
    };
    out(format!("\x1b_glass;{record}\x1b\\").as_bytes());
}

fn apc(keys: &str, payload: &[u8]) {
    let keys = if checking() {
        note_sent();
        drop_apc_quiet(keys)
    } else {
        keys.to_string()
    };
    let mut bytes = Vec::with_capacity(keys.len() + payload.len() + 8);
    bytes.extend_from_slice(b"\x1b_G");
    bytes.extend_from_slice(keys.as_bytes());
    if !payload.is_empty() {
        bytes.push(b';');
        bytes.extend_from_slice(b64(payload).as_bytes());
    }
    bytes.extend_from_slice(b"\x1b\\");
    out(&bytes);
}


// Ordered dither to 4 levels a channel: 64 colours. The threshold is a
// 4×4 Bayer matrix, scaled to the 64-wide quantisation step.
const BAYER4: [i32; 16] = [0, 8, 2, 10, 12, 4, 14, 6, 3, 11, 1, 9, 15, 7, 13, 5];

fn quant_channel(value: u8, x: u32, y: u32) -> u8 {
    let t = BAYER4[((y & 3) * 4 + (x & 3)) as usize];
    let adjusted = i32::from(value) + t * 4 - 30;
    let level = (adjusted.clamp(0, 255) as u8) / 64;
    level * 85
}

fn dither64(rgba: &[u8], w: u32, h: u32) -> Vec<u8> {
    let w = w.max(1);
    let mut out = Vec::with_capacity(rgba.len());
    for y in 0..h {
        for x in 0..w {
            let i = ((y * w + x) * 4) as usize;
            if i + 3 >= rgba.len() {
                break;
            }
            out.extend_from_slice(&[
                quant_channel(rgba[i], x, y),
                quant_channel(rgba[i + 1], x, y),
                quant_channel(rgba[i + 2], x, y),
                rgba[i + 3],
            ]);
        }
    }
    out
}

/// A rich plasma, then ordered-dithered to 64 colours so a sixel keeps
/// the dither instead of banding. Colour is mixed in `f32`: a `u8`
/// multiply would saturate before the divide and collapse the picture.
fn plasma(w: u32, h: u32) -> Vec<u8> {
    let w = w.max(1);
    let h = h.max(1);
    let mut rgba = Vec::with_capacity((w as usize).saturating_mul(h as usize).saturating_mul(4));
    for y in 0..h {
        for x in 0..w {
            let nx = x as f32 / w as f32;
            let ny = y as f32 / h as f32;
            let v = (nx * 8.0).sin()
                + (ny * 6.5).sin()
                + ((nx + ny) * 5.0).sin() * 0.7
                + (nx * 12.0 - ny * 4.0).sin() * 0.5;
            let r = (128.0 + 120.0 * (v * 0.7).sin() + 40.0 * nx).clamp(0.0, 255.0);
            let g = (110.0 + 100.0 * (v * 0.5 + ny * 4.0).sin() + 30.0 * ny).clamp(0.0, 255.0);
            let b = (140.0 + 110.0 * (nx * 7.0 + v).cos() - 20.0 * ny).clamp(0.0, 255.0);
            rgba.extend_from_slice(&[r as u8, g as u8, b as u8, 255]);
        }
    }
    dither64(&rgba, w, h)
}

/// A radial glow. Alpha is 228 at the centre and 0 at the corner.
fn glow(w: u32, h: u32) -> Vec<u8> {
    let w = w.max(1);
    let h = h.max(1);
    let cx = (w as f32 - 1.0) * 0.5;
    let cy = (h as f32 - 1.0) * 0.5;
    let max_r = cx.hypot(cy).max(1.0);
    let mut rgba = Vec::with_capacity((w as usize).saturating_mul(h as usize).saturating_mul(4));
    for y in 0..h {
        for x in 0..w {
            let d = (x as f32 - cx).hypot(y as f32 - cy) / max_r;
            let fall = (1.0 - d).max(0.0);
            let alpha = (fall.powf(1.7) * 228.0).round() as u8;
            let g = (160.0 + 50.0 * fall).clamp(0.0, 255.0) as u8;
            rgba.extend_from_slice(&[255, g, 64, alpha]);
        }
    }
    rgba
}

/// A lit sphere with a specular highlight over a gradient sky. Lighting
/// is in `f32`, not a saturating `u8` multiply.
fn sphere(w: u32, h: u32) -> Vec<u8> {
    let w = w.max(1);
    let h = h.max(1);
    let cx = w as f32 * 0.50;
    let cy = h as f32 * 0.52;
    let rad = (w.min(h) as f32) * 0.34;
    let (lx, ly, lz) = {
        let (x, y, z) = (-0.45f32, -0.55, 0.70);
        let len = (x * x + y * y + z * z).sqrt().max(0.001);
        (x / len, y / len, z / len)
    };
    let mut rgba = Vec::with_capacity((w as usize).saturating_mul(h as usize).saturating_mul(4));
    for y in 0..h {
        for x in 0..w {
            let t = y as f32 / h as f32;
            let sky = [
                (36.0 + 50.0 * (1.0 - t)) as u8,
                (48.0 + 80.0 * (1.0 - t)) as u8,
                (110.0 + 90.0 * (1.0 - t)) as u8,
                255,
            ];
            let dx = x as f32 - cx;
            let dy = y as f32 - cy;
            let d2 = dx * dx + dy * dy;
            if rad < 1.0 || d2 > rad * rad {
                rgba.extend_from_slice(&sky);
                continue;
            }
            let dz = (rad * rad - d2).sqrt();
            let nx = dx / rad;
            let ny = dy / rad;
            let nz = dz / rad;
            let ndotl = (nx * lx + ny * ly + nz * lz).max(0.0);
            let rx = 2.0 * ndotl * nx - lx;
            let ry = 2.0 * ndotl * ny - ly;
            let rz = 2.0 * ndotl * nz - lz;
            let spec = rz.max(0.0).powf(28.0);
            let shade = 0.16 + 0.74 * ndotl;
            let r = (220.0 * shade + 255.0 * spec).min(255.0) as u8;
            let g = (140.0 * shade + 230.0 * spec).min(255.0) as u8;
            let b = (70.0 * shade + 200.0 * spec).min(255.0) as u8;
            let _ = (rx, ry);
            rgba.extend_from_slice(&[r, g, b, 255]);
        }
    }
    rgba
}

/// A gradient with a bright outline. Shade is scaled in `u32`: doing it
/// in `u8` saturates every product at 255 and the divide collapses the
/// picture to near-black.
fn blocks(w: u32, h: u32) -> Vec<u8> {
    let w = w.max(1);
    let h = h.max(1);
    let mut rgba = Vec::with_capacity((w as usize).saturating_mul(h as usize).saturating_mul(4));
    for y in 0..h {
        for x in 0..w {
            if x < 2 || y < 2 || x + 2 >= w || y + 2 >= h {
                rgba.extend_from_slice(&[255, 236, 180, 255]);
                continue;
            }
            let r = 40 + (x * 180) / w;
            let g = 36 + (y * 90) / h;
            let b = 210 - (x * 150) / w;
            let shade = 180 + (y * 40) / h;
            let scale = |c: u32| -> u8 { ((c * shade) / 220).min(255) as u8 };
            rgba.extend_from_slice(&[scale(r), scale(g), scale(b), 255]);
        }
    }
    rgba
}

/// A bouncing ball with squash on the ground. Frames differ because the
/// ball moves; colour is mixed in `f32`.
fn sprite(frame: usize, frames: usize, size: u32) -> Vec<u8> {
    let size = size.max(1);
    let mut rgba = vec![0u8; (size as usize).saturating_mul(size as usize).saturating_mul(4)];
    let frames = frames.max(1);
    let t = frame as f32 / frames as f32;
    let bounce = (t * std::f32::consts::PI).sin();
    let squash = 1.0 - bounce;
    let rx = size as f32 * (0.12 + 0.07 * squash);
    let ry = size as f32 * (0.12 - 0.05 * squash).max(0.05);
    let cx = size as f32 * (0.18 + 0.64 * t);
    let ground = size as f32 * 0.78;
    let cy = ground - bounce * size as f32 * 0.52;
    let (hr, hg, hb) = hue(frame, frames);
    for y in 0..size {
        for x in 0..size {
            let dx = (x as f32 + 0.5 - cx) / rx.max(0.5);
            let dy = (y as f32 + 0.5 - cy) / ry.max(0.5);
            if dx * dx + dy * dy <= 1.0 {
                let light = (0.55 - 0.35 * dx - 0.25 * dy).clamp(0.3, 1.0);
                let i = ((y * size + x) * 4) as usize;
                rgba[i] = (f32::from(hr) * light) as u8;
                rgba[i + 1] = (f32::from(hg) * light) as u8;
                rgba[i + 2] = (f32::from(hb) * light) as u8;
                rgba[i + 3] = 255;
            }
        }
    }
    rgba
}

fn hue(frame: usize, frames: usize) -> (u8, u8, u8) {
    let t = frame as f32 / frames.max(1) as f32;
    let r = (180.0 + 70.0 * (t * 6.0).sin()) as u8;
    let g = (120.0 + 80.0 * (t * 4.0 + 1.0).sin()) as u8;
    let b = (80.0 + 60.0 * (t * 5.0 + 2.0).sin()) as u8;
    (r, g, b)
}

/// Rotating colour bars across the whole frame, so a video showcase is
/// not an empty panel with one stripe.
fn video_frame(i: u64, frames: u64, w: u32, h: u32) -> Vec<u8> {
    let w = w.max(1);
    let h = h.max(1);
    let frames = frames.max(1);
    let shift = i as f32 / frames as f32;
    let mut rgba = Vec::with_capacity((w as usize).saturating_mul(h as usize).saturating_mul(4));
    for y in 0..h {
        for x in 0..w {
            let nx = x as f32 / w as f32;
            let ny = y as f32 / h as f32;
            let bars = ((nx * 8.0 + shift * std::f32::consts::TAU).sin() * 0.5 + 0.5).clamp(0.0, 1.0);
            let wash = (ny * 3.0 + shift * 4.0).sin() * 0.5 + 0.5;
            let r = (40.0 + 200.0 * bars + 15.0 * wash).clamp(0.0, 255.0) as u8;
            let g = (30.0 + 80.0 * wash + 40.0 * (1.0 - bars)).clamp(0.0, 255.0) as u8;
            let b = (80.0 + 140.0 * (1.0 - bars) * wash).clamp(0.0, 255.0) as u8;
            rgba.extend_from_slice(&[r, g, b, 255]);
        }
    }
    rgba
}

fn bar_chart(w: u32, h: u32) -> (Vec<u8>, String) {
    let w = w.max(1);
    let h = h.max(1);
    let heights = [0.45f32, 0.72, 0.38, 0.88, 0.56, 0.66];
    let colors = [
        [255, 120, 64],
        [255, 196, 72],
        [120, 210, 255],
        [255, 96, 140],
        [130, 230, 160],
        [200, 150, 255],
    ];
    let tips = ["one", "two", "three", "four", "five", "six"];
    let mut rgba = [16u8, 18, 28, 255].repeat((w as usize).saturating_mul(h as usize));
    let gap = (w / (heights.len() as u32 + 1)).max(1);
    let bar_w = (gap * 3 / 5).max(1);
    let mut marks = String::new();
    for (i, ((height, color), tip)) in heights.iter().zip(colors).zip(tips).enumerate() {
        let x0 = gap.saturating_mul(i as u32 + 1).saturating_sub(bar_w / 2);
        let bh = ((h as f32) * height) as u32;
        let bh = bh.max(1).min(h);
        let y0 = h.saturating_sub(bh).saturating_sub(h / 12).min(h.saturating_sub(1));
        let y1 = h.saturating_sub(h / 14).max(y0.saturating_add(1));
        let drawn = y1.saturating_sub(y0).max(1);
        for y in y0..y1 {
            for x in x0..x0.saturating_add(bar_w).min(w) {
                let p = ((y * w + x) * 4) as usize;
                if p + 3 < rgba.len() {
                    rgba[p..p + 3].copy_from_slice(&color);
                }
            }
        }
        if !marks.is_empty() {
            marks.push('\n');
        }
        marks.push_str(&format!(
            "mark;x={x0};y={y0};w={bar_w};h={drawn};t={tip}|{:.0}%",
            height * 100.0
        ));
    }
    (rgba, marks)
}

/// `picture` upload, then `chart;p=` over those pixels. `n` is the mark count.
fn chart_upload(id: u32, rgba: &[u8], w: u32, h: u32, marks: &str) -> (String, String) {
    let n = marks.lines().filter(|line| line.starts_with("mark;")).count();
    let picture = picture_op(id, 32, w, h, &b64(rgba));
    let chart = chart_op(id, n as u32, &b64(marks.as_bytes()));
    (picture, chart)
}

#[cfg(test)]
fn checker(w: u32, h: u32) -> Vec<u8> {
    let mut rgba = Vec::with_capacity((w as usize) * (h as usize) * 4);
    for y in 0..h {
        for x in 0..w {
            let on = ((x / 4) + (y / 4)) % 2 == 0;
            if on {
                rgba.extend_from_slice(&[40, 180, 220, 230]);
            } else {
                rgba.extend_from_slice(&[0, 0, 0, 0]);
            }
        }
    }
    rgba
}

fn encode_sixel(w: u32, h: u32, rgba: &[u8]) -> Vec<u8> {
    let pixels = (w as usize).saturating_mul(h as usize);
    let (palette, index) = indexed(rgba, w, pixels);
    let mut out = Vec::new();
    out.extend_from_slice(b"\x1bPq");
    out.extend_from_slice(format!("\"1;1;{w};{h}").as_bytes());
    for (i, color) in palette.iter().enumerate() {
        let (pr, pg, pb) = (
            u16::from(color[0]) * 100 / 255,
            u16::from(color[1]) * 100 / 255,
            u16::from(color[2]) * 100 / 255,
        );
        out.extend_from_slice(format!("#{i};2;{pr};{pg};{pb}").as_bytes());
    }
    let mut y = 0u32;
    while y < h {
        let band = (h - y).min(6);
        for (slot, _) in palette.iter().enumerate() {
            if !band_has(&index, w, y, band, slot) {
                continue;
            }
            out.extend_from_slice(format!("#{slot}").as_bytes());
            let mut run = 0u32;
            let mut prev = 0u8;
            for x in 0..w {
                let mut six = 0u8;
                for dy in 0..band {
                    let at = ((y + dy) * w + x) as usize;
                    if index.get(at).copied().flatten() == Some(slot as u8) {
                        six |= 1 << dy;
                    }
                }
                if x > 0 && six == prev {
                    run += 1;
                } else {
                    if x > 0 {
                        push_sixel(&mut out, prev, run);
                    }
                    prev = six;
                    run = 1;
                }
            }
            push_sixel(&mut out, prev, run);
            out.push(b'$');
        }
        out.push(b'-');
        y += band;
    }
    out.extend_from_slice(b"\x1b\\");
    out
}

fn indexed(rgba: &[u8], width: u32, pixels: usize) -> (Vec<[u8; 3]>, Vec<Option<u8>>) {
    let mut colors: Vec<[u8; 3]> = Vec::new();
    let mut index = vec![None; pixels];
    for i in 0..pixels {
        let px = &rgba[i * 4..i * 4 + 4];
        if px[3] < 16 {
            continue;
        }
        let rgb = [px[0], px[1], px[2]];
        if let Some(slot) = colors.iter().position(|c| *c == rgb) {
            index[i] = Some(slot as u8);
        } else if colors.len() < 64 {
            index[i] = Some(colors.len() as u8);
            colors.push(rgb);
        } else {
            return quantize(rgba, width, pixels);
        }
    }
    if colors.is_empty() {
        colors.push([0, 0, 0]);
    }
    (colors, index)
}

fn quantize(rgba: &[u8], width: u32, pixels: usize) -> (Vec<[u8; 3]>, Vec<Option<u8>>) {
    let width = width.max(1);
    let mut palette: Vec<Option<[u8; 3]>> = vec![None; 64];
    let mut index = vec![None; pixels];
    for i in 0..pixels {
        let px = &rgba[i * 4..i * 4 + 4];
        if px[3] < 16 {
            continue;
        }
        let x = (i as u32) % width;
        let y = (i as u32) / width;
        let key = usize::from(quant_channel(px[0], x, y) / 85) * 16
            + usize::from(quant_channel(px[1], x, y) / 85) * 4
            + usize::from(quant_channel(px[2], x, y) / 85);
        let key = key.min(63);
        if palette[key].is_none() {
            let level = |ch: u8| quant_channel(ch, x, y);
            palette[key] = Some([level(px[0]), level(px[1]), level(px[2])]);
        }
        index[i] = Some(key as u8);
    }
    let mut colors = Vec::new();
    let mut remap = [None; 64];
    for (key, color) in palette.into_iter().enumerate() {
        if let Some(color) = color {
            remap[key] = Some(colors.len() as u8);
            colors.push(color);
        }
    }
    if colors.is_empty() {
        colors.push([0, 0, 0]);
    }
    for slot in &mut index {
        if let Some(key) = slot {
            *slot = remap[usize::from(*key)];
        }
    }
    (colors, index)
}

fn band_has(index: &[Option<u8>], w: u32, y: u32, band: u32, slot: usize) -> bool {
    for dy in 0..band {
        for x in 0..w {
            let at = ((y + dy) * w + x) as usize;
            if index.get(at).copied().flatten() == Some(slot as u8) {
                return true;
            }
        }
    }
    false
}

fn push_sixel(out: &mut Vec<u8>, six: u8, run: u32) {
    if run > 3 {
        out.extend_from_slice(format!("!{run}").as_bytes());
    } else {
        for _ in 1..run {
            out.push(six + 63);
        }
    }
    out.push(six + 63);
}

fn write_bmp(w: u32, h: u32, rgba: &[u8]) -> Vec<u8> {
    let row = (w.saturating_mul(3) + 3) & !3;
    let pixels = row.saturating_mul(h);
    let file = 54u32.saturating_add(pixels);
    let mut bmp = vec![0u8; file as usize];
    bmp[0] = b'B';
    bmp[1] = b'M';
    bmp[2..6].copy_from_slice(&file.to_le_bytes());
    bmp[10..14].copy_from_slice(&54u32.to_le_bytes());
    bmp[14..18].copy_from_slice(&40u32.to_le_bytes());
    bmp[18..22].copy_from_slice(&w.to_le_bytes());
    bmp[22..26].copy_from_slice(&h.to_le_bytes());
    bmp[26..28].copy_from_slice(&1u16.to_le_bytes());
    bmp[28..30].copy_from_slice(&24u16.to_le_bytes());
    bmp[34..38].copy_from_slice(&pixels.to_le_bytes());
    for y in 0..h {
        let src_y = h - 1 - y;
        for x in 0..w {
            let s = ((src_y * w + x) * 4) as usize;
            let d = (54 + y * row + x * 3) as usize;
            if s + 2 < rgba.len() && d + 2 < bmp.len() {
                bmp[d] = rgba[s + 2];
                bmp[d + 1] = rgba[s + 1];
                bmp[d + 2] = rgba[s];
            }
        }
    }
    bmp
}

fn b64(bytes: &[u8]) -> String {
    const T: &[u8] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    let mut out = String::new();
    let mut i = 0;
    while i + 3 <= bytes.len() {
        let n = (u32::from(bytes[i]) << 16) | (u32::from(bytes[i + 1]) << 8) | u32::from(bytes[i + 2]);
        for shift in [18, 12, 6, 0] {
            out.push(T[((n >> shift) & 63) as usize] as char);
        }
        i += 3;
    }
    if i < bytes.len() {
        let mut n = u32::from(bytes[i]) << 16;
        let mut pads = 2;
        if i + 1 < bytes.len() {
            n |= u32::from(bytes[i + 1]) << 8;
            pads = 1;
        }
        for shift in [18, 12, 6, 0].into_iter().take(4 - pads) {
            out.push(T[((n >> shift) & 63) as usize] as char);
        }
        for _ in 0..pads {
            out.push('=');
        }
    }
    out
}

const MARKS: &[u32] = &[
    0x0305, 0x030D, 0x030E, 0x0310, 0x0312, 0x033D, 0x033E, 0x033F,
    0x0346, 0x034A, 0x034B, 0x034C, 0x0350, 0x0351, 0x0352, 0x0357,
    0x035B, 0x0363, 0x0364, 0x0365, 0x0366, 0x0367, 0x0368, 0x0369,
    0x036A, 0x036B, 0x036C, 0x036D, 0x036E, 0x036F, 0x0483, 0x0484,
    0x0485, 0x0486, 0x0487, 0x0592, 0x0593, 0x0594, 0x0595, 0x0597,
    0x0598, 0x0599, 0x059C, 0x059D, 0x059E, 0x059F, 0x05A0, 0x05A1,
    0x05A8, 0x05A9, 0x05AB, 0x05AC, 0x05AF, 0x05C4, 0x0610, 0x0611,
    0x0612, 0x0613, 0x0614, 0x0615, 0x0616, 0x0617, 0x0657, 0x0658,
    0x0659, 0x065A, 0x065B, 0x065D, 0x065E, 0x06D6, 0x06D7, 0x06D8,
    0x06D9, 0x06DA, 0x06DB, 0x06DC, 0x06DF, 0x06E0, 0x06E1, 0x06E2,
    0x06E4, 0x06E7, 0x06E8, 0x06EB, 0x06EC, 0x0730, 0x0732, 0x0733,
    0x0735, 0x0736, 0x073A, 0x073D, 0x073F, 0x0740, 0x0741, 0x0743,
    0x0745, 0x0747, 0x0749, 0x074A, 0x07EB, 0x07EC, 0x07ED, 0x07EE,
    0x07EF, 0x07F0, 0x07F1, 0x07F3, 0x0816, 0x0817, 0x0818, 0x0819,
    0x081B, 0x081C, 0x081D, 0x081E, 0x081F, 0x0820, 0x0821, 0x0822,
    0x0823, 0x0825, 0x0826, 0x0827, 0x0829, 0x082A, 0x082B, 0x082C,
    0x082D, 0x0951, 0x0953, 0x0954, 0x0F82, 0x0F83, 0x0F86, 0x0F87,
    0x135D, 0x135E, 0x135F, 0x17DD, 0x193A, 0x1A17, 0x1A75, 0x1A76,
    0x1A77, 0x1A78, 0x1A79, 0x1A7A, 0x1A7B, 0x1A7C, 0x1B6B, 0x1B6D,
    0x1B6E, 0x1B6F, 0x1B70, 0x1B71, 0x1B72, 0x1B73, 0x1CD0, 0x1CD1,
    0x1CD2, 0x1CDA, 0x1CDB, 0x1CE0, 0x1DC0, 0x1DC1, 0x1DC3, 0x1DC4,
    0x1DC5, 0x1DC6, 0x1DC7, 0x1DC8, 0x1DC9, 0x1DCB, 0x1DCC, 0x1DD1,
    0x1DD2, 0x1DD3, 0x1DD4, 0x1DD5, 0x1DD6, 0x1DD7, 0x1DD8, 0x1DD9,
    0x1DDA, 0x1DDB, 0x1DDC, 0x1DDD, 0x1DDE, 0x1DDF, 0x1DE0, 0x1DE1,
    0x1DE2, 0x1DE3, 0x1DE4, 0x1DE5, 0x1DE6, 0x1DFE, 0x20D0, 0x20D1,
    0x20D4, 0x20D5, 0x20D6, 0x20D7, 0x20DB, 0x20DC, 0x20E1, 0x20E7,
    0x20E9, 0x20F0, 0x2CEF, 0x2CF0, 0x2CF1, 0x2DE0, 0x2DE1, 0x2DE2,
    0x2DE3, 0x2DE4, 0x2DE5, 0x2DE6, 0x2DE7, 0x2DE8, 0x2DE9, 0x2DEA,
    0x2DEB, 0x2DEC, 0x2DED, 0x2DEE, 0x2DEF, 0x2DF0, 0x2DF1, 0x2DF2,
    0x2DF3, 0x2DF4, 0x2DF5, 0x2DF6, 0x2DF7, 0x2DF8, 0x2DF9, 0x2DFA,
    0x2DFB, 0x2DFC, 0x2DFD, 0x2DFE, 0x2DFF, 0xA66F, 0xA67C, 0xA67D,
    0xA6F0, 0xA6F1, 0xA8E0, 0xA8E1, 0xA8E2, 0xA8E3, 0xA8E4, 0xA8E5,
    0xA8E6, 0xA8E7, 0xA8E8, 0xA8E9, 0xA8EA, 0xA8EB, 0xA8EC, 0xA8ED,
    0xA8EE, 0xA8EF, 0xA8F0, 0xA8F1, 0xAAB0, 0xAAB2, 0xAAB3, 0xAAB7,
    0xAAB8, 0xAABE, 0xAABF, 0xAAC1, 0xFE20, 0xFE21, 0xFE22, 0xFE23,
    0xFE24, 0xFE25, 0xFE26, 0x10A0F, 0x10A38, 0x1D185, 0x1D186, 0x1D187,
    0x1D188, 0x1D189, 0x1D1AA, 0x1D1AB, 0x1D1AC, 0x1D1AD, 0x1D242, 0x1D243,
    0x1D244,
];

fn mark(i: usize) -> char {
    char::from_u32(MARKS.get(i).copied().unwrap_or(0x0305)).unwrap_or('\u{0305}')
}

fn placeholder_cell(row: usize, col: usize) -> String {
    format!("\u{10EEEE}{}{}", mark(row), mark(col))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn px(buf: &[u8], w: u32, x: u32, y: u32) -> [u8; 4] {
        let i = ((y * w + x) * 4) as usize;
        [buf[i], buf[i + 1], buf[i + 2], buf[i + 3]]
    }

    #[test]
    fn the_show_lasts_about_half_a_minute() {
        let ms = HOLD_TEXT
            + HOLD_CURSOR * 3
            + HOLD_SIXEL
            + HOLD_APC_UNDER
            + HOLD_APC_OVER
            + HOLD_APC_CROP
            + HOLD_PLACE
            + HOLD_SCROLL * SCROLL_LINES
            + HOLD_SCROLL_REST
            + HOLD_OSC
            + HOLD_ANIM
            + HOLD_GLOW
            + HOLD_PARTICLES
            + HOLD_PRIM
            + HOLD_CUBE
            + HOLD_GROUP
            + HOLD_CHART
            + HOLD_FRAME * VIDEO_FRAMES
            + HOLD_CLOSE
            + HOLD_FINALE;
        assert!(
            (25_000..35_000).contains(&ms),
            "the show is {ms} ms, not about half a minute"
        );
    }

    #[test]
    fn quit_during_the_probe_exits() {
        let (tx, rx) = mpsc::channel();
        tx.send(vec![b'q']).unwrap();
        let started = Instant::now();
        assert!(probe(&rx, 24, 80).is_none());
        assert!(
            started.elapsed() < Duration::from_millis(50),
            "q during the probe must not wait out the deadline"
        );
        let _keep = tx;
    }

    /// The race: glass answers every query at once. With those bytes already
    /// on the channel, the probe must take them and return a fit at once.
    /// It must not read stdin (there is no tty here).
    #[test]
    fn queued_replies_return_a_fit_at_once() {
        let (tx, rx) = mpsc::channel();
        tx.send(b"\x1b[I".to_vec()).unwrap();
        tx.send(
            b"\x1b[?62;4;22c\x1b[>1;10;0c\x1b[8;39;154t\x1b[6;25;12t".to_vec(),
        )
        .unwrap();
        let started = Instant::now();
        let fit = probe(&rx, 24, 80).expect("queued replies are a fit");
        let elapsed = started.elapsed();
        assert!(
            elapsed < Duration::from_millis(50),
            "probe blocked {elapsed:?} with replies already queued"
        );
        assert_eq!(fit.rows, 39);
        assert_eq!(fit.cols, 154);
        assert_eq!(fit.cell_h, 25);
        assert_eq!(fit.cell_w, 12);
        let _keep = tx;
    }

    /// No reply on the channel: return None when the deadline lands, and
    /// do not block past it in a read.
    #[test]
    fn no_replies_return_none_by_the_deadline() {
        let (tx, rx) = mpsc::channel();
        let started = Instant::now();
        let fit = probe(&rx, 24, 80);
        let elapsed = started.elapsed();
        assert!(fit.is_none(), "silence is not glass");
        assert!(
            elapsed >= Duration::from_millis(PROBE_MS.saturating_sub(30)),
            "returned {elapsed:?} before the deadline"
        );
        assert!(
            elapsed < Duration::from_millis(PROBE_MS + 200),
            "blocked {elapsed:?} past the deadline"
        );
        let _keep = tx;
    }

    #[test]
    fn focus_reports_and_late_replies_are_not_a_quit() {
        assert!(!wants_quit(b"\x1b[I"));
        assert!(!wants_quit(b"\x1b[O"));
        assert!(!wants_quit(
            b"\x1b[?62;4;22c\x1b[>1;10;0c\x1b[8;39;154t\x1b[6;25;12t"
        ));
        assert!(!wants_quit(b"\x1b_glass;r=1;OK;\x1b\\"));
        assert!(!wants_quit(b"\x1b[2 q"));
        assert!(wants_quit(b"q"));
        assert!(wants_quit(&[3]));
        assert!(wants_quit(b"\x1b[Iq"));
    }

    #[test]
    fn chart_is_uploaded_then_opened_with_chart_p() {
        let (rgba, marks) = bar_chart(64, 40);
        assert_eq!(rgba.len(), 64 * 40 * 4);
        assert!(marks.lines().any(|line| line.starts_with("mark;")));
        let (picture, chart) = chart_upload(CHART_PICTURE, &rgba, 64, 40, &marks);
        assert!(picture.starts_with("picture;id=11;f=32;s=64;v=40;"), "{picture}");
        assert!(chart.starts_with("chart;p=11;n="), "{chart}");
        assert!(!picture.contains("k=chart"), "{picture}");
        assert!(!chart.contains("k=chart"), "{chart}");
        let n = chart
            .split(';')
            .find_map(|field| field.strip_prefix("n="))
            .and_then(|n| n.parse::<usize>().ok())
            .expect("n=");
        let marks_n = marks.lines().filter(|line| line.starts_with("mark;")).count();
        assert_eq!(n, marks_n);
    }

    #[test]
    fn sixel_header_carries_the_raster_and_a_named_colour() {
        let rgba = vec![255u8, 0, 0, 255, 0, 0, 255, 255];
        let sixel = encode_sixel(2, 1, &rgba);
        let text = String::from_utf8(sixel).unwrap();
        assert!(text.starts_with("\u{1b}Pq"), "{text}");
        assert!(text.contains("\"1;1;2;1"), "{text}");
        assert!(text.contains("#0;2;100;0;0"), "{text}");
        assert!(text.contains("#1;2;0;0;100"), "{text}");
        assert!(text.ends_with("\u{1b}\\"), "{text}");
    }

    #[test]
    fn sixel_quantises_past_64_colours() {
        let mut rgba = Vec::new();
        for i in 0..80u8 {
            rgba.extend_from_slice(&[i.saturating_mul(3), 255 - i, i, 255]);
        }
        let sixel = String::from_utf8(encode_sixel(80, 1, &rgba)).unwrap();
        let colours = sixel.matches(";2;").count();
        assert!(colours <= 64, "{colours} palette entries");
        assert!(colours > 1, "quantising should keep more than one colour");
    }

    #[test]
    fn bmp_is_a_bottom_up_24bit_file() {
        let rgba = vec![10u8, 20, 30, 255, 40, 50, 60, 255, 70, 80, 90, 255, 100, 110, 120, 255];
        let bmp = write_bmp(2, 2, &rgba);
        assert_eq!(&bmp[0..2], b"BM");
        assert_eq!(u32::from_le_bytes(bmp[18..22].try_into().unwrap()), 2);
        assert_eq!(u32::from_le_bytes(bmp[22..26].try_into().unwrap()), 2);
        assert_eq!(u16::from_le_bytes(bmp[28..30].try_into().unwrap()), 24);
        assert_eq!(&bmp[54..57], &[90, 80, 70]);
    }

    #[test]
    fn base64_roundtrip_matches_the_standard_alphabet() {
        assert_eq!(b64(b""), "");
        assert_eq!(b64(b"f"), "Zg==");
        assert_eq!(b64(b"fo"), "Zm8=");
        assert_eq!(b64(b"foo"), "Zm9v");
        assert_eq!(b64(b"foobar"), "Zm9vYmFy");
    }

    #[test]
    fn placeholder_marks_match_the_dialect_table() {
        let reference: Vec<u32> = std::fs::read_to_string(
            "/work/frosty40/glass-term-agents/ref/rowcolumn-diacritics.txt",
        )
        .expect("the row/column diacritic table")
        .lines()
        .filter_map(|line| {
            let line = line.split('#').next()?.trim();
            let code = line.split(';').next()?.trim();
            if code.is_empty() {
                None
            } else {
                u32::from_str_radix(code, 16).ok()
            }
        })
        .take(10)
        .collect();
        assert_eq!(reference.len(), 10, "the reference table should list the marks");
        for (i, code) in reference.iter().enumerate() {
            assert_eq!(mark(i) as u32, *code, "mark {i}");
        }
    }

    #[test]
    fn sprite_frames_are_distinct_and_checker_has_real_alpha() {
        let first = sprite(0, ANIM_FRAMES, 28);
        for i in 1..ANIM_FRAMES {
            assert_ne!(first, sprite(i, ANIM_FRAMES, 28), "frame {i} matches frame 0");
        }
        let board = checker(24, 16);
        assert!(board.iter().step_by(4).any(|a| *a == 0));
        assert!(board.iter().skip(3).step_by(4).any(|a| *a > 200));
    }

    #[test]
    fn blocks_shade_is_scaled_in_u32() {
        // Pixel (8, 4) of a 32×16 gradient is interior. The old `u8`
        // multiply saturated at 255 and this pixel came out (1, 1, 1).
        let picture = blocks(32, 16);
        assert_eq!(px(&picture, 32, 0, 0), [255, 236, 180, 255]);
        assert_eq!(px(&picture, 32, 8, 4), [73, 50, 149, 255]);
    }

    #[test]
    fn glow_is_opaque_at_the_centre_and_clear_at_the_edge() {
        let picture = glow(32, 24);
        assert_eq!(picture.len(), 32 * 24 * 4);
        assert!(px(&picture, 32, 16, 12)[3] >= 200, "centre alpha");
        assert_eq!(px(&picture, 32, 0, 0)[3], 0, "corner alpha");
        assert_eq!(px(&picture, 32, 31, 23)[3], 0, "far corner alpha");
    }

    #[test]
    fn plasma_is_dithered_to_64_colours_at_the_requested_size() {
        let picture = plasma(48, 24);
        assert_eq!(picture.len(), 48 * 24 * 4);
        let mut colors = std::collections::BTreeSet::new();
        for px in picture.chunks(4) {
            colors.insert([px[0], px[1], px[2]]);
        }
        assert!(colors.len() > 8, "a plasma should be more than a handful of colours");
        assert!(colors.len() <= 64, "{} colours", colors.len());
        let large = plasma(480, 240);
        assert_eq!(large.len(), 480 * 240 * 4);
    }

    #[test]
    fn sphere_has_a_highlight_brighter_than_its_shadow() {
        let picture = sphere(80, 48);
        assert_eq!(picture.len(), 80 * 48 * 4);
        assert_ne!(px(&picture, 80, 2, 1), px(&picture, 80, 2, 46), "the sky should be a gradient");
        let mut brightest = 0u32;
        let mut darkest = u32::MAX;
        let mut warm = 0u32;
        for y in 0..48u32 {
            for x in 0..80u32 {
                let p = px(&picture, 80, x, y);
                if p[0] <= p[2] {
                    continue;
                }
                warm += 1;
                let lum = u32::from(p[0]) + u32::from(p[1]) + u32::from(p[2]);
                brightest = brightest.max(lum);
                darkest = darkest.min(lum);
            }
        }
        assert!(warm > 40, "the sphere should cover more than a few pixels, got {warm}");
        assert!(
            brightest > darkest + 40,
            "highlight {brightest} vs shadow {darkest}"
        );
    }

    #[test]
    fn a_bouncing_ball_squashes_on_the_ground_and_frames_move() {
        let ground = sprite(0, 12, 64);
        let air = sprite(6, 12, 64);
        assert_eq!(ground.len(), 64 * 64 * 4);
        assert_ne!(ground, air);
        let bounds = |buf: &[u8]| {
            let mut min = (64u32, 64u32);
            let mut max = (0u32, 0u32);
            let mut any = false;
            for y in 0..64u32 {
                for x in 0..64u32 {
                    if px(buf, 64, x, y)[3] > 0 {
                        any = true;
                        min.0 = min.0.min(x);
                        min.1 = min.1.min(y);
                        max.0 = max.0.max(x);
                        max.1 = max.1.max(y);
                    }
                }
            }
            assert!(any);
            (max.0 - min.0, max.1 - min.1)
        };
        let (gw, gh) = bounds(&ground);
        let (_aw, ah) = bounds(&air);
        assert!(gw > gh, "squash on the ground: {gw}x{gh}");
        assert!(ah > gh, "the ball is taller in the air");
    }

    #[test]
    fn video_frames_fill_the_frame_and_move() {
        let a = video_frame(0, 20, 80, 40);
        let b = video_frame(7, 20, 80, 40);
        assert_eq!(a.len(), 80 * 40 * 4);
        assert_ne!(a, b);
        assert!(a.chunks(4).all(|p| p[3] == 255));
    }

    #[test]
    fn a_main_picture_fills_about_half_the_window() {
        let fit = Fit {
            rows: 53,
            cols: 189,
            cell_w: 10,
            cell_h: 20,
        };
        let (w, h) = fit.picture(0.50, 0.50, 480, 240);
        assert!(w >= 480, "{w}");
        assert!(h >= 240, "{h}");
        assert!(w <= fit.screen_w() && h <= fit.screen_h());
        let frac = w as f32 / fit.screen_w() as f32;
        assert!((0.40..=0.60).contains(&frac), "{frac}");
    }

    #[test]
    fn glass_builders_use_only_allowed_keys_and_never_carry_q() {
        let samples = [
            picture_op(11, 32, 64, 40, "Zg=="),
            layer_glow(1, "ffb040", "0.85", "4,5,20,10"),
            layer_particles(2, "ffb040", 280, 8, "2.6", 42, 22, "4,6,20,10"),
            layer_prim(5, 0, "ff8050", "8,6,12,8"),
            layer_solid(20, "ff5a4a", "10.0,8.0,6,2"),
            group_op(1, 7, "Zg=="),
            remove_all_op(),
            showcase_video(320, 180),
            showcase_close_op(),
            scene_op(8, 160, 120, "10,5,40,20", "Zg=="),
            frame_op(32, 320, 180, "Zg=="),
            chart_op(11, 6, "Zg=="),
            progress_op(0.5),
            glass_checked("scene;id=1;s=2;v=2;at=1,1,2,2", 7),
        ];
        for record in samples {
            assert!(!record.contains("q="), "{record}");
            let (op, keys) = glass_key_pairs(&record);
            let allowed = glass_allowed(&op);
            assert!(!allowed.is_empty(), "unknown op in {record}");
            for (key, _) in &keys {
                assert!(
                    allowed.contains(&key.as_str()),
                    "{op} key {key} is not allowed in {record}"
                );
            }
        }
        let checked = glass_checked(&scene_op(8, 4, 4, "1,1,2,2", "Zg=="), 3);
        let (op, keys) = glass_key_pairs(&checked);
        assert_eq!(op, "scene");
        assert_eq!(
            keys.iter().find(|(k, _)| k == "r").map(|(_, v)| v.as_str()),
            Some("3")
        );
        assert!(checked.ends_with(";Zg=="), "{checked}");
    }

    #[test]
    fn animation_places_frame_one_and_run_does_not_use_c_or_r_as_placement() {
        let place = apc_transmit_place(5, 200, 200, 40, 20, true);
        let placed = apc_key_map(&place);
        assert_eq!(placed.get("a").map(String::as_str), Some("T"));
        assert_eq!(placed.get("i").map(String::as_str), Some("5"));
        assert_eq!(placed.get("c").map(String::as_str), Some("40"));
        assert_eq!(placed.get("r").map(String::as_str), Some("20"));
        assert_eq!(placed.get("C").map(String::as_str), Some("1"));
        let frame = apc_anim_frame(5, 200, 200, ANIM_GAP_MS, true);
        let framed = apc_key_map(&frame);
        assert_eq!(framed.get("a").map(String::as_str), Some("f"));
        assert_eq!(framed.get("z").map(String::as_str), Some("80"));
        assert!(framed.get("c").is_none(), "{frame}");
        assert!(framed.get("r").is_none(), "{frame}");
        let gap = apc_key_map(&apc_frame_gap(5, 1, ANIM_GAP_MS, true));
        assert_eq!(gap.get("a").map(String::as_str), Some("a"));
        assert_eq!(gap.get("r").map(String::as_str), Some("1"));
        assert_eq!(gap.get("z").map(String::as_str), Some("80"));
        assert!(gap.get("c").is_none());
        let run = apc_key_map(&apc_anim_run(5, 5, true));
        assert_eq!(run.get("s").map(String::as_str), Some("3"));
        assert_eq!(run.get("v").map(String::as_str), Some("5"));
        assert!(run.get("c").is_none(), "a=a c= is a frame number, not columns");
        assert!(run.get("r").is_none(), "a=a r= is a frame number, not rows");
        let loud = drop_apc_quiet(&place);
        assert!(!loud.contains("q="), "{loud}");
        assert!(loud.contains("a=T"));
        assert!(loud.contains("c=40"));
    }

    #[test]
    fn video_frames_match_the_panel_and_fit_the_byte_cap() {
        let fit = Fit {
            rows: 53,
            cols: 189,
            cell_w: 10,
            cell_h: 20,
        };
        let (w, h) = video_panel(fit);
        assert!(w.saturating_mul(h).saturating_mul(4) <= FRAME_BYTES, "{w}x{h}");
        let opened = showcase_video(w, h);
        assert!(!opened.contains("id="), "{opened}");
        let frame = frame_op(32, w, h, "Zg==");
        assert!(frame.contains(&format!("s={w}")));
        assert!(frame.contains(&format!("v={h}")));
        assert!(!frame.contains("id="));
        assert!(!progress_op(0.25).contains("id="));
    }

    /// Every frame and picture payload the sampler builds stays under the
    /// dialect caps. A frame is capped at 1 MiB on the payload bytes
    /// (`store_frame`, before base64 decode). A picture is not under that
    /// cap: glass_dialect sends it through the APC loader, which caps a
    /// picture at 64 MiB and each side at 8192. The dialect reference
    /// also keeps a picture side in 1..=4096.
    #[test]
    fn frame_and_picture_payloads_stay_under_the_dialect_caps() {
        const FRAME_CAP: usize = FRAME_BYTES as usize;
        const PICTURE_CAP: usize = 64 << 20;
        const PICTURE_SIDE: u32 = 4096;
        let fit = Fit {
            rows: 53,
            cols: 189,
            cell_w: 10,
            cell_h: 20,
        };
        let (w, h) = video_panel(fit);
        assert_eq!((w, h), (VIDEO_W, VIDEO_H));
        assert!((w as usize) * (h as usize) * 4 <= FRAME_CAP, "raw {w}x{h}");
        let opened = showcase_video(w, h);
        assert!(opened.contains("fit=contain"), "{opened}");
        assert!(opened.contains(&format!("s={w}")));
        assert!(opened.contains(&format!("v={h}")));
        assert!(!opened.contains("id="), "{opened}");
        let mut previous = Vec::new();
        for i in 0..VIDEO_FRAMES {
            let pixels = video_frame(i, VIDEO_FRAMES, w, h);
            assert_eq!(pixels.len(), (w as usize) * (h as usize) * 4);
            assert!(pixels.len() <= FRAME_CAP, "raw frame {i}");
            let payload = b64(&pixels);
            assert!(
                payload.len() <= FRAME_CAP,
                "frame payload {i} is {} bytes",
                payload.len()
            );
            let op = frame_op(32, w, h, &payload);
            assert!(op.contains(&format!("s={w}")));
            assert!(op.contains(&format!("v={h}")));
            if i > 0 {
                assert_ne!(pixels, previous, "frame {i} should move");
            }
            previous = pixels;
        }
        let (cw, ch) = chart_panel(fit);
        assert!(cw >= 1 && ch >= 1 && cw <= PICTURE_SIDE && ch <= PICTURE_SIDE, "{cw}x{ch}");
        let (rgba, _marks) = bar_chart(cw, ch);
        assert!(rgba.len() <= PICTURE_CAP, "chart picture is {} bytes", rgba.len());
        let picture = b64(&rgba);
        assert!(
            picture.len() <= PICTURE_CAP,
            "chart payload is {} bytes",
            picture.len()
        );
        let prim = layer_prim(5, 0, "ff8050", "8,6,12,8");
        assert!(prim.contains("shape=0") && !prim.contains("rect"), "{prim}");
        let circle = layer_prim(6, 1, "70c8ff", "12,8,12,8");
        assert!(circle.contains("shape=1") && !circle.contains("circle"), "{circle}");
    }

    #[test]
    fn in_cell_caption_stays_outside_the_picture() {
        let wide = Fit {
            rows: 30,
            cols: 200,
            cell_w: 16,
            cell_h: 16,
        };
        let (c, r) = wide.cell_box(0.50, 0.62);
        let (_c, rows, caption) = in_cell_span(wide, 5, c, r);
        assert!(5 + rows <= u32::from(caption));
        assert!(caption <= wide.rows);
        let tall = Fit {
            rows: 53,
            cols: 189,
            cell_w: 10,
            cell_h: 20,
        };
        let (w, h) = tall.picture(0.50, 0.50, 480, 240);
        let (cw, ch, cap) = clamp_in_cell_pixels(tall, 5, w, h);
        assert_eq!((cw, ch), (w, h), "a fitting sixel keeps its size");
        let cells = ch.div_ceil(tall.cell_h);
        assert!(5 + cells <= u32::from(cap));
    }

    #[test]
    fn showcase_closes_only_when_one_is_open() {
        SHOWCASE_OPEN.store(false, Ordering::Relaxed);
        assert!(!SHOWCASE_OPEN.swap(false, Ordering::Relaxed));
        SHOWCASE_OPEN.store(true, Ordering::Relaxed);
        assert!(SHOWCASE_OPEN.swap(false, Ordering::Relaxed));
        assert!(!SHOWCASE_OPEN.load(Ordering::Relaxed));
        assert_eq!(showcase_close_op(), "showcase;close=1");
    }

    #[test]
    fn check_summary_counts_ok_and_names_each_error_code() {
        let mut tally = Tally::new();
        tally.sent = 4;
        tally.note_bytes(b"noise\x1b_glass;r=1;OK;");
        tally.note_bytes(b"\x1b\\");
        tally.note_bytes(b"\x1b_Gi=5;ENOENT:no such image\x1b\\");
        tally.note_bytes(b"\x1b_glass;r=2;EINVAL:unknown key q\x1b\\");
        tally.note_bytes(b"\x1b_Gi=9;OK\x1b\\");
        assert_eq!(tally.ok, 2);
        assert_eq!(tally.errors.len(), 2);
        let line = tally.summary();
        assert!(line.contains("ops sent 4"), "{line}");
        assert!(line.contains("OK 2"), "{line}");
        assert!(line.contains("ENOENT"), "{line}");
        assert!(line.contains("EINVAL"), "{line}");
        assert!(!line.contains("q="));
    }

    #[test]
    fn chart_hold_is_at_least_two_seconds() {
        assert!(HOLD_CHART >= 2000);
    }
}
