return {
  {
    "nvim-neotest/neotest",
    opts = {
      discovery = {
        enabled = false,
      },
      output = {
        open_on_run = true,
      },
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false, django = true },
          args = { "-p tools.pytest.django_config_auto_selection.plugin", "-s" },
          runner = "pytest",
          pytest_discovery_instances = false,
        }),
      },
    },
  },
  -- {
  --   "vim-test/vim-test",
  --   keys = {
  --     { "<leader>tt", ":TestNearest<cr>", desc = "Run nearest test" },
  --     { "<leader>tf", ":TestFile<cr>", desc = "Run tests in file" },
  --     { "<leader>tl", ":TestLast<cr>", desc = "Run last test" },
  --     { "<leader>tv", ":TestVisit<cr>", desc = "Visit last test file" },
  --   },
  --   config = function()
  --     vim.g["test#strategy"] = "neovim"
  --     vim.g["test#python#runner"] = "pytest"
  --     vim.g["test#python#pytest#options"] = "-p tools.pytest.django_config_auto_selection.plugin -s"
  --   end,
  -- },
}
