return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	enabled = true,
	opts = {
		skip_confirm_for_simple_edits = true,
		-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
		-- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
		-- Additionally, if it is a string that matches "actions.<name>",
		-- it will use the mapping at require("oil.actions").<name>
		-- Set to `false` to remove a keymap
		-- See :help oil-actions for a list of all available actions
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["l"] = "actions.select",
			["<C-v>"] = "actions.select_vsplit",
			["<C-s>"] = "actions.select_split",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<c-y>"] = function()
				require("utils.yazi").open_yazi(require("oil").get_current_dir())
			end,
			["<C-r>"] = "actions.refresh",
			["-"] = "actions.parent",
			["h"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gy>"] = "actions.copy_entry_path",
			["gS"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			["g\\"] = "actions.toggle_trash",
		},
		use_default_keymaps = false,
		view_options = {
			show_hidden = true,
		},
		columns = {
			-- "permissions",
			-- "size",
			-- "ctime",
		},
	},
	keys = {
		{ "-", "<CMD>Oil<CR>", desc = desc("Open parent directory") },
	},
}
