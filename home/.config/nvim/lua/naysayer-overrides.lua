local M = {}

local palette = {
  background = "#092b2b",
  surface = "#2c2e33",
  surface_bright = "#4f5258",
  foreground = "#d1b897",
  white = "#ffffff",
  teal = "#7ad0c6",
  cyan = "#8cf8f7",
  blue = "#add8e6",
  visual = "#0000ff",
  pink = "#ff008c",
  green = "#2ec09c",
  green_bright = "#8cde94",
  yellow = "#fce094",
  red = "#d64c42",
}

local groups = {
  Normal = { fg = palette.foreground, bg = palette.background },
  NormalNC = { fg = palette.foreground, bg = palette.background },
  EndOfBuffer = { fg = palette.background, bg = palette.background },
  NormalFloat = { fg = palette.foreground, bg = palette.surface },
  FloatBorder = { fg = palette.surface_bright, bg = palette.surface },
  WinSeparator = { fg = palette.surface_bright, bg = palette.background },
  SignColumn = { fg = palette.surface_bright, bg = palette.background },
  FoldColumn = { fg = palette.surface_bright, bg = palette.background },
  Folded = { fg = palette.teal, bg = palette.surface },
  CursorLineNr = { fg = palette.foreground, bold = true },
  QuickFixLine = { bg = palette.surface },
  Title = { fg = palette.white, bold = true },
  Question = { fg = palette.green_bright },
  Todo = { fg = palette.background, bg = palette.yellow, bold = true },
  Underlined = { fg = palette.cyan, underline = true },
  SpellBad = { undercurl = true, sp = palette.red },
  SpellCap = { undercurl = true, sp = palette.blue },
  SpellLocal = { undercurl = true, sp = palette.teal },
  SpellRare = { undercurl = true, sp = palette.pink },

  ["@variable.member"] = { fg = palette.teal },
  ["@property"] = { fg = palette.teal },
  ["@module"] = { fg = palette.foreground },
  ["@module.builtin"] = { fg = palette.foreground },
  ["@function.call"] = { fg = palette.foreground },
  ["@function.method"] = { fg = palette.foreground },
  ["@function.method.call"] = { fg = palette.foreground },
  ["@constructor"] = { fg = palette.green_bright },
  ["@attribute"] = { fg = palette.green_bright },
  ["@tag"] = { fg = palette.white },
  ["@tag.attribute"] = { fg = palette.teal },
  ["@tag.delimiter"] = { fg = palette.foreground },
  ["@markup.heading"] = { fg = palette.white, bold = true },
  ["@markup.link"] = { fg = palette.cyan, underline = true },
  ["@markup.link.label"] = { fg = palette.teal },
  ["@markup.raw"] = { fg = palette.green },
  ["@diff.plus"] = { fg = palette.green_bright },
  ["@diff.minus"] = { fg = palette.red },
  ["@diff.delta"] = { fg = palette.yellow },

  TelescopeNormal = { fg = palette.foreground, bg = palette.background },
  TelescopeBorder = { fg = palette.surface_bright, bg = palette.background },
  TelescopePromptNormal = { fg = palette.foreground, bg = palette.surface },
  TelescopePromptBorder = { fg = palette.surface_bright, bg = palette.surface },
  TelescopePromptPrefix = { fg = palette.green_bright, bg = palette.surface },
  TelescopeSelection = { fg = palette.white, bg = palette.surface },
  TelescopeMatching = { fg = palette.teal, bold = true },

  NvimTreeNormal = { fg = palette.foreground, bg = palette.background },
  NvimTreeNormalNC = { fg = palette.foreground, bg = palette.background },
  NvimTreeRootFolder = { fg = palette.white, bold = true },
  NvimTreeFolderName = { fg = palette.cyan },
  NvimTreeOpenedFolderName = { fg = palette.cyan, bold = true },
  NvimTreeGitDirty = { fg = palette.yellow },
  NvimTreeGitNew = { fg = palette.green_bright },
  NvimTreeGitDeleted = { fg = palette.red },
  NvimTreeIndentMarker = { fg = palette.surface_bright },

  GitSignsAdd = { fg = palette.green_bright },
  GitSignsChange = { fg = palette.yellow },
  GitSignsDelete = { fg = palette.red },
  DiffAdd = { fg = palette.green_bright, bg = palette.background },
  DiffChange = { fg = palette.yellow, bg = palette.background },
  DiffDelete = { fg = palette.red, bg = palette.background },
  DiffText = { fg = palette.background, bg = palette.yellow },

  WhichKey = { fg = palette.teal },
  WhichKeyGroup = { fg = palette.green_bright },
  WhichKeyDesc = { fg = palette.foreground },
  WhichKeySeparator = { fg = palette.surface_bright },
  WhichKeyFloat = { bg = palette.surface },

  LazyButton = { fg = palette.foreground, bg = palette.surface },
  LazyButtonActive = { fg = palette.background, bg = palette.foreground, bold = true },
  LazyH1 = { fg = palette.background, bg = palette.foreground, bold = true },
  MasonHeader = { fg = palette.background, bg = palette.foreground, bold = true },
  MasonHighlight = { fg = palette.teal },
  MasonHighlightBlock = { fg = palette.background, bg = palette.teal },
}

function M.apply()
  for name, highlight in pairs(groups) do
    vim.api.nvim_set_hl(0, name, highlight)
  end

  vim.g.colors_name = "naysayer"
end

return M
