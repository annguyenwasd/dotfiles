---@diagnostic disable: redefined-local
local nvim_create_augroups = require "utils".nvim_create_augroups
local map = require "utils".map
local nvim_command = vim.api.nvim_command

-- {{{1 Plugins
-- {{{ Boostrap
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap =
        fn.system(
        {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path
        }
    )
end
-- }}}

-- {{{ Packer Start

require("packer").startup(
    function(use)
        -- }}}

        -- {{{ Packer
        use "wbthomason/packer.nvim"
        -- }}}

        -- {{{ Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                require("nvim-treesitter.configs").setup(
                    {
                        ensure_installed = "maintained",
                        highlight = {
                            enable = true
                        }
                    }
                )
            end
        }

        use {
            "nvim-treesitter/nvim-treesitter-textobjects",
            config = function()
                require "nvim-treesitter.configs".setup {
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
                            swap_next = {
                                ["<leader>sn"] = "@parameter.inner"
                            },
                            swap_previous = {
                                ["<leader>sp"] = "@parameter.inner"
                            }
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
            requires = {{"nvim-lua/plenary.nvim"}, {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}},
            config = function()
                local map = require "utils".map
                local actions = require "telescope.actions"

                -- Falling back to find_files if git_files can't find a .git directory
                function _G.project_files()
                    local ok = pcall(require "telescope.builtin".git_files, {})
                    if not ok then
                        require "telescope.builtin".find_files({hidden = true})
                    end
                end

                -- You dont need to set any of these options. These are the default ones. Only
                -- the loading is important
                require("telescope").setup {
                    defaults = {
                        vimgrep_arguments = {
                            "rg",
                            "--color=never",
                            "--no-heading",
                            "--hidden",
                            "--with-filename",
                            "--line-number",
                            "--column",
                            "--smart-case",
                            "-u" -- thats the new thing
                        },
                        file_ignore_patterns = {"node_modules", ".git"},
                        mappings = {
                            i = {
                                ["<c-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                                ["<c-h>"] = actions.which_key
                            },
                            n = {
                                ["<c-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                                ["<c-h>"] = actions.which_key,
                                ["<c-d>"] = actions.delete_buffer
                            }
                        }
                    },
                    extensions = {
                        fzf = {
                            fuzzy = true, -- false will only do exact matching
                            override_generic_sorter = true, -- override the generic sorter
                            override_file_sorter = true, -- override the file sorter
                            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                            -- the default case_mode is "smart_case"
                        }
                    }
                }
                -- To get fzf loaded and working with telescope, you need to call
                -- load_extension, somewhere after setup function:
                require("telescope").load_extension("fzf")

                map("n", "<leader>o", ":call v:lua.project_files()<cr>")
                map("n", "<leader>i", "<cmd>Telescope buffers<cr>")
                map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
                map("n", "<leader>rg", ':lua require"telescope.builtin".live_grep()<CR>')
                map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
                map("n", "<leader><leader>fh", "<cmd>Telescope man_pages<cr>")
                map("n", "<leader>ch", "<cmd>Telescope command_history<cr>")
                map("n", "<leader>sh", "<cmd>Telescope search_history<cr>")
                map("n", "<leader>fc", "<cmd>Telescope commands<cr>")
                map("n", "<leader><leader>fc", "<cmd>Telescope colorscheme<cr>")
                map("n", "<leader>km", "<cmd>Telescope keymaps<cr>")
                map("n", "<leader>tr", "<cmd>Telescope resume<cr>")
                map("n", "<leader>hi", "<cmd>Telescope highlights<cr>")

                map("n", "gr", "<cmd>Telescope lsp_references initial_mode=normal<cr>")
                -- map("n", "gd", "<cmd>Telescope lsp_definitions initial_mode=normal<cr>")
                map("n", "gi", "<cmd>Telescope lsp_implementations initial_mode=normal<cr>")
                map("n", "gy", "<cmd>Telescope lsp_type_definitions initial_mode=normal<cr>")
                map("n", "<leader>ca", "<cmd>Telescope lsp_code_actions initial_mode=normal theme=cursor<cr>")
                map("n", "<leader>da", "<cmd>Telescope diagnostics bufnr=0 initial_mode=normal<cr>")
                map("n", "<leader><leader>da", "<cmd>Telescope diagnostics initial_mode=normal<cr>")
                map("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols initial_mode=normal<cr>")
                map("n", "<leader>ws", ":Telescope lsp_workspace_symbols<space>query=", {silent = false})

                map(
                    "n",
                    "<leader>ff",
                    "<cmd>lua require 'telescope.builtin'.find_files({hidden = true, cwd='%:p:h'})<cr>"
                )
            end
        }

        use {
            "nvim-telescope/telescope-symbols.nvim",
            config = function()
                local map = require("utils").map
                map("n", "<leader>ts", "<cmd>Telescope symbols<cr>")
            end
        }

        use {
            "fhill2/telescope-ultisnips.nvim",
            config = function()
                require("telescope").load_extension("ultisnips")

                local map = require("utils").map
                map("n", "<leader>tu", "<cmd>Telescope ultisnips<cr>")
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
                require "lualine".setup {
                    options = {
                        icons_enabled = true,
                        theme = "auto",
                        component_separators = {left = "", right = ""},
                        section_separators = {left = "", right = ""},
                        disabled_filetypes = {},
                        always_divide_middle = true
                    },
                    sections = {
                        lualine_a = {"mode"},
                        lualine_b = {
                            "branch",
                            {"diff", source = diff_source},
                            {"diagnostics", sources = {"nvim_diagnostic"}}
                        },
                        lualine_c = {"filename", "lsp_progress"},
                        lualine_x = {"encoding", "fileformat", "filetype"},
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
            requires = {
                {"b0o/schemastore.nvim"},
                {"neovim/nvim-lspconfig"},
                {
                    "RRethy/vim-illuminate",
                    config = function()
                        local map = require "utils".map

                        map("n", "]s", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>')
                        map("n", "[s", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>')
                    end
                },
                {
                    "ray-x/lsp_signature.nvim",
                    config = function()
                        require "lsp_signature".setup {
                            debug = false, -- set to true to enable debug logging
                            log_path = "debug_log_file_path", -- debug log path
                            verbose = false, -- show debug line number
                            bind = true, -- This is mandatory, otherwise border config won't get registered.
                            -- If you want to hook lspsaga or other signature handler, pls set to false
                            doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                            -- set to 0 if you DO NOT want any API comments be shown
                            -- This setting only take effect in insert mode, it does not affect signature help in normal
                            -- mode, 10 by default

                            floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
                            floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
                            -- will set to true when fully tested, set to false will use whichever side has more space
                            -- this setting will be helpful if you do not want the PUM and floating win overlap
                            fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
                            hint_enable = false, -- virtual hint enable
                            hint_prefix = "🐼 ", -- Panda for parameter
                            hint_scheme = "String",
                            use_lspsaga = false, -- set to true if you want to use lspsaga popup
                            hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
                            max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                            -- to view the hiding contents
                            max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
                            handler_opts = {
                                border = "rounded" -- double, rounded, single, shadow, none
                            },
                            always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
                            auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
                            extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
                            zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
                            padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
                            transparency = nil, -- disabled by default, allow floating win transparent value 1~100
                            shadow_blend = 36, -- if you using shadow as border use this set the opacity
                            shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
                            timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
                            toggle_key = "<c-s>" -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
                        }
                    end
                }
            },
            run = function()
                local required_servers = {
                    -- "emmet_ls",
                    "yamlls",
                    "jsonls",
                    "html",
                    "vimls",
                    "bashls",
                    "diagnosticls",
                    "dockerls",
                    "sumneko_lua",
                    "tsserver",
                    "cssls",
                    "eslint"
                }
                require "nvim-lsp-installer.ui.status-win"().open()
                local lsp_installer_servers = require "nvim-lsp-installer.servers"
                for _, required_server in pairs(required_servers) do
                    local _, server = lsp_installer_servers.get_server(required_server)
                    if not server:is_installed() then
                        server:install()
                    end
                end
            end,
            config = function()
                local lsp_installer = require("nvim-lsp-installer")
                local nvim_command = vim.api.nvim_command

                function _G.show_documentation()
                    if (vim.lsp.buf.server_ready()) then
                        vim.lsp.buf.hover()
                    else
                        nvim_command("execute 'h! '.expand('<cword>')")
                    end
                end

                lsp_installer.on_server_ready(
                    function(server)
                        local on_attach = function(client, bufnr)
                            require "illuminate".on_attach(client)
                            local function buf_set_keymap(...)
                                vim.api.nvim_buf_set_keymap(bufnr, ...)
                            end
                            local function buf_set_option(...)
                                vim.api.nvim_buf_set_option(bufnr, ...)
                            end

                            --Enable completion triggered by <c-x><c-o>
                            buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

                            -- Mappings.
                            local opts = {noremap = true, silent = true}

                            -- See `:help vim.lsp.*` for documentation on any of the below functions
                            -- buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
                            buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
                            -- buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
                            buf_set_keymap("n", "K", ":call v:lua.show_documentation()<cr>", opts)
                            -- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
                            -- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
                            -- buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
                            -- buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
                            -- buf_set_keymap(
                            --     "n",
                            --     "<space>wl",
                            --     "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                            --     opts
                            -- )
                            -- buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
                            buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
                            -- buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
                            buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                            buf_set_keymap("n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
                            buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
                            buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
                            buf_set_keymap("n", "<leader><leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
                            buf_set_keymap("n", "<leader><leader>ee", "<cmd>EslintFixAll<CR>", opts)
                            -- buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)
                            -- buf_set_keymap("n", "<space>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
                        end

                        local settings = {}

                        if server.name == "sumneko_lua" then
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = {"vim", "packer_bootstrap"}
                                    }
                                }
                            }
                        end

                        server:setup(
                            {
                                on_attach = on_attach,
                                settings = settings
                            }
                        )

                        vim.cmd [[ do User LspAttachBuffers ]]
                    end
                )
            end
        }
        -- }}}

        -- {{{ Completion
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                "neovim/nvim-lspconfig",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "SirVer/ultisnips",
                "quangnguyen30192/cmp-nvim-ultisnips"
            },
            config = function()
                local cmp = require "cmp"
                local t = require "utils".t

                cmp.setup(
                    {
                        snippet = {
                            -- REQUIRED - you must specify a snippet engine
                            expand = function(args)
                                vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                            end
                        },
                        mapping = {
                            ["<down>"] = cmp.mapping(
                                cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
                                {"i"}
                            ),
                            ["<up>"] = cmp.mapping(
                                cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
                                {"i"}
                            ),
                            ["<c-n>"] = cmp.mapping(
                                {
                                    c = function()
                                        if cmp.visible() then
                                            cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                                        else
                                            vim.api.nvim_feedkeys(t("<Down>"), "n", true)
                                        end
                                    end,
                                    i = function(fallback)
                                        if cmp.visible() then
                                            cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                                        else
                                            fallback()
                                        end
                                    end
                                }
                            ),
                            ["<c-p>"] = cmp.mapping(
                                {
                                    c = function()
                                        if cmp.visible() then
                                            cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
                                        else
                                            vim.api.nvim_feedkeys(t("<Up>"), "n", true)
                                        end
                                    end,
                                    i = function(fallback)
                                        if cmp.visible() then
                                            cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
                                        else
                                            fallback()
                                        end
                                    end
                                }
                            ),
                            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
                            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
                            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
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
                            ["<C-e>"] = cmp.mapping(
                                {
                                    i = cmp.mapping.abort(),
                                    c = cmp.mapping.close()
                                }
                            ),
                            ["<Tab>"] = cmp.mapping(
                                {
                                    c = function()
                                        if cmp.visible() then
                                            cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
                                        else
                                            cmp.complete()
                                        end
                                    end,
                                    i = function(fallback)
                                        if cmp.visible() then
                                            cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
                                        elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                                            vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
                                        else
                                            fallback()
                                        end
                                    end,
                                    s = function(fallback)
                                        if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                                            vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
                                        else
                                            fallback()
                                        end
                                    end
                                }
                            ),
                            ["<S-Tab>"] = cmp.mapping(
                                {
                                    c = function()
                                        if cmp.visible() then
                                            cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
                                        else
                                            cmp.complete()
                                        end
                                    end,
                                    i = function(fallback)
                                        if cmp.visible() then
                                            cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
                                        elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                                            return vim.api.nvim_feedkeys(
                                                t("<Plug>(ultisnips_jump_backward)"),
                                                "m",
                                                true
                                            )
                                        else
                                            fallback()
                                        end
                                    end,
                                    s = function(fallback)
                                        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                                            return vim.api.nvim_feedkeys(
                                                t("<Plug>(ultisnips_jump_backward)"),
                                                "m",
                                                true
                                            )
                                        else
                                            fallback()
                                        end
                                    end
                                }
                            )
                        },
                        sources = cmp.config.sources(
                            {
                                {name = "nvim_lsp"},
                                {name = "ultisnips"}
                            },
                            {
                                {
                                    name = "buffer",
                                    get_bufnrs = function()
                                        return vim.api.nvim_list_bufs()
                                    end
                                }
                            }
                        )
                    }
                )

                -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline(
                    "/",
                    {
                        sources = {
                            {
                                name = "buffer",
                                get_bufnrs = function()
                                    return vim.api.nvim_list_bufs()
                                end
                            }
                        }
                    }
                )

                -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline(
                    ":",
                    {
                        sources = cmp.config.sources(
                            {
                                {name = "path"}
                            },
                            {
                                {name = "cmdline"}
                            }
                        )
                    }
                )
            end
        }

        use {
            "onsails/lspkind-nvim",
            config = function()
                local cmp = require("cmp")
                local lspkind = require("lspkind")
                cmp.setup {
                    formatting = {
                        format = lspkind.cmp_format()
                    }
                }
            end
        }

        use {
            "SirVer/ultisnips",
            requires = {{"honza/vim-snippets", rtp = "."}},
            config = function()
                vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
                vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
                vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
                vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
                vim.g.UltiSnipsRemoveSelectModeMappings = 0
            end
        }
        -- }}}

        -- {{{ Nvim tree
        use {
            "kyazdani42/nvim-tree.lua",
            setup = function()
                vim.g.nvim_tree_quit_on_open = 1 --0 by default, closes the tree when you open a file
                vim.g.nvim_tree_indent_markers = 0 --0 by default, this option shows indent markers when folders are open
                vim.gnvim_tree_respect_buf_cwd = 1 --0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
            end,
            config = function()
                local tree_cb = require("nvim-tree.config").nvim_tree_callback
                local utils = require("utils")
                local map = utils.map

                map("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")

                -- following options are the default
                require("nvim-tree").setup(
                    {
                        -- disables netrw completely
                        disable_netrw = true,
                        -- hijack netrw window on startup
                        hijack_netrw = true,
                        -- open the tree when running this setup function
                        open_on_setup = false,
                        -- will not open on setup if the filetype is in this list
                        ignore_ft_on_setup = {},
                        -- closes neovim automatically when the tree is the last **WINDOW** in the view
                        auto_close = false,
                        -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
                        open_on_tab = false,
                        -- hijacks new directory buffers when they are opened.
                        update_to_buf_dir = {
                            -- enable the feature
                            enable = true,
                            -- allow to open the tree if it was previously closed
                            auto_open = true
                        },
                        -- hijack the cursor in the tree to put it at the start of the filename
                        hijack_cursor = false,
                        -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
                        update_cwd = false,
                        -- show lsp diagnostics in the signcolumn
                        diagnostics = {
                            enable = false,
                            icons = {
                                hint = "",
                                info = "",
                                warning = "",
                                error = ""
                            }
                        },
                        -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
                        update_focused_file = {
                            -- enables the feature
                            enable = true,
                            -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
                            -- only relevant when `update_focused_file.enable` is true
                            update_cwd = true,
                            -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
                            -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
                            ignore_list = {}
                        },
                        -- configuration options for the system open command (`s` in the tree by default)
                        system_open = {
                            -- the command to run this, leaving nil should work in most cases
                            cmd = nil,
                            -- the command arguments as a list
                            args = {}
                        },
                        view = {
                            -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
                            width = 40,
                            -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
                            height = 30,
                            -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
                            side = "left",
                            -- if true the tree will resize itself after opening a file
                            auto_resize = false,
                            mappings = {
                                -- custom only false will merge the list with the default mappings
                                -- if true, it will only use your list to set the mappings
                                custom_only = false,
                                -- list of mappings to set on the tree manually
                                list = {
                                    {key = {"l"}, cb = tree_cb("edit")},
                                    {key = {"h"}, cb = tree_cb("close_node")}
                                }
                            }
                        }
                    }
                )
            end
        }
        -- }}}

        -- {{{ Tmux integration
        use {
            "christoomey/vim-tmux-navigator",
            config = function()
                vim.g.gtmux_navigator_disable_when_zoomed = 1
            end
        }
        use "tmux-plugins/vim-tmux-focus-events"
        -- }}}

        -- {{{ Git
        use "kdheepak/lazygit.nvim"
        use {
            "tpope/vim-fugitive",
            config = function()
                local nvim_create_augroups = require "utils".nvim_create_augroups

                -- Not gonna show shit messages when run git hook via husky
                vim.g.fugitive_pty = 0
                vim.g.lazygit_floating_window_winblend = 1
                vim.g.lazygit_floating_window_scaling_factor = 1

                nvim_create_augroups(
                    {
                        FugitiveAutoCleanBuffer = {
                            "BufReadPost fugitive://* set bufhidden=delete"
                        }
                    }
                )

                ----------------------------------------------------------------------
                --                       Custom git functions                       --
                ----------------------------------------------------------------------
                local map = require "utils".map
                function _G.GitCommit()
                    vim.cmd "!git add -A"
                    vim.cmd "vsplit term://git commit"
                end

                map("n", "<leader>gf", "<cmd>diffget //2 <cr> <cmd>w <cr> <cmd>diffupdate <cr>")
                map("n", "<leader>gj", "<cmd>diffget //3 <cr> <cmd>w <cr> <cmd>diffupdate <cr>")

                map("n", "<leader>lg", "<cmd>LazyGit<cr>")
                map("n", "<leader>gl", "<cmd>GcLog<cr>")
                map("n", "<leader>gs", "<cmd>G difftool --name-status<cr>")
                map("n", "<leader><leader>gs", "<cmd>G difftool<cr>")
                map("n", "<leader><leader>bl", "<cmd>G blame<cr>")
                map("n", "<leader>gc", ":call v:lua.GitCommit()<cr>ii")
                map("n", "<leader><leader>gc", ':G commit -n -m ""<left>', {silent = false})
                map("n", "<leader>ga", "<cmd>G add -A<cr>")
                map("n", "<leader>gw", '<cmd>G add -A <bar>G commit -n -m "WIP"<cr>')
                map(
                    "n",
                    "<leader>gp",
                    ":AsyncRun git push origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease<cr>",
                    {silent = false}
                )
            end
        }
        use {
            "lewis6991/gitsigns.nvim",
            requires = {
                "nvim-lua/plenary.nvim"
            },
            config = function()
                require("gitsigns").setup(
                    {
                        signs = {
                            add = {hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"},
                            change = {
                                hl = "GitSignsChange",
                                text = "│",
                                numhl = "GitSignsChangeNr",
                                linehl = "GitSignsChangeLn"
                            },
                            delete = {
                                hl = "GitSignsDelete",
                                text = "_",
                                numhl = "GitSignsDeleteNr",
                                linehl = "GitSignsDeleteLn"
                            },
                            topdelete = {
                                hl = "GitSignsDelete",
                                text = "‾",
                                numhl = "GitSignsDeleteNr",
                                linehl = "GitSignsDeleteLn"
                            },
                            changedelete = {
                                hl = "GitSignsChange",
                                text = "~",
                                numhl = "GitSignsChangeNr",
                                linehl = "GitSignsChangeLn"
                            }
                        },
                        numhl = false,
                        linehl = false,
                        keymaps = {
                            -- Default keymap options
                            noremap = true,
                            buffer = true,
                            ["n ]c"] = {
                                expr = true,
                                '&diff ? \']c\' : \'<cmd>lua require"gitsigns.actions".next_hunk()<CR>\''
                            },
                            ["n [c"] = {
                                expr = true,
                                '&diff ? \'[c\' : \'<cmd>lua require"gitsigns.actions".prev_hunk()<CR>\''
                            },
                            ["n <leader>ha"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
                            ["v <leader>ha"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
                            ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
                            ["n <leader>hd"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
                            ["v <leader>hd"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
                            ["n <leader>hD"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
                            ["n <leader>hc"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
                            ["n <leader>bl"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
                            -- Text objects
                            ["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
                            ["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
                        },
                        watch_index = {
                            interval = 1000,
                            follow_files = true
                        },
                        current_line_blame = false,
                        current_line_blame_delay = 1000,
                        current_line_blame_position = "eol",
                        sign_priority = 6,
                        update_debounce = 100,
                        status_formatter = nil, -- Use default
                        word_diff = true,
                        use_decoration_api = true,
                        use_internal_diff = true -- If luajit is present
                    }
                )
            end
        }
        -- }}}

        -- {{{ Theme
        use {
            "folke/tokyonight.nvim",
            setup = function()
                vim.g.tokyonight_style = "night"
                vim.g.tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer"}
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
                require("material").setup(
                    {
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
                        contrast_filetypes = {
                            "terminal",
                            "packer",
                            "qf"
                        },
                        disable = {
                            borders = true,
                            background = false,
                            term_colors = false,
                            eob_lines = false
                        }
                    }
                )
                require "utils".set_theme("material", "material-nvim")
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

        -- }}}

        -- {{{ Formatter
        use {
            "sbdchd/neoformat",
            config = function()
                local map = require "utils".map

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
                require "nvim-treesitter.configs".setup {
                    context_commentstring = {
                        enable = true
                    }
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
            "tpope/vim-surround",
            "tpope/vim-repeat",
            "tpope/vim-unimpaired",
            "tpope/vim-abolish",
            "tpope/vim-obsession",
            "tpope/vim-eunuch"
        }
        use {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}
        use "kevinhwang91/nvim-bqf"
        use "vim-scripts/BufOnly.vim"
        use "KabbAmine/vCoolor.vim"
        use "ThePrimeagen/vim-be-good"
        use "romainl/vim-cool"
        use "godlygeek/tabular"

        use {
            "sunjon/shade.nvim",
            config = function()
                require "shade".setup(
                    {
                        overlay_opacity = 50,
                        opacity_step = 1,
                        keys = {
                            brightness_up = "<C-Up>",
                            brightness_down = "<C-Down>",
                            toggle = "<Leader>ss"
                        }
                    }
                )
            end
        }

        use {
            "iamcco/markdown-preview.nvim",
            run = function()
                vim.fn["mkdp#util#install"](0)
            end,
            ft = {
                "markdown"
            },
            config = function()
                local map = require "utils".map
                map("n", "gm", ":MarkdownPreviewToggle<CR>")
            end
        }

        use {
            "airblade/vim-rooter",
            setup = function()
                vim.g.rooter_patterns = {".git", ".svn", "package.json", "!node_modules"}
            end
        }

        use {
            "jghauser/mkdir.nvim",
            config = function()
                require("mkdir")
            end
        }

        use {
            "szw/vim-maximizer",
            config = function()
                local map = require "utils".map
                map("n", "<leader>m", ":MaximizerToggle<cr>")
            end
        }

        use {
            "mbbill/undotree",
            config = function()
                local map = require "utils".map

                map("n", "<leader>u", ":UndotreeShow<cr>")
            end
        }

        use {
            "ThePrimeagen/harpoon",
            config = function()
                local map = require "utils".map

                require("harpoon").setup(
                    {
                        menu = {
                            width = 120,
                            height = 30
                        }
                    }
                )

                map("n", "ma", '<cmd>lua require("harpoon.mark").add_file()<cr>')
                map("n", "'1", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')
                map("n", "'2", '<cmd>lua require("harpoon.ui").nav_file(2)<cr>')
                map("n", "'3", '<cmd>lua require("harpoon.ui").nav_file(3)<cr>')
                map("n", "'4", '<cmd>lua require("harpoon.ui").nav_file(4)<cr>')
                map("n", "'5", '<cmd>lua require("harpoon.ui").nav_file(5)<cr>')
                map("n", "mq", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')
            end
        }

        use {
            "skywind3000/asyncrun.vim",
            config = function()
                local nvim_create_augroups = require "utils".nvim_create_augroups
                nvim_create_augroups(
                    {
                        AutoOpenQuickFixAsyncRun = {
                            "User AsyncRunStop :copen 20"
                        }
                    }
                )
            end
        }

        use {
            "ryanoasis/vim-devicons",
            {
                "kyazdani42/nvim-web-devicons",
                config = function()
                    require("nvim-web-devicons").setup(
                        {
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
                        }
                    )
                end
            }
        }

        use {
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("colorizer").setup()
            end
        }

        use {
            "dm1try/golden_size",
            config = function()
                local function ignore_by_buftype(types)
                    local buftype = vim.api.nvim_buf_get_option(0, "buftype")
                    for _, type in pairs(types) do
                        if type == buftype then
                            return 1
                        end
                    end
                end
                local golden_size = require("golden_size")
                -- set the callbacks, preserve the defaults
                golden_size.set_ignore_callbacks(
                    {
                        {ignore_by_buftype, {"terminal", "quickfix", "nofile"}},
                        {golden_size.ignore_float_windows}, -- default one, ignore float windows
                        {golden_size.ignore_by_window_flag} -- default one, ignore windows with w:ignore_gold_size=1
                    }
                )
            end
        }
        -- }}}

        -- {{{ Debugger
        use {
            "mfussenegger/nvim-dap",
            setup = function()
                vim.cmd [[  
  au FileType dap-repl lua require('dap.ext.autocompl').attach()
  ]]
            end,
            config = function()
                local map = require "utils".map

                map("n", "<localleader>bb", ":lua require'dap'.toggle_breakpoint()<cr>")
                map(
                    "n",
                    "<localleader>bc",
                    ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>"
                )
                map(
                    "n",
                    "<localleader>bl",
                    ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>"
                )
                map("n", "<localleader>BB", ":lua require'dap'.list_breakpoints()<cr>:copen<cr>")
                map("n", "<localleader>c", ":lua require'dap'.continue()<cr>")
                map("n", "`o", ":lua require'dap'.step_over()<cr>")
                map("n", "`i", ":lua require'dap'.step_into()<cr>")
                map("n", "`u", ":lua require'dap'.step_out()<cr>")
                map("n", "`j", ":lua require'dap'.down()<cr>")
                map("n", "`k", ":lua require'dap'.up()<cr>")
                map("n", "<localleader>b", ":lua require'dap'.step_back()<cr>")
                map("n", "<localleader>t", ":lua require'dap'.terminate()<cr>")
                map("n", "<localleader>di", ":lua require'dap'.terminate()<cr>")
                map("n", "<localleader>re", ":lua require'dap'.repl.toggle()<cr>")
                map("n", "<localleader>rc", ":lua require'dap'.run_to_cursor()<cr>")
                map("n", "<localleader>s", ":lua require('dap.ui.widgets').hover()<cr>")
                map("n", "<localleader>da", ":Telescope dap commands<cr>")

                -- View the current scopes in floating window
                map(
                    "n",
                    "<localleader>ds",
                    ":lua local widgets = require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<cr>"
                )
                -- View the current frames floating window
                map(
                    "n",
                    "<localleader>df",
                    ":lua local widgets = require('dap.ui.widgets');widgets.centered_float(widgets.frames)<cr>"
                )
            end
        }
        use {
            "Pocco81/DAPInstall.nvim",
            config = function()
                local dap_install = require("dap-install")
                local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

                dap_install.setup(
                    {
                        installation_path = vim.fn.stdpath("data") .. "/dapinstall/"
                    }
                )

                for _, debugger in ipairs(dbg_list) do
                    dap_install.config(debugger)
                end
            end
        }

        use {
            "nvim-telescope/telescope-dap.nvim",
            config = function()
                require("telescope").load_extension("dap")
            end
        }
        -- }}}

        -- {{{ Packer end

        -- {{{ Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all useins
        if packer_bootstrap then
            require("packer").sync()
        end
        -- }}}
    end
)

-- }}}
-- }}}1

-- {{{1 Settings
-- {{{2
local o = vim.opt
local wo = vim.wo
local bo = vim.bo

vim.g.vimsyn_embed = "lPr"

o.splitbelow = true
o.splitright = true
o.wildmenu = true
o.termguicolors = true
o.hidden = true
o.ignorecase = true
o.incsearch = true
o.hlsearch = true
o.expandtab = true
o.number = true
o.relativenumber = true
o.cursorline = true
o.exrc = true
o.secure = true
o.clipboard = "unnamed"
o.updatetime = 50
o.inccommand = "nosplit"
o.mouse = "a"
o.scrolloff = 8
o.completeopt = {"menuone", "noinsert", "noselect"}
o.shortmess:append({c = true})
o.smartindent = true
o.shiftwidth = 2
o.softtabstop = 2
o.tabstop = 2
o.undofile = true
o.undodir = vim.fn.expand("~/.vim/undo")
o.cmdheight = 2
o.listchars = "tab:▹ ,trail:·"
o.list = true
o.wrapscan = false

wo.signcolumn = "yes"

bo.syntax = "enable"
bo.swapfile = false

nvim_create_augroups {
    OpenHelpOnRightMostWindow = {
        "BufEnter *.txt if &buftype == 'help' | wincmd L | endif"
    },
    SetFileType = {
        "BufNewFile,BufRead *.zsh setlocal filetype=zsh",
        "BufNewFile,BufRead *.todo setlocal filetype=todo",
        "BufNewFile,BufRead *.conf setlocal filetype=conf"
    },
    SetFoldMethod = {
        "FileType zsh,vim,conf setlocal foldmethod=marker",
        "BufRead init.lua setlocal foldmethod=marker"
    },
    CursorLineOnlyInActiveWindow = {
        "VimEnter,WinEnter,BufWinEnter * setlocal cursorline",
        "WinLeave * setlocal nocursorline"
    },
    AutoSetFoldLevelInitLua = {
        "BufNewFile,BufRead init.lua setlocal foldlevel=1"
    }
}
-- }}}2
-- }}}1

-- {{{1 Mappings
-- {{{2
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map("n", "n", "nzt", {noremap = false})
map("n", "N", "Nzt", {noremap = false})
map("n", "*", "*zt", {noremap = false})
map("n", "#", "#zt", {noremap = false})

map("n", "Y", "y$")

-- Duplicate everything selected
map("v", "D", "y'>p")

-- Do search with selected text in VISUAL mode
map("v", "*", 'y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>', {noremap = false})

map("n", "<leader>cl", "<cmd>ccl<cr><cmd>lcl<cr><cmd>echo ''<cr><cmd>noh<cr>")
map("n", "<leader><leader>r", "<cmd>so %<cr><cmd>PackerCompile<cr>")
map("n", "<leader><leader>R", "<cmd>so ~/.config/nvim/init.lua<cr><cmd>PackerCompile<cr>")

map("n", "<c-w><c-e>", "<c-w>=")

-- Moving around in command mode
map("c", "<c-h>", "<left>", {silent = false})
map("c", "<c-j>", "<down>", {silent = false})
map("c", "<c-k>", "<up>", {silent = false})
map("c", "<c-l>", "<right>", {silent = false})

map("i", "<c-h>", "<left>", {silent = false})
map("i", "<c-j>", "<down>", {silent = false})
map("i", "<c-k>", "<up>", {silent = false})
map("i", "<c-l>", "<right>", {silent = false})

map("n", "<leader>e", "<cmd>b #<cr>")
map("n", "<leader><leader>e", "<cmd>e<cr>")
map("n", "<leader>bo", "<cmd>BufOnly<cr>")
map("n", "<leader>td", ":vsp .todo<cr>")

-- Create file at same folder with vsplit/split
map("n", "<leader>vf", ":vsp %:h/", {silent = false})
map("n", "<leader>sf", ":sp %:h/", {silent = false})
map("n", "<leader><leader>ef", ":e %:h/", {silent = false})

map("n", "<leader><leader>h", 'yi" :!npm home <c-r>"<cr>')
map("n", "<leader><leader>H", 'yi\' :!npm home <c-r>"<cr>')
map("n", "<leader><leader>oe", "<cmd>!open -a textedit %<cr>")
map("n", "<leader><leader>oc", "<cmd>!open -a visual studio code %<cr>")
map("n", "<leader><leader>og", "<cmd>!open -a google chrome %<cr>")

-- Windows
map("n", "<c-w>v", "<c-w>v <c-w>l", {noremap = true})
map("n", "<c-w><c-v>", "<c-w>v <c-w>l", {noremap = true})
map("n", "<c-w>s", "<c-w>s <c-w>j", {noremap = true})
map("n", "<c-w><c-s>", "<c-w>s <c-w>j", {noremap = true})
map("n", "<c-w><c-w>", "<c-w>q", {noremap = true})
map("n", "<leader><leader>m", ":vert res 120<cr>", {noremap = true})
map("n", "<leader><leader>M", ":GoldenRatioToggle<cr>", {noremap = true})

map("n", "<leader>rr", '"rciw')
map("n", "<leader>cf", ":CopyFileName<cr>")
map("n", "<leader>fl", ":set foldlevel=", {silent = false})

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

function _G.openCurrentFolder()
    nvim_command("!open %:p:h")
end

function _G.googleJavaFormat()
    nvim_command("!google-java-format --replace % ")
end

nvim_command("command! CopyFileName :call v:lua.copyFileName()")
nvim_command("command! Cfn :call v:lua.copyFileName()")

nvim_command("command! CopyFolderName :call v:lua.copyFolderName()")
nvim_command("command! Cdn :call v:lua.copyFolderName()")

nvim_command("command! CopyAbsouPathPath :call v:lua.copyAbsouPathPath()")
nvim_command("command! CopyRelativePath :call v:lua.copyFileRelativePath()")
nvim_command("command! CopyFolderPath :call v:lua.copyFileRelativeFolderPath()")

nvim_command("command! GoogleJavaFormat :call v:lua.googleJavaFormat()")

nvim_command("command! OpenFolder :call v:lua.openCurrentFolder()")
nvim_command("command! Od :call v:lua.openCurrentFolder()")
-- }}}2
-- }}}1
