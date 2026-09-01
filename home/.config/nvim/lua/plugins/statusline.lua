return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "everforest",
        globalstatus = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
        },
        lualine_x = { "diagnostics", "filetype" },
        lualine_y = { "progress", "location" },
        lualine_z = {
          function()
            return "󰥔 " .. os.date("%H:%M")
          end,
        },
      },
      extensions = { "lazy", "mason", "nvim-tree", "quickfix" },
    },
  },
}
