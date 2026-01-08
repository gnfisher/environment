-- LSP Configuration
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- LSP Server settings
      servers = {
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "none" }, -- Disable for performance
              },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              staticcheck = false, -- Disable for performance (use golangci_lint_ls)
              analyses = {
                unusedparams = false,
                shadow = false,
              },
              hints = {
                assignVariableTypes = false, -- Disable inlay hints for performance
                compositeLiteralFields = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              hint = {
                enable = false, -- Disable inlay hints for performance
              },
            },
          },
        },
        golangci_lint_ls = {
          filetypes = { "go", "gomod" },
        },
      },
      -- Setup handlers
      setup = {},
    },
  },

  -- Mason for managing LSP servers
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "vtsls",
        "gopls",
        "lua-language-server",
        "golangci-lint-langserver",
        "prettier",
        "gofmt",
        "goimports",
      },
    },
  },

  -- Replace nvim-cmp with blink.cmp
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = {
        preset = "default",
        ["<C-e>"] = { "cancel" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<CR>"] = { "fallback" },
        ["<C-y>"] = { "accept" }, -- Your preferred accept key
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        trigger = {
          show_on_insert_on_trigger_character = true,
          show_on_x_blocked_trigger_characters = {},
        },
        menu = {
          auto_show = true,
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        accept = {
          auto_brackets = { enabled = true },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
  },

  -- Customize LSP diagnostics
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Optimize diagnostic configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = false, -- You prefer this off
        update_in_insert = false, -- Don't update in insert mode (performance)
        severity_sort = true,
      })

      -- Custom keymaps on LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<S-F12>", vim.lsp.buf.references, opts)
          vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

          -- View diagnostics
          vim.keymap.set("n", "<leader>vd", function()
            local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
            if #diagnostics > 0 then
              local messages = {}
              for _, d in ipairs(diagnostics) do
                table.insert(messages, string.format("[%s] %s", vim.diagnostic.severity[d.severity], d.message))
              end
              vim.notify(table.concat(messages, "\n"))
            else
              vim.notify("No diagnostics on this line")
            end
          end, { desc = "View Diagnostics", buffer = event.buf })

          -- Set omnifunc
          vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        end,
      })
    end,
  },
}
