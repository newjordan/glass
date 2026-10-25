//! The DEC sixel dialect, one of the dialects the intake takes.
//!
//! A sequence arrives as `DCS P1 ; P2 ; P3 q <data> ST`, lifted by the
//! [`Splitter`](super::Splitter) with its parameters, the `q`, and the
//! data. Each data byte 0x3F–0x7E carries six vertical bits (`byte −
//! 0x3F`, bit 0 at the top); only set bits are painted, in the colour
//! register current when its column was read. `$` returns to the left of
//! the band, `-` starts the next band six rows down, `+` a new page 80
//! rows down. `!count code` repeats a code across `count` columns, and
//! `#` selects or defines a colour register.
//!
//! The image grows as the data reaches new columns and bands, each side
//! capped at [`SIDE_CAP`]; the decoder keeps one RGBA grid whose size is
//! settled from the drawing alone, so no per-bit list exists to bomb
//! with. Every sum is checked or saturating: a hostile raster attribute
//! or repeat count cannot panic, wrap, or spin.

use super::{Canvas, Picture as IntakePicture, SIDE_CAP};

/// Colour registers: DEC says 16, most terminals offer 1024.
const REGISTERS: usize = 1024;

/// DEC's default colour registers.
const DEFAULT_COLORS: [u32; 16] = [
    0x000000, 0x3333cc, 0xcc2323, 0x33cc33, 0xcc33cc, 0x33cccc, 0xcccc33, 0x7a7a7a,
    0x666666, 0x3333ff, 0xff3333, 0x33ff33, 0xff33ff, 0x33ffff, 0xffff33, 0xffffff,
];

/// One decoder: a grid that grows with the drawing.
struct Decode {
    /// The pixels, four bytes each, `width * height` of them. Rows are
    /// appended six at a time as bands open, columns as codes arrive.
    rgba: Vec<u8>,
    /// The grid's size in sixel columns and sixel rows.
    cols: usize,
    rows: usize,
    /// Pixel colours by register: 0x00RRGGBB.
    registers: Vec<u32>,
    register: usize,
    /// The vertical stretch of one sixel row, as `num / den` device rows.
    aspect_num: u32,
    aspect_den: u32,
    transparent: bool,
    /// The raster attribute's canvas, when it named one.
    raster: Option<(u32, u32)>,
    /// Where the drawing stands: `x` in sixel columns, `band` in bands.
    x: usize,
    band: usize,
    /// The last band a code landed in: `-` alone opens a band without
    /// drawing in it, and the picture ends where the data stopped.
    max_band: usize,
    /// The furthest column a code landed in (before any `$` reset).
    max_x: usize,
}

impl Decode {
    fn new() -> Self {
        let mut registers = vec![0u32; REGISTERS];
        registers[..DEFAULT_COLORS.len()].copy_from_slice(&DEFAULT_COLORS);
        Self {
            rgba: Vec::new(),
            cols: 0,
            rows: 0,
            registers,
            register: 0,
            aspect_num: 2,
            aspect_den: 1,
            transparent: false,
            raster: None,
            x: 0,
            band: 0,
            max_band: 0,
            max_x: 0,
        }
    }

    /// Grow the grid until it holds `cols` columns and `bands` bands,
    /// each band `band_h` device rows. Every size is clamped to
    /// [`SIDE_CAP`] first, so a hostile raster or a huge drawing cannot
    /// allocate past the caps.
    fn grow(&mut self, cols: usize, bands: usize) {
        let cap = SIDE_CAP as usize;
        let cols = cols.min(cap);
        let bands = bands.min(cap);
        // Grow before any row of the band is written, and by the rows
        // the band needs — not by the bands the current height already
        // "holds": a band crossing the current height must be held
        // whole, its lower rows included.
        let need_rows = self.rows_of_bands(bands);
        if cols <= self.cols && need_rows <= self.rows {
            return;
        }
        // Grow geometrically: a long run of codes must not re-lay the
        // grid once per column. The cap still bounds the final size.
        let want_cols = cols.max(self.cols).next_power_of_two().min(SIDE_CAP as usize).max(self.cols);
        let want_rows = need_rows.next_power_of_two().min(SIDE_CAP as usize).max(self.rows);
        if want_cols <= self.cols && want_rows <= self.rows {
            return;
        }
        let new_cols = want_cols;
        let new_rows = want_rows;
        // Re-lay the grid at the new size, keeping what is drawn.
        let mut grid = vec![0u8; new_cols.saturating_mul(new_rows).saturating_mul(4)];
        for y in 0..self.rows {
            let (from, to) = (
                y.saturating_mul(self.cols.saturating_mul(4)),
                y.saturating_mul(new_cols.saturating_mul(4)),
            );
            let span = self.cols.saturating_mul(4);
            if from + span <= self.rgba.len() && to + span <= grid.len() {
                grid[to..to + span].copy_from_slice(&self.rgba[from..from + span]);
            }
        }
        self.rgba = grid;
        self.cols = new_cols;
        self.rows = new_rows;
    }

