return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        ["*"] = { "typos" },
        html = { "djlint" },
        python = { "ruff" },
      },
    },
  },
}
