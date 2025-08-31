local M = {}

-- this functin will open yazi in a split window with custom path
M.open_yazi = function(path)
  vim.cmd("tabnew term://yazi " .. vim.fn.expand(path) .. "|startinsert")
end

return M
