vim.o.background = "light"
vim.cmd.colorscheme("dookie")

local function set_custom_highlights()
  local foreground = "#000000"
  local comment = "#555555"

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

set_custom_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_custom_highlights,
})
