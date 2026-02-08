local set = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.o.background = "dark"

set("n", "<F6>", function()
  if vim.o.background == "light" then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
end, opts)
