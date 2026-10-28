// Writes the wall clock, in ns, to argv[1], then waits a second so the
// terminal sees an ordinary exit.
#include <stdio.h>
#include <time.h>
#include <unistd.h>
int main(int argc, char **argv) {
    struct timespec t;
    clock_gettime(CLOCK_REALTIME, &t);
    FILE *f = fopen(argv[1], "w");
    if (!f) return 1;
    fprintf(f, "%lld\n", (long long)t.tv_sec * 1000000000LL + t.tv_nsec);
    fclose(f);
    sleep(1);
    return 0;
}
