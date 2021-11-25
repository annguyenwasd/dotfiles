local utils = {}
local api = vim.api

utils.map = function(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true, expr = false}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- The function is called `t` for `termcodes`.
-- You don't have to call it that, but I find the terseness convenient
utils.t = function(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- https://github.com/norcalli/nvim_utils/blob/master/lua/nvim_utils.lua#L554-L567
function utils.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command("augroup " .. group_name)
        api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
            api.nvim_command(command)
        end
        api.nvim_command("augroup END")
    end
end

utils.set_theme = function(theme_name, lualine_theme)
    print(theme_name)
    vim.cmd("colorscheme " .. theme_name)
    require("lualine").setup({options = {theme = lualine_theme or theme_name}})
end

return utils
