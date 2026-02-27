-- grb-lucius.lua
-- Neovim colorscheme: GRB-modified Lucius Dark High Contrast
-- Based on Lucius by Jonathan Filip, with Gary Bernhardt's modifications.
-- Ported to Lua and extended for modern Neovim (treesitter, LSP diagnostics,
-- gitsigns, oil.nvim, telescope, etc.)

local colors = {
  -- Background / foreground
  bg      = "#303030",
  fg      = "#eeeeee",

  -- Gray ramp
  gray1   = "#1c1c1c",
  gray2   = "#262626",
  gray3   = "#3a3a3a",
  gray4   = "#444444",
  gray5   = "#4e4e4e",
  gray6   = "#585858",
  gray7   = "#626262",
  gray8   = "#808080",
  gray9   = "#8a8a8a",
  gray10  = "#9e9e9e",
  gray11  = "#bcbcbc",
  gray12  = "#c6c6c6",
  gray13  = "#dadada",

  -- Syntax (dark high contrast)
  comment   = "#8a8a8a",
  constant  = "#ffffd7",
  directory = "#d7ffd7",
  ident     = "#d7ffaf",
  preproc   = "#afffd7",
  special   = "#ffd7ff",
  statement = "#afffff",
  title     = "#87d7ff",
  type_     = "#afffff",

  -- UI accents
  nontext    = "#5f5f87",
  specialkey = "#5f875f",
  search     = "#87ffff",
  match      = "#87af00",
  visual     = "#005f87",
  cursor     = "#afd7ff",
  tabsel     = "#0087af",
  pmenusel   = "#005f87",
  wildmenu   = "#005f87",

  -- Diagnostics / messages
  error_fg  = "#ffafaf",
  error_bg  = "#af0000",
  error_msg = "#ff8787",
  warn_msg  = "#ffaf87",
  info_msg  = "#afffff",
  hint_msg  = "#afffd7",
  todo_fg   = "#ffff87",
  todo_bg   = "#87875f",

  -- Diff
  diff_add    = "#5f875f",
  diff_change = "#87875f",
  diff_delete = "#875f5f",
  diff_text   = "#ffff87",

  -- Git signs (bright variants for sign column)
  sign_add    = "#afd787",
  sign_change = "#87d7ff",
  sign_delete = "#ff8787",

  -- Spell
  spell_bad   = "#ff5f5f",
  spell_cap   = "#ffaf87",
  spell_local = "#d7af5f",
  spell_rare  = "#5faf5f",
}

vim.cmd("highlight clear")
vim.cmd("set background=dark")
vim.g.colors_name = "grb-lucius"

local function hi(group, opts)
  local cmd = "hi " .. group
  if opts.gui then cmd = cmd .. " gui=" .. opts.gui end
  if opts.fg then cmd = cmd .. " guifg=" .. opts.fg end
  if opts.bg then cmd = cmd .. " guibg=" .. opts.bg end
  if opts.sp then cmd = cmd .. " guisp=" .. opts.sp end
  vim.cmd(cmd)
end

local function link(from, to)
  vim.cmd("hi! link " .. from .. " " .. to)
end

-- ============================================================================
-- Core UI
-- ============================================================================

hi("Normal",        { fg = colors.fg, bg = colors.bg })
hi("NormalNC",      { fg = colors.fg, bg = colors.bg })
hi("Cursor",        { fg = colors.bg, bg = colors.cursor })
hi("CursorIM",      { fg = colors.bg, bg = colors.cursor })
hi("CursorLine",    { bg = colors.gray4 })
hi("CursorColumn",  { bg = colors.gray4 })
hi("ColorColumn",   { bg = colors.gray3 })
hi("Visual",        { bg = colors.visual })
hi("VisualNOS",     { fg = colors.fg, gui = "underline" })

hi("LineNr",        { fg = colors.gray7, bg = colors.bg })
hi("CursorLineNr",  { fg = colors.gray10, bg = colors.bg, gui = "bold" })
hi("SignColumn",    { fg = colors.gray11, bg = colors.bg })

hi("StatusLine",    { fg = colors.bg, bg = colors.gray11, gui = "bold" })
hi("StatusLineNC",  { fg = colors.gray5, bg = colors.gray11 })
hi("VertSplit",     { fg = colors.gray7, bg = colors.gray11 })
hi("WinSeparator",  { fg = colors.gray7 })

hi("TabLine",       { fg = colors.bg, bg = colors.gray11 })
hi("TabLineFill",   { fg = colors.gray5, bg = colors.gray11 })
hi("TabLineSel",    { fg = colors.fg, bg = colors.tabsel, gui = "bold" })

hi("Folded",        { fg = colors.gray12, bg = colors.bg, gui = "bold" })
hi("FoldColumn",    { fg = colors.gray12, bg = colors.bg })

