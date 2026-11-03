//! Pictures stay with the text: scroll regions, reflow, and cell covers.

use crate::engine::{Engine, HostInfo};
use crate::intake::motion::{BandScroll, Rect};
use crate::intake::{Area, Intake, Splitter, View};
use crate::session::pump;

fn engine(rows: usize, cols: usize) -> Engine {
    Engine::new(rows, cols, HostInfo { colors: [[0xd0; 3], [0, 0, 0], [0xff; 3]], cell_px: (10, 20) })
}

fn feed(engine: &mut Engine, intake: &mut Intake, bytes: &[u8]) {
    let mut splitter = Splitter::default();
    let mut pieces = Vec::new();
    splitter.split(bytes, &mut pieces);
    pump(engine, intake, &pieces);
}

fn picture(id: u32) -> Vec<u8> {
    format!("\x1b_Gi={id},s=1,v=1,a=T,f=24;AAAA\x1b\\").into_bytes()
}

#[test]
fn text_over_part_of_an_in_cell_picture_hides_only_those_cells() {
    let mut intake = Intake::new(8);
    intake.set_cell((10, 20));
    // A 2x2 cell picture. Cover the top-left cell only.
    let mut engine = engine(8, 8);
    feed(&mut engine, &mut intake, &picture(3));
    // The one-pixel picture is smaller than a cell, so build the cover
    // through the store on a picture that occupies several cells.
    intake.placements[0].width = 2.0;
    intake.placements[0].height = 2.0;
    intake.placements[0].in_cell = true;
    intake.covered(false, Area { lines: 0..1, columns: 0..1 });
    let shown = intake.describe(View { top: 0, rows: 8, alternate: false });
    let rects: Vec<(f32, f32, f32, f32)> = shown
        .placements
        .iter()
        .map(|p| (p.row, p.column, p.width, p.height))
        .collect();
    // Top row keeps the right cell; the bottom row stays whole.
    assert!(rects.iter().any(|r| (r.0 - 0.0).abs() < 0.01 && (r.1 - 1.0).abs() < 0.01), "{rects:?}");
    assert!(rects.iter().any(|r| (r.0 - 1.0).abs() < 0.01 && (r.2 - 2.0).abs() < 0.01), "{rects:?}");
    assert!(rects.iter().all(|r| r.1 > 0.0 || r.0 > 0.0), "the covered cell is absent {rects:?}");
}

#[test]
fn a_reflow_keeps_a_picture_on_the_same_text() {
    let mut engine = engine(6, 10);
    let mut intake = Intake::new(8);
    // Ten columns of digits, then a marker the picture sits on. The
    // marker wraps to the next row.
    feed(&mut engine, &mut intake, b"0123456789MARK");
    feed(&mut engine, &mut intake, b"\x1b[2;5H");
    feed(&mut engine, &mut intake, &picture(7));
    let before = intake.describe(View { top: 0, rows: 6, alternate: false });
    assert_eq!(before.placements.len(), 1);
    assert!((before.placements[0].column - 4.0).abs() < 0.01);

    engine.resize(6, 20);
    if let Some(reflow) = engine.take_reflow() {
        intake.reflow(&reflow);
        intake.set_scrolled_primary(engine.scrolled_off_top() as u64, engine.history_size(), 6);
    }
    let wide = intake.describe(View { top: engine.top_line(), rows: 6, alternate: false });
    assert_eq!(wide.placements.len(), 1, "the picture survived the wider grid");
    // The picture sits four cells into the wrapped tail, character
    // offset 14. At width 20 that is column 14 of the one logical line.
    assert!(
        (wide.placements[0].column - 14.0).abs() < 0.01,
        "the picture followed the marker, column {}",
        wide.placements[0].column
    );

    engine.resize(6, 10);
    if let Some(reflow) = engine.take_reflow() {
        intake.reflow(&reflow);
        intake.set_scrolled_primary(engine.scrolled_off_top() as u64, engine.history_size(), 6);
    }
    let back = intake.describe(View { top: engine.top_line(), rows: 6, alternate: false });
    assert_eq!(back.placements.len(), 1);
    assert!(
        (back.placements[0].column - 4.0).abs() < 0.01,
        "narrowing puts it back, column {}",
        back.placements[0].column
    );
}

#[test]
fn a_text_anchored_layer_moves_with_a_scroll_region() {
    let mut engine = engine(8, 20);
    let mut intake = Intake::new(8);
    feed(&mut engine, &mut intake, b"\x1b[4;1H");
    feed(
        &mut engine,
        &mut intake,
        b"\x1b_glass;layer;id=1;at=0,0,2,1;z=1\x1b\\",
    );
    feed(&mut engine, &mut intake, b"\x1b[3;6r\x1b[1S");
    let layers = intake.expansion.frame(0, 8, false);
    assert_eq!(layers.len(), 1, "the layer stayed");
    // It was on row 3 (1-based 4). The region is rows 2..6. Scroll up
    // one moves it to row 2.
    let row = match &layers[0].placement {
        glass_window::Placement::Cells(cells) => cells[1],
        other => panic!("expected a cell placement, {other:?}"),
    };
    assert!((row - 2.0).abs() < 0.01, "the layer moved with the region, row {row}");
}

#[test]
fn marked_rows_follow_the_grid_through_region_scrolls() {
    let mut engine = engine(8, 20);
    let mut intake = Intake::new(8);
    let mut bytes = Vec::new();
    for row in 0..6u32 {
        bytes.extend(format!("\x1b[{};1HM{row:04}", row + 1).into_bytes());
        bytes.extend(format!("\x1b[{};12H", row + 1).into_bytes());
        bytes.extend(picture(row + 1));
    }
    bytes.extend(b"\x1b[2;6r");
    bytes.extend(b"\x1b[1S\x1b[1T\x1b[2S");
    feed(&mut engine, &mut intake, &bytes);
    let shown = intake.describe(View { top: 0, rows: 8, alternate: false });
    for row in 0..8i32 {
        let text = engine.grid_line(row);
        if let Some(start) = text.find("M")
            && text.len() >= start + 5
            && text[start + 1..start + 5].chars().all(|c| c.is_ascii_digit())
        {
            let id: u32 = text[start + 1..start + 5].parse().unwrap_or(99);
            let hit = shown.placements.iter().any(|p| (p.row - row as f32).abs() < 0.01);
            assert!(hit, "marker {id} on row {row} has no picture, text {text:?}");
        }
    }
}

#[test]
fn a_band_scroll_crops_through_the_source_rectangle() {
    let band = BandScroll {
        alternate: false,
        top: 5,
        bottom: 10,
        up: 2,
        down: 0,
        count_delta: 0,
        keep_above: false,
        clears: false,
    };
    let rect = Rect { line: 5, column: 0.0, width: 2.0, height: 4.0, source: Some([0.0, 0.0, 20.0, 40.0]) };
    match crate::intake::motion::scroll_rect(rect, &band, (20, 40)) {
        crate::intake::motion::Fate::Keep(next) => {
            assert_eq!(next.line, 5);
            assert!((next.height - 2.0).abs() < 0.01);
            let [x, y, w, h] = next.source.expect("cropped source");
            assert!((x - 0.0).abs() < 0.01 && (w - 20.0).abs() < 0.01);
            assert!((y - 20.0).abs() < 0.01, "the top half of the source is cut, y {y}");
            assert!((h - 20.0).abs() < 0.01, "half the source remains, h {h}");
        }
        other => panic!("expected a crop, {other:?}"),
    }
}

#[test]
fn an_erase_rectangle_covers_only_its_cells() {
    let mut intake = Intake::new(4);
    intake.set_cell((1, 1));
    let mut engine = Engine::new(6, 6, HostInfo { colors: [[0; 3], [0, 0, 0], [0xff; 3]], cell_px: (1, 1) });
    feed(&mut engine, &mut intake, b"\x1bPq#0;2;100;0;0#0~~\x1b\\");
    // EL from column 2 on the first row covers the right of that row.
    feed(&mut engine, &mut intake, b"\x1b[1;2H\x1b[K");
    let shown = intake.describe(View { top: 0, rows: 6, alternate: false });
    assert!(!shown.placements.is_empty(), "the picture was not removed whole");
    let rows: Vec<f32> = shown.placements.iter().map(|p| p.row).collect();
    assert!(rows.iter().any(|r| (*r - 0.0).abs() < 0.01), "row 0 still has an uncovered part, {rows:?}");
}

fn rig(rows: usize, cols: usize) -> (Engine, Intake) {
    let mut engine = engine(rows, cols);
    engine.set_cell_px((1, 1));
    let mut intake = Intake::new(8);
    intake.set_cell((1, 1));
    (engine, intake)
}

fn sixel_4x6(engine: &mut Engine, intake: &mut Intake) {
    feed(engine, intake, b"\x1bPq~~~~\x1b\\");
}

type ShownRect = (i32, i32, i32, i32, Option<(i32, i32, i32, i32)>);

