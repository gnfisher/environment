-- Custom statusline with centered filename
vim.opt.laststatus = 2
vim.opt.showmode = false -- we show mode in statusline

-- Override statusline colors to match solarized light bg
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "#fdf6e3", fg = "#657b83" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#fdf6e3", fg = "#93a1a1" })
  end,
})
-- Apply now too
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#fdf6e3", fg = "#657b83" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#fdf6e3", fg = "#93a1a1" })

local function git_branch()
  local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
  if branch ~= "" then
    return " " .. branch
  end
  return ""
end

-- Cache git branch (update on buffer enter, focus, or after shell commands)
local cached_branch = ""
local function update_branch()
  cached_branch = git_branch()
  vim.cmd("redrawstatus")
end

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "ShellCmdPost", "TermLeave" }, {
  callback = update_branch,
})

-- Also refresh periodically (every 5 seconds) to catch external git changes
local timer = vim.uv.new_timer()
timer:start(5000, 5000, vim.schedule_wrap(update_branch))

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

  -- Left: mode + git branch
  local left = string.format(" %s%s ", mode_str, cached_branch)

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
  local width = vim.o.columns
  local left_len = vim.fn.strchars(left)
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
