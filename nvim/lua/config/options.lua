-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_python_lsp = "basedpyright"
-- vim.lsp.enable("djlsp")
-- vim.g.lazyvim_python_lsp = "pyrefly"
-- vim.g.lazyvim_python_lsp = "pylsp"
-- vim.lsp.enable("pylsp")

-- vim.lsp.set_log_level("debug")

-- vim.lsp.config("ty", {
--   cmd = { "ty", "server" },
--   filetypes = { "python" },
--   root_markers = { "ty.toml", "pyproject.toml", ".git" },
-- })

-- vim.lsp.config("pyrefly", {
--   cmd = { "pyrefly", "lsp" },
--   filetypes = { "python" },
--   settings = {},
--   on_exit = function(code, _, _)
--     vim.notify("Closing Pyrefly LSP exited with code: " .. code, vim.log.levels.INFO)
--   end,
-- })
-- vim.env.PYTHONPATH = "/Users/shivam.kumar/projects/kraken-core/src:/Users/shivam.kumar/.virtualenvs/kraken-core/lib/python3.12/site-packages"
