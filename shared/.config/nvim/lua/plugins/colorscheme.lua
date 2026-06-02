return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "main",
      dark_variant = "main",
      styles = {
        transparency = true,
      },
      highlight_groups = {
        Normal = { bg = "none" },
        NormalNC = { bg = "none" },
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        SignColumn = { bg = "none" },
        LineNr = { bg = "none" },
        CursorLineNr = { bg = "none" },
        StatusLine = { bg = "none" },
        StatusLineNC = { bg = "none" },
        TabLine = { bg = "none" },
        TabLineFill = { bg = "none" },
        WinBar = { bg = "none" },
        WinBarNC = { bg = "none" },
        EndOfBuffer = { bg = "none" },
      },
    },
  },
  {
    "https://gitlab.com/__tpb/acme.nvim.git",
    name = "acme.nvim",
    lazy = false,
    priority = 999,
  },
}
