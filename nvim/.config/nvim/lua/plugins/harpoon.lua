return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      vim.keymap.set("n", "ma", function() harpoon:list():add() end, { desc = desc("harpoon: add file to harpoon list") })
      vim.keymap.set("n", "mq", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = desc("harpoon: show list of bookmarks") })
      vim.keymap.set("n", "'1", function() harpoon:list():select(1) end, { desc = desc("harpoon: navigate to file #1") })
      vim.keymap.set("n", "'2", function() harpoon:list():select(1) end, { desc = desc("harpoon: navigate to file #2") })
      vim.keymap.set("n", "'3", function() harpoon:list():select(1) end, { desc = desc("harpoon: navigate to file #3") })
      vim.keymap.set("n", "'4", function() harpoon:list():select(1) end, { desc = desc("harpoon: navigate to file #4") })
      vim.keymap.set("n", "'5", function() harpoon:list():select(1) end, { desc = desc("harpoon: navigate to file #5") })
      vim.keymap.set("n", "'6", function() harpoon:list():select(1) end, { desc = desc("harpoon: navigate to file #6") })
      vim.keymap.set("n", "'7", function() harpoon:list():select(1) end, { desc = desc("harpoon: navigate to file #7") })
      vim.keymap.set("n", "'8", function() harpoon:list():select(1) end, { desc = desc("harpoon: navigate to file #8") })
      vim.keymap.set("n", "'9", function() harpoon:list():select(1) end, { desc = desc("harpoon: navigate to file #9") })

      harpoon:extend({
        UI_CREATE = function(cx)
          vim.keymap.set("n", "<C-v>", function()
            harpoon.ui:select_menu_item({ vsplit = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-s>", function()
            harpoon.ui:select_menu_item({ split = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-t>", function()
            harpoon.ui:select_menu_item({ tabedit = true })
          end, { buffer = cx.bufnr })
        end,
      })
    end,
  },
}
