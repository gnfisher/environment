return {
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1002,
    config = function()
      require("modus-themes").setup({})
      -- vim.o.background = "light"
      -- vim.cmd.colorscheme("modus_operandi")
    end,
  },
  {
    "gnfisher/tomorrow-night-blue.nvim",
    lazy = false,
    priority = 1003,
    config = function()
      require("tomorrow-night-blue").setup({
        keywords = { bold = true },
        diagnostics = {
          -- Inline diagnostics (virtual text)
          virtual_text = { italic = true },
        },
      })

      vim.cmd.colorscheme("tomorrow-night-blue")
    end,
  },
  {
    "tjdevries/colorbuddy.nvim",
    lazy = false,
    priority = 1001,
    config = function ()
      -- vim.o.background = "dark"
      -- vim.cmd.colorscheme("gruvbuddy")
    end
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "soft",
      })
      -- vim.o.background = "dark"
      -- vim.cmd.colorscheme("gruvbox")
    end,
  },
}
