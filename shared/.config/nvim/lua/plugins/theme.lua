return {
  {
    "gnfisher/tomorrow-night-blue.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tomorrow-night-blue")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
  },
}
