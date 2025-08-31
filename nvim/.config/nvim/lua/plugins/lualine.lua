return {
  {
    "nvim-lualine/lualine.nvim",
    event = "BufReadPre",
    config = function()
      local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end

      vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "FocusGained" }, {
        callback = function()
          local git_output = vim.fn.system("git config --local core.bare", true)
          vim.b.is_bare = string.find(git_output, "true", 1, true) ~= nil
        end,
      })

      local signs = require("utils.signs")

      local diagnostic = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        colored = false,
        symbols = { error = signs.Error, warn = signs.Warn, hint = signs.Hint, info = signs.Info },
      }

      local branch = { "branch", icon = "" }
      if not is_use_icons() then
        branch = { "branch", icon = "" }
      end
      local diff = { "diff", source = diff_source, colored = false }
      local file_name = {
        "filename",
        path = 3,
        shorting_target = 40,
      }
      local fileformat = { "fileformat" }
      if not is_use_icons() then
        fileformat.symbols = {
          unix = "unix", -- e712
          dos = "dos", -- e70f
          mac = "mac", -- e711
        }
      end

      require("lualine").setup({
        options = {
          icons_enabled = is_use_icons(),
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "gitcommit", "NvimTree", "mind" },
          always_divide_middle = true,
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            file_name,
            diagnostic,
            diff,
          },
          lualine_x = {
            "lsp_progress",
            branch,
            "progress",
            "location",
            fileformat,
            "encoding",
          },
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            file_name,
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
  { "arkav/lualine-lsp-progress" },
}
