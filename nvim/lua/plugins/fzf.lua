return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader>/", LazyVim.pick("live_grep_glob"), desc = "Grep (Root Dir)" },
    { "<leader>sg", LazyVim.pick("live_grep_glob"), desc = "Grep (Root Dir)" },
  },
  lsp = {
    async_or_timeout = true,
  },
}
