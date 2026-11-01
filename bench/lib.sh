# Shared by the run-*.sh scripts; sourced, not run.
#
# Every terminal is launched through Hyprland (hyprctl) onto a headless
# output made for the run, so it gets the same full-screen tile each time
# and nothing opens on a real monitor. The output is removed at the end,
# but only once every window the run opened has closed: a window still on
# it when it goes would move to a real monitor.
#
# CAP names the headless output (GLASSCAP by default), RES its size
# (1920x1080 by default).

CAP=${CAP:-GLASSCAP}
RES=${RES:-1920x1080}
WS=
BENCH_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
# The workspace the headless output opens on. Without a rule naming one,
# Hyprland hands a new output a workspace of its choosing, and that has
# been the one a real monitor was showing, windows and all. A workspace and
# an output each take the first rule that names them, so the number is the
# run's own and the rule is switched off again in headless_down.
BENCH_WS=${BENCH_WS:-$((1000 + $$ % 9000))}

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
    # foot with its own default of a render thread per CPU: Omarchy's
    # foot.ini sets workers=0, which renders on one thread.
    foot) echo "${FOOT:-foot} -o main.workers=$(nproc) -o main.pad=20x14 --app-id $class $*" ;;
    alacritty) echo "${ALACRITTY:-alacritty} -o window.padding.x=20 --class $class -e $*" ;;
    # A process of its own for each launch, not a window of a running one.
    ghostty) echo "${GHOSTTY:-ghostty} --gtk-single-instance=false --window-padding-x=17 --adjust-cell-height=1 --class=$class -e $*" ;;
    # WezTerm has no configuration here; linux/wezterm.lua gives it the
    # font, size and padding the others have, and no tab bar.
    wezterm) echo "${WEZTERM:-wezterm} --config-file $BENCH_DIR/linux/wezterm.lua start --always-new-process --class $class -- $*" ;;
    *)
      echo "lib.sh: no launch line for terminal '$name'; add one to term_cmd" >&2
      return 1
      ;;
  esac
}

# Make the headless output and find its workspace. Stops rather than open
# windows anywhere else.
headless_up() {
  hyprctl eval "_G.glass_bench_ws = hl.workspace_rule({ workspace = \"$BENCH_WS\", monitor = \"$CAP\", default = true })" >/dev/null
  hyprctl output create headless "$CAP" >/dev/null
  sleep 0.5
  hyprctl eval "hl.monitor({ output = \"$CAP\", mode = \"$RES\", position = \"auto\", scale = 1 })" >/dev/null
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
  # Should the rule not hold and the output be given a workspace with
  # windows, the run would open its windows among them, and headless_down
  # closes whatever is left there, so it stops instead.
  if [ -n "$(run_windows)" ]; then
    echo "headless output $CAP was given workspace $WS, which holds windows; stopping" >&2
    WS=
    hyprctl output remove "$CAP" >/dev/null 2>&1
    rule_off
    exit 1
  fi
}

# Open a command on the headless output's workspace, without focusing it.
# launch CLASS COMMAND...: exec COMMAND and place its window (whose class
# must be CLASS) on the headless output's workspace.
launch() {
  [ -n "$WS" ] || { echo "launch before headless_up" >&2; exit 1; }
  # Hyprland 0.56.2 silently drops exec_cmd's workspace option (both the
  # legacy "<id> silent" string and the bare number): the process runs but
  # the window opens on the active workspace -- a 1/3 tile on a real
  # monitor, which is where the 50x39/49x39 geometries came from. A
  # class-matched window rule places the window on the headless output's
  # workspace instead, and works for every terminal identically.
  hyprctl eval "_G.glass_bench_wr = hl.window_rule({ name = \"glassbench\", match = { class = \"^$1$\" }, workspace = \"$WS silent\" })" >/dev/null
  shift
  local cmd=$*
  hyprctl eval "hl.dispatch(hl.dsp.exec_cmd([[$cmd]]))" >/dev/null
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
  # Terminals take tens of seconds to map their window under system load
  # (ghostty was measured at 50s while the GPU was exhausted), and close
  # just as slowly; ten seconds truncated runs mid-teardown.
  for i in $(seq 120); do
    [ -z "$(run_windows)" ] && return 0
    sleep 0.5
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
  # Removing a virtual output can leave Hyprland 0.56.2's headless backend
  # wedged: the next create comes up 0x0 and no mode sticks to it. Waiting
  # for the monitor list to settle has kept the path healthy every run since.
  sleep 2
  hyprctl eval "hl.monitor({ output = \"$CAP\", mode = \"preferred\", position = \"auto\", scale = 1 })" >/dev/null
  rule_off
  WS=
}

# Switch the workspace rule headless_up made off again.
rule_off() {
  hyprctl eval 'if _G.glass_bench_ws then _G.glass_bench_ws:set_enabled(false); _G.glass_bench_ws = nil end' >/dev/null
  hyprctl eval 'if _G.glass_bench_wr then _G.glass_bench_wr:set_enabled(false); _G.glass_bench_wr = nil end' >/dev/null
}
