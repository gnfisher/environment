-- tango-dark.lua
-- Neovim colorscheme based on Emacs tango-dark

local colors = {
  butter1 = "#fce94f", butter2 = "#edd400", butter3 = "#c4a000",
  orange1 = "#fcaf3e", orange2 = "#f57900", orange3 = "#ce5c00",
  choc1   = "#e9b96e", choc2   = "#c17d11", choc3   = "#8f5902",
  cham0   = "#b4fa70", cham1   = "#8ae234", cham2   = "#73d216", cham3   = "#4e9a06",
  blue0   = "#8cc4ff", blue1   = "#729fcf", blue2   = "#3465a4", blue3   = "#204a87",
  plum0   = "#e9b2e3", plum1   = "#e090d7", plum2   = "#75507b", plum3   = "#5c3566",
  red0    = "#ff4b4b", red1    = "#ef2929", red2    = "#cc0000", red3    = "#a40000",
  alum1   = "#eeeeec", alum2   = "#d3d7cf", alum3   = "#babdb6", alum4   = "#888a85",
  alum5   = "#555753", alum5_5 = "#41423f", alum6   = "#2e3436", alum7   = "#212526",
}

vim.cmd("highlight clear")
vim.cmd("set background=dark")
vim.g.colors_name = "tango-dark"

local function hi(group, opts)
  local cmd = "hi " .. group
  if opts.gui then cmd = cmd .. " gui=" .. opts.gui end
  if opts.fg then cmd = cmd .. " guifg=" .. opts.fg end
  if opts.bg then cmd = cmd .. " guibg=" .. opts.bg end
  if opts.sp then cmd = cmd .. " guisp=" .. opts.sp end
  vim.cmd(cmd)
end

-- UI
hi("Normal",      { fg=colors.alum1, bg=colors.alum6 })
hi("Cursor",      { bg=colors.butter1 })
hi("CursorLine",  { bg=colors.alum7 })
hi("Visual",      { bg=colors.alum5 })
hi("LineNr",      { fg=colors.alum4 })
hi("CursorLineNr",{ fg=colors.orange1, bg=colors.alum7 })
hi("StatusLine",  { fg=colors.alum1, bg=colors.alum5_5 })
hi("StatusLineNC",{ fg=colors.alum4, bg=colors.alum6 })
hi("VertSplit",   { fg=colors.alum5 })
hi("WinSeparator",{ fg=colors.alum5 })
hi("NormalFloat", { fg=colors.alum1, bg=colors.alum6 })
hi("FloatBorder", { fg=colors.alum5,  bg=colors.alum6 })
hi("FloatTitle",  { fg=colors.butter1, bg=colors.alum6 })
hi("Pmenu",       { fg=colors.alum1, bg=colors.alum6 })
hi("PmenuSel",    { fg=colors.alum6, bg=colors.butter2 })
hi("PmenuSbar",   { bg=colors.alum5 })
hi("PmenuThumb",  { bg=colors.alum4 })
hi("Search",      { fg=colors.alum1, bg=colors.orange3 })
hi("IncSearch",   { fg=colors.alum1, bg=colors.orange3 })
hi("MatchParen",  { bg=colors.cham0 })

-- Syntax
hi("Comment",     { fg=colors.cham2 })
hi("Constant",    { fg=colors.plum0 })
hi("String",      { fg=colors.choc1 })
hi("Character",   { fg=colors.choc1 })
hi("Number",      { fg=colors.plum0 })
hi("Boolean",     { fg=colors.plum0 })
hi("Identifier",  { fg=colors.orange1 })
hi("Function",    { fg=colors.butter1 })
hi("Statement",   { fg=colors.cham0 })
hi("Conditional", { fg=colors.cham0 })
hi("Repeat",      { fg=colors.cham0 })
hi("Label",       { fg=colors.butter1 })
hi("Operator",    { fg=colors.cham0 })
hi("Keyword",     { fg=colors.cham0 })
hi("PreProc",     { fg=colors.plum1 })
hi("Type",        { fg=colors.blue0 })
hi("Special",     { fg=colors.orange1 })
hi("Underlined",  { fg=colors.blue1, gui="underline" })
hi("Error",       { fg=colors.red0 })
hi("Todo",        { fg=colors.orange1, bg=colors.alum7 })

-- Diagnostics (for LSP)
hi("DiagnosticError", { fg=colors.red0 })
hi("DiagnosticWarn",  { fg=colors.orange1 })
hi("DiagnosticInfo",  { fg=colors.blue1 })
hi("DiagnosticHint",  { fg=colors.cham1 })

-- Diagnostic underlines in text
hi("DiagnosticUnderlineError", { gui="underline", sp=colors.red0 })
hi("DiagnosticUnderlineWarn",  { gui="NONE" })
hi("DiagnosticUnderlineInfo",  { gui="NONE" })
hi("DiagnosticUnderlineHint",  { gui="NONE" })

