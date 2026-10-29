// calclient: a known-timed stimulus for calibrating viscap.
//
// Opens one xdg_toplevel (app_id from argv, default bench-vis.cal), shows it
// grey, then N times, at random moments 150-260 ms apart, switches the whole
// window between the marker colour (255,0,255) and grey. For every switch it
// records the CLOCK_MONOTONIC time just before wl_surface.commit and asks the
// compositor for wp_presentation feedback, which says when the frame holding
// that buffer was presented. Lines on stdout:
//
//   commit  i colour mono_ns
//   presented i mono_ns refresh_ns
//   discarded i
//
// usage: calclient [APP_ID] [N]
#define _GNU_SOURCE
#include <fcntl.h>
#include <poll.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <time.h>
#include <unistd.h>
#include <wayland-client.h>
#include "xdg-shell-client.h"
#include "presentation-time-client.h"

static struct wl_compositor *comp;
static struct wl_shm *shm;
static struct xdg_wm_base *wm;
static struct wp_presentation *pres;
static uint32_t pres_clock = 99;
static int cfg_w, cfg_h, configured, closed;

static int64_t mono(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (int64_t)ts.tv_sec * 1000000000LL + ts.tv_nsec;
}

static void pres_clock_id(void *d, struct wp_presentation *p, uint32_t clk) { pres_clock = clk; }
static const struct wp_presentation_listener pres_l = { pres_clock_id };

static void ping(void *d, struct xdg_wm_base *w, uint32_t serial) { xdg_wm_base_pong(w, serial); }
static const struct xdg_wm_base_listener wm_l = { ping };

static void reg_global(void *d, struct wl_registry *r, uint32_t name, const char *iface, uint32_t ver) {
    if (!strcmp(iface, wl_compositor_interface.name)) comp = wl_registry_bind(r, name, &wl_compositor_interface, 4);
    else if (!strcmp(iface, wl_shm_interface.name)) shm = wl_registry_bind(r, name, &wl_shm_interface, 1);
    else if (!strcmp(iface, xdg_wm_base_interface.name)) {
        wm = wl_registry_bind(r, name, &xdg_wm_base_interface, 1);
        xdg_wm_base_add_listener(wm, &wm_l, NULL);
    } else if (!strcmp(iface, wp_presentation_interface.name)) {
        pres = wl_registry_bind(r, name, &wp_presentation_interface, 1);
        wp_presentation_add_listener(pres, &pres_l, NULL);
    }
}
static void reg_remove(void *d, struct wl_registry *r, uint32_t name) {}
static const struct wl_registry_listener reg_l = { reg_global, reg_remove };

static void xs_configure(void *d, struct xdg_surface *s, uint32_t serial) { xdg_surface_ack_configure(s, serial); configured = 1; }
static const struct xdg_surface_listener xs_l = { xs_configure };
static void tl_configure(void *d, struct xdg_toplevel *t, int32_t w, int32_t h, struct wl_array *st) { if (w > 0 && h > 0) { cfg_w = w; cfg_h = h; } }
static void tl_close(void *d, struct xdg_toplevel *t) { closed = 1; }
static void tl_bounds(void *d, struct xdg_toplevel *t, int32_t w, int32_t h) {}
static void tl_caps(void *d, struct xdg_toplevel *t, struct wl_array *c) {}
static const struct xdg_toplevel_listener tl_l = { tl_configure, tl_close, tl_bounds, tl_caps };

static struct wl_buffer *make_buffer(int w, int h, uint32_t xrgb) {
    int stride = w * 4;
    size_t size = (size_t)stride * h;
    int fd = memfd_create("calclient", MFD_CLOEXEC);
    if (fd < 0 || ftruncate(fd, size) < 0) { perror("memfd"); exit(1); }
    uint32_t *px = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    for (size_t i = 0; i < size / 4; i++) px[i] = xrgb;
    munmap(px, size);
    struct wl_shm_pool *pool = wl_shm_create_pool(shm, fd, size);
    struct wl_buffer *b = wl_shm_pool_create_buffer(pool, 0, w, h, stride, WL_SHM_FORMAT_XRGB8888);
    wl_shm_pool_destroy(pool);
    close(fd);
    return b;
}

