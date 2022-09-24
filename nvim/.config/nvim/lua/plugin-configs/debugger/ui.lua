return function()
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

	vim.keymap.set("n", "<localleader>du", ':lua require("dapui").open()<cr>')
	vim.keymap.set("n", "`h", ':lua require("dapui").eval()<cr>')
	vim.keymap.set("v", "`h", ':lua require("dapui").eval()<cr>')
	vim.keymap.set("n", "<localleader><localleader>de", ":lua require('dapui').eval('')<left><left>")
end
