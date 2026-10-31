// Measures the cost of the one thing a scroll actually must do per line:
// rotate the ring's zero (1 store) vs copy the line's cells (cols stores).
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define COLS 154
#define CELL 24
static unsigned char buf[10139 * COLS * CELL]; // 39 screen + 10000 history
static inline unsigned char *row(size_t i) { return buf + i * COLS * CELL; }
static double now(void) { struct timespec t; clock_gettime(CLOCK_MONOTONIC, &t); return t.tv_sec + t.tv_nsec / 1e9; }
int main(void) {
    memset(buf, 'x', sizeof buf);
    size_t lines = 8388608 / (COLS * CELL); // 16 MB of flood -> lines of text
    // (a) rotate-only: one pointer update per line
    double t0 = now();
    for (size_t i = 0; i < lines; i++) {
        // read the oldest row once so it is "touched" like a real scroll would
        volatile unsigned char sink = row(0)[0];
        (void)sink;
    }
    double t1 = now();
    printf("touch-oldest-row:  %zu lines, %.3f s (%.1f M lines/s)\n", lines, t1 - t0, lines / (t1 - t0) / 1e6);
    // (b) copy the incoming line's cells, as a fresh scrolled line is written
    t0 = now();
    for (size_t i = 0; i < lines; i++) {
        memset(row(0), 'y', COLS * CELL);
    }
    t1 = now();
    printf("write-line-cells:  %zu lines, %.3f s (%.1f M lines/s)\n", lines, t1 - t0, lines / (t1 - t0) / 1e6);
    return 0;
}