static void fb_sync(void *d, struct wp_presentation_feedback *f, struct wl_output *o) {}
static void fb_presented(void *d, struct wp_presentation_feedback *f, uint32_t hi, uint32_t lo, uint32_t ns, uint32_t refresh, uint32_t shi, uint32_t slo, uint32_t flags) {
    int64_t t = (int64_t)((((uint64_t)hi) << 32) | lo) * 1000000000LL + ns;
    printf("presented %d %lld %u\n", (int)(intptr_t)d, (long long)t, refresh);
    fflush(stdout);
    wp_presentation_feedback_destroy(f);
}
static void fb_discarded(void *d, struct wp_presentation_feedback *f) {
    printf("discarded %d\n", (int)(intptr_t)d);
    fflush(stdout);
    wp_presentation_feedback_destroy(f);
}
static const struct wp_presentation_feedback_listener fb_l = { fb_sync, fb_presented, fb_discarded };

// Dispatch events for up to ms milliseconds.
static void pump(struct wl_display *dpy, int ms) {
    int64_t end = mono() + (int64_t)ms * 1000000;
    for (;;) {
        while (wl_display_prepare_read(dpy) != 0) wl_display_dispatch_pending(dpy);
        wl_display_flush(dpy);
        int64_t left = end - mono();
        if (left <= 0) { wl_display_cancel_read(dpy); break; }
        struct pollfd p = { wl_display_get_fd(dpy), POLLIN, 0 };
        if (poll(&p, 1, (int)((left + 999999) / 1000000)) > 0 && (p.revents & POLLIN)) wl_display_read_events(dpy);
        else wl_display_cancel_read(dpy);
        wl_display_dispatch_pending(dpy);
    }
}

int main(int argc, char **argv) {
    const char *app_id = argc > 1 ? argv[1] : "bench-vis.cal";
    int n = argc > 2 ? atoi(argv[2]) : 20;
    struct wl_display *dpy = wl_display_connect(NULL);
    if (!dpy) { fprintf(stderr, "calclient: no Wayland display\n"); return 1; }
    struct wl_registry *reg = wl_display_get_registry(dpy);
    wl_registry_add_listener(reg, &reg_l, NULL);
    wl_display_roundtrip(dpy);
    wl_display_roundtrip(dpy);
    if (!comp || !shm || !wm || !pres) { fprintf(stderr, "calclient: missing globals\n"); return 1; }
    printf("# presentation clock %u (1 = CLOCK_MONOTONIC)\n", pres_clock);
    struct wl_surface *s = wl_compositor_create_surface(comp);
    struct xdg_surface *xs = xdg_wm_base_get_xdg_surface(wm, s);
    xdg_surface_add_listener(xs, &xs_l, NULL);
    struct xdg_toplevel *tl = xdg_surface_get_toplevel(xs);
    xdg_toplevel_add_listener(tl, &tl_l, NULL);
    xdg_toplevel_set_app_id(tl, app_id);
    xdg_toplevel_set_title(tl, app_id);
    wl_surface_commit(s);
    while (!configured) if (wl_display_dispatch(dpy) < 0) return 1;
    int w = cfg_w ? cfg_w : 1280, h = cfg_h ? cfg_h : 720;
    printf("# size %dx%d\n", w, h);
    struct wl_buffer *grey = make_buffer(w, h, 0xff282828), *mag = make_buffer(w, h, 0xffff00ff);
    wl_surface_attach(s, grey, 0, 0);
    wl_surface_damage_buffer(s, 0, 0, w, h);
    wl_surface_commit(s);
    pump(dpy, 600);
    // The compositor may resize the window once it is tiled: follow it.
    if (cfg_w && cfg_h && (cfg_w != w || cfg_h != h)) {
        w = cfg_w; h = cfg_h;
        printf("# resized %dx%d\n", w, h);
        wl_buffer_destroy(grey); wl_buffer_destroy(mag);
        grey = make_buffer(w, h, 0xff282828); mag = make_buffer(w, h, 0xffff00ff);
        wl_surface_attach(s, grey, 0, 0);
        wl_surface_damage_buffer(s, 0, 0, w, h);
        wl_surface_commit(s);
        pump(dpy, 400);
    }
    srand((unsigned)mono());
    for (int i = 0; i < n && !closed; i++) {
        pump(dpy, 150 + rand() % 111);
        int m = !(i & 1);
        wl_surface_attach(s, m ? mag : grey, 0, 0);
        wl_surface_damage_buffer(s, 0, 0, w, h);
        struct wp_presentation_feedback *f = wp_presentation_feedback(pres, s);
        wp_presentation_feedback_add_listener(f, &fb_l, (void *)(intptr_t)i);
        int64_t t = mono();
        wl_surface_commit(s);
        wl_display_flush(dpy);
        printf("commit %d %s %lld\n", i, m ? "marker" : "grey", (long long)t);
        fflush(stdout);
    }
    pump(dpy, 300);
    return 0;
}
