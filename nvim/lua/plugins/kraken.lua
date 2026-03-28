return {
  "octoenergy/kraken.nvim",
  opts = {},
  keys = {
    { "<leader>kk", "<cmd>KLocateTests<cr>", desc = "Kraken locate tests" },
    { "<leader>kp", "<cmd>KCreateSlackPrLink<cr>", desc = "Kraken copy PR link" },
  },
  cond = string.find((os.getenv("HOSTNAME") or ""):lower(), "kraken") ~= nil,
}
