return {
  -- Set up null-ls to check spelling
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "mason.nvim", "davidmh/cspell.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local cspell = require("cspell")
      local ok, none_ls = pcall(require, "null-ls")
      if not ok then
        return
      end

      local spell_dir = vim.fn.stdpath("config")

      local config = {
        find_json = function()
          return spell_dir .. "/cspell.json"
        end,
      }

      local sources = {

        cspell.diagnostics.with({
          -- Set the severity to HINT for unknown words
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity["HINT"]
          end,
          config = config,
        }),

        cspell.code_actions.with({
          config = config,
        }),
      }

      -- Define the debounce value
      local debounce_value = 200

      return {
        sources = sources,
        debounce = debounce_value,
        debug = true,
      }
    end,
  },
}
