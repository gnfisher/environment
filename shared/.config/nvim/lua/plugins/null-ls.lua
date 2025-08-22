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

    -- Check if prettier config exists
    local function has_prettier_config()
      local config_files = {
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.js",
        ".prettierrc.mjs",
        ".prettierrc.cjs",
        ".prettierrc.yaml",
        ".prettierrc.yml",
        "prettier.config.js",
        "prettier.config.mjs",
        "prettier.config.cjs",
      }
      
      for _, config_file in ipairs(config_files) do
        if vim.fn.findfile(config_file, ".;") ~= "" then
          return true
        end
      end
      
      -- Check package.json for prettier config
      local package_json = vim.fn.findfile("package.json", ".;")
      if package_json ~= "" then
        local success, content = pcall(vim.fn.readfile, package_json)
        if success then
          local json_str = table.concat(content, "\n")
          if json_str:match('"prettier"') then
            return true
          end
        end
      end
      
      return false
    end

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier.with({
          filetypes = prettier_filetypes,
          condition = function()
            return has_prettier_config()
          end,
        }),
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
      },
    })

    -- Smart format function that uses prettier when available and configured
    local function smart_format()
      local ft = vim.bo.filetype
      local has_prettier_ft = vim.tbl_contains(prettier_filetypes, ft)
      local has_config = has_prettier_config()

      if has_prettier_ft and has_config then
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
