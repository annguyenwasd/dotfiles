vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
--  ──────────────── More convenient with search key binds ────────────────
vim.keymap.set("n", "n", "nzt", { desc = desc("mappings: Override. next occurrence and make cursor top"), noremap = false })
vim.keymap.set("n", "N", "Nzt", { desc = desc("mappings: Override. prev occurrence and make cursor top"), noremap = false })
vim.keymap.set("n", "*", "*zt", { desc = desc("mappings: Override. next whole world occurrence and make cursor top"), noremap = false })
vim.keymap.set("n", "#", "#zt", { desc = desc("mappings: Override. prev whole world occurrence and make cursor top"), noremap = false })
vim.keymap.set("v", "*", 'y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>', { desc = desc("mappings: Do search with selected text in VISUAL mode "), noremap = false })
vim.keymap.set("n", "<leader>cl", "<cmd>ccl<cr><cmd>lcl<cr><cmd>echo ''<cr><cmd>noh<cr><cmd>pclose<cr><cmd>lua vim.lsp.buf.clear_references()<cr>", { desc = desc("mappings: Closing quickfix windows/location list windows") })

--  ─────────────────── More convenient with copy paste ───────────────────
vim.keymap.set("v", "<leader>p", '"_dP', { desc = desc("mappings: Paste without replace current value by replaced value") })
vim.keymap.set("v", "D", "y'>p", { desc = desc("mappings: Duplicate everything selected") })
vim.keymap.set("n", "<c-w><c-e>", "<c-w>=", { desc = desc("mappings: Make windows equally") })

--  ──────────────────── Moving around in COMMAND MODE ────────────────────
vim.keymap.set({ "c", "i" }, "<c-h>", "<left>", { desc = desc("mappings: go to left window. mode: c/i"), silent = false })
vim.keymap.set({ "c", "i" }, "<c-j>", "<down>", { desc = desc("mappings: go to bottom window. mode: c/i"), silent = false })
vim.keymap.set({ "c", "i" }, "<c-k>", "<up>", { desc = desc("mappings: go to top window. mode: c/i"), silent = false })
vim.keymap.set({ "c", "i" }, "<c-l>", "<right>", { desc = desc("mappings: go to right window. mode: c/i"), silent = false })

--  ───── NEW split/vertical split at same directory of current file ──
vim.keymap.set("n", "<leader>fv", ":vsp %:h/", { desc = desc("mappings: Create a new file in same folder in vertical split"), silent = false })
vim.keymap.set("n", "<leader>fs", ":sp %:h/", { desc = desc("mappings: Create a new file in same folder in horizontal split"), silent = false })
vim.keymap.set("n", "<leader>fe", ":e %:h/", { desc = desc("mappings: Edit a file in current folder in same window"), silent = false })

--  ───────────────────────── JUST SPLIT windows ──────────────────────
vim.keymap.set("n", "<c-w>v", "<c-w>v <c-w>l", { desc = desc("mappings: Create a vertical split and move to new one"), noremap = true })
vim.keymap.set("n", "<c-w><c-v>", "<c-w>v <c-w>l", { desc = desc("mappings: Create a vertical split and move to new one"), noremap = true })
vim.keymap.set("n", "<c-w>s", "<c-w>s <c-w>j", { desc = desc("mappings: Create a horizontal split and move to new one"), noremap = true })
vim.keymap.set("n", "<c-w><c-s>", "<c-w>s <c-w>j", { desc = desc("mappings: Create a horizontal split and move to new one"), noremap = true })
vim.keymap.set("n", "<c-w><c-w>", "<c-w>q", { desc = desc("mappings: Close current window/split"), noremap = true })
--  ──────────────────────────────── TMUX ─────────────────────────────
vim.keymap.set("n", "<leader>tm", ":!tmux neww ", { desc = desc("mappings: Run a command in a new tmux window"), silent = false })
vim.keymap.set("n", "<leader>tM", ":!tmux splitw ", { desc = desc("mappings: Run a command in a new tmux pane"), silent = false })

--  ────────────────────────────── Terminal ───────────────────────────
vim.keymap.set(
  "n",
  "<leader>vt",
  ":vsplit term://",
  { desc = desc("mappings: Open terminal with vertial split"), noremap = true }
)
vim.keymap.set(
  "n",
  "<leader>st",
  ":split term://",
  { desc = desc("mappings: Open terminal with horizontal split"), noremap = true }
)

