-- fidget.nvim: LSP progress shown as a small indicator bottom-right
-- This is the focused answer to "I can't tell what LSP is doing"
-- without pulling in all of noice.nvim
return {
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      progress = {
        display = {
          done_ttl = 2,             -- How long to show "done" before clearing
          render_limit = 4,         -- Max LSP messages at once
          progress_icon = { pattern = "dots" },
        },
      },
      notification = {
        -- Redirect vim.notify here so LSP messages are collected
        -- but keep it subtle: bottom-right, no animation
        window = {
          winblend = 0,
          border = "none",
          align = "bottom",
        },
      },
    },
  },
}
