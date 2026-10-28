import os, sys, termios, time, tty
fd = sys.stdin.fileno(); old = termios.tcgetattr(fd); tty.setraw(fd)
log = open(sys.argv[1], "w")
try:
    while True:
        b = os.read(fd, 64); t = time.time_ns()
        log.write(f"{t} {b!r}\n"); log.flush()
        if b"q" in b: break
finally:
    termios.tcsetattr(fd, termios.TCSADRAIN, old)
