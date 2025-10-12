return {
  {
    name = "solarized-theme",
    dir = vim.fn.stdpath("config") .. "/colors",
    lazy = false,
    priority = 1001,
    init = function()
    end,
    config = function()
    end,
  },
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("modus-themes").setup({
        style = "modus_operandi",
        transparent = true,
      })
    end,
  },
  {
    "MarcoKorinth/onehalf.nvim",
    lazy = false,
    priority = 1002,
    config = function()
      vim.o.background = "dark"
      vim.cmd.colorscheme("onehalfdark")
    end,
  },
}
