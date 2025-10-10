return {
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
  -- Light theme provider (optional)
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("modus-themes").setup({
        style = "modus_operandi",
        transparent = true,
      })
    end,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("dracula").setup({
        show_end_of_buffer = true,
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "auto", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
      })
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
        }
      })
      vim.o.background = "dark"
      vim.cmd.colorscheme("github_dark_dimmed")
    end,
  },
}
