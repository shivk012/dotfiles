return {
  "nvim-lualine/lualine.nvim",
  opts = {
    always_divide_middle = false,
    sections = {
      lualine_c = {
        {
          "filename",
          path = 1,
        },
      },
    },
  },
}
