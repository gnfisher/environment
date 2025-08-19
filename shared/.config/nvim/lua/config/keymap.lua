local opts = { noremap = true, silent = true }

vim.g.mapLeader = " "
vim.keymap.set("n", "<Leader>;", ":", opts)
vim.keymap.set({"t"}, "<C-\\>", "<C-\\><C-n>", opts)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
vim.keymap.set("x", "<Leader>p", [["_dP]], opts)
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]], opts)
vim.keymap.set("n", "<Leader>Y", [["+Y]], opts)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("n", "<C-j>", "<Cmd>cnext<CR>zz", opts)
vim.keymap.set("n", "<C-k>", "<Cmd>cprev<CR>zz", opts)
vim.keymap.set("n", "-", "<Cmd>Ex<CR>", opts)
vim.keymap.set({ "n", "v", "i" }, "<F6>", ":ToggleBg<CR>", opts)
vim.keymap.set("n", "<Leader>nn", ":e ~/notes/notes<CR>", opts)
