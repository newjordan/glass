/* Validate sched_info run-delay on this host without changing sysctls or
 * attaching to unrelated processes. Pin only this process and its own child.
 * Sleep: off-CPU with little runnable wait. Contend: known runnable competition.
 * Each independent trial records both bracketed own-thread snapshots as JSONL.
 */
#define _GNU_SOURCE
#include "sched-snapshot.h"
#include <sched.h>
#include <signal.h>
#include <string.h>
#include <sys/wait.h>

static volatile uint64_t work;
static void busy(uint64_t ns) {
    uint64_t end = sched_now(CLOCK_MONOTONIC) + ns;
    do {
        for (unsigned i = 0; i < 1024; ++i) work = work * 1664525 + 1013904223;
    } while (sched_now(CLOCK_MONOTONIC) < end);
}
static void emit(const struct sched_snapshot *s) {
    printf("[%llu,%llu,%llu,%llu,%llu,%llu,%llu]",
           (unsigned long long)s->wall_before, (unsigned long long)s->cpu_before,
           (unsigned long long)s->runtime, (unsigned long long)s->runqueue,
           (unsigned long long)s->timeslices, (unsigned long long)s->cpu_after,
           (unsigned long long)s->wall_after);
}
int main(void) {
    cpu_set_t allowed, one;
    if (sched_getaffinity(0, sizeof(allowed), &allowed)) sched_fail("getaffinity");
    int cpu = -1;
    for (int i = 0; i < CPU_SETSIZE; ++i) if (CPU_ISSET(i, &allowed)) { cpu = i; break; }
    if (cpu < 0) sched_fail("no CPU");
    CPU_ZERO(&one); CPU_SET(cpu, &one);
    if (sched_setaffinity(0, sizeof(one), &one)) sched_fail("setaffinity");
    int fd = open("/proc/thread-self/schedstat", O_RDONLY | O_CLOEXEC);
    if (fd < 0) sched_fail("open schedstat");
    static const int orders[6][3] = {{0,1,2},{0,2,1},{1,0,2},{1,2,0},{2,0,1},{2,1,0}};
    static const char *names[] = {"busy", "sleep", "contend"};
    for (int round = 0; round < 12; ++round) for (int at = 0; at < 3; ++at) {
        int mode = orders[round % 6][at];
        pid_t child = -1;
        if (mode == 2) {
            int ready[2];
            if (pipe(ready)) sched_fail("pipe");
            child = fork();
            if (child < 0) sched_fail("fork");
            if (!child) {
                close(ready[0]); close(fd);
                if (write(ready[1], "R", 1) != 1) sched_fail("ready write");
                close(ready[1]);
                for (;;) busy(100000000ULL);
            }
            close(ready[1]);
            char c;
            if (read(ready[0], &c, 1) != 1 || c != 'R') sched_fail("ready read");
            close(ready[0]);
        }
        struct sched_snapshot before = sched_take(fd);
        if (mode == 1) {
            struct timespec delay = {0, 80000000};
            while (nanosleep(&delay, &delay)) if (errno != EINTR) sched_fail("nanosleep");
        } else busy(80000000ULL);
        struct sched_snapshot after = sched_take(fd);
        if (child > 0) {
            if (kill(child, SIGTERM)) sched_fail("kill");
            int status;
            if (waitpid(child, &status, 0) != child || !WIFSIGNALED(status) || WTERMSIG(status) != SIGTERM)
                sched_fail("child wait");
        }
        printf("{\"round\":%d,\"position\":%d,\"mode\":\"%s\",\"cpu\":%d,\"before\":", round, at, names[mode], cpu);
        emit(&before); printf(",\"after\":"); emit(&after); printf("}\n");
        fflush(stdout);
    }
    if (close(fd)) sched_fail("close");
    return 0;
}
