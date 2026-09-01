return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/continue" },
      { "<S-F5>", function() require("dap").terminate() end, desc = "Debug: Stop" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step into" },
      { "<S-F11>", function() require("dap").step_out() end, desc = "Debug: Step out" },
      {
        "<leader>db",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Debug: Conditional breakpoint",
      },
      { "<leader>dc", function() require("dap").clear_breakpoints() end, desc = "Debug: Clear breakpoints" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Debug: Run last" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug: Toggle REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
      {
        "<leader>de",
        function() require("dapui").eval() end,
        mode = { "n", "x" },
        desc = "Debug: Evaluate",
      },
      {
        "<leader>dt",
        function() require("dap-go").debug_test() end,
        ft = "go",
        desc = "Debug: Go test",
      },
    },
    dependencies = {
      "mason-org/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

      require("mason").setup()
      require("mason-nvim-dap").setup({
        ensure_installed = { "js", "delve", "codelldb" },
        handlers = {
          function(config)
            -- JavaScript and Go are configured below with their language-specific adapters.
            if config.name ~= "js" and config.name ~= "delve" then
              require("mason-nvim-dap").default_setup(config)
            end
          end,
        },
      })

      require("dap-go").setup({
        delve = {
          path = mason_bin .. "/dlv",
        },
      })

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = mason_bin .. "/js-debug-adapter",
          args = { "${port}", "127.0.0.1" },
        },
      }

      local js_configurations = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch current file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
          console = "integratedTerminal",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Node process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
      }

      for _, filetype in ipairs({
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      }) do
        dap.configurations[filetype] = vim.deepcopy(js_configurations)
      end

      dap.configurations.rust = {
        {
          type = "codelldb",
          request = "launch",
          name = "Launch executable",
          program = function()
            local default = vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            local path = vim.fn.input("Path to executable: ", default, "file")
            return path ~= "" and path or dap.ABORT
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapStopped", { text = ">", texthl = "DiagnosticOk", linehl = "Visual" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "DiagnosticError" })
    end,
  },
}
