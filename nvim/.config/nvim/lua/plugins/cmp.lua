return {
	{
		"hrsh7th/nvim-cmp",
		event = "BufReadPost",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/nvim-cmp",
			"lukas-reineke/cmp-under-comparator",
			"dcampos/nvim-snippy",
			{
				"dcampos/cmp-snippy",
				config = function()
					require("snippy").setup({
						mappings = {
							is = {
								["<c-j>"] = "expand",
								["<c-l>"] = "next",
								["<c-h>"] = "previous",
							},
							nx = {
								["<leader>x"] = "cut_text",
							},
						},
					})
				end,
			},
			"honza/vim-snippets",
			"bydlw98/cmp-env",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				sorting = {
					priority_weight = 1,
					comparators = {
						cmp.config.compare.kind,
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						require("cmp-under-comparator").under,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("snippy").expand_snippet(args.body)
					end,
				},
				mapping = {
					["<tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end,
					["<s-tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end,
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<cr>"] = cmp.mapping.confirm({ select = false }),
					["<C-e>"] = cmp.mapping.abort(),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "snippy" },
					{ name = "nvim_lua" },
					{
						name = "buffer",
						option = {
							-- complete words from mall buffers
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
					},
					{ name = "env" },
				},
			})
		end,
	},
	{
		"onsails/lspkind-nvim",
		enabled = is_use_icons,
		config = function()
			local lspkind = require("lspkind")
			require("cmp").setup({
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					}),
				},
			})
		end,
	},
}
