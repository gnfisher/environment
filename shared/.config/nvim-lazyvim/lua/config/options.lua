-- Options
local opt = vim.opt

-- Your preferred defaults
opt.background = "light"

-- Window splits
opt.splitright = true
opt.splitbelow = true

-- Line numbers
opt.number = true
opt.numberwidth = 1
opt.signcolumn = "yes"
opt.cursorline = true

-- Tabs and indentation (2 spaces like your config)
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.shiftround = true
opt.smartindent = true

-- Line wrapping
opt.wrap = true
opt.smoothscroll = true

-- Search
opt.hlsearch = true
opt.incsearch = true

-- No swap files, use undo
opt.swapfile = false
opt.backup = false
opt.undodir = "/tmp/undo-vim-dir/"
opt.undofile = true

-- Scrolling
opt.scrolloff = 3
opt.updatetime = 250

-- Command line
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"

-- Folding (manual, disabled)
opt.foldmethod = "manual"
opt.foldenable = false
opt.foldlevel = 99

-- Status line (global)
opt.laststatus = 3

-- Title
opt.title = true
opt.titlestring = "%t%( %M%)%( (%{expand('%:~:h')})%)%a (nvim)"

-- Auto read files
opt.autoread = true

-- Ignore patterns
opt.wildignore = {
  "*/node_modules/*",
  "*/.git/*",
  "*/dist/*",
  "*/build/*",
  "*.o",
  "*.obj",
  "*.pyc",
  "*.class",
  "*.swp",
  "*.tmp",
}

-- Use ripgrep if available
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case --hidden --glob '!{node_modules,.git,dist,build}/*'"
  opt.grepformat = "%f:%l:%c:%m"
end

-- Disable LazyVim's auto format (we'll control this manually)
vim.g.autoformat = false
