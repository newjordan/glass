//! What the window looks like: font, size, colours, opacity, padding.
//!
//! Glass keeps its settings in `$XDG_CONFIG_HOME/glass/glass.conf`
//! (`~/.config/glass/glass.conf` when that is unset; `GLASS_CONFIG` names
//! another file), one `key value` a line. The first launch writes the
//! defaults there to edit, or copies over the file earlier builds kept in
//! `~/.angelX/glass.conf`; nothing else is ever read. `GLASS_*` variables
//! override the file.

use std::ffi::OsString;
use std::path::{Path, PathBuf};

pub type Rgb = [u8; 3];

/// How braille cells are drawn: braille art, plots and maps are made of
/// them, so this is the look of many terminal pictures.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum BrailleStyle {
    /// Round dots with space between them, as a braille font draws them.
    Dots,
    /// Each dot fills its eighth of the cell: braille as a 2×4 pixel grid.
    Pixels,
}

#[derive(Clone, Debug)]
pub struct Palette {
    pub foreground: Rgb,
    pub background: Rgb,
    pub cursor: Rgb,
    pub cursor_text: Rgb,
    pub ansi: [Rgb; 16],
}

impl Default for Palette {
    fn default() -> Self {
        Self {
            foreground: [0xd0, 0xd0, 0xd0],
            background: [0x00, 0x00, 0x00],
            cursor: [0xff, 0xff, 0xff],
            cursor_text: [0x00, 0x00, 0x00],
            ansi: [
                [0x00, 0x00, 0x00],
                [0xcd, 0x31, 0x31],
                [0x0d, 0xbc, 0x79],
                [0xe5, 0xe5, 0x10],
                [0x24, 0x72, 0xc8],
                [0xbc, 0x3f, 0xbc],
                [0x11, 0xa8, 0xcd],
                [0xe5, 0xe5, 0xe5],
                [0x66, 0x66, 0x66],
                [0xf1, 0x4c, 0x4c],
                [0x23, 0xd1, 0x8b],
                [0xf5, 0xf5, 0x43],
                [0x3b, 0x8e, 0xea],
                [0xd6, 0x70, 0xd6],
                [0x29, 0xb8, 0xdb],
                [0xff, 0xff, 0xff],
            ],
        }
    }
}

#[derive(Clone, Debug)]
pub struct Options {
    pub title: String,
    /// The Wayland app id and X11 class, for window rules.
    pub app_id: String,
    /// A fontconfig family name, or a path to a font file.
    pub font_family: String,
    /// Points: 96 dpi at scale 1.
    pub font_size: f32,
    pub palette: Palette,
    /// Opacity of the default background. Cells with their own background
    /// colour stay opaque.
    pub background_opacity: f32,
    /// Logical pixels around the grid.
    pub padding: f32,
    pub braille: BrailleStyle,
    /// Coverage curve for text: above 1 thins light-on-dark strokes.
    pub text_gamma: f32,
    /// Initial window size in cells.
    pub columns: u16,
    pub rows: u16,
    /// A picture behind the text, and how it shows.
    pub background_image: Option<PathBuf>,
    pub background_layout: crate::wallpaper::Layout,
    pub background_tint: f32,
    pub background_linear: bool,
    /// Whether the first frame with text plays the assembly transition
    /// (`transition.rs`). `GLASS_TRANSITION=0` turns it off.
    pub transition: bool,
}

impl Default for Options {
    fn default() -> Self {
        Self {
            title: "glass".into(),
            app_id: "glass".into(),
            font_family: "monospace".into(),
            font_size: 13.0,
            palette: Palette::default(),
            background_opacity: 1.0,
            padding: 0.0,
            braille: BrailleStyle::Dots,
            text_gamma: 1.0,
            columns: 160,
            rows: 48,
            background_image: None,
            background_layout: crate::wallpaper::Layout::Tiled,
            background_tint: 0.0,
            background_linear: false,
            transition: true,
        }
    }
}

