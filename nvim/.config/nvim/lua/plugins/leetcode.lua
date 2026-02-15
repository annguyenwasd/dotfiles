-- image.nvim requires system deps: luarocks, imagemagick, ueberzugpp
-- Install them to enable image rendering in leetcode problems:
--   sudo pacman -S luarocks imagemagick
--   yay -S ueberzugpp
-- Then set image.nvim enabled = true below
local leet_arg = "lc"
return {
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    lazy = false,
    cond = leet_arg == vim.fn.argv()[1],
    opts = { arg = leet_arg, lang = "javascript", image_support = not is_work_profile() },
    keys = {
      { "<leader>ll", "<cmd>Leet list<cr>", desc = desc("leetcode: list leetcode problems") },
      { "<leader>lh", "<cmd>Leet hints<cr>", desc = desc("leetcode: Show some hints") },
      { "<leader>lx", "<cmd>Leet exit<cr>", desc = desc("leetcode: exit") },
      {
        "<leader>li",
        "<cmd>Leet info<cr>",
        desc = desc("leetcode: opens a pop-up containing information about the currently opened question"),
      },
      { "<leader>lb", "<cmd>Leet tabs<cr>", desc = desc("leetcode: browse opening tabs") },
      { "<leader>lt", "<cmd>Leet test<cr>", desc = desc("leetcode: run test by leetcode's judges") },
      {
        "<leader>lT",
        function()
          vim.cmd("w")
          vim.cmd("Dispatch node %")
        end,
        desc = desc("leetcode: run test local with nodejs, need to call the function inside the file with arguments"),
      },
      { "<leader>lc", "<cmd>Leet console<cr>", desc = desc("leetcode: console") },
      { "<leader>lo", "<cmd>Leet open<cr>", desc = desc("leetcode: open in browser") },
      { "<leader>ly", "<cmd>Leet yank<cr>", desc = desc("leetcode: yank the solution") },
      { "<leader>le", "<cmd>Leet desc<cr>", desc = desc("leetcode: toggle the description") },
      { "<leader>ls", "<cmd>Leet submit<cr>", desc = desc("leetcode: submit") },
    },
  },
  { "MunifTanjim/nui.nvim" },
  {
    "vhyrro/luarocks.nvim",
    cond = vim.fn.executable("luarocks") == 1,
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    config = function()
      local ok, image = pcall(require, "image")
      if not ok then return end
      local setup_ok = pcall(image.setup, {
        backend = "ueberzug",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
      })
      if not setup_ok then
        vim.notify("image.nvim: failed to setup (ueberzug issue?)", vim.log.levels.WARN)
      end
    end,
  },
}
