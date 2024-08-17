return {
	{ "LudoPinelli/comment-box.nvim", event = "BufReadPost" },
	{
		"numToStr/Comment.nvim",
		dependencies = {
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				config = function()
					require("ts_context_commentstring").setup({
						enable_autocmd = false,
					})
				end,
			},
		},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
		keys = {
			{ "gc", mode = { "n", "v" } },
			{ "gb", mode = { "n", "v" } },
		},
	},
	{
		"andrewferrier/debugprint.nvim",
		opts = function()
			local js = {
				left = 'console.log("',
				right = '")',
				mid_var = '", ',
				right_var = ")",
				---@param node TSNode
				find_treesitter_variable = function(node)
					if node:type() == "property_identifier" and node:parent() ~= nil then
						local parent = node:parent()
						---@cast parent TSNode
						return vim.treesitter.get_node_text(parent, 0)
					elseif node:type() == "identifier" then
						return vim.treesitter.get_node_text(node, 0)
					else
						return nil
					end
				end,
			}

			return {
				print_tag = "ANNGUYENWASD",
				filetypes = {
					["javascript"] = js,
					["javascriptreact"] = js,
					["typescript"] = js,
					["typescriptreact"] = js,
				},
			}
		end,
		keys = {
			"g?p",
			"g?P",
			"g?o",
			"g?O",
			"g?v",
			"g?V",
			{
				"g?d",
				":lua require('debugprint').deleteprints()<cr>",
				desc = desc("debugprint: remove all debug lines in current file"),
			},
		},
	},
}
