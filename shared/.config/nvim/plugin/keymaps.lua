local set = vim.keymap.set
local opts = { noremap = true, silent = true }

set("n", "<BS>", ":noh<CR>", opts)
set("n", "<C-space>", ":noh<CR>", opts)

set({ "i", "v" }, "<C-space>", "<Esc>", opts)


-- Paste from clipboard
set("x", "<Leader>p", [["_dP]], opts)

-- Yank to clipboard
set({ "n", "v" }, "<Leader>y", [["+y]], opts)
set("n", "<Leader>Y", [["+Y]], opts)

-- Move highlighted lines up/down
set("v", "J", ":m '>+1<CR>gv=gv", opts)
set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Center screen after jump motions
set("n", "<C-d>", "<C-d>zz", opts)
set("n", "<C-u>", "<C-u>zz", opts)
set("n", "<C-f>", "<C-f>zz", opts)
set("n", "<C-b>", "<C-b>zz", opts)
set("n", "n", "nzz", opts)
set("n", "N", "Nzz", opts)
set("n", "*", "*zz", opts)
set("n", "#", "#zz", opts)
set("n", "%", "%zz", opts)

-- Jump to line then scroll to top
set("n", "G", "Gzt", opts)
set("n", "gg", "ggzt", opts)

-- Window zoom: save layout when maximizing, and let <C-w>= restore it.
local function save_winlayout_once()
  if vim.t._zoom_winrestcmd == nil then
    vim.t._zoom_winrestcmd = vim.fn.winrestcmd()
  end
end

set("n", "<C-w>|", function()
  save_winlayout_once()
  vim.cmd("wincmd |")
end, { silent = true, desc = "Maximize window width (save layout)" })

set("n", "<C-w>_", function()
  save_winlayout_once()
  vim.cmd("wincmd _")
end, { silent = true, desc = "Maximize window height (save layout)" })

set("n", "<C-w>=", function()
  local cmd = vim.t._zoom_winrestcmd
  if cmd and cmd ~= "" then
    vim.t._zoom_winrestcmd = nil
    vim.cmd(cmd)
  else
    vim.cmd("wincmd =")
  end
end, { silent = true, desc = "Restore saved window layout or equalize" })

-- Quickfix jump
set("n", "]q", "<Cmd>cnext<CR>zz", opts)
set("n", "[q", "<Cmd>cprev<CR>zz", opts)


