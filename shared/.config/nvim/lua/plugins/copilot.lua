return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    vim.g.copilot_no_tab_map = true

    vim.keymap.set("i", "<Tab>", function()
      local suggestion = vim.fn["copilot#Accept"]("")
      if suggestion ~= "" then
        return suggestion
      else
        return "\t"
      end
    end, { expr = true, replace_keycodes = false, silent = true })
    vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot" })
    vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
    vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })
  end,
}
