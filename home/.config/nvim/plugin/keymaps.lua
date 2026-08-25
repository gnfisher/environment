local set = vim.keymap.set
local opts = { noremap = true, silent = true }

local function center_cursor()
  vim.cmd("normal! zz")
end

local function center_after(command)
  return function()
    command()
    center_cursor()
  end
end

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
set("n", "<leader>py", "<Cmd>CopyBufferPath<CR>", { silent = true, desc = "Copy absolute buffer path" })
set("n", "<leader>cL", "<Cmd>CopilotLintFix<CR>", { silent = true, desc = "Run Copilot lint-fix agent" })
set("x", "<leader>cL", ":CopilotLintFix<CR>", { silent = true, desc = "Run Copilot lint-fix agent for selection" })
set("n", "<leader>cp", function()
  require("custom.context").peek()
end, { silent = true, desc = "Peek code context" })
set("n", "<leader>cj", function()
  require("custom.context").jump()
end, { silent = true, desc = "Jump to code context" })

-- Center screen after built-in jump motions.
local centered_motions = {
  "<C-d>",
  "<C-u>",
  "<C-f>",
  "<C-b>",
  "<C-o>",
  "<C-i>",
  "<C-]>",
  "<C-t>",
  "n",
  "N",
  "*",
  "#",
  "g*",
  "g#",
  "%",
  ")",
  "(",
  "}",
  "{",
  "]]",
  "[[",
  "][",
  "[]",
  "''",
  "``",
  "g;",
  "g,",
  "gf",
  "gF",
  "[(",
  "])",
  "[{",
  "]}",
  "[m",
  "]m",
  "[M",
  "]M",
  "[s",
  "]s",
  "[z",
  "]z",
  "[#",
  "]#",
  "[*",
  "]*",
  "[/",
  "]/",
}

for _, motion in ipairs(centered_motions) do
  set("n", motion, motion .. "zz", opts)
end

vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = vim.api.nvim_create_augroup("center_after_search", { clear = true }),
  pattern = { "/", "?" },
  callback = function()
    vim.schedule(center_cursor)
  end,
})

set("n", "]c", center_after(function()
  vim.cmd.normal({ "]c", bang = true })
end), opts)
set("n", "[c", center_after(function()
  vim.cmd.normal({ "[c", bang = true })
end), opts)

set("n", "]d", center_after(function()
  vim.diagnostic.jump({ count = 1 })
end), opts)
set("n", "[d", center_after(function()
  vim.diagnostic.jump({ count = -1 })
end), opts)
set("n", "]e", center_after(function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end), opts)
set("n", "[e", center_after(function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end), opts)
set("n", "]w", center_after(function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
end), opts)
set("n", "[w", center_after(function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
end), opts)

set("n", "G", "Gzz", opts)
set("n", "gg", "ggzz", opts)

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

-- Quickfix/location-list jumps
set("n", "]q", center_after(function()
  vim.cmd.cnext()
end), opts)
set("n", "[q", center_after(function()
  vim.cmd.cprev()
end), opts)
set("n", "]l", center_after(function()
  vim.cmd.lnext()
end), opts)
set("n", "[l", center_after(function()
  vim.cmd.lprev()
end), opts)
