local themes = {
  dark = {
    background = "dark",
    colorscheme = "rose-pine",
  },
  light = {
    background = "light",
    colorscheme = "acme",
  },
}

local set_custom_highlights
local current_colorscheme
local default_guicursor = vim.o.guicursor
local function reset_highlights()
  vim.cmd("highlight clear")

  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
end

local function is_acme()
  return current_colorscheme == "acme" or vim.g.colors_name == "acme"
end

set_custom_highlights = function(event)
  if event and event.match then
    current_colorscheme = event.match
  end

  if is_acme() then
    vim.o.background = "light"
  elseif vim.o.background ~= "light" then
    vim.o.guicursor = default_guicursor
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    vim.api.nvim_set_hl(0, "Folded", { fg = normal.fg, bg = "none" })
    return
  end

  local foreground = "#000000"
  local comment = "#555555"
  local background = "#ffffea"
  local cursor = "#005fff"

  vim.o.guicursor = table.concat({
    "n-v-c-sm:block-Cursor",
    "i-ci-ve:ver25-Cursor",
    "r-cr-o:hor20-Cursor",
    "t:block-TermCursor",
  }, ",")

  vim.api.nvim_set_hl(0, "Cursor", { fg = background, bg = cursor })
  vim.api.nvim_set_hl(0, "CursorIM", { fg = background, bg = cursor })
  vim.api.nvim_set_hl(0, "lCursor", { fg = background, bg = cursor })
  vim.api.nvim_set_hl(0, "TermCursor", { fg = background, bg = cursor })
  vim.api.nvim_set_hl(0, "TermCursorNC", { fg = background, bg = cursor })

  -- Comments should recede without becoming faint or stylized.
  vim.api.nvim_set_hl(0, "Comment", { fg = comment })
  vim.api.nvim_set_hl(0, "SpecialComment", { fg = comment })
  vim.api.nvim_set_hl(0, "@comment", { fg = comment })
  vim.api.nvim_set_hl(0, "@comment.documentation", { fg = comment })
  vim.api.nvim_set_hl(0, "@comment.error", { fg = comment })
  vim.api.nvim_set_hl(0, "@comment.warning", { fg = comment })
  vim.api.nvim_set_hl(0, "@comment.todo", { fg = comment })
  vim.api.nvim_set_hl(0, "@comment.note", { fg = comment })

  -- Emphasize declarations, while keeping calls, fields, and bodies plain.
  vim.api.nvim_set_hl(0, "@keyword.function", { fg = foreground, bold = true })
  vim.api.nvim_set_hl(0, "@keyword.type", { fg = foreground, bold = true })
  vim.api.nvim_set_hl(0, "@function", { fg = foreground, bold = true })
  vim.api.nvim_set_hl(0, "@function.method", { fg = foreground, bold = true })
  vim.api.nvim_set_hl(0, "@type.definition", { fg = foreground, bold = true })
  vim.api.nvim_set_hl(0, "@function.call", { fg = foreground })
  vim.api.nvim_set_hl(0, "@function.method.call", { fg = foreground })
  vim.api.nvim_set_hl(0, "@variable.member", { fg = foreground })

  vim.api.nvim_set_hl(0, "@lsp.type.comment", { fg = comment })
  vim.api.nvim_set_hl(0, "@lsp.type.type", { fg = foreground })
  vim.api.nvim_set_hl(0, "@lsp.type.class", { fg = foreground })
  vim.api.nvim_set_hl(0, "@lsp.type.enum", { fg = foreground })
  vim.api.nvim_set_hl(0, "@lsp.type.interface", { fg = foreground })
  vim.api.nvim_set_hl(0, "@lsp.type.struct", { fg = foreground })
  vim.api.nvim_set_hl(0, "@lsp.type.function", { fg = foreground })
  vim.api.nvim_set_hl(0, "@lsp.type.method", { fg = foreground })
  vim.api.nvim_set_hl(0, "@lsp.typemod.class.declaration", { fg = foreground, bold = true })
  vim.api.nvim_set_hl(0, "@lsp.typemod.enum.declaration", { fg = foreground, bold = true })
  vim.api.nvim_set_hl(0, "@lsp.typemod.function.declaration", { fg = foreground, bold = true })
  vim.api.nvim_set_hl(0, "@lsp.typemod.interface.declaration", { fg = foreground, bold = true })
  vim.api.nvim_set_hl(0, "@lsp.typemod.method.declaration", { fg = foreground, bold = true })
  vim.api.nvim_set_hl(0, "@lsp.typemod.struct.declaration", { fg = foreground, bold = true })
  vim.api.nvim_set_hl(0, "@lsp.typemod.type.declaration", { fg = foreground, bold = true })
end

local function apply_theme(mode)
  local theme = themes[mode]

  reset_highlights()
  vim.o.background = theme.background
  current_colorscheme = theme.colorscheme
  vim.cmd.colorscheme(theme.colorscheme)
  vim.o.background = theme.background
  vim.g.theme_mode = mode

  if theme.colorscheme == "acme" then
    vim.g.colors_name = "acme"
  end

  set_custom_highlights({ match = theme.colorscheme })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_custom_highlights,
})

vim.api.nvim_create_user_command("ThemeToggle", function()
  if vim.g.theme_mode == "dark" then
    apply_theme("light")
  else
    apply_theme("dark")
  end
end, {})

vim.keymap.set("n", "<F6>", "<Cmd>ThemeToggle<CR>", { silent = true, desc = "Toggle light/dark color theme" })

apply_theme("dark")
