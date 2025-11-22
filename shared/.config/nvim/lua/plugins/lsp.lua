return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "folke/lazydev.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig_defaults = require("lspconfig").util.default_config

      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lspconfig_defaults.capabilities,
        require('blink.cmp').get_lsp_capabilities(lspconfig_defaults.capabilities)
      )

      -- Configure diagnostics to show inline
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = false,
        update_in_insert = false,
        severity_sort = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
          vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
          vim.keymap.set("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
          vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
          vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
          vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
          vim.keymap.set("n", "<S-F12>", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
          vim.keymap.set("i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
          vim.keymap.set( "n", "<leader>vd", function()
            local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
            if #diagnostics > 0 then
              local messages = {}
              for _, d in ipairs(diagnostics) do
                table.insert(messages, string.format("[%s] %s", vim.diagnostic.severity[d.severity], d.message))
              end
              vim.notify(table.concat(messages, "\n"))
            else
              vim.notify("No diagnostics on this line")
            end
          end, { desc = "View Diagnostics" })
          vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
          vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

          -- Set omnifunc for manual completion
          vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        end,
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "vtsls",
          "gopls",
          "lua_ls",
          "golangci_lint_ls",
        },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" }
                  }
                }
              }
            })
          end,
          ["gopls"] = function()
            require("lspconfig").gopls.setup({
              settings = {
                gopls = {
                  staticcheck = false,
                  analyses = {
                    unusedparams = false,
                    shadow = false,
                  },
                }
              }
            })
          end,
          ["vtsls"] = function()
            require("lspconfig").vtsls.setup({
              server_capabilities = {
                documentFormattingProvider = false,
              },
            })
          end,
          ["golangci_lint_ls"] = function()
            require("lspconfig").golangci_lint_ls.setup({
              filetypes = { "go", "gomod" },
              root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod", ".git"),
            })
          end,
        }
      })
    end
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
      keymap = {
        preset = 'default',
        ['<C-e>'] = { 'cancel' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<CR>'] = { 'fallback' },
        ['<C-y>'] = { 'accept' },
      },
      appearance = {
        nerd_font_variant = 'mono'
      },
      completion = {
        trigger = {
          show_on_insert_on_trigger_character = true,
          show_on_x_blocked_trigger_characters = {},
        },
        menu = {
          auto_show = true,
          draw = {
            treesitter = { "lsp" }
          }
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200
        },
        accept = { auto_brackets = { enabled = true } },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
}
