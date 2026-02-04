local set = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.o.background = "dark"
vim.cmd.colorscheme("tango-dark")

set("n", "<F6>", function()
  if vim.o.background == "light" then
    vim.o.background = "dark"
    vim.cmd.colorscheme("tango-dark")
  else
    vim.o.background = "light"
    vim.cmd.colorscheme("solarized")
  end
end, opts)