fn rects(shown: &super::Description) -> Vec<ShownRect> {
    let mut out: Vec<_> = shown
        .placements
        .iter()
        .map(|p| {
            (
                p.row.round() as i32,
                p.column.round() as i32,
                p.width.round() as i32,
                p.height.round() as i32,
                p.source.map(|s| (s[0].round() as i32, s[1].round() as i32, s[2].round() as i32, s[3].round() as i32)),
            )
        })
        .collect();
    out.sort();
    out
}

fn area(line: u64, rows: u64, col: u16, cols: u16) -> Area {
    Area { lines: line..line + rows, columns: col..col + cols }
}

#[test]
fn covers_emit_exact_rectangles() {
    let (mut engine, mut intake) = rig(24, 20);
    feed(&mut engine, &mut intake, b"\x1b[1;1H");
    sixel_4x6(&mut engine, &mut intake);
    // A non-rectangular cover: the middle of row 1, and all of row 3.
    intake.covered(false, area(1, 1, 1, 2));
    intake.covered(false, area(3, 1, 0, 4));
    let shown = intake.describe(View { top: 0, rows: 24, alternate: false });
    let got = rects(&shown);
    let expect = vec![
        (0, 0, 4, 1, Some((0, 0, 4, 1))),
        (1, 0, 1, 1, Some((0, 1, 1, 1))),
        (1, 3, 1, 1, Some((3, 1, 1, 1))),
        (2, 0, 4, 1, Some((0, 2, 4, 1))),
        (4, 0, 4, 8, Some((0, 4, 4, 8))),
    ];
    assert_eq!(got, expect, "describe's rectangles");
}

#[test]
fn ich_and_dch_shift_partly_over_an_in_cell_picture() {
    let (mut engine, mut intake) = rig(24, 20);
    feed(&mut engine, &mut intake, b"\x1b[1;3H");
    sixel_4x6(&mut engine, &mut intake);
    // ICH 2 at column 4 (1-based 5) shifts the row over the picture's right.
    feed(&mut engine, &mut intake, b"\x1b[1;5H\x1b[2@");
    let shown = intake.describe(View { top: 0, rows: 24, alternate: false });
    let row0: Vec<_> = rects(&shown).into_iter().filter(|r| r.0 == 0).collect();
    assert_eq!(row0, vec![(0, 2, 2, 1, Some((0, 0, 2, 1)))], "ICH, all {:?}", rects(&shown));
    assert!(rects(&shown).iter().any(|r| r.0 == 1 && r.2 == 4), "row 1 stays whole");

    let (mut engine, mut intake) = rig(24, 20);
    feed(&mut engine, &mut intake, b"\x1b[1;3H");
    sixel_4x6(&mut engine, &mut intake);
    feed(&mut engine, &mut intake, b"\x1b[1;5H\x1b[1P");
    let shown = intake.describe(View { top: 0, rows: 24, alternate: false });
    let row0: Vec<_> = rects(&shown).into_iter().filter(|r| r.0 == 0).collect();
    assert_eq!(row0, vec![(0, 2, 2, 1, Some((0, 0, 2, 1)))], "DCH, got {row0:?}");
}

#[test]
fn el_ed0_ed1_and_ech_cover_in_cell_pictures() {
    let (mut engine, mut intake) = rig(24, 20);
    feed(&mut engine, &mut intake, b"\x1b[1;3H");
    sixel_4x6(&mut engine, &mut intake);
    feed(&mut engine, &mut intake, b"\x1b[1;5H\x1b[K");
    let row0: Vec<_> = rects(&intake.describe(View { top: 0, rows: 24, alternate: false }))
        .into_iter()
        .filter(|r| r.0 == 0)
        .collect();
    assert_eq!(row0, vec![(0, 2, 2, 1, Some((0, 0, 2, 1)))], "EL 0, got {row0:?}");

    let (mut engine, mut intake) = rig(24, 20);
    feed(&mut engine, &mut intake, b"\x1b[1;3H");
    sixel_4x6(&mut engine, &mut intake);
    feed(&mut engine, &mut intake, b"\x1b[1;5H\x1b[1X");
    let row0: Vec<_> = rects(&intake.describe(View { top: 0, rows: 24, alternate: false }))
        .into_iter()
        .filter(|r| r.0 == 0)
        .collect();
    assert_eq!(
        row0,
        vec![(0, 2, 2, 1, Some((0, 0, 2, 1))), (0, 5, 1, 1, Some((3, 0, 1, 1)))],
        "ECH, got {row0:?}"
    );

    let (mut engine, mut intake) = rig(24, 20);
    feed(&mut engine, &mut intake, b"\x1b[1;3H");
    sixel_4x6(&mut engine, &mut intake);
    feed(&mut engine, &mut intake, b"\x1b[3;5H\x1b[J");
    let got = rects(&intake.describe(View { top: 0, rows: 24, alternate: false }));
    assert!(
        got.contains(&(0, 2, 4, 2, Some((0, 0, 4, 2)))),
        "rows above the cursor stay, got {got:?}"
    );
    assert!(got.contains(&(2, 2, 2, 1, Some((0, 2, 2, 1)))), "ED 0, got {got:?}");
    assert!(got.iter().all(|r| r.0 <= 2), "rows below are covered, got {got:?}");

    let (mut engine, mut intake) = rig(24, 20);
    feed(&mut engine, &mut intake, b"\x1b[1;3H");
    sixel_4x6(&mut engine, &mut intake);
    feed(&mut engine, &mut intake, b"\x1b[4;5H\x1b[1J");
    let got = rects(&intake.describe(View { top: 0, rows: 24, alternate: false }));
    assert!(got.iter().all(|r| r.0 >= 3), "lines above are covered, got {got:?}");
    assert!(got.contains(&(3, 5, 1, 1, Some((3, 3, 1, 1)))), "ED 1, got {got:?}");
    assert!(
        got.contains(&(4, 2, 4, 8, Some((0, 4, 4, 8)))),
        "rows below the cursor stay, got {got:?}"
    );
}

#[test]
fn a_wholly_covered_picture_goes() {
    let (mut engine, mut intake) = rig(24, 20);
    feed(&mut engine, &mut intake, b"\x1b[1;1H");
    sixel_4x6(&mut engine, &mut intake);
    for row in 1..=12 {
        let bytes = format!("\x1b[{row};1H\x1b[2K");
        feed(&mut engine, &mut intake, bytes.as_bytes());
    }
    let shown = intake.describe(View { top: 0, rows: 24, alternate: false });
    assert!(shown.placements.is_empty(), "a wholly covered picture goes, left {:?}", rects(&shown));
    assert!(intake.placements.is_empty(), "the showing is dropped, not merely hidden");
}

#[test]
fn a_tall_picture_is_cut_at_the_bottom_margin() {
    let (mut engine, mut intake) = rig(16, 20);
    // Picture on rows 3..=8. Region lines 2..=5, so rows 3..=5 are inside
    // and rows 6..=8 stay outside the bottom margin.
    feed(&mut engine, &mut intake, b"\x1b[4;1H");
    sixel_4x6(&mut engine, &mut intake);
    feed(&mut engine, &mut intake, b"\x1b[3;6r\x1b[S");
    let got = rects(&intake.describe(View { top: engine.top_line(), rows: 16, alternate: false }));
    assert!(
        got.contains(&(2, 0, 4, 3, Some((0, 0, 4, 3)))),
        "cut at the margin through the source, got {got:?}"
    );
    assert!(
        got.contains(&(6, 0, 4, 9, Some((0, 3, 4, 9)))),
        "rows outside the region stay, got {got:?}"
    );
}

/// A primary picture sits on `symbol`, including a row that reflow pushed
/// into history. The row is the grid's, not only the column.
fn on_symbol(engine: &Engine, intake: &Intake, rows: usize, symbol: char) -> bool {
    let hist = engine.history_size() as i32;
    let Some((screen_row, col)) = (-hist..rows as i32).find_map(|line| {
        engine.grid_line(line).chars().position(|ch| ch == symbol).map(|col| (line, col))
    }) else {
        return false;
    };
    let abs = engine.top_line() as i64 + i64::from(screen_row);
    if abs < 0 {
        return false;
    }
    intake.placements.iter().any(|p| {
        !p.alternate && p.line == abs as u64 && (p.column - col as f32).abs() < 0.01
    })
}

