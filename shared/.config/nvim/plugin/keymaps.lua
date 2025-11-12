local set = vim.keymap.set
local opts = { noremap = true, silent = true }

set("n", "<Leader>;", ":", opts)

set("n", "<C-space>", ":noh<CR>", opts)

-- Escape terminal with Ctrl-\ or Esc
set({"t"}, "<C-\\>", "<C-\\><C-n>", opts)
set("t", "<Esc>", "<C-\\><C-n>", opts)

set("x", "<Leader>p", [["_dP]], opts)
set({ "n", "v" }, "<Leader>y", [["+y]], opts)
set("n", "<Leader>Y", [["+Y]], opts)

set("v", "J", ":m '>+1<CR>gv=gv", opts)
set("v", "K", ":m '<-2<CR>gv=gv", opts)

set("n", "]q", "<Cmd>cnext<CR>zz", opts)
set("n", "[q", "<Cmd>cprev<CR>zz", opts)
