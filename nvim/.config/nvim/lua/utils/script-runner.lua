--[[
Script Runner - Execute npm/yarn/pnpm scripts via Telescope picker

DESCRIPTION:
  Finds the nearest package.json from the current file or directory,
  reads its "scripts" field, and presents them in a Telescope picker
  for fuzzy search and execution.

USAGE:
  Keybinding: <leader>sr (space + s + r)
  Or manually: :lua require('utils.script-runner').run_script_picker()

FEATURES:
  - Automatically detects package manager (pnpm > yarn > npm) based on lock files
  - Searches upward from current file location for package.json
  - Falls back to current directory if no file is open
  - Fuzzy search through script names and commands
  - Executes scripts via vim-dispatch (Start! command) in background
  - Shows script name and command in picker display
  - Alphabetically sorted script list

DEPENDENCIES:
  - telescope.nvim
  - vim-dispatch

EXAMPLE:
  For a package.json with:
  {
    "scripts": {
      "dev": "vite",
      "build": "tsc && vite build",
      "test": "vitest"
    }
  }

  Opens picker showing:
    dev                            vite
    build                          tsc && vite build
    test                           vitest

  Selecting "dev" executes: Start! pnpm run dev
--]]

local M = {}

-- Detect which package manager is being used
local function detect_package_manager(package_json_dir)
  local pnpm_lock = vim.fn.findfile("pnpm-lock.yaml", package_json_dir .. ";")
  local yarn_lock = vim.fn.findfile("yarn.lock", package_json_dir .. ";")

  if pnpm_lock ~= "" then
    return "pnpm"
  elseif yarn_lock ~= "" then
    return "yarn"
  else
    return "npm"
  end
end

-- Find nearest package.json
local function find_package_json()
  local current_file = vim.fn.expand("%:p")
  local search_path

  -- If no file is open or current buffer is not a file, use current directory
  if current_file == "" or vim.fn.filereadable(current_file) == 0 then
    search_path = vim.fn.getcwd()
  else
    search_path = vim.fn.expand("%:p:h")
  end

  local package_json = vim.fn.findfile("package.json", search_path .. ";")

  if package_json == "" then
    return nil
  end

  return vim.fn.fnamemodify(package_json, ":p")
end

-- Parse scripts from package.json
local function get_scripts_from_package_json(package_json_path)
  local file = io.open(package_json_path, "r")

  if not file then
    vim.notify("Could not open package.json", vim.log.levels.ERROR)
    return nil
  end

  local content = file:read("*a")
  file:close()

  local ok, decoded = pcall(vim.json.decode, content)
  if not ok then
    vim.notify("Could not parse package.json", vim.log.levels.ERROR)
    return nil
  end

  return decoded.scripts or {}
end

-- Main function to open script runner
function M.run_script_picker()
  local package_json_path = find_package_json()

  if not package_json_path then
    vim.notify("No package.json found", vim.log.levels.WARN)
    return
  end

  local scripts = get_scripts_from_package_json(package_json_path)

  if not scripts or vim.tbl_isempty(scripts) then
    vim.notify("No scripts found in package.json", vim.log.levels.WARN)
    return
  end

  local package_dir = vim.fn.fnamemodify(package_json_path, ":h")
  local package_manager = detect_package_manager(package_dir)

  -- Convert scripts to telescope entries
  local entries = {}
  for name, command in pairs(scripts) do
    table.insert(entries, {
      name = name,
      command = command,
    })
  end

  -- Sort alphabetically by script name
  table.sort(entries, function(a, b)
    return a.name < b.name
  end)

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Script Runner",
    finder = finders.new_table({
      results = entries,
      entry_maker = function(entry)
        return {
          value = entry,
          display = string.format("%-30s %s", entry.name, entry.command),
          ordinal = entry.name .. " " .. entry.command,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        if selection then
          local script_name = selection.value.name
          local cmd = string.format("Start! %s run %s", package_manager, script_name)
          vim.notify(string.format("Running: %s run %s", package_manager, script_name))
          vim.cmd(cmd)
        end
      end)
      return true
    end,
  }):find()
end

return M
