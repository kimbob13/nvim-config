require("util").lazy_file()

return {
  "lewis6991/gitsigns.nvim",
  event = "LazyFile",
  config = function()
    require("gitsigns").setup()
  end,
}
