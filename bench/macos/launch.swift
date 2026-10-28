// launch STAMPFILE TERMINAL ARGS...: starts the terminal, then reports in ms
// from the spawn when a window it owns is first on screen, and when the
// program inside wrote STAMPFILE.
import CoreGraphics
import Foundation

let args = CommandLine.arguments
let stampPath = args[1]
unlink(stampPath)
var pid: pid_t = 0
let cargs = args[2...].map { strdup($0) } + [nil]
var t0 = timespec()
clock_gettime(CLOCK_REALTIME, &t0)
let start = Double(t0.tv_sec) * 1e3 + Double(t0.tv_nsec) / 1e6
guard posix_spawn(&pid, args[2], nil, nil, cargs, environ) == 0 else { exit(1) }
func now() -> Double {
    var t = timespec()
    clock_gettime(CLOCK_REALTIME, &t)
    return Double(t.tv_sec) * 1e3 + Double(t.tv_nsec) / 1e6
}
var window: Double? = nil
var program: Double? = nil
while now() - start < 5000 && (window == nil || program == nil) {
    if window == nil,
       let list = CGWindowListCopyWindowInfo([.optionOnScreenOnly], kCGNullWindowID) as? [[String: Any]],
       list.contains(where: { ($0[kCGWindowOwnerPID as String] as? Int32) == pid && ($0[kCGWindowLayer as String] as? Int) == 0 }) {
        window = now() - start
    }
    if program == nil, let s = try? String(contentsOfFile: stampPath, encoding: .utf8),
       let ns = Double(s.trimmingCharacters(in: .whitespacesAndNewlines)) {
        program = ns / 1e6 - start
    }
    usleep(500)
}
var status: Int32 = 0
waitpid(pid, &status, 0)
print(String(format: "window %.1f program %.1f", window ?? -1, program ?? -1))
