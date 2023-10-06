return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPost",
  main = "ibl",
  config = function()
    require("config.indent-blankline")
  end,
}
