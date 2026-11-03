/* Own-child bounded CPU contention; parent pipe EOF always ends the helper.
 * No other processes, priority, global policy, or counters are modified. */
#define _GNU_SOURCE
#include <errno.h>
#include <poll.h>
#include <sched.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

static uint64_t now(clockid_t clock) {
    struct timespec ts;
    if (clock_gettime(clock, &ts)) { perror("clock_gettime"); exit(125); }
    return (uint64_t)ts.tv_sec * 1000000000ULL + (uint64_t)ts.tv_nsec;
}
int main(int argc, char **argv) {
    if (argc != 3 || (strcmp(argv[1], "sleep") && strcmp(argv[1], "busy"))) return 2;
    char *end;
    long cpu = strtol(argv[2], &end, 10);
    if (!*argv[2] || *end || cpu < 0 || cpu >= CPU_SETSIZE) return 2;
    cpu_set_t allowed, one;
    if (sched_getaffinity(0, sizeof(allowed), &allowed) || !CPU_ISSET(cpu, &allowed)) return 125;
    CPU_ZERO(&one); CPU_SET(cpu, &one);
    if (sched_setaffinity(0, sizeof(one), &one)) { perror("setaffinity"); return 125; }
    uint64_t wall = now(CLOCK_MONOTONIC), thread = now(CLOCK_THREAD_CPUTIME_ID);
    printf("{\"pid\":%ld,\"cpu\":%ld,\"mode\":\"%s\",\"ready\":true}\n", (long)getpid(), cpu, argv[1]);
    fflush(stdout);
    struct pollfd input = {STDIN_FILENO, POLLIN | POLLHUP, 0};
    volatile uint64_t work = 1;
    for (;;) {
        int ready = poll(&input, 1, !strcmp(argv[1], "busy") ? 0 : -1);
        if (ready < 0) { if (errno == EINTR) continue; perror("poll"); return 125; }
        if (ready) {
            if (input.revents & (POLLERR | POLLNVAL)) return 125;
            if (input.revents & (POLLIN | POLLHUP)) {
                char c;
                ssize_t n = read(STDIN_FILENO, &c, 1);
                if (n < 0 && errno == EINTR) continue;
                if (n != 0) return 125; /* Parent must send EOF, not commands. */
                break;
            }
        }
        for (unsigned i = 0; i < 4096; ++i) work = work * 1664525 + 1013904223;
    }
    printf("{\"complete\":true,\"wall_ns\":%llu,\"cpu_ns\":%llu}\n",
           (unsigned long long)(now(CLOCK_MONOTONIC)-wall),
           (unsigned long long)(now(CLOCK_THREAD_CPUTIME_ID)-thread));
    return fflush(stdout) ? 125 : 0;
}
