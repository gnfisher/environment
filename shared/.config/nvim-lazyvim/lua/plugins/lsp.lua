-- LSP Configuration
return {
  -- Server configs and our unique keymaps
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "none" },
                variableTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = false },
              },
            },
            javascript = {
              inlayHints = {
                parameterNames = { enabled = "none" },
                variableTypes = { enabled = false },
              },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              staticcheck = false,
              analyses = {
                unusedparams = false,
                shadow = false,
              },
              hints = {
                assignVariableTypes = false,
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
              diagnostics = { globals = { "vim" } },
              hint = { enable = false },
            },
          },
        },
        golangci_lint_ls = {
          filetypes = { "go", "gomod" },
        },
      },
    },
    -- init runs before opts merge - safe for side effects, won't wipe server configs
    init = function()
      -- Only add keymaps LazyVim doesn't set.
      -- LazyVim already handles: gd, gD, gI, gr, gy, K, <leader>ca, <leader>cr, ]d, [d
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_keymaps", { clear = true }),
        callback = function(event)
          local buf = event.buf
          -- IDE-style aliases for muscle memory
          vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, { buffer = buf, desc = "Go to definition" })
          vim.keymap.set("n", "<S-F12>", vim.lsp.buf.references, { buffer = buf, desc = "Find references" })
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = buf, desc = "Rename symbol" })
          vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = buf, desc = "Signature help" })
          -- LazyVim uses gy for type_definition; keep go for muscle memory
          vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { buffer = buf, desc = "Type definition" })
          -- Inline diagnostic popup
          vim.keymap.set("n", "<leader>vd", function()
            local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
            if #diagnostics > 0 then
              local msgs = {}
              for _, d in ipairs(diagnostics) do
                table.insert(msgs, string.format("[%s] %s", vim.diagnostic.severity[d.severity], d.message))
              end
              vim.notify(table.concat(msgs, "\n"))
            else
              vim.notify("No diagnostics on this line")
            end
          end, { buffer = buf, desc = "View line diagnostics" })
        end,
      })
    end,
  },

  -- Mason: tool installer
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "vtsls",
        "gopls",
        "lua-language-server",
        "golangci-lint-langserver",
        "prettier",
        "goimports",
        "stylua",
      },
    },
  },

  -- blink.cmp: Rust-based completion, faster than nvim-cmp
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
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
        ["<C-y>"] = { "accept" },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        trigger = {
          show_on_insert_on_trigger_character = true,
          show_on_x_blocked_trigger_characters = {},
        },
        menu = {
          auto_show = true,
          draw = { treesitter = { "lsp" } },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        accept = { auto_brackets = { enabled = true } },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
}
