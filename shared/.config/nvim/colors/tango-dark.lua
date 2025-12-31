-- tango-dark.lua
-- Neovim colorscheme based on Emacs tango-dark, now powered by colorbuddy

local ok, colorbuddy = pcall(require, "colorbuddy")
if not ok then
  return
end

vim.cmd("highlight clear")
vim.cmd("set background=dark")
vim.g.colors_name = "tango-dark"

local Color = colorbuddy.Color
local Group = colorbuddy.Group
local s = colorbuddy.styles
local c = colorbuddy.colors

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

for name, hex in pairs(colors) do
  Color.new(name, hex)
end

-- UI
Group.new('Normal', c.alum1, c.alum6)
Group.new('Cursor', nil, c.butter1)
Group.new('CursorLine', nil, c.alum7)
Group.new('Visual', c.alum1, c.alum5)
Group.new('LineNr', c.alum4, nil)
Group.new('CursorLineNr', c.orange1, c.alum7, s.bold)
Group.new('StatusLine', c.alum1, c.alum5_5, s.bold)
Group.new('StatusLineNC', c.alum4, c.alum6, s.italic)
Group.new('VertSplit', c.alum5, c.alum6)
Group.new('WinSeparator', c.alum5, c.alum6)
Group.new('NormalFloat', c.alum1, c.alum6)
Group.new('FloatBorder', c.alum5, c.alum6)
Group.new('FloatTitle', c.butter1, c.alum6, s.bold)
Group.new('Pmenu', c.alum1, c.alum6)
Group.new('PmenuSel', c.alum6, c.butter2, s.bold)
Group.new('PmenuSbar', nil, c.alum5)
Group.new('PmenuThumb', nil, c.alum4)
Group.new('Search', c.alum1, c.orange3, s.italic)
Group.new('IncSearch', c.alum1, c.orange3, s.bold)
Group.new('MatchParen', c.alum7, c.cham0, s.bold)
Group.new('SignColumn', c.alum4, c.alum6)

-- Syntax
Group.new('Comment', c.cham2, nil, s.italic)
Group.new('Constant', c.plum0)
Group.new('String', c.choc1)
Group.new('Character', c.choc1)
Group.new('Number', c.plum0)
Group.new('Boolean', c.plum0)
Group.new('Identifier', c.orange1)
Group.new('Function', c.butter1, nil, s.bold)
Group.new('Statement', c.cham0, nil, s.bold)
Group.new('Conditional', c.cham0, nil, s.bold)
Group.new('Repeat', c.cham0, nil, s.bold)
Group.new('Label', c.butter1, nil, s.bold)
Group.new('Operator', c.cham0, nil, s.bold)
Group.new('Keyword', c.cham0, nil, s.bold)
Group.new('PreProc', c.plum1, nil, s.bold)
Group.new('Type', c.blue0, nil, s.bold)
Group.new('Special', c.orange1, nil, s.bold)
Group.new('Underlined', c.blue1, nil, s.underline)
Group.new('Error', c.red0, nil, s.bold)
Group.new('Todo', c.orange1, c.alum7, s.bold)

-- Diagnostics
Group.new('DiagnosticError', c.red0)
Group.new('DiagnosticWarn', c.orange1)
Group.new('DiagnosticInfo', c.blue1)
Group.new('DiagnosticHint', c.cham1)
Group.new('DiagnosticOk', c.cham0)

vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = colors.red0 })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true, sp = colors.orange1 })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true, sp = colors.blue1 })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true, sp = colors.cham1 })

-- Diffs
Group.new('DiffAdd', nil, c.cham3)
Group.new('DiffChange', nil, c.blue3)
Group.new('DiffDelete', nil, c.red3)
Group.new('DiffText', nil, c.butter2, s.bold)

-- Links/underlines
Group.new('Title', c.butter1, nil, s.bold)
Group.new('Directory', c.blue1, nil, s.bold)
Group.new('Hyperlink', c.blue1, nil, s.underline)
Group.new('VisualNOS', c.alum1, c.blue3)

-- Floating UIs for common plugins
Group.new('TelescopeNormal', c.alum1, c.alum6)
Group.new('TelescopeBorder', c.alum5, c.alum6)
Group.new('TelescopeTitle', c.alum6, c.butter2, s.bold)
Group.new('TelescopeSelection', c.butter1, c.alum5, s.bold)
Group.new('TelescopeSelectionCaret', c.butter2, c.alum5, s.bold)
Group.new('TelescopePromptNormal', c.alum1, c.alum6)
Group.new('TelescopePromptBorder', c.alum5, c.alum6)
Group.new('TelescopePromptTitle', c.alum6, c.butter2, s.bold)
Group.new('TelescopeResultsNormal', c.alum1, c.alum6)
Group.new('TelescopeResultsBorder', c.alum5, c.alum6)
Group.new('TelescopeResultsTitle', c.alum6, c.blue2, s.bold)
Group.new('TelescopePreviewNormal', c.alum1, c.alum6)
Group.new('TelescopePreviewBorder', c.alum5, c.alum6)
Group.new('TelescopePreviewTitle', c.alum6, c.cham1, s.bold)

Group.new('LazyNormal', c.alum1, c.alum6)
Group.new('LazyBorder', c.alum5, c.alum6)
Group.new('LazyH1', c.alum6, c.butter2, s.bold)
Group.new('LazyButton', c.alum1, c.alum6)
Group.new('LazyButtonActive', c.alum6, c.butter2, s.bold)

Group.new('NvimTreeNormalFloat', c.alum1, c.alum6)
Group.new('NvimTreeWinSeparator', c.alum5, c.alum6)

Group.new('WhichKeyFloat', nil, c.alum6)
Group.new('WhichKeyBorder', c.alum5, c.alum6)

-- lualine theme using full tango palette
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

vim.g.tango_dark_lualine_theme = M

vim.g.terminal_color_0  = colors.alum7
vim.g.terminal_color_1  = colors.red0
vim.g.terminal_color_2  = colors.cham0
vim.g.terminal_color_3  = colors.butter1
vim.g.terminal_color_4  = colors.blue1
vim.g.terminal_color_5  = colors.plum1
vim.g.terminal_color_6  = colors.blue0
vim.g.terminal_color_7  = colors.alum1
