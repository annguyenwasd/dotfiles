local M = {}

-- Synced from .vimrc CopyPath() — supports 'relative', 'absolute', 'detailed' modes
-- Also supports boolean for backward compatibility (true=relative, false=absolute)
M.copy_path = function(mode, opts)
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
    if opts and opts.line_start and opts.line_end then
      path = path .. ":" .. opts.line_start .. "-" .. opts.line_end
      vim.fn.setreg("+", path)
      vim.fn.setreg("*", path)
      vim.notify("Copied: " .. path, vim.log.levels.INFO)
      return
    end
    local line_num = vim.fn.line(".")
    local func_name = ""

    -- Try to use treesitter if available
    pcall(function()
      local ts_utils = require("nvim-treesitter.ts_utils")
      local node = ts_utils.get_node_at_cursor()
      if node then
        -- Traverse up the tree to find a function node
        while node do
          local node_type = node:type()

          -- Common function node types across different languages
          if node_type:match("function") or
             node_type:match("method") or
             node_type == "function_definition" or
             node_type == "function_declaration" or
             node_type == "method_definition" or
             node_type == "arrow_function" or
             node_type == "function_item" or
             node_type == "function_call_expression" or
             node_type == "call_expression" then

            -- Try to extract the function name
            for child in node:iter_children() do
              local child_type = child:type()
              if child_type == "identifier" or
                 child_type == "property_identifier" or
                 child_type == "field_identifier" or
                 child_type == "name" then
                func_name = vim.treesitter.get_node_text(child, 0)
                break
              end
            end

            -- For anonymous functions, use a placeholder
            if func_name == "" then
              func_name = "<anonymous>"
            end
            break
          end

          node = node:parent()
        end
      end
    end)

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