hi("NonText",       { fg = colors.nontext })
hi("SpecialKey",    { fg = colors.specialkey })
hi("Whitespace",    { fg = colors.nontext })
hi("EndOfBuffer",   { fg = colors.gray4 })

hi("WildMenu",      { fg = colors.fg, bg = colors.wildmenu })

-- ============================================================================
-- Popup menu / Floating windows
-- ============================================================================

hi("Pmenu",         { fg = colors.fg, bg = colors.gray5 })
hi("PmenuSel",      { fg = colors.fg, bg = colors.pmenusel })
hi("PmenuSbar",     { bg = colors.gray4 })
hi("PmenuThumb",    { bg = colors.gray9 })

hi("NormalFloat",   { fg = colors.fg, bg = colors.gray2 })
hi("FloatBorder",   { fg = colors.gray7, bg = colors.gray2 })
hi("FloatTitle",    { fg = colors.title, bg = colors.gray2, gui = "bold" })

-- ============================================================================
-- Search / Match
-- ============================================================================

hi("Search",        { fg = colors.bg, bg = colors.search })
hi("IncSearch",     { fg = colors.bg, bg = colors.search })
hi("CurSearch",     { fg = colors.bg, bg = colors.title, gui = "bold" })
hi("MatchParen",    { fg = colors.fg, bg = colors.match })

-- ============================================================================
-- Messages
-- ============================================================================

hi("ErrorMsg",      { fg = colors.error_msg })
hi("WarningMsg",    { fg = colors.warn_msg })
hi("ModeMsg",       { fg = colors.info_msg })
hi("MoreMsg",       { fg = colors.info_msg })
hi("Question",      { fg = colors.fg })

-- ============================================================================
-- Syntax
-- ============================================================================

hi("Comment",       { fg = colors.comment, gui = "italic" })
hi("Conceal",       { fg = colors.comment })

hi("Constant",      { fg = colors.constant })
hi("String",        { fg = colors.constant })
hi("Character",     { fg = colors.constant })
hi("Number",        { fg = colors.constant })
hi("Boolean",       { fg = colors.constant })
hi("Float",         { fg = colors.constant })

hi("Identifier",    { fg = colors.ident })
hi("Function",      { fg = colors.ident })

hi("Statement",     { fg = colors.statement })
hi("Conditional",   { fg = colors.statement })
hi("Repeat",        { fg = colors.statement })
hi("Label",         { fg = colors.statement })
hi("Operator",      { fg = colors.statement })
hi("Keyword",       { fg = colors.statement })
hi("Exception",     { fg = colors.statement })

hi("PreProc",       { fg = colors.preproc })
hi("Include",       { fg = colors.preproc })
hi("Define",        { fg = colors.preproc })
hi("Macro",         { fg = colors.preproc })
hi("PreCondit",     { fg = colors.preproc })

hi("Type",          { fg = colors.type_ })
hi("StorageClass",  { fg = colors.type_ })
hi("Structure",     { fg = colors.type_ })
hi("Typedef",       { fg = colors.type_ })

hi("Special",       { fg = colors.special })
hi("SpecialChar",   { fg = colors.special })
hi("Tag",           { fg = colors.special })
hi("Delimiter",     { fg = colors.fg })
hi("SpecialComment", { fg = colors.special })
hi("Debug",         { fg = colors.special })

hi("Underlined",    { fg = colors.fg, gui = "underline" })
hi("Ignore",        { fg = colors.bg })
hi("Error",         { fg = colors.error_fg, bg = colors.error_bg })
hi("Todo",          { fg = colors.todo_fg, bg = colors.todo_bg })
hi("Title",         { fg = colors.title, gui = "bold" })
hi("Directory",     { fg = colors.directory })

-- ============================================================================
-- Diff
-- ============================================================================

hi("DiffAdd",       { fg = colors.fg, bg = colors.diff_add })
hi("DiffChange",    { fg = colors.fg, bg = colors.diff_change })
hi("DiffDelete",    { fg = colors.fg, bg = colors.diff_delete })
hi("DiffText",      { fg = colors.diff_text, bg = colors.diff_change, gui = "bold" })

hi("diffAdded",     { fg = colors.sign_add })
hi("diffRemoved",   { fg = colors.sign_delete })
hi("diffChanged",   { fg = colors.sign_change })
hi("diffOldFile",   { fg = colors.sign_delete })
hi("diffNewFile",   { fg = colors.sign_add })
hi("diffFile",      { fg = colors.title })
hi("diffLine",      { fg = colors.gray10 })

-- ============================================================================
-- Spelling
-- ============================================================================

