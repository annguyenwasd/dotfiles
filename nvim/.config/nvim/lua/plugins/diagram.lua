return {
  "jbyuki/venn.nvim",
  keys = {
    {
      "<leader>vv",
      function()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
          print("Started diagram...")
          vim.b.venn_enabled = true
          vim.cmd([[setlocal ve=all]])
          vim.keymap.set(
            "n",
            "J",
            "<C-v>j:VBox<CR>",
            { desc = desc("diagram: draw down"), noremap = true, buffer = 0 }
          )
          vim.keymap.set(
            "n",
            "K",
            "<C-v>k:VBox<CR>",
            { desc = desc("diagram: draw up"), noremap = true, buffer = 0 }
          )
          vim.keymap.set(
            "n",
            "L",
            "<C-v>l:VBox<CR>",
            { desc = desc("diagram: draw right"), noremap = true, buffer = 0 }
          )
          vim.keymap.set(
            "n",
            "H",
            "<C-v>h:VBox<CR>",
            { desc = desc("diagram: draw left"), noremap = true, buffer = 0 }
          )
          vim.keymap.set(
            "v",
            "f",
            ":VBox<CR>",
            { desc = desc("diagram: draw box"), noremap = true, buffer = 0 }
          )
        else
          print("Stopped diagram...")
          vim.cmd([[setlocal ve=]])
          vim.cmd([[mapclear <buffer>]])
          vim.b.venn_enabled = nil
        end
      end,
      desc = desc("diagram: toggle diagram mode"),
      noremap = true,
    },
  },
}
