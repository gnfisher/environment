local set = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.o.background = "light"

set("n", "<F6>", function()
  if vim.o.background == "light" then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
  -- Re-apply colorscheme so it picks up the new background
  vim.cmd.colorscheme(vim.g.colors_name)
end, opts)
