-- I always hit `:E ` instead of `:e `
vim.api.nvim_create_user_command("E", function(opts)
  if opts.args == "" then
    vim.cmd.edit()
    return
  end

  vim.cmd.edit(vim.fn.fnameescape(opts.args))
end, {
  nargs = "?",
  complete = "file",
  desc = "Alias for :edit",
})

local function get_copilot_mention_path()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Current buffer has no file path", vim.log.levels.ERROR)
    return nil
  end

  local absolute_path = vim.fn.fnamemodify(path, ":p")
  local display_path = vim.fn.fnamemodify(absolute_path, ":.")
  if display_path == "" then
    display_path = absolute_path
  end

  if display_path:match("%s") then
    vim.notify("Copilot file mentions do not support paths with spaces", vim.log.levels.ERROR)
    return nil
  end

  return display_path
end

local function set_copilot_reference(reference)
  vim.fn.setreg("+", reference)
  vim.fn.setreg('"', reference)
  vim.notify("Copied " .. reference)
end

local function get_project_root(path)
  local start = path or vim.fn.getcwd()
  local markers = {
    ".git",
    "go.work",
    "go.mod",
    "package.json",
    "Makefile",
    "justfile",
    "Taskfile.yml",
    "Taskfile.yaml",
  }

  local root = vim.fs.root(start, markers)
  return root or vim.fn.getcwd()
end

local function get_path_relative_to(base_dir, absolute_path)
  local prefix = base_dir:gsub("/+$", "") .. "/"
  if absolute_path:sub(1, #prefix) == prefix then
    return absolute_path:sub(#prefix + 1)
  end
  return absolute_path
end

local function get_copilot_focus_reference(opts)
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    return nil
  end

  local absolute_path = vim.fn.fnamemodify(path, ":p")
  local root = get_project_root(absolute_path)
  local display_path = get_path_relative_to(root, absolute_path)
  if display_path:match("%s") then
    return nil
  end

  if opts and opts.range ~= 0 then
    local start_line = opts.line1
    local end_line = opts.line2
    local suffix = start_line == end_line and string.format(":%d", start_line)
      or string.format(":%d-%d", start_line, end_line)
    return "@" .. display_path .. suffix
  end

  return "@" .. display_path
end

local function open_terminal_command(command, cwd)
  vim.cmd.new()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.fn.termopen(command, { cwd = cwd })
  vim.cmd.startinsert()
end

vim.api.nvim_create_user_command("CopyCopilotFileRef", function()
  local path = get_copilot_mention_path()
  if not path then
    return
  end

  set_copilot_reference("@" .. path)
end, {
  desc = "Copy current file as a Copilot @mention",
})

vim.api.nvim_create_user_command("CopyCopilotRef", function(opts)
  local path = get_copilot_mention_path()
  if not path then
    return
  end

  local start_line = opts.line1
  local end_line = opts.line2

  if opts.range == 0 then
    start_line = vim.api.nvim_win_get_cursor(0)[1]
    end_line = start_line
  end

  local suffix = start_line == end_line and string.format(":%d", start_line)
    or string.format(":%d-%d", start_line, end_line)

  set_copilot_reference("@" .. path .. suffix)
end, {
  desc = "Copy current line or selected lines as a Copilot @mention",
  range = true,
})

vim.api.nvim_create_user_command("CopilotLintFix", function(opts)
  if vim.fn.executable("copilot") ~= 1 then
    vim.notify("copilot CLI not found in PATH", vim.log.levels.ERROR)
    return
  end

  local buffer_path = vim.api.nvim_buf_get_name(0)
  local root = get_project_root(buffer_path ~= "" and vim.fn.fnamemodify(buffer_path, ":p") or nil)
  local focus_ref = get_copilot_focus_reference(opts)

  local prompt = table.concat({
    "Run this project's existing lint command and fix error-level failures only.",
    "Ignore warnings and non-blocking suggestions.",
    "Use idiomatic Go judgment when touching Go code and otherwise follow repo conventions.",
    focus_ref and ("Focus first on " .. focus_ref .. ".") or nil,
  }, " ")

  open_terminal_command({
    "copilot",
    "--agent", "lint-fix",
    "--allow-all-tools",
    "--no-ask-user",
    "--prompt", prompt,
  }, root)
end, {
  desc = "Run Copilot lint-fix agent for this project",
  range = true,
})
