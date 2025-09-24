-- solarized-dark.lua
-- Neovim colorscheme based on Solarized Dark by Ethan Schoonover

local colors = {
  base03  = "#002b36", -- background highlights
  base02  = "#073642", -- background
  base01  = "#586e75", -- optional emphasized content
  base00  = "#657b83", -- primary content
  base0   = "#839496", -- body text / default code / primary content
  base1   = "#93a1a1", -- comments / secondary content
  base2   = "#eee8d5", -- background highlights (light)
  base3   = "#fdf6e3", -- background (light)
  yellow  = "#b58900",
  orange  = "#cb4b16",
  red     = "#dc322f",
  magenta = "#d33682",
  violet  = "#6c71c4",
  blue    = "#268bd2",
  cyan    = "#2aa198",
  green   = "#859900",
}

vim.cmd("highlight clear")
vim.cmd("set background=dark")
vim.g.colors_name = "solarized-dark"

local function hi(group, opts)
  local cmd = "hi " .. group
  if opts.gui then cmd = cmd .. " gui=" .. opts.gui end
  if opts.fg then cmd = cmd .. " guifg=" .. opts.fg end
  if opts.bg then cmd = cmd .. " guibg=" .. opts.bg end
  if opts.sp then cmd = cmd .. " guisp=" .. opts.sp end
  vim.cmd(cmd)
end

-- Core UI
hi("Normal",        { fg=colors.base0, bg=colors.base03 })
hi("NormalNC",      { fg=colors.base0, bg=colors.base03 })
hi("Cursor",        { fg=colors.base03, bg=colors.base0 })
hi("CursorLine",    { bg=colors.base02 })
hi("CursorColumn",  { bg=colors.base02 })
hi("Visual",        { bg=colors.base02 })
hi("VisualNOS",     { bg=colors.base02 })
hi("LineNr",        { fg=colors.base01, bg=colors.base03 })
hi("CursorLineNr",  { fg=colors.base0,  bg=colors.base02 })
hi("StatusLine",    { fg=colors.base1,  bg=colors.base02 })
hi("StatusLineNC",  { fg=colors.base01, bg=colors.base02 })
hi("VertSplit",     { fg=colors.base01, bg=colors.base01 })
hi("WinSeparator",  { fg=colors.base01 })

-- Floating UI + menus
hi("NormalFloat",   { fg=colors.base0, bg=colors.base03 })
hi("FloatBorder",   { fg=colors.base01, bg=colors.base03 })
hi("FloatTitle",    { fg=colors.base03, bg=colors.yellow })
hi("Pmenu",         { fg=colors.base0, bg=colors.base03 })
hi("PmenuSel",      { fg=colors.base03, bg=colors.yellow })
hi("PmenuSbar",     { bg=colors.base02 })
hi("PmenuThumb",    { bg=colors.base01 })

hi("Search",        { fg=colors.base03, bg=colors.yellow })
hi("IncSearch",     { fg=colors.orange, bg=colors.base03, gui="reverse" })
hi("MatchParen",    { fg=colors.red, bg=colors.base01, gui="bold" })
hi("Folded",        { fg=colors.base0, bg=colors.base02, gui="bold" })
hi("FoldColumn",    { fg=colors.base0, bg=colors.base02 })
hi("ColorColumn",   { bg=colors.base02 })
hi("SignColumn",    { fg=colors.base01, bg=colors.base03 })

-- Syntax
hi("Comment",       { fg=colors.base01, gui="italic" })
hi("Constant",      { fg=colors.cyan })
hi("String",        { fg=colors.cyan })
hi("Character",     { fg=colors.cyan })
hi("Number",        { fg=colors.cyan })
hi("Boolean",       { fg=colors.cyan })
hi("Float",         { fg=colors.cyan })
hi("Identifier",    { fg=colors.blue })
hi("Function",      { fg=colors.blue })
hi("Statement",     { fg=colors.green })
hi("Conditional",   { fg=colors.green })
hi("Repeat",        { fg=colors.green })
hi("Label",         { fg=colors.green })
hi("Operator",      { fg=colors.green })
hi("Keyword",       { fg=colors.green })
hi("Exception",     { fg=colors.green })
hi("PreProc",       { fg=colors.orange })
hi("Include",       { fg=colors.orange })
hi("Define",        { fg=colors.orange })
hi("Macro",         { fg=colors.orange })
hi("PreCondit",     { fg=colors.orange })
hi("Type",          { fg=colors.yellow })
hi("StorageClass",  { fg=colors.yellow })
hi("Structure",     { fg=colors.yellow })
hi("Typedef",       { fg=colors.yellow })
hi("Special",       { fg=colors.red })
hi("SpecialChar",   { fg=colors.red })
hi("Tag",           { fg=colors.red })
hi("Delimiter",     { fg=colors.red })
hi("SpecialComment",{ fg=colors.red })
hi("Debug",         { fg=colors.red })
hi("Underlined",    { fg=colors.violet, gui="underline" })
hi("Ignore",        { fg=colors.base01 })
hi("Error",         { fg=colors.red, gui="bold" })
hi("Todo",          { fg=colors.magenta, gui="bold" })

-- Diagnostics (for LSP)
hi("DiagnosticError", { fg=colors.red })
hi("DiagnosticWarn",  { fg=colors.orange })
hi("DiagnosticInfo",  { fg=colors.blue })
hi("DiagnosticHint",  { fg=colors.base01 })

-- Diagnostic underlines
hi("DiagnosticUnderlineError", { gui="underline", sp=colors.red })
hi("DiagnosticUnderlineWarn",  { gui="underline", sp=colors.orange })
hi("DiagnosticUnderlineInfo",  { gui="underline", sp=colors.blue })
hi("DiagnosticUnderlineHint",  { gui="underline", sp=colors.base01 })

