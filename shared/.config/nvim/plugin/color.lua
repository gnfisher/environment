local themes = {
  dark = {
    background = "dark",
    colorscheme = "onedark",
  },
  light = {
    background = "light",
    colorscheme = "acme",
  },
}

local current_mode
local default_guicursor = vim.o.guicursor

local function reset_highlights()
  vim.cmd("highlight clear")

  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
end

local function macos_theme_mode()
  if vim.uv.os_uname().sysname ~= "Darwin" then
    return "dark"
  end

  local output = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
  if vim.v.shell_error == 0 and output:match("Dark") then
    return "dark"
  end

  return "light"
end

local function set_custom_highlights()
  vim.o.guicursor = default_guicursor
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  vim.api.nvim_set_hl(0, "Folded", { fg = normal.fg, bg = "none" })
end

local function apply_mode(mode, force)
  if not force and mode == current_mode then
    return
  end

  local theme = themes[mode]
  reset_highlights()
  vim.o.background = theme.background
  current_mode = mode
  vim.cmd.colorscheme(theme.colorscheme)
  vim.o.background = theme.background
  set_custom_highlights()
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_custom_highlights,
})

vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
  callback = function()
    apply_mode(macos_theme_mode())
  end,
})

apply_mode(macos_theme_mode(), true)
