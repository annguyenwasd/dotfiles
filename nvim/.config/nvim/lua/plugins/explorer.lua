return {
  { "tpope/vim-vinegar" },
  {
    "kyazdani42/nvim-tree.lua",
    init = function()
      vim.gnvim_tree_respect_buf_cwd = 1 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true
    end,
    keys = {
      { "<leader>n", "<cmd>NvimTreeToggle<cr>", desc = desc("nvim-tree: toggle") },
    },
    config = function()
      local function on_attach(bufnr)
        local api = require("nvim-tree.api")

        api.config.mappings.default_on_attach(bufnr)

        local utils = require("utils.nvim-tree")

        vim.keymap.set(
          "n",
          "l",
          api.node.open.edit,
          { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = desc("nvim-tree: Open") }
        )

        vim.keymap.set("n", "<c-y>", function()
          local node = api.tree.get_node_under_cursor()
          local is_folder = node.fs_stat and node.fs_stat.type == "directory" or false
          local basedir = is_folder and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
          require("utils.yazi").open_yazi(basedir)
        end, {
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
          desc = desc("nvim-tree: Open current dir in yazi"),
        })

        vim.keymap.set("n", "h", api.node.navigate.parent_close, {
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
          desc = desc("nvim-tree: Close Directory"),
        })
        vim.keymap.set("n", "h", api.node.navigate.parent_close, {
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
          desc = desc("nvim-tree: Close Directory"),
        })
        vim.keymap.set(
          "n",
          "H",
          api.tree.collapse_all,
          { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = desc("nvim-tree: Collapse") }
        )
        vim.keymap.set("n", "<c-f>", utils.launch_find_files, {
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
          desc = desc("nvim-tree: Launch Find Files"),
        })
        vim.keymap.set("n", "<c-g>", utils.launch_live_grep, {
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
          desc = desc("nvim-tree: Launch Live Grep"),
        })
        vim.keymap.set(
          "n",
          "<esc>",
          api.tree.close,
          { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = desc("nvim-tree: Close") }
        )
      end

      local HEIGHT_RATIO = 0.8 -- You can change this
      local WIDTH_RATIO = 0.5 -- You can change this too

      require("nvim-tree").setup({
        on_attach = on_attach,
        hijack_netrw = false,
        disable_netrw = false,
        live_filter = {
          prefix = "[FILTER]: ",
          always_show_folders = false,
        },
        git = { enable = false },
        actions = { open_file = { quit_on_open = true } },
        renderer = {
          indent_markers = {
            enable = true,
            icons = {
              edge = "|",
              item = "|",
              bottom = "-",
              none = " ",
              corner = "L",
            },
          },
          icons = {
            glyphs = {
              default = "",
              bookmark = "m",
              symlink = "->",
              modified = "~",
              folder = {
                arrow_closed = ">",
                arrow_open = "v",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "->",
                symlink_open = "->",
              },
              git = {
                unstaged = "",
                staged = "",
                unmerged = "",
                renamed = "",
                untracked = "",
                deleted = "",
                ignored = "",
              },
            },
          },
        },
        update_focused_file = { enable = true },
        view = {
          side = "right",
          width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
          end,
          float = {
            enable = false,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * WIDTH_RATIO
              local window_h = screen_h * HEIGHT_RATIO
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
              return {
                border = "rounded",
                relative = "editor",
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end,
          },
        },
        filesystem_watchers = {
          ignore_dirs = { "node_modules", ".git" },
        },
      })

      -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#automatically-open-file-upon-creation
      local api = require("nvim-tree.api")
      api.events.subscribe(api.events.Event.FileCreated, function(file)
        vim.cmd("edit " .. file.fname)
      end)
    end,
  },
}
