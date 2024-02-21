return {
  "brenoprata10/nvim-highlight-colors",
  event = "BufReadPost",
  enable = false,
  config = function()
    require("nvim-highlight-colors").setup()
  end,
}
