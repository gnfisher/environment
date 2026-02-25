-- Disable LazyVim defaults that don't fit this workflow
return {
  -- No start screen
  { "nvimdev/dashboard-nvim",        enabled = false },
  { "goolord/alpha-nvim",            enabled = false },

  -- Using oil.nvim instead
  { "nvim-neo-tree/neo-tree.nvim",   enabled = false },

  -- Using blink.cmp instead
  { "hrsh7th/nvim-cmp",              enabled = false },

  -- Too heavy, too intrusive
  { "folke/noice.nvim",              enabled = false },

  -- Using vim-surround instead
  { "echasnovski/mini.surround",     enabled = false },

  -- mini.indentscope animates indent lines - distracting
  { "echasnovski/mini.indentscope",  enabled = false },

  -- Changes core s/S motions, not worth the retraining
  { "folke/flash.nvim",              enabled = false },

  -- Using custom tabline
  { "akinsho/bufferline.nvim",       enabled = false },

  -- You know your bindings; enable if you want to explore LazyVim keymaps
  { "folke/which-key.nvim",          enabled = false },

  -- Native notifications are fine; noice is disabled so notify is moot
  { "rcarriga/nvim-notify",          enabled = false },

  -- Enabled: mini.ai, mini.pairs, dressing.nvim, indent-blankline
  -- (removed from disabled list - see coding.lua and ui.lua)
}
