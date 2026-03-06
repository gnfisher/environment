local set = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.o.background = "dark"

local color_config = vim.fn.stdpath("config") .. "/plugin/color.lua"

local function persist_background(bg)
  local lines = vim.fn.readfile(color_config)
  for i, line in ipairs(lines) do
    if line:match("^vim%.o%.background%s*=") then
      lines[i] = string.format('vim.o.background = "%s"', bg)
      vim.fn.writefile(lines, color_config)
      return
    end
  end

  table.insert(lines, 1, string.format('vim.o.background = "%s"', bg))
  vim.fn.writefile(lines, color_config)
end

set("n", "<F6>", function()
  local new_bg = vim.o.background == "light" and "dark" or "light"
  vim.o.background = new_bg
  persist_background(new_bg)
  vim.cmd("source " .. vim.fn.fnameescape(color_config))
  -- Re-apply colorscheme so it picks up the new background
  vim.cmd.colorscheme(vim.g.colors_name or "mono")
end, opts)
