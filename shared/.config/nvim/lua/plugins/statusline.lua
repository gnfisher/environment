return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = function()
            if vim.g.colors_name == "solarized-dark" then
              return vim.g.solarized_dark_lualine_theme
            elseif vim.g.colors_name == "tango-dark" then
              return vim.g.tango_dark_lualine_theme
            else
              return "auto"
            end
          end,
        },
      })
    end,
  },
}
