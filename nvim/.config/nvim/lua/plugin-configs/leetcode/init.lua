return function()
	vim.g.leetcode_browser = "chrome"
	vim.g.leetcode_solution_filetype = "javascript"

	vim.keymap.set("n", "<leader>ll", ":LeetCodeList<cr>")
	vim.keymap.set("n", "<leader>lt", ":LeetCodeTest<cr>")
	vim.keymap.set("n", "<leader>ls", ":LeetCodeSubmit<cr>")
	vim.keymap.set("n", "<leader>li", ":LeetCodeSignIn<cr>")
end
