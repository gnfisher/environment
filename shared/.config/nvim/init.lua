vim.loader.enable()

vim.g.mapleader = " "

vim.opt.background = "dark"

-- Folding (treesitter-based, LazyVim style)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

if vim.g.vscode then
  -- VSCode extension
  -- I guess you have to grow up and murder the dreams of childhood eventually.
else
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    spec = "plugins",
    change_detection = { notify = false }
  })
end
