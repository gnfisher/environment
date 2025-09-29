return {
  -- Local theme controller (no external package)
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
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 999,
    config = function()
      require("catppuccin").setup({
        float = {
          transparent = true, -- enable transparent floating windows
          solid = false, -- use solid styling for floating windows, see |winborder|
        },
        transparent_background = true,
        flavour = "frappe",
        background = {
          light = "latte",
          dark = "frappe",
        },
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = false,
          mini = false,
        },
      })
      vim.o.background = "dark"
      -- vim.cmd.colorscheme("catppuccin") -- disabled in favor of rose-pine
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
        disable_background = true, -- transparent background
        disable_float_background = true, -- transparent floating windows
        highlight_groups = {
          -- Ensure transparency
          Normal = { bg = "NONE" },
          NormalFloat = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
          LineNr = { bg = "NONE" },
          Folded = { bg = "NONE" },
          NonText = { bg = "NONE" },
          SpecialKey = { bg = "NONE" },
          VertSplit = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
        },
      })
      vim.o.background = "dark"
      vim.cmd.colorscheme("rose-pine")
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
    end,
  },
}
