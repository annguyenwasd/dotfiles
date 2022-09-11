return function()
	local dap = require("dap")
	local widgets = require("dap.ui.widgets")

	vim.keymap.set("n", "<localleader>bb", dap.toggle_breakpoint)
	vim.keymap.set("n", "<localleader>bc", function()
		dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end)
	vim.keymap.set("n", "<localleader>bl", function()
		dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end)
	vim.keymap.set("n", "<localleader>BB", function()
		dap.list_breakpoints()
	end)
	vim.keymap.set("n", "<localleader>c", dap.continue)
	vim.keymap.set("n", "`o", dap.step_over)
	vim.keymap.set("n", "`i", dap.step_into)
	vim.keymap.set("n", "`u", dap.step_out)
	vim.keymap.set("n", "`j", dap.down)
	vim.keymap.set("n", "`k", dap.up)
	vim.keymap.set("n", "<localleader>dt", dap.terminate)
	vim.keymap.set("n", "<localleader>dr", dap.repl.toggle)
	vim.keymap.set("n", "<localleader>dc", dap.run_to_cursor)
	vim.keymap.set("n", "`h", widgets.hover)
	vim.keymap.set("n", "<localleader>da", ":Telescope dap commands<cr>")
	vim.keymap.set("n", "<localleader>ds", function()
		widgets.centered_float(widgets.scopes)
	end)
	vim.keymap.set("n", "<localleader>df", function()
		widgets.centered_float(widgets.frames)
	end)

	-- ╭──────────────────────────────────────────────────────────╮
	-- │                microsoft/vscode-js-debug                 │
	-- ╰──────────────────────────────────────────────────────────╯

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

	-- ╭──────────────────────────────────────────────────────────╮
	-- │            nvim-telescope/telescope-dap.nvim             │
	-- ╰──────────────────────────────────────────────────────────╯
	require("telescope").load_extension("dap")

	-- ╭──────────────────────────────────────────────────────────╮
	-- │             theHamsta/nvim-dap-virtual-text              │
	-- ╰──────────────────────────────────────────────────────────╯
	require("nvim-dap-virtual-text").setup()
end
