return {
  {
    "ranelpadon/python-copy-reference.vim",
    keys = {
      { "<leader>ccd", ":PythonCopyReferenceDotted<CR>", desc = "Copy dotted reference" },
      { "<leader>ccp", ":PythonCopyReferencePytest<CR>", desc = "Copy pytest reference" },
      { "<leader>cci", ":PythonCopyReferenceImport<CR>", desc = "Copy import reference" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { mode = "topline", max_lines = 5 },
  },
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp", -- Use this branch for the new version
    cmd = "VenvSelect",
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = false,
        },
      },
    },
    --  Call config for python files and load the cached venv automatically
    ft = "python",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },
  -- {
  --   "python-rope/ropevim", -- Rope refactoring commands for Vim
  --   ft = "python", -- only load for Python files
  --   config = function()
  --     -- enable ropevim (optional; it's on by default)
  --     vim.g.ropevim_enable = 1
  --
  --     -- example keymaps:
  --     local map = vim.api.nvim_set_keymap
  --     map("n", "<leader>rv", "<Cmd>RopeExtractVariable<CR>", { silent = true })
  --     map("n", "<leader>rm", "<Cmd>RopeExtractMethod<CR>", { silent = true })
  --     map("n", "<leader>ri", "<Cmd>RopeInline<CR>", { silent = true })
  --     map("n", "<leader>rr", "<Cmd>RopeRename<CR>", { silent = true })
  --   end,
  -- },
}
