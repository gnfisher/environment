local themes = {
  dark = {
    background = "dark",
    colorscheme = "github_dark_dimmed",
  },
  light = {
    background = "light",
    colorscheme = "github_light_default",
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

local function toggle_mode()
  apply_mode(current_mode == "dark" and "light" or "dark")
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_custom_highlights,
})

vim.keymap.set("n", "<F6>", toggle_mode, { silent = true, desc = "Toggle dark/light theme" })

apply_mode("dark", true)
