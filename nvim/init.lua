vim.g.mapleader = ';' -- Make sure to set `mapleader` before lazy so your mappings are correct

-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode then
    require("config.vscode")
else
    require("config.lazy")
end
