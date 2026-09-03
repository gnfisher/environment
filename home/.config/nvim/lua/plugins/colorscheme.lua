return {
  {
    "sainnhe/everforest",
    dependencies = {
      "Mofiqul/dracula.nvim",
      "miikanissi/modus-themes.nvim",
    },
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = "medium"
      vim.g.everforest_transparent_background = 2
      vim.g.everforest_disable_italic_comment = 1
      vim.g.everforest_better_performance = 1

      require("dracula").setup({
        transparent_bg = true,
      })

      require("modus-themes").setup({
        style = "modus_operandi",
        transparent = false,
      })

      require("environment-theme").setup()
    end,
  },
}
