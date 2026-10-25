//! glass's own dialect, the expansion side: a program speaks APC
//! `glass;` sequences and reaches what the window itself can draw —
//! layers of every kind, groups replaced per frame, particles, lit
//! primitives and the showcase — more than any picture dialect can say.
//! Other terminals ignore unknown APC strings, so a program may send
//! these blind; `hello` lets it ask first.
//!
//! One framing, everywhere: `ESC _ glass ; <op> [; <key>=<value>]... [; <payload>] ESC \`
//! (BEL also ends it). Fields sit behind `;`, so a value may hold
//! commas (`at=2,1,4,2`); the payload, when the op takes one, is the
//! last field and is base64. Chunked transmissions follow the intake's
//! own rule — `m=1` on every piece but the last, the first piece's keys
//! governing — and a payload-less continuation writes its last field
//! empty (`picture;m=0;`).
//!
//! The dialect reuses the intake's machinery rather than repeating it:
//! picture uploads decode through the APC graphics adapter's loader
//! (the same caps and budget), and its state lives in [`Expansion`],
//! which the store owns beside the intake's pictures and the session
//! renders each frame beside them.

use super::apc_graphics;
use super::{base64, Canvas};

/// The dialect's version. v2 adds `scene` and the showcase's video
/// frames, charts, models and pages (docs/GLASS_DIALECT.md).
pub const VERSION: u32 = 2;

/// The ops this build takes, in the order `hello` answers them.
pub const OPS: [&str; 12] = [
    "hello", "picture", "layer", "group", "remove", "showcase", "scene", "frame", "chart",
    "model", "page", "progress",
];

/// The ops whose last field is a payload.
const PAYLOAD_OPS: [&str; 7] = ["picture", "group", "scene", "frame", "chart", "model", "page"];

/// Program ids live below this; a `picture` or `layer` id the program
/// names is offset by it into the expansion's own id space, far from
/// the intake's client ids (below `MINT_BASE`) and its minted ones.
pub const ID_BASE: u32 = 0x4000_0000;

/// The most layers one `group` may name — the stage's own limit, so a
/// group that fills a frame's whole layer set settles in one go.
pub const GROUP_CAP: usize = 65_536;

/// The most bytes a `group` payload may carry once decoded; layer
/// records are short, so this caps a hostile payload before its
/// records are even split.
pub const GROUP_BYTES: usize = 1 << 20;

/// The keys each op takes; anything else is refused, so a program
/// learns its typo instead of drawing half of what it meant.
fn allowed_keys(op: &str) -> &'static [&'static str] {
    match op {
        "hello" => &["r", "m"],
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
        "mark" => &["x", "y", "w", "h", "ax", "ay", "t"],
        _ => &[],
    }
}

/// Why a sequence failed: a short code for the reply, a message for
/// the program's log.
struct Bad(String, String);

/// One op's keys, `;`-separated behind the op, each field one
/// `key=value` (a value may hold commas).
struct Keys {
    op: String,
    pairs: Vec<(String, String)>,
    /// The whole key text, held for a chunked transmission's last piece.
    raw: Vec<u8>,
}

impl Keys {
    /// `op;k=v;k=v...` — no payload; a group record line is exactly
    /// this shape.
    fn parse(text: &str) -> Self {
        let mut fields = text.split(';');
        let op = fields.next().unwrap_or("").to_string();
        let mut pairs = Vec::new();
        for field in fields {
            if let Some((key, value)) = field.split_once('=') {
                pairs.push((key.to_string(), value.to_string()));
            }
        }
        Self { op, pairs, raw: text.as_bytes().to_vec() }
    }

    /// The op and its key fields, with the payload already taken off.
    fn from_parts(op: &str, key_fields: &[&str]) -> Self {
        let mut pairs = Vec::new();
        for field in key_fields {
            if let Some((key, value)) = field.split_once('=') {
                pairs.push((key.to_string(), value.to_string()));
            }
        }
        let whole = [op].iter().chain(key_fields.iter()).copied().collect::<Vec<_>>().join(";");
        Self { op: op.to_string(), pairs, raw: whole.into_bytes() }
    }

    fn check(&self) -> Result<(), Bad> {
        let allowed = allowed_keys(&self.op);
        if let Some((key, _)) = self.pairs.iter().find(|(k, _)| !allowed.contains(&k.as_str())) {
            return Err(Bad("EINVAL".into(), format!("unknown key {key}")));
        }
        Ok(())
    }

    /// A key's value, the last one it was given.
    fn get(&self, key: &str) -> Option<&str> {
        self.pairs.iter().rev().find(|(k, _)| k == key).map(|(_, v)| v.as_str())
    }

    fn f32(&self, key: &str) -> Result<Option<f32>, Bad> {
        match self.get(key) {
            None => Ok(None),
            Some(v) => v
                .parse::<f32>()
                .ok()
                .filter(|n| n.is_finite())
                .map(Some)
                .ok_or_else(|| Bad("EINVAL".into(), format!("{key} is not a finite number"))),
        }
    }

    fn u32(&self, key: &str) -> Result<Option<u32>, Bad> {
        match self.get(key) {
            None => Ok(None),
            Some(v) => v
                .parse::<u32>()
                .map(Some)
                .map_err(|_| Bad("EINVAL".into(), format!("{key} is not a number"))),
        }
    }

    fn i32(&self, key: &str) -> Result<Option<i32>, Bad> {
        match self.get(key) {
            None => Ok(None),
            Some(v) => v
                .parse::<i32>()
                .map(Some)
                .map_err(|_| Bad("EINVAL".into(), format!("{key} is not a number"))),
        }
    }

    /// `0` or `1`.
    fn flag(&self, key: &str) -> Result<Option<bool>, Bad> {
        match self.get(key) {
            None => Ok(None),
            Some("0") => Ok(Some(false)),
            Some("1") => Ok(Some(true)),
            Some(_) => Err(Bad("EINVAL".into(), format!("{key} is not 0 or 1"))),
        }
    }

    /// Four numbers, `x,y,w,h` — commas live inside the one value.
    fn quad(&self, key: &str) -> Result<Option<[f32; 4]>, Bad> {
        match self.get(key) {
            None => Ok(None),
            Some(v) => list4(Some(v), key).map(Some),
        }
    }
}

/// `x,y,w,h`, fractions allowed.
fn list4(value: Option<&str>, key: &str) -> Result<[f32; 4], Bad> {
    let Some(v) = value else { return Ok([0.0; 4]) };
    let bad = || Bad("EINVAL".into(), format!("{key}= is not four finite numbers"));
    let mut parts = v.split(',');
    let mut out = [0.0f32; 4];
    for slot in &mut out {
        *slot = parts.next().unwrap_or("").parse::<f32>().ok().filter(|n| n.is_finite()).ok_or_else(bad)?;
    }
    if parts.next().is_some() {
        return Err(bad());
    }
    Ok(out)
}

/// Hex digits to bytes: 6 (rrggbb, opaque) or 8 (rrggbbaa).
fn hex(text: &str) -> Option<Vec<u8>> {
    if text.len() != 6 && text.len() != 8 {
        return None;
    }
    (0..text.len() / 2)
        .map(|i| u8::from_str_radix(&text[i * 2..i * 2 + 2], 16).ok())
        .collect()
}

