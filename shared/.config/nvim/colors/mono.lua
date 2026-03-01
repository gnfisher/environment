-- mono.lua
-- Minimal monochromatic colorscheme with light and dark variants.
-- Respects vim.o.background; toggle with F6 (see plugin/color.lua).
--
-- Syntax uses only shades of gray differentiated by weight and style.
-- Color is reserved for diagnostics (red/orange underlines), diffs,
-- and git signs.

vim.cmd("highlight clear")
vim.g.colors_name = "mono"

local is_light = vim.o.background == "light"

local colors
if is_light then
  colors = {
    bg       = "#ffffff",
    fg       = "#222222",

    -- Gray ramp (light → dark)
    gray1    = "#fafafa",
    gray2    = "#f5f5f5",
    gray3    = "#eeeeee",
    gray4    = "#e0e0e0",
    gray5    = "#cccccc",
    gray6    = "#b0b0b0",
    gray7    = "#999999",
    gray8    = "#777777",
    gray9    = "#555555",
    gray10   = "#444444",
    gray11   = "#333333",

    -- UI accents
    visual   = "#f5d87a",
    search   = "#f5e6a3",
    cursearch = "#dfc040",
    match    = "#c8dfc8",
    cursor   = "#222222",
    tabsel   = "#e0e0e0",
    pmenusel = "#d0e4f5",
    nontext  = "#cccccc",

    -- Cursor accent (warm amber)
    cursorline_bg = "#f5f0e0",
    linenr_fg     = "#b89a60",
    curlinenr_fg  = "#8a6d20",

    -- Diagnostics (red/orange, matching lucius style)
    error_fg = "#cc0000",
    warn_fg  = "#bf6900",
    info_fg  = "#555555",
    hint_fg  = "#777777",
    todo_fg  = "#856404",
    todo_bg  = "#fff3cd",

    -- Diff
    diff_add    = "#d4edda",
    diff_change = "#fff3cd",
    diff_delete = "#f8d7da",
    diff_text   = "#856404",

    -- Git signs
    sign_add    = "#22863a",
    sign_change = "#0366d6",
    sign_delete = "#cb2431",

    -- Spell
    spell_bad   = "#cc0000",
    spell_cap   = "#bf6900",
    spell_local = "#856404",
    spell_rare  = "#22863a",
  }
else
  colors = {
    bg       = "#191919",
    fg       = "#d4d4d4",

    -- Gray ramp (dark → light)
    gray1    = "#111111",
    gray2    = "#1e1e1e",
    gray3    = "#252525",
    gray4    = "#2d2d2d",
    gray5    = "#3a3a3a",
    gray6    = "#505050",
    gray7    = "#606060",
    gray8    = "#777777",
    gray9    = "#999999",
    gray10   = "#aaaaaa",
    gray11   = "#bbbbbb",

    -- UI accents
    visual   = "#504000",
    search   = "#6b5300",
    cursearch = "#8a6d00",
    match    = "#3a5f3a",
    cursor   = "#d4d4d4",
    tabsel   = "#3a3a3a",
    pmenusel = "#264f78",
    nontext  = "#3a3a3a",

    -- Cursor accent (warm amber)
    cursorline_bg = "#2a2418",
    linenr_fg     = "#7a6530",
    curlinenr_fg  = "#d4a840",

    -- Diagnostics (red/orange, matching lucius style)
    error_fg = "#ff8787",
    warn_fg  = "#ffaf87",
    info_fg  = "#aaaaaa",
    hint_fg  = "#888888",
    todo_fg  = "#c8c070",
    todo_bg  = "#3a3520",

    -- Diff
    diff_add    = "#1e3a1e",
    diff_change = "#3a3520",
    diff_delete = "#3a1e1e",
    diff_text   = "#c8c070",

    -- Git signs
    sign_add    = "#7fb87f",
    sign_change = "#7fb8d4",
    sign_delete = "#d47f7f",

    -- Spell
    spell_bad   = "#ff5f5f",
    spell_cap   = "#ffaf87",
    spell_local = "#d7af5f",
    spell_rare  = "#5faf5f",
  }
end

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
hi("CursorLine",    { bg = colors.cursorline_bg })
hi("CursorColumn",  { bg = colors.cursorline_bg })
hi("ColorColumn",   { bg = colors.gray3 })
hi("Visual",        { bg = colors.visual })
hi("VisualNOS",     { fg = colors.fg, gui = "underline" })

hi("LineNr",        { fg = colors.linenr_fg, bg = colors.bg })
hi("CursorLineNr",  { fg = colors.curlinenr_fg, bg = colors.bg, gui = "bold" })
hi("SignColumn",    { fg = colors.gray7, bg = colors.bg })

