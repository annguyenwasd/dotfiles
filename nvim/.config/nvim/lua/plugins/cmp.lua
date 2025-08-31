return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        experimental = {
          ghost_text = false,
        },
        snippet = {
          expand = function(args)
            require("snippy").expand_snippet(args.body)
          end,
        },
        mapping = {
          ["<tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ["<c-n>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ["<c-p>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
          ["<c-d>"] = cmp.mapping.scroll_docs(-4),
          ["<c-f>"] = cmp.mapping.scroll_docs(4),
          ["<c-y>"] = cmp.mapping.complete(),
          ["<cr>"] = cmp.mapping.confirm({ select = false }),
          ["<c-a>"] = cmp.mapping.abort(),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "snippy" },
          { name = "nvim_lua" },
          {
            name = "lazydev",
            group_index = 0,
          },
        }, {
          {
            name = "buffer",
            option = {
              keyword_length = 2,
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
        }),
      })
    end,
  },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-nvim-lua" },
  { "dcampos/nvim-snippy" },
  { "honza/vim-snippets" },
  {
    "dcampos/cmp-snippy",
    config = function()
      require("snippy").setup({
        mappings = {
          is = {
            ["<c-j>"] = "expand",
            ["<c-l>"] = "next",
            ["<c-h>"] = "previous",
          },
          nx = {
            ["<leader>x"] = "cut_text",
          },
        },
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