impl Options {
    /// `glass.conf` (written with the defaults on the first launch, or
    /// copied from where earlier builds kept it), then the `GLASS_*`
    /// overrides.
    pub fn from_environment() -> Self {
        let mut options = Self::default();
        let home = std::env::var_os("HOME");
        let path = match glass_stage::env::var_os("GLASS_CONFIG").filter(|p| !p.is_empty()) {
            Some(named) => Some(PathBuf::from(named)),
            None => default_config_path(std::env::var_os("XDG_CONFIG_HOME"), home.clone()).map(|path| {
                // The settings of an earlier build, once, where they now live.
                match home.map(|home| PathBuf::from(home).join(EARLIER_CONFIG)) {
                    Some(earlier) => migrate(&path, &earlier).unwrap_or(path),
                    None => path,
                }
            }),
        };
        match path {
            Some(path) if path.is_file() => apply_conf(&mut options, &path),
            Some(path) => {
                if let Err(error) = options.save(&path) {
                    eprintln!("GLASS: could not write {}: {error}", path.display());
                }
            }
            None => {}
        }
        options.apply_env();
        options
    }

    /// The settings as a `glass.conf`.
    pub fn to_conf(&self) -> String {
        let hex = |c: Rgb| format!("#{:02x}{:02x}{:02x}", c[0], c[1], c[2]);
        let mut out = String::from(
            "# glass: the window's look, one setting a line. Edit freely;\n\
             # delete this file to start again from the defaults.\n\n",
        );
        let mut line = |key: &str, value: String| out.push_str(&format!("{key} {value}\n"));
        line("font_family", self.font_family.clone());
        line("font_size", format!("{}", self.font_size));
        // Padding is kept in points, as the font size is.
        line(
            "window_padding_width",
            format!("{}", self.padding * 72.0 / 96.0),
        );
        line("background_opacity", format!("{}", self.background_opacity));
        line("foreground", hex(self.palette.foreground));
        line("background", hex(self.palette.background));
        line("cursor", hex(self.palette.cursor));
        line("cursor_text_color", hex(self.palette.cursor_text));
        for (i, color) in self.palette.ansi.iter().enumerate() {
            line(&format!("color{i}"), hex(*color));
        }
        match &self.background_image {
            Some(path) => line("background_image", path.display().to_string()),
            None => line("background_image", "none".into()),
        }
        line(
            "background_image_layout",
            self.background_layout.name().into(),
        );
        line("background_tint", format!("{}", self.background_tint));
        line(
            "background_image_linear",
            if self.background_linear { "yes" } else { "no" }.into(),
        );
        line(
            "braille",
            match self.braille {
                BrailleStyle::Dots => "dots",
                BrailleStyle::Pixels => "pixels",
            }
            .into(),
        );
        line("text_gamma", format!("{}", self.text_gamma));
        out
    }

    fn save(&self, path: &Path) -> std::io::Result<()> {
        if let Some(dir) = path.parent() {
            std::fs::create_dir_all(dir)?;
        }
        let partial = path.with_extension("conf.new");
        std::fs::write(&partial, self.to_conf())?;
        std::fs::rename(partial, path)
    }

    /// The background image settings, when there is an image.
    pub fn wallpaper(&self) -> Option<crate::wallpaper::Settings> {
        Some(crate::wallpaper::Settings {
            path: self.background_image.clone()?,
            layout: self.background_layout,
            tint: self.background_tint,
            linear: self.background_linear,
        })
    }

