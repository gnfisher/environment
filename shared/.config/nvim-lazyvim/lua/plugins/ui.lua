-- UI customizations
return {
  -- Lualine (statusline)
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = {
        theme = "auto",
        globalstatus = true, -- Global statusline (your preference)
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      }
      opts.sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "filename",
            path = 1, -- Show relative path
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
          },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      }
      return opts
    end,
  },

  -- Custom tabline (keep it simple like yours)
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Disable tabline (you have custom one or prefer simple)
      opts.options.tabline = nil
      return opts
    end,
  },
}
