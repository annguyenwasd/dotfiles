---@diagnostic disable: undefined-global
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local M = {}

local view_selection = function(prompt_bufnr, map)
  local openfile = require("nvim-tree.actions.node.open-file")
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local filename = selection.filename
    if filename == nil then
      filename = selection[1]
    end
    openfile.fn("preview", filename)
  end)
  return true
end

function M.launch_live_grep(opts)
  return M.launch_telescope("live_grep", opts)
end

function M.launch_find_files(opts)
  return M.launch_telescope("find_files", opts)
end

function M.launch_telescope(func_name, opts)
  local api = require("nvim-tree.api")
  local telescope_status_ok, _ = pcall(require, "telescope")
  if not telescope_status_ok then
    return
  end
  local node = api.tree.get_node_under_cursor()
  local is_folder = node.fs_stat and node.fs_stat.type == "directory" or false
  local basedir = is_folder and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
  if node.name == ".." and TreeExplorer ~= nil then
    basedir = TreeExplorer.cwd
  end
  opts = opts or {}
  opts.cwd = basedir
  opts.search_dirs = { basedir }
  opts.attach_mappings = view_selection
  if func_name == "find_files" then
    opts.prompt_title = "Find files under " .. basedir
    return require("telescope.builtin").find_files(opts)
  end
  if func_name == "live_grep" then
    opts.prompt_title = "Live Grep under " .. basedir
    return require("telescope").extensions.egrepify.egrepify(opts)
  end
end

function M.find_files(opts)
  opts = opts or {}
  opts.hidden = true
  require("telescope.builtin").find_files(opts)
end

return M