    fn apply_env(&mut self) {
        let var = |name: &str| glass_stage::env::var(name).filter(|v| !v.trim().is_empty());
        if let Some(app_id) = var("GLASS_APP_ID") {
            self.app_id = app_id;
        }
        if let Some(gamma) = var("GLASS_TEXT_GAMMA").and_then(|v| ranged(&v, 0.3, 3.0)) {
            self.text_gamma = gamma;
        }
        if let Some(path) = var("GLASS_WALLPAPER") {
            self.background_image = (path != "none").then(|| expand_home(&path));
        }
        if let Some(font) = var("GLASS_FONT") {
            self.font_family = font;
        }
        if let Some(size) = var("GLASS_FONT_SIZE").and_then(|v| ranged(&v, 1.0, 256.0)) {
            self.font_size = size;
        }
        if let Some(opacity) = var("GLASS_OPACITY").and_then(|v| ranged(&v, 0.0, 1.0)) {
            self.background_opacity = opacity;
        }
        if let Some(padding) = var("GLASS_PADDING").and_then(|v| ranged(&v, 0.0, 512.0)) {
            self.padding = padding;
        }
        if let Some(style) = var("GLASS_BRAILLE") {
            self.braille = match style.as_str() {
                "pixels" => BrailleStyle::Pixels,
                _ => BrailleStyle::Dots,
            };
        }
        if let Some((columns, rows)) = var("GLASS_SIZE").and_then(|v| {
            let (c, r) = v.split_once(['x', 'X'])?;
            let pair: (u16, u16) = (c.trim().parse().ok()?, r.trim().parse().ok()?);
            (pair.0 > 0 && pair.1 > 0).then_some(pair)
        }) {
            self.columns = columns;
            self.rows = rows;
        }
        if var("GLASS_TRANSITION").is_some_and(|v| v == "0") {
            self.transition = false;
        }
    }
}

/// Where earlier builds kept the settings, under the home directory.
const EARLIER_CONFIG: &str = ".angelX/glass.conf";

/// Glass's own settings when `GLASS_CONFIG` names none: `glass/glass.conf`
/// in the XDG config home, `~/.config` when that is unset or not absolute
/// (as the XDG spec says to treat a relative one).
fn default_config_path(xdg_config_home: Option<OsString>, home: Option<OsString>) -> Option<PathBuf> {
    let base = xdg_config_home
        .map(PathBuf::from)
        .filter(|dir| dir.is_absolute())
        .or_else(|| home.map(|home| PathBuf::from(home).join(".config")))?;
    Some(base.join("glass").join("glass.conf"))
}

/// Copy `earlier` to `path` when `path` does not exist yet and `earlier`
/// does: once, saying so on stderr. Returns the file to read, `path` once
/// copied (`earlier` itself if the copy failed), or `None` when there is
/// nothing to bring over.
fn migrate(path: &Path, earlier: &Path) -> Option<PathBuf> {
    if path.exists() || !earlier.is_file() {
        return None;
    }
    let partial = path.with_extension("conf.new");
    let copied = path
        .parent()
        .map_or(Ok(()), std::fs::create_dir_all)
        .and_then(|()| std::fs::copy(earlier, &partial))
        .and_then(|_| std::fs::rename(&partial, path));
    match copied {
        Ok(()) => {
            eprintln!("GLASS: copied your settings from {} to {}, where glass reads them now", earlier.display(), path.display());
            Some(path.to_path_buf())
        }
        Err(error) => {
            let _ = std::fs::remove_file(&partial);
            eprintln!("GLASS: could not copy {} to {}: {error}; reading it where it is", earlier.display(), path.display());
            Some(earlier.to_path_buf())
        }
    }
}

fn expand_home(path: &str) -> PathBuf {
    match path.strip_prefix("~/") {
        Some(rest) => std::env::var_os("HOME")
            .map(|home| PathBuf::from(home).join(rest))
            .unwrap_or_else(|| PathBuf::from(path)),
        None => PathBuf::from(path),
    }
}

/// A config is a few kilobytes; anything past this is not read.
const MAX_CONFIG_BYTES: u64 = 1 << 20;

