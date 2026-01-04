local set = vim.keymap.set
local opts = { noremap = true, silent = true }

set("n", "<C-space>", ":noh<CR>", opts)

set({"i", "v"}, "<C-space>", "<Esc>", opts)


-- Paste from clipboard
set("x", "<Leader>p", [["_dP]], opts)

-- Yank to clipboard
set({ "n", "v" }, "<Leader>y", [["+y]], opts)
set("n", "<Leader>Y", [["+Y]], opts)

-- Move highlighted lines up/down
set("v", "J", ":m '>+1<CR>gv=gv", opts)
set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Quickfix jump
set("n", "]q", "<Cmd>cnext<CR>zz", opts)
set("n", "[q", "<Cmd>cprev<CR>zz", opts)

-- Toggle dark/light theme
set("n", "<F6>", function()
  if vim.o.background == "light" then
    vim.o.background = "dark"
    vim.cmd.colorscheme("tomorrow-night-blue")
  else
    vim.o.background = "light"
    vim.cmd.colorscheme("zellner")
  end
end, opts)
