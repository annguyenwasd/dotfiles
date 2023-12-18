local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local OUTPUT_FILE_NAME = "__output__.lua"
local THEME_FOLDER = "themes/"
local APP_NAME = os.getenv("NVIM_APPNAME") or "nvim"
local THEME_FOLDER_FULL_PATH = vim.fn.expand("$HOME/.config/" .. APP_NAME .. "/lua/" .. THEME_FOLDER)

local function write_file(file_name, func_name)
	vim.fn.writefile(
		{ "require('themes." .. file_name .. "')." .. func_name .. "()" },
		THEME_FOLDER_FULL_PATH ..OUTPUT_FILE_NAME
	)
end

local pick_color = function(opts, file_name)
	local theme = require(THEME_FOLDER .. file_name)
	local fns = {}
	for key, _ in pairs(theme) do
		table.insert(fns, key)
	end
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "Variant",
			finder = finders.new_table(fns),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					local func_name = selection[1]
					require(THEME_FOLDER .. file_name)[func_name]()
					write_file(file_name, func_name)
				end)
				return true
			end,
		})
		:find()
end

local pick_file = function(opts)
	opts = opts or {}
	local files = vim.fn.readdir(THEME_FOLDER_FULL_PATH)
	local theme_files = {}
	for _, file_name in ipairs(files) do
		local name = file_name:gsub(".lua", "") -- remove .lua
		if file_name ~= OUTPUT_FILE_NAME then
			table.insert(theme_files, name)
		end
	end
	pickers
		.new(opts, {
			prompt_title = "Theme",
			finder = finders.new_table(theme_files),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					pick_color(opts, selection[1])
				end)
				return true
			end,
		})
		:find()
end

return function()
	pick_file(require("telescope.themes").get_dropdown({}))
end