fn apply_conf(options: &mut Options, path: &Path) {
    use std::io::Read as _;
    let Ok(file) = std::fs::File::open(path) else {
        return;
    };
    let mut bytes = Vec::new();
    if file
        .take(MAX_CONFIG_BYTES)
        .read_to_end(&mut bytes)
        .is_err()
    {
        return;
    }
    let Ok(text) = String::from_utf8(bytes) else {
        return;
    };
    for line in text.lines() {
        let line = line.trim();
        if line.is_empty() || line.starts_with('#') {
            continue;
        }
        let (key, value) = line
            .split_once(char::is_whitespace)
            .map_or((line, ""), |(k, v)| (k, v.trim()));
        match key {
            "font_family" => {
                if !value.is_empty() {
                    options.font_family = value.to_string();
                }
            }
            "font_size" => {
                if let Some(size) = ranged(value, 1.0, 256.0) {
                    options.font_size = size;
                }
            }
            "background_opacity" => {
                if let Some(opacity) = ranged(value, 0.0, 1.0) {
                    options.background_opacity = opacity;
                }
            }
            "window_padding_width" => {
                if let Some(padding) = value.split_whitespace().next().and_then(number) {
                    // In points, as the font size is.
                    options.padding = (padding * 96.0 / 72.0).clamp(0.0, 512.0);
                }
            }
            "background_image" => {
                // A relative path is relative to the config file.
                options.background_image = (value != "none" && !value.is_empty()).then(|| {
                    let image = expand_home(value);
                    match path.parent() {
                        Some(dir) if image.is_relative() => dir.join(image),
                        _ => image,
                    }
                });
            }
            "background_image_layout" => {
                if let Some(layout) = crate::wallpaper::Layout::parse(value) {
                    options.background_layout = layout;
                }
            }
            "background_tint" => {
                if let Some(tint) = ranged(value, 0.0, 1.0) {
                    options.background_tint = tint;
                }
            }
            "background_image_linear" => options.background_linear = value == "yes",
            "braille" => {
                options.braille = match value {
                    "pixels" => BrailleStyle::Pixels,
                    _ => BrailleStyle::Dots,
                }
            }
            "text_gamma" => {
                if let Some(gamma) = ranged(value, 0.3, 3.0) {
                    options.text_gamma = gamma;
                }
            }
            "foreground" => set_color(&mut options.palette.foreground, value),
            "background" => set_color(&mut options.palette.background, value),
            "cursor" => set_color(&mut options.palette.cursor, value),
            "cursor_text_color" => set_color(&mut options.palette.cursor_text, value),
            _ => {
                if let Some(index) = key
                    .strip_prefix("color")
                    .and_then(|n| n.parse::<usize>().ok())
                    && index < 16
                {
                    set_color(&mut options.palette.ansi[index], value);
                }
            }
        }
    }
}

fn set_color(slot: &mut Rgb, value: &str) {
    if let Some(color) = parse_hex(value) {
        *slot = color;
    }
}

/// A finite number from config text or the environment. Rust's float
/// parser accepts `nan`, `inf` and overflowing exponents, and a NaN font
/// size or opacity would flow straight into cell metrics and the clear
/// colour, so anything non-finite is no number at all.
fn number(value: &str) -> Option<f32> {
    value.parse().ok().filter(|v: &f32| v.is_finite())
}

/// A finite number clamped to a sane range for its setting.
fn ranged(value: &str, lo: f32, hi: f32) -> Option<f32> {
    number(value).map(|v| v.clamp(lo, hi))
}