#[test]
fn reflow_on_both_screens_wider_narrower_and_back() {
    let mut engine = engine(8, 20);
    let mut intake = Intake::new(8);
    intake.set_cell((10, 20));
    feed(&mut engine, &mut intake, b"0123456789abcdef");
    feed(&mut engine, &mut intake, b"\x1b[1;3H");
    feed(&mut engine, &mut intake, &picture(1));
    feed(&mut engine, &mut intake, b"\x1b[1;13H");
    feed(&mut engine, &mut intake, &picture(2));
    // Scroll that line into history, then put another picture on the screen.
    feed(&mut engine, &mut intake, b"\n\n\n\n\n\n\n\n");
    feed(&mut engine, &mut intake, b"\x1b[8;2H");
    feed(&mut engine, &mut intake, &picture(3));
    assert!(
        intake.placements.iter().any(|p| !p.alternate && p.line < engine.top_line()),
        "a picture is in scrollback before the resize"
    );

    let anchors = |intake: &Intake, alternate: bool| {
        let mut v: Vec<(u64, i32)> = intake
            .placements
            .iter()
            .filter(|p| p.alternate == alternate)
            .map(|p| (p.line, p.column.round() as i32))
            .collect();
        v.sort();
        v
    };
    let apply = |engine: &mut Engine, intake: &mut Intake, rows: usize, cols: usize| {
        engine.resize(rows, cols);
        if let Some(reflow) = engine.take_reflow() {
            intake.reflow(&reflow);
        }
    };

    apply(&mut engine, &mut intake, 8, 40);
    assert_eq!(anchors(&intake, false).len(), 3, "wider keeps every picture, {:?}", anchors(&intake, false));
    assert!(
        anchors(&intake, false).iter().any(|(_, c)| *c == 12),
        "a wider screen does not move a picture that already fit, {:?}",
        anchors(&intake, false)
    );
    assert!(on_symbol(&engine, &intake, 8, '2'), "wider: the picture left the 2, {:?}", anchors(&intake, false));
    assert!(on_symbol(&engine, &intake, 8, 'c'), "wider: the picture left the c, {:?}", anchors(&intake, false));

    apply(&mut engine, &mut intake, 8, 10);
    let narrow = anchors(&intake, false);
    assert_eq!(narrow.len(), 3, "narrower keeps every picture, {narrow:?}");
    // Column 12 of the 20-column line is column 2 once the width is 10,
    // and that character is on the next row of the logical line.
    assert!(narrow.iter().any(|(_, c)| *c == 2), "the wrapped picture moved, {narrow:?}");
    assert!(
        intake.placements.iter().any(|p| !p.alternate && p.line < engine.top_line()),
        "a picture is still in scrollback after the narrower reflow"
    );
    assert!(on_symbol(&engine, &intake, 8, '2'), "narrower: the picture left the 2, {narrow:?}");
    assert!(on_symbol(&engine, &intake, 8, 'c'), "narrower: the picture left the c, {narrow:?}");

    apply(&mut engine, &mut intake, 8, 20);
    let back = anchors(&intake, false);
    assert_eq!(back.len(), 3, "back keeps every picture, {back:?}");
    assert!(back.iter().any(|(_, c)| *c == 12), "narrower and back restores the column, {back:?}");
    assert!(on_symbol(&engine, &intake, 8, '2'), "back: the picture left the 2, {back:?}");
    assert!(on_symbol(&engine, &intake, 8, 'c'), "back: the picture left the c, {back:?}");

    // The alternate grid does not reflow. Its pictures stay. The primary
    // grid does reflow even while the alternate screen is up.
    feed(&mut engine, &mut intake, b"\x1b[?1049h");
    feed(&mut engine, &mut intake, b"\x1b[2;4H");
    feed(&mut engine, &mut intake, &picture(4));
    feed(&mut engine, &mut intake, b"\x1b[3;6H");
    feed(&mut engine, &mut intake, &picture(5));
    let alt_before = anchors(&intake, true);
    assert_eq!(alt_before.len(), 2, "two pictures on the alternate screen, {alt_before:?}");
    apply(&mut engine, &mut intake, 8, 12);
    apply(&mut engine, &mut intake, 8, 30);
    apply(&mut engine, &mut intake, 8, 20);
    assert_eq!(anchors(&intake, true), alt_before, "alternate pictures stay through wider, narrower and back");
    assert!(
        anchors(&intake, false).len() >= 2,
        "primary pictures, including scrollback, survive a resize while the alternate screen is up, {:?}",
        anchors(&intake, false)
    );
    // The primary grid reflowed while the alternate screen was up. Back on
    // it, the pictures are still on the same characters, row and column.
    feed(&mut engine, &mut intake, b"\x1b[?1049l");
    assert!(on_symbol(&engine, &intake, 8, '2'), "alt resize: the picture left the 2");
    assert!(on_symbol(&engine, &intake, 8, 'c'), "alt resize: the picture left the c");
}

/// Recordings of the sampler's output, in the folder `GLASS_FIXTURES`
/// names on a machine that has them; they are not in the repository.
const SAMPLER_FULL: &str = "sampler-replay-full.bin";
const SAMPLER_OSC: &str = "sampler-replay-osc-only.bin";

/// The reader thread's read, then the sizes the cover bug was chased at.
/// `None`, said on stderr, when the recording is not there.
fn replay_fixture(name: &str, read: usize) -> Option<(Engine, Intake)> {
    let Some(path) = std::env::var_os("GLASS_FIXTURES").filter(|dir| !dir.is_empty()).map(|dir| std::path::Path::new(&dir).join(name)) else {
        eprintln!("skipped: GLASS_FIXTURES does not name the folder of {name}");
        return None;
    };
    let Ok(bytes) = std::fs::read(&path) else {
        eprintln!("skipped: {} is not there", path.display());
        return None;
    };
    let mut engine = Engine::new(
        39,
        154,
        HostInfo { colors: [[0xd0; 3], [0, 0, 0], [0xff; 3]], cell_px: (12, 25) },
    );
    engine.set_cell_px((12, 25));
    let mut intake = Intake::new(64);
    intake.set_cell((12, 25));
    let mut splitter = Splitter::default();
    let step = read.max(1);
    for piece in bytes.chunks(step) {
        let mut pieces = Vec::new();
        splitter.split(piece, &mut pieces);
        if !pieces.is_empty() {
            pump(&mut engine, &mut intake, &pieces);
        }
    }
    Some((engine, intake))
}

fn osc_picture_is_one_uncovered_rectangle(engine: &Engine, intake: &mut Intake, read: usize) {
    let (width, height) = {
        let osc: Vec<_> = intake.placements.iter().filter(|p| p.space == crate::intake::Space::Osc).collect();
        assert_eq!(osc.len(), 1, "read {read}: expected the one OSC 1337 picture, saw {}", intake.placements.len());
        let put = osc[0];
        assert!(put.covered.is_empty(), "read {read}: OSC picture covered {:?}", put.covered);
        (put.width, put.height)
    };
    let shown = intake.describe(View {
        top: engine.top_line(),
        rows: 39,
        alternate: engine.alternate_screen(),
    });
    assert_eq!(shown.placements.len(), 1, "read {read}: describe split the picture into {} rectangles", shown.placements.len());
    let rect = &shown.placements[0];
    assert!((rect.width - width).abs() < 0.05, "width {} vs {}", rect.width, width);
    assert!((rect.height - height).abs() < 0.05, "height {} vs {}", rect.height, height);
}

#[test]
fn sampler_replay_full_osc_picture_is_uncovered_at_reader_reads() {
    let Some((engine, mut intake)) = replay_fixture(SAMPLER_FULL, 64 * 1024) else { return };
    osc_picture_is_one_uncovered_rectangle(&engine, &mut intake, 64 * 1024);
}

#[test]
fn sampler_replay_full_osc_picture_is_uncovered_at_other_reads() {
    for read in [1usize, 7, 4096, usize::MAX] {
        let Some((engine, mut intake)) = replay_fixture(SAMPLER_FULL, read) else { return };
        osc_picture_is_one_uncovered_rectangle(&engine, &mut intake, read);
    }
}

#[test]
fn sampler_replay_osc_only_picture_is_uncovered() {
    let Some((engine, mut intake)) = replay_fixture(SAMPLER_OSC, 64 * 1024) else { return };
    osc_picture_is_one_uncovered_rectangle(&engine, &mut intake, 64 * 1024);
}

/// A caption below an in-cell picture must not hide it just because the
/// alternate screen has scrolled. The cover is recorded on the picture's
/// absolute line, which includes the lines that left the top.
#[test]
fn alt_scroll_does_not_apply_text_below_a_picture_as_a_cover() {
    let mut engine = engine(12, 40);
    let mut intake = Intake::new(8);
    intake.set_cell((10, 20));
    feed(&mut engine, &mut intake, b"\x1b[?1049h");
    // 20 linefeeds: 11 reach the last row, 9 leave the top.
    let down = vec![b'\n'; 20];
    feed(&mut engine, &mut intake, &down);
    assert_eq!(engine.alt_scrolled(), 9, "the alternate screen did not scroll as the fixture's screen does");
    // An in-cell picture on row 2. A later caption on the last row does
    // not overlap it. Before the fix that caption was recorded at the
    // grid row, which collided with the picture's absolute line.
    feed(&mut engine, &mut intake, b"\x1b[2;1H\x1bPq#0!40~\x1b\\");
    let before = engine.alt_scrolled();
    feed(&mut engine, &mut intake, b"\x1b[12;1Hbelow");
    let pic = intake.placements.iter().find(|p| p.in_cell).expect("in-cell picture");
    assert!(pic.covered.is_empty(), "text below the picture covered line {} {:?}", pic.line, pic.covered);
    assert_eq!(engine.alt_scrolled(), before, "the caption scrolled the screen");
    // The same cells, written on the picture, do hide it.
    feed(&mut engine, &mut intake, b"\x1b[2;1HXX");
    let pic = intake.placements.iter().find(|p| p.in_cell).expect("in-cell picture");
    assert!(!pic.covered.is_empty(), "text on the picture left it uncovered");
}

