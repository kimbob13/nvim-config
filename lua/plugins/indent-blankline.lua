return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  main = "ibl",
  config = function()
    require("config.indent-blankline")
  end,
}
