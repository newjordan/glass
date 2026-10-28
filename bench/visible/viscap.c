// viscap: watch one region of one Wayland output, frame by frame.
//
// Uses wlr-screencopy (capture_output_region + copy) in a loop: one frame
// request is always outstanding, and as soon as a frame comes back the next
// is asked for. For every frame it writes one line:
//
//   seq ready_mono_ns recv_mono_ns r g b nmag npix
//
//   ready_mono_ns  the timestamp the compositor puts on the frame (`ready`
//                  event, CLOCK_MONOTONIC)
//   recv_mono_ns   when this client received it (CLOCK_MONOTONIC)
//   r g b          mean colour over the region (0-255)
//   nmag           pixels that are the marker colour (r>200, g<80, b>200)
//   npix           pixels in the region
//
// The first line is "# offset real_minus_mono_ns <n> output <name> ..."; add
// it to a monotonic time to get wall-clock (CLOCK_REALTIME) ns.
//
// usage: viscap OUTPUT X Y W H LOGFILE [damage]
//   region in output-local logical px; "damage" uses copy_with_damage (the
//   compositor answers only when the output changed) instead of copy.
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <time.h>
#include <unistd.h>
#include <wayland-client.h>
#include "wlr-screencopy-unstable-v1-client.h"

static struct wl_shm *shm;
static struct zwlr_screencopy_manager_v1 *scm;
static struct wl_output *outputs[16];
static char *names[16];
static int nout;
static struct wl_output *target;
static const char *want;
static int rx, ry, rw, rh;
static int logfd, with_damage;

static struct {
    uint32_t format, width, height, stride;
    int have;
    struct wl_buffer *buf;
    void *data;
    size_t size;
    uint32_t bf, bw, bh, bs; // what buf was made for
} fb;
static uint32_t yinvert;
static uint64_t seq;
static int failures;

static int64_t now(clockid_t c) {
    struct timespec ts;
    clock_gettime(c, &ts);
    return (int64_t)ts.tv_sec * 1000000000LL + ts.tv_nsec;
}

// Smallest-gap estimate of CLOCK_REALTIME - CLOCK_MONOTONIC.
static int64_t real_minus_mono(void) {
    int64_t best_gap = INT64_MAX, off = 0;
    for (int i = 0; i < 64; i++) {
        int64_t m0 = now(CLOCK_MONOTONIC), r = now(CLOCK_REALTIME), m1 = now(CLOCK_MONOTONIC);
        if (m1 - m0 < best_gap) { best_gap = m1 - m0; off = r - (m0 + (m1 - m0) / 2); }
    }
    return off;
}

static void out_geometry(void *d, struct wl_output *o, int32_t x, int32_t y, int32_t pw, int32_t ph, int32_t sp, const char *mk, const char *md, int32_t t) {}
static void out_mode(void *d, struct wl_output *o, uint32_t f, int32_t w, int32_t h, int32_t r) {}
static void out_done(void *d, struct wl_output *o) {}
static void out_scale(void *d, struct wl_output *o, int32_t s) {}
static void out_name(void *d, struct wl_output *o, const char *name) { names[(intptr_t)d] = strdup(name); }
static void out_desc(void *d, struct wl_output *o, const char *desc) {}
static const struct wl_output_listener out_l = { out_geometry, out_mode, out_done, out_scale, out_name, out_desc };

static void reg_global(void *d, struct wl_registry *r, uint32_t name, const char *iface, uint32_t ver) {
    if (!strcmp(iface, wl_shm_interface.name)) shm = wl_registry_bind(r, name, &wl_shm_interface, 1);
    else if (!strcmp(iface, zwlr_screencopy_manager_v1_interface.name))
        scm = wl_registry_bind(r, name, &zwlr_screencopy_manager_v1_interface, ver < 3 ? ver : 3);
    else if (!strcmp(iface, wl_output_interface.name) && nout < 16 && ver >= 4) {
        outputs[nout] = wl_registry_bind(r, name, &wl_output_interface, 4);
        wl_output_add_listener(outputs[nout], &out_l, (void *)(intptr_t)nout);
        nout++;
    }
}
static void reg_remove(void *d, struct wl_registry *r, uint32_t name) {}
static const struct wl_registry_listener reg_l = { reg_global, reg_remove };

