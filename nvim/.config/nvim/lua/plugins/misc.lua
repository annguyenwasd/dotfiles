return {
  { "LudoPinelli/comment-box.nvim", event = "VeryLazy" },
  { "jghauser/mkdir.nvim" },
  { "godlygeek/tabular", cmd = "Tabularize" },
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>mm", ":MaximizerToggle<cr>", desc = desc("utils: toggle maximizer") },
    },
  },
  {
    "airblade/vim-rooter",
    cmd = "Rooter",
    init = function()
      vim.g.rooter_patterns = { ".git" }
      vim.g.rooter_manual_only = 1
    end,
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", ":UndotreeShow<cr>", desc = desc("utils: toggle Undotree") },
    },
  },
  {
    "will133/vim-dirdiff",
    cmd = "DirDiff",
    init = function()
      vim.g.DirDiffExcludes =
        ".git,personal.*,.DS_Store,**/packer_compiled.lua,**/*.add,**/*.spl,*.png,*.jpg,*.jpeg,Session.vim,*/state.yml,plugin/*,spell/*,node_modules/*,*node_modules*"
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
    keys = {
      { "<leader>tc", "<cmd>ColorizerToggle<cr>", desc = desc("Toggle color") },
    },
  },
  {
    "Wansmer/treesj",
    config = function()
      require("treesj").setup({ use_default_keymaps = false, max_join_length = 99999999 })
    end,
    keys = {
      {
        "gst",
        function()
          require("treesj").toggle()
        end,
        desc = desc("treejs: toggle join/split"),
      },
      {
        "gss",
        function()
          require("treesj").split()
        end,
        desc = desc("treejs: split lines"),
      },
      {
        "gsj",
        function()
          require("treesj").join()
        end,
        desc = desc("treejs: join lines"),
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cond = os.getenv("TMUX"),
    init = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },
  {
    "sontungexpt/url-open",
    cmd = "URLOpenUnderCursor",
    config = function()
      local status_ok, url_open = pcall(require, "url-open")
      if not status_ok then
        return
      end
      url_open.setup({})
    end,
    keys = {
      {
        "<leader>gh",
        "<cmd>URLOpenUnderCursor<cr>",
        desc = desc("Open url/githut repo under cursor"),
      },
    },
  },
  {
    "zdcthomas/yop.nvim",
    event = "VeryLazy",
    config = function()
      require("yop").op_map({ "n", "v" }, "<leader>Rg", function(lines)
        require("telescope.builtin").grep_string({ search = lines[1] })
      end, { desc = desc("Telescope: Grep string with motion") })

      require("yop").op_map({ "n", "v" }, "<leader>ho", function(lines)
        vim.cmd("Dispatch! npm home " .. lines[1])
      end, { desc = desc("misc: Open npm home/home npm") })
    end,
  },
  {
    "cappyzawa/trim.nvim",
    cmd = { "Trim", "TrimToggle" },
    event = "BufWritePre",
    opts = { trim_on_write = true },
  },
}
