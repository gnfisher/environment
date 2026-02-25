-- Coding enhancements
return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua",
        "typescript",
        "tsx",
        "javascript",
        "go",
        "html",
        "css",
        "json",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
      },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- NOTE: <C-space> is used for noh/escape, so use <CR> here instead
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
  },

  -- Treesitter context: show enclosing function/class at top of buffer
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      max_lines = 1,
      mode = "cursor",
    },
  },

  -- mini.ai: better text objects (dif = delete in function, dan = delete around number, etc.)
  -- Non-intrusive, works on top of existing text objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {
      n_lines = 500, -- How many lines to search for text object
    },
  },

  -- mini.pairs: auto-close brackets/quotes
  -- Smart: won't close if next char is same, handles del/BS correctly
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = false, terminal = false },
    },
  },

  -- Todo comments: highlight and navigate TODO/FIXME/HACK/etc
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    opts = {
      signs = false, -- No gutter signs, just highlighting
    },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
    },
  },

  -- Trouble: structured diagnostics, references, quickfix
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list (Trouble)" },
    },
  },

  -- vim-surround: your preferred surround plugin
  {
    "tpope/vim-surround",
    event = "BufReadPost",
  },

  -- Zen mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = { window = { width = 120 } },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen mode" } },
  },

  -- Spectre: project-wide search and replace with preview
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "vnew" },
    keys = {
      {
        "<leader>sr",
        function() require("spectre").open() end,
        desc = "Replace in files (Spectre)",
      },
    },
  },
}
