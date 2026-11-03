/* Linux/x86-64 diagnostic for our own process, NOT a release component.
 * LD_PRELOAD this DSO; GLASS_SAMPLE_THREAD=pty-parse (or pty-read),
 * GLASS_SAMPLE_OUT=/absolute/new-file, GLASS_SAMPLE_US=100 (CPU microseconds).
 * A thread CPU-time timer interrupts only the named current thread, recording
 * its userspace RIP into fixed storage. No allocation/stdio in the handler.
 * Timer delivery samples execution, not off-CPU stacks or kernel call chains.
 * Profiling has overhead; never use these sessions as default scores.
 */
#define _GNU_SOURCE
#include <dlfcn.h>
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <pthread.h>
#include <poll.h>
#include <signal.h>
#include <stdint.h>
#include <stdatomic.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <time.h>
#include <ucontext.h>
#include <unistd.h>

#define CAPACITY (1u << 20)
_Static_assert(ATOMIC_INT_LOCK_FREE == 2 && ATOMIC_LONG_LOCK_FREE == 2, "handler requires lock-free atomics");
static _Atomic uintptr_t pcs[CAPACITY];
static _Atomic unsigned long stamps[CAPACITY];
static _Atomic unsigned call_labels[CAPACITY];
static _Atomic unsigned long overruns;
static __thread volatile sig_atomic_t active_call __attribute__((tls_model("initial-exec")));
static __thread int sample_this __attribute__((tls_model("initial-exec")));
static ssize_t (*real_read)(int, void *, size_t);
static int (*real_poll)(struct pollfd *, nfds_t, int);
static _Atomic unsigned count, dropped;
static timer_t timer_id;
static _Atomic int armed;
static int output_fd = -1, sample_signal, sample_us = 100;
static pid_t target_tid;
static const char *wanted;

static void sample(int signal, siginfo_t *info, void *context) {
    (void)signal;
    if (info->si_code != SI_TIMER || info->si_value.sival_ptr != &timer_id)
        return;
    atomic_fetch_add_explicit(&overruns, (unsigned long)info->si_overrun, memory_order_relaxed);
    ucontext_t *uc = context;
    unsigned at = atomic_load_explicit(&count, memory_order_relaxed);
    if (at < CAPACITY) {
        struct timespec now;
        clock_gettime(CLOCK_MONOTONIC, &now);
        atomic_store_explicit(&pcs[at], (uintptr_t)uc->uc_mcontext.gregs[REG_RIP], memory_order_relaxed);
        atomic_store_explicit(&stamps[at], (unsigned long)now.tv_sec * 1000000000UL + now.tv_nsec, memory_order_relaxed);
        atomic_store_explicit(&call_labels[at], (unsigned)active_call, memory_order_relaxed);
        atomic_store_explicit(&count, at + 1, memory_order_release);
    } else if (atomic_load_explicit(&dropped, memory_order_relaxed) < INT_MAX) {
        atomic_fetch_add_explicit(&dropped, 1, memory_order_relaxed);
    }
}

__attribute__((constructor)) static void init(void) {
    *(void **)(&real_read) = dlsym(RTLD_NEXT, "read");
    *(void **)(&real_poll) = dlsym(RTLD_NEXT, "poll");
    if (!real_read || !real_poll) _exit(125);
    wanted = getenv("GLASS_SAMPLE_THREAD");
    const char *out = getenv("GLASS_SAMPLE_OUT");
    const char *period = getenv("GLASS_SAMPLE_US");
    if (!wanted || !out)
        return;
    const char *only_exe = getenv("GLASS_SAMPLE_EXE");
    char executable[PATH_MAX];
    ssize_t n = readlink("/proc/self/exe", executable, sizeof(executable) - 1);
    if (!only_exe || n < 0) return;
    executable[n] = 0;
    if (strcmp(executable, only_exe)) return;
    if (period) {
        char *end;
        long parsed = strtol(period, &end, 10);
        if (*end || parsed < 50 || parsed > 100000) {
            dprintf(2, "cpu-sample: invalid period\n");
            _exit(125);
        }
        sample_us = (int)parsed;
    }
    output_fd = open(out, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0600);
    if (output_fd < 0) {
        dprintf(2, "cpu-sample: cannot create output: %s\n", strerror(errno));
        _exit(125);
    }
    /* Reserve an otherwise-unused realtime signal. Refuse an existing handler;
     * this is opt-in diagnostic code, never silently replace application state. */
    sample_signal = SIGRTMIN + 6;
    struct sigaction previous, action = {0};
    if (sigaction(sample_signal, NULL, &previous) || previous.sa_handler != SIG_DFL) {
        dprintf(2, "cpu-sample: signal already in use\n");
        _exit(125);
    }
    sigemptyset(&action.sa_mask);
    action.sa_sigaction = sample;
    action.sa_flags = SA_SIGINFO | SA_RESTART;
    if (sigaction(sample_signal, &action, NULL)) {
        dprintf(2, "cpu-sample: sigaction failed\n");
        _exit(125);
    }
}

