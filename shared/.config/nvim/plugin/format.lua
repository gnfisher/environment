local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
  command = [[%s/\s\+$//e]],
  group = augroup("trim_whitespace", {}),
})

