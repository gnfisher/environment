local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Appearance
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14.0
config.line_height = 1.1

-- Window
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = true

-- Behavior
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.audible_bell = "Disabled"

-- Keys (keep defaults, add a few conveniences)
config.keys = {
  -- Split panes (similar to tmux with C-s)
  { key = "d", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

  -- Navigate panes
  { key = "h", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "k", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "j", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },

  -- Close pane
  { key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

  -- Zoom/toggle pane
  { key = "Enter", mods = "CMD|SHIFT", action = wezterm.action.TogglePaneZoomState },

  -- Shift+Enter sends newline for TUI multi-line input (Claude Code, Copilot CLI)
  { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\n") },
}

return config
