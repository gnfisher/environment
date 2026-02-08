-- Custom statusline with centered filename
vim.opt.laststatus = 2
vim.opt.showmode = false -- we show mode in statusline

-- Mode highlight groups (set after colorscheme loads)
local function setup_custom_highlights()
  local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
  local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
  local bg_str = normal_bg and string.format("#%06x", normal_bg) or "NONE"
  local fg_str = normal_fg and string.format("#%06x", normal_fg) or "#ffffff"
  vim.api.nvim_set_hl(0, "StatusMode", { fg = "#969896", bg = bg_str, bold = false })
  vim.api.nvim_set_hl(0, "StatusModeInsert", { fg = "#002451", bg = "#ebcb8b", bold = true })
  vim.api.nvim_set_hl(0, "StatusModeVisual", { fg = "#002451", bg = "#b48ead", bold = true })
  vim.api.nvim_set_hl(0, "StatusModeReplace", { fg = "#002451", bg = "#bf616a", bold = true })
  vim.api.nvim_set_hl(0, "StatusModeCommand", { fg = "#002451", bg = "#a3be8c", bold = true })
  -- Oil.nvim winbar: match editor background
  vim.api.nvim_set_hl(0, "WinBar", { fg = fg_str, bg = bg_str, bold = true })
  vim.api.nvim_set_hl(0, "WinBarNC", { fg = "#969896", bg = bg_str })
end

setup_custom_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_custom_highlights })

local mode_map = {
  ["n"] = "NORMAL",
  ["no"] = "O-PENDING",
  ["nov"] = "O-PENDING",
  ["noV"] = "O-PENDING",
  ["no\22"] = "O-PENDING",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["nt"] = "NORMAL",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "V-LINE",
  ["Vs"] = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  ["\19"] = "S-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rx"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["Rvc"] = "V-REPLACE",
  ["Rvx"] = "V-REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "REPLACE",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

function _G.statusline()
  local mode = vim.fn.mode()
  local mode_str = mode_map[mode] or mode

  -- Pick highlight group based on mode
  local mode_hl = "StatusMode"
  if mode_str == "INSERT" then
    mode_hl = "StatusModeInsert"
  elseif mode_str == "VISUAL" or mode_str == "V-LINE" or mode_str == "V-BLOCK" then
    mode_hl = "StatusModeVisual"
  elseif mode_str == "REPLACE" or mode_str == "V-REPLACE" then
    mode_hl = "StatusModeReplace"
  elseif mode_str == "COMMAND" then
    mode_hl = "StatusModeCommand"
  end

  -- Left: mode + git branch
  local left = string.format("%%#%s# %s %%*", mode_hl, mode_str)

  -- Center: filepath with modified indicator
  local filename = vim.fn.expand("%:~:.") -- relative to cwd, fallback to home-relative
  if filename == "" then
    filename = "[No Name]"
  end
  if vim.bo.modified then
    filename = filename .. " [+]"
  end
  if vim.bo.readonly then
    filename = filename .. " [RO]"
  end

  -- Right: filetype, line:col, percentage
  local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "no ft"
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local total = vim.fn.line("$")
  local pct = math.floor(line / total * 100)
  local right = string.format(" %s │ %d:%d │ %d%%%% ", filetype, line, col, pct)

  -- Calculate padding for centering
  -- left display width is mode_str + 2 spaces (highlight codes don't count)
  local width = vim.o.columns
  local left_len = vim.fn.strchars(mode_str) + 2
  local right_len = vim.fn.strchars(right)
  local center_len = vim.fn.strchars(filename)
  local available = width - left_len - right_len
  local pad_left = math.floor((available - center_len) / 2)
  local pad_right = available - center_len - pad_left

  if pad_left < 0 then pad_left = 0 end
  if pad_right < 0 then pad_right = 0 end

  return left .. string.rep(" ", pad_left) .. filename .. string.rep(" ", pad_right) .. right
end

vim.opt.statusline = "%{%v:lua.statusline()%}"
