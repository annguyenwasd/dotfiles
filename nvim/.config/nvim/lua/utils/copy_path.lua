local M = {}

-- Synced from .vimrc CopyPath() — supports 'relative', 'absolute', 'detailed' modes
-- Also supports boolean for backward compatibility (true=relative, false=absolute)
M.copy_path = function(mode)
  local full_path = vim.fn.expand("%:p")
  local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")

  -- Backward compatibility: boolean → string mode
  if type(mode) == "boolean" then
    mode = mode and "relative" or "absolute"
  end

  local path
  if mode == "relative" then
    if vim.v.shell_error == 0 and git_root ~= "" then
      -- Relative to git root
      path = full_path:gsub("^" .. vim.pesc(git_root .. "/"), "")
    else
      -- Fallback to cwd
      path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
    end
  elseif mode == "detailed" then
    -- Absolute path with function name or line number
    path = full_path
    local line_num = vim.fn.line(".")
    local func_name = ""

    -- Check if current line contains 'function'
    local current_line = vim.fn.getline(".")
    if current_line:match("[Ff]unction") then
      func_name = vim.fn.matchstr(current_line, "\\cfunction\\S*\\s\\+\\zs\\w\\+")
    end

    -- If current line doesn't have function, search backwards
    if func_name == "" then
      local func_line = vim.fn.search("\\cfunction", "bnW")
      if func_line > 0 then
        local func_text = vim.fn.getline(func_line)
        func_name = vim.fn.matchstr(func_text, "\\cfunction\\S*\\s\\+\\zs\\w\\+")
      end
    end

    -- Add function name or line number
    if func_name ~= "" then
      path = path .. " at " .. func_name .. "() function"
    else
      path = path .. ":" .. line_num
    end
  else
    -- absolute
    path = full_path
  end

  -- Copy to clipboard (both + and *)
  vim.fn.setreg("+", path)
  vim.fn.setreg("*", path)

  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end

return M
