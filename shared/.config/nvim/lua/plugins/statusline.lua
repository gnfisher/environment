return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = function()
            local name = vim.g.colors_name
            if name == "tango-dark" and vim.g.tango_dark_lualine_theme then
              return vim.g.tango_dark_lualine_theme
            end
            if name == "solarized-dark" and vim.g.solarized_dark_lualine_theme then
              return vim.g.solarized_dark_lualine_theme
            end
            return "auto"
          end,
        },
      })
    end,
  },
}
