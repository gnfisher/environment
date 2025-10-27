-- ghostty.lua
-- Neovim colorscheme that mirrors Ghostty's default palette.

local palette = {
  [0] = "#1D1F21",
  [1] = "#CC6666",
  [2] = "#B5BD68",
  [3] = "#F0C674",
  [4] = "#81A2BE",
  [5] = "#B294BB",
  [6] = "#8ABEB7",
  [7] = "#C5C8C6",
  [8] = "#666666",
  [9] = "#D54E53",
  [10] = "#B9CA4A",
  [11] = "#E7C547",
  [12] = "#7AA6DA",
  [13] = "#C397D8",
  [14] = "#70C0B1",
  [15] = "#EAEAEA",
}

local colors = {
  bg = "#202326",
  bg_alt = "#24282c",
  bg_float = "#262a2f",
  bg_highlight = "#2d3238",
  fg = palette[7],
  fg_bright = palette[15],
  comment = palette[8],
  border = "#353b42",
  selection = "#353b44",
  accent = palette[12],
  accent_alt = palette[4],
  red = palette[9],
  red_alt = palette[1],
  orange = palette[3],
  yellow = palette[11],
  green = palette[2],
  green_alt = palette[10],
  teal = palette[6],
  cyan = palette[14],
  blue = palette[4],
  blue_alt = palette[12],
  magenta = palette[5],
  magenta_alt = palette[13],
  success = palette[10],
  warn = palette[11],
  info = palette[12],
  hint = palette[14],
}

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "ghostty"

local function hi(group, opts)
  if opts.link then
    vim.cmd("hi! link " .. group .. " " .. opts.link)
    return
  end

  local parts = { "hi", group }
  if opts.gui then table.insert(parts, "gui=" .. opts.gui) end
  if opts.fg then table.insert(parts, "guifg=" .. opts.fg) end
  if opts.bg then table.insert(parts, "guibg=" .. opts.bg) end
  if opts.sp then table.insert(parts, "guisp=" .. opts.sp) end
  vim.cmd(table.concat(parts, " "))
end

-- Core UI
hi("Normal",        { fg = colors.fg,        bg = colors.bg })
hi("NormalNC",      { fg = colors.fg,        bg = colors.bg })
hi("NormalFloat",   { fg = colors.fg,        bg = colors.bg_float })
hi("FloatBorder",   { fg = colors.border,    bg = colors.bg_float })
hi("FloatTitle",    { fg = colors.bg,        bg = colors.blue_alt, gui = "bold" })
hi("WinSeparator",  { fg = colors.border })
hi("VertSplit",     { fg = colors.border })
hi("Cursor",        { fg = colors.bg,        bg = colors.fg })
hi("CursorLine",    { bg = colors.bg_highlight })
hi("CursorColumn",  { bg = colors.bg_highlight })
hi("LineNr",        { fg = colors.comment,   bg = colors.bg })
hi("CursorLineNr",  { fg = colors.yellow,    bg = colors.bg })
hi("SignColumn",    { fg = colors.comment,   bg = colors.bg })
hi("ColorColumn",   { bg = colors.bg_highlight })
hi("Visual",        { bg = colors.selection })
hi("VisualNOS",     { bg = colors.selection })
hi("Search",        { fg = colors.bg,        bg = colors.warn })
hi("IncSearch",     { fg = colors.bg,        bg = colors.accent, gui = "bold" })
hi("MatchParen",    { fg = colors.accent_alt, bg = colors.bg_highlight, gui = "bold" })
hi("Folded",        { fg = colors.comment,   bg = colors.bg_highlight })
hi("FoldColumn",    { fg = colors.comment,   bg = colors.bg })
hi("StatusLine",    { fg = colors.bg,        bg = colors.cyan, gui = "bold" })
hi("StatusLineNC",  { fg = colors.comment,   bg = colors.bg_highlight })
hi("TabLine",       { fg = colors.comment,   bg = colors.bg_highlight })
hi("TabLineSel",    { fg = colors.bg,        bg = colors.magenta_alt, gui = "bold" })
hi("TabLineFill",   { fg = colors.comment,   bg = colors.bg })

-- Menus
hi("Pmenu",         { fg = colors.fg,        bg = colors.bg_float })
hi("PmenuSel",      { fg = colors.bg,        bg = colors.blue })
hi("PmenuSbar",     { bg = colors.bg_highlight })
hi("PmenuThumb",    { bg = colors.comment })

