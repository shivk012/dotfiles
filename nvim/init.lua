-- Setup Lazy 
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ';' -- Make sure to set `mapleader` before lazy so your mappings are correct

-- VSCode settings
if vim.g.vscode then

    -- Plugins
    require('lazy').setup(
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {"html","python"},
                sync_install = false,
                highlight = {
                    enable = false,
                    additional_vim_regex_highlighting = false
                },
                indent = {
                    enable = true
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>", -- set to `false` to disable one of the mappings
                        node_incremental = "<CR>",
                        scope_incremental = "grc",
                        node_decremental = "<BS>",
                    }
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner'
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = false, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer'
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer'
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer'
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer'
                        }
                    }
                }
            })
        end
    }    
)

    -- Commenting
    vim.api.nvim_set_keymap('x', 'gc', '<Plug>VSCodeCommentary', {})
    vim.api.nvim_set_keymap('n', 'gc', '<Plug>VSCodeCommentary', {})
    vim.api.nvim_set_keymap('o', 'gc', '<Plug>VSCodeCommentary', {})
    vim.api.nvim_set_keymap('n', 'gcc', '<Plug>VSCodeCommentaryLine', {})

    -- Telescope equivalent
    vim.keymap.set('n', '<Leader>ff', ':call VSCodeNotify(\'find-it-faster.findFiles\')<CR>')
    vim.keymap.set('n', '<Leader>fg', ':call VSCodeNotify(\'find-it-faster.findWithinFiles\')<CR>')

    -- Definitions
    vim.keymap.set('n', '<Leader>gh', ':call VSCodeNotify(\'reference-view.findReferences\')<CR>')

    -- Formatting
    vim.keymap.set('n', '<Leader>fm', ':call VSCodeNotify(\'editor.action.formatDocument\')<CR>')

    -- General Settings
else
    local set = vim.opt
    set.cursorline = true
    set.expandtab = true
    set.number = true
    set.relativenumber = true
    set.title = true
    set.signcolumn = 'yes'

    -- Treat jj as escape
    vim.keymap.set('i', 'jj', '<ESC>', {
        noremap = true
    })

    -- Tabs
    vim.keymap.set('n', '<S-Tab>', 'gT', {
        noremap = true
    })
    vim.keymap.set('n', '<Tab>', 'gt', {
        noremap = true
    })
    vim.keymap.set('n', '<S-t>', ':tabnew<CR>', {
        silent = true,
        noremap = true
    })

    -- COQ for completions
    vim.g.coq_settings = {
        auto_start = 'shut-up'
    }

    -- Plugins
    require('lazy').setup({ 
    -- Theme
    'oxfist/night-owl.nvim', 
    -- Git
    'lewis6991/gitsigns.nvim', 
    'tpope/vim-fugitive',
    -- Mason
    'williamboman/mason.nvim', 
    -- LSP
    'williamboman/mason-lspconfig.nvim', 
    'neovim/nvim-lspconfig', {
        'ms-jpq/coq_nvim',
        branch = 'coq'
    },
    -- Commenting'
    {
        'numToStr/Comment.nvim',
        lazy = false
    }, 
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {"lua", "html", "rust", "javascript", "python"},
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                indent = {
                    enable = true
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>", -- set to `false` to disable one of the mappings
                        node_incremental = "<CR>",
                        scope_incremental = "grc",
                        node_decremental = "<BS>",
                    }
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner'
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer'
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer'
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer'
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer'
                        }
                    }
                }
            })
        end
    }, 
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {'nvim-lua/plenary.nvim'}
    }, 
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }})

    -- Theme
    vim.cmd.colorscheme("night-owl")

    -- Telescope binds
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

    -- Setups
    require('coq')

    require('Comment').setup()

    require('gitsigns').setup()

    require('telescope').setup {}
    require('telescope').load_extension('fzf')

    require('mason').setup()

    require('mason-lspconfig').setup {
        ensure_installed = {'pyright', 'rust_analyzer'}
    }

    -- Python
    local config = require('lspconfig.configs')
    require('lspconfig').pyright.setup {
        on_attach = config.on_attach,
        capabilities = config.capabilities,
        filetypes = {'python'}
    }

    -- Rust
    require('lspconfig').rust_analyzer.setup {}

    -- LSP Settings
    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = {
                buffer = ev.buf
            }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({'n', 'v'}, '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<space>f', function()
                vim.lsp.buf.format {
                    async = true
                }
            end, opts)
        end
    })
end
