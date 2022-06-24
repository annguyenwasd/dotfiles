-- {{{1 Plugins
-- {{{ Boostrap
local install_path = vim.fn.stdpath("data") ..
                         "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    })
end
-- }}}

-- {{{ Packer Start
require("packer").startup(function(use)

    -- {{{ Packer
    use "wbthomason/packer.nvim"
    -- }}}

    -- {{{ Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {enable = true}
            })
        end,
        run = ':TSUpdate'
    }

    use {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            require"nvim-treesitter.configs".setup {
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["ai"] = "@contitional.outer",
                            ["ii"] = "@conditional.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                            ["ap"] = "@parameter.outer",
                            ["ip"] = "@parameter.inner"
                        }
                    },
                    swap = {
                        enable = true,
                        swap_next = {["<leader>sn"] = "@parameter.inner"},
                        swap_previous = {["<leader>sp"] = "@parameter.inner"}
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer"
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer"
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer"
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer"
                        }
                    },
                    lsp_interop = {
                        enable = true,
                        border = "none",
                        peek_definition_code = {
                            ["<leader>df"] = "@function.outer",
                            ["<leader>dF"] = "@class.outer"
                        }
                    }
                }
            }
        end
    }
    -- }}}

    -- {{{ Telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/plenary.nvim"}},
        config = function()
            local actions = require "telescope.actions"

            -- Falling back to find_files if git_files can't find a .git directory
            local function project_files()
                local ok = pcall(require"telescope.builtin".git_files, {})
                if not ok then
                    require"telescope.builtin".find_files({hidden = true})
                end
            end

            -- You dont need to set any of these options. These are the default ones. Only
            -- the loading is important
            require("telescope").setup {
                defaults = {
                    vimgrep_arguments = {
                        "rg", "--color=never", "--no-heading", "--hidden",
                        "--with-filename", "--line-number", "--column",
                        "--smart-case", "-u" -- thats the new thing
                    },
                    file_ignore_patterns = {"node_modules", ".git"},
                    mappings = {
                        i = {
                            ["<c-s>"] = actions.send_selected_to_qflist +
                                actions.open_qflist,
                            ["<c-h>"] = actions.which_key
                        },
                        n = {
                            ["<c-s>"] = actions.send_selected_to_qflist +
                                actions.open_qflist,
                            ["<c-h>"] = actions.which_key,
                            ["<c-d>"] = actions.delete_buffer
                        }
                    }
                }
            }

            local builtin = require('telescope.builtin');

            vim.keymap.set("n", "<leader>o", project_files)
            vim.keymap.set("n", "<leader>i", builtin.find_files)
            vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
            vim.keymap.set("n", "<leader>rg", builtin.live_grep)
            vim.keymap.set("n", "<leader>fh", builtin.help_tags)
            vim.keymap.set("n", "<leader><leader>fh", builtin.man_pages)
            vim.keymap.set("n", "<leader>ch", builtin.command_history)
            vim.keymap.set("n", "<leader>sh", builtin.search_history)
            vim.keymap.set("n", "<leader>fc", builtin.commands)
            vim.keymap.set("n", "<leader><leader>fc", builtin.colorscheme)
            vim.keymap.set("n", "<leader>km", builtin.keymaps)
            vim.keymap.set("n", "<leader>tr", builtin.resume)
            vim.keymap.set("n", "<leader>hi", builtin.highlights)

            vim.keymap.set("n", "gr", function()
                builtin.lsp_references({initial_mode = 'normal'})
            end)

            -- vim.keymap.set("n", "gd", function()
            --     builtin.lsp_definitions({initial_mode = 'normal'})
            -- end)
            vim.keymap.set("n", "gi", function()
                builtin.lsp_implementations({initial_mode = 'normal'})
            end)

            vim.keymap.set("n", "gy", function()
                builtin.lsp_type_definitions({initial_mode = 'normal'})
            end)

            vim.keymap.set("n", "<leader>da", function()
                builtin.diagnostics({initial_mode = 'normal', bufnr = 0})
            end)

            vim.keymap.set("n", "<leader><leader>da", function()
                builtin.diagnostics({initial_mode = 'normal'})
            end)

            vim.keymap.set("n", "<leader>ds", function()
                builtin.lsp_document_symbols({initial_mode = 'normal'})
            end)

            vim.keymap.set("n", "<leader>ws", function()
                builtin.lsp_workspace_symbols({query = ''})
            end)

            vim.keymap.set("n", "<leader>ff", function()
                builtin.find_files({hidden = true, cwd = '%:p:h'})
            end)

        end
    }

    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        config = function()
            require("telescope").setup {extensions = {fzf = {}}}

            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("fzf")
        end
    }

    use {
        "nvim-telescope/telescope-symbols.nvim",
        config = function()
            vim.keymap.set("n", "<leader>ts", "<cmd>Telescope symbols<cr>")
        end
    }

    use {
        "fhill2/telescope-ultisnips.nvim",
        config = function()
            require("telescope").load_extension("ultisnips")

            vim.keymap.set("n", "<leader>tu", "<cmd>Telescope ultisnips<cr>")
        end
    }
    -- }}}

    -- {{{ Status line
    use {
        "nvim-lualine/lualine.nvim",
        requires = "arkav/lualine-lsp-progress",
        config = function()
            local function diff_source()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                    return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed
                    }
                end
            end
            require"lualine".setup {
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    -- component_separators = {left = "", right = ""},
                    -- section_separators = {left = "", right = ""},
                    component_separators = {left = "", right = ""},
                    section_separators = {left = "", right = ""},
                    disabled_filetypes = {},
                    always_divide_middle = true
                },
                sections = {
                    lualine_a = {"mode"},
                    lualine_b = {
                        {"branch", icon = ""},
                        {"diff", source = diff_source},
                        {"diagnostics", sources = {"nvim_diagnostic"}}
                    },
                    lualine_c = {"filename", "lsp_progress"},
                    lualine_x = {},
                    lualine_y = {"progress"},
                    lualine_z = {"location"}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {"filename"},
                    lualine_x = {"location"},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = {}
            }
        end
    }
    -- }}}

    -- {{{ LSP
    use {
        "williamboman/nvim-lsp-installer",
        run = function()
            local required_servers = {
                "yamlls", "jsonls", "html", "vimls", "bashls", "diagnosticls",
                "dockerls", "sumneko_lua", "tsserver", "cssls", "eslint"
            }
            require"nvim-lsp-installer.ui.status-win"().open()
            local lsp_installer_servers = require "nvim-lsp-installer.servers"
            for _, required_server in pairs(required_servers) do
                local _, server = lsp_installer_servers.get_server(
                                      required_server)
                if not server:is_installed() then
                    server:install()
                end
            end
        end
    }

    use {
        "neovim/nvim-lspconfig",
        requires = {
            {"jose-elias-alvarez/nvim-lsp-ts-utils"}, {"b0o/schemastore.nvim"}
        },
        config = function()
            local lsp_installer = require("nvim-lsp-installer")

            function _G.show_documentation()
                if (vim.lsp.buf.server_ready()) then
                    vim.lsp.buf.hover()
                else
                    vim.api.nvim_command("execute 'h! '.expand('<cword>')")
                end
            end

            local setup_ts_utils = function(bufnr, client)
                local ts_utils = require("nvim-lsp-ts-utils")

                ts_utils.setup({})

                -- required to fix code action ranges and filter diagnostics
                ts_utils.setup_client(client)

                local opts = {buffer = bufnr}
                -- no default maps, so you may want to define some here
                vim.keymap.set("n", "<leader><leader>oi", ":TSLspOrganize<CR>",
                               opts)
                vim.keymap.set("n", "<leader>rf", ":TSLspRenameFile<CR>", opts)
                vim.keymap.set("n", "<leader><leader>i", ":TSLspImportAll<CR>",
                               opts)
            end

            local onServerReady = function(server)
                local on_attach = function(client, bufnr)

                    vim.api.nvim_buf_set_option(bufnr, 'omnifunc',
                                                'v:lua.vim.lsp.omnifunc')

                    if server.name == "tsserver" then
                        setup_ts_utils(bufnr, client)
                    end

                    local opts = {buffer = bufnr}

                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    -- vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
                    vim.keymap.set("n", "K", show_documentation, opts)
                    -- vim.keymap.set("n", "gi",vim.lsp.buf.implementation, opts)
                    -- vim.keymap.set("n", "<C-k>",vim.lsp.buf.signature_help, opts)
                    -- vim.keymap.set("n", "<leader>wa",vim.lsp.buf.add_workspace_folder, opts)
                    -- vim.keymap.set("n", "<leader>wr",vim.lsp.buf.remove_workspace_folder, opts)
                    -- vim.keymap.set("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
                                   opts)
                    vim.keymap.set("n", "gR", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float,
                                   opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                    vim.keymap.set("n", "<leader><leader>fm",
                                   vim.lsp.buf.formatting, opts)
                    vim.keymap.set("n", "<leader><leader>ee",
                                   "<cmd>EslintFixAll<CR>", opts)
                    -- vim.keymap.set("n", "<space>q",vim.diagnostic.set_loclist, opts)
                    -- vim.keymap.set("n", "<space>=",vim.lsp.buf.formatting, opts)
                end

                local settings = {}
                local capabilities = {}
                local init_options = {}

                if server.name == "sumneko_lua" then
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = {"vim", "packer_bootstrap"}
                            }
                        }
                    }
                end

                if server.name == "jsonls" then
                    capabilities = vim.lsp.protocol.make_client_capabilities()
                    capabilities.textDocument.completion.completionItem
                        .snippetSupport = true

                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = {enable = true}
                        }
                    }
                end

                if server.name == "tsserver" then
                    init_options = require("nvim-lsp-ts-utils").init_options
                end

                server:setup({
                    init_options = init_options,
                    on_attach = on_attach,
                    settings = settings,
                    capabilities = capabilities
                })

                vim.cmd [[ do User LspAttachBuffers ]]
            end

            lsp_installer.on_server_ready(onServerReady)
        end
    }

    use {
        "ray-x/lsp_signature.nvim",
        config = function()
            require"lsp_signature".setup {toggle_key = "<c-s>"}
        end
    }
    -- }}}

    -- {{{ Completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline",
            "SirVer/ultisnips", "quangnguyen30192/cmp-nvim-ultisnips"
        },
        config = function()
            local cmp = require "cmp"
            local t = require"utils".t

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end
                },
                mapping = {
                    ["<down>"] = cmp.mapping(
                        cmp.mapping.select_next_item({
                            behavior = cmp.SelectBehavior.Select
                        }), {"i"}),
                    ["<up>"] = cmp.mapping(
                        cmp.mapping.select_prev_item({
                            behavior = cmp.SelectBehavior.Select
                        }), {"i"}),
                    ["<c-n>"] = cmp.mapping({
                        c = function()
                            if cmp.visible() then
                                cmp.select_next_item({
                                    behavior = cmp.SelectBehavior.Select
                                })
                            else
                                vim.api.nvim_feedkeys(t("<Down>"), "n", true)
                            end
                        end,
                        i = function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item({
                                    behavior = cmp.SelectBehavior.Select
                                })
                            else
                                fallback()
                            end
                        end
                    }),
                    ["<c-p>"] = cmp.mapping({
                        c = function()
                            if cmp.visible() then
                                cmp.select_prev_item({
                                    behavior = cmp.SelectBehavior.Select
                                })
                            else
                                vim.api.nvim_feedkeys(t("<Up>"), "n", true)
                            end
                        end,
                        i = function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item({
                                    behavior = cmp.SelectBehavior.Select
                                })
                            else
                                fallback()
                            end
                        end
                    }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4),
                                            {"i", "c"}),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4),
                                            {"i", "c"}),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(),
                                                {"i", "c"}),
                    -- ["<c-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<cr>"] = cmp.mapping.confirm({select = false}),
                    -- ["<cr>"] = cmp.mapping(
                    --     {
                    --         i = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}),
                    --         c = function(fallback)
                    --             if cmp.visible() then
                    --                 cmp.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})
                    --             else
                    --                 fallback()
                    --             end
                    --         end
                    --     }
                    -- ),
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close()
                    }),
                    ["<Tab>"] = cmp.mapping({
                        c = function()
                            if cmp.visible() then
                                cmp.select_next_item({
                                    behavior = cmp.SelectBehavior.Insert
                                })
                            else
                                cmp.complete()
                            end
                        end,
                        i = function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item({
                                    behavior = cmp.SelectBehavior.Insert
                                })
                            elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                                vim.api.nvim_feedkeys(t(
                                                          "<Plug>(ultisnips_jump_forward)"),
                                                      "m", true)
                            else
                                fallback()
                            end
                        end,
                        s = function(fallback)
                            if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                                vim.api.nvim_feedkeys(t(
                                                          "<Plug>(ultisnips_jump_forward)"),
                                                      "m", true)
                            else
                                fallback()
                            end
                        end
                    }),
                    ["<S-Tab>"] = cmp.mapping({
                        c = function()
                            if cmp.visible() then
                                cmp.select_prev_item({
                                    behavior = cmp.SelectBehavior.Insert
                                })
                            else
                                cmp.complete()
                            end
                        end,
                        i = function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item({
                                    behavior = cmp.SelectBehavior.Insert
                                })
                            elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                                return vim.api.nvim_feedkeys(t(
                                                                 "<Plug>(ultisnips_jump_backward)"),
                                                             "m", true)
                            else
                                fallback()
                            end
                        end,
                        s = function(fallback)
                            if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                                return vim.api.nvim_feedkeys(t(
                                                                 "<Plug>(ultisnips_jump_backward)"),
                                                             "m", true)
                            else
                                fallback()
                            end
                        end
                    })
                },
                sources = cmp.config.sources({
                    {name = "nvim_lsp"}, {name = "ultisnips"}
                }, {
                    {
                        name = "buffer",
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end
                    }
                })
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline("/", {
                sources = {
                    {
                        name = "buffer",
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end
                    }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                sources = cmp.config
                    .sources({{name = "path"}}, {{name = "cmdline"}})
            })
        end
    }

    use {
        "onsails/lspkind-nvim",
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            cmp.setup {formatting = {format = lspkind.cmp_format()}}
        end
    }

    use {
        "SirVer/ultisnips",
        requires = {{"honza/vim-snippets", rtp = "."}},
        config = function()
            vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
            vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
            vim.g.UltiSnipsJumpBackwardTrigger =
                "<Plug>(ultisnips_jump_backward)"
            vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
            vim.g.UltiSnipsRemoveSelectModeMappings = 0
        end
    }
    -- }}}

    -- {{{ Nvim tree
    use {
        "kyazdani42/nvim-tree.lua",
        setup = function()
            vim.gnvim_tree_respect_buf_cwd = 1 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
        end,
        config = function()
            local tree_cb = require("nvim-tree.config").nvim_tree_callback

            vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")

            require("nvim-tree").setup({
                actions = {open_file = {quit_on_open = true}},
                renderer = {indent_markers = {enable = true}},
                update_to_buf_dir = {enable = true, auto_open = true},
                update_focused_file = {enable = true},
                view = {
                    width = 40,
                    mappings = {
                        list = {
                            {key = {"l"}, cb = tree_cb("edit")},
                            {key = {"h"}, cb = tree_cb("close_node")}
                        }

                    }
                }
            })
        end
    }
    -- }}}

    -- {{{ Tmux integration
    use {
        "christoomey/vim-tmux-navigator",
        config = function() vim.g.gtmux_navigator_disable_when_zoomed = 1 end
    }
    -- }}}

    -- {{{ Git
    use {"kdheepak/lazygit.nvim"}
    use {
        "tpope/vim-fugitive",
        config = function()
            -- Not gonna show shit messages when run git hook via husky
            vim.g.fugitive_pty = 0
            vim.g.lazygit_floating_window_winblend = 1
            vim.g.lazygit_floating_window_scaling_factor = 1

            vim.api.nvim_create_autocmd("BufReadPost", {
                group = vim.api.nvim_create_augroup("FugitiveAutoCleanBuffer",
                                                    {clear = true}),
                pattern = "fugitive://*",
                command = "set bufhidden=delete"
            })

            local function vsplitCommit()
                vim.cmd "vsplit term://git commit"
            end

            vim.keymap.set("n", "<leader>gf",
                           "<cmd>diffget //2 <cr> <cmd>w <cr> <cmd>diffupdate <cr>")
            vim.keymap.set("n", "<leader>gj",
                           "<cmd>diffget //3 <cr> <cmd>w <cr> <cmd>diffupdate <cr>")
            vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>")
            vim.keymap.set("n", "<leader>gl", "<cmd>GcLog<cr>")
            vim.keymap.set("n", "<leader>gs",
                           "<cmd>G difftool --name-status<cr>")
            vim.keymap.set("n", "<leader><leader>gs", "<cmd>G difftool<cr>")
            vim.keymap.set("n", "<leader><leader>bl", "<cmd>G blame<cr>")
            vim.keymap.set("n", "<leader>gc", vsplitCommit)
            vim.keymap.set("n", "<leader><leader>gc",
                           ':G commit -n -m ""<left>', {silent = false})
            vim.keymap.set("n", "<leader>ga", "<cmd>G add -A<cr>")
            vim.keymap.set("n", "<leader>gw",
                           '<cmd>G add -A <bar>G commit -n -m "WIP"<cr>')
            vim.keymap.set("n", "<leader>gp",
                           ":AsyncRun git push origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease<cr>",
                           {silent = false})
        end
    }
    use {
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return '<Ignore>'
                    end, {expr = true})

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return '<Ignore>'
                    end, {expr = true})

                    -- Actions
                    map({'n', 'v'}, '<leader>ha', ':Gitsigns stage_hunk<CR>')
                    map({'n', 'v'}, '<leader>hd', ':Gitsigns reset_hunk<CR>')
                    map('n', '<leader>hA', gs.stage_buffer)
                    map('n', '<leader>hu', gs.undo_stage_hunk)
                    map('n', '<leader>hD', gs.reset_buffer)
                    map('n', '<leader>hc', gs.preview_hunk)
                    map('n', '<leader>bl',
                        function()
                        gs.blame_line {full = true}
                    end)
                    map('n', '<leader>tb', gs.toggle_current_line_blame)
                    map('n', '<leader>td', gs.toggle_deleted)

                    -- Text object
                    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            })
        end
    }
    -- }}}

    -- {{{ Theme
    use {
        "folke/tokyonight.nvim",
        setup = function()
            vim.g.tokyonight_style = "night"
            vim.g.tokyonight_sidebars = {
                "qf", "vista_kind", "terminal", "packer"
            }
        end,
        config = function()
            -- require "utils".set_theme("tokyonight")
        end
    }

    use {
        "bluz71/vim-nightfly-guicolors",
        config = function()
            -- require "utils".set_theme('nightfly')
        end
    }

    use {
        "dracula/vim",
        as = "dracula",
        config = function()
            -- require "utils".set_theme('dracula')
        end
    }

    use {
        "doums/darcula",
        config = function()
            -- require "utils".set_theme('darcula', 'gruvbox_dark')
        end
    }

    use {
        "marko-cerovac/material.nvim",
        setup = function()
            -- darker, lighter, oceanic, palenight, deep ocean
            vim.g.material_style = "deep ocean"
        end,
        config = function()
            -- lua require('material.functions').toggle_style()
            require("material").setup({
                contrast = {
                    sidebars = true,
                    floating_windows = false,
                    line_numbers = false,
                    sign_column = false,
                    cursor_line = true,
                    popup_menu = false
                },
                italics = {
                    comments = true,
                    strings = false,
                    keywords = true,
                    functions = true,
                    variables = false
                },
                contrast_filetypes = {"terminal", "packer", "qf"},
                disable = {
                    borders = true,
                    background = false,
                    term_colors = false,
                    eob_lines = false
                }
            })
            require"utils".set_theme("material")
        end
    }

    use {
        "mcchrish/zenbones.nvim",
        requires = "rktjmp/lush.nvim",
        config = function()
            --[[
                  zenwritten  	 Zero hue and saturation version
                  neobones    	 Inspired by neovim.io
                  vimbones    	 Inspired by vim.org
                  rosebones   	 Inspired by Rosé Pine
                  forestbones 	 Inspired by Everforest
                  nordbones   	 Inspired by Nord
                  tokyobones  	 Inspired by Tokyo Night
                  seoulbones  	 Inspired by Seoul256
                  duckbones   	 Inspired by Spaceduck
                  zenburned   	 Inspired by Zenburn
                  randombones 	 Randomly pick from the collection.
              ]]
            -- require "utils".set_theme("neobones")
        end
    }

    use {
        "Mofiqul/vscode.nvim",
        setup = function()
            vim.g.vscode_style = "dark"
            -- vim.g.vscode_style = "light"
        end,
        config = function()
            -- :lua require('vscode').change_style("light")
            -- :lua require('vscode').change_style("dark")
            -- require "utils".set_theme("vscode")
        end
    }

    use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            -- require "utils".set_theme("catppuccin")
        end
    })

    -- }}}

    -- {{{ Formatter
    use {
        "sbdchd/neoformat",
        config = function()
            local map = require"utils".map

            vim.g.neoformat_only_msg_on_error = 1
            vim.g.neoformat_basic_format_trim = 1

            map("v", "<leader>fm", ":Neoformat<CR>")
            map("n", "<leader>fm", ":Neoformat<CR>")
        end
    }
    -- }}}

    -- {{{ Comment
    use {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            require"nvim-treesitter.configs".setup {
                context_commentstring = {enable = true}
            }
        end
    }
    use {
        "tpope/vim-commentary",
        config = function()
            vim.cmd [[
                  autocmd FileType apache setlocal commentstring=#\ %s
                  ]]
        end
    }
    -- }}}

    -- {{{ MISC
    use {
        "tpope/vim-surround", "tpope/vim-repeat", "tpope/vim-unimpaired",
        "tpope/vim-abolish", "tpope/vim-obsession", "tpope/vim-eunuch"
    }
    use {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}
    use "kevinhwang91/nvim-bqf"
    use "vim-scripts/BufOnly.vim"
    use "KabbAmine/vCoolor.vim"
    use "ThePrimeagen/vim-be-good"
    use "romainl/vim-cool"
    use "godlygeek/tabular"

    -- This break the lsp_installer :LSPInstallInfo. Disabled for now
    use {
        "sunjon/shade.nvim",
        disable = true,
        config = function()
            require"shade".setup({
                overlay_opacity = 50,
                opacity_step = 1,
                keys = {
                    brightness_up = "<C-Up>",
                    brightness_down = "<C-Down>",
                    toggle = "<leader>ss"
                }
            })
        end
    }

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
        setup = function() vim.g.mkdp_filetypes = {"markdown"} end,
        ft = {"markdown"},
        config = function()
            local map = require"utils".map
            map("n", "gm", ":MarkdownPreviewToggle<CR>")
        end
    })

    use {
        "airblade/vim-rooter",
        setup = function()
            vim.g.rooter_patterns = {
                ".git", ".svn", "package.json", "!node_modules"
            }
        end
    }

    use {"jghauser/mkdir.nvim", config = function() require("mkdir") end}

    use {
        "szw/vim-maximizer",
        config = function()
            local map = require"utils".map
            map("n", "<leader>m", ":MaximizerToggle<cr>")
        end
    }

    use {
        "mbbill/undotree",
        config = function()
            local map = require"utils".map

            map("n", "<leader>u", ":UndotreeShow<cr>")
        end
    }

    use {
        "ThePrimeagen/harpoon",
        config = function()
            local map = require"utils".map

            require("harpoon").setup({menu = {width = 120, height = 30}})

            map("n", "ma", '<cmd>lua require("harpoon.mark").add_file()<cr>')
            map("n", "'1", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')
            map("n", "'2", '<cmd>lua require("harpoon.ui").nav_file(2)<cr>')
            map("n", "'3", '<cmd>lua require("harpoon.ui").nav_file(3)<cr>')
            map("n", "'4", '<cmd>lua require("harpoon.ui").nav_file(4)<cr>')
            map("n", "'5", '<cmd>lua require("harpoon.ui").nav_file(5)<cr>')
            map("n", "mq",
                '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')
        end
    }

    use {
        "skywind3000/asyncrun.vim",
        config = function()
            local nvim_create_augroups = require"utils".nvim_create_augroups
            nvim_create_augroups({
                AutoOpenQuickFixAsyncRun = {"User AsyncRunStop :copen 20"}
            })
        end
    }

    use {
        "ryanoasis/vim-devicons", {
            "kyazdani42/nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup({
                    override = {
                        typescriptreact = {
                            icon = "",
                            color = "#519aba",
                            name = "Tsx"
                        },
                        javascriptreact = {
                            icon = "",
                            color = "#519aba",
                            name = "Jsx"
                        },
                        typescript = {
                            icon = "",
                            color = "#519aba",
                            name = "Ts"
                        },
                        javascript = {
                            icon = "",
                            color = "#519ada",
                            name = "Js"
                        }
                    },
                    default = true
                })
            end
        }
    }

    use {
        "norcalli/nvim-colorizer.lua",
        config = function() require("colorizer").setup() end
    }

    use {
        "dm1try/golden_size",
        config = function()
            local function ignore_by_buftype(types)
                local buftype = vim.api.nvim_buf_get_option(0, "buftype")
                for _, type in pairs(types) do
                    if type == buftype then return 1 end
                end
            end
            local golden_size = require("golden_size")
            -- set the callbacks, preserve the defaults
            golden_size.set_ignore_callbacks({
                {ignore_by_buftype, {"terminal", "quickfix", "nofile"}},
                {golden_size.ignore_float_windows}, -- default one, ignore float windows
                {golden_size.ignore_by_window_flag} -- default one, ignore windows with w:ignore_gold_size=1
            })
        end
    }
    -- }}}

    -- {{{ Debugger
    -- use {
    --     "mfussenegger/nvim-dap",
    --     setup = function()
    --         vim.cmd [[
    --   au FileType dap-repl lua require('dap.ext.autocompl').attach()
    --   ]]
    --     end,
    --     config = function()
    --         local map = require "utils".map

    --         map("n", "<localleader>bb", ":lua require'dap'.toggle_breakpoint()<cr>")
    --         map(
    --             "n",
    --             "<localleader>bc",
    --             ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>"
    --         )
    --         map(
    --             "n",
    --             "<localleader>bl",
    --             ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>"
    --         )
    --         map("n", "<localleader>BB", ":lua require'dap'.list_breakpoints()<cr>:copen<cr>")
    --         map("n", "<localleader>c", ":lua require'dap'.continue()<cr>")
    --         map("n", "`o", ":lua require'dap'.step_over()<cr>")
    --         map("n", "`i", ":lua require'dap'.step_into()<cr>")
    --         map("n", "`u", ":lua require'dap'.step_out()<cr>")
    --         map("n", "`j", ":lua require'dap'.down()<cr>")
    --         map("n", "`k", ":lua require'dap'.up()<cr>")
    --         map("n", "<localleader>b", ":lua require'dap'.step_back()<cr>")
    --         map("n", "<localleader>t", ":lua require'dap'.terminate()<cr>")
    --         map("n", "<localleader>di", ":lua require'dap'.terminate()<cr>")
    --         map("n", "<localleader>re", ":lua require'dap'.repl.toggle()<cr>")
    --         map("n", "<localleader>rc", ":lua require'dap'.run_to_cursor()<cr>")
    --         map("n", "<localleader>s", ":lua require('dap.ui.widgets').hover()<cr>")
    --         map("n", "<localleader>da", ":Telescope dap commands<cr>")

    --         -- View the current scopes in floating window
    --         map(
    --             "n",
    --             "<localleader>ds",
    --             ":lua local widgets = require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<cr>"
    --         )
    --         -- View the current frames floating window
    --         map(
    --             "n",
    --             "<localleader>df",
    --             ":lua local widgets = require('dap.ui.widgets');widgets.centered_float(widgets.frames)<cr>"
    --         )
    --     end
    -- }
    -- use {
    --     "Pocco81/DAPInstall.nvim",
    --     config = function()
    --         local dap_install = require("dap-install")
    --         local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

    --         dap_install.setup(
    --             {
    --                 installation_path = vim.fn.stdpath("data") .. "/dapinstall/"
    --             }
    --         )

    --         for _, debugger in ipairs(dbg_list) do
    --             dap_install.config(debugger)
    --         end
    --     end
    -- }

    -- use {
    --     "nvim-telescope/telescope-dap.nvim",
    --     config = function()
    --         require("telescope").load_extension("dap")
    --     end
    -- }
    -- }}}

    -- {{{ Packer end

    -- {{{ Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all useins
    if packer_bootstrap then require("packer").sync() end
    -- }}}
end)

-- }}}
-- }}}1

