local find_buffer_by_name = function(name)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local buf_name = vim.api.nvim_buf_get_name(buf)
		local n = string.sub(buf_name, #buf_name - #name + 1)
		if n == name then
			return buf
		end
	end
	return -1
end

local function starts_with(str, starts)
	return string.sub(str, 1, #starts) == starts
end

local ts_buf_name = "ts_file.ts"
vim.cmd("e " .. ts_buf_name)
vim.cmd("b#")

local ts_buffer_number = find_buffer_by_name(ts_buf_name)

local keys_tb = vim.api.nvim_get_keymap("n")
local ts_keys = vim.api.nvim_buf_get_keymap(ts_buffer_number, "n")

for _, t in ipairs(ts_keys) do
	local found = false

	for __, k in ipairs(keys_tb) do
		found = k.lhs == t.lhs
	end

	if not found then
		table.insert(keys_tb, t)
	end
end

table.sort(keys_tb, function(a, b)
	return (a.desc or "N/A") > (b.desc or "N/A")
end)

--[[ {
    buffer = 0,
    desc = "[annguyenwasd] nvim-tree: toggle",
    expr = 0,
    lhs = "  n",
    lhsraw = "  n",
    lnum = 0,
    mode = "n",
    noremap = 1,
    nowait = 0,
    rhs = "<Cmd>NvimTreeToggle<CR>",
    script = 0,
    sid = -8,
    silent = 0
  } ]]
local o = [[
# Key bindings

Which starts with `[annguyenwasd]` are customised, else are from plugins

This list is not includes all keys, but worth to lookup :)

`<leader>`: `" "`


`<localleader>`: `\`

]]

local header = "|lhs|desc|\n|---|---|\n"
o = o .. header

for i, v in ipairs(keys_tb) do
	if not starts_with(v.lhs, "<Plug>") and v.desc ~= nil then
		local lhs = string.gsub(v.lhs, " ", "<leader>")
		lhs = string.gsub(lhs, "\\", "<localleader>")
		-- lhs
		if starts_with(lhs, "`") then
			o = o .. "|<kbd>" .. lhs .. "</kdb>|"
		else
			o = o .. "|`" .. lhs .. "`|"
		end
		-- desc
		if v.desc ~= nil then
			o = o .. "" .. v.desc .. "|"
		else
			o = o .. "" .. "N/A" .. "|"
		end

		-- rhs
		-- if v.rhs ~= nil then
		-- 	o = o .. "`" .. v.rhs .. "`|"
		-- else
		-- 	o = o .. "`" .. "N/A" .. "`|"
		-- end

		o = o .. "\n"
	end
end
local f = io.open("keys.md", "w")
f.write(f, o)
f.close()