-- Syntax
hi("Comment",       { fg = colors.comment, gui = "italic" })
hi("Constant",      { fg = colors.magenta })
hi("String",        { fg = colors.green_alt })
hi("Character",     { fg = colors.green_alt })
hi("Number",        { fg = colors.cyan })
hi("Boolean",       { fg = colors.cyan })
hi("Float",         { fg = colors.cyan })
hi("Identifier",    { fg = colors.blue })
hi("Function",      { fg = colors.accent_alt })
hi("Statement",     { fg = colors.green })
hi("Conditional",   { fg = colors.green })
hi("Repeat",        { fg = colors.green })
hi("Label",         { fg = colors.green })
hi("Operator",      { fg = colors.teal })
hi("Keyword",       { fg = colors.magenta_alt })
hi("Exception",     { fg = colors.red })
hi("PreProc",       { fg = colors.orange })
hi("Include",       { fg = colors.orange })
hi("Define",        { fg = colors.orange })
hi("Macro",         { fg = colors.orange })
hi("PreCondit",     { fg = colors.orange })
hi("Type",          { fg = colors.blue_alt })
hi("StorageClass",  { fg = colors.blue_alt })
hi("Structure",     { fg = colors.blue_alt })
hi("Typedef",       { fg = colors.blue_alt })
hi("Special",       { fg = colors.yellow })
hi("SpecialChar",   { fg = colors.yellow })
hi("Tag",           { fg = colors.red_alt })
hi("Delimiter",     { fg = colors.comment })
hi("SpecialComment",{ fg = colors.magenta })
hi("Debug",         { fg = colors.red })
hi("Underlined",    { fg = colors.blue_alt, gui = "underline" })
hi("Ignore",        { fg = colors.comment })
hi("Error",         { fg = colors.bg,        bg = colors.red, gui = "bold" })
hi("Todo",          { fg = colors.bg,        bg = colors.yellow, gui = "bold" })

-- Diagnostics
hi("DiagnosticError",           { fg = colors.red })
hi("DiagnosticWarn",            { fg = colors.warn })
hi("DiagnosticInfo",            { fg = colors.info })
hi("DiagnosticHint",            { fg = colors.hint })
hi("DiagnosticOk",              { fg = colors.success })
hi("DiagnosticUnderlineError",  { gui = "underline", sp = colors.red })
hi("DiagnosticUnderlineWarn",   { gui = "underline", sp = colors.warn })
hi("DiagnosticUnderlineInfo",   { gui = "underline", sp = colors.info })
hi("DiagnosticUnderlineHint",   { gui = "underline", sp = colors.hint })

-- Diffs
hi("DiffAdd",       { fg = colors.bg, bg = "#2c4134" })
hi("DiffChange",    { fg = colors.bg, bg = "#3a2f2a" })
hi("DiffDelete",    { fg = colors.bg, bg = "#412c33" })
hi("DiffText",      { fg = colors.bg, bg = "#2a3f46" })

-- Git signs
hi("GitSignsAdd",    { fg = colors.green_alt })
hi("GitSignsChange", { fg = colors.yellow })
hi("GitSignsDelete", { fg = colors.red })

-- Treesitter aliases
hi("@comment",      { link = "Comment" })
hi("@keyword",      { link = "Keyword" })
hi("@string",       { link = "String" })
hi("@number",       { link = "Number" })
hi("@boolean",      { link = "Boolean" })
hi("@function",     { link = "Function" })
hi("@method",       { link = "Function" })
hi("@type",         { link = "Type" })
hi("@variable",     { fg = colors.fg })
hi("@constant",     { link = "Constant" })

-- Telescope
hi("TelescopeNormal",         { fg = colors.fg,   bg = colors.bg_float })
hi("TelescopeBorder",         { fg = colors.border, bg = colors.bg_float })
hi("TelescopeTitle",          { fg = colors.bg,   bg = colors.blue, gui = "bold" })
hi("TelescopePromptNormal",   { fg = colors.fg,   bg = colors.bg_float })
hi("TelescopePromptBorder",   { fg = colors.cyan, bg = colors.bg_float })
hi("TelescopePromptTitle",    { fg = colors.bg,   bg = colors.cyan })
hi("TelescopeResultsNormal",  { fg = colors.fg,   bg = colors.bg })
hi("TelescopeResultsBorder",  { fg = colors.border, bg = colors.bg })
hi("TelescopeResultsTitle",   { fg = colors.bg,   bg = colors.magenta })
hi("TelescopePreviewNormal",  { fg = colors.fg,   bg = colors.bg })
hi("TelescopePreviewBorder",  { fg = colors.border, bg = colors.bg })
hi("TelescopePreviewTitle",   { fg = colors.bg,   bg = colors.green })
hi("TelescopeSelection",      { fg = colors.fg_bright, bg = colors.selection })
hi("TelescopeSelectionCaret", { fg = colors.magenta_alt, bg = colors.selection })
hi("TelescopeMatching",       { fg = colors.yellow })

-- Lazy.nvim
hi("LazyNormal",    { fg = colors.fg,        bg = colors.bg_float })
hi("LazyBorder",    { fg = colors.border,    bg = colors.bg_float })
hi("LazyH1",        { fg = colors.bg,        bg = colors.blue_alt, gui = "bold" })
hi("LazyButton",    { fg = colors.fg,        bg = colors.bg_float })
hi("LazyButtonActive", { fg = colors.bg,     bg = colors.teal })

-- Nvim-tree / other floats
hi("NvimTreeNormal",      { fg = colors.fg, bg = colors.bg })
hi("NvimTreeNormalFloat", { fg = colors.fg, bg = colors.bg_float })
hi("NvimTreeWinSeparator",{ fg = colors.border, bg = colors.bg })

-- WhichKey
hi("WhichKeyFloat",  { bg = colors.bg_float })
hi("WhichKeyBorder", { fg = colors.border, bg = colors.bg_float })
