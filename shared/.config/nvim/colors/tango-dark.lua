-- tango-dark.lua
-- Neovim colorscheme based on Emacs tango-dark (standalone)

local colors = {
  butter1 = "#fce94f", butter2 = "#edd400", butter3 = "#c4a000",
  orange1 = "#fcaf3e", orange2 = "#f57900", orange3 = "#ce5c00",
  choc1   = "#e9b96e", choc2   = "#c17d11", choc3   = "#8f5902",
  cham0   = "#b4fa70", cham1   = "#8ae234", cham2   = "#73d216", cham3 = "#4e9a06",
  blue0   = "#8cc4ff", blue1   = "#729fcf", blue2   = "#3465a4", blue3 = "#204a87",
  plum0   = "#e9b2e3", plum1   = "#e090d7", plum2   = "#75507b", plum3 = "#5c3566",
  red0    = "#ff4b4b", red1    = "#ef2929", red2    = "#cc0000", red3  = "#a40000",
  alum1   = "#eeeeec", alum2   = "#d3d7cf", alum3   = "#babdb6", alum4 = "#888a85",
  alum5   = "#555753", alum5_5 = "#41423f", alum6   = "#2e3436", alum7 = "#212526",
}

local diff = {
  add = "#3b4a32",
  delete = "#4a3131",
  change = "#3b4f36",
  text = "#4f6f48",
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

-- Core UI
hi("Normal",        { fg = colors.alum1, bg = colors.alum6 })
hi("NormalNC",      { fg = colors.alum1, bg = colors.alum6 })
hi("Cursor",        { fg = colors.alum6, bg = colors.butter1 })
hi("CursorLine",    { bg = colors.alum7 })
hi("CursorColumn",  { bg = colors.alum7 })
hi("ColorColumn",   { bg = colors.alum7 })
hi("Visual",        { bg = colors.alum5 })
hi("VisualNOS",     { bg = colors.blue3 })
hi("LineNr",        { fg = colors.alum4, bg = colors.alum6 })
hi("CursorLineNr",  { fg = colors.orange1, bg = colors.alum7, gui = "bold" })
hi("SignColumn",    { fg = colors.alum4, bg = colors.alum6 })
hi("Folded",        { fg = colors.alum3, bg = colors.alum5_5, gui = "bold" })
hi("FoldColumn",    { fg = colors.alum4, bg = colors.alum6 })
hi("WinSeparator",  { fg = colors.alum5, bg = colors.alum6 })
hi("VertSplit",     { fg = colors.alum5, bg = colors.alum6 })
hi("StatusLine",    { fg = colors.alum1, bg = colors.blue3, gui = "bold" })
hi("StatusLineNC",  { fg = colors.alum4, bg = colors.alum5_5 })
hi("StatusLineTerm",   { fg = colors.alum1, bg = colors.plum2, gui = "bold" })
hi("StatusLineTermNC", { fg = colors.alum4, bg = colors.alum6 })
hi("TabLine",       { fg = colors.alum4, bg = colors.alum6 })
hi("TabLineFill",   { fg = colors.alum4, bg = colors.alum6 })
hi("TabLineSel",    { fg = colors.alum1, bg = colors.alum5, gui = "bold" })
hi("Pmenu",         { fg = colors.alum1, bg = colors.alum5_5 })
hi("PmenuSel",      { fg = colors.alum7, bg = colors.butter2, gui = "bold" })
hi("PmenuSbar",     { bg = colors.alum5 })
hi("PmenuThumb",    { bg = colors.alum3 })
hi("NormalFloat",   { fg = colors.alum1, bg = colors.alum6 })
hi("FloatBorder",   { fg = colors.alum5, bg = colors.alum6 })
hi("FloatTitle",    { fg = colors.butter1, bg = colors.alum6, gui = "bold" })
hi("Search",        { fg = colors.alum7, bg = colors.orange1 })
hi("IncSearch",     { fg = colors.alum7, bg = colors.orange2, gui = "bold" })
hi("MatchParen",    { fg = colors.alum7, bg = colors.cham0, gui = "bold" })
hi("NonText",       { fg = colors.alum5 })
hi("Whitespace",    { fg = colors.alum5 })
hi("EndOfBuffer",   { fg = colors.alum6 })
hi("Directory",     { fg = colors.blue1, gui = "bold" })
hi("Title",         { fg = colors.butter1, gui = "bold" })
hi("ErrorMsg",      { fg = colors.red0, gui = "bold" })
hi("WarningMsg",    { fg = colors.orange1, gui = "bold" })
hi("MoreMsg",       { fg = colors.blue0, gui = "bold" })
hi("ModeMsg",       { fg = colors.cham0, gui = "bold" })
hi("Question",      { fg = colors.cham1, gui = "bold" })
hi("QuickFixLine",  { bg = colors.alum5_5 })
hi("Conceal",       { fg = colors.blue1 })
hi("SpecialKey",    { fg = colors.alum4 })

-- Spelling
hi("SpellBad",   { gui = "undercurl", sp = colors.red0 })
hi("SpellCap",   { gui = "undercurl", sp = colors.blue0 })
hi("SpellLocal", { gui = "undercurl", sp = colors.cham1 })
hi("SpellRare",  { gui = "undercurl", sp = colors.plum1 })

-- Syntax
hi("Comment",      { fg = colors.cham2, gui = "italic" })
hi("Constant",     { fg = colors.plum0 })
hi("String",       { fg = colors.choc1 })
hi("Character",    { fg = colors.choc1 })
hi("Number",       { fg = colors.plum0 })
hi("Boolean",      { fg = colors.plum0 })
hi("Float",        { fg = colors.plum0 })
hi("Identifier",   { fg = colors.orange1 })
hi("Function",     { fg = colors.butter1, gui = "bold" })
hi("Statement",    { fg = colors.cham0, gui = "bold" })
hi("Conditional",  { fg = colors.cham0, gui = "bold" })
hi("Repeat",       { fg = colors.cham0, gui = "bold" })
hi("Label",        { fg = colors.butter1, gui = "bold" })
hi("Operator",     { fg = colors.cham0, gui = "bold" })
hi("Keyword",      { fg = colors.cham0, gui = "bold" })
hi("Exception",    { fg = colors.cham0, gui = "bold" })
hi("PreProc",      { fg = colors.plum1, gui = "bold" })
hi("Include",      { fg = colors.plum1, gui = "bold" })
hi("Define",       { fg = colors.plum1, gui = "bold" })
hi("Macro",        { fg = colors.plum1, gui = "bold" })
hi("PreCondit",    { fg = colors.plum1, gui = "bold" })
hi("Type",         { fg = colors.blue0, gui = "bold" })
hi("StorageClass", { fg = colors.blue0, gui = "bold" })
hi("Structure",    { fg = colors.blue0, gui = "bold" })
hi("Typedef",      { fg = colors.blue0, gui = "bold" })
hi("Special",      { fg = colors.orange1, gui = "bold" })
hi("SpecialChar",  { fg = colors.orange1 })
hi("Tag",          { fg = colors.orange2, gui = "bold" })
hi("Delimiter",    { fg = colors.alum2 })
hi("SpecialComment", { fg = colors.plum1 })
hi("Debug",        { fg = colors.red1 })
hi("Underlined",   { fg = colors.blue1, gui = "underline" })
hi("Ignore",       { fg = colors.alum5 })
hi("Error",        { fg = colors.red0, gui = "bold" })
hi("Todo",         { fg = colors.orange1, bg = colors.alum7, gui = "bold" })

-- Diagnostics
hi("DiagnosticError", { fg = colors.red0 })
hi("DiagnosticWarn",  { fg = colors.orange1 })
hi("DiagnosticInfo",  { fg = colors.blue1 })
hi("DiagnosticHint",  { fg = colors.cham1 })
hi("DiagnosticOk",    { fg = colors.cham0 })
hi("DiagnosticUnderlineError", { gui = "undercurl", sp = colors.red0 })
hi("DiagnosticUnderlineWarn",  { gui = "undercurl", sp = colors.orange1 })
hi("DiagnosticUnderlineInfo",  { gui = "undercurl", sp = colors.blue1 })
hi("DiagnosticUnderlineHint",  { gui = "undercurl", sp = colors.cham1 })
hi("LspReferenceText",  { bg = colors.alum5_5 })
hi("LspReferenceRead",  { bg = colors.alum5_5 })
hi("LspReferenceWrite", { bg = colors.alum5 })

-- Diffs
hi("DiffAdd",    { fg = colors.alum1, bg = diff.add })
hi("DiffChange", { fg = colors.alum1, bg = diff.change })
hi("DiffDelete", { fg = colors.alum1, bg = diff.delete })
hi("DiffText",   { fg = colors.alum1, bg = diff.text, gui = "bold" })

hi("diffAdded",   { fg = colors.cham1 })
hi("diffRemoved", { fg = colors.red1 })
hi("diffChanged", { fg = colors.cham0 })
hi("diffOldFile", { fg = colors.red1 })
hi("diffNewFile", { fg = colors.cham1 })
hi("diffFile",    { fg = colors.butter1 })
hi("diffLine",    { fg = colors.alum3 })

-- Git signs
hi("GitSignsAdd",    { fg = colors.cham1 })
hi("GitSignsChange", { fg = colors.cham0 })
hi("GitSignsDelete", { fg = colors.red1 })
hi("GitSignsAddNr",    { fg = colors.cham1 })
hi("GitSignsChangeNr", { fg = colors.cham0 })
hi("GitSignsDeleteNr", { fg = colors.red1 })
hi("GitSignsAddLn",    { bg = diff.add })
hi("GitSignsChangeLn", { bg = diff.change })
hi("GitSignsDeleteLn", { bg = diff.delete })

-- Treesitter
hi("@comment",   { fg = colors.cham2, gui = "italic" })
hi("@string",    { fg = colors.choc1 })
hi("@string.escape", { fg = colors.orange1 })
hi("@string.regex",  { fg = colors.orange2 })
hi("@number",    { fg = colors.plum0 })
hi("@float",     { fg = colors.plum0 })
hi("@boolean",   { fg = colors.plum0 })
hi("@character", { fg = colors.choc1 })
hi("@constant",  { fg = colors.plum0 })
hi("@constant.builtin", { fg = colors.plum1 })
hi("@constant.macro",   { fg = colors.plum1 })
hi("@variable",  { fg = colors.alum1 })
hi("@variable.builtin", { fg = colors.orange1 })
hi("@parameter", { fg = colors.alum2 })
hi("@field",     { fg = colors.orange1 })
hi("@property",  { fg = colors.orange1 })
hi("@function",  { fg = colors.butter1, gui = "bold" })
hi("@function.builtin", { fg = colors.butter2 })
hi("@function.call",    { fg = colors.butter1 })
hi("@method",    { fg = colors.butter1 })
hi("@method.call", { fg = colors.butter1 })
hi("@constructor", { fg = colors.blue0, gui = "bold" })
hi("@type",      { fg = colors.blue0, gui = "bold" })
hi("@type.builtin", { fg = colors.blue1 })
hi("@type.definition", { fg = colors.blue0 })
hi("@type.qualifier", { fg = colors.blue1 })
hi("@module",    { fg = colors.blue1 })
hi("@namespace", { fg = colors.blue1 })
hi("@keyword",   { fg = colors.cham0, gui = "bold" })
hi("@keyword.function", { fg = colors.cham0, gui = "bold" })
hi("@keyword.return",   { fg = colors.cham0, gui = "bold" })
hi("@keyword.operator", { fg = colors.cham0, gui = "bold" })
hi("@operator",  { fg = colors.cham0, gui = "bold" })
hi("@punctuation.delimiter", { fg = colors.alum2 })
hi("@punctuation.bracket",   { fg = colors.alum2 })
hi("@punctuation.special",   { fg = colors.orange1 })
hi("@tag",       { fg = colors.orange2, gui = "bold" })
hi("@tag.attribute", { fg = colors.orange1 })
hi("@tag.delimiter", { fg = colors.alum2 })
hi("@attribute", { fg = colors.plum1 })
hi("@label",     { fg = colors.butter1, gui = "bold" })

hi("@markup.heading", { fg = colors.butter1, gui = "bold" })
hi("@markup.link",    { fg = colors.blue1, gui = "underline" })
hi("@markup.link.url", { fg = colors.blue1, gui = "underline" })
hi("@markup.italic",  { gui = "italic" })
hi("@markup.bold",    { gui = "bold" })
hi("@markup.list",    { fg = colors.orange1 })
hi("@markup.quote",   { fg = colors.cham1 })
hi("@markup.raw",     { fg = colors.blue0 })
hi("@markup.raw.block", { fg = colors.blue0 })

hi("@diff.plus",  { fg = colors.cham1 })
hi("@diff.minus", { fg = colors.red1 })
hi("@diff.delta", { fg = colors.cham0 })

-- Telescope
hi("TelescopeNormal",         { fg = colors.alum1, bg = colors.alum6 })
hi("TelescopeBorder",         { fg = colors.alum5, bg = colors.alum6 })
hi("TelescopeTitle",          { fg = colors.alum6, bg = colors.butter2, gui = "bold" })
hi("TelescopeSelection",      { fg = colors.butter1, bg = colors.alum5, gui = "bold" })
hi("TelescopeSelectionCaret", { fg = colors.butter2, bg = colors.alum5, gui = "bold" })
hi("TelescopePromptNormal",   { fg = colors.alum1, bg = colors.alum6 })
hi("TelescopePromptBorder",   { fg = colors.alum5, bg = colors.alum6 })
hi("TelescopePromptTitle",    { fg = colors.alum6, bg = colors.butter2, gui = "bold" })
hi("TelescopeResultsNormal",  { fg = colors.alum1, bg = colors.alum6 })
hi("TelescopeResultsBorder",  { fg = colors.alum5, bg = colors.alum6 })
hi("TelescopeResultsTitle",   { fg = colors.alum6, bg = colors.blue2, gui = "bold" })
hi("TelescopePreviewNormal",  { fg = colors.alum1, bg = colors.alum6 })
hi("TelescopePreviewBorder",  { fg = colors.alum5, bg = colors.alum6 })
hi("TelescopePreviewTitle",   { fg = colors.alum6, bg = colors.cham1, gui = "bold" })

-- Lazy.nvim
hi("LazyNormal",       { fg = colors.alum1, bg = colors.alum6 })
hi("LazyBorder",       { fg = colors.alum5, bg = colors.alum6 })
hi("LazyH1",           { fg = colors.alum6, bg = colors.butter2, gui = "bold" })
hi("LazyButton",       { fg = colors.alum1, bg = colors.alum6 })
hi("LazyButtonActive", { fg = colors.alum6, bg = colors.butter2, gui = "bold" })

-- WhichKey
hi("WhichKeyFloat",  { bg = colors.alum6 })
hi("WhichKeyBorder", { fg = colors.alum5, bg = colors.alum6 })

-- Lualine theme using full tango palette
local M = {}
M.normal = {
  a = { fg = colors.alum7, bg = colors.blue2, gui = "bold" },
  b = { fg = colors.alum2, bg = colors.blue3 },
  c = { fg = colors.alum2, bg = colors.alum6 },
}
M.insert = {
  a = { fg = colors.alum7, bg = colors.cham1, gui = "bold" },
  b = { fg = colors.alum2, bg = colors.cham3 },
  c = { fg = colors.alum2, bg = colors.alum6 },
}
M.visual = {
  a = { fg = colors.alum7, bg = colors.orange1, gui = "bold" },
  b = { fg = colors.alum2, bg = colors.orange3 },
  c = { fg = colors.alum2, bg = colors.alum6 },
}
M.replace = {
  a = { fg = colors.alum1, bg = colors.red2, gui = "bold" },
  b = { fg = colors.alum2, bg = colors.red3 },
  c = { fg = colors.alum2, bg = colors.alum6 },
}
M.command = {
  a = { fg = colors.alum1, bg = colors.plum2, gui = "bold" },
  b = { fg = colors.alum2, bg = colors.plum3 },
  c = { fg = colors.alum2, bg = colors.alum6 },
}
M.terminal = {
  a = { fg = colors.alum7, bg = colors.butter3, gui = "bold" },
  b = { fg = colors.alum2, bg = colors.choc3 },
  c = { fg = colors.alum2, bg = colors.alum6 },
}
M.inactive = {
  a = { fg = colors.alum3, bg = colors.alum5_5 },
  b = { fg = colors.alum4, bg = colors.alum6 },
  c = { fg = colors.alum4, bg = colors.alum7 },
}

vim.g.tango_dark_lualine_theme = M

-- Terminal colors
vim.g.terminal_color_0  = colors.alum7
vim.g.terminal_color_1  = colors.red0
vim.g.terminal_color_2  = colors.cham0
vim.g.terminal_color_3  = colors.butter1
vim.g.terminal_color_4  = colors.blue1
vim.g.terminal_color_5  = colors.plum1
vim.g.terminal_color_6  = colors.blue0
vim.g.terminal_color_7  = colors.alum1
vim.g.terminal_color_8  = colors.alum5
vim.g.terminal_color_9  = colors.red1
vim.g.terminal_color_10 = colors.cham1
vim.g.terminal_color_11 = colors.butter2
vim.g.terminal_color_12 = colors.blue2
vim.g.terminal_color_13 = colors.plum2
vim.g.terminal_color_14 = colors.blue1
vim.g.terminal_color_15 = colors.alum2
