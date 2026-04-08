-- Formatting with conform.nvim (faster than none-ls)
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
        go = { "gofmt", "goimports" },
        lua = { "stylua" },
      },
      -- Format on save with conditional prettier
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        local prettier_fts = {
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
            ".prettierrc.yaml",
            ".prettierrc.yml",
            "prettier.config.js",
          }
          for _, config_file in ipairs(config_files) do
            if vim.fn.findfile(config_file, ".;") ~= "" then
              return true
            end
          end
          return false
        end

        -- Only format with prettier if config exists
        if vim.tbl_contains(prettier_fts, ft) then
          if not has_prettier_config() then
            return nil -- Skip formatting
          end
        end

        return {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,
    },
    keys = {
      {
        "<F3>",
        function()
          require("conform").format({ async = false, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
  },
}
