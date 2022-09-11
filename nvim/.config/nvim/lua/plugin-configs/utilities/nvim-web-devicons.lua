return function()
	require("nvim-web-devicons").setup({
		override = {
			typescriptreact = {
				icon = "",
				color = "#519aba",
				name = "Tsx",
			},
			javascriptreact = {
				icon = "",
				color = "#519aba",
				name = "Jsx",
			},
			typescript = {
				icon = "",
				color = "#519aba",
				name = "Ts",
			},
			javascript = {
				icon = "",
				color = "#519ada",
				name = "Js",
			},
		},
		default = true,
	})
end
