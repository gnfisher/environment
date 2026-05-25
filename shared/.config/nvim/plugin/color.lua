local themes = {
  dark = {
    background = "dark",
    colorscheme = "tokyonight",
  },
  light = {
    background = "light",
    colorscheme = "acme",
  },
}

local set_custom_highlights
local function reset_highlights()
  vim.cmd("highlight clear")

  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
end

set_custom_highlights = function()
  if vim.o.background ~= "light" then
    return
  end

  local foreground = "#000000"
  local background = "#ffffea"
  local comment = "#555555"

  vim.api.nvim_set_hl(0, "Cursor", { fg = background, bg = foreground })
  vim.api.nvim_set_hl(0, "CursorIM", { fg = background, bg = foreground })
  vim.api.nvim_set_hl(0, "TermCursor", { fg = background, bg = foreground })

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
  vim.cmd.colorscheme(theme.colorscheme)
  vim.o.background = theme.background
  vim.g.theme_mode = mode

  if theme.colorscheme == "acme" then
    vim.g.colors_name = "acme"
  end

  set_custom_highlights()
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
