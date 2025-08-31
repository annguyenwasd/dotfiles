vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("SetFoldMethod", { clear = true }),
  pattern = { "*.vimrc", "*.vim", "*.zshrc", "*.zsh", "*.conf" },
  command = "setlocal foldmethod=marker",
})

-- Auto-command: only load mappings inside netrw
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NetRWKeyBinds", { clear = true }),
  pattern = "netrw",
  callback = function()
    vim.keymap.set(
      "n",
      "<C-f>",
      require('utils.netrw').netrw_find_files,
      { desc = desc("netrw: Use telescope to find files under this directory") }
    )
    vim.keymap.set(
      "n",
      "<C-g>",
      require('utils.netrw').netrw_live_grep,
      { desc = desc("netrw: Use telescope to live grep under this directory") }
    )
  end,
})
