vim.g.legacy_syntax_highlighting = true

return {
  {
    "https://codeberg.org/lifepillar/vim-solarized8.git",
    name = "vim-solarized8",
    branch = "neovim",
    lazy = false,
    priority = 1001,
    init = function()
      vim.g.solarized_extra_hi_groups = 1
      vim.g.solarized_italics = 0
      vim.g.solarized_old_cursor_style = 1
      vim.g.solarized_termtrans = 0
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        transparency = true,
      },
    },
  },
  {
    "nanotech/jellybeans.vim",
    name = "jellybeans.vim",
    lazy = false,
    priority = 999,
  },
  {
    "https://gitlab.com/__tpb/acme.nvim.git",
    name = "acme.nvim",
    lazy = false,
    priority = 998,
  },
}
