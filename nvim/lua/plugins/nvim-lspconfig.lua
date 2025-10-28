local function grep_python_def()
  if vim.bo.filetype ~= "python" then
    vim.lsp.buf.definition()
    return
  end

  local current_word = vim.fn.expand("<cword>")
  if current_word == "" then
    vim.notify("No word under cursor", vim.log.levels.WARN)
    return
  end

  local pattern = "(def "
    .. current_word
    .. "\\()|(class "
    .. current_word
    .. "\\:)|(class "
    .. current_word
    .. "\\()|(related_name=.*"
    .. current_word
    .. ")"

  Snacks.picker.grep({
    search = pattern,
    regex = true,
    live = false,
    ft = "py",
    glob = { "!**/migrations/**" },
    auto_confirm = true,
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "<leader>ss", false },
            { "<leader>sS", false },
            {
              "<leader>G",
              function()
                grep_python_def()
              end,
              desc = "Grep python def",
            },
          },
        },
        ["ty"] = {
          settings = {
            ty = {
              experimental = {
                autoImport = true,
                rename = true,
              },
            },
          },
        },
        ["pylsp"] = {
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