hi("StatusLine",    { fg = colors.bg, bg = colors.fg, gui = "bold" })
hi("StatusLineNC",  { fg = colors.gray8, bg = colors.gray4 })
hi("VertSplit",     { fg = colors.gray5 })
hi("WinSeparator",  { fg = colors.gray5 })

hi("TabLine",       { fg = colors.gray7, bg = colors.bg })
hi("TabLineFill",   { bg = colors.bg })
hi("TabLineSel",    { fg = colors.fg, bg = colors.bg, gui = "bold" })

hi("Folded",        { fg = colors.gray8, bg = colors.gray3, gui = "bold" })
hi("FoldColumn",    { fg = colors.gray7, bg = colors.bg })

hi("NonText",       { fg = colors.nontext })
hi("SpecialKey",    { fg = colors.gray6 })
hi("Whitespace",    { fg = colors.nontext })
hi("EndOfBuffer",   { fg = colors.gray5 })

hi("WildMenu",      { fg = colors.fg, bg = colors.visual })

-- ============================================================================
-- Popup menu / Floating windows
-- ============================================================================

hi("Pmenu",         { fg = colors.fg, bg = colors.gray3 })
hi("PmenuSel",      { fg = colors.fg, bg = colors.pmenusel })
hi("PmenuSbar",     { bg = colors.gray4 })
hi("PmenuThumb",    { bg = colors.gray7 })

hi("NormalFloat",   { fg = colors.fg, bg = colors.gray2 })
hi("FloatBorder",   { fg = colors.gray5, bg = colors.gray2 })
hi("FloatTitle",    { fg = colors.fg, bg = colors.gray2, gui = "bold" })

-- ============================================================================
-- Search / Match
-- ============================================================================

hi("Search",        { fg = colors.fg, bg = colors.search })
hi("IncSearch",     { fg = colors.fg, bg = colors.search })
hi("CurSearch",     { fg = colors.fg, bg = colors.cursearch, gui = "bold" })
hi("MatchParen",    { fg = colors.fg, bg = colors.match })

-- ============================================================================
-- Messages
-- ============================================================================

hi("ErrorMsg",      { fg = colors.error_fg })
hi("WarningMsg",    { fg = colors.warn_fg })
hi("ModeMsg",       { fg = colors.fg, gui = "bold" })
hi("MoreMsg",       { fg = colors.fg, gui = "bold" })
hi("Question",      { fg = colors.fg })

-- ============================================================================
-- Syntax — monochromatic: shades + weight/style only
-- ============================================================================

hi("Comment",       { fg = colors.gray8, gui = "italic" })
hi("Conceal",       { fg = colors.gray8 })

hi("Constant",      { fg = colors.gray9 })
hi("String",        { fg = colors.gray9 })
hi("Character",     { fg = colors.gray9 })
hi("Number",        { fg = colors.gray9 })
hi("Boolean",       { fg = colors.gray9 })
hi("Float",         { fg = colors.gray9 })

hi("Identifier",    { fg = colors.fg })
hi("Function",      { fg = colors.fg })

hi("Statement",     { fg = colors.fg, gui = "bold" })
hi("Conditional",   { fg = colors.fg, gui = "bold" })
hi("Repeat",        { fg = colors.fg, gui = "bold" })
hi("Label",         { fg = colors.fg, gui = "bold" })
hi("Operator",      { fg = colors.fg })
hi("Keyword",       { fg = colors.fg, gui = "bold" })
hi("Exception",     { fg = colors.fg, gui = "bold" })

hi("PreProc",       { fg = colors.gray10 })
hi("Include",       { fg = colors.gray10 })
hi("Define",        { fg = colors.gray10 })
hi("Macro",         { fg = colors.gray10 })
hi("PreCondit",     { fg = colors.gray10 })

hi("Type",          { fg = colors.fg, gui = "bold" })
hi("StorageClass",  { fg = colors.fg, gui = "bold" })
hi("Structure",     { fg = colors.fg, gui = "bold" })
hi("Typedef",       { fg = colors.fg, gui = "bold" })

hi("Special",       { fg = colors.gray9, gui = "italic" })
hi("SpecialChar",   { fg = colors.gray9, gui = "italic" })
hi("Tag",           { fg = colors.fg })
hi("Delimiter",     { fg = colors.fg })
hi("SpecialComment", { fg = colors.gray9, gui = "italic" })
hi("Debug",         { fg = colors.gray9 })

