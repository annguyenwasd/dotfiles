return {
  {
    "andrewferrier/debugprint.nvim",
    opts = function()
      local js = {
        left = 'console.log("',
        right = '")',
        mid_var = '", ',
        right_var = ")",
        find_treesitter_variable = function(node)
          if node:type() == "property_identifier" and node:parent() ~= nil then
            local parent = node:parent()
            return vim.treesitter.get_node_text(parent, 0)
          elseif node:type() == "identifier" then
            return vim.treesitter.get_node_text(node, 0)
          else
            return nil
          end
        end,
      }

      return {
        print_tag = "AN.NGUYEN",
        filetypes = {
          ["javascript"] = js,
          ["javascriptreact"] = js,
          ["typescript"] = js,
          ["typescriptreact"] = js,
        },
      }
    end,
    keys = {
      "g?p",
      "g?P",
      "g?o",
      "g?O",
      "g?v",
      "g?V",
      {
        "g?d",
        ":lua require('debugprint').deleteprints()<cr>",
        desc = desc("debugprint: remove all debug lines in current file"),
      },
    },
  },
}
