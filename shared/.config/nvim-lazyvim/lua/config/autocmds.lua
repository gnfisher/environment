local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Trim trailing whitespace on save
autocmd("BufWritePre", {
  command = [[%s/\s\+$//e]],
  group = augroup("trim_whitespace", { clear = true }),
})

-- LSP diagnostic display preferences
-- Runs once on startup (not per-buffer)
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = false,      -- No underline, too noisy
  update_in_insert = false, -- Don't update while typing (performance)
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",    -- Always show which LSP raised the diagnostic
  },
})
