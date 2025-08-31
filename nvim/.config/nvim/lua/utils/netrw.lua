-- Function: telescope find_files from cursor in netrw
local function netrw_find_files()
  -- get the line under cursor
  local line = vim.fn.getline(".")
  -- expand to absolute path
  local path = vim.fn.fnamemodify(line, ":p")
  -- if it's a file, go up to its parent
  if vim.fn.isdirectory(path) == 0 then
    path = vim.fn.fnamemodify(path, ":h")
  end
  require("telescope.builtin").find_files({
    cwd = path,
    hidden = true,
    search_dirs = { path },
    prompt_title = "Find files under " .. path,
  })
end

-- Function: telescope live_grep from cursor in netrw
local function netrw_live_grep()
  local line = vim.fn.getline(".")
  local path = vim.fn.fnamemodify(line, ":p")
  if vim.fn.isdirectory(path) == 0 then
    path = vim.fn.fnamemodify(path, ":h")
  end
  require("telescope.builtin").live_grep({
    cwd = path,
    search_dirs = { path },
    prompt_title = "Live grep under " .. path,
  })
end

local M = {}
M.netrw_find_files = netrw_find_files
M.netrw_live_grep = netrw_live_grep

return M
