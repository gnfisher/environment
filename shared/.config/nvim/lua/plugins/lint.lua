return {
  "mfussenegger/nvim-lint",
  enabled = false, -- Disabled: using external golangci-lint via pre-commit/CI
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      go = { "golangcilint" },
    }

    -- Override to explicitly pass config path so it doesn't change cwd
    local golangcilint = lint.linters.golangcilint
    golangcilint.args = {
      "run",
      "--out-format=json",
      "--show-stats=false",
      "-c",
      vim.fn.expand("~/Development/github/.golangci.toml"),
      "./...",
    }

    -- Debounce linting to prevent "parallel golangci-lint" errors
    local timer = nil
    local function debounced_lint()
      if timer then
        timer:stop()
      end
      timer = vim.defer_fn(function()
        lint.try_lint()
      end, 1000)
    end

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      pattern = { "*.go" },
      callback = debounced_lint,
    })
  end,
}
