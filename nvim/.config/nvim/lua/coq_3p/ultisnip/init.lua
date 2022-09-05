-- Very simple case
-- Offers suggestions of `vim.lsp.protocol.CompletionItemKind`

return function(spec)
  return function(args, callback)
    local items = {}
    
    -- label      :: display label
    -- insertText :: string | null, default to `label` if null
    -- kind       :: int ∈ `vim.lsp.protocol.CompletionItemKind`
    -- detail     :: doc popup

    for key, val in pairs(vim.fn['UltiSnips#SnippetsInCurrentScope']()) do
      local item = {
        label = tostring(key),
        insertText = key,
        detail = tostring(val)
      }
      table.insert(items, item)
    end

    callback {
      items = items
    }
  end
end