/// A colour, `c=rrggbb` or `c=rrggbbaa`, as straight RGBA in 0..1.
fn rgba_of(keys: &Keys) -> Result<[f32; 4], Bad> {
    let Some(v) = keys.get("c") else { return Ok([1.0, 1.0, 1.0, 1.0]) };
    let bytes =
        hex(v).ok_or_else(|| Bad("EINVAL".into(), "c= is not rrggbb or rrggbbaa".into()))?;
    let mut out = [1.0f32; 4];
    for (i, b) in bytes.iter().enumerate() {
        out[i] = f32::from(*b) / 255.0;
    }
    if bytes.len() == 3 {
        out[3] = 1.0;
    }
    Ok(out)
}

/// One picture this dialect uploaded, as the store keeps it.
struct Kept { id: u32 }

/// One layer the program asked for, as the frame draws it.
struct Wanted {
    /// The window id: the program's id offset by [`ID_BASE`].
    id: u32,
    z: i32,
    opacity: f32,
    angle: f32,
    height: f32,
    breathe: f32,
    additive: bool,
    flicker: f32,
    stand: angel_glass::Stand,
    placement: angel_glass::Placement,
    kind: angel_glass::LayerKind,
    /// Anchored to the text (`at=` without `anchor=window`): it scrolls
    /// with the text and leaves with it. `false` pins it to the window.
    text: bool,
    /// The absolute line it was anchored to, from the start of output.
    line: u64,
    /// Placed on the alternate screen (text-anchored only).
    alternate: bool,
}

/// The dialect's own state, owned by the store beside the intake's
/// pictures: the layers and groups the program asked for, and the
/// showcase it opened. Lifecycle operations clear it through the same
/// store calls that clear the intake's own pictures.
/// A showcase request. Frames and progress are not part of it, so a
/// stream does not reopen the panel.
#[derive(Clone, Debug, PartialEq)]
pub enum ShowcaseAsk {
    /// An uploaded picture, as version 1 opened the showcase.
    Picture { id: u32, fit: angel_glass::Fit },
    /// A video panel of this pixel size. Frames arrive separately.
    Video { width: u32, height: u32, fit: angel_glass::Fit, generation: u64 },
    /// Chart marks over a picture uploaded with `picture`. The picture's
    /// size is the chart's size. `generation` moves only when the request does.
    Chart {
        marks: Vec<angel_glass::Mark>,
        size: (u32, u32),
        fit: angel_glass::Fit,
        picture: u32,
        generation: u64,
    },
    /// A model, nodes from the scene wire.
    Model {
        nodes: Vec<angel_glass::scene::Node>,
        meshes: Vec<(u32, angel_glass::scene::MeshData)>,
        size: (u32, u32),
        fit: angel_glass::Fit,
        generation: u64,
    },
    /// Page text the window rasterises when the request changes.
    Page { text: String, cols: u16, rows: u16, generation: u64 },
}

/// One video frame waiting for the session to hand the window.
#[derive(Clone)]
pub enum PendingFrame {
    /// Raw or decoded pixels.
    Pixels { width: u32, height: u32, rgba: Vec<u8> },
    /// An already uploaded picture, by program id.
    Picture(u32),
}

/// A scene the session should draw, once it is dirty.
pub struct SceneDraw {
    pub window_id: u32,
    pub scene: angel_glass::scene::Scene,
    pub meshes: Vec<(u32, angel_glass::scene::MeshData)>,
    pub size: (u32, u32),
}

/// A placed scene: the stage scene, the picture it is drawn into, and
/// the layer that places that picture.
struct KeptScene {
    program_id: u32,
    window_id: u32,
    scene: angel_glass::scene::Scene,
    meshes: Vec<(u32, angel_glass::scene::MeshData)>,
    size: (u32, u32),
    wanted: Wanted,
    dirty: bool,
}

/// Inline meshes the wire named, minted above the program's id space.
const MESH_BASE: u32 = 0xC000_0000;

/// The most marks one chart may name.
const CHART_CAP: usize = 4_096;

/// Page columns and rows, each side.
const PAGE_MAX: u32 = 256;

pub struct Expansion {
    /// Layers keyed by their window id, create or replace by `id`.
    layers: Vec<Wanted>,
    /// Group ids to their layers, replaced whole by `group`.
    groups: Vec<(u32, Vec<Wanted>)>,
    /// The pictures this dialect uploaded (kept through the store's own
    /// budget), so `showcase` can name one and `remove all` frees them.
    pictures: Vec<Kept>,
    /// The showcase request. Frames and progress are not part of it.
    ask: Option<ShowcaseAsk>,
    scenes: Vec<KeptScene>,
    pending_frame: Option<PendingFrame>,
    progress: Option<(Option<f32>, bool)>,
    progress_dirty: bool,
    events: bool,
    generation: u64,
    next_mesh: u32,
}

impl Default for Expansion {
    fn default() -> Self {
        Self::new()
    }
}

impl Expansion {
    pub fn new() -> Self {
        Self { layers: Vec::new(), groups: Vec::new(), pictures: Vec::new(), ask: None, scenes: Vec::new(), pending_frame: None, progress: None, progress_dirty: false, events: false, generation: 0, next_mesh: MESH_BASE }
    }

    /// The frame's layers, positioned against the view: text-anchored
    /// layers move with the view's top line exactly as the intake's own
    /// showings do, and window-pinned layers never move.
    pub fn frame(&self, top: u64, rows: u16, alternate: bool) -> Vec<angel_glass::Layer> {
        let mut out = Vec::new();
        let push = |w: &Wanted, out: &mut Vec<angel_glass::Layer>| {
            let row = if w.text { w.line as f32 - top as f32 } else { 0.0 };
            let h = rect_h(&w.placement);
            if !w.text || (w.alternate == alternate && row < f32::from(rows) && row + h > 0.0) {
                // Only a text-anchored layer takes its row from the view; a
                // window-pinned one keeps the row it was placed at.
                let placement = if w.text { place_at(&w.placement, row) } else { w.placement.clone() };
                let mut layer = angel_glass::Layer::new(u64::from(w.id), w.z, placement, w.kind.clone());
                layer.opacity = w.opacity;
                layer.angle = w.angle;
                layer.height = w.height;
                layer.breathe = w.breathe;
                layer.additive = w.additive;
                layer.flicker = w.flicker;
                layer.stand = w.stand;
                out.push(layer);
            }
        };
        for w in &self.layers {
            push(w, &mut out);
        }
        for (_, ws) in &self.groups {
            for w in ws {
                push(w, &mut out);
            }
        }
        for scene in &self.scenes {
            push(&scene.wanted, &mut out);
        }
        out
    }

