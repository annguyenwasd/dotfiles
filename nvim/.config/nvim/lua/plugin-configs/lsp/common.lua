-- config common plugins used between coq & cmp
return function()
	-- ╭──────────────────────────────────────────────────────────╮
	-- │                   kkharji/lspsaga.nvim                   │
	-- ╰──────────────────────────────────────────────────────────╯

	vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>")
	vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>")
	vim.keymap.set("x", "<leader>ca", "<cmd>Lspsaga range_code_action<cr>")

	-- ╭──────────────────────────────────────────────────────────╮
	-- │                 ray-x/lsp_signature.nvim                 │
	-- ╰──────────────────────────────────────────────────────────╯

	require("lsp_signature").setup({ toggle_key = "<c-s>" })
end
