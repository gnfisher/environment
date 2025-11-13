local set = vim.keymap.set
local opts = { noremap = true, silent = true }

set("n", "<C-space>", ":noh<CR>", opts)

set("x", "<Leader>p", [["_dP]], opts)
set({ "n", "v" }, "<Leader>y", [["+y]], opts)
set("n", "<Leader>Y", [["+Y]], opts)

set("v", "J", ":m '>+1<CR>gv=gv", opts)
set("v", "K", ":m '<-2<CR>gv=gv", opts)

set("n", "]q", "<Cmd>cnext<CR>zz", opts)
set("n", "[q", "<Cmd>cprev<CR>zz", opts)