    /// The showcase's picture id, if one is open.
    #[cfg(test)]
    pub fn showcase(&self) -> Option<u32> {
        match &self.ask {
            Some(ShowcaseAsk::Picture { id, .. }) => Some(*id),
            _ => None,
        }
    }
    pub fn ask(&self) -> Option<&ShowcaseAsk> { self.ask.as_ref() }
    pub fn events_on(&self) -> bool { self.events }
    #[cfg(test)]
    pub fn progress(&self) -> Option<(Option<f32>, bool)> { self.progress }
    #[cfg(test)]
    pub fn pending_frame(&self) -> Option<&PendingFrame> { self.pending_frame.as_ref() }
    pub fn take_video_frame(&mut self) -> Option<PendingFrame> {
        if !matches!(self.ask, Some(ShowcaseAsk::Video { .. })) { return None; }
        self.pending_frame.take()
    }
    pub fn take_progress(&mut self) -> Option<(Option<f32>, bool)> {
        if !self.progress_dirty { return None; }
        self.progress_dirty = false;
        self.progress
    }
    #[cfg(test)]
    pub fn scene(&self, program_id: u32) -> Option<&angel_glass::scene::Scene> {
        self.scenes.iter().find(|s| s.program_id == program_id).map(|s| &s.scene)
    }
    #[cfg(test)]
    pub fn scene_size(&self, program_id: u32) -> Option<(u32, u32)> {
        self.scenes.iter().find(|s| s.program_id == program_id).map(|s| s.size)
    }
    pub fn scene_ids(&self) -> Vec<u32> { self.scenes.iter().map(|s| s.window_id).collect() }
    pub fn dirty_scenes(&mut self) -> Vec<SceneDraw> {
        let mut out = Vec::new();
        for scene in &mut self.scenes {
            if !scene.dirty { continue; }
            scene.dirty = false;
            out.push(SceneDraw { window_id: scene.window_id, scene: scene.scene.clone(), meshes: scene.meshes.clone(), size: scene.size });
        }
        out
    }
    #[cfg(test)]
    pub fn showcase_gen(&self) -> u64 { self.generation }


    /// `ED 2` on a screen: text-anchored layers on that screen go.
    /// `scrolled` is the boundary the engine's own clear left (its
    /// lines are already in history above it), so the layers above it
    /// went with the screen and the scrollback's stay.
    pub fn clear_screen(&mut self, alternate: bool, scrolled: u64) {
        self.drop_where(|w| w.alternate == alternate && below(w, scrolled));
    }

    /// `ED 3`: the saved lines go, and the layers anchored to them.
    pub fn clear_saved(&mut self, scrolled: u64) {
        self.drop_where(|w| !w.alternate && below(w, scrolled));
    }

    /// The exclusive absolute line past the lowest text-anchored layer on
    /// this screen, if any. Window-pinned layers do not move with text.
    pub fn anchored_end(&self, alternate: bool) -> Option<u64> {
        let mut end = None;
        let mut note = |w: &Wanted| {
            if !w.text || w.alternate != alternate || w.line == u64::MAX {
                return;
            }
            let (_, height) = cells_size(w);
            let bottom = w.line.saturating_add(height.max(1.0).ceil() as u64);
            end = Some(end.unwrap_or(0).max(bottom));
        };
        for w in &self.layers {
            note(w);
        }
        for (_, ws) in &self.groups {
            for w in ws {
                note(w);
            }
        }
        for scene in &self.scenes {
            note(&scene.wanted);
        }
        end
    }

    /// Text-anchored layers move and crop with a scroll region, through
    /// the same rectangle math the picture store uses.
    pub fn scroll_text(
        &mut self,
        band: &super::motion::BandScroll,
        image: impl Fn(u32) -> (u32, u32),
    ) {
        let mut born = Vec::new();
        self.map_text(|w| {
            if w.alternate != band.alternate {
                return;
            }
            if let Some(extra) = scroll_wanted(w, band, &image) {
                born.push(extra);
            }
        });
        self.layers.extend(born);
        self.drop_where(|w| w.line == u64::MAX);
    }

    /// Text-anchored layers stay on the same text through a reflow.
    pub fn reflow_text(&mut self, reflow: &super::motion::Reflow) {
        self.map_text(|w| {
            if !w.text || w.alternate {
                return;
            }
            let column = cells_col(w);
            if let Some((line, column)) = super::motion::map_anchor(reflow, w.line, column) {
                w.line = line;
                set_cells_col(w, column);
            } else {
                w.line = u64::MAX;
            }
        });
        self.drop_where(|w| w.line == u64::MAX);
    }

    fn map_text(&mut self, mut f: impl FnMut(&mut Wanted)) {
        for w in &mut self.layers {
            if w.text {
                f(w);
            }
        }
        for members in self.groups.iter_mut() {
            for w in members.1.iter_mut() {
                if w.text {
                    f(w);
                }
            }
        }
        for scene in &mut self.scenes {
            if scene.wanted.text {
                f(&mut scene.wanted);
            }
        }
    }

    /// Leaving the alternate screen: its text-anchored layers go, solo
    /// and grouped, whatever line they sit on.
    pub fn leave_alternate(&mut self) {
        self.drop_where(|w| w.alternate);
    }

    /// `RIS`, or the program's exit: everything this dialect made goes.
    pub fn reset(&mut self) {
        let next_mesh = self.next_mesh;
        *self = Self::new();
        self.next_mesh = next_mesh;
    }

    /// Drop the text-anchored layers `drop` names, solo and grouped;
    /// window-pinned layers are never dropped by a text rule.
    fn drop_where(&mut self, drop: impl Fn(&Wanted) -> bool) {
        self.layers.retain(|w| !w.text || !drop(w));
        for (_, ws) in &mut self.groups {
            ws.retain(|w| !w.text || !drop(w));
        }
        self.scenes.retain(|s| !s.wanted.text || !drop(&s.wanted));
    }
}

/// Whether a layer's text anchor sits below `scrolled` — the lines that
/// left for history, or were cleared away.
fn cells_col(w: &Wanted) -> f32 {
    match w.placement {
        angel_glass::Placement::Cells(c) => c[0],
        _ => 0.0,
    }
}

fn set_cells_col(w: &mut Wanted, column: f32) {
    if let angel_glass::Placement::Cells(c) = &mut w.placement {
        c[0] = column;
    }
}

fn cells_size(w: &Wanted) -> (f32, f32) {
    match w.placement {
        angel_glass::Placement::Cells(c) => (c[2], c[3]),
        _ => (1.0, 1.0),
    }
}

fn set_cells_size(w: &mut Wanted, width: f32, height: f32) {
    if let angel_glass::Placement::Cells(c) = &mut w.placement {
        c[2] = width;
        c[3] = height;
    }
}

fn picture_id(kind: &angel_glass::LayerKind) -> Option<u32> {
    match kind {
        angel_glass::LayerKind::Picture(id) | angel_glass::LayerKind::PicturePart(id, _) => Some(*id),
        _ => None,
    }
}

/// Move or cut one text-anchored layer. Returns an extra layer when the
/// scroll split it; `None` when the layer was removed.
fn scroll_wanted(
    w: &mut Wanted,
    band: &super::motion::BandScroll,
    image: &impl Fn(u32) -> (u32, u32),
) -> Option<Wanted> {
    if !w.text || w.alternate != band.alternate {
        return None;
    }
    let (width, height) = cells_size(w);
    let px = picture_id(&w.kind).map(image).unwrap_or((0, 0));
    let source = match w.kind {
        angel_glass::LayerKind::PicturePart(_, src) => Some(src),
        _ => None,
    };
    let rect = super::motion::Rect {
        line: w.line,
        column: cells_col(w),
        width,
        height,
        source,
    };
    match super::motion::scroll_rect(rect, band, px) {
        super::motion::Fate::Keep(next) => {
            write_wanted(w, &next);
            None
        }
        super::motion::Fate::Split(first, _) => {
            write_wanted(w, &first);
            None
        }
        super::motion::Fate::Gone => {
            w.line = u64::MAX;
            None
        }
    }
}

