-- standard-light.lua
-- Neovim port of the Emacs standard-light theme by Protesilaos Stavrou.
-- https://github.com/protesilaos/standard-themes
--
-- "Like the unthemed light Emacs, but more consistent."
-- A light theme with colorful syntax, faithful to the classic Emacs palette.

vim.cmd("highlight clear")
vim.o.background = "light"
vim.g.colors_name = "standard-light"

local c = {
  -- Base
  bg          = "#ffffff",
  fg          = "#000000",
  dim_bg      = "#ebebeb",
  dim_fg      = "#7f7f7f",
  alt_bg      = "#dcdcdc",
  alt_fg      = "#193f8f",
  active_bg   = "#bfbfbf",
  inactive_bg = "#f0f0f0",
  border      = "#bababa",

  -- Red
  red         = "#b3303a",
  red_warmer  = "#e00033",
  red_cooler  = "#ce2b50",
  red_faint   = "#b22222",

  -- Green
  green         = "#228b22",
  green_warmer  = "#4f7400",
  green_cooler  = "#008858",
  green_faint   = "#61756c",

  -- Yellow
  yellow         = "#a45f22",
  yellow_warmer  = "#b6532f",
  yellow_cooler  = "#a0522d",
  yellow_faint   = "#76502a",

  -- Blue
  blue         = "#001faf",
  blue_warmer  = "#3a5fcd",
  blue_cooler  = "#0000ff",
  blue_faint   = "#483d8b",

  -- Magenta
  magenta         = "#721045",
  magenta_warmer  = "#8b2252",
  magenta_cooler  = "#800080",
  magenta_faint   = "#8f4499",

  -- Cyan
  cyan         = "#1f6fbf",
  cyan_warmer  = "#2f8fab",
  cyan_cooler  = "#008b8b",
  cyan_faint   = "#3f7a80",

  -- Intense backgrounds
  bg_red_intense     = "#ff8f88",
  bg_green_intense   = "#8adf80",
  bg_yellow_intense  = "#f3d000",
  bg_blue_intense    = "#bfc9ff",
  bg_magenta_intense = "#dfa0f0",
  bg_cyan_intense    = "#a4d5f9",

  -- Subtle backgrounds
  bg_red_subtle     = "#ffcfbf",
  bg_green_subtle   = "#b3fabf",
  bg_yellow_subtle  = "#fff576",
  bg_blue_subtle    = "#ccdfff",
  bg_magenta_subtle = "#ffddff",
  bg_cyan_subtle    = "#bfefff",

  -- Nuanced backgrounds
  bg_red_nuanced     = "#fff1f0",
  bg_green_nuanced   = "#ecf7ed",
  bg_yellow_nuanced  = "#fff3da",
  bg_blue_nuanced    = "#f3f3ff",
  bg_magenta_nuanced = "#fdf0ff",
  bg_cyan_nuanced    = "#ebf6fa",

  -- Diff
  bg_added         = "#c0f8d0",
  bg_added_faint   = "#d0ffe0",
  bg_added_refine  = "#b4e8c4",
  fg_added         = "#007200",
  bg_changed       = "#ffdfa9",
  bg_changed_faint = "#ffefbf",
  bg_changed_refine = "#fac090",
  fg_changed       = "#8d6a12",
  bg_removed       = "#ffd8d5",
  bg_removed_faint = "#ffe9e9",
  bg_removed_refine = "#f3b5af",
  fg_removed       = "#a02a2a",

  -- UI
  bg_completion = "#bfe8ff",
  bg_hover      = "#aaeccf",
  bg_hl_line    = "#b4eeb4",
  bg_region     = "#eedc82",
  bg_paren      = "#40e0d0",
  bg_popup      = "#f3f3f3",

  -- Statusline
  sl_active_bg    = "#b3b3b3",
  sl_active_fg    = "#000000",
  sl_active_border = "#5a5a5a",
  sl_inactive_bg  = "#e5e5e5",
  sl_inactive_fg  = "#7f7f7f",

  -- Diagnostics
  underline_err     = "#ef0f1f",
  underline_warning = "#bf5f00",
  underline_note    = "#02af52",
  modeline_err      = "#b02020",
  modeline_warning  = "#5f1080",
  modeline_info     = "#002fb0",
}

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

