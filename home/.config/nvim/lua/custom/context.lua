local M = {}

local last_target
local popup_win
local popup_buf
local popup_key_ns = vim.api.nvim_create_namespace("custom-context-popup")
local popup_key_handler_active = false

local context_kinds = {
  arrow_function = "function",
  class_declaration = "class",
  class_definition = "class",
  enhanced_for_statement = "for",
  for_in_statement = "for",
  for_statement = "for",
  foreach_statement = "for",
  function_declaration = "function",
  function_definition = "function",
  function_item = "function",
  function_statement = "function",
  if_statement = "if",
  loop_expression = "loop",
  method_declaration = "method",
  method_definition = "method",
  method_signature = "method",
  repeat_statement = "repeat",
  select_statement = "select",
  switch_statement = "switch",
  type_declaration = "type",
  while_statement = "while",
}

local function close_popup()
  if popup_key_handler_active then
    vim.on_key(nil, popup_key_ns)
    popup_key_handler_active = false
  end

  if popup_win and vim.api.nvim_win_is_valid(popup_win) then
    vim.api.nvim_win_close(popup_win, true)
  end
  popup_win = nil
  popup_buf = nil
end

local function line_is_comment(line)
  return line:match("^%s*//") ~= nil
    or line:match("^%s*/%*") ~= nil
    or line:match("^%s*%*") ~= nil
    or line:match("^%s*%*/") ~= nil
    or line:match("^%s*#") ~= nil
    or line:match("^%s*%-%-") ~= nil
end

local function leading_comment_lines(bufnr, start_row)
  local rows = {}
  local row = start_row - 1

  while row >= 0 and #rows < 8 do
    local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1] or ""
    if not line_is_comment(line) then
      break
    end

    table.insert(rows, 1, vim.trim(line))
    row = row - 1
  end

  return rows
end

local function preview_for_node(bufnr, node)
  local start_row, _, end_row = node:range()
  local limit = math.min(end_row, start_row + 5)
  local pieces = leading_comment_lines(bufnr, start_row)

  for row = start_row, limit do
    local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1] or ""
    line = vim.trim(line)
    if line ~= "" then
      table.insert(pieces, line)
    end
    if line:find("{", 1, true) or line:find("=>", 1, true) or line:find(" then$") or line:find(" do$") then
      break
    end
  end

  local text = table.concat(pieces, " ")
  text = text:gsub("%s+", " ")
  return text
end

local function collect_contexts()
  local bufnr = vim.api.nvim_get_current_buf()
  local ok, node = pcall(vim.treesitter.get_node, { bufnr = bufnr })
  if not ok or not node then
    return {}
  end

  local contexts = {}
  while node do
    local kind = context_kinds[node:type()]
    if kind then
      local start_row, start_col = node:range()
      table.insert(contexts, {
        bufnr = bufnr,
        kind = kind,
        line = start_row + 1,
        col = start_col,
        text = preview_for_node(bufnr, node),
      })
    end
    node = node:parent()
  end

  return contexts
end

function M.peek()
  close_popup()

  local contexts = collect_contexts()
  if #contexts == 0 then
    last_target = nil
    vim.notify("No enclosing Treesitter context found", vim.log.levels.INFO)
    return
  end

  last_target = contexts[1]

  local lines = {}
  local width = 20
  for _, context in ipairs(contexts) do
    local line = string.format("%s L%d: %s", context.kind, context.line, context.text)
    table.insert(lines, line)
    width = math.max(width, #line)
  end

  width = math.min(width, math.max(20, vim.o.columns - 8))
  popup_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(popup_buf, 0, -1, false, lines)
  vim.bo[popup_buf].bufhidden = "wipe"
  vim.bo[popup_buf].filetype = "treesitter-context"

  popup_win = vim.api.nvim_open_win(popup_buf, false, {
    relative = "cursor",
    row = 1,
    col = 0,
    width = width,
    height = #lines,
    style = "minimal",
    border = "rounded",
    focusable = false,
  })

  vim.wo[popup_win].wrap = false

  vim.schedule(function()
    if popup_win and vim.api.nvim_win_is_valid(popup_win) then
      popup_key_handler_active = true
      vim.on_key(function()
        close_popup()
      end, popup_key_ns)
    end
  end)
end

function M.jump()
  if not last_target or not vim.api.nvim_buf_is_valid(last_target.bufnr) then
    M.peek()
    if not last_target then
      return
    end
  end

  close_popup()
  vim.api.nvim_set_current_buf(last_target.bufnr)
  vim.api.nvim_win_set_cursor(0, { last_target.line, last_target.col })
  vim.cmd("normal! zz")
end

return M
