return {
	{
		"mfussenegger/nvim-dap",
		init = function()
			vim.cmd([[
      au FileType dap-repl lua require('dap.ext.autocompl').attach()
      ]])
		end,
		config = function()
			local dap = require("dap")
			local widgets = require("dap.ui.widgets")

			vim.keymap.set("n", "<localleader>bb", dap.toggle_breakpoint, make_mapping_opts("debug: toggle breakpoint"))

			vim.keymap.set("n", "<localleader>bc", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, make_mapping_opts("debug: toggle breakpoint with a condition"))

			vim.keymap.set("n", "<localleader>bl", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, make_mapping_opts("debug: log point message"))

			vim.keymap.set("n", "<localleader>BB", function()
				dap.list_breakpoints()
			end, make_mapping_opts("debug: list breakpoints"))

			vim.keymap.set("n", "<localleader>c", dap.continue, make_mapping_opts("debug: continue/start debugging"))
			vim.keymap.set("n", "`o", dap.step_over, make_mapping_opts("debug: step over"))
			vim.keymap.set("n", "`i", dap.step_into, make_mapping_opts("debug: step into"))
			vim.keymap.set("n", "`u", dap.step_out, make_mapping_opts("debug: step out"))
			vim.keymap.set("n", "`j", dap.down, make_mapping_opts("debug: go down"))
			vim.keymap.set("n", "`k", dap.up, make_mapping_opts("degbug: go up"))
			vim.keymap.set("n", "<localleader>dt", dap.terminate, make_mapping_opts("debug: terminate"))
			vim.keymap.set("n", "<localleader>dr", dap.repl.toggle, make_mapping_opts("debug: restart"))
			vim.keymap.set("n", "<localleader>dc", dap.run_to_cursor, make_mapping_opts("debug: run to cursor"))

			vim.keymap.set(
				"n",
				"<localleader>da",
				":Telescope dap commands<cr>",
				make_mapping_opts("debug: show list of commands")
			)

			vim.keymap.set("n", "<localleader>ds", function()
				widgets.centered_float(widgets.scopes)
			end, make_mapping_opts("debug: show scopes"))

			vim.keymap.set("n", "<localleader>df", function()
				widgets.centered_float(widgets.frames)
			end, make_mapping_opts("debug: show frames"))
		end,
		keys = {
			{
				"<localleader>c",
			},
		},
	},
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

			vim.keymap.set(
				"n",
				"<localleader>du",
				':lua require("dapui").open()<cr>',
				make_mapping_opts("debug: dapui open")
			)
			vim.keymap.set("n", "`h", ':lua require("dapui").eval()<cr>', make_mapping_opts("debug: dapui eval"))
			vim.keymap.set(
				"v",
				"`h",
				':lua require("dapui").eval()<cr>',
				make_mapping_opts("debug: dapui selection eval")
			)

			vim.keymap.set(
				"n",
				"<localleader><localleader>de",
				":lua require('dapui').eval('')<left><left>",
				make_mapping_opts("debug; dapui eval with prompts")
			)
		end,
		keys = {
			"<localleader>du",
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
    pin=true,
		config = function()
			require("dap-vscode-js").setup({
				-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
				debugger_path = os.getenv("HOME") .. "/.local/share/nvim/site/pack/packer/start/vscode-js-debug", -- Path to vscode-js-debug installation.
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
}
