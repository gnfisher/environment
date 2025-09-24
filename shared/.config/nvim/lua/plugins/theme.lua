return {
  -- Local theme controller (no external package)
  {
    name = "solarized-theme",
    dir = vim.fn.stdpath("config") .. "/colors",
    lazy = false,
    priority = 1001,
    init = function()
      vim.o.background = "dark"
      vim.g.default_colorscheme = "solarized-dark"
      local function apply_default()
        local scheme = vim.g.default_colorscheme or "solarized-dark"
        if scheme == "modus_operandi" then
          vim.o.background = "light"
          pcall(require("modus-themes").setup, { style = "modus_operandi", transparent = true })
          pcall(vim.cmd, "colorscheme modus_operandi")
        else
          vim.o.background = "dark"
          pcall(vim.cmd, "colorscheme " .. scheme)
        end
      end
      local ok = pcall(apply_default)
      if not ok then
        vim.api.nvim_create_autocmd("VimEnter", { once = true, callback = apply_default })
      end
    end,
    config = function()
      -- Expose a command so external tools (toggle-theme) can switch live
      vim.api.nvim_create_user_command("ThemeApply", function(opts)
        local scheme = (opts.args ~= "" and opts.args) or vim.g.default_colorscheme or "solarized-dark"
        if scheme == "modus_operandi" then
          vim.o.background = "light"
          pcall(require("modus-themes").setup, { style = "modus_operandi", transparent = true })
          pcall(vim.cmd, "colorscheme modus_operandi")
        else
          vim.o.background = "dark"
          pcall(vim.cmd, "colorscheme " .. scheme)
        end
        pcall(function() require("lualine").refresh() end)
      end, { nargs = "?", complete = function()
        return { "solarized-dark", "tango-dark", "modus_operandi" }
      end })
    end,
  },
  -- Light theme provider (optional)
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
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 999,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        flavour = "frappe",
        background = {
          light = "latte",
          dark = "frappe",
        },
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = false,
          mini = false,
        },
      })
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
        }
      })
    end,
  },
}
