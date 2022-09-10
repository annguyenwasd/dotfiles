-- vim.api.nvim_create_autocmd("BufEnter", {
--     group = vim.api.nvim_create_augroup("OpenHelpOnRightMostWindow",
--                                         {clear = true}),
--     pattern = "*.txt",
--     command = "if &buftype == 'help' | wincmd L | endif",
--     desc = "Open help page on the right (default bottom)"
-- })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("SetFoldMethod", { clear = true }),
	pattern = { "*.vim", "*.lua", "*.zsh", "*.conf" },
	command = "setlocal foldmethod=marker",
})

--[[ vim.api.nvim_create_autocmd({ "BufRead" }, { ]]
--[[ 	group = vim.api.nvim_create_augroup("AutoSetFoldLevelInitLua", { clear = true }), ]]
--[[ 	pattern = { "*.lua" }, ]]
--[[ 	command = "setlocal foldlevel=1", ]]
--[[ }) ]]

local cursor_line_only_in_active_window = vim.api.nvim_create_augroup("CursorLineOnlyInActiveWindow", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
	group = cursor_line_only_in_active_window,
	pattern = "*",
	command = "setlocal cursorline",
})

vim.api.nvim_create_autocmd("WinLeave", {
	group = cursor_line_only_in_active_window,
	pattern = "*",
	command = "setlocal nocursorline",
})
