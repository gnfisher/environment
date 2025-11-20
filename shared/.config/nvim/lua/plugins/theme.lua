return {
  {
    "tjdevries/colorbuddy.nvim",
    lazy = false,
    priority = 1002,
    config = function()
      -- local colorbuddy = require('colorbuddy')
      -- colorbuddy.colorscheme("gruvbuddy")
      -- vim.cmd.colorscheme("gruvbuddy")
    end,
  },
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      vim.o.termguicolors = true
      vim.o.background = 'light'
      require('solarized').setup({
        variant = 'spring',
      })
      vim.cmd.colorscheme 'solarized'
    end,
  }
}
