local M = {}

-- Global statusline: like in your original config
vim.opt.laststatus = 3

-----------------------------------------------------------------------
-- Helpers
-----------------------------------------------------------------------

-- Map Vim mode() to short labels (similar to el.extensions.mode)
local mode_map = {
  n  = "NORMAL",
  no = "O-PENDING",
  nov= "O-PENDING",
  noV= "O-PENDING",
  ["no\22"] = "O-PENDING",
  niI= "NORMAL",
  niR= "NORMAL",
  niV= "NORMAL",
  nt = "NORMAL",
  v  = "VISUAL",
  V  = "V-LINE",
  ["\22"] = "V-BLOCK",
  s  = "SELECT",
  S  = "S-LINE",
  ["\19"] = "S-BLOCK",
  i  = "INSERT",
  ic = "INSERT",
  ix = "INSERT",
  R  = "REPLACE",
  Rc = "REPLACE",
  Rv = "V-REPLACE",
  Rx = "REPLACE",
  c  = "COMMAND",
  cv = "EX",
  r  = "HIT-ENTER",
  rm = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  t  = "TERMINAL",
}

local function current_mode()
  local m = vim.api.nvim_get_mode().mode
  return mode_map[m] or m
end

-- Very simple git root finder
local function find_git_root(bufnr)
  bufnr = bufnr or 0
  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == "" then return nil end

  local dir = vim.fn.fnamemodify(fname, ":h")
  if dir == "" then dir = "." end

  -- Walk up until we find .git or reach filesystem root
  while dir and dir ~= "" and dir ~= "/" do
    if vim.fn.isdirectory(dir .. "/.git") == 1 then
      return dir
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then break end
    dir = parent
  end

  return nil
end

-- Get current git branch
function _G.MyStatusline_git_branch()
  local root = find_git_root()
  if not root then return "" end

  -- Run once per call; you could cache this if needed
  local head = vim.fn.systemlist({ "git", "-C", root, "rev-parse", "--abbrev-ref", "HEAD" })[1]
  if not head or head == "" or head:match("^fatal:") then
    return ""
  end
  return " " .. head .. " "
end

-- Very simple git changes indicator: shows dirty/clean
-- You can make this more fancy if you’d like.
function _G.MyStatusline_git_changes()
  local root = find_git_root()
  if not root then return "" end

  local status = vim.fn.systemlist({ "git", "-C", root, "status", "--porcelain" })
  if not status or #status == 0 then
    -- clean
    return ""
  end

  -- Non-empty means some changes; we just show a marker
  return " +"
end

-- Scheduler tasks (as in your original statusline)
function _G.MyStatusline_queued_events()
  local ok, scheduler = pcall(require, "misery.scheduler")
  if not ok or not scheduler or type(scheduler.tasks) ~= "table" then
    return ""
  end

  local task_count = #scheduler.tasks
  if task_count == 0 then
    return ""
  end

  return string.format(" (Queued Events: %d)", task_count)
end

-- Mode
function _G.MyStatusline_mode()
  return " " .. current_mode() .. " "
end

-----------------------------------------------------------------------
-- Statusline builder
-----------------------------------------------------------------------

-- This function will be called from the 'statusline' option via %{...}
function _G.MyStatusline()
  -- Left side
  local s = ""
  s = s .. _G.MyStatusline_mode()
  s = s .. _G.MyStatusline_git_branch()
  s = s .. _G.MyStatusline_git_changes()
  s = s .. _G.MyStatusline_queued_events()

  -- Split: go to right side
  s = s .. "%="

  -- Filename and modified flag (similar to %f + builtin.modified)
  -- %f is short filename, %m is [+] if modified, [-] if not modifiable, [RO] if read-only
  s = s .. " %f%m "

  -- Another split, if you want three zones (like sections.split twice)
  s = s .. "%="

  -- Filetype
  s = s .. " %{&filetype} "

  -- Line / column
  -- %3l : current line, width 3
  -- %2c : current column, width 2
  s = s .. "[%3l:%2c] "

  return s
end

function M.setup()
  -- Now tie our function into the 'statusline' option
  vim.o.statusline = "%!v:lua.MyStatusline()"
end

-- Auto-setup when required
M.setup()

return M
