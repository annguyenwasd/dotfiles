return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      local actions = require("telescope.actions")
      local actions_layout = require("telescope.actions.layout")
      local themes = require("telescope.themes")

      -- You dont need to set any of these options. These are the default ones. Only
      -- the loading is important
      require("telescope").setup({
        defaults = themes.get_ivy({
          find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
          debounce = 150,
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--hidden",
            "--smart-case",
            "--trim", -- add this value
          },
          file_ignore_patterns = {
            "%.git/",
            ".vscode/",
            ".idea",
            "coverage/",
            "build/",
            "reports/",
            "dist/",
          },
          preview = {
            hide_on_startup = true,
          },
          mappings = {
            i = {
              ["<c-e>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<c-s>"] = actions.select_horizontal,
              ["<c-\\>"] = actions_layout.toggle_preview,
            },
            n = {
              ["<c-e>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<c-s>"] = actions.select_horizontal,
              ["<c-d>"] = actions.delete_buffer,
              ["<c-\\>"] = actions_layout.toggle_preview,
            },
          },
        }),
      })
    end,
    keys = {
      {
        "<leader>o",
        "<cmd>lua require('utils.nvim-tree').find_files()<cr>",
        desc = desc("telescope: find files"),
      },
      {
        "<leader>O",
        function()
          require("telescope.builtin").find_files({ no_ignore = true, no_ignore_parent = true, hidden = true })
        end,
        desc = desc("telescope: find files with ignored files"),
      },
      {
        "<leader>i",
        function()
          require("telescope.builtin").buffers({
            sort_rmu = true,
            sort_lastused = true,
            show_all_buffers = true,
          })
        end,
        desc = desc("telescope: show opened buffers"),
      },
      {
        "<leader>/",
        "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
        desc = desc("telescope: current buffer fuzzy find"),
      },
      {
        "<leader>fc",
        "<cmd>lua require('utils.theme-chooser').choose()<cr>",
        desc = desc("telescope: theme chooser"),
      },
      -- { "<leader>rg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc=desc("telescope: live grep default")},
      {
        "<leader>fh",
        "<cmd>lua require('telescope.builtin').help_tags()<cr>",
        desc = desc("telescope: help tags"),
      },
      {
        "<leader>ch",
        "<cmd>lua require('telescope.builtin').command_history()<cr>",
        desc = desc("telescope: command history"),
      },
      {
        "<leader>sh",
        "<cmd>lua require('telescope.builtin').search_history()<cr>",
        desc = desc("telescope: search history"),
      },
      {
        "<leader><leader>fc",
        "<cmd>lua require('telescope.builtin').commands()<cr>",
        desc = desc("telescope: commands"),
      },
      { "<leader>km", "<cmd>lua require('telescope.builtin').keymaps()<cr>", desc = desc("telescope: keymaps") },
      {
        "<leader>tr",
        function()
          require("telescope.builtin").resume({ initial_mode = "normal" })
        end,
        desc = desc("telescope: resume"),
      },
      {
        "<leader>ds",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = desc("telescope: lsp document symbols"),
      },
      {
        "<leader>ws",
        ":Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = desc("telescope: lsp dynamic workspace symbols"),
        silent = false,
      },
      {
        "<leader>qf",
        ":Telescope quickfix<cr>",
        desc = desc("telescope: from quickfix list"),
        silent = false,
      },
      {
        "<leader>qh",
        ":Telescope quickfixhistory<cr>",
        desc = desc("telescope: list quickfix history"),
        silent = false,
      },
      {
        "<leader>RG",
        ":Telescope grep_string<cr>",
        desc = desc("telescope: grep current word"),
        silent = false,
      },
      {
        "<leader>ss",
        ":Telescope spell_suggest<cr>",
        desc = desc("telescope: suggets spell correction under cursor"),
      },
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "fdschmidt93/telescope-egrepify.nvim",
    config = function()
      local egrep_actions = require("telescope._extensions.egrepify.actions")
      require("telescope").setup({
        extensions = {
          egrepify = {
            -- intersect tokens in prompt ala "str1.*str2" that ONLY matches
            -- if str1 and str2 are consecutively in line with anything in between (wildcard)
            AND = true, -- default
            permutations = true, -- opt-in to imply AND & match all permutations of prompt tokens
            lnum = true, -- default, not required
            lnum_hl = "EgrepifyLnum", -- default, not required, links to `Constant`
            col = false, -- default, not required
            col_hl = "EgrepifyCol", -- default, not required, links to `Constant`
            title = true, -- default, not required, show filename as title rather than inline
            filename_hl = "EgrepifyFile", -- default, not required, links to `Title`
            results_ts_hl = false, -- set to true if you want results ts highlighting, may increase latency!
            -- suffix = long line, see screenshot
            -- EXAMPLE ON HOW TO ADD PREFIX!
            prefixes = {
              -- ADDED ! to invert matches
              -- example prompt: ! sorter
              -- matches all lines that do not comprise sorter
              -- rg --invert-match -- sorter
              ["!"] = {
                flag = "glob",
                cb = function(input)
                  return string.format([[!*{%s}*]], input)
                end,
              },
              -- HOW TO OPT OUT OF PREFIX
              -- ^ is not a default prefix and safe example
              ["^"] = false,
            },
            -- default mappings
            mappings = {
              i = {
                -- toggle prefixes, prefixes is default
                ["<C-z>"] = egrep_actions.toggle_prefixes,
                -- toggle AND, AND is default, AND matches tokens and any chars in between
                ["<C-x>"] = egrep_actions.toggle_and,
                -- toggle permutations, permutations of tokens is opt-in
                ["<C-r>"] = egrep_actions.toggle_permutations,
              },
            },
          },
        },
      })
      require("telescope").load_extension("egrepify")
    end,
    keys = {
      {
        "<leader>rg",
        function()
          require("telescope").extensions.egrepify.egrepify({})
        end,
        desc = desc("telescope: live grep using egrepify"),
      },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    cond = function()
      return not is_work_profile()
    end,
    build = "cmake -S. -Bbuild -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}
