local set = vim.keymap.set

local quitfn = function()
  vim.cmd("quit")
end

vim.keymap.set("n", "gq", quitfn, { desc = "Close help window" })