-- {{{1 Settings
-- {{{2
vim.g.vimsyn_embed = "lPr"

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.clipboard = "unnamed"
vim.opt.updatetime = 50
vim.opt.inccommand = "nosplit"
vim.opt.mouse = "a"
vim.opt.scrolloff = 8
vim.opt.completeopt = {"menuone", "noinsert", "noselect"}
vim.opt.shortmess:append({c = true})
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undo")
vim.opt.cmdheight = 2
vim.opt.listchars = "tab:▹ ,trail:·"
vim.opt.list = true
vim.opt.wrapscan = false

vim.wo.signcolumn = "yes"

vim.bo.syntax = "enable"
vim.bo.swapfile = false

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("OpenHelpOnRightMostWindow",
                                        {clear = true}),
    pattern = "*.txt",
    command = "if &buftype == 'help' | wincmd L | endif",
    desc = "Open help page on the right (default bottom)"
})

local auto_set_file_type = vim.api.nvim_create_augroup("AutoSetFileType",
                                                       {clear = true});

vim.api.nvim_create_autocmd("BufEnter", {
    group = auto_set_file_type,
    pattern = "*.zsh",
    command = "setlocal filetype=zsh"
})
vim.api.nvim_create_autocmd("BufEnter", {
    group = auto_set_file_type,
    pattern = "*.todo",
    command = "setlocal filetype=todo"
})
vim.api.nvim_create_autocmd("BufEnter", {
    group = auto_set_file_type,
    pattern = "*.conf",
    command = "setlocal filetype=conf"
})

vim.api.nvim_create_autocmd("FileType zsh,vim.conf,lua", {
    group = vim.api.nvim_create_augroup("SetFoldMethod", {clear = true}),
    command = "setlocal foldmethod=marker"
})

local cursor_line_only_in_active_window =
    vim.api.nvim_create_augroup("CursorLineOnlyInActiveWindow", {clear = true})

vim.api.nvim_create_autocmd({"VimEnter", "WinEnter", "BufWinEnter"}, {
    group = cursor_line_only_in_active_window,
    pattern = "*",
    command = "setlocal cursorline"
})

vim.api.nvim_create_autocmd("WinLeave", {
    group = cursor_line_only_in_active_window,
    pattern = "*",
    command = "setlocal nocursorline"
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = vim.api.nvim_create_augroup("AutoSetFoldLevelInitLua",
                                        {clear = true}),
    pattern = "*.lua",
    command = "setlocal foldlevel=1"
})

-- }}}2
-- }}}1