/// A scroll and the text after it can share one chunk. The cover's line
/// must follow the scroll, or text at the picture's old row hides it.
#[test]
fn alt_scroll_in_the_same_chunk_does_not_leave_covers_on_the_old_row() {
    let mut engine = engine(12, 40);
    let mut intake = Intake::new(8);
    intake.set_cell((10, 20));
    feed(&mut engine, &mut intake, b"\x1b[?1049h");
    let down = vec![b'\n'; 20];
    feed(&mut engine, &mut intake, &down);
    feed(&mut engine, &mut intake, b"\x1b[5;1H\x1bPq#0!40~\x1b\\");
    let line = intake.placements.iter().find(|p| p.in_cell).expect("picture").line;
    // Two linefeeds from the last row scroll the picture up by two. The
    // text is then written at the picture's old screen row.
    feed(&mut engine, &mut intake, b"\x1b[12;1H\n\n\x1b[5;1Hnope");
    let pic = intake.placements.iter().find(|p| p.in_cell).expect("picture");
    assert_eq!(pic.line, line, "the picture's absolute line moved");
    assert!(pic.covered.is_empty(), "text at the old row covered {:?}", pic.covered);
    // Text on the picture's new screen row still hides those cells.
    feed(&mut engine, &mut intake, b"\x1b[3;1HYY");
    let pic = intake.placements.iter().find(|p| p.in_cell).expect("picture");
    assert!(!pic.covered.is_empty(), "text on the picture after the scroll left it uncovered");
}

/// Characterize a shipping growth-coordinate defect, not a correctness fix.
/// Uses Session resize mapping and an actual placement through pump.
#[test]
fn height_growth_picture_coordinate_defect_is_reproducible() {
    let mut engine = engine(4, 10);
    let mut intake = Intake::new(8);
    feed(&mut engine, &mut intake, &b"x\r\n".repeat(12));
    feed(&mut engine, &mut intake, b"\x1b[1;1H");
    feed(&mut engine, &mut intake, &picture(719));
    feed(&mut engine, &mut intake, b"\x1b[1;1HM");
    let before = intake.describe(View { top: engine.top_line(), rows: 4, alternate: false });
    assert_eq!(before.placements.len(), 1);
    assert_eq!(before.placements[0].row, 0.0);
    engine.resize(6, 10);
    let reflow = engine.take_reflow();
    if let Some(ref r) = reflow { intake.reflow(r); }
    intake.set_scrolled_primary(engine.scrolled_off_top() as u64, engine.history_size(), 6);
    let marker = engine.grid_line(2).chars().next().unwrap();
    assert_eq!(marker, 'M');
    let after = intake.describe(View { top: engine.top_line(), rows: 6, alternate: false });
    assert_eq!(after.placements.len(), 1);
    eprintln!("growth-picture before_row={} marker_row=2 picture_row={} reflow={}", before.placements[0].row, after.placements[0].row, reflow.is_some());
    // Correct alignment would put the picture at marker row 2. The engine
    // neither changes its coordinate base nor emits a mapping on height growth.
    assert!(reflow.is_none());
    assert_eq!(after.placements[0].row, 0.0);
    assert_ne!(after.placements[0].row, 2.0, "remove this characterization when fixing the defect");
}

