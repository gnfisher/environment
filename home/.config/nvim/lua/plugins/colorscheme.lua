vim.g.legacy_syntax_highlighting = true

return {
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1001,
    opts = {
      style = "modus_operandi",
      styles = {
        comments = { italic = false },
      },
    },
  },
  {
    "https://gitlab.com/__tpb/acme.nvim.git",
    name = "acme.nvim",
    lazy = false,
    priority = 1000,
  },
}
