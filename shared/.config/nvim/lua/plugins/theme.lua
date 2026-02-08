return {
  {
    "NTBBloodbath/doom-one.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.doom_one_enable_treesitter = true
      vim.g.doom_one_terminal_colors = true
      vim.cmd.colorscheme("doom-one")
    end,
  },
}
