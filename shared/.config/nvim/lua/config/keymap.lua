local opts = { noremap = true, silent = true }

vim.g.mapLeader = " "

vim.keymap.set("n", "<Leader>;", ":", opts)

-- Escape terminal with Ctrl-\ or Esc
vim.keymap.set({"t"}, "<C-\\>", "<C-\\><C-n>", opts)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

vim.keymap.set("x", "<Leader>p", [["_dP]], opts)
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]], opts)
vim.keymap.set("n", "<Leader>Y", [["+Y]], opts)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

vim.keymap.set("n", "]q", "<Cmd>cnext<CR>zz", opts)
vim.keymap.set("n", "[q", "<Cmd>cprev<CR>zz", opts)