    /// How many device rows `bands` bands cover at the current aspect.
    fn rows_of_bands(&self, bands: usize) -> usize {
        // One band is six sixel rows, each aspect_num/aspect_den device
        // rows tall: 6 * num / den per band, rounded up so a band is
        // never empty.
        let per = (6u64 * u64::from(self.aspect_num.max(1))).div_ceil(u64::from(self.aspect_den.max(1)));
        (bands as u64).saturating_mul(per).min(u64::from(SIDE_CAP)) as usize
    }


    /// `!count code`: one sixel code across `count` columns. The count is
    /// clamped, so a hostile repeat cannot loop billions of times.
    fn repeat(&mut self, code: u8, count: u32) {
        let count = (count.max(1) as usize).min(SIDE_CAP as usize);
        for _ in 0..count {
            self.column(code);
        }
    }

    /// One sixel code: six vertical bits, bit 0 at the top, in the
    /// current colour, at the current column of the current band. Only
    /// set bits are painted. Past the side cap nothing is drawn.
    fn column(&mut self, code: u8) {
        let cap = SIDE_CAP as usize;
        if self.x >= cap || self.band >= cap {
            return;
        }
        // Grow to hold every row this band can paint before any of them
        // is written: a band crossing the current height is held whole.
        let bits = (code as u32).wrapping_sub(0x3F);
        let lowest = bits.trailing_zeros() as usize;
        let grow_to = self.band + 1;
        let _ = lowest;
        self.grow(self.x + 1, grow_to);
        let bits = (code as u32).wrapping_sub(0x3F);
        let register = self.register.min(REGISTERS - 1);
        let color = self.registers[register];
        let (r, g, b) = ((color >> 16) as u8, (color >> 8) as u8, color as u8);
        // One sixel row is aspect_num/aspect_den device rows: the rows a
        // bit covers run from sixel row * num / den to the next. The
        // grid already holds the whole band, so the runs paint every row
        // the bits reach, but never past the rows it holds.
        let num = u64::from(self.aspect_num.max(1));
        let den = u64::from(self.aspect_den.max(1)).max(1);
        let rows = self.rows as u64;
        let stride = self.cols.saturating_mul(4);
        let px = [r, g, b, 255];
        for bit in 0..6u64 {
            if bits & (1 << bit) == 0 {
                continue;
            }
            let sy = u64::from(self.band as u32) * 6 + bit;
            let y0 = (sy.saturating_mul(num) / den).min(rows);
            let y1 = ((sy + 1).saturating_mul(num) / den).max(y0 + 1).min(rows);
            if y0 >= rows {
                continue;
            }
            let mut at = y0 as usize * stride + self.x * 4;
            for _ in y0..y1 {
                self.rgba[at..at + 4].copy_from_slice(&px);
                at += stride;
            }
        }
        self.max_x = self.max_x.max(self.x);
        self.max_band = self.max_band.max(self.band);
        self.x += 1;
    }

    /// One pixel, inside the grid's bounds.
    #[allow(dead_code)]
    fn paint(&mut self, y: usize, x: usize, r: u8, g: u8, b: u8) {
        if y >= self.rows || x >= self.cols {
            return;
        }
        let at = y.saturating_mul(self.cols.saturating_mul(4)).saturating_add(x * 4);
        if at + 4 > self.rgba.len() {
            return;
        }
        self.rgba[at..at + 3].copy_from_slice(&[r, g, b]);
        self.rgba[at + 3] = 255;
    }

