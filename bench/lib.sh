# Shared by the run-*.sh scripts; sourced, not run.
#
# Every terminal is launched through Hyprland (hyprctl) onto a headless
# output made for the run, so it gets the same full-screen tile each time
# and nothing opens on a real monitor. The output is removed at the end,
# but only once every window the run opened has closed: a window still on
# it when it goes would move to a real monitor.
#
# CAP names the headless output (GLASSCAP by default).

CAP=${CAP:-GLASSCAP}
WS=

command -v hyprctl >/dev/null || { echo "the harness launches terminals through Hyprland (hyprctl); none found" >&2; exit 1; }
command -v python3 >/dev/null || { echo "the harness needs python3" >&2; exit 1; }

# term_cmd NAME CLASS COMMAND...: the line Hyprland runs to open terminal
# NAME with the window class (Wayland app id) CLASS, running COMMAND.
#
# To add a terminal, add a case below. The line must set the window's
# class to CLASS, run COMMAND as the terminal's child, and close the
# window when COMMAND exits. See bench/README.md.
term_cmd() {
  local name=$1 class=$2
  shift 2
  case $name in
    glass) echo "${GLASS:-glass} --class $class -e $*" ;;
    # A second glass binary, to compare two builds in one run.
    glass-alt) echo "${GLASS_ALT:?GLASS_ALT names a second glass binary} --class $class -e $*" ;;
    kitty) echo "${KITTY:-kitty} --class $class $*" ;;
    *)
      echo "lib.sh: no launch line for terminal '$name'; add one to term_cmd" >&2
      return 1
      ;;
  esac
}

# Make the headless output and find its workspace. Stops rather than open
# windows anywhere else.
headless_up() {
  hyprctl output create headless "$CAP" >/dev/null
  sleep 1
  WS=$(hyprctl monitors -j | CAP=$CAP python3 -c '
import json, os, sys
ids = [m["activeWorkspace"]["id"] for m in json.load(sys.stdin) if m["name"] == os.environ["CAP"]]
print(ids[0] if ids else "")')
  if [ -z "$WS" ]; then
    echo "no headless output $CAP" >&2
    hyprctl output remove "$CAP" >/dev/null 2>&1
    exit 1
  fi
}

# Open a command on the headless output's workspace, without focusing it.
launch() {
  [ -n "$WS" ] || { echo "launch before headless_up" >&2; exit 1; }
  hyprctl eval "hl.dispatch(hl.dsp.exec_cmd([[$1]], { workspace = \"$WS silent\" }))" >/dev/null
}

# The windows open on the headless output's workspace: "pid class address" a line.
run_windows() {
  hyprctl clients -j | WS=$WS python3 -c '
import json, os, sys
for c in json.load(sys.stdin):
    if str(c["workspace"]["id"]) == os.environ["WS"]:
        print(c["pid"], c["class"], c["address"])'
}

# Wait up to ten seconds for every window on the headless output to close.
wait_gone() {
  local i
  for i in $(seq 40); do
    [ -z "$(run_windows)" ] && return 0
    sleep 0.25
  done
  return 1
}

# Close whatever is left on the headless output, then remove the output.
headless_down() {
  [ -n "$WS" ] || return 0
  if ! wait_gone; then
    run_windows | while read -r pid _ _; do kill "$pid" 2>/dev/null; done
    if ! wait_gone; then
      echo "windows are still open on $CAP; leaving the output in place" >&2
      return 1
    fi
  fi
  hyprctl output remove "$CAP" >/dev/null
  WS=
}