/* Label only this diagnostic target; preserve return values and errno. Signal
 * handlers read initial-exec TLS directly (no dynamic TLS helper/allocations).
 * Calls interrupted in glibc's shared cancel stub keep their outer label. */
ssize_t read(int fd, void *buf, size_t len) {
    if (!real_read) return syscall(SYS_read, fd, buf, len);
    if (!sample_this) return real_read(fd, buf, len);
    sig_atomic_t previous = active_call;
    active_call = 1;
    ssize_t result = real_read(fd, buf, len);
    active_call = previous;
    return result;
}

int poll(struct pollfd *fds, nfds_t count, int timeout) {
    if (!real_poll) return (int)syscall(SYS_poll, fds, count, timeout);
    if (!sample_this) return real_poll(fds, count, timeout);
    sig_atomic_t previous = active_call;
    active_call = 2;
    int result = real_poll(fds, count, timeout);
    active_call = previous;
    return result;
}

int pthread_setname_np(pthread_t thread, const char *name) {
    int (*real_setname)(pthread_t, const char *) = dlsym(RTLD_NEXT, "pthread_setname_np");
    if (!real_setname)
        return ENOSYS;
    int result = real_setname(thread, name);
    if (result || output_fd < 0 || !wanted || strcmp(name, wanted) ||
        !pthread_equal(thread, pthread_self()))
        return result;
    /* Only the selected current thread writes/arms the sampler. Glass has one
     * parser and one reader. Treat a second matching name as an error. */
    if (atomic_load_explicit(&armed, memory_order_acquire)) {
        dprintf(2, "cpu-sample: duplicate target\n");
        _exit(125);
    }
    clockid_t clock_id;
    struct sigevent event = {0};
    sample_this = 1;
    target_tid = (pid_t)syscall(SYS_gettid);
    event.sigev_notify = SIGEV_THREAD_ID;
    event.sigev_signo = sample_signal;
    event.sigev_value.sival_ptr = &timer_id;
    event._sigev_un._tid = target_tid;
    struct itimerspec period = {0};
    period.it_value.tv_sec = period.it_interval.tv_sec = sample_us / 1000000;
    period.it_value.tv_nsec = period.it_interval.tv_nsec = (sample_us % 1000000) * 1000L;
    if (pthread_getcpuclockid(thread, &clock_id) || timer_create(clock_id, &event, &timer_id) ||
        timer_settime(timer_id, 0, &period, NULL)) {
        dprintf(2, "cpu-sample: timer setup failed: %s\n", strerror(errno));
        _exit(125);
    }
    atomic_store_explicit(&armed, 1, memory_order_release);
    return result;
}

__attribute__((destructor)) static void finish(void) {
    if (output_fd < 0)
        return;
    int was_armed = atomic_load_explicit(&armed, memory_order_acquire);
    if (was_armed)
        timer_delete(timer_id);
    /* The handler publishes count after both lock-free stores. A late signal
     * may append, never mutate a slot below this acquire snapshot. */
    unsigned n = atomic_load_explicit(&count, memory_order_acquire);
    dprintf(output_fd, "cpu-sample-v2 tid=%d period_us=%d samples=%u dropped=%u armed=%d overruns=%lu\n",
            target_tid, sample_us, n, atomic_load(&dropped), was_armed, atomic_load(&overruns));
    /* Maps enable PIE/load-offset symbolization; record only mappings, not
     * environment, command lines or arbitrary process memory. */
    int maps = open("/proc/self/maps", O_RDONLY | O_CLOEXEC);
    if (maps >= 0) {
        char buf[4096];
        ssize_t got;
        dprintf(output_fd, "MAPS\n");
        while ((got = read(maps, buf, sizeof(buf))) > 0) {
            ssize_t at = 0;
            while (at < got) {
                ssize_t sent = write(output_fd, buf + at, (size_t)(got - at));
                if (sent < 0 && errno == EINTR) continue;
                if (sent <= 0) break;
                at += sent;
            }
        }
        close(maps);
    }
    dprintf(output_fd, "PCS\n");
    for (unsigned i = 0; i < n; i++)
        dprintf(output_fd, "%lx %lu %u\n", (unsigned long)atomic_load_explicit(&pcs[i], memory_order_relaxed),
                atomic_load_explicit(&stamps[i], memory_order_relaxed),
                atomic_load_explicit(&call_labels[i], memory_order_relaxed));
    close(output_fd);
}
