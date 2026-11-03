/* Own-thread Linux scheduler accounting. Diagnostic only, no global changes.
 * schedstat's run_delay comes from sched_info, not the schedstats static key.
 * A snapshot runs on the measured thread (no uncompleted runqueue wait from a
 * remotely sleeping/runnable target). Clocks bracket proc read/parse overhead.
 * A preemption during that bracket remains explicit measurement uncertainty.
 */
#ifndef GLASS_SCHED_SNAPSHOT_H
#define GLASS_SCHED_SNAPSHOT_H
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

struct sched_snapshot {
    uint64_t wall_before, cpu_before, runtime, runqueue, timeslices;
    uint64_t cpu_after, wall_after;
};

static void sched_fail(const char *message) {
    dprintf(2, "sched-snapshot: %s\n", message);
    _exit(125);
}

static uint64_t sched_now(clockid_t clock) {
    struct timespec ts;
    if (clock_gettime(clock, &ts)) sched_fail("clock_gettime");
    return (uint64_t)ts.tv_sec * 1000000000ULL + (uint64_t)ts.tv_nsec;
}

static struct sched_snapshot sched_take(int fd) {
    struct sched_snapshot s = {0};
    s.wall_before = sched_now(CLOCK_MONOTONIC);
    s.cpu_before = sched_now(CLOCK_THREAD_CPUTIME_ID);
    if (fd >= 0) {
        char text[192];
        ssize_t n;
        do { n = pread(fd, text, sizeof(text) - 1, 0); } while (n < 0 && errno == EINTR);
        if (n <= 0 || n == sizeof(text) - 1) sched_fail("schedstat read/truncation");
        text[n] = 0;
        unsigned long long runtime, runqueue, timeslices;
        int used = 0;
        if (sscanf(text, "%llu %llu %llu %n", &runtime, &runqueue, &timeslices, &used) != 3 || text[used])
            sched_fail("schedstat format");
        s.runtime = runtime;
        s.runqueue = runqueue;
        s.timeslices = timeslices;
    }
    s.cpu_after = sched_now(CLOCK_THREAD_CPUTIME_ID);
    s.wall_after = sched_now(CLOCK_MONOTONIC);
    return s;
}
#endif
