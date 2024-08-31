return {
	{
		"ThePrimeagen/harpoon",
		keys = {
      -- TODO: send command of current it, current file to run yarn test, send it to term 1
      {"<localleader>1", "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>", desc=desc"harpoon: go to terminal 1"},
      {"<localleader>2", "<cmd>lua require('harpoon.term').gotoTerminal(2)<cr>", desc=desc"harpoon: go to terminal 2"},
      {"<localleader>3", "<cmd>lua require('harpoon.term').gotoTerminal(3)<cr>", desc=desc"harpoon: go to terminal 3"},
      {"<localleader>4", "<cmd>lua require('harpoon.term').gotoTerminal(4)<cr>", desc=desc"harpoon: go to terminal 4"},
      {"<localleader>5", "<cmd>lua require('harpoon.term').gotoTerminal(5)<cr>", desc=desc"harpoon: go to terminal 5"},
			{ "ma", '<cmd>lua require"harpoon.mark".add_file()<cr>', desc=desc("harpoon: add file to harpoon list"),},
      { "mq", '<cmd>lua require"harpoon.ui".toggle_quick_menu()<cr>', desc=desc("harpoon: show list of bookmarks"),},
      { "'1", '<cmd>lua require"harpoon.ui".nav_file(1)<cr>', desc=desc("harpoon: navigate to file #1"),},
      { "'2", '<cmd>lua require"harpoon.ui".nav_file(2)<cr>', desc=desc("harpoon: navigate to file #2"),},
      { "'3", '<cmd>lua require"harpoon.ui".nav_file(3)<cr>', desc=desc("harpoon: navigate to file #3"),},
      { "'4", '<cmd>lua require"harpoon.ui".nav_file(4)<cr>', desc=desc("harpoon: navigate to file #4"),},
      { "'5", '<cmd>lua require"harpoon.ui".nav_file(5)<cr>', desc=desc("harpoon: navigate to file #5"),},
      { "'6", '<cmd>lua require"harpoon.ui".nav_file(6)<cr>', desc=desc("harpoon: navigate to file #6"),},
			{ "'7", '<cmd>lua require"harpoon.ui".nav_file(7)<cr>', desc=desc("harpoon: navigate to file #7"),},
			{ "'8", '<cmd>lua require"harpoon.ui".nav_file(8)<cr>', desc=desc("harpoon: navigate to file #8"),},
			{ "'9", '<cmd>lua require"harpoon.ui".nav_file(9)<cr>', desc=desc("harpoon: navigate to file #9"),},
		},
	},
}
