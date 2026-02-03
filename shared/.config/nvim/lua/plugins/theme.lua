return {
  -- Solarized - faithful lua port
  {
    "ishan9299/nvim-solarized-lua",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "light"
      vim.cmd.colorscheme("solarized")
      -- Clean up line number gutter to match reference image
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#b58900", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#839496", bg = "NONE", bold = false })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      -- Match statusline bg to theme bg
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "#fdf6e3" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#fdf6e3" })
    end,
  },

  -- Modus themes - available as alternative
  {
    "miikanissi/modus-themes.nvim",
    lazy = true,
    opts = {
      style = "auto",
      variant = "default",
      transparent = false,
      dim_inactive = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = {},
        variables = {},
      },
    },
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
