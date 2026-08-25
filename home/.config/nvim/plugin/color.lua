vim.g.acme_style = "colorful"

local default_guicursor = vim.o.guicursor

local acme_highlights = {
  ["@variable"] = { link = "Identifier" },
  ["@variable.member"] = { link = "Identifier" },
  ["@variable.parameter"] = { link = "Identifier" },
  ["@lsp.type.variable"] = { link = "@variable" },
  ["@lsp.type.parameter"] = { link = "@variable.parameter" },
}

local function set_custom_highlights(colors_name)
  local active_colors_name = colors_name or vim.g.colors_name
  vim.o.guicursor = default_guicursor

  if active_colors_name == "acme" then
    vim.g.colors_name = "acme"

    for group, highlight in pairs(acme_highlights) do
      vim.api.nvim_set_hl(0, group, highlight)
    end
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function(event)
    set_custom_highlights(event.match)
  end,
})

vim.o.background = "light"
vim.cmd("syntax enable")
vim.cmd.colorscheme("modus_operandi")
set_custom_highlights()