hi("SpellBad",      { gui = "undercurl", sp = colors.spell_bad })
hi("SpellCap",      { gui = "undercurl", sp = colors.spell_cap })
hi("SpellLocal",    { gui = "undercurl", sp = colors.spell_local })
hi("SpellRare",     { gui = "undercurl", sp = colors.spell_rare })

-- ============================================================================
-- Diagnostics (LSP)
-- ============================================================================

hi("DiagnosticError", { fg = colors.error_msg })
hi("DiagnosticWarn",  { fg = colors.warn_msg })
hi("DiagnosticInfo",  { fg = colors.info_msg })
hi("DiagnosticHint",  { fg = colors.hint_msg })
hi("DiagnosticOk",    { fg = colors.sign_add })

hi("DiagnosticUnderlineError", { fg = colors.error_msg, gui = "underline", sp = colors.error_msg })
hi("DiagnosticUnderlineWarn",  { fg = colors.warn_msg, gui = "underline", sp = colors.warn_msg })
hi("DiagnosticUnderlineInfo",  { fg = colors.info_msg, gui = "underline", sp = colors.info_msg })
hi("DiagnosticUnderlineHint",  { fg = colors.hint_msg, gui = "underline", sp = colors.hint_msg })

hi("LspReferenceText",  { bg = colors.gray4 })
hi("LspReferenceRead",  { bg = colors.gray4 })
hi("LspReferenceWrite", { bg = colors.gray3 })

-- ============================================================================
-- Git Signs
-- ============================================================================

hi("GitSignsAdd",       { fg = colors.sign_add, bg = colors.bg })
hi("GitSignsChange",    { fg = colors.sign_change, bg = colors.bg })
hi("GitSignsDelete",    { fg = colors.sign_delete, bg = colors.bg })
hi("GitSignsAddNr",     { fg = colors.sign_add })
hi("GitSignsChangeNr",  { fg = colors.sign_change })
hi("GitSignsDeleteNr",  { fg = colors.sign_delete })
hi("GitSignsAddLn",     { bg = colors.diff_add })
hi("GitSignsChangeLn",  { bg = colors.diff_change })
hi("GitSignsDeleteLn",  { bg = colors.diff_delete })

-- ============================================================================
-- Treesitter
-- ============================================================================

hi("@comment",              { fg = colors.comment, gui = "italic" })
hi("@string",               { fg = colors.constant })
hi("@string.escape",        { fg = colors.special })
hi("@string.regex",         { fg = colors.special })
hi("@string.special",       { fg = colors.special })
hi("@number",               { fg = colors.constant })
hi("@float",                { fg = colors.constant })
hi("@boolean",              { fg = colors.constant })
hi("@character",            { fg = colors.constant })

hi("@constant",             { fg = colors.constant })
hi("@constant.builtin",     { fg = colors.constant })
hi("@constant.macro",       { fg = colors.preproc })

hi("@variable",             { fg = colors.fg })
hi("@variable.builtin",     { fg = colors.ident })
hi("@variable.parameter",   { fg = colors.fg })
hi("@parameter",            { fg = colors.fg })

hi("@field",                { fg = colors.ident })
hi("@property",             { fg = colors.ident })

hi("@function",             { fg = colors.ident })
hi("@function.builtin",     { fg = colors.ident })
hi("@function.call",        { fg = colors.ident })
hi("@method",               { fg = colors.ident })
hi("@method.call",          { fg = colors.ident })
hi("@constructor",          { fg = colors.type_ })

hi("@type",                 { fg = colors.type_ })
hi("@type.builtin",         { fg = colors.type_ })
hi("@type.definition",      { fg = colors.type_ })
hi("@type.qualifier",       { fg = colors.type_ })

hi("@module",               { fg = colors.preproc })
hi("@namespace",            { fg = colors.preproc })

hi("@keyword",              { fg = colors.statement })
hi("@keyword.function",     { fg = colors.statement })
hi("@keyword.return",       { fg = colors.statement })
hi("@keyword.operator",     { fg = colors.statement })
hi("@keyword.import",       { fg = colors.preproc })
hi("@keyword.conditional",  { fg = colors.statement })
hi("@keyword.repeat",       { fg = colors.statement })
hi("@keyword.exception",    { fg = colors.statement })

hi("@operator",             { fg = colors.statement })

hi("@punctuation.delimiter", { fg = colors.fg })
hi("@punctuation.bracket",   { fg = colors.fg })
hi("@punctuation.special",   { fg = colors.special })

hi("@tag",                  { fg = colors.statement })
hi("@tag.attribute",        { fg = colors.ident })
hi("@tag.delimiter",        { fg = colors.fg })

hi("@attribute",            { fg = colors.preproc })
hi("@label",                { fg = colors.statement })

