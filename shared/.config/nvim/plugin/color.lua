local set = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.o.background = "dark"

set("n", "<F6>", function()
  if vim.o.background == "light" then
    vim.o.background = "dark"
    vim.cmd.colorscheme("github_dark_dimmed")
  else
    vim.o.background = "light"
    vim.cmd.colorscheme("github_light")
  end
end, opts)
