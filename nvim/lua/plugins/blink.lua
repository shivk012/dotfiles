return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      ghost_text = { enabled = false },
    },
    sources = {
      per_filetype = {
        -- optionally inherit from the `default` sources
        -- lua = { inherit_defaults = true, 'lsp', 'path' },
        -- vim = { inherit_defaults = true, 'cmdline' },
        python = { "lazydev", "lsp", "path" },
      },
    },
  },
}