hi("Normal",        { fg = c.fg, bg = c.bg })
hi("NormalNC",      { fg = c.fg, bg = c.bg })
hi("Cursor",        { fg = c.bg, bg = c.fg })
hi("CursorIM",      { fg = c.bg, bg = c.fg })
hi("CursorLine",    { bg = c.inactive_bg })
hi("CursorColumn",  { bg = c.inactive_bg })
hi("ColorColumn",   { bg = c.dim_bg })
hi("Visual",        { bg = c.bg_region })
hi("VisualNOS",     { fg = c.fg, gui = "underline" })

hi("LineNr",        { fg = c.dim_fg, bg = c.bg })
hi("CursorLineNr",  { fg = c.fg, bg = c.bg, gui = "bold" })
hi("SignColumn",    { fg = c.dim_fg, bg = c.bg })

hi("StatusLine",    { fg = c.sl_active_fg, bg = c.sl_active_bg, gui = "bold" })
hi("StatusLineNC",  { fg = c.sl_inactive_fg, bg = c.sl_inactive_bg })
hi("VertSplit",     { fg = c.border, bg = c.border })
hi("WinSeparator",  { fg = c.border, bg = c.border })

hi("TabLineFill",   { bg = c.alt_bg })
hi("TabLine",       { fg = c.dim_fg, bg = c.alt_bg })
hi("TabLineSel",    { fg = c.fg, bg = c.bg, gui = "bold" })

hi("Folded",        { fg = c.fg, bg = c.dim_bg, gui = "bold" })
hi("FoldColumn",    { fg = c.dim_fg, bg = c.bg })

hi("NonText",       { fg = c.border })
hi("SpecialKey",    { fg = c.dim_fg })
hi("Whitespace",    { fg = c.border })
hi("EndOfBuffer",   { fg = c.alt_bg })

hi("WildMenu",      { fg = c.fg, bg = c.bg_completion })

-- ============================================================================
-- Popup menu / Floating windows
-- ============================================================================

hi("Pmenu",         { fg = c.fg, bg = c.bg_popup })
hi("PmenuSel",      { fg = c.fg, bg = c.bg_completion })
hi("PmenuSbar",     { bg = c.alt_bg })
hi("PmenuThumb",    { bg = c.active_bg })

hi("NormalFloat",   { fg = c.fg, bg = c.bg_popup })
hi("FloatBorder",   { fg = c.border, bg = c.bg_popup })
hi("FloatTitle",    { fg = c.fg, bg = c.bg_popup, gui = "bold" })

-- ============================================================================
-- Search / Match
-- ============================================================================

hi("Search",        { fg = c.fg, bg = c.bg_cyan_intense })
hi("IncSearch",     { fg = c.fg, bg = c.bg_yellow_intense })
hi("CurSearch",     { fg = c.fg, bg = c.bg_magenta_intense, gui = "bold" })
hi("MatchParen",    { fg = c.fg, bg = c.bg_paren })

-- ============================================================================
-- Messages
-- ============================================================================

hi("ErrorMsg",      { fg = c.red_warmer })
hi("WarningMsg",    { fg = c.yellow_warmer })
hi("ModeMsg",       { fg = c.fg, gui = "bold" })
hi("MoreMsg",       { fg = c.green, gui = "bold" })
hi("Question",      { fg = c.blue })

-- ============================================================================
-- Syntax — colorful, following the Emacs standard-light palette
-- ============================================================================

hi("Comment",       { fg = c.red_faint, gui = "italic" })
hi("Conceal",       { fg = c.dim_fg })

hi("Constant",      { fg = c.cyan_cooler })
hi("String",        { fg = c.magenta_warmer })
hi("Character",     { fg = c.magenta_warmer })
hi("Number",        { fg = c.cyan_cooler })
hi("Boolean",       { fg = c.cyan_cooler })
hi("Float",         { fg = c.cyan_cooler })

