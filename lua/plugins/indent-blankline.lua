require("util").lazy_file()

return {
  "lukas-reineke/indent-blankline.nvim",
  event = "LazyFile",
  main = "ibl",
  config = function()
    require("config.indent-blankline")
  end,
}
