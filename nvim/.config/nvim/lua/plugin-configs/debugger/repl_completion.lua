return function()
	vim.cmd([[
      au FileType dap-repl lua require('dap.ext.autocompl').attach()
      ]])
end