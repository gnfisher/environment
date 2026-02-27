-- Colorschemes
return {
  -- Keep tokyonight (LazyVim default for dark mode)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },

  -- Add your custom colorschemes
  {
    "GnHN/tomorrow-night-blue.nvim",
    lazy = false,
    priority = 1000,
  },

  -- Configure LazyVim to use zellner by default
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "zellner",
    },
  },
}
