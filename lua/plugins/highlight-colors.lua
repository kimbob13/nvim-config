return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
  enable = false,
  config = function()
    require("nvim-highlight-colors").setup()
  end,
}