fn write_wanted(w: &mut Wanted, rect: &super::motion::Rect) {
    w.line = rect.line;
    set_cells_col(w, rect.column);
    set_cells_size(w, rect.width, rect.height);
    if let Some(src) = rect.source {
        let id = picture_id(&w.kind).unwrap_or(0);
        w.kind = angel_glass::LayerKind::PicturePart(id, src);
    }
}

fn below(w: &Wanted, scrolled: u64) -> bool {
    w.line < scrolled
}

/// A cells placement against a view row.
fn place_at(p: &angel_glass::Placement, row: f32) -> angel_glass::Placement {
    match p {
        angel_glass::Placement::Cells([c, _, w, h]) => angel_glass::Placement::Cells([*c, row, *w, *h]),
        other => other.clone(),
    }
}

/// A placement's height in cells, for the visibility test.
fn rect_h(p: &angel_glass::Placement) -> f32 {
    match p {
        angel_glass::Placement::Cells([_, _, _, h]) => *h,
        angel_glass::Placement::Pixels(_) => f32::from(u16::MAX),
    }
}

/// The dialect's entry point: one lifted `glass;` body. Replies go out
/// only when the program gave `r=`, and errors never panic.
pub fn handle(body: &[u8], canvas: &mut dyn Canvas) {
    let text = String::from_utf8_lossy(body);
    let Some(rest) = text.strip_prefix("glass;") else { return };
    // Op, key fields, then the payload as the last field for the ops
    // that take one (everything else is keys).
    let mut fields: Vec<&str> = rest.split(';').collect();
    let op = fields.first().copied().unwrap_or("").to_string();
    fields.remove(0);
    // The payload is the last field, and only when it cannot be a key:
    // a key=value field carries its '=' inside, base64 padding only at
    // the end (and a payload never travels without keys before it,
    // since every payload op needs at least id=).
    let takes_payload = PAYLOAD_OPS.contains(&op.as_str());
    let last_is_payload = match fields.last() {
        Some(last) if takes_payload && fields.len() >= 2 => {
            !last.contains('=') || last.ends_with('=')
        }
        _ => false,
    };
    let mut payload = "";
    if last_is_payload {
        payload = fields.pop().unwrap_or("");
    }
    let keys = Keys::from_parts(&op, &fields);
    // A chunked picture owns its reply: the first piece's `r` answers
    // when the last piece lands, so every other op replies here.
    let token = keys.get("r").map(str::to_string);
    let chunked_picture = matches!(op.as_str(), "picture" | "frame") && keys.get("m").is_some_and(|v| v == "1");
    let result = dispatch(&keys, payload, canvas);
    if !chunked_picture && let Some(token) = token {
        let reply = match result {
            Ok(extra) => format!("\x1b_glass;r={token};OK;{extra}\x1b\\"),
            Err(Bad(code, message)) => format!("\x1b_glass;r={token};{code}:{message}\x1b\\"),
        };
        canvas.reply(reply.into_bytes());
    }
}

fn dispatch(keys: &Keys, payload: &str, canvas: &mut dyn Canvas) -> Result<String, Bad> {
    // The op must be one this build takes before its keys are read.
    if !OPS.contains(&keys.op.as_str()) {
        return Err(Bad("EINVAL".into(), format!("unknown op {}", keys.op)));
    }
    keys.check()?;
    match keys.op.as_str() {
        "hello" => Ok(format!("v={VERSION},ops={}", OPS.join(","))),
        "picture" => picture(keys, payload, canvas),
        "layer" => layer(keys, canvas),
        "group" => group(keys, payload, canvas),
        "remove" => remove(keys, canvas),
        "showcase" => showcase(keys, canvas),
        "scene" => scene(keys, payload, canvas),
        "frame" => frame(keys, payload, canvas),
        "chart" => chart(keys, payload, canvas),
        "model" => model(keys, payload, canvas),
        "page" => page(keys, payload, canvas),
        "progress" => progress(keys, canvas),
        _ => unreachable!(),
    }
}

/// `picture`: upload a picture under a program id, decoding through the
/// APC graphics adapter's loader — `f=100` takes whatever the image crate
/// decodes (PNG, JPEG, GIF, TIFF, WebP, BMP, ICO, TGA, PNM), plus raw
/// `f=32` and `f=24`, the same compression (`o=z`) and caps. Chunked transmissions ride the store's
/// one-open-transmission rule; the first piece's keys govern, and the
/// reply waits for the last piece.
fn picture(keys: &Keys, payload: &str, canvas: &mut dyn Canvas) -> Result<String, Bad> {
    let data = payload.as_bytes().to_vec();
    if let Some(key) = canvas.open_chunk() {
        // A continuation: whatever keys it repeats, the first piece's
        // govern; only its `m` says whether more follow.
        let more = keys.flag("m")? == Some(true);
        let assembled = canvas.chunk(key, &data, more);
        if more {
            return Ok(String::new());
        }
        let first = Keys::parse(&String::from_utf8_lossy(&canvas.take_chunk_head(key)));
        let result = finish_payload(&first, &assembled, canvas);
        if let Some(token) = first.get("r").map(str::to_string) {
            let reply = match &result {
                Ok(extra) => format!("\x1b_glass;r={token};OK;{extra}\x1b\\"),
                Err(Bad(code, message)) => format!("\x1b_glass;r={token};{code}:{message}\x1b\\"),
            };
            canvas.reply(reply.into_bytes());
        }
        return result.map(|_| String::new());
    }
    if keys.flag("m")? == Some(true) {
        let key = canvas.begin_chunk();
        canvas.chunk_head(key, keys.raw.clone());
        canvas.chunk(key, &data, true);
        return Ok(String::new());
    }
    upload(keys, &data, canvas)
}

/// One whole picture payload, decoded and kept under the program's id.
fn upload(keys: &Keys, data: &[u8], canvas: &mut dyn Canvas) -> Result<String, Bad> {
    let Some(id) = keys.u32("id")? else {
        return Err(Bad("EINVAL".into(), "picture needs id=".into()));
    };
    if id >= ID_BASE {
        return Err(Bad("EINVAL".into(), format!("id must be under {ID_BASE:#x}")));
    }
    // The same loader the APC graphics adapter uses, under its caps and
    // the store's budget: `f=100|32|24`, `o=z`, `s=`/`v=` for raw data.
    let key_text = format!(
        "f={},s={},v={},o={}",
        keys.get("f").unwrap_or("32"),
        keys.get("s").unwrap_or("0"),
        keys.get("v").unwrap_or("0"),
        keys.get("o").unwrap_or(""),
    );
    let (width, height, rgba) = apc_graphics::load_picture(&key_text, data)
        .map_err(|(code, message)| Bad(code, message))?;
    let window_id = ID_BASE + id;
    canvas.store(super::Picture { id: window_id, width, height, rgba, space: super::Space::Glass });
    let kept = Kept { id };
    let pictures = &mut canvas.expansion().pictures;
    if let Some(at) = pictures.iter().position(|k| k.id == id) {
        pictures[at] = kept;
    } else {
        pictures.push(kept);
    }
    Ok(String::new())
}

