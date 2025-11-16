local opt = vim.opt

opt.splitright = true
opt.splitbelow = true

opt.number = true
opt.numberwidth = 1
opt.signcolumn = "yes"
opt.showtabline = 3

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.shiftround = true
opt.smartindent = true
opt.wrap = true

opt.mouse = "a"
opt.smoothscroll = true

opt.hlsearch = true
opt.incsearch = true

opt.swapfile = false
opt.backup = false
opt.undodir = "/tmp/undo-vim-dir/"
opt.undofile = true

opt.scrolloff = 3
opt.updatetime = 250

opt.path:append  "**"

opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"

opt.foldmethod = 'manual'
opt.foldenable = false
opt.foldlevel = 99

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

opt.title = true
opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'

opt.autoread = true

opt.laststatus = 3

-- opt.background = "dark"
-- vim.cmd.colorscheme("retrobox")

-- use ripgrep if its installed
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case --hidden --glob '!{node_modules,.git,dist,build}/*'"
  opt.grepformat = "%f:%l:%c:%m"
end
