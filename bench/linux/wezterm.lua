-- WezTerm for the bench: the font, size and padding glass, kitty, foot,
-- Alacritty and Ghostty have in this machine's configuration, and no tab
-- bar or title bar, so it gets the same grid in the same tile.
return {
  font = require("wezterm").font("Berkeley Mono"),
  font_size = 15,
  window_padding = { left = 20, right = 20, top = 14, bottom = 14 },
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "NONE",
  window_close_confirmation = "NeverPrompt",
  check_for_updates = false,
}