static void request(void);

static void ensure_buffer(void) {
    if (fb.buf && fb.bf == fb.format && fb.bw == fb.width && fb.bh == fb.height && fb.bs == fb.stride) return;
    if (fb.buf) { wl_buffer_destroy(fb.buf); munmap(fb.data, fb.size); }
    fb.size = (size_t)fb.stride * fb.height;
    int fd = memfd_create("viscap", MFD_CLOEXEC);
    if (fd < 0 || ftruncate(fd, fb.size) < 0) { perror("memfd"); exit(1); }
    fb.data = mmap(NULL, fb.size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    struct wl_shm_pool *pool = wl_shm_create_pool(shm, fd, fb.size);
    fb.buf = wl_shm_pool_create_buffer(pool, 0, fb.width, fb.height, fb.stride, fb.format);
    wl_shm_pool_destroy(pool);
    close(fd);
    fb.bf = fb.format; fb.bw = fb.width; fb.bh = fb.height; fb.bs = fb.stride;
}

static void f_buffer(void *d, struct zwlr_screencopy_frame_v1 *f, uint32_t format, uint32_t w, uint32_t h, uint32_t stride) {
    if (fb.have) return; // the first shm offer
    fb.format = format; fb.width = w; fb.height = h; fb.stride = stride; fb.have = 1;
}
static void do_copy(struct zwlr_screencopy_frame_v1 *f) {
    ensure_buffer();
    if (with_damage) zwlr_screencopy_frame_v1_copy_with_damage(f, fb.buf);
    else zwlr_screencopy_frame_v1_copy(f, fb.buf);
}
static void f_flags(void *d, struct zwlr_screencopy_frame_v1 *f, uint32_t flags) { yinvert = flags & 1; }

static void pixel(const uint8_t *p, int *r, int *g, int *b) {
    uint32_t v;
    memcpy(&v, p, 4);
    switch (fb.format) {
    case WL_SHM_FORMAT_ARGB8888: case WL_SHM_FORMAT_XRGB8888:
        *r = (v >> 16) & 255; *g = (v >> 8) & 255; *b = v & 255; break;
    case WL_SHM_FORMAT_ABGR8888: case WL_SHM_FORMAT_XBGR8888:
        *r = v & 255; *g = (v >> 8) & 255; *b = (v >> 16) & 255; break;
    case WL_SHM_FORMAT_XRGB2101010: case WL_SHM_FORMAT_ARGB2101010:
        *r = ((v >> 20) & 1023) >> 2; *g = ((v >> 10) & 1023) >> 2; *b = (v & 1023) >> 2; break;
    case WL_SHM_FORMAT_XBGR2101010: case WL_SHM_FORMAT_ABGR2101010:
        *r = (v & 1023) >> 2; *g = ((v >> 10) & 1023) >> 2; *b = ((v >> 20) & 1023) >> 2; break;
    default: *r = *g = *b = -1;
    }
}

static void f_ready(void *d, struct zwlr_screencopy_frame_v1 *f, uint32_t hi, uint32_t lo, uint32_t ns) {
    int64_t recv = now(CLOCK_MONOTONIC);
    int64_t ready = (int64_t)((((uint64_t)hi) << 32) | lo) * 1000000000LL + ns;
    long sr = 0, sg = 0, sb = 0, nmag = 0, n = 0;
    for (uint32_t y = 0; y < fb.height; y++) {
        const uint8_t *row = (const uint8_t *)fb.data + (size_t)y * fb.stride;
        for (uint32_t x = 0; x < fb.width; x++) {
            int r, g, b;
            pixel(row + 4 * x, &r, &g, &b);
            sr += r; sg += g; sb += b; n++;
            if (r > 200 && g < 80 && b > 200) nmag++;
        }
    }
    char line[200];
    int len;
    if (seq == 0) {
        len = snprintf(line, sizeof line, "# format 0x%08x %ux%u stride %u y_invert %u\n", fb.format, fb.width, fb.height, fb.stride, yinvert);
        if (write(logfd, line, len) < 0) exit(1);
    }
    len = snprintf(line, sizeof line, "%llu %lld %lld %ld %ld %ld %ld %ld\n", (unsigned long long)seq++,
                       (long long)ready, (long long)recv, n ? sr / n : 0, n ? sg / n : 0, n ? sb / n : 0, nmag, n);
    if (write(logfd, line, len) < 0) exit(1);
    zwlr_screencopy_frame_v1_destroy(f);
    request();
}
static void f_failed(void *d, struct zwlr_screencopy_frame_v1 *f) {
    zwlr_screencopy_frame_v1_destroy(f);
    if (++failures > 1000) { fprintf(stderr, "viscap: too many failed frames\n"); exit(1); }
    char line[64];
    int len = snprintf(line, sizeof line, "# failed %lld\n", (long long)now(CLOCK_MONOTONIC));
    if (write(logfd, line, len) < 0) exit(1);
    request();
}
static void f_damage(void *d, struct zwlr_screencopy_frame_v1 *f, uint32_t x, uint32_t y, uint32_t w, uint32_t h) {}
static void f_dmabuf(void *d, struct zwlr_screencopy_frame_v1 *f, uint32_t fmt, uint32_t w, uint32_t h) {}
static void f_buffer_done(void *d, struct zwlr_screencopy_frame_v1 *f) { do_copy(f); }
static const struct zwlr_screencopy_frame_v1_listener frame_l = { f_buffer, f_flags, f_ready, f_failed, f_damage, f_dmabuf, f_buffer_done };

static void request(void) {
    fb.have = 0;
    struct zwlr_screencopy_frame_v1 *f = zwlr_screencopy_manager_v1_capture_output_region(scm, 0, target, rx, ry, rw, rh);
    zwlr_screencopy_frame_v1_add_listener(f, &frame_l, NULL);
}

int main(int argc, char **argv) {
    if (argc != 7 && argc != 8) { fprintf(stderr, "usage: viscap OUTPUT X Y W H LOGFILE [damage]\n"); return 2; }
    with_damage = argc == 8 && !strcmp(argv[7], "damage");
    want = argv[1]; rx = atoi(argv[2]); ry = atoi(argv[3]); rw = atoi(argv[4]); rh = atoi(argv[5]);
    logfd = open(argv[6], O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0644);
    if (logfd < 0) { perror(argv[6]); return 1; }
    struct wl_display *dpy = wl_display_connect(NULL);
    if (!dpy) { fprintf(stderr, "viscap: no Wayland display\n"); return 1; }
    struct wl_registry *reg = wl_display_get_registry(dpy);
    wl_registry_add_listener(reg, &reg_l, NULL);
    wl_display_roundtrip(dpy);
    wl_display_roundtrip(dpy);
    if (!shm || !scm) { fprintf(stderr, "viscap: compositor lacks wl_shm or wlr-screencopy v3\n"); return 1; }
    if (zwlr_screencopy_manager_v1_get_version(scm) < 3) { fprintf(stderr, "viscap: need screencopy v3\n"); return 1; }
    for (int i = 0; i < nout; i++) if (names[i] && !strcmp(names[i], want)) target = outputs[i];
    if (!target) { fprintf(stderr, "viscap: no output named %s\n", want); return 1; }
    char line[200];
    int len = snprintf(line, sizeof line, "# offset real_minus_mono_ns %lld output %s region %d,%d %dx%d\n",
                       (long long)real_minus_mono(), want, rx, ry, rw, rh);
    if (write(logfd, line, len) < 0) return 1;
    request();
    while (wl_display_dispatch(dpy) != -1) {}
    fprintf(stderr, "viscap: display connection closed\n");
    return 1;
}
