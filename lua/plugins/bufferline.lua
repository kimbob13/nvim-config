return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      themable = true,
      separator_style = "slant",
    },
  },
}
