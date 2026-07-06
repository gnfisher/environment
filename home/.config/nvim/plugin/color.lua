vim.g.acme_style = "colorful"

local default_guicursor = vim.o.guicursor

local acme_highlights = {
  ["@variable"] = { link = "Identifier" },
  ["@variable.member"] = { link = "Identifier" },
  ["@variable.parameter"] = { link = "Identifier" },
  ["@lsp.type.variable"] = { link = "@variable" },
  ["@lsp.type.parameter"] = { link = "@variable.parameter" },
}

local transparent_groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "FloatBorder",
  "SignColumn",
  "FoldColumn",
  "LineNr",
  "EndOfBuffer",
}

local function clear_background(group)
  local ok, highlight = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
  if not ok then
    return
  end

  highlight.bg = "none"
  vim.api.nvim_set_hl(0, group, highlight)
end

local function set_custom_highlights(colors_name)
  vim.o.guicursor = default_guicursor

  for _, group in ipairs(transparent_groups) do
    clear_background(group)
  end

  local ok, normal = pcall(vim.api.nvim_get_hl, 0, { name = "Normal", link = false })
  if ok then
    vim.api.nvim_set_hl(0, "Folded", { fg = normal.fg, bg = "none" })
  end

  if (colors_name or vim.g.colors_name) == "acme" then
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

vim.o.background = "dark"
vim.cmd.colorscheme("rose-pine-moon")
set_custom_highlights()
