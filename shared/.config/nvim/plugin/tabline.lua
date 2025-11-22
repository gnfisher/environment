function CustomTabLine()
  local tabline = ''
  local current_tab = vim.fn.tabpagenr()
  
  for i = 1, vim.fn.tabpagenr('$') do
    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.bufname(bufnr)
    
    -- Set highlight for active/inactive tab
    if i == current_tab then
      tabline = tabline .. '%#TabLineSel#'
    else
      tabline = tabline .. '%#TabLine#'
    end
    
    -- Make tab clickable
    tabline = tabline .. '%' .. i .. 'T'
    
    -- Add some padding
    tabline = tabline .. ' '
    
    -- Format the buffer name
    local display_name
    if bufname == '' then
      display_name = '[No Name]'
    else
      -- Get the last two parts of the path (parent/file)
      local parts = {}
      for part in string.gmatch(bufname, "[^/]+") do
        table.insert(parts, part)
      end
      
      if #parts >= 2 then
        display_name = parts[#parts - 1] .. '/' .. parts[#parts]
      elseif #parts == 1 then
        display_name = parts[1]
      else
        display_name = bufname
      end
    end
    
    -- Add modified flag
    local modified = vim.fn.getbufvar(bufnr, "&modified")
    if modified == 1 then
      display_name = display_name .. ' [+]'
    end
    
    tabline = tabline .. display_name .. ' '
  end
  
  -- Fill the rest with TabLineFill
  tabline = tabline .. '%#TabLineFill#%T'
  
  return tabline
end

vim.o.tabline = '%!v:lua.CustomTabLine()'
