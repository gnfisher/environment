vim.g.mapleader = " "
vim.o.number = true
vim.o.numberwidth = 1
vim.o.signcolumn = "yes"
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.mouse = "a"
vim.o.smartindent = true
vim.o.wrap = true
vim.o.hlsearch = false
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.o.incsearch = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.o.undofile = true
vim.o.scrolloff = 8
vim.o.updatetime = 50
vim.o.autoread = true
vim.o.exrc = true
vim.o.secure = true
vim.o.path = "**"
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.o.wildoptions = "pum"
vim.opt.wildignore = {
  "*/node_modules/*",
  "*/.git/*",
  "*/dist/*",
  "*/build/*",
  "*.o",
  "*.obj",
  "*.pyc",
  "*.class",
  "*.swp",
  "*.tmp"
}

vim.opt.isfname:append("@-@")

if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --vimgrep --smart-case --hidden --glob '!{node_modules,.git,dist,build}/*'"
  vim.o.grepformat = "%f:%l:%c:%m"
elseif vim.fn.executable("ag") == 1 then
  vim.o.grepprg = "ag --vimgrep --smart-case --hidden --ignore node_modules --ignore .git --ignore dist --ignore build"
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