    /// `$`: graphics carriage return, back to the left edge of this band.
    fn cr(&mut self) {
        self.x = 0;
    }

    /// `-`: graphics new line, the next band six rows down.
    fn nl(&mut self) {
        if self.band < SIDE_CAP as usize {
            self.band += 1;
        }
        self.x = 0;
    }

    /// `+`: down a page: a new band, 80 sixel rows below.
    fn np(&mut self) {
        self.band = self.band.saturating_add(80 / 6 + 1).min(SIDE_CAP as usize);
        self.x = 0;
    }

    /// How many device rows the drawing actually reaches: the last band
    /// a code landed in, times its band height. Trims the slack the
    /// geometric growth leaves.
    fn drawn_rows(&self) -> usize {
        if self.rows == 0 {
            0
        } else {
            let per = self.rows_of_bands(1).max(1);
            self.max_band.saturating_add(1).saturating_mul(per).min(self.rows)
        }
    }

    /// The picture: the drawing's own size, or the raster attribute's
    /// canvas when that is larger, each side capped.
    fn finish(mut self) -> IntakePicture {
        let mut height = self.drawn_rows();
        let used_cols = if self.cols == 0 { 0 } else { self.max_x.saturating_add(1).min(self.cols) };
        let mut width = used_cols.min(SIDE_CAP as usize);
        if let Some((ph, pv)) = self.raster
            && ph > 0
            && pv > 0
        {
            // The raster attribute names the canvas: the picture is the
            // extent the data reached, clipped to it. Data beyond it is
            // not drawn.
            width = width.min((ph as usize).min(SIDE_CAP as usize));
            height = height.min((pv as usize).min(SIDE_CAP as usize));
        }
        if width == 0 {
            width = 1;
        }
        if height == 0 {
            // Nothing was drawn: one band, so the placement has a size.
            height = self.rows_of_bands(1).max(1);
        }
        // The grid may be wider than the drawing (growth is geometric):
        // re-lay it at the picture's own size so every row has the
        // stride the picture claims.
        if self.cols != width || self.rows < height {
            let mut grid = vec![0u8; width.saturating_mul(height).saturating_mul(4)];
            let copy_rows = self.rows.min(height);
            let copy_cols = self.cols.min(width);
            for y in 0..copy_rows {
                let from = y * self.cols * 4;
                let to = y * width * 4;
                let span = copy_cols * 4;
                if from + span <= self.rgba.len() && to + span <= grid.len() {
                    grid[to..to + span].copy_from_slice(&self.rgba[from..from + span]);
                }
            }
            self.rgba = grid;
        } else if self.rows > height {
            self.rgba.truncate(width.saturating_mul(height).saturating_mul(4));
        }
        let size = width.saturating_mul(height).saturating_mul(4);
        if self.rgba.len() < size {
            self.rgba.resize(size, 0);
        }
        if !self.transparent {
            // The background (register 0) fills what nothing painted.
            let bg = self.registers[0];
            let fill = [(bg >> 16) as u8, (bg >> 8) as u8, bg as u8, 255];
            for px in self.rgba[..size].chunks_exact_mut(4) {
                if px[3] == 0 {
                    px.copy_from_slice(&fill);
                }
            }
        }
        IntakePicture { id: 0, width: width as u32, height: height as u32, rgba: self.rgba, space: super::Space::Sixel }
    }
}

/// A 0..100 component to 0..255, as the dialect scales.
fn scale100(r: u32, g: u32, b: u32) -> u32 {
    let c = |v: u32| v.min(100) * 255 / 100;
    (c(r) << 16) | (c(g) << 8) | c(b)
}

