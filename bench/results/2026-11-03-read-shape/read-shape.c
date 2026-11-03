/* Opt-in diagnostic for the named reader of our own exact Linux executable.
 * No application buffers, paths, descriptors, pointers or unrelated calls are
 * recorded. This is an LD_PRELOAD observer, NOT a runtime optimization.
 * COUNT: one exit monotonic clock + result/size; TIMED adds entry wall and two
 * thread-CPU clocks. Both perturb the target; measure their overhead separately.
 */
#define _GNU_SOURCE
#include <dlfcn.h>
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <pthread.h>
#include <poll.h>
#include <stdatomic.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <time.h>
#include <unistd.h>

#define CAPACITY (1u << 20)
/* Little-endian Linux x86-64 format, checked by the independent decoder. */
struct event {
    uint64_t end_ns, begin_ns, cpu_ns, requested;
    int64_t result;
    uint32_t kind, error, flags, reserved;
};
struct header {
    char magic[8];
    uint32_t version, record_size, count, dropped, mode, tid, capacity, reserved;
};
_Static_assert(sizeof(struct event) == 56 && sizeof(struct header) == 40, "trace ABI");
static struct event events[CAPACITY];
static _Atomic unsigned count, dropped, armed;
static __thread int target __attribute__((tls_model("initial-exec")));
static ssize_t (*real_read)(int, void *, size_t);
static int (*real_poll)(struct pollfd *, nfds_t, int);
static int (*real_setname)(pthread_t, const char *);
static int output_fd = -1, timed;
static uint32_t target_tid;

static void fail(const char *message) {
    dprintf(2, "read-shape: %s\n", message);
    _exit(125);
}

static uint64_t now(clockid_t clock) {
    struct timespec ts;
    if (clock_gettime(clock, &ts)) fail("clock_gettime failed");
    return (uint64_t)ts.tv_sec * 1000000000ULL + (uint64_t)ts.tv_nsec;
}

__attribute__((constructor)) static void init(void) {
    *(void **)(&real_read) = dlsym(RTLD_NEXT, "read");
    *(void **)(&real_poll) = dlsym(RTLD_NEXT, "poll");
    *(void **)(&real_setname) = dlsym(RTLD_NEXT, "pthread_setname_np");
    if (!real_read || !real_poll || !real_setname) fail("dlsym failed");
    const char *exe = getenv("GLASS_READ_SHAPE_EXE");
    const char *out = getenv("GLASS_READ_SHAPE_OUT");
    const char *mode = getenv("GLASS_READ_SHAPE_MODE");
    if (!exe || !out || !mode) return;
    char path[PATH_MAX];
    ssize_t n = readlink("/proc/self/exe", path, sizeof(path) - 1);
    if (n < 0 || n == (ssize_t)sizeof(path) - 1) fail("readlink failed/truncated");
    path[n] = 0;
    if (strcmp(path, exe)) return; /* Inherited child preload is inactive. */
    if (!strcmp(mode, "count")) timed = 0;
    else if (!strcmp(mode, "timed")) timed = 1;
    else fail("mode must be count or timed");
    output_fd = open(out, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0600);
    if (output_fd < 0) fail("cannot exclusively create output");
}

int pthread_setname_np(pthread_t thread, const char *name) {
    if (!real_setname) return ENOSYS;
    int result = real_setname(thread, name);
    if (result || output_fd < 0 || strcmp(name, "pty-read") ||
        !pthread_equal(thread, pthread_self())) return result;
    if (atomic_exchange_explicit(&armed, 1, memory_order_acq_rel))
        fail("duplicate reader target");
    target_tid = (uint32_t)syscall(SYS_gettid);
    target = 1;
    return result;
}

static void record(uint32_t kind, uint64_t begin, uint64_t cpu_begin,
                   uint64_t requested, int64_t result, int error, uint32_t flags) {
    uint64_t cpu = timed ? now(CLOCK_THREAD_CPUTIME_ID) - cpu_begin : 0;
    uint64_t end = now(CLOCK_MONOTONIC);
    unsigned at = atomic_load_explicit(&count, memory_order_relaxed);
    if (at == CAPACITY) {
        atomic_fetch_add_explicit(&dropped, 1, memory_order_relaxed);
        return;
    }
    events[at] = (struct event){end, begin, cpu, requested, result, kind,
                               result < 0 ? (uint32_t)error : 0, flags, 0};
    /* A late append cannot alter any slot below the destructor's snapshot. */
    atomic_store_explicit(&count, at + 1, memory_order_release);
}

ssize_t read(int fd, void *buf, size_t len) {
    if (!real_read) return syscall(SYS_read, fd, buf, len);
    if (!target) return real_read(fd, buf, len);
    int saved = errno;
    uint64_t begin = timed ? now(CLOCK_MONOTONIC) : 0;
    uint64_t cpu = timed ? now(CLOCK_THREAD_CPUTIME_ID) : 0;
    errno = saved;
    ssize_t result = real_read(fd, buf, len);
    saved = errno;
    record(1, begin, cpu, len, result, saved, 0);
    errno = saved;
    return result;
}

int poll(struct pollfd *fds, nfds_t n, int timeout) {
    if (!real_poll) return (int)syscall(SYS_poll, fds, n, timeout);
    if (!target) return real_poll(fds, n, timeout);
    int saved = errno;
    uint64_t begin = timed ? now(CLOCK_MONOTONIC) : 0;
    uint64_t cpu = timed ? now(CLOCK_THREAD_CPUTIME_ID) : 0;
    errno = saved;
    int result = real_poll(fds, n, timeout);
    saved = errno;
    /* We only inspect pollfd when libc says at least one descriptor is ready.
     * flags: low 16 bits first revents, high bit says n==1. requested preserves
     * the signed timeout's 32-bit representation. No descriptor is recorded. */
    uint32_t flags = n == 1 ? 0x80000000u : 0;
    if (result > 0 && n == 1) flags |= (uint16_t)fds[0].revents;
    record(2, begin, cpu, (uint32_t)timeout, result, saved, flags);
    errno = saved;
    return result;
}

static void write_all(const void *buffer, size_t size) {
    const char *p = buffer;
    while (size) {
        ssize_t n = write(output_fd, p, size);
        if (n < 0 && errno == EINTR) continue;
        if (n <= 0) fail("trace write failed");
        p += n;
        size -= (size_t)n;
    }
}

__attribute__((destructor)) static void finish(void) {
    if (output_fd < 0) return;
    if (!atomic_load_explicit(&armed, memory_order_acquire)) fail("reader not armed");
    unsigned n = atomic_load_explicit(&count, memory_order_acquire);
    struct header h = {{'R','D','S','H','A','P','E','1'}, 1, sizeof(struct event), n,
                       atomic_load_explicit(&dropped, memory_order_relaxed),
                       (uint32_t)timed, target_tid, CAPACITY, 0};
    write_all(&h, sizeof(h));
    write_all(events, (size_t)n * sizeof(events[0]));
    if (close(output_fd)) fail("trace close failed");
}
