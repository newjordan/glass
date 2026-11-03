//! Generate the exact Unicode scalar width policy from the pinned dependency.
//! Values 0..=3 are widths; 255 means `None` or a surrogate (not a Rust `char`).
use std::{env, fs, path::PathBuf};

fn main() {
    println!("cargo:rerun-if-changed=build.rs");
    let widths: Vec<u8> = (0..0x110000)
        .map(|value| {
            char::from_u32(value)
                .and_then(unicode_width::UnicodeWidthChar::width)
                .map_or(u8::MAX, |width| {
                    assert!(width <= 3, "unexpected Unicode scalar width: {width}");
                    width as u8
                })
        })
        .collect();
    let out = PathBuf::from(env::var_os("OUT_DIR").expect("Cargo OUT_DIR"));
    fs::write(out.join("unicode-widths.bin"), widths).expect("write generated Unicode widths");
}
