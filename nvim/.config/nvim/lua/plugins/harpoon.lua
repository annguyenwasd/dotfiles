-- Function to retrieve the nearest test name from `it()` or `describe()` calls
-- above the current cursor position in a Neovim buffer.
--
-- This function searches for the nearest `it()` or `describe()` function calls
-- in the current buffer, starting from the line where the cursor is located
-- and moving upwards. It extracts the first argument (test name) of the nearest
-- `it()` or `describe()` call, which is expected to be a string enclosed in
-- either single or double quotes.
--
-- Returns:
--   - A string containing the first argument of the nearest `it()` or `describe()`
--     call, or `nil` if none are found.
--
-- Usage:
--   local test_name = get_test_name()
--   print("Test Name: " .. (test_name or "No test name found."))
function get_test_name()
	-- Get the current buffer
	local buf = vim.api.nvim_get_current_buf()

	-- Get the current cursor position
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	-- Search for the nearest `it()` or `desc()` above the current line
	local start_row = row
	local test_name = nil
	while start_row > 0 do
		local line = vim.api.nvim_buf_get_lines(buf, start_row - 1, start_row, false)[1]
		if line then
			local it_start, it_end = line:find("it%(")
			local desc_start, desc_end = line:find("describe%(")
			if it_start then
				local quote_start = line:find('"', it_end) or line:find("'", it_end)
				local quote_end = quote_start and line:find('"', quote_start + 1) or line:find("'", quote_start + 1)
				test_name = line:sub(quote_start + 1, quote_end - 1)
				break
			elseif desc_start then
				local quote_start = line:find('"', desc_end) or line:find("'", desc_end)
				local quote_end = quote_start and line:find('"', quote_start + 1) or line:find("'", quote_start + 1)
				test_name = line:sub(quote_start + 1, quote_end - 1)
				break
			end
		end
		start_row = start_row - 1
	end

	return test_name
end
return {
	{
		"ThePrimeagen/harpoon",
		opts = {
			global_settings = {
				enter_on_sendcmd = true,
			},
		},
		keys = {
			{
				"<localleader>1",
				"<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>",
				desc = desc("harpoon: go to terminal 1"),
			},
			{
				"<localleader>2",
				"<cmd>lua require('harpoon.term').gotoTerminal(2)<cr>",
				desc = desc("harpoon: go to terminal 2"),
			},
			{
				"<localleader>3",
				"<cmd>lua require('harpoon.term').gotoTerminal(3)<cr>",
				desc = desc("harpoon: go to terminal 3"),
			},
			{
				"<localleader>4",
				"<cmd>lua require('harpoon.term').gotoTerminal(4)<cr>",
				desc = desc("harpoon: go to terminal 4"),
			},
			{
				"<localleader>5",
				"<cmd>lua require('harpoon.term').gotoTerminal(5)<cr>",
				desc = desc("harpoon: go to terminal 5"),
			},
			{ "ma", '<cmd>lua require"harpoon.mark".add_file()<cr>', desc = desc("harpoon: add file to harpoon list") },
			{
				"mq",
				'<cmd>lua require"harpoon.ui".toggle_quick_menu()<cr>',
				desc = desc("harpoon: show list of bookmarks"),
			},
			{ "'1", '<cmd>lua require"harpoon.ui".nav_file(1)<cr>', desc = desc("harpoon: navigate to file #1") },
			{ "'2", '<cmd>lua require"harpoon.ui".nav_file(2)<cr>', desc = desc("harpoon: navigate to file #2") },
			{ "'3", '<cmd>lua require"harpoon.ui".nav_file(3)<cr>', desc = desc("harpoon: navigate to file #3") },
			{ "'4", '<cmd>lua require"harpoon.ui".nav_file(4)<cr>', desc = desc("harpoon: navigate to file #4") },
			{ "'5", '<cmd>lua require"harpoon.ui".nav_file(5)<cr>', desc = desc("harpoon: navigate to file #5") },
			{ "'6", '<cmd>lua require"harpoon.ui".nav_file(6)<cr>', desc = desc("harpoon: navigate to file #6") },
			{ "'7", '<cmd>lua require"harpoon.ui".nav_file(7)<cr>', desc = desc("harpoon: navigate to file #7") },
			{ "'8", '<cmd>lua require"harpoon.ui".nav_file(8)<cr>', desc = desc("harpoon: navigate to file #8") },
			{ "'9", '<cmd>lua require"harpoon.ui".nav_file(9)<cr>', desc = desc("harpoon: navigate to file #9") },
			{
				"<leader>t3",
				function()
					local test = get_test_name()
					local path = vim.api.nvim_buf_get_name(0)
					local command = "yarn test --watchAll=false --findRelatedTests " .. path
					if test ~= nil then
						command = command .. ' -t "' .. test .. '"'
					end
					vim.notify("Running " .. command .. " on term 3")
					require("harpoon.term").sendCommand(3, command)
				end,
				desc = desc("harpoon: grab nearest it or desc, and set to terminal 3"),
			},
		},
	},
}
