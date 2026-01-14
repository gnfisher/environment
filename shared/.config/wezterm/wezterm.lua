local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Custom color scheme: Modern Borland Blue
-- Inspired by Tomorrow Night Blue / classic DOS Borland with a contemporary feel
config.colors = {
  -- Deep blue background reminiscent of Borland/DOS
  background = "#002451",
  foreground = "#ffffff",
  cursor_bg = "#ffcc00",
  cursor_fg = "#002451",
  cursor_border = "#ffcc00",
  selection_bg = "#003f8e",
  selection_fg = "#ffffff",

  ansi = {
    "#00346e", -- black (dark blue tint)
    "#ff9da4", -- red (soft coral)
    "#d1f1a9", -- green (soft lime)
    "#ffeead", -- yellow (warm cream)
    "#bbdaff", -- blue (soft sky)
    "#ebbbff", -- magenta (soft lavender)
    "#99ffff", -- cyan (bright aqua)
    "#ffffff", -- white
  },
  brights = {
    "#7285b7", -- bright black (muted periwinkle)
    "#ff7882", -- bright red
    "#b5e890", -- bright green
    "#ffd479", -- bright yellow (golden)
    "#96cbfe", -- bright blue
    "#ff73fd", -- bright magenta
    "#67eaff", -- bright cyan
    "#ffffff", -- bright white
  },

  -- Tab bar colors
  tab_bar = {
    background = "#001e3c",
    active_tab = {
      bg_color = "#002451",
      fg_color = "#ffffff",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#001e3c",
      fg_color = "#7285b7",
    },
    inactive_tab_hover = {
      bg_color = "#003366",
      fg_color = "#bbdaff",
    },
    new_tab = {
      bg_color = "#001e3c",
      fg_color = "#7285b7",
    },
    new_tab_hover = {
      bg_color = "#003366",
      fg_color = "#ffffff",
    },
  },
}

-- Font
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 14.0
config.line_height = 1.1

-- Window
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 12,
}
config.window_background_opacity = 0.97
config.macos_window_background_blur = 20
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.native_macos_fullscreen_mode = true

-- Behavior
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.audible_bell = "Disabled"
config.default_cursor_style = "SteadyBlock"
config.cursor_blink_rate = 0

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