/// Independent geometry oracle: the marker's row follows only known resize
/// pushes/pulls, not a snapshot matcher or the engine's scroll counter.
#[test]
#[ignore = "desired invariant diagnostic: shipping height resize is known to fail"]
fn height_snapshot_marker_picture_matrix() {
    let capacity = std::env::var("GLASS_SCROLLBACK").unwrap_or_else(|_| "10000".into()).parse::<usize>().unwrap();
    let mut cases = 0;
    let mut failures = 0;
    for rows in [4usize, 6] {
        for target in [1usize, 2, 4, 6, 8] {
            for cursor in 0..rows {
                for marker in 0..rows {
                    for records in [0usize, 1, 12] {
                        for alt in [false, true] {
                            for fast in [false, true] {
                                let mut engine = engine(rows, 10);
                                engine.set_fast(fast);
                                let mut intake = Intake::new(8);
                                intake.set_cell((10, 20));
                                for _ in 0..records { feed(&mut engine, &mut intake, b"x\r\n"); }
                                feed(&mut engine, &mut intake, format!("\x1b[{};1HM\x1b[{};1H", marker + 1, marker + 1).as_bytes());
                                feed(&mut engine, &mut intake, &picture(991));
                                feed(&mut engine, &mut intake, format!("\x1b[{};1H", cursor + 1).as_bytes());
                                let mut h = records.saturating_sub(rows - 1).min(capacity);
                                let mut old_rows = rows;
                                let mut c = cursor;
                                let mut expected = Some(marker as i32);
                                for (step, next) in [target, rows, target].into_iter().enumerate() {
                                    if alt { feed(&mut engine, &mut intake, b"\x1b[?1049h"); }
                                    if next > old_rows {
                                        let pull = h.min(next - old_rows);
                                        expected = expected.map(|m| m + pull as i32);
                                        c += pull;
                                        h -= pull;
                                    } else if next < old_rows {
                                        let push = (c + 1).saturating_sub(next);
                                        h = (h + push).min(capacity);
                                        c = c.min(next - 1);
                                        expected = expected.and_then(|m| {
                                            let y = m - push as i32;
                                            if y < -(h as i32) || y >= next as i32 { None } else { Some(y) }
                                        });
                                    }
                                    old_rows = next;
                                    engine.resize(next, 10);
                                    // Exactly Session::resize's intake update ordering.
                                    if let Some(reflow) = engine.take_reflow() {
                                        intake.reflow(&reflow);
                                        intake.set_scrolled_primary(engine.scrolled_off_top() as u64, engine.history_size(), next as u16);
                                    }
                                    if alt { feed(&mut engine, &mut intake, b"\x1b[?1049l"); }
                                    let actual = (-(engine.history_size() as i32)..next as i32)
                                        .find(|&r| engine.grid_line(r).starts_with('M'));
                                    let view_top = engine.scrolled_off_top().saturating_sub(engine.history_size()) as u64;
                                    let shown = intake.describe(View { top: view_top, rows: (engine.history_size() + next) as u16, alternate: false });
                                    let pic_rows: Vec<i32> = shown.placements.iter().map(|p| p.row.round() as i32 + view_top as i32 - engine.scrolled_off_top() as i32).collect();
                                    let wanted: Vec<i32> = expected.into_iter().collect();
                                    let ok = actual == expected && pic_rows == wanted;
                                    cases += 1;
                                    if !ok { failures += 1; }
                                    eprintln!("height-case rows={rows} target={target} cursor={cursor} marker={marker} records={records} alt={alt} fast={fast} step={step} capacity={capacity} expected={expected:?} actual={actual:?} pictures={pic_rows:?} ok={ok}");
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    eprintln!("height-summary cases={cases} failures={failures} capacity={capacity}");
    assert_eq!(failures, 0, "independent text and real-picture resize oracle");
}

#[test]
#[ignore = "desired invariant diagnostic: shipping mixed resize is known to fail"]
fn mixed_snapshot_marker_picture_matrix() {
    let mut cases = 0;
    let mut failures = 0;
    for rows in [4usize, 6] {
        for target in [2usize, 4, 8] {
            for width in [5usize, 10, 14] {
                for cursor in [0usize, rows - 1] {
                    for marker in [0usize, rows - 1] {
                        for records in [0usize, 12] {
                            for dense in [false, true] {
                                for alt in [false, true] {
                                    for fast in [false, true] {
                                        let mut engine = engine(rows, 10);
                                        engine.set_fast(fast);
                                        let mut intake = Intake::new(8);
                                        intake.set_cell((10, 20));
                                        for _ in 0..records { feed(&mut engine, &mut intake, b"x\r\n"); }
                                        if dense {
                                            for r in 0..rows {
                                                feed(&mut engine, &mut intake, format!("\x1b[{};1Habcdefghij", r + 1).as_bytes());
                                            }
                                        }
                                        let column = if dense { 3 } else { 0 };
                                        feed(&mut engine, &mut intake, format!("\x1b[{};{}HM\x1b[{};{}H",marker + 1,column + 1,marker + 1,column + 1).as_bytes());
                                        feed(&mut engine, &mut intake, &picture(992));
                                        feed(&mut engine, &mut intake, format!("\x1b[{};1H",cursor + 1).as_bytes());
                                        for (step,(height,cols)) in [(target,width),(rows,10),(target,width)].into_iter().enumerate() {
                                            if alt { feed(&mut engine, &mut intake, b"\x1b[?1049h"); }
                                            engine.resize(height,cols);
                                            if let Some(reflow) = engine.take_reflow() {
                                                intake.reflow(&reflow);
                                                intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),height as u16);
                                            }
                                            if alt { feed(&mut engine, &mut intake, b"\x1b[?1049l"); }
                                            let text: Vec<(i32,i32)> = (-(engine.history_size() as i32)..height as i32).flat_map(|r| {
                                                engine.grid_line(r).chars().enumerate().filter_map(move |(c,ch)| (ch == 'M').then_some((r,c as i32))).collect::<Vec<_>>()
                                            }).collect();
                                            let top = engine.scrolled_off_top().saturating_sub(engine.history_size()) as u64;
                                            let shown = intake.describe(View {top,rows:(engine.history_size()+height) as u16,alternate:false});
                                            let pics:Vec<(i32,i32)> = shown.placements.iter().map(|p| (p.row.round() as i32+top as i32-engine.scrolled_off_top() as i32,p.column.round() as i32)).collect();
                                            let ok = text == pics;
                                            cases += 1;
                                            if !ok { failures += 1; }
                                            eprintln!("mixed-case rows={rows} target={target} width={width} cursor={cursor} marker={marker} records={records} dense={dense} alt={alt} fast={fast} step={step} text={text:?} pictures={pics:?} ok={ok}");
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    eprintln!("mixed-summary cases={cases} failures={failures}");
    assert_eq!(failures,0,"real-picture placement agrees with actual marker cells");
}

#[test]
fn mixed_resize_round_trip_picture_defect_is_reproducible() {
    let mut engine = engine(4, 10);
    let mut intake = Intake::new(8);
    intake.set_cell((10, 20));
    for _ in 0..12 { feed(&mut engine, &mut intake, b"x\r\n"); }
    for row in 0..4 { feed(&mut engine, &mut intake, format!("\x1b[{};1Habcdefghij", row + 1).as_bytes()); }
    feed(&mut engine, &mut intake, b"\x1b[1;4HM\x1b[1;4H");
    feed(&mut engine, &mut intake, &picture(993));
    feed(&mut engine, &mut intake, b"\x1b[4;1H");
    for (height, width) in [(8,5),(4,10)] {
        engine.resize(height,width);
        if let Some(reflow) = engine.take_reflow() {
            eprintln!("round-trip resize={height}x{width} reflow={reflow:?}");
            intake.reflow(&reflow);
            intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),height as u16);
        }
        let shown = intake.describe(View {top:engine.top_line(),rows:height as u16,alternate:false});
        eprintln!("round-trip resize={height}x{width} base={} history={} pictures={:?}",engine.scrolled_off_top(),engine.history_size(),shown.placements.iter().map(|p|(p.row,p.column)).collect::<Vec<_>>());
        if width == 5 {
            assert_eq!(shown.placements.len(), 1);
            assert_eq!((shown.placements[0].row, shown.placements[0].column), (0.0, 3.0));
        }
        for row in -(engine.history_size() as i32)..height as i32 { eprintln!("round-trip row={row} text={:?}",engine.grid_line(row)); }
    }
    assert_eq!(engine.grid_line(0).chars().nth(3),Some('M'));
    let shown = intake.describe(View {top:engine.top_line(),rows:4,alternate:false});
    // Characterize broken behavior, not correctness. Replace this test when
    // reflow preserves surviving anchors across a truncated unrelated tail.
    assert_eq!(shown.placements.len(),0,"known defect: the marker survives but its picture is gone");
}

/// Isolate the exact matcher failure from parser/grid/intake behavior.
/// This deliberately records broken behavior, and must change with its fix.
#[test]
fn truncated_tail_reflow_drops_unrelated_anchor_defect_is_reproducible() {
    use crate::intake::motion::{GridSnap, RowSnap, reflow_of, scrolled_after, map_anchor};
    let short = RowSnap { wrap: false, len: 1 };
    let mut old_rows = vec![short; 9];
    for _ in 0..4 {
        old_rows.push(RowSnap { wrap: true, len: 5 });
        old_rows.push(RowSnap { wrap: false, len: 5 });
    }
    let mut new_rows = vec![short; 9];
    new_rows.extend([RowSnap { wrap: false, len: 10 }; 3]);
    new_rows.push(RowSnap { wrap: false, len: 5 });
    let old = GridSnap { cols: 5, screen: 8, history: 9, scrolled: 9, lines: old_rows };
    let mut new = GridSnap { cols: 10, screen: 4, history: 9, scrolled: 9, lines: new_rows };
    let broken = reflow_of(&old, &new);
    assert_eq!(scrolled_after(&broken), 9);
    assert_eq!(map_anchor(&broken, 9, 3.0), None, "known defect: first content marker is unchanged");
    // A one-field sensitivity check: do not truncate the unrelated last line.
    // The very same anchor then survives; loss is not caused by its own row.
    new.lines.last_mut().unwrap().len = 10;
    let complete = reflow_of(&old, &new);
    assert_eq!(map_anchor(&complete, 9, 3.0), Some((9, 3.0)));
}

/// Independent cell-position oracle, not a line-length or provenance-map oracle.
#[test]
#[ignore = "research diagnostic: wide glyph anchors through real resize"]
fn origin_map_unicode_marker_matrix() {
    let mut cases = 0;
    let mut failures = 0;
    for rows in [4usize, 6] {
        for target in [2usize, 4, 8] {
            for width in [3usize, 7, 14] {
                for cursor in [0usize, rows - 1] {
                    for marker_row in [0usize, rows - 1] {
                        for (kind, glyph) in [('a','M'),('c','漢'),('e','🚀'),('z','M')] {
                            for column in [0usize, 3, 8] {
                                for records in [0usize, 12] {
                                    for alt in [false, true] {
                                        for fast in [false, true] {
                                            let mut engine = engine(rows, 10);
                                            engine.set_fast(fast);
                                            let mut intake = Intake::new(8);
                                            intake.set_cell((10, 20));
                                            for _ in 0..records { feed(&mut engine, &mut intake, b"x\r\n"); }
                                            for r in 0..rows { feed(&mut engine, &mut intake, format!("\x1b[{};1Ha界e\u{301}🦀bcde",r+1).as_bytes()); }
                                            feed(&mut engine, &mut intake, format!("\x1b[{};{}H{glyph}{}\x1b[{};{}H",marker_row+1,column+1,if kind=='z' {"\u{301}"} else {""},marker_row+1,column+1).as_bytes());
                                            feed(&mut engine, &mut intake, &picture(994));
                                            feed(&mut engine, &mut intake, format!("\x1b[{};1H",cursor+1).as_bytes());
                                            for (step,(height,cols)) in [(target,width),(rows,10),(target,width)].into_iter().enumerate() {
                                                if alt { feed(&mut engine,&mut intake,b"\x1b[?1049h"); }
                                                engine.resize(height,cols);
                                                if let Some(reflow)=engine.take_reflow() {
                                                    intake.reflow(&reflow);
                                                    intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),height as u16);
                                                }
                                                if alt { feed(&mut engine,&mut intake,b"\x1b[?1049l"); }
                                                let text:Vec<(i32,i32)>=(-(engine.history_size() as i32)..height as i32).flat_map(|r| {
                                                    engine.grid_line(r).chars().enumerate().filter_map(move |(c,ch)|(ch==glyph).then_some((r,c as i32))).collect::<Vec<_>>()
                                                }).collect();
                                                let top=engine.scrolled_off_top().saturating_sub(engine.history_size()) as u64;
                                                let shown=intake.describe(View{top,rows:(engine.history_size()+height) as u16,alternate:false});
                                                let pics:Vec<(i32,i32)>=shown.placements.iter().map(|p|(p.row.round() as i32+top as i32-engine.scrolled_off_top() as i32,p.column.round() as i32)).collect();
                                                let ok=text==pics;
                                                cases+=1; failures+=usize::from(!ok);
                                                eprintln!("unicode-case rows={rows} target={target} width={width} cursor={cursor} marker={marker_row} kind={kind} column={column} records={records} alt={alt} fast={fast} step={step} text={text:?} pictures={pics:?} ok={ok}");
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    eprintln!("unicode-summary cases={cases} failures={failures}");
    assert_eq!(failures,0,"unique real glyphs agree with their picture anchors");
}

#[test]
#[ignore = "research diagnostic: blank logical slot must not die with trimmed padding"]
fn origin_map_blank_slot_diagnostic() {
    let mut engine=engine(6,10);
    let mut intake=Intake::new(8);
    feed(&mut engine,&mut intake,b"0123456789MARK\x1b[2;5H");
    feed(&mut engine,&mut intake,&picture(995));
    for cols in [20usize,10] {
        engine.resize(6,cols);
        let reflow=engine.take_reflow().expect("changed width");
        let source_line=if cols==20 {1} else {0};
        let source_column=if cols==20 {4.0} else {14.0};
        let exact=crate::intake::motion::map_anchor(&reflow,source_line,source_column);
        let mut legacy=reflow.clone(); legacy.exact=None;
        let inferred=crate::intake::motion::map_anchor(&legacy,source_line,source_column);
        eprintln!("blank-slot width={cols} exact={exact:?} inferred={inferred:?} text={:?}",engine.grid_line(0));
        intake.reflow(&reflow);
        intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),6);
    }
    assert_eq!(engine.grid_line(1).chars().take(4).collect::<String>(),"MARK");
    let shown=intake.describe(View{top:engine.top_line(),rows:6,alternate:false});
    assert_eq!(shown.placements.len(),1,"blank slot after MARK is a semantic anchor");
}

/// Blank slots are checked against the actual unique glyph, not either mapper.
/// A missing glyph is tracked separately: no invented destination is asserted.
#[test]
#[ignore = "research diagnostic: trailing blank slots need a content witness"]
fn blank_witness_marker_matrix() {
    let mut cases=0; let mut failures=0; let mut absent=0;
    for rows in [4usize,6] { for width in [3usize,7,14,20] { for target in [2usize,4,8] { for cursor in [0usize,rows-1] {
    for marker_row in [0usize,rows-1] { for column in [0usize,3] {
    for (kind,glyph,extent) in [('a','M',1usize),('c','漢',2),('e','🚀',2),('z','M',1)] {
    for gap in [0usize,2] { for records in [0usize,12] { for alt in [false,true] { for fast in [false,true] {
        let mut engine=engine(rows,10); engine.set_fast(fast);
        let mut intake=Intake::new(8); intake.set_cell((10,20));
        for _ in 0..records { feed(&mut engine,&mut intake,b"x\r\n"); }
        feed(&mut engine,&mut intake,format!("\x1b[{};{}H{glyph}{}\x1b[{};{}H",marker_row+1,column+1,if kind=='z' {"\u{301}"} else {""},marker_row+1,column+extent+gap+1).as_bytes());
        feed(&mut engine,&mut intake,&picture(996));
        feed(&mut engine,&mut intake,format!("\x1b[{};1H",cursor+1).as_bytes());
        for (step,(height,cols)) in [(target,width),(rows,10),(target,width)].into_iter().enumerate() {
            if alt { feed(&mut engine,&mut intake,b"\x1b[?1049h"); }
            engine.resize(height,cols);
            if let Some(reflow)=engine.take_reflow() { intake.reflow(&reflow); intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),height as u16); }
            if alt { feed(&mut engine,&mut intake,b"\x1b[?1049l"); }
            let text:Vec<(i32,i32)>=(-(engine.history_size() as i32)..height as i32).flat_map(|r| engine.grid_line(r).chars().enumerate().filter_map(move |(c,ch)|(ch==glyph).then_some((r,c as i32))).collect::<Vec<_>>()).collect();
            let top=engine.scrolled_off_top().saturating_sub(engine.history_size()) as u64;
            let shown=intake.describe(View{top,rows:(engine.history_size()+height) as u16,alternate:false});
            let pics:Vec<(i32,i32)>=shown.placements.iter().map(|p|(p.row.round() as i32+top as i32-engine.scrolled_off_top() as i32,p.column.round() as i32)).collect();
            let expected:Vec<(i32,i32)>=text.iter().filter_map(|&(r,c)| {
                let flat=r*cols as i32+c+(extent+gap) as i32;
                let dest=(flat.div_euclid(cols as i32),flat.rem_euclid(cols as i32));
                (dest.0>=-(engine.history_size() as i32) && dest.0<height as i32).then_some(dest)
            }).collect();
            // Only observations with a surviving glyph specify a logical slot.
            let checked=!text.is_empty(); let ok=!checked || pics==expected;
            cases+=1; absent+=usize::from(!checked); failures+=usize::from(!ok);
            eprintln!("slot-case rows={rows} target={target} cursor={cursor} width={width} marker={marker_row} column={column} kind={kind} gap={gap} records={records} alt={alt} fast={fast} step={step} text={text:?} expected={expected:?} pictures={pics:?} checked={checked} ok={ok}");
        }
    }}}}}}}}}}}
    eprintln!("slot-summary cases={cases} absent={absent} failures={failures}");
    assert_eq!(failures,0,"surviving unique glyph witnesses its trailing logical slot");
}

/// Negative control: a surviving glyph on ANOTHER line cannot revive a slot
/// whose own content was discarded by height/history truncation.
#[test]
#[ignore = "research diagnostic: deleted own-line witnesses never borrow neighbours"]
fn blank_witness_deleted_line_matrix() {
    let mut cases=0; let mut eligible=0; let mut failures=0;
    for rows in [4usize,6] { for target in [2usize,4,8] { for cols in [3usize,7,14] {
    for marker_row in [0usize,rows-1] { for cursor in [0usize,rows-1] {
    for column in [0usize,6] { for records in [0usize,12] { for alt in [false,true] { for fast in [false,true] {
        let mut engine=engine(rows,10); engine.set_fast(fast);
        let mut intake=Intake::new(8); intake.set_cell((10,20));
        for _ in 0..records { feed(&mut engine,&mut intake,b"x\r\n"); }
        for r in 0..rows { feed(&mut engine,&mut intake,format!("\x1b[{};1Habcdefghij",r+1).as_bytes()); }
        feed(&mut engine,&mut intake,format!("\x1b[{};{}HM\x1b[K\x1b[{};{}H",marker_row+1,column+1,marker_row+1,column+2).as_bytes());
        feed(&mut engine,&mut intake,&picture(997));
        let other=if marker_row==0 {rows-1} else {0};
        feed(&mut engine,&mut intake,format!("\x1b[{};1HW\x1b[{};1H",other+1,cursor+1).as_bytes());
        if alt { feed(&mut engine,&mut intake,b"\x1b[?1049h"); }
        engine.resize(target,cols);
        let reflow=engine.take_reflow();
        if let Some(reflow)=reflow { intake.reflow(&reflow); intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),target as u16); }
        if alt { feed(&mut engine,&mut intake,b"\x1b[?1049l"); }
        let mut own=0; let mut unrelated=0;
        for r in -(engine.history_size() as i32)..target as i32 {
            for ch in engine.grid_line(r).chars() { own+=usize::from(ch=='M'); unrelated+=usize::from(ch=='W'); }
        }
        let checked=own==0 && unrelated==1;
        let top=engine.scrolled_off_top().saturating_sub(engine.history_size()) as u64;
        let shown=intake.describe(View{top,rows:(engine.history_size()+target) as u16,alternate:false});
        let pictures=shown.placements.len(); let ok=!checked || pictures==0;
        cases+=1; eligible+=usize::from(checked); failures+=usize::from(!ok);
        eprintln!("deleted-case rows={rows} target={target} cols={cols} marker={marker_row} cursor={cursor} column={column} records={records} alt={alt} fast={fast} own={own} unrelated={unrelated} pictures={pictures} checked={checked} ok={ok}");
    }}}}}}}}}
    eprintln!("deleted-summary cases={cases} eligible={eligible} failures={failures}");
    assert!(eligible>0,"negative-control configurations execute");
    assert_eq!(failures,0,"an unrelated surviving glyph cannot revive the deleted line");
}

/// Two histories collapse to the same row/column and reflow input. A stateless
/// cell-destination map cannot reconstruct whether a blank belonged to M's
/// logical tail or the next hard row. This test characterizes, not resolves, it.
#[test]
#[ignore = "research diagnostic: blank-slot identity is absent after collapse"]
fn blank_witness_indistinguishable_histories() {
    fn run(cup: &[u8]) -> (String,Vec<(i32,i32)>,Vec<(i32,i32)>,String,String) {
        let mut engine=engine(4,10);
        let mut intake=Intake::new(8);intake.set_cell((10,20));
        feed(&mut engine,&mut intake,b"M");
        feed(&mut engine,&mut intake,cup);
        feed(&mut engine,&mut intake,&picture(998));
        feed(&mut engine,&mut intake,b"\x1b[1;1H");
        let mut states=Vec::new(); let mut positions=Vec::new(); let mut maps=Vec::new();
        for (height,cols) in [(2usize,3usize),(4,10)] {
            engine.resize(height,cols);
            let reflow=engine.take_reflow().expect("width changes");
            maps.push(format!("{reflow:?}"));
            intake.reflow(&reflow);
            intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),height as u16);
            states.push((-(engine.history_size() as i32)..height as i32).map(|r|engine.grid_line(r)).collect::<Vec<_>>().join("\n"));
            let top=engine.scrolled_off_top().saturating_sub(engine.history_size()) as u64;
            let shown=intake.describe(View{top,rows:(engine.history_size()+height) as u16,alternate:false});
            positions.push(shown.placements.iter().map(|p|(p.row.round() as i32+top as i32-engine.scrolled_off_top() as i32,p.column.round() as i32)).collect::<Vec<_>>());
        }
        (states[0].clone(),positions[0].clone(),positions[1].clone(),maps[1].clone(),states[1].clone())
    }
    let a=run(b"\x1b[1;4H"); let b=run(b"\x1b[2;1H");
    eprintln!("identity-case a_mid={:?} b_mid={:?} a_final={:?} b_final={:?} same_text={} same_map={}",a.1,b.1,a.2,b.2,a.0==b.0,a.3==b.3);
    assert_eq!(a.0,b.0,"same narrowed text");
    assert_eq!(a.1,b.1,"same narrowed picture position");
    assert_eq!(a.3,b.3,"identical full next Reflow including exact destinations");
    assert_eq!(a.4,b.4,"same final text");
    assert_eq!(a.2,b.2,"identical current input necessarily yields identical destination");
    assert_eq!(a.1,vec![(1,0)]);
    assert_eq!(a.2,vec![(1,0)]);
    assert_ne!(a.2,vec![(0,3)],"original marker-relative blank slot is no longer representable");
}

/// Independent explicit destinations for resize-only state, including the two
/// histories that the previous stateless mapper collapsed. No output of the
/// mapper is used to construct expected coordinates.
#[test]
#[ignore = "research diagnostic: persistent witness roundtrips"]
fn persistent_witness_roundtrips() {
    fn position(engine: &Engine, intake: &mut Intake) -> Vec<(i32,i32)> {
        let top=engine.scrolled_off_top().saturating_sub(engine.history_size()) as u64;
        let view=intake.describe(View {top,rows:(engine.history_size()+16) as u16,alternate:false});
        view.placements.iter().map(|p|(p.row.round() as i32+top as i32-engine.scrolled_off_top() as i32,p.column.round() as i32)).collect()
    }
    fn resize(engine: &mut Engine,intake: &mut Intake,height: usize,width: usize,alt: bool) {
        if alt {feed(engine,intake,b"\x1b[?1049h");}
        engine.resize(height,width);
        if let Some(r)=engine.take_reflow(){intake.reflow(&r);intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),height as u16);}
        if alt {feed(engine,intake,b"\x1b[?1049l");}
    }
    let mut cases=0;
    for alt in [false,true] { for fast in [false,true] {
        let mut states=Vec::new();
        for (name,cup,expected) in [("tail",b"\x1b[1;4H".as_slice(),(0,3)),("blank",b"\x1b[2;1H".as_slice(),(1,0))] {
            let mut e=engine(4,10);e.set_fast(fast);let mut i=Intake::new(8);i.set_cell((10,20));
            feed(&mut e,&mut i,b"M");feed(&mut e,&mut i,cup);feed(&mut e,&mut i,&picture(1001));feed(&mut e,&mut i,b"\x1b[1;1H");
            let mut positions=Vec::new();let mut anchors=Vec::new();let mut text=Vec::new();
            for (step,(height,width)) in [(2,3),(4,10),(2,3),(4,10)].into_iter().enumerate() {
                resize(&mut e,&mut i,height,width,alt);
                let got=position(&e,&mut i);let want=if step%2==0 {(1,0)} else {expected};
                eprintln!("roundtrip-case alt={alt} fast={fast} name={name} step={step} pictures={got:?} expected={want:?} anchor={:?}",i.resize_anchors);
                assert_eq!(got,vec![want]);
                positions.push(got);anchors.push(format!("{:?}",i.resize_anchors));
                text.push((-(e.history_size() as i32)..height as i32).map(|r|e.grid_line(r)).collect::<Vec<_>>());
                cases+=1;
            }
            states.push((positions,anchors,text));
        }
        assert_eq!(states[0].0[0],states[1].0[0],"same collapsed picture");
        assert_eq!(states[0].2,states[1].2,"same grid throughout");
        assert_ne!(states[0].1[0],states[1].1[0],"persistent identity differs at collapse");
        assert_ne!(states[0].0[1],states[1].0[1],"both original slots return, neither deleted");
        // A right-hand witness gives a negative offset; full-width Unicode
        // spacers must not be selected in preference to the actual glyph.
        for (name,bytes,column) in [("right",b"\x1b[1;7HM\x1b[1;5H".as_slice(),4),("wide","\x1b[1;3H漢\x1b[1;6H".as_bytes(),5)] {
            let mut e=engine(6,10);e.set_fast(fast);let mut i=Intake::new(8);i.set_cell((10,20));
            feed(&mut e,&mut i,bytes);feed(&mut e,&mut i,&picture(1002));feed(&mut e,&mut i,b"\x1b[1;1H");
            for (step,width) in [3,10,7,10].into_iter().enumerate() {
                resize(&mut e,&mut i,6,width,alt);
                // Oracle is the unique text glyph plus a fixed initial signed
                // offset, independently scanning actual text (not Reflow).
                // Width changes can push the marker into retained history.
                let needle=if name=="right" {'M'} else {'漢'};
                let markers:Vec<_>=(-(e.history_size() as i32)..6).flat_map(|row|e.grid_line(row).chars().enumerate().filter_map(move |(col,ch)|(ch==needle).then_some((row,col as i32))).collect::<Vec<_>>()).collect();
                assert_eq!(markers.len(),1);
                let delta=if name=="right" {-2} else {3};
                let flat=markers[0].0*width as i32+markers[0].1+delta;
                let want=(flat.div_euclid(width as i32),flat.rem_euclid(width as i32));
                let _ = column; // Screen-relative row is not roundtrip-invariant: text can enter history.
                let got=position(&e,&mut i);
                eprintln!("roundtrip-case alt={alt} fast={fast} name={name} step={step} pictures={got:?} expected={want:?} anchor={:?}",i.resize_anchors);
                assert_eq!(got,vec![want]);cases+=1;
            }
        }
    }}
    eprintln!("roundtrip-summary cases={cases}");assert_eq!(cases,64);
}

/// Deliberate out-of-scope falsification. Moving the witness's text by a band
/// scroll between resizes must not be misreported as a successful anchor.
#[test]
#[ignore = "research diagnostic: intervening scroll invalidates prototype state"]
fn persistent_witness_intervening_scroll_characterization() {
    for fast in [false,true] {
        let mut e=engine(6,10);e.set_fast(fast);let mut i=Intake::new(8);i.set_cell((10,20));
        feed(&mut e,&mut i,b"\x1b[3;1HM\x1b[3;4H");feed(&mut e,&mut i,&picture(1003));feed(&mut e,&mut i,b"\x1b[1;1H");
        e.resize(6,7);let r=e.take_reflow().unwrap();i.reflow(&r);i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),6);
        feed(&mut e,&mut i,b"\x1b[2;5r\x1b[1S");
        e.resize(6,10);let r=e.take_reflow().unwrap();i.reflow(&r);i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),6);
        let markers:Vec<_>=(0..6).flat_map(|row|e.grid_line(row).chars().enumerate().filter_map(move |(col,ch)|(ch=='M').then_some((row,col as i32))).collect::<Vec<_>>()).collect();
        let view=i.describe(View{top:e.top_line(),rows:6,alternate:false});
        let pics:Vec<_>=view.placements.iter().map(|p|(p.row.round() as i32,p.column.round() as i32)).collect();
        eprintln!("scroll-characterization fast={fast} markers={markers:?} pictures={pics:?}");
        assert_eq!(markers,vec![(1,0)]);
        assert_ne!(pics,vec![(1,3)],"known out-of-scope prototype failure");
    }
}
/// Scroll oracle models the two physical points independently; it never calls
/// Reflow or either mapping helper to produce an expected destination.
#[test]
#[ignore = "research: interleaved resize/scroll witness transport"]
fn scroll_witness_matrix() {
    fn markers(e: &Engine) -> Vec<(i32,i32)> {
        (-(e.history_size() as i32)..8).flat_map(|r| e.grid_line(r).chars().enumerate()
            .filter_map(move |(c,ch)| (ch=='M').then_some((r,c as i32))).collect::<Vec<_>>()).collect()
    }
    fn pictures(e: &Engine, i: &mut Intake) -> Vec<(i32,i32)> {
        let top=e.scrolled_off_top().saturating_sub(e.history_size()) as u64;
        i.describe(View {top,rows:(e.history_size()+8) as u16,alternate:false}).placements.iter()
            .map(|p|(p.row.round() as i32+top as i32-e.scrolled_off_top() as i32,p.column.round() as i32)).collect()
    }
    fn resize(e: &mut Engine,i: &mut Intake,w: usize,alt: bool) {
        if alt {feed(e,i,b"\x1b[?1049h");}
        e.resize(8,w);if let Some(r)=e.take_reflow(){i.reflow(&r);i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),8);}
        if alt {feed(e,i,b"\x1b[?1049l");}
    }
    fn shift(row: i32,top: i32,down: bool) -> Option<i32> {
        if row<top || row>=7 {Some(row)} else if down { (row<6).then_some(row+1) } else { (row>top).then_some(row-1) }
    }
    let mut cases=0;let mut failures=0;
    for fast in [false,true] {for alt in [false,true] {for row in 1..6 {for delta in [0,3,8,-8] {
        for (op,bytes,top,down) in [
            ("SU",b"\x1b[2;7r\x1b[1S".as_slice(),1,false),
            ("SD",b"\x1b[2;7r\x1b[1T".as_slice(),1,true),
            ("IL",b"\x1b[2;7r\x1b[4;1H\x1b[1L".as_slice(),3,true),
            ("DL",b"\x1b[2;7r\x1b[4;1H\x1b[1M".as_slice(),3,false),
            ("RI",b"\x1b[2;7r\x1b[2;1H\x1bM".as_slice(),1,true),
            ("LF",b"\x1b[2;7r\x1b[7;1H\n".as_slice(),1,false),
        ] {
            let mc=if delta<0 {8} else {0};let pc=mc+delta;
            let mut e=engine(8,10);e.set_fast(fast);let mut i=Intake::new(8);i.set_cell((10,20));
            feed(&mut e,&mut i,format!("\x1b[{};{}HM\x1b[{};{}H",row+1,mc+1,row+1,pc+1).as_bytes());
            feed(&mut e,&mut i,&picture(1101));feed(&mut e,&mut i,b"\x1b[1;1H");
            resize(&mut e,&mut i,7,alt);
            let before_m=markers(&e);let before_p=pictures(&e,&mut i);
            assert_eq!(before_m.len(),1);assert_eq!(before_p.len(),1);
            let m=before_m[0];let p=before_p[0];assert_eq!((p.0-m.0)*7+p.1-m.1,delta);
            let sm=shift(m.0,top,down);let sp=shift(p.0,top,down);
            let next_delta=sm.zip(sp).map(|(a,b)|(b-a)*7+p.1-m.1);
            feed(&mut e,&mut i,bytes);
            let after_m=markers(&e);let after_p=pictures(&e,&mut i);
            assert_eq!(after_m,sm.map(|r|vec![(r,m.1)]).unwrap_or_default(),"text oracle {op}");
            if sm.is_some() {assert_eq!(after_p,sp.map(|r|vec![(r,p.1)]).unwrap_or_default(),"physical picture oracle {op}");}
            resize(&mut e,&mut i,10,alt);
            let final_m=markers(&e);let got=pictures(&e,&mut i);
            let expected=match (next_delta,final_m.first()) {
                (Some(d),Some(&(r,c))) => {let flat=r*10+c+d;let rr=flat.div_euclid(10);let cc=flat.rem_euclid(10);
                    if rr>=-(e.history_size() as i32) && rr<8 {vec![(rr,cc)]} else {vec![]}},
                _ => vec![],
            };
            let pass=got==expected;if !pass {failures+=1;}
            eprintln!("scroll-witness fast={fast} alt={alt} row={row} delta={delta} op={op} before_m={before_m:?} before_p={before_p:?} after_m={after_m:?} after_p={after_p:?} final_m={final_m:?} got={got:?} expected={expected:?} pass={pass}");
            cases+=1;
        }
    }}}}
    eprintln!("scroll-witness-summary cases={cases} failures={failures}");
    assert_eq!(cases,480);assert_eq!(failures,0,"interleaved scroll transport failures");
}

#[test]
#[ignore = "research: saved state must not leak after RIS"]
fn scroll_witness_reset_lifetime() {
    for fast in [false,true] {
        let mut e=engine(8,10);e.set_fast(fast);let mut i=Intake::new(8);i.set_cell((10,20));
        feed(&mut e,&mut i,b"M\x1b[1;4H");feed(&mut e,&mut i,&picture(1102));
        e.resize(8,7);i.reflow(&e.take_reflow().unwrap());
        assert_eq!(i.resize_anchors.len(),1);
        feed(&mut e,&mut i,b"\x1bc");
        eprintln!("reset-lifetime fast={fast} placements={} saved={}",i.placements.len(),i.resize_anchors.len());
        assert!(i.placements.is_empty());assert!(i.resize_anchors.is_empty(),"saved witness leaked after RIS");
    }
}

// Independent two-width geometry oracle: marker M is outside the scroll band.
// At width 7 picture starts one cell after M+7; SD splits it at two margins.
#[test]
fn split_witness_blank_fragment_roundtrip() {
    for fast in [false, true] {
        let mut e = engine(12, 10);
        e.set_fast(fast);
        let mut i = Intake::new(8);
        i.set_cell((10, 20));
        feed(&mut e, &mut i, b"\x1b[2;1HM\x1b[2;9H");
        feed(&mut e, &mut i, b"\x1b_Gi=71,s=1,v=1,a=T,f=24,c=1,r=5;AAAA\x1b\\");
        assert_eq!(i.placements.len(),1);
        feed(&mut e, &mut i, b"\x1b[H");
        e.resize(12,7);
        i.reflow(&e.take_reflow().expect("width reflow"));
        i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),12);
        assert_eq!((i.placements[0].line,i.placements[0].column,i.placements[0].height),(2,1.0,5.0));
        feed(&mut e,&mut i,b"\x1b[5;7r\x1b[1T");
        let middle:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        assert_eq!(middle,vec![(2,1.0,2.0),(5,1.0,2.0)]);
        e.resize(12,10);
        i.reflow(&e.take_reflow().expect("return reflow"));
        i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),12);
        let got:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        eprintln!("split-roundtrip fast={fast} got={got:?} expected=[(1, 8.0, 2.0), (3, 9.0, 2.0)]");
        assert_eq!(got,vec![(1,8.0,2.0),(3,9.0,2.0)]);
    }
}

// No mapping helper used by this oracle. Each retained vertical slice inherits
// its original marker offset, plus its physical start-row displacement at 7 cols.
#[test]
fn split_witness_matrix() {
    let mut cases=0; let mut failures=0;
    for fast in [false,true] { for inactive in [false,true] {
    for marker_col in 0..5 { for picture_col in [8,9] {
    for height in [3,4,5,6] { for above in 1..height {
    for down in [1,2,3] {
        let mut e=engine(20,10);e.set_fast(fast);
        let mut i=Intake::new(8);i.set_cell((10,20));
        feed(&mut e,&mut i,format!("\x1b[2;{}HM\x1b[2;{}H",marker_col+1,picture_col+1).as_bytes());
        feed(&mut e,&mut i,format!("\x1b_Gi=71,s=1,v=1,a=T,f=24,c=1,r={height};AAAA\x1b\\").as_bytes());
        feed(&mut e,&mut i,b"\x1b[H");
        if inactive {feed(&mut e,&mut i,b"\x1b[?1049h");}
        e.resize(20,7);i.reflow(&e.take_reflow().unwrap());
        i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),20);
        if inactive {feed(&mut e,&mut i,b"\x1b[?1049l");}
        let narrow:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        assert_eq!(narrow,vec![(2,(picture_col-7) as f32,height as f32)]);
        let top=2+above;let bottom=2+height+down;
        feed(&mut e,&mut i,format!("\x1b[{};{}r\x1b[{down}T",top+1,bottom).as_bytes());
        let physical:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        assert_eq!(physical,vec![(2,(picture_col-7) as f32,above as f32),((top+down) as u64,(picture_col-7) as f32,(height-above) as f32)]);
        let physical_sources:Vec<_>=i.placements.iter().map(|p|p.source.unwrap()).collect();
        let source_ok=physical_sources.iter().zip([[0.0,0.0,1.0,above as f32/height as f32],[0.0,above as f32/height as f32,1.0,(height-above) as f32/height as f32]])
            .all(|(got,want)|got.iter().zip(want).all(|(a,b)|(*a-b).abs()<0.00001));
        if inactive {feed(&mut e,&mut i,b"\x1b[?1049h");}
        e.resize(20,10);i.reflow(&e.take_reflow().unwrap());
        i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),20);
        if inactive {feed(&mut e,&mut i,b"\x1b[?1049l");}
        let got:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        let second_flat=10+picture_col+(above+down)*7;
        let expected=vec![(1,picture_col as f32,above as f32),((second_flat/10) as u64,(second_flat%10) as f32,(height-above) as f32)];
        let saved=i.resize_anchors.len();
        let unique=i.placements.iter().map(|p|p.seq).collect::<std::collections::HashSet<_>>().len();
        let pass=got==expected && source_ok && saved==2 && unique==2;
        if !pass {failures+=1;}
        eprintln!("split-case fast={fast} inactive={inactive} marker={marker_col} picture={picture_col} height={height} above={above} down={down} got={got:?} expected={expected:?} sources={physical_sources:?} saved={saved} unique={unique} pass={pass}");
        cases+=1;
    }}}}}}}
    eprintln!("split-summary cases={cases} failures={failures}");
    assert_eq!(cases,1680);assert_eq!(failures,0);
}

