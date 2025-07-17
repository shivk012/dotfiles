return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          enabled = false,
          settings = {
            pylsp = {
              plugins = {
                jedi = { enabled = true, extra_paths = { "/Users/shivam.kumar/projects/kraken-core/src" } },
                pydocstyle = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                mccabe = { enabled = false },
                noy_pyls = { enabled = true },
                pylama = { enabled = false },
                flake8 = { enabled = false },
                pyls_isort = { enabled = false },
                black = { enabled = false },
                pylsp_mypy = { enabled = false },
                ruff = { enabled = false },
                rope = { enabled = true },
              },
            },
          },
          flags = {
            debounce_text_changes = 200,
          },
        },
      },
    },
  },
}