/// `layer`: create or replace one layer by `id`.
fn layer(keys: &Keys, canvas: &mut dyn Canvas) -> Result<String, Bad> {
    let wanted = wanted_layer(keys, canvas)?;
    let id = wanted.id;
    let state = canvas.expansion();
    if let Some(at) = state.layers.iter().position(|w| w.id == id) {
        state.layers[at] = wanted;
    } else {
        state.layers.push(wanted);
    }
    Ok(String::new())
}

/// `group`: replace a whole set in one go, for per-frame animation. The
/// payload is `n` layer records, newline-separated, base64-encoded.
fn group(keys: &Keys, payload: &str, canvas: &mut dyn Canvas) -> Result<String, Bad> {
    let Some(group_id) = keys.u32("g")? else {
        return Err(Bad("EINVAL".into(), "group needs g=".into()));
    };
    let Some(count) = keys.u32("n")? else {
        return Err(Bad("EINVAL".into(), "group needs n=".into()));
    };
    if count as usize > GROUP_CAP {
        return Err(Bad("EINVAL".into(), format!("n is capped at {GROUP_CAP}")));
    }
    let decoded = base64(payload.as_bytes())
        .ok_or_else(|| Bad("EBADF".into(), "payload is not base64".into()))?;
    if decoded.len() > GROUP_BYTES {
        return Err(Bad("EFBIG".into(), format!("payload is capped at {GROUP_BYTES} bytes")));
    }
    let text = String::from_utf8(decoded)
        .map_err(|_| Bad("EBADF".into(), "payload is not layer records".into()))?;
    let mut wanted = Vec::with_capacity(count.min(1024) as usize);
    for (i, line) in text.split('\n').enumerate() {
        if i as u32 >= count {
            break;
        }
        if line.is_empty() {
            continue;
        }
        let record = Keys::parse(line);
        if record.op != "layer" {
            return Err(Bad("EINVAL".into(), format!("record {} is not a layer record", i + 1)));
        }
        record.check()?;
        wanted.push(wanted_layer(&record, canvas)?);
    }
    if wanted.len() != count as usize {
        return Err(Bad("EINVAL".into(), format!("payload holds {} records, n= said {count}", wanted.len())));
    }
    let state = canvas.expansion();
    if let Some(at) = state.groups.iter().position(|(g, _)| *g == group_id) {
        state.groups[at].1 = wanted;
    } else {
        state.groups.push((group_id, wanted));
    }
    Ok(String::new())
}

/// `remove`: `id=` one layer (or an `a-b` span), `g=` one group,
/// `all=1` everything this dialect made.
fn remove(keys: &Keys, canvas: &mut dyn Canvas) -> Result<String, Bad> {
    if keys.flag("all")? == Some(true) {
        *canvas.expansion() = Expansion::new();
        return Ok(String::new());
    }
    if let Some(span) = keys.get("id") {
        let (from, to) = match span.split_once('-') {
            Some((a, b)) => match (a.parse::<u32>(), b.parse::<u32>()) {
                (Ok(a), Ok(b)) => (a, b),
                _ => return Err(Bad("EINVAL".into(), "id= is not an id or an a-b range".into())),
            },
            None => match span.parse::<u32>() {
                Ok(id) => (id, id),
                Err(_) => return Err(Bad("EINVAL".into(), "id= is not an id or an a-b range".into())),
            },
        };
        if to < from {
            return Err(Bad("EINVAL".into(), "the id= range ends before it starts".into()));
        }
        let state = canvas.expansion();
        state.layers.retain(|w| w.id < ID_BASE + from || w.id > ID_BASE + to);
        state.scenes.retain(|s| s.window_id < ID_BASE + from || s.window_id > ID_BASE + to);
        return Ok(String::new());
    }
    if let Some(group_id) = keys.u32("g")? {
        canvas.expansion().groups.retain(|(g, _)| *g != group_id);
        return Ok(String::new());
    }
    Err(Bad("EINVAL".into(), "remove needs id=, g= or all=1".into()))
}

/// `showcase`: open on an uploaded picture, a sized video panel, events, or close.
fn showcase(keys: &Keys, canvas: &mut dyn Canvas) -> Result<String, Bad> {
    if let Some(on) = keys.flag("events")? {
        canvas.expansion().events = on;
    }
    if keys.flag("close")? == Some(true) {
        let state = canvas.expansion();
        state.ask = None;
        state.pending_frame = None;
        return Ok(String::new());
    }
    let fit = fit_of(keys)?;
    let has_id = keys.get("id").is_some();
    let has_size = keys.get("s").is_some() || keys.get("v").is_some();
    if has_id && has_size {
        return Err(Bad("EINVAL".into(), "showcase takes a picture or a size, not both".into()));
    }
    if has_id {
        let id = keys.u32("id")?.expect("id present");
        if !canvas.expansion().pictures.iter().any(|k| k.id == id) {
            return Err(Bad("EINVAL".into(), format!("no picture {id} was uploaded")));
        }
        let state = canvas.expansion();
        state.ask = Some(ShowcaseAsk::Picture { id, fit });
        if state.progress.is_some() { state.progress_dirty = true; }
        return Ok(String::new());
    }
    if has_size {
        let (width, height) = size_pair(keys, "showcase")?;
        let state = canvas.expansion();
        if let Some(ShowcaseAsk::Video { width: w, height: h, fit: old, .. }) = &state.ask
            && *w == width && *h == height && *old == fit
        {
            return Ok(String::new());
        }
        let generation = bump(state);
        state.ask = Some(ShowcaseAsk::Video { width, height, fit, generation });
        return Ok(String::new());
    }
    if keys.get("events").is_some() { return Ok(String::new()); }
    Err(Bad("EINVAL".into(), "showcase needs id=, s= and v=, events= or close=1".into()))
}

/// The furthest a layer may lift, as the stage caps it.
const MAX_LIFT: f32 = 8192.0;

/// The most motes one emitter may keep in the air, as the stage caps it.
const MAX_MOTES: u16 = 4096;

/// One layer record's keys, as the frame draws it.
fn wanted_layer(keys: &Keys, canvas: &mut dyn Canvas) -> Result<Wanted, Bad> {
    let program_id = keys.u32("id")?.ok_or_else(|| Bad("EINVAL".into(), "layer needs id=".into()))?;
    if program_id >= ID_BASE {
        return Err(Bad("EINVAL".into(), format!("id must be under {ID_BASE:#x}")));
    }
    let id = ID_BASE + program_id;
    let z = keys.i32("z")?.unwrap_or(0);
    let opacity = match keys.f32("o")? {
        None => 1.0,
        Some(v) if (0.0..=1.0).contains(&v) => v,
        Some(_) => return Err(Bad("EINVAL".into(), "o= is outside 0..1".into())),
    };
    let angle = keys.f32("a")?.unwrap_or(0.0);
    let height = keys.f32("h")?.unwrap_or(0.0).clamp(0.0, MAX_LIFT);
    let breathe = keys.f32("b")?.unwrap_or(0.0).clamp(0.0, MAX_LIFT);
    let additive = keys.flag("add")?.unwrap_or(false);
    let flicker = keys.f32("fl")?.unwrap_or(0.0).clamp(0.0, 1.0);
    let stand = match keys.get("stand") {
        None | Some("floor") => angel_glass::Stand::Floor,
        Some("up") => angel_glass::Stand::Upright(foot_of(keys)?),
        Some("screen") => angel_glass::Stand::Screen,
        Some(other) => {
            return Err(Bad("EINVAL".into(), format!("stand={other} is not floor, up or screen")))
        }
    };
    let (placement, text, line, alternate) = placement_of(keys, canvas)?;
    let kind = kind_of(keys, canvas)?;
    Ok(Wanted {
        id,
        z,
        opacity,
        angle,
        height,
        breathe,
        additive,
        flicker,
        stand,
        placement,
        kind,
        text,
        line,
        alternate,
    })
}