pub(crate) fn parse_hex(value: &str) -> Option<Rgb> {
    let hex = value.trim().strip_prefix('#')?;
    // The slicing below pairs bytes; a multibyte string of the right byte
    // length would otherwise panic on a non-char-boundary.
    if !hex.is_ascii() {
        return None;
    }
    let digit = |i: usize, len: usize| u8::from_str_radix(&hex[i..i + len], 16).ok();
    match hex.len() {
        6 => Some([digit(0, 2)?, digit(2, 2)?, digit(4, 2)?]),
        3 => Some([digit(0, 1)? * 17, digit(1, 1)? * 17, digit(2, 1)? * 17]),
        _ => None,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_family_is_the_rest_of_its_line_and_never_empty() {
        assert_eq!(options_from("font_family Berkeley Mono\n").font_family, "Berkeley Mono");
        assert_eq!(options_from("font_family\n").font_family, Options::default().font_family);
    }

    #[test]
    fn saved_settings_read_back_the_same() {
        let mut palette = Palette::default();
        palette.ansi[3] = [0x66, 0x66, 0x00];
        let options = Options {
            font_family: "Berkeley Mono".into(),
            font_size: 15.0,
            padding: 14.0 * 96.0 / 72.0,
            palette,
            background_image: Some(PathBuf::from("/tmp/frost.png")),
            background_layout: crate::wallpaper::Layout::Centered,
            background_tint: 0.5,
            braille: BrailleStyle::Pixels,
            ..Default::default()
        };
        let path = std::env::temp_dir().join(format!("glass-conf-{}.conf", std::process::id()));
        options.save(&path).unwrap();
        let mut back = Options::default();
        apply_conf(&mut back, &path);
        let _ = std::fs::remove_file(&path);
        assert_eq!(back.font_family, "Berkeley Mono");
        assert_eq!(back.font_size, 15.0);
        assert!((back.padding - options.padding).abs() < 1e-3);
        assert_eq!(back.palette.ansi, options.palette.ansi);
        assert_eq!(back.palette.foreground, options.palette.foreground);
        assert_eq!(back.background_image, options.background_image);
        assert_eq!(back.background_layout, crate::wallpaper::Layout::Centered);
        assert_eq!(back.background_tint, 0.5);
        assert_eq!(back.braille, BrailleStyle::Pixels);
    }

    #[test]
    fn hex_colors() {
        assert_eq!(parse_hex("#00ffff"), Some([0, 255, 255]));
        assert_eq!(parse_hex("#fff"), Some([255, 255, 255]));
        assert_eq!(parse_hex("cyan"), None);
    }

    #[test]
    fn hex_colors_reject_multibyte_without_panicking() {
        // Six bytes, but the pair boundaries fall inside the characters.
        assert_eq!(parse_hex("#界界"), None);
        assert_eq!(parse_hex("#ééé"), None);
        assert_eq!(parse_hex("#12é456"), None);
    }

    fn options_from(text: &str) -> Options {
        let path = std::env::temp_dir().join(format!(
            "glass-conf-bad-{}-{}.conf",
            std::process::id(),
            text.len()
        ));
        std::fs::write(&path, text).unwrap();
        let mut options = Options::default();
        apply_conf(&mut options, &path);
        let _ = std::fs::remove_file(&path);
        options
    }

    #[test]
    fn an_oversized_config_is_capped_not_swallowed_whole() {
        // Settings past the read cap never apply: a hostile or accidental
        // giant file must not be read into memory unbounded on the startup
        // path.
        let mut text = String::from("font_size 20\n");
        text.push_str(&"# filler\n".repeat(300_000));
        text.push_str("font_size 99\n");
        let options = options_from(&text);
        assert_eq!(options.font_size, 20.0, "past the cap, nothing applies");
    }

    #[test]
    fn malformed_numbers_keep_the_defaults() {
        let options = options_from(
            "font_size nan\nbackground_opacity inf\nwindow_padding_width -inf\nbackground_tint nan\ntext_gamma 1e999\n",
        );
        let defaults = Options::default();
        assert_eq!(options.font_size, defaults.font_size);
        assert_eq!(options.background_opacity, defaults.background_opacity);
        assert_eq!(options.padding, defaults.padding);
        assert_eq!(options.background_tint, defaults.background_tint);
        assert_eq!(options.text_gamma, defaults.text_gamma);
    }

    #[test]
    fn absurd_numbers_clamp_to_sane_ranges() {
        let options = options_from(
            "font_size 100000\nwindow_padding_width -50\nbackground_opacity 7\n",
        );
        assert!(options.font_size.is_finite() && options.font_size <= 256.0, "{}", options.font_size);
        assert!(options.padding >= 0.0 && options.padding.is_finite(), "{}", options.padding);
        assert_eq!(options.background_opacity, 1.0);
        let tiny = options_from("font_size 0.01\n");
        assert!(tiny.font_size >= 1.0, "{}", tiny.font_size);
    }

    /// A fresh, empty directory under the system's temporary one.
    fn scratch(name: &str) -> PathBuf {
        let dir = std::env::temp_dir().join(format!("glass-conf-{name}-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&dir);
        std::fs::create_dir_all(&dir).unwrap();
        dir
    }

    #[test]
    fn the_config_lives_in_the_xdg_config_home() {
        let path = |xdg: Option<&str>, home: Option<&str>| default_config_path(xdg.map(Into::into), home.map(Into::into));
        assert_eq!(path(Some("/x/conf"), Some("/home/u")), Some(PathBuf::from("/x/conf/glass/glass.conf")));
        assert_eq!(path(None, Some("/home/u")), Some(PathBuf::from("/home/u/.config/glass/glass.conf")));
        // A relative XDG_CONFIG_HOME is ignored, as the spec says.
        assert_eq!(path(Some("conf"), Some("/home/u")), Some(PathBuf::from("/home/u/.config/glass/glass.conf")));
        assert_eq!(path(Some(""), Some("/home/u")), Some(PathBuf::from("/home/u/.config/glass/glass.conf")));
        assert_eq!(path(None, None), None);
    }

    #[test]
    fn an_earlier_config_is_copied_over_once() {
        let dir = scratch("migrate");
        let earlier = dir.join("home/.angelX/glass.conf");
        let path = dir.join("config/glass/glass.conf");
        std::fs::create_dir_all(earlier.parent().unwrap()).unwrap();
        std::fs::write(&earlier, "font_size 21\n").unwrap();
        assert_eq!(migrate(&path, &earlier), Some(path.clone()), "copied, and read from its new place");
        assert_eq!(std::fs::read_to_string(&path).unwrap(), "font_size 21\n");
        assert!(earlier.is_file(), "the earlier file is left as it was");
        assert!(!path.with_extension("conf.new").exists());
        let mut options = Options::default();
        apply_conf(&mut options, &path);
        assert_eq!(options.font_size, 21.0);
        // Once there, it is glass's: edits stay, and nothing is copied again.
        std::fs::write(&path, "font_size 9\n").unwrap();
        assert_eq!(migrate(&path, &earlier), None);
        assert_eq!(std::fs::read_to_string(&path).unwrap(), "font_size 9\n");
        let _ = std::fs::remove_dir_all(&dir);
    }

    #[test]
    fn nothing_is_copied_without_an_earlier_config() {
        let dir = scratch("fresh");
        let path = dir.join("config/glass/glass.conf");
        assert_eq!(migrate(&path, &dir.join("home/.angelX/glass.conf")), None);
        assert!(!path.exists() && !dir.join("config").exists());
        // The first launch then writes the defaults, which say glass.
        Options::default().save(&path).unwrap();
        let text = std::fs::read_to_string(&path).unwrap();
        assert!(text.starts_with("# glass: "), "{text}");
        assert!(!text.to_lowercase().contains("angel"), "{text}");
        let _ = std::fs::remove_dir_all(&dir);
    }

    #[test]
    fn the_defaults_are_glass() {
        let options = Options::default();
        assert_eq!((options.title.as_str(), options.app_id.as_str()), ("glass", "glass"));
        assert!(options.transition);
    }
}
