-- Setup Lazy 
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)
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
vim.keymap.set('n', 'gh', ':call VSCodeNotify(\'references-view.findReferences\')<CR>')

-- Formatting
vim.keymap.set('n', '<Leader>fm', ':call VSCodeNotify(\'editor.action.formatDocument\')<CR>')

-- General Settings