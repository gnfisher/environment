-- I always hit `:E ` instead of `:e `
vim.api.nvim_create_user_command("E", function(opts)
  if opts.args == "" then
    vim.cmd.edit()
    return
  end

  vim.cmd.edit(vim.fn.fnameescape(opts.args))
end, {
  nargs = "?",
  complete = "file",
  desc = "Alias for :edit",
})
