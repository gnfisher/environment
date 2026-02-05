local set = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.o.background = "dark"
vim.cmd.colorscheme("onedark")

set("n", "<F6>", function()
  local onedark = require("onedark")
  if vim.o.background == "light" then
    vim.o.background = "dark"
    onedark.setup({ style = "dark" })
  else
    vim.o.background = "light"
    onedark.setup({ style = "light" })
  end
  onedark.load()
end, opts)
