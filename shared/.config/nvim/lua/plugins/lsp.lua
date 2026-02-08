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
          vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
          vim.keymap.set("n", "<F12>", "<cmd>Telescope lsp_definitions<cr>", opts)
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
          vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
          vim.keymap.set("n", "go", "<cmd>Telescope lsp_type_definitions<cr>", opts)
          vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
          vim.keymap.set("n", "<S-F12>", "<cmd>Telescope lsp_references<cr>", opts)
          vim.keymap.set("i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
          vim.keymap.set("n", "<leader>vd", function()
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

      -- Configure LSP servers via vim.lsp.config (Neovim 0.11+).
      -- mason-lspconfig auto-enables installed servers via vim.lsp.enable().
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      })

      vim.lsp.config("gopls", {
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

      vim.lsp.config("vtsls", {
        capabilities = {
          documentFormattingProvider = false,
        },
      })

      vim.lsp.config("golangci_lint_ls", {
        -- Only use Go project markers for root detection; golangci config
        -- files in parent directories must not pull root_dir upward.
        root_markers = { "go.work", "go.mod", ".git" },
        before_init = function(params, config)
          -- Pass local config explicitly to prevent golangci-lint v2 from
          -- walking up to parent directories and finding a v1 config.
          local root = params.rootUri and vim.uri_to_fname(params.rootUri) or vim.fn.getcwd()
          local names = {
            ".golangci.toml", ".golangci.yml", ".golangci.yaml", ".golangci.json",
            "golangci.toml", "golangci.yml", "golangci.yaml", "golangci.json",
          }
          for _, name in ipairs(names) do
            local path = root .. "/" .. name
            if vim.uv.fs_stat(path) then
              table.insert(config.init_options.command, "-c")
              table.insert(config.init_options.command, path)
              return
            end
          end
        end,
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "vtsls",
          "gopls",
          "lua_ls",
        },
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
