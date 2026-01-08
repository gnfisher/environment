-- Disable LazyVim plugins you don't want
return {
  -- Disable dashboard/alpha
  { "nvimdev/dashboard-nvim", enabled = false },
  { "goolord/alpha-nvim", enabled = false },

  -- Disable neo-tree (you use oil.nvim)
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  -- Disable nvim-cmp (you use blink.cmp)
  { "hrsh7th/nvim-cmp", enabled = false },

  -- Disable noice.nvim (too intrusive)
  { "folke/noice.nvim", enabled = false },

  -- Disable mini.nvim suite (you prefer individual plugins)
  { "echasnovski/mini.indentscope", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  { "echasnovski/mini.ai", enabled = false },
  { "echasnovski/mini.surround", enabled = false }, -- You use vim-surround

  -- Disable flash.nvim (no fancy motions)
  { "folke/flash.nvim", enabled = false },

  -- Disable indent-blankline (cleaner look)
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  -- Disable bufferline (you have custom tabline)
  { "akinsho/bufferline.nvim", enabled = false },

  -- Disable which-key (you know your keybindings)
  { "folke/which-key.nvim", enabled = false },

  -- Disable notify (simpler notifications)
  { "rcarriga/nvim-notify", enabled = false },

  -- Disable dressing.nvim (native UI is fine)
  { "stevearc/dressing.nvim", enabled = false },

  -- Disable nvim-navic (you don't use breadcrumbs)
  { "SmiteshP/nvim-navic", enabled = false },
}
