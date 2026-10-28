//! The window's first frames, drawn on the CPU while the GPU opens.
//!
//! Opening the GPU takes most of startup (on an NVIDIA card about a tenth
//! of a second in the driver's instance and device), and a Wayland window
//! is not shown until something has been drawn into it. So once the window
//! exists, its background goes to the compositor as a plain shared-memory
//! buffer: the background colour at the window's opacity, and the
//! background image laid out and tinted as the GPU lays it out. The window
//! is on screen while the GPU is still opening, and it is drawn again at
//! each size the compositor gives it meanwhile. The GPU's first frame
//! takes its place; a few frames later the buffer is let go.
//!
//! Wayland only. Elsewhere, or if any step fails, nothing is drawn here and
//! the window shows with the GPU's first frame.

use winit::window::Window;

use crate::wallpaper::{Layout, Wallpaper};

/// What the background looks like, as the GPU draws it under everything.
pub struct Look<'a> {
    pub background: [u8; 3],
    pub opacity: f32,
    pub wallpaper: Option<&'a Wallpaper>,
}

/// A frame on show, kept until the GPU's frames have replaced it.
pub struct Frame {
    #[cfg(all(unix, not(target_os = "macos")))]
    _shown: wayland::Shown,
    /// GPU frames presented since.
    presents: u8,
}

impl Frame {
    /// A GPU frame was presented. True once enough have been that this
    /// buffer is off screen for good and can go.
    pub fn presented(&mut self) -> bool {
        self.presents = self.presents.saturating_add(1);
        self.presents >= 3
    }
}

/// Show `look` in `window`, at the window's size, now. `None` where it
/// can't be.
pub fn show(window: &Window, look: &Look<'_>) -> Option<Frame> {
    let size = window.inner_size();
    if !(1..=16384).contains(&size.width) || !(1..=16384).contains(&size.height) {
        return None;
    }
    #[cfg(all(unix, not(target_os = "macos")))]
    {
        let shown = wayland::show(window, size.width, size.height, || paint(look, size.width, size.height))?;
        Some(Frame { _shown: shown, presents: 0 })
    }
    #[cfg(not(all(unix, not(target_os = "macos"))))]
    {
        let _ = (window, look);
        None
    }
}

/// The background as the GPU draws it: the background colour at the
/// window's opacity, the image over it where its layout places it (nearest
/// pixels, as the GPU samples it unless `linear` is set), then the tint
/// toward the background colour over the whole window. Premultiplied, as
/// Wayland's ARGB8888 is, in its little-endian byte order (B, G, R, A).
fn paint(look: &Look<'_>, width: u32, height: u32) -> Vec<u8> {
    let (w, h) = (width as usize, height as usize);
    let alpha = look.opacity.clamp(0.0, 1.0);
    let bg = look.background.map(|c| f32::from(c) / 255.0);
    let clear = [bg[0] * alpha, bg[1] * alpha, bg[2] * alpha, alpha];
    let tint = look.wallpaper.map_or(0.0, |image| (image.tint * alpha).clamp(0.0, 1.0));
    let finish = move |p: [f32; 4]| -> [u8; 4] {
        let p = if tint > 0.0 {
            [
                bg[0] * tint + p[0] * (1.0 - tint),
                bg[1] * tint + p[1] * (1.0 - tint),
                bg[2] * tint + p[2] * (1.0 - tint),
                tint + p[3] * (1.0 - tint),
            ]
        } else {
            p
        };
        let byte = |v: f32| (v.clamp(0.0, 1.0) * 255.0).round() as u8;
        [byte(p[2]), byte(p[1]), byte(p[0]), byte(p[3])]
    };
    let plain = finish(clear);
    let mut out = vec![0u8; w * h * 4];
    let Some(image) = look.wallpaper else {
        for pixel in out.chunks_exact_mut(4) {
            pixel.copy_from_slice(&plain);
        }
        return out;
    };
    // Where each window column and row reads the image, if it does.
    let (dst, src) = image.quad((width as f32, height as f32));
    let texels = |count: usize, at: f32, span: f32, from: f32, length: f32, size: u32| -> Vec<Option<usize>> {
        (0..count)
            .map(|i| {
                let t = (i as f32 + 0.5 - at) / span;
                if !(0.0..1.0).contains(&t) {
                    return None;
                }
                let texel = (from + t * length).floor() as i64;
                Some(address(image.layout, texel, i64::from(size)))
            })
            .collect()
    };
    let columns = texels(w, dst[0], dst[2], src[0], src[2], image.width);
    let rows = texels(h, dst[1], dst[3], src[1], src[3], image.height);
    let iw = image.width as usize;
    let fill = |(y, line): (usize, &mut [u8])| {
        for (x, pixel) in line.chunks_exact_mut(4).enumerate() {
            let value = match (rows[y], columns[x]) {
                (Some(ty), Some(tx)) => {
                    let at = (ty * iw + tx) * 4;
                    let Some(texel) = image.rgba.get(at..at + 4) else {
                        pixel.copy_from_slice(&plain);
                        continue;
                    };
                    let a = f32::from(texel[3]) / 255.0 * alpha;
                    let c = |i: usize| f32::from(texel[i]) / 255.0 * a + clear[i] * (1.0 - a);
                    finish([c(0), c(1), c(2), a + clear[3] * (1.0 - a)])
                }
                _ => plain,
            };
            pixel.copy_from_slice(&value);
        }
    };
    // Rows in bands across a few threads: a full-screen window is a few
    // million pixels, and this is on the way to the first frame.
    let threads = std::thread::available_parallelism().map_or(1, |n| n.get().min(8));
    let band = h.div_ceil(threads).max(1) * w * 4;
    let fill = &fill;
    std::thread::scope(|scope| {
        for (n, chunk) in out.chunks_mut(band).enumerate() {
            let first = n * (band / (w * 4));
            scope.spawn(move || chunk.chunks_exact_mut(w * 4).enumerate().for_each(|(y, line)| fill((first + y, line))));
        }
    });
    out
}

