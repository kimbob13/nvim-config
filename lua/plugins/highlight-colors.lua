require("util").lazy_file()

return {
  "brenoprata10/nvim-highlight-colors",
  event = "LazyFile",
  enable = false,
  config = function()
    require("nvim-highlight-colors").setup()
  end,
}
