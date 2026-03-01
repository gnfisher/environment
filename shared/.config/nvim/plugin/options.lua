local opt = vim.opt

opt.termguicolors = true

opt.splitright = true
opt.splitbelow = true

opt.number = true
opt.numberwidth = 5
opt.signcolumn = "yes"
opt.showtabline = 2

-- Custom tabline with better names for oil and terminal buffers
function _G.custom_tabline()
  local s = ""
  for tabnr = 1, vim.fn.tabpagenr("$") do
    local winnr = vim.fn.tabpagewinnr(tabnr)
    local bufnr = vim.fn.tabpagebuflist(tabnr)[winnr]
    local bufname = vim.fn.bufname(bufnr)
    local buftype = vim.fn.getbufvar(bufnr, "&buftype")
    local label

    if bufname:match("^oil://") then
      -- Oil buffer: show just the directory name
      local path = bufname:gsub("oil://", "")
      label = "/" .. vim.fn.fnamemodify(path, ":t")
    elseif buftype == "terminal" then
      -- Terminal buffer: extract term name or use "term"
      local term_title = vim.fn.getbufvar(bufnr, "term_title")
      if term_title and term_title ~= "" then
        -- Get just the command name (first word after any path)
        label = "term:" .. vim.fn.fnamemodify(term_title, ":t"):gsub("^(%S+).*", "%1")
      else
        label = "term"
      end
    elseif bufname == "" then
      label = "[No Name]"
    else
      label = vim.fn.fnamemodify(bufname, ":t")
    end

    -- Highlight current tab
    if tabnr == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end
    s = s .. " " .. label .. " "
  end
  s = s .. "%#TabLineFill#"
  return s
end

vim.opt.tabline = "%!v:lua.custom_tabline()"
opt.cursorline = true
opt.cursorcolumn = true

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

opt.path:append "**"

opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"

-- Folding managed by nvim-ufo
opt.foldlevelstart = 99
opt.foldenable = true

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

-- use ripgrep if its installed
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case --hidden --glob '!{node_modules,.git,dist,build}/*'"
  opt.grepformat = "%f:%l:%c:%m"
end

-- Set the colorscheme
-- vim.cmd.colorscheme "github_modern"
-- vim.cmd.colorscheme "tango-dark"