/// A `stand=up` foot: `up=x,y` in placement pixels.
fn foot_of(keys: &Keys) -> Result<[f32; 2], Bad> {
    let Some(v) = keys.get("up") else { return Ok([0.0, 0.0]) };
    let bad = || Bad("EINVAL".into(), "up= is not two numbers".into());
    let mut parts = v.split(',');
    let x = parts.next().unwrap_or("").parse::<f32>().ok().filter(|n| n.is_finite()).ok_or_else(bad)?;
    let y = parts.next().unwrap_or("").parse::<f32>().ok().filter(|n| n.is_finite()).ok_or_else(bad)?;
    if parts.next().is_some() {
        return Err(bad());
    }
    Ok([x, y])
}

/// A record's placement: `at=` cells anchored to the text by default,
/// `anchor=window` pinning it, or `px=` window pixels always pinned.
/// Text-anchored placements pin to the absolute line the cursor stands
/// on, exactly as the intake's own adapters pin theirs.
fn placement_of(keys: &Keys, canvas: &mut dyn Canvas) -> Result<(angel_glass::Placement, bool, u64, bool), Bad> {
    if let Some(v) = keys.get("px") {
        let quad = list4(Some(v), "px")?;
        return Ok((angel_glass::Placement::Pixels(quad), false, 0, false));
    }
    let Some(v) = keys.get("at") else {
        return Err(Bad("EINVAL".into(), "layer needs at= or px=".into()));
    };
    let quad = list4(Some(v), "at")?;
    if keys.get("anchor").is_some_and(|v| v == "window") {
        return Ok((angel_glass::Placement::Cells(quad), false, 0, false));
    }
    let (cursor_row, _column) = canvas.cursor();
    let alternate = canvas.alternate();
    let scrolled = canvas.scrolled();
    // The anchor is the cursor's absolute line; `at=`'s row counts from
    // there, so a layer rides the text it was placed against.
    let line = scrolled.saturating_add(u64::from(cursor_row)).saturating_add(quad[1] as u64);
    let quad = [quad[0], 0.0, quad[2], quad[3]];
    Ok((angel_glass::Placement::Cells(quad), true, line, alternate))
}

/// A record's kind: every kind the stage draws.
fn kind_of(keys: &Keys, canvas: &mut dyn Canvas) -> Result<angel_glass::LayerKind, Bad> {
    Ok(match keys.get("k").unwrap_or("solid") {
        "solid" => angel_glass::LayerKind::Solid(rgba_of(keys)?),
        "picture" => {
            let id = keys.u32("p")?.ok_or_else(|| Bad("EINVAL".into(), "picture needs p=".into()))?;
            let gpu = canvas
                .gpu_of(ID_BASE + id)
                .ok_or_else(|| Bad("EINVAL".into(), format!("no picture {id} was uploaded")))?;
            angel_glass::LayerKind::Picture(gpu)
        }
        "part" => {
            let id = keys.u32("p")?.ok_or_else(|| Bad("EINVAL".into(), "part needs p=".into()))?;
            let gpu = canvas
                .gpu_of(ID_BASE + id)
                .ok_or_else(|| Bad("EINVAL".into(), format!("no picture {id} was uploaded")))?;
            let quad = keys.quad("src")?.ok_or_else(|| Bad("EINVAL".into(), "part needs src=".into()))?;
            angel_glass::LayerKind::PicturePart(gpu, quad)
        }
        "glow" => angel_glass::LayerKind::Glow(rgba_of(keys)?),
        "particles" => angel_glass::LayerKind::Particles(particles_of(keys)),
        "prim" => {
            let shape = keys.u32("shape")?.unwrap_or(0);
            if shape > 6 {
                return Err(Bad("EINVAL".into(), "shape is 0..6".into()));
            }
            let speed = keys.f32("speed")?.unwrap_or(1.0);
            let phase = keys.f32("phase")?.unwrap_or(0.0);
            angel_glass::LayerKind::Primitive { shape, color: rgba_of(keys)?, phase, speed }
        }
        other => return Err(Bad("EINVAL".into(), format!("k={other} is not a kind"))),
    })
}

/// A particle emitter, with the stage's own caps.
fn particles_of(keys: &Keys) -> angel_glass::Particles {
    angel_glass::Particles {
        color: rgba_of(keys).unwrap_or([1.0, 1.0, 1.0, 1.0]),
        count: keys.u32("n").unwrap_or(None).unwrap_or(64).min(u32::from(MAX_MOTES)) as u16,
        size: keys.f32("size").unwrap_or(None).unwrap_or(3.0).clamp(0.5, 64.0),
        life: keys.f32("life").unwrap_or(None).unwrap_or(2.0).clamp(0.05, 600.0),
        rise: keys.f32("rise").unwrap_or(None).unwrap_or(20.0).clamp(-MAX_LIFT, MAX_LIFT),
        sway: keys.f32("sway").unwrap_or(None).unwrap_or(8.0).clamp(-MAX_LIFT, MAX_LIFT),
        seed: keys.u32("seed").unwrap_or(None).unwrap_or(0),
        burst: keys.f32("burst").unwrap_or(None),
    }
}

/// Counters the session last told the program, so an event fires only
/// when one changes.
#[derive(Clone, Copy, Default)]
pub struct ShowcaseSeen {
    pub baselined: bool,
    pub steps: i32,
    pub copies: u32,
    pub dismissals: u32,
    pub clicks: u32,
}

/// The window's showcase counters, as `render` read them.
#[derive(Clone, Copy, Default)]
pub struct ShowcaseNow {
    pub seek: Option<f32>,
    pub steps: i32,
    pub copies: u32,
    pub dismissals: u32,
    pub clicks: u32,
}

/// `ESC _ glass;event;showcase;<key>=<value> ESC \`, in the order the
/// counters are read. Nothing, unless the program opted in.
pub fn showcase_event_bytes(opted_in: bool, seen: &mut ShowcaseSeen, now: ShowcaseNow) -> Vec<u8> {
    if !opted_in {
        return Vec::new();
    }
    let mut changes: Vec<(&str, String)> = Vec::new();
    if let Some(seek) = now.seek {
        changes.push(("seek", format_seek(seek)));
    }
    if seen.baselined {
        if seen.steps != now.steps {
            changes.push(("steps", now.steps.to_string()));
        }
        if seen.copies != now.copies {
            changes.push(("copies", now.copies.to_string()));
        }
        if seen.dismissals != now.dismissals {
            changes.push(("dismissals", now.dismissals.to_string()));
        }
        if seen.clicks != now.clicks {
            changes.push(("clicks", now.clicks.to_string()));
        }
        if now.dismissals > seen.dismissals {
            changes.push(("close", "1".into()));
        }
    }
    seen.steps = now.steps;
    seen.copies = now.copies;
    seen.dismissals = now.dismissals;
    seen.clicks = now.clicks;
    seen.baselined = true;
    let mut out = Vec::new();
    for (key, value) in &changes {
        out.extend(format!("\x1b_glass;event;showcase;{key}={value}\x1b\\").into_bytes());
    }
    out
}