vim.keymap.set(
  "n",
  "<leader>vT",
  ":vsplit term://$SHELL<cr>",
  { desc = desc("mappings: Open terminal with vertial split with default shell"), noremap = true }
)

vim.keymap.set(
  "n",
  "<leader>sT",
  ":split term://$SHELL<cr>",
  { desc = desc("mappings: Open terminal with horizontal split with default shell"), noremap = true }
)

--  ────────────────────────── Working with repo ──────────────────────────
vim.keymap.set("n", "<leader>bd", function()
  local package = vim.fn.findfile("package.json", ".;")
  if package ~= "package.json" then
    local file = io.open(package, "rb")

    if file == nil then
      print("no package.json found")
      return
    end

    local jsonString = file:read("*a")
    file:close()
    print(jsonString)

    local t = vim.json.decode(jsonString)
    local packageName = t["name"]
    vim.notify("Building " .. packageName)

    vim.cmd("Dispatch! yarn workspace " .. packageName .. " build")
  end
end, { desc = desc("mappings: Find nearest upper package.json file and build that package") })

vim.keymap.set("n", "<leader>bp", function()
  local package = vim.fn.findfile("package.json", ".;")
  if package ~= "package.json" then
    vim.cmd.edit(package)
  end
end, { desc = desc("mappings: Open nearest package.json file") })

vim.keymap.set("n", "<leader>sr", function()
  require("utils.script-runner").run_script_picker()
end, { desc = desc("mappings: Run script from nearest package.json") })

--  ─────────── copy current file path (relatively/absolutely) ────────
local copy_path = require("utils.copy_path").copy_path

vim.keymap.set("n", "<leader>cp", function()
  copy_path(true)
end, { desc = "Copy relative path" })
vim.keymap.set("n", "<leader>cP", function()
  copy_path(false)
end, { desc = "Copy absolute path" })
-- Synced from .vimrc:449 — Copy detailed path (absolute + function name or line number)
vim.keymap.set("n", "<leader>CP", function()
  copy_path("detailed")
end, { desc = "Copy detailed path (with function name)" })


--  ──────────────────────────────── MISC ─────────────────────────────
vim.keymap.set("n", "<leader>yz", function()
  require("utils.yazi").open_yazi(vim.fn.expand("%:h"))
end, { desc = desc("yazi: open yazi for current directory"), noremap = true })
vim.keymap.set("c", "%%", function()
  if vim.fn.getcmdtype() == ":" then
    return vim.fn.expand("%:h") .. "/"
  else
    return "%%"
  end
end, { expr = true, desc = desc("mappings: Current file's directory path") })

vim.keymap.set("n", "<leader>e", "<cmd>b #<cr>", { desc = desc("mappings: Swap current buffer with alternative buffer") })
vim.keymap.set("n", "<leader>fl", ":set foldlevel=", { desc = desc("mappings: set custom fold level"), silent = false })
vim.keymap.set("n", "<leader>vm", ":vert res 120<cr>", { desc = desc("mappings: Set current window width 120 length"), noremap = true })

--  ──────────── Synced from .vimrc (Vim→Lua conversions) ─────────────

-- Synced from .vimrc:47 — Terminal mode: press Esc twice to exit to normal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = desc("mappings: Exit terminal mode to normal mode") })

-- Synced from .vimrc:464 — Insert console.log for word under cursor
vim.keymap.set("n", "<leader>ll", function()
  local word = vim.fn.expand("<cword>")
  local file_path = vim.fn.expand("%")
  local line_num = vim.fn.line(".")
  local ext = vim.fn.expand("%:e")
  if vim.tbl_contains({ "js", "ts", "jsx", "tsx" }, ext) then
    local log_line = string.format('console.log("[XXXDEBUG:%d] at %s, %s:", %s);', line_num, file_path, word, word)
    vim.fn.append(vim.fn.line("."), log_line)
    vim.cmd("normal! j")
  end
end, { desc = desc("mappings: Insert console.log debug line") })

-- Synced from .vimrc:465 — Delete all XXXDEBUG console.log lines
vim.keymap.set("n", "<leader>LL", "<cmd>g/xxxDEBUG/ d<cr>", { desc = desc("mappings: Remove all XXXDEBUG lines") })

