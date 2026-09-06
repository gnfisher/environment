local M = {}

local state_file = vim.fn.expand("~/.local/state/environment-theme/current")
local profiles = {
  everforest = {
    background = "dark",
    colorscheme = "everforest",
  },
  dracula = {
    background = "dark",
    colorscheme = "dracula",
  },
  ["modus-operandi"] = {
    background = "light",
    colorscheme = "modus_operandi",
  },
  naysayer = {
    background = "dark",
    colorscheme = "naysayer",
    after = function()
      require("naysayer-overrides").apply()
    end,
  },
}

local function current()
  local file = io.open(state_file, "r")
  if not file then
    return "everforest"
  end

  local name = file:read("*l")
  file:close()

  if profiles[name] then
    return name
  end

  return "everforest"
end

local function apply()
  local name = current()
  if vim.g.environment_theme == name then
    return
  end

  local profile = profiles[name]
  vim.o.background = profile.background
  vim.cmd.colorscheme(profile.colorscheme)
  if profile.after then
    profile.after()
  end
  vim.g.environment_theme = name
end

function M.setup()
  apply()

  vim.api.nvim_create_autocmd("FocusGained", {
    group = vim.api.nvim_create_augroup("environment-theme", { clear = true }),
    callback = apply,
  })
end

return M