hi("Identifier",    { fg = c.fg })
hi("Function",      { fg = c.blue_cooler })

hi("Statement",     { fg = c.magenta_cooler })
hi("Conditional",   { fg = c.magenta_cooler })
hi("Repeat",        { fg = c.magenta_cooler })
hi("Label",         { fg = c.magenta_cooler })
hi("Operator",      { fg = c.fg })
hi("Keyword",       { fg = c.magenta_cooler })
hi("Exception",     { fg = c.magenta_cooler })

hi("PreProc",       { fg = c.blue_faint })
hi("Include",       { fg = c.blue_faint })
hi("Define",        { fg = c.blue_faint })
hi("Macro",         { fg = c.green_warmer })
hi("PreCondit",     { fg = c.blue_faint })

hi("Type",          { fg = c.green })
hi("StorageClass",  { fg = c.green })
hi("Structure",     { fg = c.green })
hi("Typedef",       { fg = c.green })

hi("Special",       { fg = c.cyan_cooler, gui = "italic" })
hi("SpecialChar",   { fg = c.cyan_cooler, gui = "italic" })
hi("Tag",           { fg = c.blue })
hi("Delimiter",     { fg = c.fg })
hi("SpecialComment", { fg = c.red_faint, gui = "bold,italic" })
hi("Debug",         { fg = c.red })

hi("Underlined",    { fg = c.blue_warmer, gui = "underline" })
hi("Ignore",        { fg = c.bg })
hi("Error",         { fg = c.red_warmer, gui = "bold" })
hi("Todo",          { fg = c.magenta_cooler, gui = "bold" })
hi("Title",         { fg = c.fg, gui = "bold" })
hi("Directory",     { fg = c.blue })

-- ============================================================================
-- Diff
-- ============================================================================

hi("DiffAdd",       { fg = c.fg_added, bg = c.bg_added })
hi("DiffChange",    { fg = c.fg_changed, bg = c.bg_changed })
hi("DiffDelete",    { fg = c.fg_removed, bg = c.bg_removed })
hi("DiffText",      { fg = c.fg_changed, bg = c.bg_changed_refine, gui = "bold" })

hi("Added",         { fg = c.fg_added })
hi("Changed",       { fg = c.fg_changed })
hi("Removed",       { fg = c.fg_removed })

hi("diffAdded",     { fg = c.fg_added })
hi("diffRemoved",   { fg = c.fg_removed })
hi("diffChanged",   { fg = c.fg_changed })
hi("diffOldFile",   { fg = c.fg_removed })
hi("diffNewFile",   { fg = c.fg_added })
hi("diffFile",      { fg = c.fg, gui = "bold" })
hi("diffLine",      { fg = c.dim_fg })

-- ============================================================================
-- Spelling
-- ============================================================================

hi("SpellBad",      { gui = "undercurl", sp = c.underline_err })
hi("SpellCap",      { gui = "undercurl", sp = c.underline_warning })
hi("SpellLocal",    { gui = "undercurl", sp = c.yellow })
hi("SpellRare",     { gui = "undercurl", sp = c.underline_note })

-- ============================================================================
-- Diagnostics (LSP)
-- ============================================================================

hi("DiagnosticError", { fg = c.red_warmer })
hi("DiagnosticWarn",  { fg = c.yellow_warmer })
hi("DiagnosticInfo",  { fg = c.green })
hi("DiagnosticHint",  { fg = c.dim_fg })
hi("DiagnosticOk",    { fg = c.green_cooler })

hi("DiagnosticUnderlineError", { gui = "undercurl", sp = c.underline_err })
hi("DiagnosticUnderlineWarn",  { gui = "undercurl", sp = c.underline_warning })
hi("DiagnosticUnderlineInfo",  { gui = "undercurl", sp = c.underline_note })
hi("DiagnosticUnderlineHint",  { gui = "undercurl", sp = c.dim_fg })