-- {{{1 Mappings
-- {{{
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "n", "nzt", {noremap = false})
vim.keymap.set("n", "N", "Nzt", {noremap = false})
vim.keymap.set("n", "*", "*zt", {noremap = false})
vim.keymap.set("n", "#", "#zt", {noremap = false})

vim.keymap.set("n", "Y", "y$")

-- Duplicate everything selected
vim.keymap.set("v", "D", "y'>p")

-- Do search with selected text in VISUAL mode
vim.keymap.set("v", "*", 'y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>',
               {noremap = false})

vim.keymap.set("n", "<leader>cl",
               "<cmd>ccl<cr><cmd>lcl<cr><cmd>echo ''<cr><cmd>noh<cr>")
vim.keymap.set("n", "<leader><leader>r",
               "<cmd>so %<cr><cmd>PackerCompile<cr>:syntax enable<cr>")
vim.keymap.set("n", "<leader><leader>R",
               "<cmd>so ~/.config/nvim/init.lua<cr><cmd>PackerCompile<cr>:syntax enable<cr>")

vim.keymap.set("n", "<c-w><c-e>", "<c-w>=")

-- Moving around in command mode
vim.keymap.set("c", "<c-h>", "<left>", {silent = false})
vim.keymap.set("c", "<c-j>", "<down>", {silent = false})
vim.keymap.set("c", "<c-k>", "<up>", {silent = false})
vim.keymap.set("c", "<c-l>", "<right>", {silent = false})

vim.keymap.set("i", "<c-h>", "<left>", {silent = false})
vim.keymap.set("i", "<c-j>", "<down>", {silent = false})
vim.keymap.set("i", "<c-k>", "<up>", {silent = false})
vim.keymap.set("i", "<c-l>", "<right>", {silent = false})

vim.keymap.set("n", "<leader>e", "<cmd>b #<cr>")
vim.keymap.set("n", "<leader><leader>e", "<cmd>e<cr>")
vim.keymap.set("n", "<leader>bo", "<cmd>BufOnly<cr>")
vim.keymap.set("n", "<leader>td", ":vsp .todo<cr>")

-- Create file at same folder with vsplit/split
vim.keymap.set("n", "<leader>vf", ":vsp %:h/", {silent = false})
vim.keymap.set("n", "<leader>sf", ":sp %:h/", {silent = false})
vim.keymap.set("n", "<leader><leader>ef", ":e %:h/", {silent = false})

vim.keymap.set("n", "<leader><leader>h", 'yi" :!npm home <c-r>"<cr>')
vim.keymap.set("n", "<leader><leader>H", 'yi\' :!npm home <c-r>"<cr>')
vim.keymap.set("n", "<leader><leader>oe", "<cmd>!open -a textedit %<cr>")
vim.keymap.set("n", "<leader><leader>oc",
               "<cmd>!open -a visual studio code %<cr>")
vim.keymap.set("n", "<leader><leader>og", "<cmd>!open -a google chrome %<cr>")

-- Windows
vim.keymap.set("n", "<c-w>v", "<c-w>v <c-w>l", {noremap = true})
vim.keymap.set("n", "<c-w><c-v>", "<c-w>v <c-w>l", {noremap = true})
vim.keymap.set("n", "<c-w>s", "<c-w>s <c-w>j", {noremap = true})
vim.keymap.set("n", "<c-w><c-s>", "<c-w>s <c-w>j", {noremap = true})
vim.keymap.set("n", "<c-w><c-w>", "<c-w>q", {noremap = true})
vim.keymap.set("n", "<leader><leader>m", ":vert res 120<cr>", {noremap = true})
vim.keymap.set("n", "<leader><leader>M", ":GoldenRatioToggle<cr>",
               {noremap = true})

vim.keymap.set("n", "<leader>rr", '"rciw')
vim.keymap.set("n", "<leader>cf", ":CopyFileName<cr>")
vim.keymap.set("n", "<leader>fl", ":set foldlevel=", {silent = false})

function _G.copyFileName()
    vim.fn.setreg("*", vim.fn.expand("%:t:r"))
    vim.fn.setreg("r", vim.fn.expand("%:t:r"))
end

function _G.copyAbsouPathPath()
    vim.fn.setreg("*", vim.fn.expand("%:p"))
    vim.fn.setreg("r", vim.fn.expand("%:p"))
end

function _G.copyFileRelativePath()
    vim.fn.setreg("*", vim.fn.expand("%"))
    vim.fn.setreg("r", vim.fn.expand("%"))
end

function _G.copyFileRelativeFolderPath()
    vim.fn.setreg("*", vim.fn.expand("%:h"))
    vim.fn.setreg("r", vim.fn.expand("%:h"))
end

function _G.copyFolderName()
    vim.fn.setreg("*", vim.fn.expand("%:h:t"))
    vim.fn.setreg("r", vim.fn.expand("%:h:t"))
end

function _G.openCurrentFolder() vim.api.nvim_command("!open %:p:h") end

function _G.googleJavaFormat()
    vim.api.nvim_command("!google-java-format --replace % ")
end

vim.api.nvim_command("command! CopyFileName :call v:lua.copyFileName()")
vim.api.nvim_command("command! Cfn :call v:lua.copyFileName()")

vim.api.nvim_command("command! CopyFolderName :call v:lua.copyFolderName()")
vim.api.nvim_command("command! Cdn :call v:lua.copyFolderName()")

vim.api.nvim_command(
    "command! CopyAbsouPathPath :call v:lua.copyAbsouPathPath()")
vim.api.nvim_command(
    "command! CopyRelativePath :call v:lua.copyFileRelativePath()")
vim.api.nvim_command(
    "command! CopyFolderPath :call v:lua.copyFileRelativeFolderPath()")

vim.api.nvim_command("command! GoogleJavaFormat :call v:lua.googleJavaFormat()")

vim.api.nvim_command("command! OpenFolder :call v:lua.openCurrentFolder()")
vim.api.nvim_command("command! Od :call v:lua.openCurrentFolder()")

-- Open github page
vim.keymap.set("n", "<leader><leader>gh", function()
    vim.cmd('normal! yi"');
    local package = vim.fn.getreg('"')
    local ghPage = 'https://github.com/' .. package
    vim.cmd('!open ' .. ghPage);
end)

-- }}}
-- }}}1
