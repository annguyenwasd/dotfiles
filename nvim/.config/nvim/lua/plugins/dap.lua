return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				config = function()
					require("dapui").setup()

					local dap, dapui = require("dap"), require("dapui")
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
				end,
				keys = {
					{ "<localleader>du", '<cmd>lua require("dapui").open()<cr>', desc = desc("debug: dapui open") },
					{ "`h", '<cmd>lua require("dapui").eval()<cr>', desc = desc("debug: dapui eval") },
					{ "`h", '<cmd>lua require("dapui").eval()<cr>', "v", desc = desc("debug: dapui selection eval") },
					{
						"<localleader><localleader>de",
						"<cmd>lua require('dapui').eval('')<left><left>",
						desc = desc("debug; dapui eval with prompts"),
					},
				},
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				config = function()
					require("nvim-dap-virtual-text").setup()
				end,
			},
			{
				"nvim-telescope/telescope-dap.nvim",
				lazy = true,
				config = function()
					require("telescope").load_extension("dap")
				end,
			},
			"mxsdev/nvim-dap-vscode-js",
			{
				"microsoft/vscode-js-debug",
				build = "npm install --legacy-peer-deps && npm run compile",
				lazy = true,
				pin = true,
				config = function()
					require("dap-vscode-js").setup({
						-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
						debugger_path = os.getenv("HOME")
							.. "/.local/share/nvim/site/pack/packer/start/vscode-js-debug", -- Path to vscode-js-debug installation.
						adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
					})

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
		},
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
			{ "`o", "<cmd>lua require('dap').step_over()<cr>", desc = desc("debug: step over") },
			{ "`i", "<cmd>lua require('dap').step_into()<cr>", desc = desc("debug: step into") },
			{ "`u", "<cmd>lua require('dap').step_out()<cr>", desc = desc("debug: step out") },
			{ "`j", "<cmd>lua require('dap').down()<cr>", desc = desc("debug: go down") },
			{ "`k", "<cmd>lua require('dap').up()<cr>", desc = desc("debug: go up") },
			{ "<localleader>dt", "<cmd>lua require('dap').terminate()<cr>", desc = desc("debug: terminate") },
			{ "<localleader>dr", "<cmd>lua require('dap').repl.toggle()<cr>", desc = desc("debug: restart") },
			{ "<localleader>dc", "<cmd>lua require('dap').run_to_cursor()<cr>", desc = desc("debug: run to cursor") },
			{ "<localleader>da", ":Telescope dap commands<cr>", desc = desc("debug: show list of commands") },
			{
				"<localleader>ds",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.scopes)
				end,
				desc = desc("debug: show scopes"),
			},
			{
				"<localleader>df",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.frames)
				end,
				desc = desc("debug: show frames"),
			},
		},
	},
}
