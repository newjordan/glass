#!/bin/bash
# Wait for the frozen performance/latency run before any CPU-heavy test.
set -euo pipefail
while kill -0 2574218 2>/dev/null; do sleep 2; done
D=bench/results/2026-11-02-hup-drain
mkdir -p "$D"
python3 - <<'PY'
p='crates/term/src/read_ahead.rs';s=open(p).read()
anchor='    /// Every byte the program writes comes out once, in order, however it\n'
assert s.count(anchor)==1
s=s.replace(anchor,'''    #[cfg(target_os = "linux")]
    #[test]
    fn readable_bytes_are_drained_before_a_hangup_ends_the_reader() {
        let (mut master, mut slave) = pty();
        let fd: OwnedFd = master.try_clone().unwrap().into();
        slave.write_all(b"the final burst").unwrap();
        drop(slave);
        // Linux reports POLLIN | POLLHUP together: HUP does not mean
        // the already-buffered bytes are gone. This is the state a writer
        // can create between waiting(FIONREAD) and wait_for_more(poll).
        assert!(matches!(wait_for_more(Some(&fd), Duration::ZERO), Poll::Ready));
        let mut bytes = [0; 15];
        master.read_exact(&mut bytes).unwrap();
        assert_eq!(&bytes, b"the final burst");
        assert!(matches!(wait_for_more(Some(&fd), Duration::ZERO), Poll::End));
    }

'''+anchor,1)
open(p,'w').write(s)
PY
set +e
cargo test --release -p glass-term --locked -- read_ahead::tests::readable_bytes_are_drained_before_a_hangup_ends_the_reader --exact > "$D/before.log" 2>&1
rc=$?
set -e
printf 'before %s\n' "$rc" | tee "$D/exits.txt"
test "$rc" -eq 101
python3 - <<'PY'
p='crates/term/src/read_ahead.rs';s=open(p).read()
old='''    if pfd.revents & (libc::POLLHUP | libc::POLLERR) != 0 {
        return Poll::End;
    }
'''
new='''    // A peer can close with unread bytes still queued. POLLIN and HUP
    // then arrive together: drain readable bytes before honoring the end.
    if pfd.revents & libc::POLLIN != 0 {
        return Poll::Ready;
    }
    if pfd.revents & (libc::POLLHUP | libc::POLLERR) != 0 {
        return Poll::End;
    }
'''
assert s.count(old)==1;s=s.replace(old,new,1);open(p,'w').write(s)
PY
set +e
cargo test --release -p glass-term --locked -- read_ahead::tests > "$D/after.log" 2>&1
rc=$?
set -e
printf 'after %s\n' "$rc" | tee -a "$D/exits.txt"
git diff -- crates/term/src/read_ahead.rs > "$D/reader.patch"
exit "$rc"