-- Synced from .vimrc:652 — ZenMode: minimal statusline + single window + side margin
vim.keymap.set("n", "<leader>zz", function()
  vim.o.statusline = "%<%t %h%m%r"
  vim.cmd("only")
  local cols = vim.v.count > 0 and vim.v.count or 70
  vim.cmd("topleft " .. cols .. "vnew")
  vim.cmd("wincmd l")
end, { desc = desc("mappings: Toggle zen mode") })

-- Synced from .vimrc:668 — Open markdown file in browser
vim.keymap.set("n", "<leader>md", function()
  if vim.bo.filetype ~= "markdown" then
    print("Not a markdown file")
    return
  end
  if vim.fn.executable("mdbrowse") == 1 then
    vim.fn.jobstart("mdbrowse " .. vim.fn.expand("%"), { detach = true })
  else
    print("mdbrowse not found. Install with: npm install md-browse -g")
  end
end, { desc = desc("mappings: Open markdown in browser") })

-- Synced from .vimrc:78 — Agent commit via Dispatch (reads $VIM_AGENT_COMMIT_COMMAND)
vim.keymap.set("n", "<leader>Gc", function()
  local cmd = vim.env.VIM_AGENT_COMMIT_COMMAND
  if not cmd or cmd == "" then
    print("VIM_AGENT_COMMIT_COMMAND not set. Source agent.zsh first.")
    return
  end
  vim.cmd('Dispatch! ' .. cmd .. ' "Create a commit for all changed files"')
end, { desc = desc("mappings: Agent commit via Dispatch") })

-- Synced from .vimrc:685 — Open or switch to agent interactive terminal
vim.keymap.set("n", "<leader>cc", function()
  local agent_cmd = vim.env.VIM_AGENT_INTERACTIVE_COMMAND
  if not agent_cmd or agent_cmd == "" then
    print("VIM_AGENT_INTERACTIVE_COMMAND not set. Source agent.zsh first.")
    return
  end

  -- Close finished terminal buffers first
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      local chan = vim.b[buf].terminal_job_id
      if chan and vim.fn.jobwait({ chan }, 0)[1] ~= -1 then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end

  -- Look for existing agent terminal
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      local name = vim.api.nvim_buf_get_name(buf)
      if name:find(agent_cmd, 1, true) then
        vim.cmd("buffer " .. buf)
        return
      end
    end
  end

  -- No existing agent terminal, create new one
  local cmd = agent_cmd:gsub("^!", "")
  vim.cmd("vsplit term://" .. cmd)
end, { desc = desc("mappings: Open or switch to agent terminal") })

-- Synced from .vimrc:714 — Close all finished terminal buffers
vim.keymap.set("n", "<leader>bf", function()
  local closed = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      local chan = vim.b[buf].terminal_job_id
      if chan and vim.fn.jobwait({ chan }, 0)[1] ~= -1 then
        vim.api.nvim_buf_delete(buf, { force = true })
        closed = closed + 1
      end
    end
  end
  if closed > 0 then
    print("Closed " .. closed .. " finished terminal buffer(s)")
  else
    print("No finished terminal buffers found")
  end
end, { desc = desc("mappings: Close all finished terminal buffers") })

-- Synced from .vimrc:642 — Run test for current file
vim.keymap.set("n", "<leader>gg", function()
  local file = vim.fn.expand("%")
  if file == "" then
    print("No file to test")
    return
  end
  vim.cmd("cclose")
  vim.cmd("vertical Start! yarn test -u --no-coverage " .. vim.fn.shellescape(file))
end, { desc = desc("mappings: Run yarn test for current file") })

-- Synced from .vimrc:643 — Run test for nearest it() block
vim.keymap.set("n", "<leader>GG", function()
  local file = vim.fn.expand("%")
  if file == "" then
    print("No file to test")
    return
  end
  local it_line = vim.fn.search("\\s*it(", "bnW")
  if it_line == 0 then
    print("No it() function found")
    return
  end
  local test_name = vim.fn.matchstr(vim.fn.getline(it_line), "it(\\s*[\"']\\zs[^\"']*\\ze[\"']")
  if test_name == "" then
    print("Could not extract test name")
    return
  end
  vim.cmd("cclose")
  vim.cmd("vertical Start! yarn test -u --no-coverage " .. vim.fn.shellescape(file) .. " -t " .. vim.fn.shellescape(test_name))
end, { desc = desc("mappings: Run yarn test for nearest it() block") })