-- Diffs
hi("DiffAdd",       { fg=colors.green,  bg=colors.base02 })
hi("DiffChange",    { fg=colors.yellow, bg=colors.base02 })
hi("DiffDelete",    { fg=colors.red,    bg=colors.base02 })
hi("DiffText",      { fg=colors.blue,   bg=colors.base02 })

-- Git signs
hi("GitSignsAdd",    { fg=colors.green,  bg=colors.base03 })
hi("GitSignsChange", { fg=colors.yellow, bg=colors.base03 })
hi("GitSignsDelete", { fg=colors.red,    bg=colors.base03 })

-- Directory and links
hi("Title",         { fg=colors.orange })
hi("Directory",     { fg=colors.blue })
hi("Link",          { fg=colors.violet, gui="underline" })

-- Treesitter
hi("@comment",      { fg=colors.base01, gui="italic" })
hi("@keyword",      { fg=colors.green })
hi("@string",       { fg=colors.cyan })
hi("@number",       { fg=colors.cyan })
hi("@boolean",      { fg=colors.cyan })
hi("@function",     { fg=colors.blue })
hi("@method",       { fg=colors.blue })
hi("@type",         { fg=colors.yellow })
hi("@variable",     { fg=colors.base0 })
hi("@constant",     { fg=colors.cyan })

-- Telescope (complete float styling)
hi("TelescopeNormal",         { fg=colors.base0, bg=colors.base03 })
hi("TelescopeBorder",         { fg=colors.base01, bg=colors.base03 })
hi("TelescopeTitle",          { fg=colors.base03, bg=colors.yellow })
hi("TelescopePromptNormal",   { fg=colors.base0, bg=colors.base03 })
hi("TelescopePromptBorder",   { fg=colors.cyan,  bg=colors.base03 })
hi("TelescopePromptTitle",    { fg=colors.base03, bg=colors.cyan })
hi("TelescopeResultsNormal",  { fg=colors.base0, bg=colors.base03 })
hi("TelescopeResultsBorder",  { fg=colors.base01, bg=colors.base03 })
hi("TelescopeResultsTitle",   { fg=colors.base03, bg=colors.blue })
hi("TelescopePreviewNormal",  { fg=colors.base0, bg=colors.base03 })
hi("TelescopePreviewBorder",  { fg=colors.base01, bg=colors.base03 })
hi("TelescopePreviewTitle",   { fg=colors.base03, bg=colors.green })
hi("TelescopeSelection",      { fg=colors.base0, bg=colors.base01 })
hi("TelescopeSelectionCaret", { fg=colors.red, bg=colors.base01 })
hi("TelescopeMatching",       { fg=colors.yellow })

-- Lazy.nvim
hi("LazyNormal",    { fg=colors.base0,  bg=colors.base03 })
hi("LazyBorder",    { fg=colors.base01, bg=colors.base03 })
hi("LazyH1",        { fg=colors.base03, bg=colors.yellow })
hi("LazyButton",    { fg=colors.base0,  bg=colors.base03 })
hi("LazyButtonActive", { fg=colors.base03, bg=colors.yellow })

-- nvim-tree floating window
hi("NvimTreeNormalFloat", { fg=colors.base0, bg=colors.base03 })
hi("NvimTreeWinSeparator",{ fg=colors.base01, bg=colors.base03 })

-- WhichKey
hi("WhichKeyFloat",  { bg=colors.base03 })
hi("WhichKeyBorder", { fg=colors.base01, bg=colors.base03 })

-- Lualine theme configuration
local M = {}
M.normal = {
  a = { fg = colors.base03, bg = colors.blue, gui = 'bold' },
  b = { fg = colors.base0,  bg = colors.base02 },
  c = { fg = colors.base01, bg = colors.base03 },
}
M.insert = {
  a = { fg = colors.base03, bg = colors.green, gui = 'bold' },
  b = { fg = colors.base0,  bg = colors.base02 },
  c = { fg = colors.base01, bg = colors.base03 },
}
M.visual = {
  a = { fg = colors.base03, bg = colors.magenta, gui = 'bold' },
  b = { fg = colors.base0,  bg = colors.base02 },
  c = { fg = colors.base01, bg = colors.base03 },
}
M.replace = {
  a = { fg = colors.base03, bg = colors.red, gui = 'bold' },
  b = { fg = colors.base0,  bg = colors.base02 },
  c = { fg = colors.base01, bg = colors.base03 },
}
M.command = {
  a = { fg = colors.base03, bg = colors.yellow, gui = 'bold' },
  b = { fg = colors.base0,  bg = colors.base02 },
  c = { fg = colors.base01, bg = colors.base03 },
}
M.terminal = {
  a = { fg = colors.base03, bg = colors.cyan, gui = 'bold' },
  b = { fg = colors.base0,  bg = colors.base02 },
  c = { fg = colors.base01, bg = colors.base03 },
}
M.inactive = {
  a = { fg = colors.base01, bg = colors.base02 },
  b = { fg = colors.base01, bg = colors.base02 },
  c = { fg = colors.base01, bg = colors.base03 },
}

-- Make theme globally available for lualine
vim.g.solarized_dark_lualine_theme = M

-- Set terminal colors
vim.g.terminal_color_0  = colors.base02
vim.g.terminal_color_1  = colors.red
vim.g.terminal_color_2  = colors.green
vim.g.terminal_color_3  = colors.yellow
vim.g.terminal_color_4  = colors.blue
vim.g.terminal_color_5  = colors.magenta
vim.g.terminal_color_6  = colors.cyan
vim.g.terminal_color_7  = colors.base2
vim.g.terminal_color_8  = colors.base03
vim.g.terminal_color_9  = colors.orange
vim.g.terminal_color_10 = colors.base01