hi("@markup.heading",       { fg = colors.title, gui = "bold" })
hi("@markup.link",          { fg = colors.statement, gui = "underline" })
hi("@markup.link.url",      { fg = colors.preproc, gui = "underline" })
hi("@markup.italic",        { gui = "italic" })
hi("@markup.bold",          { gui = "bold" })
hi("@markup.list",          { fg = colors.special })
hi("@markup.quote",         { fg = colors.comment, gui = "italic" })
hi("@markup.raw",           { fg = colors.constant })
hi("@markup.raw.block",     { fg = colors.constant })

hi("@diff.plus",            { fg = colors.sign_add })
hi("@diff.minus",           { fg = colors.sign_delete })
hi("@diff.delta",           { fg = colors.sign_change })

-- ============================================================================
-- Telescope
-- ============================================================================

hi("TelescopeNormal",         { fg = colors.fg, bg = colors.gray2 })
hi("TelescopeBorder",         { fg = colors.gray7, bg = colors.gray2 })
hi("TelescopeTitle",          { fg = colors.bg, bg = colors.title, gui = "bold" })
hi("TelescopePromptNormal",   { fg = colors.fg, bg = colors.gray2 })
hi("TelescopePromptBorder",   { fg = colors.gray7, bg = colors.gray2 })
hi("TelescopePromptTitle",    { fg = colors.bg, bg = colors.statement, gui = "bold" })
hi("TelescopeResultsNormal",  { fg = colors.fg, bg = colors.gray2 })
hi("TelescopeResultsBorder",  { fg = colors.gray7, bg = colors.gray2 })
hi("TelescopeResultsTitle",   { fg = colors.bg, bg = colors.title, gui = "bold" })
hi("TelescopePreviewNormal",  { fg = colors.fg, bg = colors.gray2 })
hi("TelescopePreviewBorder",  { fg = colors.gray7, bg = colors.gray2 })
hi("TelescopePreviewTitle",   { fg = colors.bg, bg = colors.sign_add, gui = "bold" })
hi("TelescopeSelection",      { fg = colors.fg, bg = colors.gray4 })
hi("TelescopeSelectionCaret", { fg = colors.search, bg = colors.gray4 })
hi("TelescopeMatching",       { fg = colors.search })

-- ============================================================================
-- Oil.nvim
-- ============================================================================

link("OilDir",       "Directory")
link("OilDirIcon",   "Directory")
link("OilFile",      "Normal")
link("OilCreate",    "DiffAdd")
link("OilDelete",    "DiffDelete")
link("OilMove",      "DiffChange")
link("OilCopy",      "DiffAdd")
link("OilChange",    "DiffChange")
link("OilSocket",    "Special")
link("OilLink",      "Underlined")
link("OilLinkTarget", "Comment")

-- ============================================================================
-- Lazy.nvim
-- ============================================================================

hi("LazyNormal",       { fg = colors.fg, bg = colors.gray2 })
hi("LazyBorder",       { fg = colors.gray7, bg = colors.gray2 })
hi("LazyH1",           { fg = colors.bg, bg = colors.title, gui = "bold" })
hi("LazyButton",       { fg = colors.fg, bg = colors.gray4 })
hi("LazyButtonActive", { fg = colors.bg, bg = colors.title, gui = "bold" })

-- ============================================================================
-- WhichKey
-- ============================================================================

hi("WhichKeyFloat",  { bg = colors.gray2 })
hi("WhichKeyBorder", { fg = colors.gray7, bg = colors.gray2 })

-- ============================================================================
-- Fugitive
-- ============================================================================

link("fugitiveHash",         "Constant")
link("fugitiveHeader",       "Title")
link("fugitiveStagedHeading", "PreProc")
link("fugitiveUnstagedHeading", "Type")
link("fugitiveStagedModifier", "PreProc")
link("fugitiveUnstagedModifier", "Type")

-- ============================================================================
-- Terminal colors
-- ============================================================================

vim.g.terminal_color_0  = colors.bg
vim.g.terminal_color_1  = colors.error_msg
vim.g.terminal_color_2  = colors.sign_add
vim.g.terminal_color_3  = colors.warn_msg
vim.g.terminal_color_4  = colors.title
vim.g.terminal_color_5  = colors.special
vim.g.terminal_color_6  = colors.statement
vim.g.terminal_color_7  = colors.fg
vim.g.terminal_color_8  = colors.gray7
vim.g.terminal_color_9  = colors.spell_bad
vim.g.terminal_color_10 = colors.directory
vim.g.terminal_color_11 = colors.constant
vim.g.terminal_color_12 = colors.search
vim.g.terminal_color_13 = colors.preproc
vim.g.terminal_color_14 = colors.type_
vim.g.terminal_color_15 = colors.gray13
