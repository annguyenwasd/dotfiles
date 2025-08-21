---@diagnostic disable: missing-fields
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "html", "lua", "typescript", "javascript", "markdown", "markdown_inline", "vimdoc" },
        ignore_install = {},
        auto_install = false,
        sync_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = function(lang, buf)
            -- 0) Disable TS for help buffers (your earlier ask)
            if vim.bo[buf].filetype == "help" then
              return true
            end

            if vim.bo[buf].filetype == "leetcode.nvim" then
              return true
            end

            -- 1) Make sure uv exists (0.10+: vim.uv, older: vim.loop)
            local uv = vim.uv or vim.loop

            -- 2) Get the buffer's path and skip non-file buffers (term://, oil://, etc.)
            local name = vim.api.nvim_buf_get_name(buf)
            if name == "" or name:match("^%w+://") then
              return false
            end

            -- 3) Large file guard (100 KB)
            local max_filesize = 1000 * 1024
            local ok, stats = pcall(uv.fs_stat, name)
            if ok and stats and stats.size and stats.size > max_filesize then
              return true
            end

            return false
          end,
        },
        indent = { enable = false },
      })
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        cond = false,
        keys = {
          {
            "{",
            function()
              require("treesitter-context").go_to_context(vim.v.count1)
            end,
            silent = true,
            desc = desc("Jump to upper context"),
          },
        },
      },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
          require("nvim-treesitter.configs").setup({
            textobjects = {
              select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

                keymaps = {
                  -- You can use the capture groups defined in textobjects.scm
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  -- You can optionally set descriptions to the mappings (used in the desc parameter of
                  -- nvim_buf_set_keymap) which plugins like which-key display
                  ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                  -- You can also use captures from other query groups like `locals.scm`
                  ["as"] = {
                    query = "@scope",
                    query_group = "locals",
                    desc = "Select language scope",
                  },
                },
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                  ["@parameter.outer"] = "v", -- charwise
                  ["@function.outer"] = "V",  -- linewise
                  ["@class.outer"] = "<c-v>", -- blockwise
                },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * selection_mode: eg 'v'
                -- and should return true of false
                include_surrounding_whitespace = true,
              },
            },
          })
        end,
      },

      {
        "nvim-treesitter/nvim-treesitter-refactor",
        cond = false,
        config = function()
          require("nvim-treesitter.configs").setup({
            refactor = {
              highlight_definitions = {
                enable = true,
                -- Set to false if you have an `updatetime` of ~100.
                clear_on_cursor_move = true,
              },
              highlight_current_scope = { enable = false },
              navigation = {
                enable = true,
                -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
                keymaps = {
                  goto_definition = false,
                  list_definitions = false,
                  list_definitions_toc = false,
                  goto_next_usage = "]s",
                  goto_previous_usage = "[s",
                },
              },
            },
          })
        end,
      },
    },
  },
}
