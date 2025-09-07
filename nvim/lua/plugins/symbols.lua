return {
  "bassamsdata/namu.nvim",
  opts = {
    global = {},
    namu_symbols = { -- Specific Module options
      options = {},
    },
  },
  keys = {
    { "<leader>ss", ":Namu symbols<cr>", desc = "Jump to LSP symbol" },
    { "<leader>sS", ":Namu watchtower<cr>", desc = "Jump to LSP symbol in buffers" },
  },
}
