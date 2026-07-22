vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "chillfocus"

local palettes = {
  dark = {
    bg = "#101819",
    bg_alt = "#182324",
    bg_focus = "#1D2B2C",
    selection = "#29413F",
    fg = "#C5C2B6",
    fg_dim = "#9A9E95",
    comment = "#788784",
    cyan = "#8FAAA2",
    blue = "#96A9B5",
    green = "#A7AD84",
    sand = "#B09D88",
    yellow = "#C3A467",
    red = "#C27B76",
    diff_add = "#23352F",
    diff_change = "#263336",
    diff_delete = "#352527",
    diff_text = "#324447",
  },
  light = {
    bg = "#F3F1E8",
    bg_alt = "#E7E9E2",
    bg_focus = "#DCE3DE",
    selection = "#CBDDD7",
    fg = "#354341",
    fg_dim = "#566561",
    comment = "#62716D",
    cyan = "#3F7069",
    blue = "#456D82",
    green = "#617340",
    sand = "#7C614B",
    yellow = "#88681E",
    red = "#98504C",
    diff_add = "#DBE6D7",
    diff_change = "#D9E4E8",
    diff_delete = "#EAD8D6",
    diff_text = "#C9DADF",
  },
}

local colors = palettes[vim.o.background]

local function highlight(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function link(group, target)
  highlight(group, { link = target })
end

highlight("Normal", { fg = colors.fg, bg = colors.bg })
highlight("NormalNC", { fg = colors.fg_dim, bg = colors.bg })
highlight("NormalFloat", { fg = colors.fg, bg = colors.bg_alt })
highlight("FloatBorder", { fg = colors.comment, bg = colors.bg_alt })
highlight("FloatTitle", { fg = colors.cyan, bg = colors.bg_alt })
highlight("FloatFooter", { fg = colors.comment, bg = colors.bg_alt })
highlight("ColorColumn", { bg = colors.bg_alt })
highlight("Cursor", { fg = colors.bg, bg = colors.fg })
highlight("CursorColumn", { bg = colors.bg_alt })
highlight("CursorLine", { bg = colors.bg_alt })
highlight("CursorLineNr", { fg = colors.sand, bg = colors.bg_alt })
highlight("LineNr", { fg = colors.comment, bg = colors.bg })
highlight("SignColumn", { fg = colors.comment, bg = colors.bg })
highlight("FoldColumn", { fg = colors.comment, bg = colors.bg })
highlight("Folded", { fg = colors.fg_dim, bg = colors.bg_alt })
highlight("EndOfBuffer", { fg = colors.bg, bg = colors.bg })
highlight("NonText", { fg = colors.comment })
highlight("Whitespace", { fg = colors.bg_focus })
highlight("SpecialKey", { fg = colors.comment })
highlight("WinSeparator", { fg = colors.bg_focus })
highlight("VertSplit", { fg = colors.bg_focus })

highlight("Visual", { bg = colors.selection })
highlight("VisualNOS", { bg = colors.selection })
highlight("Search", { fg = colors.bg, bg = colors.sand })
highlight("IncSearch", { fg = colors.bg, bg = colors.yellow })
highlight("CurSearch", { fg = colors.bg, bg = colors.yellow })
highlight("Substitute", { fg = colors.bg, bg = colors.cyan })
highlight("MatchParen", { fg = colors.fg, bg = colors.selection })

highlight("Pmenu", { fg = colors.fg, bg = colors.bg_alt })
highlight("PmenuSel", { fg = colors.fg, bg = colors.selection })
highlight("PmenuKind", { fg = colors.blue, bg = colors.bg_alt })
highlight("PmenuKindSel", { fg = colors.blue, bg = colors.selection })
highlight("PmenuExtra", { fg = colors.comment, bg = colors.bg_alt })
highlight("PmenuExtraSel", { fg = colors.fg_dim, bg = colors.selection })
highlight("PmenuSbar", { bg = colors.bg_focus })
highlight("PmenuThumb", { bg = colors.comment })

highlight("StatusLine", { fg = colors.fg, bg = colors.bg_focus })
highlight("StatusLineNC", { fg = colors.comment, bg = colors.bg_alt })
highlight("TabLine", { fg = colors.fg_dim, bg = colors.bg_alt })
highlight("TabLineSel", { fg = colors.fg, bg = colors.selection })
highlight("TabLineFill", { bg = colors.bg })
highlight("WinBar", { fg = colors.fg_dim, bg = colors.bg })
highlight("WinBarNC", { fg = colors.comment, bg = colors.bg })

highlight("Directory", { fg = colors.blue })
highlight("Title", { fg = colors.cyan })
highlight("Question", { fg = colors.green })
highlight("MoreMsg", { fg = colors.green })
highlight("ModeMsg", { fg = colors.fg_dim })
highlight("WarningMsg", { fg = colors.yellow })
highlight("ErrorMsg", { fg = colors.red })
highlight("Error", { fg = colors.red })
highlight("Todo", { fg = colors.bg, bg = colors.yellow })
highlight("QuickFixLine", { bg = colors.selection })
highlight("WildMenu", { fg = colors.bg, bg = colors.cyan })

highlight("Comment", { fg = colors.comment })
highlight("Constant", { fg = colors.sand })
highlight("String", { fg = colors.green })
highlight("Character", { fg = colors.green })
highlight("Number", { fg = colors.sand })
highlight("Boolean", { fg = colors.sand })
highlight("Float", { fg = colors.sand })
highlight("Identifier", { fg = colors.fg })
highlight("Function", { fg = colors.blue })
highlight("Statement", { fg = colors.cyan })
highlight("Conditional", { fg = colors.cyan })
highlight("Repeat", { fg = colors.cyan })
highlight("Label", { fg = colors.cyan })
highlight("Operator", { fg = colors.fg_dim })
highlight("Keyword", { fg = colors.cyan })
highlight("Exception", { fg = colors.cyan })
highlight("PreProc", { fg = colors.sand })
highlight("Include", { fg = colors.cyan })
highlight("Define", { fg = colors.sand })
highlight("Macro", { fg = colors.sand })
highlight("PreCondit", { fg = colors.sand })
highlight("Type", { fg = colors.blue })
highlight("StorageClass", { fg = colors.blue })
highlight("Structure", { fg = colors.blue })
highlight("Typedef", { fg = colors.blue })
highlight("Special", { fg = colors.cyan })
highlight("SpecialChar", { fg = colors.cyan })
highlight("Tag", { fg = colors.blue })
highlight("Delimiter", { fg = colors.fg_dim })
highlight("SpecialComment", { fg = colors.comment })
highlight("Debug", { fg = colors.red })
highlight("Underlined", { fg = colors.blue, underline = true })
highlight("Ignore", { fg = colors.comment })

highlight("DiagnosticError", { fg = colors.red })
highlight("DiagnosticWarn", { fg = colors.yellow })
highlight("DiagnosticInfo", { fg = colors.blue })
highlight("DiagnosticHint", { fg = colors.cyan })
highlight("DiagnosticOk", { fg = colors.green })
highlight("DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
highlight("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.yellow })
highlight("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.blue })
highlight("DiagnosticUnderlineHint", { undercurl = true, sp = colors.cyan })

highlight("DiffAdd", { fg = colors.green, bg = colors.diff_add })
highlight("DiffChange", { fg = colors.blue, bg = colors.diff_change })
highlight("DiffDelete", { fg = colors.red, bg = colors.diff_delete })
highlight("DiffText", { fg = colors.fg, bg = colors.diff_text })
highlight("Added", { fg = colors.green })
highlight("Changed", { fg = colors.blue })
highlight("Removed", { fg = colors.red })

link("@comment", "Comment")
link("@constant", "Constant")
link("@constant.builtin", "Constant")
link("@string", "String")
link("@string.escape", "SpecialChar")
link("@number", "Number")
link("@boolean", "Boolean")
link("@variable", "Identifier")
link("@variable.builtin", "Identifier")
link("@variable.member", "Identifier")
link("@variable.parameter", "Identifier")
link("@function", "Function")
link("@function.builtin", "Function")
link("@function.call", "Function")
link("@function.method", "Function")
link("@constructor", "Type")
link("@keyword", "Keyword")
link("@keyword.function", "Keyword")
link("@keyword.return", "Keyword")
link("@operator", "Operator")
link("@type", "Type")
link("@type.builtin", "Type")
link("@property", "Identifier")
link("@attribute", "PreProc")
link("@punctuation", "Delimiter")
link("@tag", "Tag")
link("@tag.attribute", "Identifier")
link("@tag.delimiter", "Delimiter")
link("@markup.heading", "Title")
link("@markup.link", "Underlined")
link("@markup.raw", "String")

link("@lsp.type.variable", "@variable")
link("@lsp.type.parameter", "@variable.parameter")
link("@lsp.type.property", "@property")
link("@lsp.type.function", "@function")
link("@lsp.type.method", "@function.method")
link("@lsp.type.type", "@type")
link("@lsp.type.class", "@type")
link("@lsp.type.interface", "@type")
link("@lsp.type.enum", "@type")
link("@lsp.type.keyword", "@keyword")
link("@lsp.type.comment", "@comment")

highlight("GitSignsAdd", { fg = colors.green })
highlight("GitSignsChange", { fg = colors.blue })
highlight("GitSignsDelete", { fg = colors.red })
highlight("GitSignsCurrentLineBlame", { fg = colors.comment })

highlight("TelescopeNormal", { fg = colors.fg, bg = colors.bg_alt })
highlight("TelescopeBorder", { fg = colors.bg_focus, bg = colors.bg_alt })
highlight("TelescopePromptNormal", { fg = colors.fg, bg = colors.bg_focus })
highlight("TelescopePromptBorder", { fg = colors.selection, bg = colors.bg_focus })
highlight("TelescopePromptTitle", { fg = colors.cyan, bg = colors.bg_focus })
highlight("TelescopeResultsTitle", { fg = colors.blue, bg = colors.bg_alt })
highlight("TelescopePreviewTitle", { fg = colors.green, bg = colors.bg_alt })
highlight("TelescopeSelection", { bg = colors.selection })
highlight("TelescopeMatching", { fg = colors.yellow })

highlight("NvimTreeNormal", { fg = colors.fg, bg = colors.bg_alt })
highlight("NvimTreeNormalNC", { fg = colors.fg_dim, bg = colors.bg_alt })
highlight("NvimTreeEndOfBuffer", { fg = colors.bg_alt, bg = colors.bg_alt })
highlight("NvimTreeCursorLine", { bg = colors.selection })
highlight("NvimTreeFolderName", { fg = colors.blue })
highlight("NvimTreeOpenedFolderName", { fg = colors.cyan })
highlight("NvimTreeRootFolder", { fg = colors.comment })
highlight("NvimTreeGitDirty", { fg = colors.yellow })
highlight("NvimTreeGitNew", { fg = colors.green })
highlight("NvimTreeGitDeleted", { fg = colors.red })

highlight("WhichKey", { fg = colors.cyan })
highlight("WhichKeyGroup", { fg = colors.blue })
highlight("WhichKeyDesc", { fg = colors.fg })
highlight("WhichKeySeparator", { fg = colors.comment })
highlight("WhichKeyFloat", { bg = colors.bg_alt })

highlight("IblIndent", { fg = colors.bg_focus })
highlight("IblScope", { fg = colors.comment })
highlight("IndentBlanklineChar", { fg = colors.bg_focus })
highlight("IndentBlanklineContextChar", { fg = colors.comment })

highlight("BlinkCmpMenu", { fg = colors.fg, bg = colors.bg_alt })
highlight("BlinkCmpMenuSelection", { fg = colors.fg, bg = colors.selection })
highlight("BlinkCmpLabelDeprecated", { fg = colors.comment, strikethrough = true })
highlight("BlinkCmpLabelMatch", { fg = colors.yellow })
highlight("BlinkCmpKind", { fg = colors.blue })
highlight("BlinkCmpSource", { fg = colors.comment })
highlight("BlinkCmpDoc", { fg = colors.fg, bg = colors.bg_alt })
highlight("BlinkCmpDocBorder", { fg = colors.comment, bg = colors.bg_alt })

highlight("NeogitDiffAdd", { fg = colors.green, bg = colors.diff_add })
highlight("NeogitDiffDelete", { fg = colors.red, bg = colors.diff_delete })
highlight("NeogitDiffContext", { fg = colors.fg_dim, bg = colors.bg })
highlight("NeogitHunkHeader", { fg = colors.fg_dim, bg = colors.bg_alt })
highlight("NeogitHunkHeaderHighlight", { fg = colors.fg, bg = colors.selection })
highlight("NeogitBranch", { fg = colors.cyan })
highlight("NeogitRemote", { fg = colors.blue })
