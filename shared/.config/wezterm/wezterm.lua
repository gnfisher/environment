local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Themes
local themes = {
  tomorrow_night_blue = {
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
  },

  tango = {
    background = "#000000",
    foreground = "#d3d7cf",
    cursor_bg = "#d3d7cf",
    cursor_fg = "#000000",
    cursor_border = "#d3d7cf",
    selection_bg = "#4e9a06",
    selection_fg = "#ffffff",
    ansi = {
      "#000000", -- black
      "#cc0000", -- red
      "#4e9a06", -- green
      "#c4a000", -- yellow
      "#3465a4", -- blue
      "#75507b", -- magenta
      "#06989a", -- cyan
      "#d3d7cf", -- white
    },
    brights = {
      "#555753", -- bright black
      "#ef2929", -- bright red
      "#8ae234", -- bright green
      "#fce94f", -- bright yellow
      "#729fcf", -- bright blue
      "#ad7fa8", -- bright magenta
      "#34e2e2", -- bright cyan
      "#eeeeec", -- bright white
    },
    tab_bar = {
      background = "#2e3436",
      active_tab = {
        bg_color = "#000000",
        fg_color = "#d3d7cf",
        intensity = "Bold",
      },
      inactive_tab = {
        bg_color = "#2e3436",
        fg_color = "#888a85",
      },
      inactive_tab_hover = {
        bg_color = "#555753",
        fg_color = "#d3d7cf",
      },
      new_tab = {
        bg_color = "#2e3436",
        fg_color = "#888a85",
      },
      new_tab_hover = {
        bg_color = "#555753",
        fg_color = "#d3d7cf",
      },
    },
  },
}

-- Select theme
local current_theme = "tango"
config.colors = themes[current_theme]

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