-- Diffs
hi("DiffAdd",    { bg=colors.cham3 })
hi("DiffChange", { bg=colors.blue3 })
hi("DiffDelete", { bg=colors.red3 })
hi("DiffText",   { bg=colors.butter2 })

-- Links/underlines
hi("Title",      { fg=colors.butter1 })
hi("Directory",  { fg=colors.blue1 })
hi("Link",       { fg=colors.blue1, gui="underline" })
hi("VisualNOS",  { bg=colors.blue3 })

-- You can add more highlight groups as needed

-- Floating UIs for common plugins
-- Telescope
hi("TelescopeNormal",        { fg=colors.alum1, bg=colors.alum6 })
hi("TelescopeBorder",        { fg=colors.alum5, bg=colors.alum6 })
hi("TelescopeTitle",         { fg=colors.alum6, bg=colors.butter2 })
hi("TelescopeSelection",     { fg=colors.butter1, bg=colors.alum5 })
hi("TelescopeSelectionCaret",{ fg=colors.butter2, bg=colors.alum5 })
hi("TelescopePromptNormal",  { fg=colors.alum1, bg=colors.alum6 })
hi("TelescopePromptBorder",  { fg=colors.alum5, bg=colors.alum6 })
hi("TelescopePromptTitle",   { fg=colors.alum6, bg=colors.butter2 })
hi("TelescopeResultsNormal", { fg=colors.alum1, bg=colors.alum6 })
hi("TelescopeResultsBorder", { fg=colors.alum5, bg=colors.alum6 })
hi("TelescopeResultsTitle",  { fg=colors.alum6, bg=colors.blue2 })
hi("TelescopePreviewNormal", { fg=colors.alum1, bg=colors.alum6 })
hi("TelescopePreviewBorder", { fg=colors.alum5, bg=colors.alum6 })
hi("TelescopePreviewTitle",  { fg=colors.alum6, bg=colors.cham1 })

-- Lazy.nvim
hi("LazyNormal",  { fg=colors.alum1, bg=colors.alum6 })
hi("LazyBorder",  { fg=colors.alum5,  bg=colors.alum6 })
hi("LazyH1",      { fg=colors.alum6,  bg=colors.butter2 })
hi("LazyButton",  { fg=colors.alum1,  bg=colors.alum6 })
hi("LazyButtonActive", { fg=colors.alum6, bg=colors.butter2 })

-- nvim-tree floating window
hi("NvimTreeNormalFloat", { fg=colors.alum1, bg=colors.alum6 })
hi("NvimTreeWinSeparator",{ fg=colors.alum5,  bg=colors.alum6 })

-- WhichKey
hi("WhichKeyFloat",  { bg=colors.alum6 })
hi("WhichKeyBorder", { fg=colors.alum5, bg=colors.alum6 })

-- Creative lualine theme using full tango color palette
local M = {}
M.normal = {
  a = { fg = colors.alum7, bg = colors.cham1, gui = 'bold' },
  b = { fg = colors.cham0, bg = colors.alum5 },
  c = { fg = colors.butter2, bg = colors.alum6 },
}
M.insert = {
  a = { fg = colors.alum1, bg = colors.blue2, gui = 'bold' },
  b = { fg = colors.blue0, bg = colors.alum5 },
  c = { fg = colors.blue1, bg = colors.alum6 },
}
M.visual = {
  a = { fg = colors.alum7, bg = colors.orange1, gui = 'bold' },
  b = { fg = colors.orange2, bg = colors.alum5 },
  c = { fg = colors.choc1, bg = colors.alum6 },
}
M.replace = {
  a = { fg = colors.alum1, bg = colors.red2, gui = 'bold' },
  b = { fg = colors.red0, bg = colors.alum5 },
  c = { fg = colors.orange1, bg = colors.alum6 },
}
M.command = {
  a = { fg = colors.alum1, bg = colors.plum2, gui = 'bold' },
  b = { fg = colors.plum0, bg = colors.alum5 },
  c = { fg = colors.plum1, bg = colors.alum6 },
}
M.terminal = {
  a = { fg = colors.alum7, bg = colors.butter3, gui = 'bold' },
  b = { fg = colors.butter1, bg = colors.alum5 },
  c = { fg = colors.butter2, bg = colors.alum6 },
}
M.inactive = {
  a = { fg = colors.alum3, bg = colors.alum5_5 },
  b = { fg = colors.alum4, bg = colors.alum6 },
  c = { fg = colors.alum4, bg = colors.alum7 },
}

-- Make theme globally available for lualine
vim.g.tango_dark_lualine_theme = M

-- Set terminal colors (optional)
vim.g.terminal_color_0  = colors.alum7
vim.g.terminal_color_1  = colors.red0
vim.g.terminal_color_2  = colors.cham0
vim.g.terminal_color_3  = colors.butter1
vim.g.terminal_color_4  = colors.blue1
vim.g.terminal_color_5  = colors.plum1
vim.g.terminal_color_6  = colors.blue0
vim.g.terminal_color_7  = colors.alum1
