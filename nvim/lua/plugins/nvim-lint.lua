return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff" },
        ["*"] = { "cspell", "codespell" },
      },
    },
  },
}