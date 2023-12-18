return {
	{
		"jbyuki/venn.nvim",
		config = function()
			local function toggle_venn()
				local venn_enabled = vim.inspect(vim.b.venn_enabled)
				if venn_enabled == "nil" then
					print("Started diagram...")
					vim.b.venn_enabled = true
					vim.cmd([[setlocal ve=all]])
					-- draw a line on HJKL keystokes
					vim.keymap.set("n", "J", "<C-v>j:VBox<CR>", make_mapping_opts("diagram: draw down", { noremap = true, buffer = 0 }))
					vim.keymap.set("n", "K", "<C-v>k:VBox<CR>", make_mapping_opts("diagram: draw up", { noremap = true, buffer = 0 }))
					vim.keymap.set("n", "L", "<C-v>l:VBox<CR>", make_mapping_opts("diagram: draw right", { noremap = true, buffer = 0 }))
					vim.keymap.set("n", "H", "<C-v>h:VBox<CR>", make_mapping_opts("diagram: draw left", { noremap = true, buffer = 0 }))
					-- draw a box by pressing "f" with visual selection
					vim.keymap.set("v", "f", ":VBox<CR>", make_mapping_opts("diagram: draw box", { noremap = true, buffer = 0 }))
				else
					print("Stopped diagram...")
					vim.cmd([[setlocal ve=]])
					vim.cmd([[mapclear <buffer>]])
					vim.b.venn_enabled = nil
				end
			end
			-- toggle keymappings for venn using <leader>v
			vim.keymap.set("n", "<leader>vv", toggle_venn, make_mapping_opts("diagram: toggle diagram mode", { noremap = true }))
		end,
		keys = "<leader>vv",
	},
}
