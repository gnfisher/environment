return {
  {
    "tjdevries/colorbuddy.nvim",
    lazy = false,
    priority = 1002,
    config = function()
      local colorbuddy = require('colorbuddy')
      colorbuddy.colorscheme("gruvbuddy")
      vim.cmd.colorscheme("gruvbuddy")
    end,
  },
  {
    name = "solarized-theme",
    dir = vim.fn.stdpath("config") .. "/colors",
    lazy = false,
    priority = 1001,
    init = function()
    end,
    config = function()
    end,
  },
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("modus-themes").setup({
        style = "modus_operandi",
        transparent = false,
      })
    end,
  },
}
