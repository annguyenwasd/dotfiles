return function()
	require("null-ls").setup({
		sources = {
			require("null-ls").builtins.formatting.stylua,
			require("null-ls").builtins.formatting.prettierd,
			require("null-ls").builtins.formatting.jq,
			require("null-ls").builtins.formatting.shfmt,
			require("null-ls").builtins.formatting.yamlfmt,
			require("null-ls").builtins.formatting.ktlint,
			require("null-ls").builtins.formatting.markdownlint,
		},
	})
end
