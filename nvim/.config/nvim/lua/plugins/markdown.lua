return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown" },
    keys = {
      {
        "<leader>mh",
        function() require("render-markdown").buf_toggle() end,
        desc = desc("markdown: Toggle render-markdown highlighting"),
      },
    },
    opts = {
      heading = {
        icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
        signs = { "§ " },
      },
      checkbox = {
        unchecked = { icon = "☐ " },
        checked   = { icon = "☑ " },
        custom    = {
          todo = { raw = "[-]", rendered = "◐ ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
        },
      },
      link = {
        footnote  = { icon = "^ " },
        image     = "[img] ",
        email     = "@ ",
        hyperlink = "-> ",
        wiki      = { icon = "§ " },
        custom    = {
          web = { pattern = "^http", icon = "-> " },
        },
      },
      callout = {
        note      = { raw = "[!NOTE]",      rendered = "i Note",      highlight = "RenderMarkdownInfo",    category = "github" },
        tip       = { raw = "[!TIP]",       rendered = "* Tip",       highlight = "RenderMarkdownSuccess", category = "github" },
        important = { raw = "[!IMPORTANT]", rendered = "! Important", highlight = "RenderMarkdownHint",    category = "github" },
        warning   = { raw = "[!WARNING]",   rendered = "~ Warning",   highlight = "RenderMarkdownWarn",    category = "github" },
        caution   = { raw = "[!CAUTION]",   rendered = "x Caution",   highlight = "RenderMarkdownError",   category = "github" },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    keys = {
      { "<leader>md", "<cmd>MarkdownPreview<cr>", desc = desc("Markdown Preview (using plugin)") },
    },
  },
}
