return {
  -- Modus themes - primary theme (light: operandi, dark: vivendi)
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Style can be "auto", "modus_operandi", "modus_vivendi"
      -- "auto" follows vim.o.background
      style = "auto",
      variant = "default", -- "default", "tinted", "deuteranopia", "tritanopia"
      transparent = false,
      dim_inactive = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = {},
        variables = {},
      },
    },
    config = function(_, opts)
      require("modus-themes").setup(opts)
      -- modus available but not default; using zellner
    end,
  },

  -- Keep catppuccin available as fallback
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      term_colors = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        telescope = { enabled = true },
        indent_blankline = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        mason = true,
        mini = { enabled = true },
        fidget = true,
        harpoon = true,
        which_key = true,
      },
    },
  },

  {
    "gnfisher/tomorrow-night-blue.nvim",
    lazy = true,
  },
}
