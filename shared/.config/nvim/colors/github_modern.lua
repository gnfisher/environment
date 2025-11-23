-- shared/.config/nvim/colors/github_modern.lua

-- Check if colorbuddy is available
local status, colorbuddy = pcall(require, "colorbuddy")
if not status then
  return
end

local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local g = colorbuddy.groups
local s = colorbuddy.styles

-- Define colors
Color.new('background', '#F8F8FF')
Color.new('foreground', '#000000')
Color.new('black', '#000000')
Color.new('white', '#FFFFFF')
Color.new('grey_light', '#ECECEC')
Color.new('grey_medium', '#BBBBBB')
Color.new('grey_dark', '#808080')
Color.new('grey_darker', '#404040')
Color.new('red', '#990000')
Color.new('red_light', '#FF1100')
Color.new('red_pale', '#FFDDDD')
Color.new('green_dark', '#003300')
Color.new('green_pale', '#DDFFDD')
Color.new('green', '#159828')
Color.new('blue_dark', '#000033')
Color.new('blue_pale', '#DDDDFF')
Color.new('blue_selection', '#3465A4')
Color.new('blue_selection_nos', '#204A87')
Color.new('blue_identifier', '#0086B3')
Color.new('blue_type', '#445588')
Color.new('cyan_constant', '#177F80')
Color.new('cyan_number', '#1C9898')
Color.new('pink_string', '#D81745')
Color.new('purple_symbol', '#960B73')
Color.new('orange_title', '#EF5939')
Color.new('highlight_match', '#CDCDFD')
Color.new('cursor_bg', '#444454')
Color.new('cursor_line_bg', '#D8D8DD')

-- Apply groups
Group.new('Normal', c.foreground, c.background)
Group.new('DiffAdd', c.green_dark, c.green_pale)
Group.new('DiffChange', nil, c.grey_light)
Group.new('DiffText', c.blue_dark, c.blue_pale)
Group.new('DiffDelete', Color.new('diff_del_fg', '#DDCCCC'), c.red_pale)

Group.new('Folded', c.grey_dark, c.grey_light)
Group.new('LineNr', c.grey_medium, c.grey_light)
Group.new('NonText', c.grey_dark, c.grey_light)
Group.new('VertSplit', c.grey_medium, c.grey_medium)
Group.new('StatusLine', c.grey_darker, c.grey_medium, s.bold)
Group.new('StatusLineNC', c.grey_medium, c.grey_light, s.italic)

Group.new('ModeMsg', c.red)
Group.new('MoreMsg', c.red)
Group.new('Title', c.orange_title)
Group.new('WarningMsg', c.orange_title)
Group.new('SpecialKey', c.white, c.red_light, s.italic)
Group.new('MatchParen', c.black, c.highlight_match)
Group.new('Underlined', c.black, nil, s.underline)
Group.new('Directory', c.red)

Group.new('Visual', c.white, c.blue_selection)
Group.new('VisualNOS', c.white, c.blue_selection_nos)
Group.new('IncSearch', c.black, c.highlight_match, s.italic)
Group.new('Search', c.black, c.highlight_match, s.italic)
Group.new('Ignore', c.grey_dark)

Group.new('Identifier', c.blue_identifier)
Group.new('PreProc', Color.new('preproc_fg', '#A0A0A0'), nil, s.bold)
Group.new('Comment', Color.new('comment_fg', '#AAAAAA'), nil, s.italic)
Group.new('Constant', c.cyan_constant)
Group.new('String', c.pink_string)
Group.new('Function', c.red, nil, s.bold)
Group.new('Statement', c.black, nil, s.bold)
Group.new('Type', c.blue_type, nil, s.bold)
Group.new('Number', c.cyan_number)
Group.new('Todo', c.background, c.red_light, s.underline)
Group.new('Special', c.green, nil, s.bold)
Group.new('rubySymbol', c.purple_symbol)
Group.new('Error', c.background, c.red_light)

Group.new('Label', c.black, nil, s.bold)
Group.new('StorageClass', c.black, nil, s.bold)
Group.new('Structure', c.black, nil, s.bold)
Group.new('TypeDef', c.black, nil, s.bold)

Group.new('WildMenu', Color.new('wildmenu_fg', '#7FBDFF'), Color.new('wildmenu_bg', '#425C78'))
Group.new('Pmenu', c.white, c.grey_dark, s.bold)
Group.new('PmenuSel', c.black, c.highlight_match, s.italic)
Group.new('PmenuSbar', Color.new('pmenusbar_fg', '#444444'), c.black)
Group.new('PmenuThumb', Color.new('pmenuthumb_fg', '#AAAAAA'), Color.new('pmenuthumb_bg', '#AAAAAA'))

Group.new('TabLine', c.grey_darker, Color.new('tabline_bg', '#DDDDDD'))
Group.new('TabLineFill', c.grey_darker, c.tabline_bg)
Group.new('TabLineSel', c.grey_darker, c.background, s.bold)

Group.new('cucumberTags', Color.new('cucumber_fg', '#333333'), Color.new('cucumber_bg', '#FFFF66'), s.bold)
Group.new('htmlTagN', nil, nil, s.bold)

Group.new('Cursor', c.background, c.cursor_bg)
Group.new('CursorLine', nil, c.cursor_line_bg)
Group.new('CursorColumn', nil, c.cursor_line_bg)

-- Explicitly define bold groups to ensure they are picked up
Group.new('Boolean', c.cyan_constant)
Group.new('Character', c.cyan_constant)
Group.new('Float', c.cyan_number)

Group.new('Conditional', c.black, nil, s.bold)
Group.new('Repeat', c.black, nil, s.bold)
Group.new('Operator', c.black, nil, s.bold)
Group.new('Keyword', c.black, nil, s.bold)
Group.new('Exception', c.black, nil, s.bold)

Group.new('Include', c.preproc_fg, nil, s.bold)
Group.new('Define', c.preproc_fg, nil, s.bold)
Group.new('Macro', c.preproc_fg, nil, s.bold)
Group.new('PreCondit', c.preproc_fg, nil, s.bold)

-- Links
Group.link('rubyStringDelimiter', g.String)
