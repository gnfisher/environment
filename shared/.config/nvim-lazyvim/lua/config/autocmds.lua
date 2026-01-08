-- Autocmds
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Trim trailing whitespace on save
autocmd("BufWritePre", {
  command = [[%s/\s\+$//e]],
  group = augroup("trim_whitespace", { clear = true }),
})