hi("Underlined",    { fg = colors.fg, gui = "underline" })
hi("Ignore",        { fg = colors.bg })
hi("Error",         { fg = colors.error_fg, gui = "bold" })
hi("Todo",          { fg = colors.todo_fg, bg = colors.todo_bg })
hi("Title",         { fg = colors.fg, gui = "bold" })
hi("Directory",     { fg = colors.fg, gui = "bold" })

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
hi("diffFile",      { fg = colors.fg, gui = "bold" })
hi("diffLine",      { fg = colors.gray8 })

-- ============================================================================
-- Spelling
-- ============================================================================

hi("SpellBad",      { gui = "undercurl", sp = colors.spell_bad })
hi("SpellCap",      { gui = "undercurl", sp = colors.spell_cap })
hi("SpellLocal",    { gui = "undercurl", sp = colors.spell_local })
hi("SpellRare",     { gui = "undercurl", sp = colors.spell_rare })

-- ============================================================================
-- Diagnostics (LSP) — colored underlines, matching lucius style
-- ============================================================================

hi("DiagnosticError", { fg = colors.error_fg })
hi("DiagnosticWarn",  { fg = colors.warn_fg })
hi("DiagnosticInfo",  { fg = colors.info_fg })
hi("DiagnosticHint",  { fg = colors.hint_fg })
hi("DiagnosticOk",    { fg = colors.sign_add })

hi("DiagnosticUnderlineError", { fg = colors.error_fg, gui = "underline", sp = colors.error_fg })
hi("DiagnosticUnderlineWarn",  { fg = colors.warn_fg, gui = "underline", sp = colors.warn_fg })
hi("DiagnosticUnderlineInfo",  { fg = colors.info_fg, gui = "underline", sp = colors.info_fg })
hi("DiagnosticUnderlineHint",  { fg = colors.hint_fg, gui = "underline", sp = colors.hint_fg })

hi("LspReferenceText",  { bg = colors.gray3 })
hi("LspReferenceRead",  { bg = colors.gray3 })
hi("LspReferenceWrite", { bg = colors.gray4 })

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
-- Treesitter — same monochromatic philosophy
-- ============================================================================

hi("@comment",              { fg = colors.gray8, gui = "italic" })
hi("@string",               { fg = colors.gray9 })
hi("@string.escape",        { fg = colors.gray9, gui = "italic" })
hi("@string.regex",         { fg = colors.gray9, gui = "italic" })
hi("@string.special",       { fg = colors.gray9, gui = "italic" })
hi("@number",               { fg = colors.gray9 })
hi("@float",                { fg = colors.gray9 })
hi("@boolean",              { fg = colors.gray9 })
hi("@character",            { fg = colors.gray9 })

hi("@constant",             { fg = colors.gray9 })
hi("@constant.builtin",     { fg = colors.gray9 })
hi("@constant.macro",       { fg = colors.gray10 })

hi("@variable",             { fg = colors.fg })
hi("@variable.builtin",     { fg = colors.fg })
hi("@variable.parameter",   { fg = colors.fg })
hi("@parameter",            { fg = colors.fg })

hi("@field",                { fg = colors.fg })
hi("@property",             { fg = colors.fg })

hi("@function",             { fg = colors.fg })
hi("@function.builtin",     { fg = colors.fg })
hi("@function.call",        { fg = colors.fg })
hi("@method",               { fg = colors.fg })
hi("@method.call",          { fg = colors.fg })
hi("@constructor",          { fg = colors.fg, gui = "bold" })

hi("@type",                 { fg = colors.fg, gui = "bold" })
hi("@type.builtin",         { fg = colors.fg, gui = "bold" })
hi("@type.definition",      { fg = colors.fg, gui = "bold" })
hi("@type.qualifier",       { fg = colors.fg, gui = "bold" })

hi("@module",               { fg = colors.gray10 })
hi("@namespace",            { fg = colors.gray10 })

hi("@keyword",              { fg = colors.fg, gui = "bold" })
hi("@keyword.function",     { fg = colors.fg, gui = "bold" })
hi("@keyword.return",       { fg = colors.fg, gui = "bold" })
hi("@keyword.operator",     { fg = colors.fg, gui = "bold" })
hi("@keyword.import",       { fg = colors.gray10 })
hi("@keyword.conditional",  { fg = colors.fg, gui = "bold" })
hi("@keyword.repeat",       { fg = colors.fg, gui = "bold" })
hi("@keyword.exception",    { fg = colors.fg, gui = "bold" })

hi("@operator",             { fg = colors.fg })

hi("@punctuation.delimiter", { fg = colors.fg })
hi("@punctuation.bracket",   { fg = colors.fg, gui = "bold" })
hi("@punctuation.special",   { fg = colors.gray9, gui = "italic" })

