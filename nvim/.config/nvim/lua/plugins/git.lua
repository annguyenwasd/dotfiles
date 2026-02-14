return {
  {
    "tpope/vim-fugitive",
    lazy = false,
    init = function()
      -- Not going to show shit messages when run git hook via husky
      vim.g.fugitive_pty = 0
    end,
    keys = {
      {
        "<leader>gf",
        "<cmd>diffget //2 <cr> <cmd>w <cr> <cmd>diffupdate <cr>",
        desc = desc("git: select left"),
      },
      {
        "<leader>gj",
        "<cmd>diffget //3 <cr> <cmd>w <cr> <cmd>diffupdate <cr>",
        desc = desc("git: select right"),
      },
      { "<leader>gl", ":Git log --decorate=full<cr>", mode = { "n" },      desc = desc("git: fugitive: show log") },
      { "<leader>gl", ":Gclog!<cr>",                  mode = { "v" },      desc = desc("git: fugitive: show log") },
      { "<leader>gL", ":0GcLog<cr>",                  mode = { "n", "v" }, desc = desc("git: fugitive: show log") },
      {
        "<leader>ge",
        "<cmd>Gedit<cr>",
        desc = desc("git: Gedit"),
      },
      {
        "<leader>gs",
        "<cmd>G<cr>",
        desc = desc("git: open git fugitive status"),
      },
      {
        "<leader><leader>gs",
        "<cmd>G difftool<cr>",
        desc = desc("git: show all changes by line in quickfix list"),
      },
      { "<leader><leader>bl", "<cmd>G blame<cr>",  desc = desc("git: show all lines blame") },
      {
        "<leader>gc",
        function()
          vim.cmd("split term://git commit|:startinsert")
        end,
        desc = desc("git: commit by built-in terminal"),
      },
      {
        "<leader><leader>gc",
        ':G commit -m ""<left>',
        silent = false,
        desc = desc("git: commit with custom message"),
      },
      { "<leader>ga",         "<cmd>G add -A<cr>", desc = desc("git: quick add all files to stageing area") },
      {
        "<leader>gw",
        '<cmd>G add -A <bar>G commit -n -m "WIP"<cr>',
        desc = desc("git: add new WIP commit"),
      },
      {
        "<leader>GW",
        function()
          vim.cmd("G add -A")
          vim.cmd('G commit -n -m "WIP"')
          vim.cmd("<cmd>Dispatch! git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease")
        end,
        silent = false,
        desc = desc("git: add all -> create WIP commit -> push to origin"),
      },
      {
        "<leader>gpp",
        "<cmd>Dispatch! git push -u origin $(git rev-parse --abbrev-ref HEAD)<cr>",
        silent = false,
        desc = desc("git: push to origin"),
      },
      {
        "<leader>gpf",
        "<cmd>Dispatch! git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease<cr>",
        silent = false,
        desc = desc("git: push to origin"),
      },
      {
        "gpt",
        "<cmd>Dispatch! git push -u origin $(git rev-parse --abbrev-ref HEAD) --follow-tags<cr>",
        silent = false,
        desc = desc("git: push to origin with tags"),
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({
        sign_priority = 100,
        auto_attach = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          -- Navigation
          vim.keymap.set("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { buffer = bufnr, expr = true, desc = desc("git: next change") })

          vim.keymap.set("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { buffer = bufnr, expr = true, desc = desc("git: prev change") })

          -- Actions
          vim.keymap.set(
            { "n", "v" },
            "<leader>ha",
            ":Gitsigns stage_hunk<CR>",
            { buffer = bufnr, desc = desc("git: add hunk to staging area") }
          )

          vim.keymap.set(
            { "n", "v" },
            "<leader>hd",
            ":Gitsigns reset_hunk<CR>",
            { buffer = bufnr, desc = desc("git: remove hunk from strging area") }
          )

          vim.keymap.set(
            "n",
            "<leader>hA",
            gs.stage_buffer,
            { buffer = bufnr, desc = desc("git: add whole file to staging area") }
          )

          vim.keymap.set(
            "n",
            "<leader>hu",
            gs.undo_stage_hunk,
            { buffer = bufnr, desc = desc("git: remove whole file from staging area") }
          )

          vim.keymap.set(
            "n",
            "<leader>hD",
            gs.reset_buffer,
            { buffer = bufnr, desc = desc("git: reset file to index") }
          )
          vim.keymap.set(
            "n",
            "<leader>hc",
            gs.preview_hunk,
            { buffer = bufnr, desc = desc("git: preview hunk") }
          )

          vim.keymap.set("n", "<leader>bl", function()
            gs.blame_line({ full = true })
          end, { buffer = bufnr, desc = desc("git: show gitsign blame") })

          vim.keymap.set(
            "n",
            "<leader>tb",
            gs.toggle_current_line_blame,
            { buffer = bufnr, desc = desc("git: toggle line blame") }
          )
          vim.keymap.set(
            "n",
            "<leader>td",
            gs.toggle_deleted,
            { buffer = bufnr, desc = desc("git: toggle deleted") }
          )

          vim.keymap.set(
            { "o", "x" },
            "ih",
            ":<C-U>Gitsigns select_hunk<CR>",
            { buffer = bufnr, desc = desc("git: textobject select hunk") }
          )
        end,
      })
    end,
  },
  {
    "tpope/vim-rhubarb",
    keys = {
      {
        "<leader>gy",
        mode = { "n", "v" },
        ":GBrowse<cr>",
        desc = desc("git: Open file in browser (mode: n,v)"),
      },
    }
  },
}
