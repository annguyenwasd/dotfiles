return {
	{
		"danihek/hellwal-vim",
    cond=function()
      return fileExists("~/.cacle/hellwal/colors.vim")
    end,
		config = function()
			vim.cmd("colorscheme hellwal")
		end,
	},
}