hi("@tag",                  { fg = colors.fg, gui = "bold" })
hi("@tag.attribute",        { fg = colors.fg })
hi("@tag.delimiter",        { fg = colors.fg })

hi("@attribute",            { fg = colors.gray10 })
hi("@label",                { fg = colors.fg, gui = "bold" })

hi("@markup.heading",       { fg = colors.fg, gui = "bold" })
hi("@markup.link",          { fg = colors.fg, gui = "underline" })
hi("@markup.link.url",      { fg = colors.gray9, gui = "underline" })
hi("@markup.italic",        { gui = "italic" })
hi("@markup.bold",          { gui = "bold" })
hi("@markup.list",          { fg = colors.fg })
hi("@markup.quote",         { fg = colors.gray8, gui = "italic" })
hi("@markup.raw",           { fg = colors.gray9 })
hi("@markup.raw.block",     { fg = colors.gray9 })

hi("@diff.plus",            { fg = colors.sign_add })
hi("@diff.minus",           { fg = colors.sign_delete })
hi("@diff.delta",           { fg = colors.sign_change })

-- ============================================================================
-- Telescope
-- ============================================================================

hi("TelescopeNormal",         { fg = colors.fg, bg = colors.gray2 })
hi("TelescopeBorder",         { fg = colors.gray5, bg = colors.gray2 })
hi("TelescopeTitle",          { fg = colors.bg, bg = colors.fg, gui = "bold" })
hi("TelescopePromptNormal",   { fg = colors.fg, bg = colors.gray2 })
hi("TelescopePromptBorder",   { fg = colors.gray5, bg = colors.gray2 })
hi("TelescopePromptTitle",    { fg = colors.bg, bg = colors.fg, gui = "bold" })
hi("TelescopeResultsNormal",  { fg = colors.fg, bg = colors.gray2 })
hi("TelescopeResultsBorder",  { fg = colors.gray5, bg = colors.gray2 })
hi("TelescopeResultsTitle",   { fg = colors.bg, bg = colors.fg, gui = "bold" })
hi("TelescopePreviewNormal",  { fg = colors.fg, bg = colors.gray2 })
hi("TelescopePreviewBorder",  { fg = colors.gray5, bg = colors.gray2 })
hi("TelescopePreviewTitle",   { fg = colors.bg, bg = colors.fg, gui = "bold" })
hi("TelescopeSelection",      { fg = colors.fg, bg = colors.gray4 })
hi("TelescopeSelectionCaret", { fg = colors.fg, bg = colors.gray4, gui = "bold" })
hi("TelescopeMatching",       { fg = colors.fg, gui = "bold,underline" })

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
hi("LazyBorder",       { fg = colors.gray5, bg = colors.gray2 })
hi("LazyH1",           { fg = colors.bg, bg = colors.fg, gui = "bold" })
hi("LazyButton",       { fg = colors.fg, bg = colors.gray4 })
hi("LazyButtonActive", { fg = colors.bg, bg = colors.fg, gui = "bold" })

-- ============================================================================
-- WhichKey
-- ============================================================================

hi("WhichKeyFloat",  { bg = colors.gray2 })
hi("WhichKeyBorder", { fg = colors.gray5, bg = colors.gray2 })

-- ============================================================================
-- Fugitive
-- ============================================================================

link("fugitiveHash",         "Constant")
link("fugitiveHeader",       "Title")
link("fugitiveStagedHeading", "Title")
link("fugitiveUnstagedHeading", "Title")
link("fugitiveStagedModifier", "Statement")
link("fugitiveUnstagedModifier", "Statement")

-- ============================================================================
-- Terminal colors (grayscale with diagnostic accents)
-- ============================================================================

vim.g.terminal_color_0  = colors.bg
vim.g.terminal_color_1  = colors.error_fg
vim.g.terminal_color_2  = colors.sign_add
vim.g.terminal_color_3  = colors.warn_fg
vim.g.terminal_color_4  = colors.gray9
vim.g.terminal_color_5  = colors.gray8
vim.g.terminal_color_6  = colors.gray10
vim.g.terminal_color_7  = colors.fg
vim.g.terminal_color_8  = colors.gray7
vim.g.terminal_color_9  = colors.spell_bad
vim.g.terminal_color_10 = colors.sign_add
vim.g.terminal_color_11 = colors.warn_fg
vim.g.terminal_color_12 = colors.gray9
vim.g.terminal_color_13 = colors.gray8
vim.g.terminal_color_14 = colors.gray10
vim.g.terminal_color_15 = colors.fg
