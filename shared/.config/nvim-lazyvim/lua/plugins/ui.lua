-- UI customizations
return {
  -- Lualine: configure LazyVim's built-in statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "filename",
            path = 1, -- relative path
            symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
          },
        },
        lualine_x = {
          { "diagnostics", sources = { "nvim_diagnostic" } },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- dressing.nvim: better vim.ui.select() and vim.ui.input()
  -- Makes code actions, rename prompts, etc. use telescope/float instead of cmdline
  -- Minimal overhead, big UX improvement
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        default_prompt = "➤ ",
        win_options = { winblend = 0 },
      },
      select = {
        backend = { "telescope", "builtin" },
      },
    },
  },
}
