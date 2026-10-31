// Per-scroll cost of ring rotation vs VecDeque-style memmove under an
// active 37 MB history, at the cadence the flood actually scrolls.
#include <stdio.h>
#include <string.h>
#include <time.h>
#define COLS 154
#define CELL 24
#define HIST 10000
#define SCREEN 39
#define TOTAL (HIST + SCREEN)
static unsigned char buf[TOTAL * COLS * CELL];
static size_t zero;
static double now(void) { struct timespec t; clock_gettime(CLOCK_MONOTONIC, &t); return t.tv_sec + t.tv_nsec / 1e9; }
static unsigned long long sink;
static void scroll_ring(void) {
    // alacritty's grid: rotate = one index arithmetic; the incoming line is
    // then written fresh by the parser. Touch a few rows to model reads.
    zero = (zero + 1) % TOTAL;
    sink += buf[((zero + 5) % TOTAL) * COLS * CELL];
    memset(&buf[(zero % TOTAL) * COLS * CELL], 'y', COLS * CELL);
}
static void scroll_memmove(void) {
    // VecDeque of rows would still be O(1) swap; a naive Vec<Row> with
    // pop-front/push-back pays a memmove of the whole tail per scroll.
    memmove(buf, buf + COLS * CELL, (TOTAL - 1) * COLS * CELL);
    memset(buf + (TOTAL - 1) * COLS * CELL, 'y', COLS * CELL);
    sink += buf[5 * COLS * CELL % sizeof buf];
}
int main(void) {
    memset(buf, 'x', sizeof buf);
    enum { N = 100000 };
    double t0 = now();
    for (int i = 0; i < N; i++) scroll_ring();
    double t1 = now();
    printf("ring rotate : %d scrolls in %.4f s = %.2f us/scroll (%.1f M lines/s)\n", N, t1 - t0, (t1 - t0) / N * 1e6, N / (t1 - t0) / 1e6);
    t0 = now();
    for (int i = 0; i < N / 100; i++) scroll_memmove();
    t1 = now();
    printf("naive memmove: %d scrolls in %.4f s = %.2f us/scroll\n", N / 100, t1 - t0, (t1 - t0) / (N / 100) * 1e6);
    if (sink == 1) printf(".\n");
    return 0;
}
