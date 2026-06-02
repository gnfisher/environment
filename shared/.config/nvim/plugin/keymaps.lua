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
set("n", "<leader>cr", "<Cmd>CopyCopilotRef<CR>", { silent = true, desc = "Copy Copilot line reference" })
set("x", "<leader>cr", ":CopyCopilotRef<CR>", { silent = true, desc = "Copy Copilot range reference" })
set("n", "<leader>cR", "<Cmd>CopyCopilotFileRef<CR>", { silent = true, desc = "Copy Copilot file reference" })
set("n", "<leader>cL", "<Cmd>CopilotLintFix<CR>", { silent = true, desc = "Run Copilot lint-fix agent" })
set("x", "<leader>cL", ":CopilotLintFix<CR>", { silent = true, desc = "Run Copilot lint-fix agent for selection" })
set("n", "<leader>cp", function()
  require("custom.context").peek()
end, { silent = true, desc = "Peek code context" })
set("n", "<leader>cj", function()
  require("custom.context").jump()
end, { silent = true, desc = "Jump to code context" })

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

local function reset_window_zoom()
  vim.t._zoom_winrestcmd = nil
  vim.t._zoom_direction = nil
end

local function restore_window_zoom_or_equalize()
  local cmd = vim.t._zoom_winrestcmd
  if cmd and cmd ~= "" then
    reset_window_zoom()
    vim.cmd(cmd)
  else
    vim.cmd("wincmd =")
  end
end

set("n", "<C-w>|", function()
  save_winlayout_once()
  vim.t._zoom_direction = "width"
  vim.cmd("wincmd |")
end, { silent = true, desc = "Maximize window width (save layout)" })

set("n", "<C-w>_", function()
  save_winlayout_once()
  vim.t._zoom_direction = "height"
  vim.cmd("wincmd _")
end, { silent = true, desc = "Maximize window height (save layout)" })

set("n", "<C-w>=", function()
  restore_window_zoom_or_equalize()
end, { silent = true, desc = "Restore saved window layout or equalize" })

local function toggle_window_zoom(direction)
  if vim.t._zoom_direction == direction then
    restore_window_zoom_or_equalize()
    return
  end

  save_winlayout_once()
  vim.t._zoom_direction = direction
  if direction == "width" then
    vim.cmd("wincmd |")
  else
    vim.cmd("wincmd _")
  end
end

set("n", "<F1>", function()
  toggle_window_zoom("width")
end, { silent = true, desc = "Toggle current window full/equal width" })

set("n", "<S-F1>", function()
  toggle_window_zoom("height")
end, { silent = true, desc = "Toggle current window full/equal height" })

-- Quickfix jump
set("n", "]q", "<Cmd>cnext<CR>zz", opts)
set("n", "[q", "<Cmd>cprev<CR>zz", opts)
