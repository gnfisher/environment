vim.g.mapleader = " "

vim.o.autoread = true

-- vim.opt.isfname:append("@-@")

if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --vimgrep --smart-case --hidden --glob '!{node_modules,.git,dist,build}/*'"
  vim.o.grepformat = "%f:%l:%c:%m"
end

vim.api.nvim_create_autocmd("BufWritePre", {
  command = [[%s/\s\+$//e]],
  group = vim.api.nvim_create_augroup("trim_whitespace", {}),
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function(args)
    vim.keymap.set("n", "gq", function()
      vim.cmd("quit")
    end, {
      buffer = args.buf,
      desc = "Close help window"
    })
  end,
})

-- Auto style markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = ""
    vim.opt_local.textwidth = 80
    -- Format options:
    -- t = auto-wrap text using textwidth
    -- c = auto-wrap comments
    -- q = allow formatting with gq
    -- l = don't break lines that are already long when entering insert mode
    -- n = recognize numbered lists
    -- j = remove comment leader when joining lines (if supported)
    vim.opt_local.formatoptions = "tcqln"
  end,
})

vim.o.laststatus = 3

vim.o.background = "dark"
vim.cmd.colorscheme("retrobox")