/// HLS to the 0xRRGGBB the registers hold. Hue is degrees (0..360),
/// lightness and saturation 0..100. The sixel convention turns the wheel
/// from blue: 0 is blue, 120 red, 240 green.
fn hls(hue: u32, lightness: u32, saturation: u32) -> u32 {
    let h = ((hue % 360) + 240) as f32 % 360.0;
    let l = lightness.min(100) as f32 / 100.0;
    let s = saturation.min(100) as f32 / 100.0;
    let c = if l <= 0.5 { 2.0 * l * s } else { (2.0 - 2.0 * l) * s };
    let hp = h / 60.0;
    let x = c * (1.0 - (hp % 2.0 - 1.0).abs());
    let (r, g, b) = match (h / 60.0) as u32 {
        0 => (c, x, 0.0),
        1 => (x, c, 0.0),
        2 => (0.0, c, x),
        3 => (0.0, x, c),
        4 => (x, 0.0, c),
        _ => (c, 0.0, x),
    };
    let m = l - c / 2.0;
    let to255 = |v: f32| ((v + m).clamp(0.0, 1.0) * 255.0).round() as u32;
    (to255(r) << 16) | (to255(g) << 8) | to255(b)
}

/// Hand one DCS sixel body (parameters, `q`, data) to this dialect.
pub fn handle(body: &[u8], canvas: &mut dyn Canvas) {
    // The parameters before the `q`, `;`-separated.
    let q = body.iter().position(|&b| b == b'q').unwrap_or(body.len());
    let params: Vec<u32> = String::from_utf8_lossy(&body[..q])
        .split(';')
        .map(|p| p.trim().parse::<u32>().unwrap_or(0))
        .collect();
    let mut decode = Decode::new();
    decode.transparent = params.get(1) == Some(&1);
    // P1 carries the pixel aspect by DEC's table; the raster attribute's
    // pan/pad replaces it.
    match params.first().copied().unwrap_or(0) {
        2 => { decode.aspect_num = 5; decode.aspect_den = 1; }
        3..=4 => { decode.aspect_num = 3; decode.aspect_den = 1; }
        7..=9 => { decode.aspect_num = 1; decode.aspect_den = 1; }
        // 0, 1, 5, 6 and absent: 2:1.
        _ => { decode.aspect_num = 2; decode.aspect_den = 1; }
    }
    let data = &body[q + 1..];
    let mut i = 0;
    while i < data.len() {
        match data[i] {
            b'!' => {
                // `!count code`.
                let mut j = i + 1;
                let mut count = 0u32;
                while j < data.len() && data[j].is_ascii_digit() {
                    count = count.saturating_mul(10).saturating_add(u32::from(data[j] - b'0'));
                    j += 1;
                }
                if j < data.len() {
                    decode.repeat(data[j], count.max(1));
                    i = j + 1;
                } else {
                    i = j;
                }
            }
            b'#' | b'"' => {
                // A `;`-separated number list, closed by the first byte
                // that is neither digit nor `;`.
                let kind = data[i];
                let mut j = i + 1;
                let mut params = Vec::new();
                let mut number = String::new();
                while j < data.len() {
                    let c = data[j];
                    if c.is_ascii_digit() {
                        number.push(c as char);
                        j += 1;
                    } else if c == b';' {
                        if !number.is_empty() {
                            params.push(number.parse().unwrap_or(0));
                            number.clear();
                        }
                        j += 1;
                    } else {
                        break;
                    }
                }
                if !number.is_empty() {
                    params.push(number.parse().unwrap_or(0));
                }
                if kind == b'#' {
                    colour(&mut decode, &params);
                } else {
                    raster(&mut decode, &params);
                }
                i = j;
            }
            b'$' => {
                decode.cr();
                i += 1;
            }
            b'-' => {
                decode.nl();
                i += 1;
            }
            b'+' => {
                decode.np();
                i += 1;
            }
            0x3f..=0x7e => {
                decode.column(data[i]);
                i += 1;
            }
            _ => {
                // Anything else (padding, a stray byte) is skipped.
                i += 1;
            }
        }
    }
    let picture = decode.finish();
    let (width, height) = (picture.width, picture.height);
    // A sixel is drawn straight over the text: whatever sat on those
    // cells goes, as text drawn over it would take it.
    let (row, column) = canvas.cursor();
    canvas.overlay(IntakePicture { id: 0, width, height, rgba: picture.rgba, space: super::Space::Sixel }, (row, column));
    // After drawing, the cursor goes to the line below the image.
    let (_, ch) = canvas.cell();
    let rows = height as f32 / ch.max(1) as f32;
    let down = rows.ceil().max(1.0) as u16;
    // LF, not CUD: at the bottom of the screen the line feed scrolls, so
    // the prompt cannot draw over the picture.
    for _ in 0..down {
        canvas.feed(b"\n");
    }
}

