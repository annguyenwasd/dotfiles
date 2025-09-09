---@diagnostic disable: missing-fields, undefined-field
return {
  {
    "mfussenegger/nvim-dap",
    init = function()
      vim.cmd([[
        au FileType dap-repl lua require('dap.ext.autocompl').attach()
      ]])
    end,
    keys = {
      {
        "<localleader>bb",
        "<cmd>lua require('dap').toggle_breakpoint()<cr>",
        desc = desc("debug: toggle breakpoint"),
      },
      {
        "<localleader>bc",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = desc("debug: toggle breakpoint with a condition"),
      },
      {
        "<localleader>bl",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end,
        desc = desc("debug: log point message"),
      },
      {
        "<localleader>BB",
        function()
          require("dap").list_breakpoints()
        end,
        desc = desc("debug: list breakpoints"),
      },
      {
        "<localleader>c",
        "<cmd>lua require('dap').continue()<cr>",
        desc = desc("debug: continue/start debugging"),
      },
      { "`o",              "<cmd>lua require('dap').step_over()<cr>",     desc = desc("debug: step over") },
      { "`i",              "<cmd>lua require('dap').step_into()<cr>",     desc = desc("debug: step into") },
      { "`u",              "<cmd>lua require('dap').step_out()<cr>",      desc = desc("debug: step out") },
      { "`j",              "<cmd>lua require('dap').down()<cr>",          desc = desc("debug: Go down in current stacktrace without stepping.") },
      { "`k",              "<cmd>lua require('dap').up()<cr>",            desc = desc("debug: Go up in current stacktrace without stepping.") },
      { "<localleader>dt", "<cmd>lua require('dap').terminate({all=true})<cr>",     desc = desc("debug: terminate") },
      { "<localleader>dr", "<cmd>lua require('dap').repl.toggle()<cr>",   desc = desc("debug: open repl") },
      { "<localleader>dc", "<cmd>lua require('dap').run_to_cursor()<cr>", desc = desc("debug: run to cursor") },
      {
        "<localleader>ds",
        function()
          local widgets = require("dap.ui.widgets")
          local my_sidebar = widgets.sidebar(widgets.scopes)
          my_sidebar.open()
        end,
        desc = desc("debug: widge shows scopes"),
      },
      {
        "<localleader>df",
        function()
          local widgets = require("dap.ui.widgets")
          local my_sidebar = widgets.sidebar(widgets.frames)
          my_sidebar.open()
        end,
        desc = desc("debug: widget shows frames"),
      },
    },
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
      "mfussenegger/nvim-dap",
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      }
    },
    config = function()
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      })

      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "node",
          args = { "/home/annguyenwasd/Downloads/js-debug/src/dapDebugServer.js", "${port}" },

        }
      }

      for _, language in ipairs({ "typescript", "javascript" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            trace = true, -- include debugger info
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
        }
      end
    end,
  },
}