/// A seek value, short and stable.
pub fn format_seek(v: f32) -> String {
    let text = format!("{v:.6}");
    let trimmed = text.trim_end_matches('0').trim_end_matches('.');
    if trimmed.is_empty() || trimmed == "-" { "0".into() } else { trimmed.to_string() }
}

fn wire_err(err: super::glass_scene::WireError) -> Bad {
    Bad(err.code.into(), err.message)
}

fn size_pair(keys: &Keys, op: &str) -> Result<(u32, u32), Bad> {
    let Some(width) = keys.u32("s")? else {
        return Err(Bad("EINVAL".into(), format!("{op} needs s=")));
    };
    let Some(height) = keys.u32("v")? else {
        return Err(Bad("EINVAL".into(), format!("{op} needs v=")));
    };
    super::glass_scene::pixel_size(width, height).map_err(wire_err)
}

fn fit_of(keys: &Keys) -> Result<angel_glass::Fit, Bad> {
    match keys.get("fit") {
        None | Some("contain") => Ok(angel_glass::Fit::Contain),
        Some("width") => Ok(angel_glass::Fit::Width),
        Some(other) => Err(Bad("EINVAL".into(), format!("fit={other} is not contain or width"))),
    }
}

fn bump(state: &mut Expansion) -> u64 {
    state.generation = state.generation.saturating_add(1);
    if state.progress.is_some() {
        state.progress_dirty = true;
    }
    state.generation
}

/// `scene`: a placed 3D scene, drawn into a picture and shown like a layer.
fn scene(keys: &Keys, payload: &str, canvas: &mut dyn Canvas) -> Result<String, Bad> {
    let Some(id) = keys.u32("id")? else {
        return Err(Bad("EINVAL".into(), "scene needs id=".into()));
    };
    if id >= ID_BASE {
        return Err(Bad("EINVAL".into(), format!("id must be under {ID_BASE:#x}")));
    }
    let size = size_pair(keys, "scene")?;
    let wanted = scene_wanted(keys, canvas, ID_BASE + id)?;
    let decoded = base64(payload.as_bytes())
        .ok_or_else(|| Bad("EBADF".into(), "payload is not base64".into()))?;
    if decoded.len() > super::glass_scene::SCENE_BYTES {
        return Err(Bad(
            "EFBIG".into(),
            format!("scene payload is capped at {} bytes", super::glass_scene::SCENE_BYTES),
        ));
    }
    let wired = super::glass_scene::parse(&decoded).map_err(wire_err)?;
    let state = canvas.expansion();
    let (scene, meshes) = assign_meshes(state, wired);
    let kept = KeptScene {
        program_id: id,
        window_id: ID_BASE + id,
        scene,
        meshes,
        size,
        wanted,
        dirty: true,
    };
    if let Some(at) = state.scenes.iter().position(|s| s.program_id == id) {
        state.scenes[at] = kept;
    } else {
        state.scenes.push(kept);
    }
    Ok(String::new())
}

fn assign_meshes(
    state: &mut Expansion,
    mut wired: super::glass_scene::Wired,
) -> (angel_glass::scene::Scene, Vec<(u32, angel_glass::scene::MeshData)>) {
    use angel_glass::scene::MeshRef;
    let mut meshes = Vec::new();
    for node in &mut wired.scene.nodes {
        if let Some(MeshRef::Uploaded(index)) = node.mesh {
            let id = state.next_mesh;
            state.next_mesh = state.next_mesh.saturating_add(1);
            let mesh = wired.meshes[index as usize].clone();
            node.mesh = Some(MeshRef::Uploaded(id));
            meshes.push((id, mesh));
        }
    }
    (wired.scene, meshes)
}

fn scene_wanted(keys: &Keys, canvas: &mut dyn Canvas, window_id: u32) -> Result<Wanted, Bad> {
    let (placement, text, line, alternate) = placement_of(keys, canvas).map_err(|Bad(code, message)| {
        Bad(code, message.replace("layer needs", "scene needs"))
    })?;
    let positive = match &placement {
        angel_glass::Placement::Cells([_, _, w, h]) | angel_glass::Placement::Pixels([_, _, w, h]) => {
            *w > 0.0 && *h > 0.0
        }
    };
    if !positive {
        return Err(Bad("EINVAL".into(), "scene placement must have a positive size".into()));
    }
    Ok(Wanted {
        id: window_id,
        z: keys.i32("z")?.unwrap_or(1),
        opacity: match keys.f32("o")? {
            None => 1.0,
            Some(v) if (0.0..=1.0).contains(&v) => v,
            Some(_) => return Err(Bad("EINVAL".into(), "o= is outside 0..1".into())),
        },
        angle: 0.0,
        height: 0.0,
        breathe: 0.0,
        additive: false,
        flicker: 0.0,
        stand: angel_glass::Stand::Floor,
        placement,
        kind: angel_glass::LayerKind::Picture(window_id),
        text,
        line,
        alternate,
    })
}

/// `frame`: one video frame, a picture upload or raw RGBA, chunked like
/// `picture`. `id=` names a picture already uploaded.
fn frame(keys: &Keys, payload: &str, canvas: &mut dyn Canvas) -> Result<String, Bad> {
    if canvas.open_chunk().is_some() || keys.flag("m")? == Some(true) {
        return picture(keys, payload, canvas);
    }
    store_frame(keys, payload.as_bytes(), canvas)
}

fn finish_payload(keys: &Keys, data: &[u8], canvas: &mut dyn Canvas) -> Result<String, Bad> {
    if keys.op == "frame" {
        store_frame(keys, data, canvas)
    } else {
        upload(keys, data, canvas)
    }
}

fn store_frame(keys: &Keys, data: &[u8], canvas: &mut dyn Canvas) -> Result<String, Bad> {
    if let Some(id) = keys.u32("id")? {
        if !canvas.expansion().pictures.iter().any(|k| k.id == id) {
            return Err(Bad("EINVAL".into(), format!("no picture {id} was uploaded")));
        }
        canvas.expansion().pending_frame = Some(PendingFrame::Picture(id));
        return Ok(String::new());
    }
    if data.is_empty() {
        return Err(Bad("EINVAL".into(), "frame needs id= or a picture payload".into()));
    }
    if data.len() > super::glass_scene::SCENE_BYTES {
        return Err(Bad(
            "EFBIG".into(),
            format!("frame payload is capped at {} bytes", super::glass_scene::SCENE_BYTES),
        ));
    }
    let key_text = format!(
        "f={},s={},v={},o={}",
        keys.get("f").unwrap_or("32"),
        keys.get("s").unwrap_or("0"),
        keys.get("v").unwrap_or("0"),
        keys.get("o").unwrap_or(""),
    );
    let (width, height, rgba) =
        apc_graphics::load_picture(&key_text, data).map_err(|(code, message)| Bad(code, message))?;
    super::glass_scene::pixel_size(width, height).map_err(wire_err)?;
    canvas.expansion().pending_frame = Some(PendingFrame::Pixels { width, height, rgba });
    Ok(String::new())
}

