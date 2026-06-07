return {
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "GBrowse",
      "GDelete",
      "GMove",
      "GRename",
      "Gdiffsplit",
      "Gedit",
      "Ggrep",
      "Gread",
      "Gwrite",
    },
    dependencies = {
      "tpope/vim-rhubarb",
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("custom_fugitive_layout", { clear = true }),
        pattern = "fugitive",
        callback = function()
          vim.schedule(function()
            if vim.bo.filetype ~= "fugitive" or #vim.api.nvim_list_wins() == 1 then
              return
            end

            pcall(vim.api.nvim_win_set_height, 0, math.max(8, math.floor(vim.o.lines / 3)))
          end)
        end,
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewLog",
      "DiffviewOpen",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
    },
    keys = {
      { "<leader>dv", "<Cmd>DiffviewOpen<CR>", desc = "Diffview open" },
      {
        "<leader>dp",
        function()
          local remote_head = vim.fn.systemlist({ "git", "symbolic-ref", "--short", "refs/remotes/origin/HEAD" })[1]
          local base = remote_head ~= nil and remote_head ~= "" and remote_head or "origin/main"
          vim.cmd("DiffviewOpen " .. vim.fn.fnameescape(base) .. "...HEAD")
        end,
        desc = "Diffview PR diff",
      },
      { "<leader>dV", "<Cmd>DiffviewFileHistory %<CR>", desc = "Diffview file history" },
      { "<leader>dq", "<Cmd>DiffviewClose<CR>", desc = "Diffview close" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function(_, opts)
      require("diffview").setup(opts)

      local group = vim.api.nvim_create_augroup("custom_diffview_lsp", { clear = true })

      local function attach_go_lsp()
        if vim.bo.filetype ~= "go" or vim.bo.buftype ~= "" then
          return
        end

        require("lazy").load({ plugins = { "nvim-lspconfig" } })
        vim.lsp.enable("gopls")
      end

      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = group,
        pattern = "*.go",
        callback = function()
          vim.schedule(attach_go_lsp)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "go",
        callback = function()
          vim.schedule(attach_go_lsp)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "DiffviewViewOpened",
        callback = function()
          vim.schedule(attach_go_lsp)
        end,
      })
    end,
    opts = {
      default_args = {
        DiffviewOpen = { "--imply-local" },
      },
    },
  },
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    keys = {
      { "<leader>dd", "<Cmd>CodeDiff<CR>", desc = "Diff explorer (git status)" },
      { "<leader>df", "<Cmd>CodeDiff history %<CR>", desc = "Diff file history" },
      { "<leader>dh", "<Cmd>CodeDiff HEAD<CR>", desc = "Diff against HEAD" },
    },
    opts = {
      highlights = {
        line_insert = "DiffAdd",
        line_delete = "DiffDelete",
      },
      diff = {
        jump_to_first_change = true,
      },
      explorer = {
        initial_focus = "explorer",
      },
    },
  },
}
