/* Sparse own-reader scheduler diagnostic; LD_PRELOAD for our exact executable.
 * A window spans 128 completed read calls INCLUDING intervening ioctls, polls,
 * channel waits and scheduler time. It is NOT a per-syscall kernel profile.
 * The clock arm has identical clocks/records but omits the two proc reads.
 * No payload bytes, pointers, descriptor numbers or unrelated tasks are saved.
 */
#define _GNU_SOURCE
#include "sched-snapshot.h"
#include <dlfcn.h>
#include <limits.h>
#include <pthread.h>
#include <stdatomic.h>
#include <string.h>
#include <sys/syscall.h>

#define CAPACITY (1u << 16)
#define STRIDE 128u
struct window {
    struct sched_snapshot before, after;
    uint64_t bytes, reads;
};
struct header {
    char magic[8];
    uint32_t version, size, count, dropped, mode, tid, capacity, stride;
};
_Static_assert(sizeof(struct window) == 128 && sizeof(struct header) == 40, "trace ABI");
static struct window windows[CAPACITY];
static _Atomic unsigned count, dropped, armed;
static __thread int target __attribute__((tls_model("initial-exec")));
static __thread int have_before __attribute__((tls_model("initial-exec")));
static struct sched_snapshot before;
static uint64_t bytes, reads;
static _Atomic uint32_t target_tid;
static ssize_t (*real_read)(int, void *, size_t);
static int (*real_setname)(pthread_t, const char *);
static int output_fd = -1, sched_fd = -1, mode;

__attribute__((constructor)) static void init(void) {
    *(void **)(&real_read) = dlsym(RTLD_NEXT, "read");
    *(void **)(&real_setname) = dlsym(RTLD_NEXT, "pthread_setname_np");
    if (!real_read || !real_setname) sched_fail("dlsym");
    const char *exe = getenv("GLASS_SCHED_EXE");
    const char *out = getenv("GLASS_SCHED_OUT");
    const char *setting = getenv("GLASS_SCHED_MODE");
    if (!exe || !out || !setting) return;
    char path[PATH_MAX];
    ssize_t n = readlink("/proc/self/exe", path, sizeof(path) - 1);
    if (n < 0 || n == sizeof(path) - 1) sched_fail("readlink");
    path[n] = 0;
    if (strcmp(path, exe)) return;
    if (!strcmp(setting, "clock")) mode = 0;
    else if (!strcmp(setting, "sched")) mode = 1;
    else sched_fail("unknown mode");
    output_fd = open(out, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0600);
    if (output_fd < 0) sched_fail("exclusive output");
}

int pthread_setname_np(pthread_t thread, const char *name) {
    if (!real_setname) return ENOSYS;
    int result = real_setname(thread, name);
    if (result || output_fd < 0 || strcmp(name, "pty-read") ||
        !pthread_equal(thread, pthread_self())) return result;
    if (atomic_exchange_explicit(&armed, 1, memory_order_acq_rel)) sched_fail("duplicate reader");
    target_tid = (uint32_t)syscall(SYS_gettid);
    if (mode) {
        /* /proc/thread-self resolves in the measured thread, not constructor. */
        sched_fd = open("/proc/thread-self/schedstat", O_RDONLY | O_CLOEXEC);
        if (sched_fd < 0) sched_fail("open reader schedstat");
    }
    target = 1;
    return result;
}

ssize_t read(int fd, void *buf, size_t len) {
    if (!real_read) return syscall(SYS_read, fd, buf, len);
    if (!target) return real_read(fd, buf, len);
    int saved = errno;
    if (!have_before) { before = sched_take(sched_fd); have_before = 1; }
    errno = saved;
    ssize_t result = real_read(fd, buf, len);
    saved = errno;
    if (result > 0) bytes += (uint64_t)result;
    if (++reads == STRIDE) {
        struct sched_snapshot after = sched_take(sched_fd);
        unsigned at = atomic_load_explicit(&count, memory_order_relaxed);
        if (at == CAPACITY) atomic_fetch_add_explicit(&dropped, 1, memory_order_relaxed);
        else {
            windows[at] = (struct window){before, after, bytes, reads};
            atomic_store_explicit(&count, at + 1, memory_order_release);
        }
        before = after;
        bytes = reads = 0;
    }
    errno = saved;
    return result;
}

static void write_all(const void *buffer, size_t size) {
    const char *p = buffer;
    while (size) {
        ssize_t n = write(output_fd, p, size);
        if (n < 0 && errno == EINTR) continue;
        if (n <= 0) sched_fail("write trace");
        p += n; size -= (size_t)n;
    }
}
__attribute__((destructor)) static void finish(void) {
    if (output_fd < 0) return;
    if (!atomic_load_explicit(&armed, memory_order_acquire)) sched_fail("reader not armed");
    unsigned n = atomic_load_explicit(&count, memory_order_acquire);
    if (!n) sched_fail("no complete reader windows");
    struct header h = {{'R','D','S','C','H','E','D','1'}, 1, sizeof(struct window), n,
        atomic_load_explicit(&dropped, memory_order_relaxed), (uint32_t)mode, atomic_load_explicit(&target_tid, memory_order_relaxed), CAPACITY, STRIDE};
    write_all(&h, sizeof(h));
    write_all(windows, (size_t)n * sizeof(windows[0]));
    if (close(output_fd)) sched_fail("close trace");
    /* Only fully published windows are dumped; unfinished tail is not claimed. */
}
