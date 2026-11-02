/* Minimal Linux read/discard control, NOT a terminal or throughput competitor.
 * The ready handshake and final timestamp are outside the measured data path.
 * Read until the exact expected count; short input and read errors fail closed.
 */
#define _GNU_SOURCE
#include <errno.h>
#include <inttypes.h>
#include <sched.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/resource.h>
#include <time.h>
#include <unistd.h>

static uint64_t now_ns(void) {
    struct timespec t;
    if (clock_gettime(CLOCK_MONOTONIC, &t)) { perror("clock_gettime"); exit(1); }
    return (uint64_t)t.tv_sec * 1000000000 + t.tv_nsec;
}

static void schedstat(uint64_t *run, uint64_t *wait, uint64_t *slices) {
    FILE *f = fopen("/proc/self/schedstat", "r");
    if (!f || fscanf(f, "%" SCNu64 " %" SCNu64 " %" SCNu64, run, wait, slices) != 3) {
        fputs("cannot read schedstat\n", stderr); exit(1);
    }
    fclose(f);
}

int main(int argc, char **argv) {
    if (argc < 4) { fputs("sink FD EXPECTED CPU...\n", stderr); return 2; }
    char *end;
    long fd = strtol(argv[1], &end, 10);
    if (*end || fd < 0) return 2;
    uint64_t expected = strtoull(argv[2], &end, 10);
    if (*end || !expected) return 2;
    cpu_set_t mask;
    CPU_ZERO(&mask);
    for (int i = 3; i < argc; i++) {
        long cpu = strtol(argv[i], &end, 10);
        if (*end || cpu < 0 || cpu >= CPU_SETSIZE) return 2;
        CPU_SET(cpu, &mask);
    }
    if (sched_setaffinity(0, sizeof(mask), &mask)) { perror("sched_setaffinity"); return 1; }
    struct rusage before, after;
    uint64_t r0, w0, s0, r1, w1, s1;
    schedstat(&r0, &w0, &s0);
    if (getrusage(RUSAGE_SELF, &before)) return 1;
    puts("READY"); fflush(stdout);
    uint64_t count = 0, calls = 0;
    char buffer[65536];
    while (count < expected) {
        size_t want = expected - count < sizeof(buffer) ? (size_t)(expected - count) : sizeof(buffer);
        ssize_t n = read((int)fd, buffer, want);
        if (n < 0 && errno == EINTR) continue;
        if (n <= 0) { fprintf(stderr, "short/error read at %" PRIu64 ": %d\n", count, errno); return 1; }
        count += (uint64_t)n;
        calls++;
    }
    uint64_t done = now_ns();
    if (getrusage(RUSAGE_SELF, &after)) return 1;
    schedstat(&r1, &w1, &s1);
    int64_t user = (after.ru_utime.tv_sec-before.ru_utime.tv_sec)*1000000LL + after.ru_utime.tv_usec-before.ru_utime.tv_usec;
    int64_t system = (after.ru_stime.tv_sec-before.ru_stime.tv_sec)*1000000LL + after.ru_stime.tv_usec-before.ru_stime.tv_usec;
    printf("{\"bytes\":%" PRIu64 ",\"read_calls\":%" PRIu64 ",\"done_ns\":%" PRIu64
           ",\"runtime_ns\":%" PRIu64 ",\"runqueue_ns\":%" PRIu64 ",\"timeslices\":%" PRIu64
           ",\"user_us\":%" PRId64 ",\"system_us\":%" PRId64 ",\"voluntary\":%ld,\"involuntary\":%ld}\n",
           count, calls, done, r1-r0, w1-w0, s1-s0, user, system,
           after.ru_nvcsw-before.ru_nvcsw, after.ru_nivcsw-before.ru_nivcsw);
    return 0;
}