/// The texel `texel` reads in an image `size` wide, as the GPU's sampler
/// addresses it for `layout`.
fn address(layout: Layout, texel: i64, size: i64) -> usize {
    let size = size.max(1);
    let at = match layout {
        Layout::Tiled => texel.rem_euclid(size),
        Layout::MirrorTiled => {
            let period = texel.rem_euclid(2 * size);
            if period < size { period } else { 2 * size - 1 - period }
        }
        _ => texel.clamp(0, size - 1),
    };
    at as usize
}

#[cfg(all(unix, not(target_os = "macos")))]
mod wayland {
    use std::io::Write;
    use std::os::fd::AsFd;
    use std::os::unix::fs::OpenOptionsExt;

    use wayland_backend::client::{Backend, ObjectId};
    use wayland_client::globals::{GlobalListContents, registry_queue_init};
    use wayland_client::protocol::{wl_buffer, wl_registry, wl_shm, wl_shm_pool, wl_surface};
    use wayland_client::{Connection, Dispatch, EventQueue, Proxy, QueueHandle};
    use winit::raw_window_handle::{HasDisplayHandle, HasWindowHandle, RawDisplayHandle, RawWindowHandle};
    use winit::window::Window;

    /// A buffer attached to the window's surface, and what it came through.
    pub struct Shown {
        conn: Connection,
        pool: wl_shm_pool::WlShmPool,
        buffer: wl_buffer::WlBuffer,
        // Dropped last: the objects above are on it.
        _queue: EventQueue<State>,
    }

    impl Drop for Shown {
        fn drop(&mut self) {
            self.buffer.destroy();
            self.pool.destroy();
            let _ = self.conn.flush();
        }
    }

    pub struct State;

    impl Dispatch<wl_registry::WlRegistry, GlobalListContents> for State {
        fn event(
            _: &mut Self,
            _: &wl_registry::WlRegistry,
            _: wl_registry::Event,
            _: &GlobalListContents,
            _: &Connection,
            _: &QueueHandle<Self>,
        ) {
        }
    }

    wayland_client::delegate_noop!(State: ignore wl_shm::WlShm);
    wayland_client::delegate_noop!(State: wl_shm_pool::WlShmPool);
    wayland_client::delegate_noop!(State: ignore wl_buffer::WlBuffer);

