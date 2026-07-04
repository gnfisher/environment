return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<F3>",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "x" },
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "gofmt", "goimports" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      markdown = { "prettier" },
    },
    format_on_save = function(bufnr)
      -- Disable for files without a prettier config (for JS/TS files)
      local ft = vim.bo[bufnr].filetype
      local prettier_fts = {
        "javascript", "javascriptreact", "typescript", "typescriptreact",
        "json", "html", "css", "scss", "markdown"
      }

      if vim.tbl_contains(prettier_fts, ft) then
        -- Check for prettier config
        local config_files = {
          ".prettierrc", ".prettierrc.json", ".prettierrc.js", ".prettierrc.mjs",
          ".prettierrc.cjs", ".prettierrc.yaml", ".prettierrc.yml",
          "prettier.config.js", "prettier.config.mjs", "prettier.config.cjs",
        }
        local has_config = false
        for _, config_file in ipairs(config_files) do
          if vim.fn.findfile(config_file, ".;") ~= "" then
            has_config = true
            break
          end
        end
        -- Also check package.json
        if not has_config then
          local package_json = vim.fn.findfile("package.json", ".;")
          if package_json ~= "" then
            local content = vim.fn.readfile(package_json)
            if table.concat(content, "\n"):match('"prettier"') then
              has_config = true
            end
          end
        end
        if not has_config then
          return false
        end
      end

      return {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end,
  },
}
