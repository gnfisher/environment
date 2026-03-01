return {
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
    },
    config = function() end,
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