#[test]
fn split_witness_repeated_split_and_local_death() {
    for fast in [false,true] {for local_death in [false,true] {
        let mut e=engine(20,10);e.set_fast(fast);
        let mut i=Intake::new(8);i.set_cell((10,20));
        feed(&mut e,&mut i,b"\x1b[2;1HM\x1b[2;9H\x1b_Gi=71,s=1,v=1,a=T,f=24,c=1,r=8;AAAA\x1b\\\x1b[H");
        e.resize(20,7);i.reflow(&e.take_reflow().unwrap());
        i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),20);
        feed(&mut e,&mut i,b"\x1b[6;20r\x1b[1T\x1b[4;20r\x1b[1T");
        let physical:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        assert_eq!(physical,vec![(2,1.0,1.0),(4,1.0,2.0),(7,1.0,5.0)]);
        let unique=i.placements.iter().map(|p|p.seq).collect::<std::collections::HashSet<_>>().len();
        let saved=i.resize_anchors.len();
        if local_death {feed(&mut e,&mut i,b"\x1b[3;4r\x1b[1S");}
        e.resize(20,10);i.reflow(&e.take_reflow().unwrap());
        i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),20);
        let got:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        let expected=if local_death {vec![(3,2.0,2.0),(5,3.0,5.0)]}else{vec![(1,8.0,1.0),(3,2.0,2.0),(5,3.0,5.0)]};
        eprintln!("split-repeat fast={fast} local_death={local_death} unique={unique} saved={saved} got={got:?} expected={expected:?}");
        assert_eq!(unique,3,"split identifiers alias");assert_eq!(saved,3,"fragment lost witness");
        assert_eq!(got,expected,"one fragment's death must not delete surviving siblings");
    }}
}