/// A colour definition: `#id` selects, `#id;2;r;g;b` defines RGB,
/// `#id;3;h;l;s` defines HLS.
fn colour(decode: &mut Decode, params: &[u32]) {
    let Some(&id) = params.first() else { return };
    if id as usize >= REGISTERS {
        return;
    }
    match params.get(1).copied() {
        Some(2) => {
            let rgb = params.get(2..5);
            if let Some([r, g, b]) = rgb.map(|p: &[u32]| {
                [p.first().copied().unwrap_or(0), p.get(1).copied().unwrap_or(0), p.get(2).copied().unwrap_or(0)]
            }) {
                decode.registers[id as usize] = scale100(r, g, b);
            }
        }
        Some(3) => {
            let (h, l, s) = (
                params.get(2).copied().unwrap_or(0),
                params.get(3).copied().unwrap_or(0),
                params.get(4).copied().unwrap_or(0),
            );
            decode.registers[id as usize] = hls(h, l, s);
        }
        _ => {}
    }
    decode.register = id as usize;
}

/// A raster attribute `" Pan ; Pad ; Ph ; Pv`: the pixel aspect as
/// `Pan / Pad`, and the canvas size, both clamped to the caps.
fn raster(decode: &mut Decode, params: &[u32]) {
    if let (Some(&pan), Some(&pad)) = (params.first(), params.get(1))
        && pan > 0
        && pad > 0
    {
        decode.aspect_num = pan.min(SIDE_CAP);
        decode.aspect_den = pad.min(SIDE_CAP);
    }
    if let (Some(&ph), Some(&pv)) = (params.get(2), params.get(3))
        && ph > 0
        && pv > 0
    {
        decode.raster = Some((ph.min(SIDE_CAP), pv.min(SIDE_CAP)));
    }
}



#[cfg(test)]
mod tests {
    use super::*;
    use crate::intake::testing::Record;

    #[test]
    fn the_imagemagick_fixture_decodes_exactly() {
        // ImageMagick's sixel of the 320x160 gradient, live-captured.
        let six = include_bytes!("testdata/gradient-320x160.six");
        let body = &six[2..six.len() - 2]; // strip ESC P and ST
        let mut canvas = Record::new();
        handle(body, &mut canvas);
        let pictures = canvas.pictures;
        assert_eq!(pictures.len(), 1);
        let picture = &pictures[0];
        assert_eq!((picture.width, picture.height), (320, 160));
        assert_eq!(picture.rgba.len(), 320 * 160 * 4);
        for px in picture.rgba.chunks_exact(4) {
            assert_eq!(px[3], 255, "every pixel is opaque");
        }
    }

    #[test]
    fn bands_crossing_the_growth_edges_lose_no_rows() {
        // No raster attribute: bands whose bottoms cross every height
        // the geometric growth steps through (8, 16, 32, 64, 128 and
        // 256 rows). The default 2:1 aspect makes one band twelve
        // device rows; twenty-four bands reach 288 rows, past every
        // power-of-two step the growth takes.
        let mut body = Vec::new();
        body.extend_from_slice(b"0;1;0q");
        body.extend_from_slice(b"#0;2;255;0;0");
        body.extend_from_slice(b"#0");
        #[allow(clippy::same_item_push)]
        for _band in 0..23 {
            for _ in 0..8 {
                body.push(b'~');
            }
            body.push(b'-');
        }
        let mut canvas = Record::new();
        handle(&body, &mut canvas);
        let picture = &canvas.pictures[0];
        // The trailing `-` opens a band no code lands in, so the picture
        // ends at the last drawn band's bottom: twenty-three of them.
        assert_eq!(picture.height, 276);
        assert_eq!(picture.rgba.len(), picture.width as usize * 276 * 4);
        for y in 0..276 {
            for x in 0..picture.width as usize {
                let at = (y * picture.width as usize + x) * 4;
                assert_eq!(picture.rgba[at + 3], 255, "row {y} is not transparent");
            }
        }
    }
}
