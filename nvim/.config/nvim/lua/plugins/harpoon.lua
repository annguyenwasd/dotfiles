return {
	{
		"ThePrimeagen/harpoon",
		keys = {
			{
				"ma",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = desc("harpoon: add file to harpoon list"),
			},
			{
				"mq",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = desc("harpoon: show list of bookmarks"),
			},
			{
				"'1",
				function()
					require("harpoon.ui").nav_file(1)
				end,
				desc = desc("harpoon: navigate to file #1"),
			},
			{
				"'2",
				function()
					require("harpoon.ui").nav_file(2)
				end,
				desc = desc("harpoon: navigate to file #2"),
			},
			{
				"'3",
				function()
					require("harpoon.ui").nav_file(3)
				end,
				desc = desc("harpoon: navigate to file #3"),
			},
			{
				"'4",
				function()
					require("harpoon.ui").nav_file(4)
				end,
				desc = desc("harpoon: navigate to file #4"),
			},
			{
				"'5",
				function()
					require("harpoon.ui").nav_file(5)
				end,
				desc = desc("harpoon: navigate to file #5"),
			},
			{
				"'6",
				function()
					require("harpoon.ui").nav_file(6)
				end,
				desc = desc("harpoon: navigate to file #6"),
			},
			{
				"'7",
				function()
					require("harpoon.ui").nav_file(7)
				end,
				desc = desc("harpoon: navigate to file #7"),
			},
			{
				"'8",
				function()
					require("harpoon.ui").nav_file(8)
				end,
				desc = desc("harpoon: navigate to file #8"),
			},
			{
				"'9",
				function()
					require("harpoon.ui").nav_file(9)
				end,
				desc = desc("harpoon: navigate to file #9"),
			},
		},
	},
}