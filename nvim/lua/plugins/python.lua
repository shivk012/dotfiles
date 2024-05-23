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
}
