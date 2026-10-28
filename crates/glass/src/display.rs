//! The main display, asked before there is a window on it.

/// The main display's scale: device pixels to a point in its current
/// mode, which is the scale a window opened on it gets (2 on a Retina
/// display, 1 on most others). `None` if the display can't be asked.
#[cfg(target_os = "macos")]
pub fn main_scale() -> Option<f32> {
    use std::ffi::c_void;
    #[link(name = "CoreGraphics", kind = "framework")]
    unsafe extern "C" {
        fn CGMainDisplayID() -> u32;
        fn CGDisplayCopyDisplayMode(display: u32) -> *mut c_void;
        fn CGDisplayModeGetPixelWidth(mode: *mut c_void) -> usize;
        fn CGDisplayModeGetWidth(mode: *mut c_void) -> usize;
        fn CGDisplayModeRelease(mode: *mut c_void);
    }
    // SAFETY: the mode is checked for null before it is read, and
    // released once, after its last read; the display id needs no release.
    let (pixels, points) = unsafe {
        let mode = CGDisplayCopyDisplayMode(CGMainDisplayID());
        if mode.is_null() {
            return None;
        }
        let sizes = (CGDisplayModeGetPixelWidth(mode), CGDisplayModeGetWidth(mode));
        CGDisplayModeRelease(mode);
        sizes
    };
    (points > 0 && pixels > 0).then(|| pixels as f32 / points as f32)
}
