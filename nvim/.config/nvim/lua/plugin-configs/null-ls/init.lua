return function()
	local null_ls = require("null-ls")
	require("null-ls").setup({
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.beautysh,
			null_ls.builtins.formatting.yamlfmt,
			null_ls.builtins.formatting.ktlint,
			null_ls.builtins.formatting.markdownlint,
			null_ls.builtins.formatting.trim_whitespace,

			null_ls.builtins.diagnostics.eslint_d,
			null_ls.builtins.code_actions.eslint_d,

			null_ls.builtins.hover.dictionary,
			null_ls.builtins.hover.printenv,
		},
	})
end
