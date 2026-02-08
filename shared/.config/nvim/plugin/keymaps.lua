local set = vim.keymap.set
local opts = { noremap = true, silent = true }

set("n", "<BS>", ":noh<CR>", opts)

set({ "i", "v" }, "<C-space>", "<Esc>", opts)


-- Paste from clipboard
set("x", "<Leader>p", [["_dP]], opts)

-- Yank to clipboard
set({ "n", "v" }, "<Leader>y", [["+y]], opts)
set("n", "<Leader>Y", [["+Y]], opts)

-- Move highlighted lines up/down
set("v", "J", ":m '>+1<CR>gv=gv", opts)
set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Jump to line then scroll to top
set("n", "G", "Gzt", opts)
set("n", "gg", "ggzt", opts)

-- Quickfix jump
set("n", "]q", "<Cmd>cnext<CR>zz", opts)
set("n", "[q", "<Cmd>cprev<CR>zz", opts)

-- Diffview
set("n", "<Leader>dd", "<Cmd>DiffviewToggle<CR>", opts)
set("n", "<Leader>df", "<Cmd>DiffviewFileHistory %<CR>", opts)