    /// Attach `paint`'s pixels, `width` by `height`, to `window`'s surface
    /// and commit, on a connection of our own to winit's display.
    pub fn show(window: &Window, width: u32, height: u32, paint: impl FnOnce() -> Vec<u8>) -> Option<Shown> {
        let RawDisplayHandle::Wayland(display) = window.display_handle().ok()?.as_raw() else {
            return None;
        };
        let RawWindowHandle::Wayland(surface) = window.window_handle().ok()?.as_raw() else {
            return None;
        };
        // SAFETY: the display and the surface are winit's, live for as long
        // as `window` is, and outlive this (the window lets this go first:
        // `Glass::release`).
        let conn = Connection::from_backend(unsafe { Backend::from_foreign_display(display.display.as_ptr().cast()) });
        let (globals, queue) = registry_queue_init::<State>(&conn).ok()?;
        let qh = queue.handle();
        let shm: wl_shm::WlShm = globals.bind(&qh, 1..=1, ()).ok()?;
        // SAFETY: as above; the pointer is a live wl_surface proxy.
        let id = unsafe { ObjectId::from_ptr(wl_surface::WlSurface::interface(), surface.surface.as_ptr().cast()) }.ok()?;
        let surface = wl_surface::WlSurface::from_id(&conn, id).ok()?;
        let pixels = paint();
        let bytes = i32::try_from(pixels.len()).ok()?;
        let file = memory(&pixels)?;
        let pool = shm.create_pool(file.as_fd(), bytes, &qh, ());
        let (w, h) = (i32::try_from(width).ok()?, i32::try_from(height).ok()?);
        let buffer = pool.create_buffer(0, w, h, w * 4, wl_shm::Format::Argb8888, &qh, ());
        surface.attach(Some(&buffer), 0, 0);
        if surface.version() >= 4 {
            surface.damage_buffer(0, 0, w, h);
        } else {
            surface.damage(0, 0, w, h);
        }
        surface.commit();
        conn.flush().ok()?;
        Some(Shown { conn, pool, buffer, _queue: queue })
    }

    /// `pixels` in a file of shared memory: one in the runtime directory
    /// (a tmpfs), unlinked once open.
    fn memory(pixels: &[u8]) -> Option<std::fs::File> {
        let dir = std::env::var_os("XDG_RUNTIME_DIR")?;
        let nanos = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).map_or(0, |d| d.subsec_nanos());
        let path = std::path::Path::new(&dir).join(format!("glass-early-{}-{nanos}", std::process::id()));
        let mut file = std::fs::OpenOptions::new().read(true).write(true).create_new(true).mode(0o600).open(&path).ok()?;
        let _ = std::fs::remove_file(&path);
        file.write_all(pixels).ok()?;
        Some(file)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn wallpaper(layout: Layout, tint: f32) -> Wallpaper {
        // 2 by 1: red then green, opaque.
        Wallpaper { width: 2, height: 1, rgba: vec![255, 0, 0, 255, 0, 255, 0, 255], layout, tint, linear: false }
    }

    fn at(pixels: &[u8], width: u32, x: u32, y: u32) -> [u8; 4] {
        let i = ((y * width + x) * 4) as usize;
        [pixels[i], pixels[i + 1], pixels[i + 2], pixels[i + 3]]
    }

    #[test]
    fn the_background_alone_is_premultiplied_bgra() {
        let look = Look { background: [200, 100, 50], opacity: 0.5, wallpaper: None };
        let pixels = paint(&look, 3, 2);
        assert_eq!(pixels.len(), 3 * 2 * 4);
        assert!(pixels.chunks_exact(4).all(|p| p == [25, 50, 100, 128]));
    }

    #[test]
    fn a_centred_image_sits_in_the_middle_and_the_tint_covers_the_window() {
        let image = wallpaper(Layout::Centered, 0.5);
        let look = Look { background: [0, 0, 0], opacity: 1.0, wallpaper: Some(&image) };
        let pixels = paint(&look, 4, 1);
        // Black either side; red then green between, half toward black.
        assert_eq!(at(&pixels, 4, 0, 0), [0, 0, 0, 255]);
        assert_eq!(at(&pixels, 4, 1, 0), [0, 0, 128, 255]);
        assert_eq!(at(&pixels, 4, 2, 0), [0, 128, 0, 255]);
        assert_eq!(at(&pixels, 4, 3, 0), [0, 0, 0, 255]);
    }

    #[test]
    fn tiles_repeat_and_mirrored_tiles_turn_back() {
        let tiled = wallpaper(Layout::Tiled, 0.0);
        let mirrored = wallpaper(Layout::MirrorTiled, 0.0);
        let row = |image: &Wallpaper| {
            let look = Look { background: [0, 0, 0], opacity: 1.0, wallpaper: Some(image) };
            let pixels = paint(&look, 6, 1);
            (0..6).map(|x| if at(&pixels, 6, x, 0)[2] == 255 { 'r' } else { 'g' }).collect::<String>()
        };
        assert_eq!(row(&tiled), "rgrgrg");
        assert_eq!(row(&mirrored), "rggrrg");
        assert_eq!(address(Layout::Clamped, -3, 2), 0);
        assert_eq!(address(Layout::Clamped, 9, 2), 1);
    }

    #[test]
    fn many_rows_are_painted_alike_across_the_bands() {
        let look = Look { background: [1, 2, 3], opacity: 1.0, wallpaper: None };
        let pixels = paint(&look, 7, 97);
        assert!(pixels.chunks_exact(4).all(|p| p == [3, 2, 1, 255]));
    }
}
