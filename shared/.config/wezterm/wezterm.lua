local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Theme: Catppuccin Mocha
config.color_scheme = "Catppuccin Mocha"

-- Font
config.font = wezterm.font("CaskaydiaCove Nerd Font Mono", { weight = "Regular" })
config.font_size = 15.0
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

-- Tab title: show CWD name
wezterm.on("format-tab-title", function(tab)
  local cwd = tab.active_pane.current_working_dir
  if cwd then
    -- Extract just the folder name from the path
    local folder = cwd.file_path:match("([^/]+)/?$") or cwd.file_path
    return " " .. folder .. " "
  end
  return tab.active_pane.title
end)

-- Keys (keep defaults, add a few conveniences)
config.keys = {
  -- Split panes (similar to tmux with C-s)
  { key = "d",     mods = "CMD",       action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "d",     mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

  -- Navigate panes
  { key = "h",     mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l",     mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "k",     mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "j",     mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },

  -- Close pane
  { key = "w",     mods = "CMD",       action = wezterm.action.CloseCurrentPane({ confirm = true }) },

  -- Zoom/toggle pane
  { key = "Enter", mods = "CMD|SHIFT", action = wezterm.action.TogglePaneZoomState },

  -- Shift+Enter sends newline for TUI multi-line input (Claude Code, Copilot CLI)
  { key = "Enter", mods = "SHIFT",     action = wezterm.action.SendString("\n") },
}

return config
