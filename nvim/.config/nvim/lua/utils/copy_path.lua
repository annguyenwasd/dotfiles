local M = {}

M.copy_path = function(is_relative)
  local full_path = vim.fn.expand("%:p")
  local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")

  local path
  if is_relative then
    if vim.v.shell_error == 0 and git_root ~= "" then
      -- Relative to git root
      path = full_path:gsub("^" .. vim.pesc(git_root .. "/"), "")
    else
      -- Fallback to cwd
      path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
    end
  else
    path = full_path
  end

  -- Copy to clipboard (both + and *)
  vim.fn.setreg("+", path)
  vim.fn.setreg("*", path)

  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end

return M
