local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Escape terminal with Ctrl-\ or Esc
set({"t"}, "<C-\\>", "<C-\\><C-n>", opts)
set("t", "<Esc>", "<C-\\><C-n>", opts)

