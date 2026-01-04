return {
  {
    "gnfisher/tomorrow-night-blue.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tomorrow-night-blue").setup({
        keywords = { bold = true },
        diagnostics = {
          virtual_text = { italic = true },
        },
      })
      -- vim.cmd.colorscheme("tomorrow-night-blue")
    end,
  },
}
