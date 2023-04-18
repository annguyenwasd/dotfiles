-- config common plugins used between coq & cmp
return function()
	-- ╭──────────────────────────────────────────────────────────╮
	-- │                   kkharji/lspsaga.nvim                   │
	-- ╰──────────────────────────────────────────────────────────╯

	vim.keymap.set("n", "<leader>rn", "<cmd>LspUI rename<cr>")
	vim.keymap.set("n", "<leader>ca", "<cmd>LspUI code_action<cr>")
	vim.keymap.set("n", "]d", "<cmd>LspUI diagnostic next<cr>")
	vim.keymap.set("n", "[d", "<cmd>LspUI diagnostic prev<cr>")
	vim.keymap.set("n", "K", "<cmd>LspUI hover<cr>")

	-- ╭──────────────────────────────────────────────────────────╮
	-- │                 ray-x/lsp_signature.nvim                 │
	-- ╰──────────────────────────────────────────────────────────╯

	require("lsp_signature").setup({ toggle_key = "<c-s>" })
end
