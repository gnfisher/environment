return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
    "DiffviewClose",
    "DiffviewFocusFiles",
    "DiffviewToggleFiles",
    "DiffviewRefresh",
    "DiffviewLog",
  },
  keys = {
    {
      "<leader>gd",
      "<Cmd>DiffviewOpen origin/main...HEAD<CR>",
      desc = "Git diff PR changes",
    },
    {
      "<leader>gD",
      "<Cmd>DiffviewClose<CR>",
      desc = "Git diff close",
    },
  },
  opts = function()
    local actions = require("diffview.actions")

    local function center_after(action)
      return function()
        action()
        vim.cmd.normal({ "zz", bang = true })
      end
    end

    local function jump_diff(motion)
      return center_after(function()
        vim.cmd.normal({ motion, bang = true })
      end)
    end

    return {
      keymaps = {
        view = {
          { "n", "<tab>", center_after(actions.select_next_entry), { desc = "Open the next file diff" } },
          { "n", "<s-tab>", center_after(actions.select_prev_entry), { desc = "Open the previous file diff" } },
          { "n", "[F", center_after(actions.select_first_entry), { desc = "Open the first file diff" } },
          { "n", "]F", center_after(actions.select_last_entry), { desc = "Open the last file diff" } },
          { "n", "]c", jump_diff("]c"), { desc = "Next diff hunk" } },
          { "n", "[c", jump_diff("[c"), { desc = "Previous diff hunk" } },
          { "n", "]x", center_after(actions.next_conflict), { desc = "Next merge conflict" } },
          { "n", "[x", center_after(actions.prev_conflict), { desc = "Previous merge conflict" } },
          { "n", "gf", center_after(actions.goto_file_edit), { desc = "Open file in the previous tabpage" } },
          { "n", "<C-w><C-f>", center_after(actions.goto_file_split), { desc = "Open file in a new split" } },
          { "n", "<C-w>gf", center_after(actions.goto_file_tab), { desc = "Open file in a new tabpage" } },
        },
      },
    }
  end,
}
