return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        background = {
          light = "latte",
          dark = "frappe",
        },
        term_colors = true,
        integrations = {
          gitsigns = true,
          mason = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