/// `chart`: marks over a picture uploaded with `picture`. `p` names that
/// picture, and its size is the chart's size. The marks lie over it.
/// Without `p=` it is an error. The same request does not reopen the showcase.
fn chart(keys: &Keys, payload: &str, canvas: &mut dyn Canvas) -> Result<String, Bad> {
    let Some(id) = keys.u32("p")? else {
        return Err(Bad("EINVAL".into(), "chart needs p=".into()));
    };
    if id >= ID_BASE {
        return Err(Bad("EINVAL".into(), "picture id is out of range".into()));
    }
    let Some(size) = canvas.glass_size(ID_BASE + id) else {
        return Err(Bad("ENOENT".into(), "no such picture".into()));
    };
    let fit = fit_of(keys)?;
    let Some(count) = keys.u32("n")? else {
        return Err(Bad("EINVAL".into(), "chart needs n=".into()));
    };
    if count as usize > CHART_CAP {
        return Err(Bad("EINVAL".into(), format!("n is capped at {CHART_CAP}")));
    }
    let marks = chart_marks(payload, count)?;
    let state = canvas.expansion();
    if let Some(ShowcaseAsk::Chart {
        marks: old,
        size: old_size,
        fit: old_fit,
        picture,
        ..
    }) = &state.ask
        && old == &marks
        && *old_size == size
        && *old_fit == fit
        && *picture == id
    {
        return Ok(String::new());
    }
    let generation = bump(state);
    state.ask = Some(ShowcaseAsk::Chart { marks, size, fit, picture: id, generation });
    Ok(String::new())
}

fn chart_marks(payload: &str, count: u32) -> Result<Vec<angel_glass::Mark>, Bad> {
    let decoded = base64(payload.as_bytes())
        .ok_or_else(|| Bad("EBADF".into(), "payload is not base64".into()))?;
    if decoded.len() > GROUP_BYTES {
        return Err(Bad("EFBIG".into(), format!("payload is capped at {GROUP_BYTES} bytes")));
    }
    let text = String::from_utf8(decoded)
        .map_err(|_| Bad("EBADF".into(), "payload is not mark records".into()))?;
    let mut marks = Vec::new();
    for (i, line) in text.split('\n').enumerate() {
        if i as u32 >= count {
            break;
        }
        if line.is_empty() {
            continue;
        }
        let record = Keys::parse(line);
        if record.op != "mark" {
            return Err(Bad("EINVAL".into(), format!("record {} is not a mark record", i + 1)));
        }
        record.check()?;
        let x = record.f32("x")?.ok_or_else(|| Bad("EINVAL".into(), format!("mark {} needs x=", i + 1)))?;
        let y = record.f32("y")?.ok_or_else(|| Bad("EINVAL".into(), format!("mark {} needs y=", i + 1)))?;
        let w = record.f32("w")?.ok_or_else(|| Bad("EINVAL".into(), format!("mark {} needs w=", i + 1)))?;
        let h = record.f32("h")?.ok_or_else(|| Bad("EINVAL".into(), format!("mark {} needs h=", i + 1)))?;
        if w <= 0.0 || h <= 0.0 {
            return Err(Bad("EINVAL".into(), format!("mark {} must have a positive size", i + 1)));
        }
        let anchor = match (record.f32("ax")?, record.f32("ay")?) {
            (Some(ax), Some(ay)) => [ax, ay],
            (None, None) => [x + w * 0.5, y + h * 0.5],
            _ => return Err(Bad("EINVAL".into(), format!("mark {} needs both ax= and ay=, or neither", i + 1))),
        };
        let text = record
            .get("t")
            .map(|t| t.split('|').map(str::to_string).collect())
            .unwrap_or_default();
        marks.push(angel_glass::Mark { rect: [x, y, w, h], anchor, text });
    }
    if marks.len() != count as usize {
        return Err(Bad("EINVAL".into(), format!("payload holds {} records, n= said {count}", marks.len())));
    }
    Ok(marks)
}

/// `model`: scene nodes, through the scene wire, shown in the showcase.
fn model(keys: &Keys, payload: &str, canvas: &mut dyn Canvas) -> Result<String, Bad> {
    let size = size_pair(keys, "model")?;
    let fit = fit_of(keys)?;
    let decoded = base64(payload.as_bytes())
        .ok_or_else(|| Bad("EBADF".into(), "payload is not base64".into()))?;
    if decoded.len() > super::glass_scene::SCENE_BYTES {
        return Err(Bad(
            "EFBIG".into(),
            format!("model payload is capped at {} bytes", super::glass_scene::SCENE_BYTES),
        ));
    }
    let wired = super::glass_scene::parse(&decoded).map_err(wire_err)?;
    if wired.scene.nodes.is_empty() {
        return Err(Bad("EINVAL".into(), "model needs at least one node".into()));
    }
    let state = canvas.expansion();
    let (scene, meshes) = assign_meshes(state, wired);
    let nodes = scene.nodes;
    let generation = bump(state);
    state.ask = Some(ShowcaseAsk::Model { nodes, meshes, size, fit, generation });
    Ok(String::new())
}

/// `page`: text the window rasterises as a page and shows in the showcase.
fn page(keys: &Keys, payload: &str, canvas: &mut dyn Canvas) -> Result<String, Bad> {
    let cols = page_dim(keys, "cols")?;
    let rows = page_dim(keys, "rows")?;
    let decoded = base64(payload.as_bytes())
        .ok_or_else(|| Bad("EBADF".into(), "payload is not base64".into()))?;
    if decoded.len() > super::glass_scene::SCENE_BYTES {
        return Err(Bad(
            "EFBIG".into(),
            format!("page payload is capped at {} bytes", super::glass_scene::SCENE_BYTES),
        ));
    }
    let text = String::from_utf8(decoded)
        .map_err(|_| Bad("EBADF".into(), "page payload is not text".into()))?;
    let lines = text.lines().count();
    if lines > PAGE_MAX as usize {
        return Err(Bad("EINVAL".into(), format!("page is capped at {PAGE_MAX} lines")));
    }
    let state = canvas.expansion();
    if let Some(ShowcaseAsk::Page { text: old, cols: oc, rows: or, .. }) = &state.ask
        && old == &text && *oc == cols && *or == rows
    {
        return Ok(String::new());
    }
    let generation = bump(state);
    state.ask = Some(ShowcaseAsk::Page { text, cols, rows, generation });
    Ok(String::new())
}

fn page_dim(keys: &Keys, name: &str) -> Result<u16, Bad> {
    let Some(n) = keys.u32(name)? else {
        return Err(Bad("EINVAL".into(), format!("page needs {name}=")));
    };
    if n == 0 || n > PAGE_MAX {
        return Err(Bad("EINVAL".into(), format!("{name} must be 1..={PAGE_MAX}")));
    }
    Ok(n as u16)
}

/// `progress`: where playback is, and whether it is paused. This does
/// not reopen the showcase.
fn progress(keys: &Keys, canvas: &mut dyn Canvas) -> Result<String, Bad> {
    let at = keys.f32("t")?;
    let pause = keys.flag("pause")?;
    if at.is_none() && pause.is_none() {
        return Err(Bad("EINVAL".into(), "progress needs t= or pause=".into()));
    }
    if let Some(at) = at && !(0.0..=1.0).contains(&at) {
        return Err(Bad("EINVAL".into(), "t must be 0..=1".into()));
    }
    let state = canvas.expansion();
    state.progress = Some((at, pause.unwrap_or(false)));
    state.progress_dirty = true;
    Ok(String::new())
}
