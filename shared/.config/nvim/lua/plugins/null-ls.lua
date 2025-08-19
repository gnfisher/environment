return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    -- Prettier-supported filetypes
    local prettier_filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "html",
      "css",
      "scss",
      "markdown",
    }

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier.with({
          filetypes = prettier_filetypes,
        }),
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
      },
    })

    -- Smart format function that uses prettier when available
    local function smart_format()
      local ft = vim.bo.filetype
      local has_prettier = vim.tbl_contains(prettier_filetypes, ft)

      if has_prettier then
        -- Use null-ls (prettier) formatting
        vim.lsp.buf.format({
          async = false,
          filter = function(client)
            return client.name == "null-ls"
          end
        })
      else
        -- Fall back to LSP formatting
        vim.lsp.buf.format({ async = false })
      end
    end

    -- Override F3 mapping after LSP attach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        vim.keymap.set({ "n", "x" }, "<F3>", smart_format, { buffer = event.buf })
      end,
    })

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.html", "*.css", "*.scss", "*.md", "*.go" },
      callback = function()
        smart_format()
      end,
    })
  end,
}