hi("LspReferenceText",  { bg = c.bg_cyan_subtle })
hi("LspReferenceRead",  { bg = c.bg_cyan_subtle })
hi("LspReferenceWrite", { bg = c.bg_yellow_subtle })

-- ============================================================================
-- Git Signs
-- ============================================================================

hi("GitSignsAdd",       { fg = c.fg_added, bg = c.bg })
hi("GitSignsChange",    { fg = c.fg_changed, bg = c.bg })
hi("GitSignsDelete",    { fg = c.fg_removed, bg = c.bg })
hi("GitSignsAddNr",     { fg = c.fg_added })
hi("GitSignsChangeNr",  { fg = c.fg_changed })
hi("GitSignsDeleteNr",  { fg = c.fg_removed })
hi("GitSignsAddLn",     { bg = c.bg_added_faint })
hi("GitSignsChangeLn",  { bg = c.bg_changed_faint })
hi("GitSignsDeleteLn",  { bg = c.bg_removed_faint })

-- ============================================================================
-- Treesitter
-- ============================================================================

hi("@comment",              { fg = c.red_faint, gui = "italic" })
hi("@string",               { fg = c.magenta_warmer })
hi("@string.escape",        { fg = c.green, gui = "bold" })
hi("@string.regex",         { fg = c.green })
hi("@string.special",       { fg = c.cyan_cooler, gui = "italic" })
hi("@number",               { fg = c.cyan_cooler })
hi("@float",                { fg = c.cyan_cooler })
hi("@boolean",              { fg = c.cyan_cooler })
hi("@character",            { fg = c.magenta_warmer })

hi("@constant",             { fg = c.cyan_cooler })
hi("@constant.builtin",     { fg = c.cyan_cooler })
hi("@constant.macro",       { fg = c.green_warmer })

hi("@variable",             { fg = c.yellow_cooler })
hi("@variable.builtin",     { fg = c.yellow_cooler, gui = "italic" })
hi("@variable.parameter",   { fg = c.yellow_faint })
hi("@parameter",            { fg = c.yellow_faint })

hi("@field",                { fg = c.yellow_cooler })
hi("@property",             { fg = c.yellow_cooler })

hi("@function",             { fg = c.blue_cooler })
hi("@function.builtin",     { fg = c.blue_faint })
hi("@function.call",        { fg = c.blue_faint })
hi("@function.method",      { fg = c.blue_cooler })
hi("@function.method.call", { fg = c.blue_faint })
hi("@function.signature",   { fg = c.blue_cooler, gui = "bold" })
hi("@method",               { fg = c.blue_cooler })
hi("@method.call",          { fg = c.blue_faint })
hi("@constructor",          { fg = c.blue_cooler, gui = "bold" })

hi("@type",                 { fg = c.green })
hi("@type.builtin",         { fg = c.green })
hi("@type.definition",      { fg = c.green, gui = "bold" })
hi("@type.qualifier",       { fg = c.magenta_cooler })

hi("@module",               { fg = c.blue_faint })
hi("@namespace",            { fg = c.blue_faint })

hi("@keyword",              { fg = c.magenta_cooler })
hi("@keyword.function",     { fg = c.magenta_cooler })
hi("@keyword.return",       { fg = c.magenta_cooler })
hi("@keyword.operator",     { fg = c.magenta_cooler })
hi("@keyword.import",       { fg = c.blue_faint })
hi("@keyword.conditional",  { fg = c.magenta_cooler })
hi("@keyword.repeat",       { fg = c.magenta_cooler })
hi("@keyword.exception",    { fg = c.magenta_cooler })

hi("@operator",             { fg = c.fg })

hi("@punctuation.delimiter", { fg = c.fg })
hi("@punctuation.bracket",   { fg = c.fg })
hi("@punctuation.special",   { fg = c.cyan_cooler, gui = "italic" })

hi("@tag",                  { fg = c.blue })
hi("@tag.attribute",        { fg = c.yellow_cooler })
hi("@tag.delimiter",        { fg = c.fg })

hi("@attribute",            { fg = c.blue_faint })
hi("@label",                { fg = c.magenta_cooler })

