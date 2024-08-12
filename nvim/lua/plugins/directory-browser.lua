return {
  "simonmclean/triptych.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "nvim-tree/nvim-web-devicons", -- optional
  },
  keys = {
    {
      "<leader>-",
      "<cmd>Triptych<CR>",
      desc = "Toggle Triptych",
      silent = true,
    },
  },
  config = function()
    require("triptych").setup()
  end,
}
