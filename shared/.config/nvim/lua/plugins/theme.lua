return {
  -- Atom One - clean, readable dark/light theme
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "dark",
      transparent = false,
      term_colors = true,
      code_style = {
        comments = "italic",
        keywords = "bold",
        functions = "none",
        strings = "none",
        variables = "none",
      },
      diagnostics = {
        darker = true,
        undercurl = true,
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
}