hi("@markup.heading",       { fg = c.fg, gui = "bold" })
hi("@markup.link",          { fg = c.blue_warmer, gui = "underline" })
hi("@markup.link.url",      { fg = c.blue_warmer, gui = "underline" })
hi("@markup.italic",        { gui = "italic" })
hi("@markup.bold",          { gui = "bold" })
hi("@markup.list",          { fg = c.fg })
hi("@markup.quote",         { fg = c.red_faint, gui = "italic" })
hi("@markup.raw",           { fg = c.cyan_cooler })
hi("@markup.raw.block",     { fg = c.cyan_cooler })

hi("@diff.plus",            { fg = c.fg_added })
hi("@diff.minus",           { fg = c.fg_removed })
hi("@diff.delta",           { fg = c.fg_changed })

-- ============================================================================
-- Telescope
-- ============================================================================

hi("TelescopeNormal",         { fg = c.fg, bg = c.bg_popup })
hi("TelescopeBorder",         { fg = c.border, bg = c.bg_popup })
hi("TelescopeTitle",          { fg = c.bg, bg = c.blue, gui = "bold" })
hi("TelescopePromptNormal",   { fg = c.fg, bg = c.bg_popup })
hi("TelescopePromptBorder",   { fg = c.border, bg = c.bg_popup })
hi("TelescopePromptTitle",    { fg = c.bg, bg = c.blue, gui = "bold" })
hi("TelescopeResultsNormal",  { fg = c.fg, bg = c.bg_popup })
hi("TelescopeResultsBorder",  { fg = c.border, bg = c.bg_popup })
hi("TelescopeResultsTitle",   { fg = c.bg, bg = c.blue, gui = "bold" })
hi("TelescopePreviewNormal",  { fg = c.fg, bg = c.bg_popup })
hi("TelescopePreviewBorder",  { fg = c.border, bg = c.bg_popup })
hi("TelescopePreviewTitle",   { fg = c.bg, bg = c.blue, gui = "bold" })
hi("TelescopeSelection",      { fg = c.fg, bg = c.bg_completion })
hi("TelescopeSelectionCaret", { fg = c.blue, bg = c.bg_completion, gui = "bold" })
hi("TelescopeMatching",       { fg = c.red_warmer, gui = "bold" })

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

hi("LazyNormal",       { fg = c.fg, bg = c.bg_popup })
hi("LazyBorder",       { fg = c.border, bg = c.bg_popup })
hi("LazyH1",           { fg = c.bg, bg = c.blue, gui = "bold" })
hi("LazyButton",       { fg = c.fg, bg = c.alt_bg })
hi("LazyButtonActive", { fg = c.bg, bg = c.blue, gui = "bold" })

-- ============================================================================
-- WhichKey
-- ============================================================================

hi("WhichKeyFloat",  { bg = c.bg_popup })
hi("WhichKeyBorder", { fg = c.border, bg = c.bg_popup })

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
-- Terminal colors
-- ============================================================================

vim.g.terminal_color_0  = "#000000"  -- black
vim.g.terminal_color_1  = "#b3303a"  -- red
vim.g.terminal_color_2  = "#228b22"  -- green
vim.g.terminal_color_3  = "#a45f22"  -- yellow
vim.g.terminal_color_4  = "#001faf"  -- blue
vim.g.terminal_color_5  = "#721045"  -- magenta
vim.g.terminal_color_6  = "#1f6fbf"  -- cyan
vim.g.terminal_color_7  = "#ffffff"  -- white
vim.g.terminal_color_8  = "#7f7f7f"  -- bright black
vim.g.terminal_color_9  = "#e00033"  -- bright red
vim.g.terminal_color_10 = "#008858"  -- bright green
vim.g.terminal_color_11 = "#b6532f"  -- bright yellow
vim.g.terminal_color_12 = "#3a5fcd"  -- bright blue
vim.g.terminal_color_13 = "#800080"  -- bright magenta
vim.g.terminal_color_14 = "#2f8fab"  -- bright cyan
vim.g.terminal_color_15 = "#ebebeb"  -- bright white
