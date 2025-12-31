local set = vim.opt_local

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", {}),
  callback = function()
    set.number = false
    set.relativenumber = false
    set.scrolloff = 0

    vim.bo.filetype = "terminal"
  end,
})

-- Easily hit escape in terminal mode.
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", "<Leader>st", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end)

-- Open a terminal in a vertical split on the right at ~33% width.
vim.keymap.set("n", "<Leader>vt", function()
  vim.cmd.vnew()
  vim.cmd.wincmd "L"
  vim.api.nvim_win_set_width(0, math.floor(vim.o.columns / 3))
  vim.wo.winfixwidth = true
  vim.cmd.term()
end)
