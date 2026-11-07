return {
  { "tpope/vim-fugitive" },
  { "sindrets/diffview.nvim" },
  {
    "CoreyKaylor/diffbandit.nvim",
    config = function()
      require("diffbandit").setup()
    end,
  },
}
